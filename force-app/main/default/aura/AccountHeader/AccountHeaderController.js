({
    initalLoad : function(component, event, helper) {
        
        component.set("v.header",[
            {label:'Account Id'},
            {label:'Name'},
            {label:'Type'},
            {label:'Industry'},
            {label:'Action'}
        ])
    },
    
	handleClick : function(component, event, helper) {
        helper.helperMethod(component,event)
	},
    
    handleComponentEvent : function(component, event,helper) {
        var deleteId = event.getParam("deleteId");
        var action = component.get("c.deleteAccount");
        action.setParams({
            "Id":deleteId
         });
        action.setCallback(this, function(response){
            var state = response.getState();
            if(state == 'SUCCESS'){
                helper.toastMethod('Deleted Successfully','success');
                helper.helperMethod(component,event);
            }
            else{
                helper.toastMethod('Not Deleted Something Went Wrong','error');
            }
        });
        $A.enqueueAction(action);
       
    }
}) 