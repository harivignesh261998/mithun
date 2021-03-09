trigger CountryTrigger on Lead (before insert) {
    
    if(Trigger.isInsert && Trigger.isBefore){

        NewCountriesClass.assignOwner(Trigger.new);
    }

}