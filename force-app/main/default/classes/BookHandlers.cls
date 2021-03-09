public class BookHandlers {
    
    public static void preventDuplicate(List<Book__c> newBooks){
        Integer flag =0,flag_one=1;
        Set<String> setName = new Set<String>();
        for(Book__c b : newBooks){
            if(setName.contains(b.ISBN__c)){
                system.debug(flag);
               b.ISBN__c.addError('Duplicate found in the list');
                
            }
            else{
                system.debug(flag_one);
                 setName.add(b.ISBN__c);
            }
           
        }
        
        if(setName.size() > 0 ){
            List<Book__c> books = [select ISBN__c  from Book__c where ISBN__c in :setName ];
            
            Map<String ,Book__c> book = new Map<String,Book__c>();
            
            for(Book__c b: books){
                book.put(b.ISBN__c ,b);
            }
            
            for(Book__c b : newBooks){
                if(book.containsKey(b.ISBN__c)){
                    
                    b.addError(b.ISBN__c+' Book ISBN already Exist ');
                }
            }
            
        }
           
    }

}