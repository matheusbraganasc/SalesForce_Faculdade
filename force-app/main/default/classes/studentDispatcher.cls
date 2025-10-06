public with sharing class studentDispatcher implements triggerDispatcher {

    public void selectContext() {
        TriggerHandler InstanceTriggerHandler;

        if (Trigger.isBefore) {
            if (Trigger.isInsert){
                InstanceTriggerHandler = (TriggerHandler) di_Injector.Org.getInstance('StudentBeforeInsertTrigger');
            }
        }
        

        if (Trigger.isAfter) {
            if (Trigger.isInsert){
                InstanceTriggerHandler = (TriggerHandler) di_Injector.Org.getInstance('StudentAfterInsertTrigger');
            }

            if (Trigger.isUpdate){
                InstanceTriggerHandler = (TriggerHandler) di_Injector.Org.getInstance('StudentAfterUpdateTrigger');
            }

            if (Trigger.isDelete){
                InstanceTriggerHandler = (TriggerHandler) di_Injector.Org.getInstance('StudentAfterDeleteTrigger');
            }
        }

        if (InstanceTriggerHandler != null){
            InstanceTriggerHandler.execute();
        }
    }
}
