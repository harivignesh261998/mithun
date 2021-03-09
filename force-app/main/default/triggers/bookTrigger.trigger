trigger bookTrigger on Book__c (before insert,before update) {
    
    if(Trigger.isInsert){
        if(Trigger.isBefore){
            BookHandlerClass.preventDuplicateInsert(Trigger.new);
        }
    }
    
    if(Trigger.isUpdate){
        if(Trigger.isBefore){
            
            //BookHandlerClass.preventDuplicateUpdate(Trigger.newMap);
            
        }
    }

}