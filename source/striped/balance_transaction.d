module striped.balance_transaction;

import striped.object;

struct StripeBalanceTransaction
{
    mixin StripeObject!("balance_transaction");

    mixin field!(int, "amount");
    mixin field!(int, "availableOn", "available_on");
    mixin field!(int, "created");
    mixin field!(string, "currency");
    mixin field!(string, "description");
    mixin field!(double, "exchangeRate", "exchange_rate");
    mixin field!(int, "fee");
    mixin field!(int, "net");
    mixin field!(string, "reportingCategory", "reporting_category");
    mixin field!(string, "status");
    mixin field!(string, "type");

    @property
    bool isAvailable() const
    {
        return status == "available";
    }

    @property
    bool isPending() const
    {
        return status == "pending";
    }
}
