global class InsertAccount {

      @AuraEnabled
      public static void saveAccount(List<Account> accountList) {

        System.debug(accountList);
        

    }
    

}
