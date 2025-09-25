public without sharing class CaseService {
    public static void closeCases(Set<Id> caseIds, String closeReason) {
        if (caseIds == null || caseIds.isEmpty() || String.isBlank(closeReason)) return;
        List<Case> casesToUpdate = [
            SELECT Id, Status, Reason
            FROM Case
            WHERE Id IN :caseIds
            FOR UPDATE
        ];
        for (Case c : casesToUpdate) {
            c.Status = 'Closed';
            c.Reason = closeReason;
        }
        if (!casesToUpdate.isEmpty()) update casesToUpdate;
    }
}