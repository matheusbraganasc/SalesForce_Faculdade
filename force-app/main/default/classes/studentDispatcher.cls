public with sharing class studentDispatcher implements triggerDispatcher {
    


    public void selectContext() {

        TriggerHandler InstanceTriggerHandler;

        if (Trigger.isBefore) {
            if (Trigger.isInsert){
                InstanceTriggerHandler = (TriggerHandler) di_Injector.Org.getInstance('StudentBeforeInsertTrigger');
            }

            if (Trigger.isUpdate){
               
            }

            if (Trigger.isDelete){
                
            }
        }

        if (Trigger.isAfter) {
            if (Trigger.isInsert){

            }

            if (Trigger.isUpdate){

            }

            if (Trigger.isDelete){

            }

            if (Trigger.isUndelete){

            } 
        }

        if (InstanceTriggerHandler != null){
            return;
        }

        InstanceTriggerHandler.execute();
    }
}