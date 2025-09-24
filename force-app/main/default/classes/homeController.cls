public with sharing class homeController {
    
    @AuraEnabled(cacheable=true)
    public static List<Professor__c> getProfessores2() {
        return [SELECT Id, Name FROM Professor__c ORDER BY Name];
    }

    @AuraEnabled(cacheable=true)
    public static List<Curso__c> getCursosDeProfessor(Id professorId) {
        if (String.isBlank(professorId)) {
            return new List<Curso__c>();
        }
        return [SELECT Id, Name FROM Curso__c WHERE Professor__c = :professorId ORDER BY Name];
    }

    @AuraEnabled(cacheable=true)
    public static List<Aluno__c> getAlunosDeCurso(Id cursoId) {
        if (String.isBlank(cursoId)) {
            return new List<Aluno__c>();
        }
        return [SELECT Id, Name FROM Aluno__c WHERE Curso__c = :cursoId ORDER BY Name];
    }
}