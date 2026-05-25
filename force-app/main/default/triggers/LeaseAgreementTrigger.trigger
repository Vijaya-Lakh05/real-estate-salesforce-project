trigger LeaseAgreementTrigger on Lease_Agreement__c (after insert) {

    List<Task> tasks = new List<Task>();

    for(Lease_Agreement__c lease : Trigger.new) {

        Task t = new Task();

        t.Subject = 'Generate Lease Agreement';
        t.Status = 'Not Started';
        t.Priority = 'Normal';

        tasks.add(t);
    }

    if(!tasks.isEmpty()) {
        insert tasks;
    }
}