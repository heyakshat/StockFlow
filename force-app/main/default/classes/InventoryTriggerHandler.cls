public with sharing class InventoryTriggerHandler {
    public static void handleAfterUpdate(List<Inventory__c> newItems, Map<Id, Inventory__c> oldMap) {
        List<Purchase_Order__c> poList = new List<Purchase_Order__c>();

        for (Inventory__c inv : newItems) {
            Inventory__c oldInv = oldMap.get(inv.Id);
            
            // LOGIC: Trigger when stock falls below reorder level
            if (inv.Current_Stock__c <= inv.Reorder_Level__c && oldInv.Current_Stock__c > inv.Reorder_Level__c) {
                poList.add(new Purchase_Order__c(
                    Products__c = inv.Products__c,      // Corrected API Name
                    Warehouses__c = inv.Warehouses__c,  // Corrected API Name
                    Status__c = 'Draft'
                    // Note: Quantity__c is removed here. 
                    // Add it only if you have created that field on Purchase_Order__c.
                ));
            }
        }

        if (!poList.isEmpty()) {
            insert poList;
        }
    }
}