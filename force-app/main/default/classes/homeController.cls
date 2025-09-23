public with sharing class homeController {

    @AuraEnabled(cacheable=true)
    public static List<Curso__c> getCursosEAlunos(Id professorId) {
        if (professorId == null) {
            return new List<Curso__c>();
        }

        return [
            SELECT Id, Name, (SELECT Id, Name, Status__c FROM Students__r ORDER BY Name) FROM Curso__c ORDER BY Name
        ];
    }
}