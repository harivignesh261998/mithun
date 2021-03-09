public with sharing  class NewCountriesClass {
    
        public static void assignOwner(List<Lead> leadList){
            
            Set<String> countries = new Set<String>();
            
            for(Lead l :leadList){
                countries.add(l.country_name__c);
            }
            
            
            List<Country_Name__mdt> countriesContinent = new List<Country_Name__mdt>(
                [Select Label,Continent_Name__c from Country_Name__mdt Where Label IN :countries]
            );
            
            Map<String,String> countriesContinentMap = new Map<String,String>();
            
            for(Country_Name__mdt l :countriesContinent){
                countriesContinentMap.put(l.Label,l.Continent_Name__c);
            }
            
            List<Profile__mdt> Pro = new List<Profile__mdt>(
               [Select Label,Continent__c from Profile__mdt Where Continent__c In :countriesContinentMap.values()]
            );
            
            Map<String,String> proMap = new Map<String,String>();
            for(Profile__mdt l : Pro){
                proMap.put(l.Continent__c,l.Label);
            }
            
            List<User> userList = new List<User>(
                [Select Id,Name,UserName from User Where UserName In :proMap.values()]
            );
            
            Map<String,Id> newMaps = new Map<String,Id>();
            
            for(User l : userList){
                newMaps.put(l.userName,l.Id);
            }
            
            for(Lead l : leadList){
                if(countriesContinentMap.keySet().contains(l.country_name__c)){
                    /*String continent = countriesContinentMap.get(l.Country_Name__c);
                    String userName = proMap.get(continent);
                    String userId = newMaps.get(userName);
                    l.OwnerId = userId;*/
                    l.OwnerId = newMaps.get(proMAp.get(countriesContinentMap.get(l.Country_Name__c)));
                }
                else{
                    l.addError(l.country_name__c+' is not avilable for lead');
                }
            }
 
        }
}