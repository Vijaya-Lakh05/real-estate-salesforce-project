global class LeaseExpiryReminderBatch implements Database.Batchable<SObject> {

    private Integer daysBefore;

    public LeaseExpiryReminderBatch(Integer daysBefore) {
        this.daysBefore = daysBefore;
    }

    // STEP 1: Collect records
    global Database.QueryLocator start(Database.BatchableContext bc) {

        Date targetDate = Date.today().addDays(daysBefore);

        return Database.getQueryLocator([
            SELECT Id,
                   Name,
                   End_Date__c,
                   Tenant__r.Name,
                   Tenant__r.Email__c
            FROM Lease_Agreement__c
            WHERE End_Date__c = :Date.today().addDays(daysBefore)
        ]);
    }

    // STEP 2: Process records
    global void execute(Database.BatchableContext bc, List<Lease_Agreement__c> scope) {

        List<Messaging.SingleEmailMessage> emails = new List<Messaging.SingleEmailMessage>();

        for (Lease_Agreement__c lease : scope) {

            if (lease.Tenant__r == null ||
                String.isBlank(lease.Tenant__r.Email__c)) {
                continue;
            }

            Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();

            mail.setToAddresses(new String[] {
                lease.Tenant__r.Email__c
            });

            mail.setSubject('Lease Expiry Reminder - ' + lease.Name);

            String body =
                'Hello ' + lease.Tenant__r.Name + ',\n\n' +
                'Your lease "' + lease.Name + '" will expire on ' +
                lease.End_Date__c + '.\n\n' +
                'Regards,\nProperty Management Team';

            mail.setPlainTextBody(body);

            emails.add(mail);
        }

        if (!emails.isEmpty()) {
            Messaging.sendEmail(emails);
        }
    }

    // STEP 3: Finish
    global void finish(Database.BatchableContext bc) {
        System.debug('Lease expiry batch completed');
    }
}