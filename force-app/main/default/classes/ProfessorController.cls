public with sharing class ProfessorController {
    
    @AuraEnabled
    public static Id criarProfessor(String nomeProfessor) {
        Professor__c prof = new Professor__c(Name = nomeProfessor);
        insert prof;
        return prof.Id;
    }

    @AuraEnabled
    public static Id criarCurso(String nomeCurso, String professorCurso) {
        Curso__c curso = new Curso__c(Name = nomeCurso);
        curso.Professor__c = professorCurso;
        insert curso;
        return curso.Id;
    }

    @AuraEnabled
    public static void relacionarCursoProfessor(Id professorId, Id cursoId) {
        if (professorId != null && cursoId != null) {
            Curso__c Curs = [SELECT Id FROM Curso__c WHERE Id = :cursoId LIMIT 1];
            Curs.Professor__c = professorId;
            update Curs;
        }
    }

    @AuraEnabled(cacheable=true)
    public static List<Professor__c> getProfessores() {
        return [SELECT Id, Name, (SELECT Name FROM Cursos__r) FROM Professor__c ORDER BY Name];
    }

    @AuraEnabled(cacheable=true)
    public static List<Curso__c> getCursos() {
        return [SELECT Id, Name, Professor__c, Professor__r.Name FROM Curso__c ORDER BY Name];
    }
}