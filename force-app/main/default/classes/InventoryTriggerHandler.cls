public with sharing class InventoryTriggerHandler {
    public static void handleAfterUpdate(List<Inventory__c> newItems, Map<Id, Inventory__c> oldMap) {
        List<Purchase_Order__c> poList = new List<Purchase_Order__c>();
        Account defaultSupplier = [SELECT Id FROM Account WHERE Name = 'Global Tech Parts' LIMIT 1];

        for (Inventory__c inv : newItems) {
            if (inv.Current_Stock__c <= inv.Reorder_Level__c) {

                poList.add(new Purchase_Order__c(
                    Supplier__c = defaultSupplier.Id, 
                    Quantity__c = 100,                   
                    Inventory_Link__c = inv.Id,          
                    Status__c = 'Draft'
                ));
            }
        }

        if (!poList.isEmpty()) {
            insert poList; 
        }
    }
}