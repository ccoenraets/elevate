@RestResource(urlMapping='/Session/*')
global with sharing class SessionManager {

	@HttpGet
	global static Session__c getSessionById() {
		RestRequest req = RestContext.request;
		String sessionId = req.requestURI.substring(req.requestURI.lastIndexOf('/')+1);
		Session__c result =
			[SELECT Name, Description__c, Level__c FROM Session__c WHERE Id = :sessionId];
		return result;
	}

	class RESTException extends Exception {}

}