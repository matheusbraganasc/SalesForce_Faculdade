public with sharing class studentSelectorIMPL extends fflib_SObjectSelector implements studentSelector {

    public Boolean olharStatusInativo (String status){
        
        List<Aluno__c> alunos = [SELECT Id, Name, Status__c FROM Aluno__c WHERE Status__c =: status];
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

    public Map<Id, Integer> contarAlunosAtivosPorCurso(Set<Id> cursoIds) {
    Map<Id, Integer> resultado = new Map<Id, Integer>();

    List<AggregateResult> resultados = [
        SELECT Curso__c, COUNT(Id) total
        FROM Aluno__c
        WHERE Curso__c IN :cursoIds AND Status__c = 'Ativa'
        GROUP BY Curso__c
    ];

    for (AggregateResult ar : resultados) {
        Id cursoId = (Id) ar.get('Curso__c');
        Integer total = (Integer) ar.get('total');
        resultado.put(cursoId, total);
        System.debug('Curso: ' + cursoId + ' | Total Alunos Ativos: ' + total);
    }

    return resultado;
}



    public List<Aluno__c> selectById(List<Id> idset){
        return [SELECT Id, Name, Status__c, Curso__c FROM Aluno__c WHERE Id IN :idset];
    }
}