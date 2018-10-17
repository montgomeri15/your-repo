@isTest
private class CalloutJobAdvertisementTest {
    
    static Position__c insertPosition(){
        Position__c position = new Position__c(Name = 'OurName');
        insert position;
        return position;
    }
    
    static String accessTokenBody(){  //Токен-данные
        Settings__c settings = new Settings__c(Name = 'OurSettings',
                               				   ConsumerKey__c = '234234234',
                               				   ClientSecret__c = '678678678',
                               				   Username__c = 'mail@mail.com',
                               				   SecurityToken__c = '12312321213',
                               				   Password__c = 'mypassword1');
        insert settings;
        
        String consumerKey = settings.ConsumerKey__c;
		String consumerSecret = settings.ClientSecret__c;
		String username = settings.Username__c;
		String password = settings.Password__c + settings.SecurityToken__c;
    	String request = 'grant_type=password&client_id=' + consumerKey +'&client_secret=' + consumerSecret +
            			 '&username=' + username + '&password='+password;
        return request;
    }
    
    //GET
    
    @isTest
    static void testGetCallout() {         
        String request = accessTokenBody();
                
    	Test.startTest(); 
 		Test.setMock(HttpCalloutMock.class, new CalloutJobAdvertisementMock(200, 'ACCESS_TOKEN'));
  		HttpResponse response = CalloutJobAdvertisement.getCalloutResponseContents();
 		String contentType = response.getHeader('Content-Type');
    	System.assert(contentType == 'application/json');
    	String actualValue = response.getBody();
    	System.debug('GET Callout:   ' + response.getBody());
    	String expectedValue = '{"Name":"OurName"}';
    	System.assertEquals(actualValue, expectedValue);
    	System.assertEquals(200, response.getStatusCode());
        Test.stopTest(); 
	}
    
    @isTest
    static void testGetCalloutNot200() {         
        String request = accessTokenBody();
        HttpResponse response;
                
    	Test.startTest(); 
 		Test.setMock(HttpCalloutMock.class, new CalloutJobAdvertisementMock(500, 'ACCESS_TOKEN'));
 		try {
  			response = CalloutJobAdvertisement.getCalloutResponseContents();
		} catch(CalloutJobAdvertisement.ResponseException e) {
            System.debug('ERROR 200:   ' + e);
            System.assertEquals(response, null);
		}
        Test.stopTest(); 
	}
    
    @isTest
    static void testGetCalloutNoToken() {         
        String request = accessTokenBody();
        HttpResponse response;
                
    	Test.startTest(); 
 		Test.setMock(HttpCalloutMock.class, new CalloutJobAdvertisementMock(200, 'OTHER_WORDS_HERE'));
 		try {
  			response = CalloutJobAdvertisement.getCalloutResponseContents();
		} catch(CalloutJobAdvertisement.ResponseException e) {
            System.debug('TOKEN ERROR:   ' + e);
            System.assertEquals(response, null);
		}
        Test.stopTest(); 
	}
        
    //POST
    
    @isTest
    static void testPostCallout() {
        String request = accessTokenBody();
        Position__c testPosition = insertPosition();

    	Test.startTest(); 
 		Test.setMock(HttpCalloutMock.class, new CalloutJobAdvertisementMock(200, 'ACCESS_TOKEN'));
 		HttpResponse response = CalloutJobAdvertisement.postCalloutResponseContents(testPosition.Id);
 		String contentType = response.getHeader('Content-Type');
    	System.assert(contentType == 'application/json');
    	String actualValue = response.getBody();
    	System.debug('POST Callout:   ' + response.getBody());
    	String expectedValue = '{"Name":"OurName"}';
    	System.assertEquals(actualValue, expectedValue);
    	System.assertEquals(200, response.getStatusCode());
        Test.stopTest(); 
	}
    
    @isTest
    static void testPostCalloutNot200() {         
        String request = accessTokenBody();
        Position__c testPosition = insertPosition();
        HttpResponse response;
                
    	Test.startTest(); 
 		Test.setMock(HttpCalloutMock.class, new CalloutJobAdvertisementMock(500, 'ACCESS_TOKEN'));
 		try {
  			response = CalloutJobAdvertisement.postCalloutResponseContents(testPosition.Id);
		} catch(CalloutJobAdvertisement.ResponseException e) {
            System.debug('ERROR 200:   ' + e);
            System.assertEquals(response, null);
		}
        Test.stopTest(); 
	}
    
