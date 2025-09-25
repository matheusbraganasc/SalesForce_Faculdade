public class ContactUtility {
    public static void viewContacts(){
    	List<Contact> listOfContacts = [SELECT FirstName, LastName FROM Contact];  
    }
}