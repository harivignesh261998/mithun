public class Books {
    public static void preventDuplicate(List<Book__c> bookList) {

        Set<String> isbnBook = new Set<String>();

        for(Book__c l : bookList){
            if(isbnBook.contains(l.ISBN__C)){
                l.addError('Duplicate Found in the list');
            }
            else{
                isbnBook.add(l.ISBN__C);
            }
        }

        List<Book__c> boo = new List<Book__c>(
            [Select Id,ISBN__C from Book__c Where ISBN__C IN :isbnBook]
        );

        Map<String,String> booMap = new Map<String,String>();

        for(Book__c l :boo){
            booMap.put(l.ISBN__C,l.Id);
        }

        for(String l :isbnBook){
            if(booMap.keySet().contains(l)){
                bookList[0].addError('duplcate Found');
            }
            else{
                system.debug('inserted');
            }
        }



    }
}
