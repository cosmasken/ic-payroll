import Principal "mo:base/Principal";
import Time "mo:base/Time";

    
    module {
    // Define a type for representing the different subscription types
    public type SubscriptionType = {
        #Trial;
        #Monthly;
        #Yearly;
    };

    // Define a type for representing different employee tiers
    public type EmployeeTier = {
        #Tier1;  // 1-10 employees
        #Tier2;  // 11-50 employees
        #Tier3;  // 51-100 employees
        #Tier4;  // 101+ employees
    };

    // Define a type for representing the amount associated with each subscription type and employee tier
    public type SubscriptionAmount = {
        trial: Nat;
        monthly: [Nat];  // Array to store amounts for each employee tier
        yearly: [Nat];   // Array to store amounts for each employee tier
    };

     // Constants for duration in nanoseconds
    let oneDay : Nat64 = 86_400_000_000_000;  // 24 hours in nanoseconds
    let oneMonth : Nat64 = oneDay * 30;       // Approximation of 30 days in nanoseconds
    let oneYear : Nat64 = oneDay * 365;       // Approximation of 365 days in nanoseconds


    // Define a type to represent a subscription
    public type Subscription = {
        id: Nat;                        // Unique identifier for the subscription
        user: Principal;                     // User principal associated with the subscription
        subscriptionType: SubscriptionType; // Type of the subscription
        employeeCount: Nat;             // Number of employees
        amount: Nat;                    // Amount to be paid for the subscription
        startDate: Time.Time;                // Start date of the subscription
        endDate: ?Time.Time;                 // Optional end date for trial subscriptions or cancellations
    };

    // Function to calculate the end date based on the subscription type
    public func calculateEndDate(subscriptionType: SubscriptionType, startDate: Time.Time) : ?Time.Time {
        switch subscriptionType {
            case (#Trial) null;  // Trials may not have a predefined end date
            case (#Monthly) ?Time.add(startDate, oneMonth);
            case (#Yearly) ?Time.add(startDate, oneYear);
        }
    };

    // Define default amounts for different subscription types and employee tiers
    public let defaultAmounts : SubscriptionAmount = {
        trial = 0;                     // Trial subscriptions are usually free
        monthly = [10_000, 25_000, 40_000, 70_000];  // Monthly costs for Tier1, Tier2, Tier3, Tier4
        yearly = [100_000, 250_000, 400_000, 700_000]; // Yearly costs for Tier1, Tier2, Tier3, Tier4
    };

    // Function to determine the employee tier based on the number of employees
    public func determineEmployeeTier(employeeCount: Nat) : EmployeeTier {
        if (employeeCount <= 10) {
            #Tier1
        } else if (employeeCount <= 50) {
            #Tier2
        } else if (employeeCount <= 100) {
            #Tier3
        } else {
            #Tier4
        }
    };

    // Function to create a new subscription
    public func createSubscription(user: Principal, subscriptionType: SubscriptionType, employeeCount: Nat, startDate: Time) : Subscription {
        let tier = determineEmployeeTier(employeeCount);
        let amount = switch (subscriptionType, tier) {
            case (#Trial, _) defaultAmounts.trial;
            case (#Monthly, #Tier1) defaultAmounts.monthly[0];
            case (#Monthly, #Tier2) defaultAmounts.monthly[1];
            case (#Monthly, #Tier3) defaultAmounts.monthly[2];
            case (#Monthly, #Tier4) defaultAmounts.monthly[3];
            case (#Yearly, #Tier1) defaultAmounts.yearly[0];
            case (#Yearly, #Tier2) defaultAmounts.yearly[1];
            case (#Yearly, #Tier3) defaultAmounts.yearly[2];
            case (#Yearly, #Tier4) defaultAmounts.yearly[3];
        };

        {
            id = 0;  // Assign a unique ID for each subscription, to be implemented
            user = user;
            subscriptionType = subscriptionType;
            employeeCount = employeeCount;
            amount = amount;
            startDate = startDate;
            endDate = calculateEndDate(subscriptionType, startDate);  // Calculate end date based on subscription type
        }
    };

    // Example of using the createSubscription function
   // public let exampleSubscription = createSubscription("user123", #Monthly, 15, Time.now());
};
