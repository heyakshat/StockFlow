public with sharing class DuplicatePreventionHandler {
    public static void checkDuplicates(List<Inventory__c> newItems) {
        Set<String> existingKeys = new Set<String>();
        
        for (Inventory__c inv : newItems) {
            String uniqueKey = inv.Product__c + '' + inv.Warehouse__c;
            
            if (existingKeys.contains(uniqueKey)) {
                inv.addError('Duplicate Entry: This product is already registered in this warehouse.');
            }
            existingKeys.add(uniqueKey);
        }
    }
}