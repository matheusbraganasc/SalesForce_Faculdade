trigger studentTrigger on Aluno__c (before insert, before update, before delete, after insert, after update, after delete, after undelete) {
        
    triggerDispatcher instanceDispatcher - (triggerDispatcher) di.inject.org.getInstance(studentDispatcher);
}