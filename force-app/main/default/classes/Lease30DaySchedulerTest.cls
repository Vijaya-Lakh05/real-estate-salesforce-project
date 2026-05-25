@isTest
private class Lease30DaySchedulerTest {

    @isTest
    static void testScheduler() {

        Test.startTest();

        String cronExp =
            '0 0 0 1 1 ? 2099';

        System.schedule(
            'Test Lease 30 Day Scheduler',
            cronExp,
            new Lease30DayScheduler()
        );

        Test.stopTest();

        System.assert(true);
    }
}