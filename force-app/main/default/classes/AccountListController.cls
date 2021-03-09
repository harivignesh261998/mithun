public class AccountListController {
    
        @AuraEnabled
        public static List <Account> fetchAccts() {
            return [ SELECT Id, Name, Industry, Type FROM Account];
        }

        @AuraEnabled
        public static Id deleteAccount(Id Id) {
            System.debug(Id);
            List<Account> deleteList = new List<Account>(
                [Select Id,Name from Account where Id = :Id]
            );
            delete deleteList;
            System.debug(deleteList);
            return Id;
        }
}