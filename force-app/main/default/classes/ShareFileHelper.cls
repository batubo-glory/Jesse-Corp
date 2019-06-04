public class ShareFileHelper {
    
    public static void attachFile(List<Opportunity> opps){
        
        List<ContentDocumentLink> cdls = new List<ContentDocumentLink>();
        for (Opportunity opp : opps){
            //create ID to get Opportunity ID
            ID oppID = opp.ID;
            //select Content Document(File) ID related to opportunity
            ID cdID = [SELECT ContentDocumentId FROM ContentDocumentLink WHERE LinkedEntityId =: oppID].id;
            
            //Check if content document (file) was uploaded
            if(cdID != null){
                //create list of profile names
                Profile Upp = [SELECT Id, Name FROM Profile WHERE Id=:userinfo.getProfileId() LIMIT 1];
                String Up = Upp.Name;
                
                //Check profile of current user
                if(Up == 'cSales Manager' || Up == 'cService Manager'){
                    
                    //Set access of file for manager
                    ContentDocumentLink link = new ContentDocumentLink();
                    link.LinkedEntityId = oppID;
                    link.ContentDocumentId = cdID;
                    link.ShareType = 'C';
                    link.Visibility = 'AllUsers';
                    cdls.add(link);         
                }
                
                if(Up == 'cSales User' || Up == 'cService User'){
                    
                    //Set access of file for user
                    ContentDocumentLink link = new ContentDocumentLink();
                    link.LinkedEntityId = oppID;
                    link.ContentDocumentId = cdID;
                    link.ShareType = 'I';
                    link.Visibility = 'AllUsers';
                    cdls.add(link);
                }
                
            }
        }
        insert cdls;
        
    }
    
}