module striped.refund;

import striped.balance_transaction;
import striped.charge;
import striped.object;

struct StripeRefund
{
    mixin StripeObject!("refund");

    mixin identifier;

    mixin field!(int, "amount");
    mixin field!(int, "created");
    mixin field!(string, "currency");
    mixin field!(string, "description");
    mixin field!(string, "failureReason", "failure_reason");
    mixin field!(JSONValue, "metadata");
    mixin field!(string, "reason");
    mixin field!(string, "recipientNumber", "recipient_number");
    mixin field!(string, "status");

    mixin expandable!(StripeBalanceTransaction, "balanceTransaction", "balance_transaction");
    mixin expandable!(StripeCharge, "charge");
    mixin expandable!(StripeBalanceTransaction, "failureBalanceTransaction", "failure_balance_transaction");
}
