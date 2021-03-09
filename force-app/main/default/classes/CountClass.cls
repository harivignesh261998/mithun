public class CountClass {

    public static void doCount(List<Contact> afterList,Boolean isInsert) {

        Map<Id,Integer> indiaMap = new Map<Id,Integer>();
        Map<Id,Integer> americaMap = new Map<Id,Integer>();
        
        for(Contact contacts : afterList) {

            if(contacts.MailingCountry == 'India') {

                if(!indiaMap.containsKey(contacts.AccountId)){
                    indiaMap.put(contacts.AccountId,0);
                }
                indiaMap.put(contacts.AccountId,indiaMap.get(contacts.AccountId)+1);
            }
            else if(contacts.MailingCountry == 'USA') {

                if(!americaMap.containsKey(contacts.AccountId)) {
                    americaMap.put(contacts.AccountId,0);
                }

                americaMap.put(contacts.AccountId,americaMap.get(contacts.AccountId)+1);
            }
        }

        System.debug(indiaMap);
        System.debug(americaMap);
        
        List<Account> accountList =[
            Select Id,Contact_Count__c,India_Count__c,America_Count__c from Account Where Id In :indiaMap.keySet() OR Id In :americaMap.keySet()];

        for(Account accounts :accountList) {

            if(isInsert) {

                accounts.Contact_Count__c += 1;
                if(indiaMap.containsKey(accounts.Id)) {
                    accounts.India_Count__c += indiaMap.get(accounts.Id);
                }
            
                if(americaMap.containsKey(accounts.Id)) {
                    accounts.America_Count__c += americaMap.get(accounts.Id);
                }
            }
            else {
                accounts.Contact_Count__c -= 1;

                if(indiaMap.containsKey(accounts.Id)) {
                    accounts.India_Count__c -= indiaMap.get(accounts.Id);
                }

                if(americaMap.containsKey(accounts.Id)) {
                    accounts.America_Count__c -= americaMap.get(accounts.Id);
                }

            }
        }
        
        update accountList;
    }
        
    public static void doUpdate(Map<Id,Contact> newList,Map<Id,Contact> oldList){

        Map<Id,Integer> indiaMapOld = new Map<Id,Integer>();
        Map<Id,Integer> indiaMapNew = new Map<Id,Integer>();
        Map<Id,Integer> americaMapOld = new Map<Id,Integer>();
        Map<Id,Integer> americaMapNew = new Map<Id,Integer>();

        for(Contact contacts : oldList.values()) {

            if(contacts.MailingCountry == 'India') {

                if(!indiaMapOld.containsKey(contacts.AccountId)) {
                    indiaMapOld.put(contacts.AccountId,0);
                }
            
                indiaMapOld.put(contacts.AccountId,indiaMapOld.get(contacts.AccountId)+1);
            
                if(contacts.AccountId != newList.get(contacts.Id).AccountId) {
            
                    if(contacts.MailingCountry == newList.get(contacts.Id).MailingCountry) {
            
                        if(!indiaMapNew.containsKey(newList.get(contacts.Id).AccountId)) {
                            indiaMapNew.put(newList.get(contacts.Id).AccountId,0);
                        }
            
                        indiaMapNew.put(newList.get(contacts.Id).AccountId,indiaMapNew.get(newList.get(contacts.Id).AccountId)+1);
                    }
                    else{
            
                        if(!americaMapNew.containsKey(newList.get(contacts.Id).AccountId)) {
                            americaMapNew.put(newList.get(contacts.Id).AccountId,0);
                        }
            
                        americaMapNew.put(newList.get(contacts.Id).AccountId,americaMapNew.get(newList.get(contacts.Id).AccountId)+1);
                    }
                }
                else {
            
                    if(contacts.MailingCountry != newList.get(contacts.Id).MailingCountry) {
            
                        if(!americaMapNew.containsKey(newList.get(contacts.Id).AccountId)) {
                            americaMapNew.put(newList.get(contacts.Id).AccountId,0);
                        }
            
                        americaMapNew.put(newList.get(contacts.Id).AccountId,americaMapNew.get(newList.get(contacts.Id).AccountId)+1);
                    }
                    else {
            
                        if(!indiaMapNew.containsKey(newList.get(contacts.Id).AccountId)) {
                            indiaMapNew.put(newList.get(contacts.Id).AccountId,0);
                        }
            
                        indiaMapNew.put(newList.get(contacts.Id).AccountId,indiaMapNew.get(newList.get(contacts.Id).AccountId)+1);
                    }
            
                }
            }
            
            if(contacts.MailingCountry == 'USA') {
            
                if(!americaMapOld.containsKey(contacts.AccountId)) {
                    americaMapOld.put(contacts.AccountId,0);
                }
            
                americaMapOld.put(contacts.AccountId,americaMapOld.get(contacts.AccountId)+1);
            
                if(contacts.AccountId != newList.get(contacts.Id).AccountId) {
            
                    if(contacts.MailingCountry == newList.get(contacts.Id).MailingCountry) {
                        
                        if(!americaMapNew.containsKey(newList.get(contacts.Id).AccountId)) {
                            americaMapNew.put(newList.get(contacts.Id).AccountId,0);
                        }
            
                        americaMapNew.put(newList.get(contacts.Id).AccountId,americaMapNew.get(newList.get(contacts.Id).AccountId)+1);
                    }
                    else {
            
                        if(!indiaMapNew.containsKey(newList.get(contacts.Id).AccountId)) {
                            indiaMapNew.put(newList.get(contacts.Id).AccountId,0);
                        }
            
                        indiaMapNew.put(newList.get(contacts.Id).AccountId,indiaMapNew.get(newList.get(contacts.Id).AccountId)+1);
                    }   
                }
                else {
            
                    if(contacts.MailingCountry != newList.get(contacts.Id).MailingCountry) {
            
                        if(!indiaMapNew.containsKey(newList.get(contacts.Id).AccountId)) {
                            indiaMapNew.put(newList.get(contacts.Id).AccountId,0);
                        }
            
                        indiaMapNew.put(newList.get(contacts.Id).AccountId,indiaMapNew.get(newList.get(contacts.Id).AccountId)+1);
                    }
                    else {
            
                        if(!americaMapNew.containsKey(newList.get(contacts.Id).AccountId)) {
                            americaMapNew.put(newList.get(contacts.Id).AccountId,0);
                        }
            
                        americaMapNew.put(newList.get(contacts.Id).AccountId,americaMapNew.get(newList.get(contacts.Id).AccountId)+1);
                    }
                }
            }
        }

        List<Account> account = new List<Account>(
            [Select Id,Contact_Count__c,India_Count__c,America_Count__c from Account Where Id In 
            :indiaMapOld.keySet() OR Id In :indiaMapNew.keySet() OR Id In :americaMapOld.keySet() OR 
            Id In :americaMapNew.keySet()]
        );

        for(Account accounts : account) {

            if(indiaMapOld.containsKey(accounts.Id)) {
                
                accounts.Contact_Count__c = accounts.Contact_Count__c - 1;
                accounts.India_Count__c = accounts.India_Count__c - indiaMapOld.get(accounts.Id);
            }

            if(indiaMapNew.containsKey(accounts.Id)) {

                accounts.Contact_Count__c = accounts.Contact_Count__c + 1;
                accounts.India_Count__c = accounts.India_Count__c + indiaMapNew.get(accounts.Id);
            }

            if(americaMapOld.containsKey(accounts.Id)) {
                
                accounts.Contact_Count__c = accounts.Contact_Count__c - 1;
                accounts.America_Count__c = accounts.America_Count__c - americaMapOld.get(accounts.Id);
            }

            if(americaMapNew.containsKey(accounts.Id)) {
                
                accounts.Contact_Count__c = accounts.Contact_Count__c + 1;
                accounts.America_Count__c = accounts.America_Count__c + americaMapNew.get(accounts.Id);
            }
        }

        update account;
    }
    
}