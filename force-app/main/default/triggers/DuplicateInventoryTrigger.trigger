trigger DuplicateInventoryTrigger on Inventory__c (before insert) {
    Set<String> uniqueKeys = new Set<String>();
    for (Inventory__c inv : Trigger.new) {
        String key = inv.Products__c + '' + inv.Warehouses__c;
        if (uniqueKeys.contains(key)) {
            inv.addError('Duplicate record: This product is already mapped to this warehouse.');
        }
        uniqueKeys.add(key);
    }
}