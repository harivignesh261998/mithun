public class BookHandlerClass {
    
    public static void preventDuplicateInsert(List<Book__c> newBooks){
      
        Set<String> UniqueISBN = new Set<String>();
        
        for(Book__c b : newBooks){
            
            if(UniqueISBN.contains(b.ISBN__c)){

                 b.addError('Remove the duplicate to insert');

            }
            
            else{
                
                UniqueISBN.add(b.ISBN__c);

            } 
            
        }
        
        List<Book__c> books = new List<Book__c>(
            [
                Select Id,ISBN__c from Book__c where ISBN__c IN :UniqueISBN Limit 1
            ]
        );
        
        for(Book__c bookNew : newBooks ){
            for(Book__c book : books){
                if(bookNew.ISBN__C == book.ISBN__c){
                    bookNew.addError('Duplicate found');
                    
                }
            }
        }
       
    }
    
    public static void preventDuplicateUpdate(Map<Id,Book__c> bookList){
        Set<String> uniqueISBN = new Set<String>();
        
        for(Book__c b :bookList.values()){

            if(uniqueISBN.contains(b.ISBN__c)){
                b.addError('Remove the duplicate to insert');   
            }
            else{
                uniqueISBN.add(b.ISBN__C);
                
            }

        }
        
      List<Book__c> books = new List<Book__c>(
            [
                Select Id,ISBN__c from Book__c where ISBN__c IN :uniqueISBN LIMIT 1
            ]
        );
        
        if(books.size() > 0){
            
            for(Book__c b : bookList.values()){
                b.addError('Duplicate found :>');
            }
          
        }
    
        
    }
}

/*1.Cheking the list for duplication
2.If Duplicate found Throw Error else Stored in the set
3.Query the books that has already present in the database filterd with ISBN__c
4.If books.Size() > 0 throw error else insert into database
*/