public with sharing class InventoryTriggerHandler {
 
    public static void handleAfterUpdate(List<Inventory__c> newItems, Map<Id, Inventory__c> oldMap) {
        List<Purchase_Order__c> poList = new List<Purchase_Order__c>();

        for (Inventory__c inv : newItems) {
            Inventory__c oldInv = oldMap.get(inv.Id);
            
            if (inv.Current_Stock__c <= inv.Reorder_Level__c && oldInv.Current_Stock__c > inv.Reorder_Level__c) {
                poList.add(new Purchase_Order__c(
                    Status__c = 'Draft'
                ));
            }
        }
        if (!poList.isEmpty()) {
            insert poList;
        }
    }
}