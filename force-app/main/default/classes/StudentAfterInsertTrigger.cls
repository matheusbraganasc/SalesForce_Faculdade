public with sharing class StudentAfterInsertTrigger implements TriggerHandler {
    public void execute() {
        this.instancestudentService.atualizarQtdAlunosPorCurso(Trigger.new);
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