    @isTest
    static void testPostCalloutNoToken() {         
        String request = accessTokenBody();
        Position__c testPosition = insertPosition();
        HttpResponse response;
                
    	Test.startTest(); 
 		Test.setMock(HttpCalloutMock.class, new CalloutJobAdvertisementMock(200, 'OTHER_WORDS_HERE'));
 		try {
  			response = CalloutJobAdvertisement.postCalloutResponseContents(testPosition.Id);
		} catch(CalloutJobAdvertisement.ResponseException e) {
            System.debug('TOKEN ERROR:   ' + e);
            System.assertEquals(response, null);
		}
        Test.stopTest(); 
	}
    
    //DELETE
    
    @isTest
    static void testDeleteCallout() {         
        String request = accessTokenBody();
        Position__c testPosition = insertPosition();
        
    	Test.startTest(); 
 		Test.setMock(HttpCalloutMock.class, new CalloutJobAdvertisementMock(200, 'ACCESS_TOKEN'));
 		HttpResponse response = CalloutJobAdvertisement.deleteCalloutResponseContents(testPosition.Id);
 		String contentType = response.getHeader('Content-Type');
    	System.assert(contentType == 'application/json');
    	String actualValue = response.getBody();
    	System.debug('DELETE Callout:   ' + response.getBody());
    	String expectedValue = '{"Name":"OurName"}';
    	System.assertEquals(actualValue, expectedValue);
    	System.assertEquals(200, response.getStatusCode());
        Test.stopTest(); 
	}
    
    @isTest
    static void testDeleteCalloutNot200() {         
        String request = accessTokenBody();
        Position__c testPosition = insertPosition();
        HttpResponse response;
                
    	Test.startTest(); 
 		Test.setMock(HttpCalloutMock.class, new CalloutJobAdvertisementMock(500, 'ACCESS_TOKEN'));
 		try {
  			response = CalloutJobAdvertisement.deleteCalloutResponseContents(testPosition.Id);
		} catch(CalloutJobAdvertisement.ResponseException e) {
            System.debug('ERROR 200:   ' + e);
            System.assertEquals(response, null);
		}
        Test.stopTest(); 
	}
    
    @isTest
    static void testDeleteCalloutNoToken() {         
        String request = accessTokenBody();
        Position__c testPosition = insertPosition();
        HttpResponse response;
                
    	Test.startTest(); 
 		Test.setMock(HttpCalloutMock.class, new CalloutJobAdvertisementMock(200, 'OTHER_WORDS_HERE'));
 		try {
  			response = CalloutJobAdvertisement.deleteCalloutResponseContents(testPosition.Id);
		} catch(CalloutJobAdvertisement.ResponseException e) {
            System.debug('TOKEN ERROR:   ' + e);
            System.assertEquals(response, null);
		}
        Test.stopTest(); 
	}
    
    //PUT
    
    @isTest    
    static void testPutCallout(){
        String request = accessTokenBody();
        Position__c testPosition = insertPosition();
        
    	Test.startTest(); 
 		Test.setMock(HttpCalloutMock.class, new CalloutJobAdvertisementMock(200, 'ACCESS_TOKEN'));
 		HttpResponse response = CalloutJobAdvertisement.putCalloutResponseContents(testPosition.Id);
 		String contentType = response.getHeader('Content-Type');
    	System.assert(contentType == 'application/json');
    	String actualValue = response.getBody();
    	System.debug('PUT Callout:   ' + response.getBody());
    	String expectedValue = '{"Name":"OurName"}';
    	System.assertEquals(actualValue, expectedValue);
    	System.assertEquals(200, response.getStatusCode());
        Test.stopTest(); 
    }
    
    @isTest
    static void testPutCalloutNot200() {         
        String request = accessTokenBody();
        Position__c testPosition = insertPosition();
        HttpResponse response;
                
    	Test.startTest(); 
 		Test.setMock(HttpCalloutMock.class, new CalloutJobAdvertisementMock(500, 'ACCESS_TOKEN'));
 		try {
  			response = CalloutJobAdvertisement.putCalloutResponseContents(testPosition.Id);
		} catch(CalloutJobAdvertisement.ResponseException e) {
            System.debug('ERROR 200:   ' + e);
            System.assertEquals(response, null);
		}
        Test.stopTest(); 
	}
    
    @isTest
    static void testPutCalloutNoToken() {         
        String request = accessTokenBody();
        Position__c testPosition = insertPosition();
        HttpResponse response;
                
    	Test.startTest(); 
 		Test.setMock(HttpCalloutMock.class, new CalloutJobAdvertisementMock(200, 'OTHER_WORDS_HERE'));
 		try {
  			response = CalloutJobAdvertisement.putCalloutResponseContents(testPosition.Id);
		} catch(CalloutJobAdvertisement.ResponseException e) {
            System.debug('TOKEN ERROR:   ' + e);
            System.assertEquals(response, null);
		}
        Test.stopTest(); 
	}
}