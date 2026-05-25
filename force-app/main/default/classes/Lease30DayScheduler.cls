global class Lease30DayScheduler implements Schedulable {

    global void execute(SchedulableContext sc) {

        Database.executeBatch(
            new LeaseExpiryReminderBatch(30)
        );
    }
}