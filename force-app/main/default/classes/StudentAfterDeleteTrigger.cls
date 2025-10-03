public with sharing class StudentAfterDeleteTrigger implements TriggerHandler {
    public void execute() {
        this.instancestudentService.atualizarQtdAlunosPorCurso(Trigger.old);
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
