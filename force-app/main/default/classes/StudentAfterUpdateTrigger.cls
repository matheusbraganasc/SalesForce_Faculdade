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
            this.instancestudentService.atualizarQtdAlunosPorCurso(alunosQueAlteraramStatus);
        }
    }

    private studentService instancestudentService {
        get {
            if (this.instancestudentService == null) {
                this.instancestudentService = (studentService) di_Injector.Org.getInstance('studentServiceIMPL');
            }
            return instancestudentService;
        }
        set;
    }
}
