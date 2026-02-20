@isTest
public class StockFlowTest {
    
    @testSetup
    static void setupData() {
        // Create an Active Supplier
        Account supplier = new Account(Name = 'Global Tech Parts', Status__c = 'Active');
        insert supplier;

        // Create Inventory with defined capacity
        Inventory__c inv = new Inventory__c(
            Current_Stock__c = 100,
            Reorder_Level__c = 50,
            Max_Capacity__c = 500,
            Status__c = 'In Stock'
        );
        insert inv;
    }

    @isTest
    static void testAutoProcurement() {
        Inventory__c inv = [SELECT Id FROM Inventory__c LIMIT 1];
        
        Test.startTest();
        inv.Current_Stock__c = 30; // Drop below Reorder Level (50)
        update inv;
        Test.stopTest();

        List<Purchase_Order__c> pos = [SELECT Id FROM Purchase_Order__c];
        System.assertEquals(1, pos.size(), 'A Purchase Order should be generated automatically.');
    }

    @isTest
    static void testStockFulfillment() {
        Inventory__c inv = [SELECT Id, Current_Stock__c FROM Inventory__c LIMIT 1];
        Account acc = [SELECT Id FROM Account LIMIT 1];
        
        Purchase_Order__c po = new Purchase_Order__c(
            Supplier__c = acc.Id,
            Quantity__c = 50,
            Status__c = 'Draft',
            Inventory_Link__c = inv.Id
        );
        insert po;

        Test.startTest();
        po.Status__c = 'Received';
        update po;
        Test.stopTest();

        Inventory__c updatedInv = [SELECT Current_Stock__c FROM Inventory__c WHERE Id = :inv.Id];
        System.assertEquals(150, updatedInv.Current_Stock__c, 'Inventory should increase by 50 units.');
    }

    @isTest
    static void testCapacityValidation() {
        Inventory__c inv = [SELECT Id FROM Inventory__c LIMIT 1];
        
        Test.startTest();
        inv.Current_Stock__c = 600; 
        try {
            update inv;
            System.assert(false, 'The trigger should have blocked this update.');
        } catch (DmlException e) {
            System.assert(e.getMessage().contains('exceeds the Warehouse bin capacity'), 'Correct error message received.');
        }
        Test.stopTest();
    }
}