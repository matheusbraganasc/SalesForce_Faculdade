trigger studentyTrigger on Aluno__c (
    before insert,
    before update,
    before delete,
    after insert,
    after update,
    after delete,
    after undelete

    ) {
        /*Não inserir se a matricula for inativa*/
        switch on Trigger.operationType  {
            when BEFORE_INSERT {
                For (Aluno__c aluno : Trigger.new)
                {
                   if (String.valueOf(aluno.Status__c) == 'Inativa') {
                       aluno.Status__c.addError('Não é possível inserir um aluno com status inativo.');
                   }
                }
            }
            when else {
                Return;
            }
        }
}