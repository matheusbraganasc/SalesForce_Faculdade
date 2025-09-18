public with sharing class ProfessorController {
    
    @AuraEnabled
    public static Id criarProfessor(String nomeProfessor) {
        Professor__c prof = new Professor__c(Name = nomeProfessor);
        insert prof;
        return prof.Id;
    }

    @AuraEnabled
    public static Id criarCurso(String nomeCurso, Id professorId) {
        Curso__c curso = new Curso__c(
            Name = nomeCurso,
            Professor__c = professorId
        );
        insert curso;
        return curso.Id;
    }

    @AuraEnabled
    public static Id criarProfessorComCurso(String nomeProfessor, String nomeCurso) {
        Professor__c prof = new Professor__c(Name = nomeProfessor);
        insert prof;

        Curso__c curso = new Curso__c(
            Name = nomeCurso,
            Professor__c = prof.Id
        );
        insert curso;

        return prof.Id;
    }

    @AuraEnabled(cacheable=true)
    public static List<Professor__c> a() {
        return [SELECT Id, Name, (SELECT Id, Name FROM Curso__r) FROM Professor__c ORDER BY Name];
    }
}