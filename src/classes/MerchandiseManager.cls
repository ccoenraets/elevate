@RestResource(urlMapping='/Merchandise/*')
global with sharing class MerchandiseManager {

	@HttpGet
	global static Merchandise__c getMerchandiseById() {
		RestRequest req = RestContext.request;
		String merchId = req.requestURI.substring(req.requestURI.lastIndexOf('/')+1);
		Merchandise__c result =
			[SELECT Name,Price__c,Quantity__c
			FROM Merchandise__c
			WHERE Id = :merchId];
		return result;
	}

	@HttpPost
	global static String createMerchandise(String name, Decimal price, Double inventory, String warehouse) {
		List<Warehouse__c> warehouses = [SELECT ID from Warehouse__c WHERE Name =:warehouse LIMIT 1];
		if(warehouses.size() > 0) {
			Merchandise__c m = new Merchandise__c(
			Name=name,
			Price__c=price,
			Quantity__c=inventory,
			Warehouse__c=warehouses[0].Id);
			insert m;
			return m.Id;
		} else {
			throw new RESTException('No warehouse found by that name');
			return null;
		}
	}
	
	class RESTException extends Exception {}

}