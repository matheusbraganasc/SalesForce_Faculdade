public with sharing class studentServiceIMPL implements studentService {
    
    public void validarMatricula(list<Aluno__c> Aluno){

        studentSelector selector = (studentSelector) di_Injector.Org.getInstance(studentSelectorIMPL.class);
        boolean result;

        for (Aluno__c a : Aluno) {

            result = selector.olharStatusInativo(a.Status__c);

            if (String.valueOf (a.Status__c) == 'Inativa') {
                a.Status__c.addError('Aluno Inativo não pode ser matriculado');
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

}