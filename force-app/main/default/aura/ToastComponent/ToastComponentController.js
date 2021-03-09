({
    myAction : function(component, event, helper) {
        try {
            component.find('notifLib').showToast({
                "variant": event.getParam('toastType'),
                "message": event.getParam('toastMessage'),
                "mode": "dismissable"
            });
          } catch(err) {
            component.set('v.toast',true);
            component.set('v.toastMessage', event.getParam('toastMessage'));
            component.set('v.toastType',event.getParam('toastType'));
            setTimeout(function(){
                component.set('v.toast',false)
            },3000);
          }
    },

    closeMethod : function(component,event){
        component.set('v.toast',false);
    }
})
