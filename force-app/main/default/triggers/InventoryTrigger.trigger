trigger InventoryTrigger on Inventory__c (after update) {
    if (Trigger.isAfter && Trigger.isUpdate) {
        InventoryTriggerHandler.handleAfterUpdate(Trigger.new, Trigger.oldMap);
    }
}