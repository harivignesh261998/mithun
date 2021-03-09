({
    handleClick : function(component, event, helper) {
        var time = component.find("inputId").get("v.value");
        var newYork = moment.tz(time,'America/New_York').format('MMMM Do YYYY, h:mm:ss a');
        component.set("v.myAttribute",newYork);
    }   
})