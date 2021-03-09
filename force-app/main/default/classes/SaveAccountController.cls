public class SaveAccountController {
    
    @AuraEnabled
    public static Account  saveAccounts(Account acc) {
        insert acc;
        return acc;
    }
}
