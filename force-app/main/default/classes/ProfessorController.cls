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
        insert curso;
        return curso.Id;
    }

    @AuraEnabled
    public static void relacionarCursoProfessor(Id professorId, Id cursoId) {
        if (professorId != null && cursoId != null) {
            Curso__c curso = [SELECT Id, Professor__c FROM Curso__c WHERE Id = :cursoId LIMIT 1];
            curso.Professor__c = professorId;
            update curso;
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

    @AuraEnabled(cacheable=true)
    public static List<Curso__c> getCursosPorProfessor(Id professorId) {
        return [
            SELECT Id, Name, Professor__c FROM Curso__c WHERE Professor__c = 'a09fj000003AhTRAA0' ORDER BY Name
        ];
    }
    @AuraEnabled(cacheable=true)
    public static List<Curso__c> getCursosEAlunos(Id professorId) {
        return [
            SELECT Id, Name, (SELECT Id, Name, Status__c FROM Students__r ORDER BY Name) FROM Curso__c WHERE Professor__c = 'a09fj000003AhTRAA0' ORDER BY Name
        ];
    }
}