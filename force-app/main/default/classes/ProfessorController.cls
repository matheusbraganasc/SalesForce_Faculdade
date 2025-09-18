public with sharing class ProfessorController {
    
    @AuraEnabled
    public static Id criarProfessor(String nomeProfessor) {
        Professor__c prof = new Professor__c(Name = nomeProfessor);
        insert prof;
        return prof.Id;
    }

    @AuraEnabled
    public static Id criarCurso(String nomeCurso) {
        Curso__c curso = new Curso__c(Name = nomeCurso);
        insert curso;
        return curso.Id;
    }

    @AuraEnabled
    public static void relacionarCursoProfessor(Id professorId, Id cursoId) {
        if (professorId != null && cursoId != null) {
            Professor__c prof = [SELECT Id FROM Professor__c WHERE Id = :professorId LIMIT 1];
            prof.Curso__c = cursoId;
            update prof;
        }
    }

    @AuraEnabled(cacheable=true)
    public static List<Professor__c> getProfessores() {
        return [SELECT Id, Name, curso__c, curso__r.Name FROM Professor__c ORDER BY Name];
    }

    @AuraEnabled(cacheable=true)
    public static List<Curso__c> getCursos() {
        return [SELECT Id, Name FROM Curso__c ORDER BY Name];
    }
}