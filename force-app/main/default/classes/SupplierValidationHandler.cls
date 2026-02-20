public with sharing class SupplierValidationHandler {
    public static void verifySupplier(List<Purchase_Order__c> poList) {
        for (Purchase_Order__c po : poList) {
            if (po.Supplier_Status__c != 'Active') {
                po.addError('Invalid Supplier: Purchase Orders can only be issued to Active vendors.');
            }
        }
    }
}