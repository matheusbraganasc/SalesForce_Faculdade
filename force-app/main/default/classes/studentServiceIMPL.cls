public with sharing class studentServiceIMPL implements studentService {
    
    public void validarMatricula(list<Aluno__c> Aluno){

        studentSelector selector = (studentSelector) di_Injector.Org.getInstance(studentSelectorIMPL.class);
        boolean result;

        for (Aluno__c a : Aluno) {

            result = selector.olharStatusInativo(a.Status__c);

            if (String.valueOf (a.Status__c) == 'Inativa') {
                a.Status__c.addError('Não é possível inserir um aluno com status inativo.');
            }
        }

    }

    public void atualizarQtdAlunosPorCurso(List<Aluno__c> alunos) {
    Set<Id> cursoIds = new Set<Id>();

    for (Aluno__c aluno : alunos) {
        if (aluno.Curso__c != null) {
            cursoIds.add(aluno.Curso__c);
        }
    }

    if (cursoIds.isEmpty()) return;

    studentSelector selector = (studentSelector) di_Injector.Org.getInstance(studentSelectorIMPL.class);
    Map<Id, Integer> contagem = selector.contarAlunosAtivosPorCurso(cursoIds);

    List<Curso__c> cursosParaAtualizar = new List<Curso__c>();

    for (Id cursoId : cursoIds) {
        Integer qtd = contagem.containsKey(cursoId) ? contagem.get(cursoId) : 0;
        cursosParaAtualizar.add(new Curso__c(
            Id = cursoId,
            Qtd_Alunos__c = qtd
        ));
    }

    update cursosParaAtualizar;
}
    public void notificarProfessorAlunoInativo(List<Aluno__c> novos, List<Aluno__c> antigos) {
        // Agrupa alunos que passaram de Ativa -> Inativa por Curso
        Map<Id, List<Aluno__c>> alunosPorCurso = new Map<Id, List<Aluno__c>>();

        for (Integer i = 0; i < novos.size(); i++) {
            Aluno__c novo = novos[i];
            Aluno__c antigo = antigos[i];
            if (antigo != null && novo != null && String.valueOf(antigo.Status__c) == 'Ativa' && String.valueOf(novo.Status__c) == 'Inativa') {
                if (novo.Curso__c != null) {
                    if (!alunosPorCurso.containsKey(novo.Curso__c)) alunosPorCurso.put(novo.Curso__c, new List<Aluno__c>());
                    alunosPorCurso.get(novo.Curso__c).add(novo);
                }
            }
        }

        if (alunosPorCurso.isEmpty()) return;

        // Buscar cursos e professor (usar Prof_Email__c como campo de e-mail do professor)
        Set<Id> cursoIds = alunosPorCurso.keySet();
        List<Curso__c> cursos = [SELECT Id, Name, Professor__c, Professor__r.Name, Professor__r.Prof_Email__c FROM Curso__c WHERE Id IN :cursoIds];

        // Agrupar por professor
        Map<Id, List<Aluno__c>> alunosPorProfessor = new Map<Id, List<Aluno__c>>();
        Map<Id, String> emailPorProfessor = new Map<Id, String>();
        Map<Id, String> nomeProfessor = new Map<Id, String>();

        for (Curso__c c : cursos) {
            Id profId = c.Professor__c;
            if (profId == null) continue;
            String email = null;
            if (c.Professor__r != null) email = (String) c.Professor__r.get('Prof_Email__c');
            if (String.isBlank(email)) continue;

            if (!alunosPorProfessor.containsKey(profId)) alunosPorProfessor.put(profId, new List<Aluno__c>());
            alunosPorProfessor.get(profId).addAll(alunosPorCurso.get(c.Id));
            emailPorProfessor.put(profId, email);
            nomeProfessor.put(profId, c.Professor__r != null ? c.Professor__r.Name : null);
        }

        if (alunosPorProfessor.isEmpty()) return;

        List<Messaging.SingleEmailMessage> emails = new List<Messaging.SingleEmailMessage>();
        for (Id profId : alunosPorProfessor.keySet()) {
            String toAddress = emailPorProfessor.get(profId);
            if (String.isBlank(toAddress)) continue;

            List<Aluno__c> lista = alunosPorProfessor.get(profId);
            String body = 'Olá ' + (nomeProfessor.get(profId) != null ? nomeProfessor.get(profId) : '') + ',\n\n';
            body += 'Os seguintes alunos ficaram com matrícula INATIVA:\n\n';
            for (Aluno__c a : lista) {
                body += '- ' + a.Name + ' (Id: ' + a.Id + ')\n';
            }
            body += '\nAtenciosamente,\nEquipe';

            Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
            mail.setToAddresses(new String[] { toAddress });
            mail.setSubject('Alunos com matrícula inativa');
            mail.setPlainTextBody(body);
            emails.add(mail);
        }

        if (!emails.isEmpty()) {
            try {
                Messaging.sendEmail(emails);
            } catch (Exception e) {
                System.debug('Erro ao enviar emails para professores: ' + e.getMessage());
            }
        }
    }

}