public with sharing class studentSelectorIMPL extends fflib_SObjectSelector implements studentSelector {

    public Boolean olharStatusInativo (String status){
        
        List<Aluno__c> alunos = [SELECT Id, Name, Status__c FROM Aluno__c WHERE Status__c =: status LIMIT 1];
        return alunos.isEmpty();

    }

    public schema.SObjectType getSObjectType (){
        return Aluno__c.sObjectType;
    }

    public List<schema.SObjectField> getSObjectFieldList(){
        return new List<schema.SObjectField>{
            Aluno__c.Status__c,
            Aluno__c.Name,
            Aluno__c.Curso__c
        };
    }

    public List<Aluno__c> selectById(List<Id> idset){
        return (List<Aluno__c>) selectSObjectsById(idSet);
    }
}