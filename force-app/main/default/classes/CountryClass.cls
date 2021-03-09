public class CountryClass {
    
    public static void assignOwner(List<Lead> leadList){
        Set<String> s = new Set<String>();
        for(Lead l : leadList){
            s.add(l.country_Name__c);   
        }
        
        List<Country_Name__mdt> cL = new List<Country_Name__mdt>(
            [Select Label,Continent_Name__c from Country_Name__mdt Where Label In :s]
        );
        /*set<String> a = new Set<String>();
        for(Country_Name__mdt k :cL){
            a.add(k.Label);
        }*/
        
        Map<String,String> p = new Map<String,string>();
        for(Country_Name__mdt e : cL){
            p.put(e.Label,e.Continent_Name__c);
            
        }

        if(s.size() == cL.size()){
           /* Set<String> c = new set<String>();
            for(Country_Name__mdt v : cL){
                c.add(v.Continent_Name__c);
            }*/
            
            Set<Profile__mdt> qwerty = new Set<Profile__mdt>([Select Label from Profile__mdt where Continent__c IN :p.values()]);
            Set<String> q = new Set<String>();
            for(Profile__mdt op : qwerty){
                q.add(op.Label);
            }
            
            Map<Id,Profile> profileIds = new Map<Id,Profile>(
                [SELECT Id,UserLicenseId FROM Profile where UserLicenseId In 
                 (SELECT Id FROM UserLicense where Name In :q)]
            );
			
			List<user> standardProfileUsers = [select id from user where profileId in:profileIds.Keyset()];
            
          	leadList[0].ownerId = standardProfileUsers[0].Id;

        }
        else{
            
            for(String o :s){
                if(p.keySet().contains(o)){
                    system.debug(o);   
                }
                else{
                   leadList[0].addError(o+' is not in the list so you cannot create lead for the country '+o);
                }
                
               
            }

        }
  
    }

}