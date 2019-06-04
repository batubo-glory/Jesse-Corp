trigger ShareFile on Opportunity (before insert) {
    if(trigger.isInsert) {
        ShareFileHelper.attachFile(trigger.new);
    }
}