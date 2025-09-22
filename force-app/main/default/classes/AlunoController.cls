public with sharing class AlunoController {
    
    @AuraEnabled
    public static Id salvarAluno(String nome, String statusValue, Id cursoId, Decimal registroNumero) {
        try {
            Aluno__c novoAluno = new Aluno__c();
            novoAluno.Name = nome;
            novoAluno.Status__c = statusValue;
            novoAluno.curso__c = cursoId;
            novoAluno.registros__c = registroNumero;
            insert novoAluno;
            return novoAluno.Id;
        } catch (Exception e) {
            throw new AuraHandledException('Erro ao salvar Aluno: ' + e.getMessage());
        }
    }

    @AuraEnabled(cacheable=true)
    public static List<Aluno__c> getAlunos(String statusMatricula) {
        String query = 'SELECT Id, Name, Status__c, curso__r.Name, registros__c FROM Aluno__c';
        
        if (statusMatricula != null && statusMatricula != 'Todos') {
            query += ' WHERE Status__c = :statusMatricula';
        }
        
        query += ' ORDER BY CreatedDate DESC';
        
        return Database.query(query);
    }
}