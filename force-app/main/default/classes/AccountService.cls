public with sharing class AccountService {
    public class AccountInput {
        @InvocableVariable(required=true)
        public String nome;
    }
    
    @InvocableMethod(label='Criar Conta')
    public static List<Id> criarConta(List<AccountInput> inputs) {
        List<Id> results = new List<Id>();
        List<Account> contas = new List<Account>();
        
        for (AccountInput input : inputs) {
            contas.add(new Account(Name = input.nome));
        }
        
        insert contas;
        
        for (Account c : contas) {
            results.add(c.Id);
        }
        
        return results;
    }
}