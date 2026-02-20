trigger PurchaseOrderTrigger on Purchase_Order__c (after update) {
    if (Trigger.isAfter && Trigger.isUpdate) {
        PurchaseOrderTriggerHandler.handleAfterUpdate(Trigger.new, Trigger.oldMap);
    }
}
