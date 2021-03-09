({
	helperMethod : function(component,event) {
		var tableData = component.find("tableData");
       	tableData.callRecord();
		
	},

	toastMethod : function(toastMessage,toastType) {
		var appEvent = $A.get("e.c:tEvent");
		appEvent.setParams({
			toastMessage:toastMessage,
			toastType:toastType
		})
		appEvent.fire();
	}
	
}) 