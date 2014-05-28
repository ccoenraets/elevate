@isTest
public class TestDataFactory {
	
	public static Invoice__c createOneInvoiceStatement(Boolean withLineItem) {
	    // Create Warehouse if one does not exist
            Warehouse__c w;
            List<Warehouse__c> warehouse = [SELECT ID from Warehouse__c];
            if(warehouse.size() == 0) {
                w = createWarehouseLocation('Warehouse 1');
            } else {
                w = warehouse[0];
            }

            // Create one invoice
	    Invoice__c testInvoice = createInvoiceStatement();
            if (withLineItem == true) {
                // Create a merchandise item
		Merchandise__c m = createMerchandiseItem('Orange juice',w);
	  	// Create one line item and associate it with the invoice
      		AddLineItem(testInvoice, m);
	    }
	    return testInvoice;
	}

	// Helper methods
	//
	private static Warehouse__c createWarehouseLocation(String warehouseName) {
	    Warehouse__c w = new Warehouse__c(
	        Name=warehouseName,
	        City__c='San Francisco',
	        Location__Latitude__s=37.7833,
	     	Location__Longitude__s=122.4167);
	 	insert w;
		return w; 
	}
	
	private static Merchandise__c createMerchandiseItem(String merchName, Warehouse__c w) {
	    Merchandise__c m = new Merchandise__c(
	        Name=merchName,
	        Price__c=2,
	        Quantity__c=1000,
	        Warehouse__c = w.Id);
		insert m;
		return m; 
	}
	
	private static Invoice__c createInvoiceStatement() {
		Invoice__c inv = new Invoice__c();
	    insert inv;
	  	return inv;
	}
	
	private static Line_Item__c AddLineItem(Invoice__c inv, Merchandise__c m) {
		Line_Item__c lineItem = new Line_Item__c(
	        Invoice__c = inv.Id,
	        Merchandise__c = m.Id,
	  		Unit_Price__c = m.Price__c,
	  		Quantity__c = (Double)(10*Math.random()+1));
		insert lineItem;
	    return lineItem;
	}
	
}
