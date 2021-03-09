({

    fetchAccounts : function(component, event, helper) {
        var action = component.get("c.fetchAccts");
        action.setCallback(this, function(response){
            var state = response.getState();
            if (state === "SUCCESS") {
                
                var records = response.getReturnValue();
                component.set("v.acctList", records);
                console.log(records.length);
            }
            else{
                console.log('failed');
            }
        });
            
        $A.enqueueAction(action);
    },

    showCaseDeleteModal : function(component, event, helper){
        var accountId = event.currentTarget.dataset.value;
        var modalEvent = $A.get("e.c:aeEvent");
        modalEvent.setParams({
            'accountId':accountId,
            'headerMessage':'Account Delete',
            'bodyMessage':'Do you really want to delete ?',
            'buttonName':'Delete'
           });
        modalEvent.fire();        
    },
})