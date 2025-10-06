public with sharing class StudentAfterDeleteTrigger implements TriggerHandler {
    public void execute() {
        this.instancestudentService.atualizarQtdAlunosPorCurso(Trigger.old);
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
