public with sharing class InventoryTriggerHandler {
    /**
     * Long Answer: Logic for automated procurement.
     * This method checks if stock has crossed the reorder threshold.
     */
    public static void handleAfterUpdate(List<Inventory__c> newItems, Map<Id, Inventory__c> oldMap) {
        List<Purchase_Order__c> poList = new List<Purchase_Order__c>();

        for (Inventory__c inv : newItems) {
            // Retrieve previous state to ensure we only trigger on the actual crossing of the limit
            Inventory__c oldInv = oldMap.get(inv.Id);
            
            // Logic: Create a Purchase Order if current stock hits or drops below reorder level
            if (inv.Current_Stock__c <= inv.Reorder_Level__c && oldInv.Current_Stock__c > inv.Reorder_Level__c) {
                poList.add(new Purchase_Order__c(
                    Status__c = 'Draft'
                ));
            }
        }

        // Standard DML: Insert the list if it is not empty
        if (!poList.isEmpty()) {
            insert poList;
        }
    }
}