public with sharing class StudentBeforeInsertTrigger implements TriggerHandler {
  
      public void execute(){
            this.instancestudentService.validarMatricula(Trigger.new);
      }


      private studentService instancestudentService{

            get{
                  if(this.instancestudentService == null) {
                        this.instancestudentService = (studentService) di_Injector.Org.getInstance('studentServiceIMPL');
                  }
                  return instancestudentService;
            }
            set;
      }
}