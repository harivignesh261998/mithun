public class CountriesClass {
    
    public static void preventDuplicateLead(List<Lead> leadList){
        
        Set<String> countries = new Set<String>();
        
        for(Lead l : leadList){
            countries.add(l.Country_Name__c);
        }
        
        List<Country_Name__mdt> countriesWithContinent = new List<Country_Name__mdt>(
            [Select Label,Continent_Name__c from Country_Name__mdt where Label IN :countries]
        );
        
        Map<String,String> countriesWithContinentMap = new Map<String,string>();
        
        for(Country_Name__mdt l : countriesWithContinent){
            countriesWithContinentMap.put(l.Label,l.Continent_Name__c);
        }
 
        List<Profile__mdt> pro = new List<Profile__mdt>(
            [Select Label,Continent__c from Profile__mdt where Continent__c In :countriesWithContinentMap.values()]
        );
        
        Map<String,String> profileWithContinent = new Map<String,String>();
        Map<String,String> profileWithContinentTwo = new Map<String,String>();
        for(Profile__mdt l : pro){
            profileWithContinent.put(l.Continent__c,l.Label);
            profileWithContinentTwo.put(l.label,l.Continent__c);
        }
   

        List<User> usersWithSalesforceLicense = [
           	Select Id, Name, Profile.UserLicense.Name From User 
            Where Profile.UserLicense.Name In :profileWithContinent.values()
        ];
        
        Map<String,Id> lp = new Map<String,Id>();
        
        for(User l : usersWithSalesforceLicense){
            
            lp.put(profileWithContinentTwo.get(l.Profile.UserLicense.Name),l.Id);
        }
        
        

       for(Lead l :leadList){
            if(countriesWithContinentMap.keySet().contains(l.country_name__c)){
                
                l.OwnerId = lp.get(countriesWithContinentMap.get(l.Country_Name__c));  
            }
            else{
                
                l.addError(l.Country_Name__c+ ' is not avialable for lead');
            }
            
        }
        system.debug(leadList.size());
    }
}