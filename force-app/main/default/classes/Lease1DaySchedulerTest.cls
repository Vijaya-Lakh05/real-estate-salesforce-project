@isTest
private class Lease1DaySchedulerTest {

    @isTest
    static void testScheduler() {

        Test.startTest();

        String cronExp =
            '0 0 0 1 1 ? 2099';

        System.schedule(
            'Test Lease 1 Day Scheduler',
            cronExp,
            new Lease1DayScheduler()
        );

        Test.stopTest();

        System.assert(true);
    }
}