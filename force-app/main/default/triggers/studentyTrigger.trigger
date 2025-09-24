trigger studentyTrigger on Aluno__c (
    before insert,
    before insert,
    before update,
    before delete,
    after insert,
    after update,
    after delete,
    after undelete

    ) {

        switch on Trigger.operationType  {
            when BEFORE_INSERT {
                For (Aluno__c a : Trigger.new)
                {
                    
                }
            }
            when else {
                
            }
        }
}