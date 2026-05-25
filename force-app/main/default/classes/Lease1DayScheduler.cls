global class Lease1DayScheduler implements Schedulable {

    global void execute(SchedulableContext sc) {

        Database.executeBatch(
            new LeaseExpiryReminderBatch(1)
        );
    }
}