public class AccountHandler{
    public static void insertAccount(Integer value){
        Integer counter = 1;
    list<Account> addAccounts = new list<Account>();
    while(counter <= value){
        System.debug('Valor da conta antes de adicionar' + counter);
        Account store = new Account();
        store.Name = 'Acme Inc N' + counter;
        store.AccountNumber = 'A00000n' + counter;
        addAccounts.add(store);
        System.debug(addAccounts);
        counter = counter + 1;
        System.debug('Valor da conta depois de adicionar' + counter);
        }
        System.debug('Size of Accounts List: ' + addAccounts.size() );
        System.debug('Elements in Accounts List: ' + addAccounts);
        
        insert addAccounts;
    }
}