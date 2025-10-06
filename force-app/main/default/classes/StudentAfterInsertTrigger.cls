public with sharing class StudentAfterInsertTrigger implements TriggerHandler {
    public void execute() {
        this.instancestudentService.atualizarQtdAlunosPorCurso(Trigger.new);
    }

    public void professorPadrãoEmCursoSemProfessor(List<Curso__c> cursos) {
        this.instancestudentService.professorPadrãoEmCursoSemProfessor(cursos);
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
