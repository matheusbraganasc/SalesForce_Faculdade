trigger studentTrigger on Aluno__c (before insert, before update, before delete, after insert, after update, after delete, after undelete) {
    
    triggerDispatcher instanceDispatcher = (triggerDispatcher) di_Injector.org.getInstance(studentDispatcher.class);
    if (instanceDispatcher != null) {
        instanceDispatcher.selectContext();
    }
}