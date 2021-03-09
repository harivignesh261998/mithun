({

   openModel: function(component, event, helper) {
      component.set("v.isOpen", true);
   },
 
   closeModel: function(component, event, helper) {
      component.set("v.isOpen", false);
   },
 
   submit: function(component, event, helper) {
      var newAcc = component.get("v.Accountval");
      var action = component.get("c.saveAccounts");
      console.log(newAcc)
      action.setParams({
         "acc":newAcc
      });
         action.setCallback(this, function(response){
            var state = response.getState();
            if(state == 'SUCCESS'){
               console.log(response.getReturnValue());
            }
            else{
               console.log('failed')
            }
         });
       $A.enqueueAction(action)
       component.set("v.isOpen", false);
   },

   emptyOrNot : function(componnet ,event, helper) {
      if(componnet.get('v.Accountval.Name') != '' || componnet.get('v.Accountval.AccountNumber') != '' || componnet.get('v.Accountval.Type') != '') {
         componnet.set('v.disableButton',false);
      } else{
         componnet.set('v.disableButton',true);
      }
   }
});