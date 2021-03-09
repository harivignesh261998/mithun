({
    myAction : function(component, event, helper) {
        component.set("v.isOpen", true);
        component.set('v.accountId',event.getParam("accountId"));
        component.set('v.headerMessage',event.getParam('headerMessage'));
        component.set('v.bodyMessage',event.getParam('bodyMessage'));
        component.set('v.buttonName',event.getParam('buttonName'));

    },
    closeModel : function(component,event,helper){
        component.set('v.isOpen',false);
    },
    submit : function(component,event,helper){

        var appEvent = $A.get("e.c:deleteEvent");
        appEvent.setParams({
            'deleteId':component.get('v.accountId')
        })
        appEvent.fire();
        component.set('v.isOpen',false);

    }
})
