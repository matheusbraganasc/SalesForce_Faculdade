public with sharing class StudentAfterUpdateTrigger implements TriggerHandler {
    public void execute() {
        List<Aluno__c> alunosQueAlteraramStatus = new List<Aluno__c>();

        for (Integer i = 0; i < Trigger.new.size(); i++) {
            Aluno__c novo = (Aluno__c) Trigger.new[i];
            Aluno__c antigo = (Aluno__c) Trigger.old[i];


            if (novo.Status__c != antigo.Status__c || novo.Curso__c != antigo.Curso__c) {
                alunosQueAlteraramStatus.add(novo);
                alunosQueAlteraramStatus.add(antigo);
            }
        }

        if (!alunosQueAlteraramStatus.isEmpty()) {
            List<Aluno__c> novos = new List<Aluno__c>();
            List<Aluno__c> antigos = new List<Aluno__c>();
            for (Integer i = 0; i < alunosQueAlteraramStatus.size(); i += 2) {
                Aluno__c n = alunosQueAlteraramStatus[i];
                Aluno__c a = alunosQueAlteraramStatus[i+1];
                novos.add(n);
                antigos.add(a);
            }
            this.instancestudentService.atualizarQtdAlunosPorCurso(alunosQueAlteraramStatus);
            this.instancestudentService.notificarProfessorAlunoInativo(novos, antigos);
        }
    }

    private studentService instancestudentService {
        get {
            if (this.instancestudentService == null) {
                try {
                    this.instancestudentService = (studentService) di_Injector.Org.getInstance('studentServiceIMPL');
                } catch (Exception e) {
                    this.instancestudentService = new studentServiceIMPL();
                }
            }
            return instancestudentService;
        }
        set;
    }
}
