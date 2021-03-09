trigger countTrigger on Contact (after insert, after update, after delete, after undelete) {

    Boolean isInsert;

    if(Trigger.isInsert || Trigger.isUndelete) {

        if(Trigger.isAfter) {

            isInsert = true;
            CountClass.doCount(Trigger.new,isInsert);
        }
    }

    if(Trigger.isDelete) {

        if(Trigger.isAfter) {

            isInsert = false;
            CountClass.doCount(Trigger.old,isInsert);
        }
    }

    if(Trigger.isUpdate) {

        if(Trigger.isAfter) {
            CountClass.doUpdate(Trigger.newMap,Trigger.oldMap);
        }
    }

}