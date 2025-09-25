public with sharing class CheckCaseStatusBot {
    
    public class CaseOutput {
        @InvocableVariable(required=true)
        public String CaseStatus;
    }
    
    public class CaseInput {
    	@InvocableVariable(required=true)
        public String CaseNumber;
    }
    
    @InvocableMethod(label='Checar status de Caso')
    public static List<CaseOutput> getCaseStatus(List<CaseInput> caseInputs) {
        Set<String> caseNumbers = new Set<String>();
	
    for (CaseInput caseInp : caseInputs) {
        caseNumbers.add(caseInp.CaseNumber);
    }
    
    List<case> cases =
        [SELECT Subject, id, CaseNumber, Status FROM case where CaseNumber in :caseNumbers];
    
    Map<String, String> mapNameStatus = new Map<String, String>();
    if (cases.size() > 0) {
        for (case vCase : cases) {
            mapNameStatus.put(vCase.CaseNumber, vCase.Status);
        }
    }
    
    List<CaseOutput> caseOutputs = new List<CaseOutput>();
    for (CaseInput caseInput : caseInputs) {
        CaseOutput caseOutput = new CaseOutput();
        
        if (mapNameStatus.containsKey(caseInput.CaseNumber)) {
            caseOutput.CaseStatus = mapNameStatus.get(caseInput.CaseNumber);
        } else {
            caseOutput.CaseStatus = 'Caso não existente';
        }
        caseOutputs.add(caseOutput);
    	}
        
        return caseOutputs;
    }
}