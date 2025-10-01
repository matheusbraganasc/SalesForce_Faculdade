public interface studentSelector {
    Boolean olharStatusInativo (String status);
    schema.SObjectType getSObjectType();
    List<schema.SObjectField> getSObjectFieldList();
    List<Aluno__c> selectById(List<Id> idset);
}