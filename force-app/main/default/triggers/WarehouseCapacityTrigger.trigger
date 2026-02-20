trigger WarehouseCapacityTrigger on Inventory__c (before insert, before update) {
    for (Inventory__c inv : Trigger.new) {
        if (inv.Current_Stock__c > inv.Max_Capacity__c) {
            inv.addError('Critical Error: Current stock exceeds the maximum bin capacity for this warehouse.');
        }
    }
}