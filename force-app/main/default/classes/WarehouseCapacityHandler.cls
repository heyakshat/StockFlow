public with sharing class WarehouseCapacityHandler {
    public static void validateCapacity(List<Inventory__c> newItems) {
        for (Inventory__c inv : newItems) {
            if (inv.Current_Stock__c > inv.Max_Capacity__c) {
                inv.addError('Capacity Exceeded: You cannot store ' + inv.Current_Stock__c + 
                             ' units. The maximum limit is ' + inv.Max_Capacity__c);
            }
        }
    }
}