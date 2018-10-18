public class PositionButtonsController {
    
    public static Position__c position = [SELECT Id, Post_Status__c FROM Position__c WHERE Id =: ApexPages.CurrentPage().getparameters().get('Id')];
    public CalloutJobAdvertisement calloutJobAdvertisement;
    public static String positionStatus{get;set;}
    public static String statusMessage{get;set;}
    
    public PositionButtonsController(ApexPages.StandardController controller){
        //position = (Position__c)controller.getRecord();
        position = [SELECT Id, Post_Status__c FROM Position__c WHERE Id =: ApexPages.CurrentPage().getparameters().get('Id')];
        positionStatus = position.Post_Status__c;
    }
        
    public static void getJobAdvertisement(){
        try{
        	HttpResponse response = calloutJobAdvertisement.getCalloutResponseContents();
            positionStatus = position.Post_Status__c;
            statusMessage = 'Job Advertisements received';
        } catch(QueryException e){
            ApexPages.addmessage(new ApexPages.message(ApexPages.SEVERITY.ERROR, e.getMessage()));
        } catch(Exception e){
            ApexPages.addmessage(new ApexPages.message(ApexPages.SEVERITY.ERROR, e.getMessage()));
        }
    }
    
    public static void postJobAdvertisement(){
        if(position.Post_Status__c == 'Not posted' || position.Post_Status__c == null){
            try{
            	HttpResponse response = calloutJobAdvertisement.postCalloutResponseContents(position.Id);
                position.Post_Status__c = 'Posted';
                update position;
                statusMessage = 'Job Advertisement posted';
        	} catch(QueryException e){
            	ApexPages.addmessage(new ApexPages.message(ApexPages.SEVERITY.ERROR, e.getMessage()));
        	} catch(Exception e){
            	ApexPages.addmessage(new ApexPages.message(ApexPages.SEVERITY.ERROR, e.getMessage()));
        	}
        } else{
            statusMessage = 'ERROR: Job Advertisement has already been posted!';
        }
        positionStatus = position.Post_Status__c;
    }
    
    public static void deleteJobAdvertisement(){
        if(position.Post_Status__c == 'Posted'){
            try{
            	HttpResponse response = calloutJobAdvertisement.deleteCalloutResponseContents(position.Id);
                position.Post_Status__c = 'Not posted';
                update position;
                statusMessage = 'Job Advertisement deleted';
        	} catch(QueryException e){
            	ApexPages.addmessage(new ApexPages.message(ApexPages.SEVERITY.ERROR, e.getMessage()));
        	} catch(Exception e){
            	ApexPages.addmessage(new ApexPages.message(ApexPages.SEVERITY.ERROR, e.getMessage()));
        	}
        } else{
            statusMessage = 'ERROR: This Job Advertisement does not exist!';
        }
        positionStatus = position.Post_Status__c;
    }
    
    public static void updateJobAdvertisement(){
        if(position.Post_Status__c == 'Posted'){
            try{
            	HttpResponse response = calloutJobAdvertisement.putCalloutResponseContents(position.Id);
                statusMessage = 'Job Advertisement updated';
        	} catch(QueryException e){
            	ApexPages.addmessage(new ApexPages.message(ApexPages.SEVERITY.ERROR, e.getMessage()));
        	} catch(Exception e){
            	ApexPages.addmessage(new ApexPages.message(ApexPages.SEVERITY.ERROR, e.getMessage()));
        	}
        } else{
            statusMessage = 'ERROR: This Job Advertisement does not exist!';
        }
        positionStatus = position.Post_Status__c;
    }
}