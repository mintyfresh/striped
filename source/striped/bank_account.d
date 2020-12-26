module striped.bank_account;

import striped.customer;
import striped.object;

struct StripeBankAccount
{
    mixin StripeObject!("bank_account");

    mixin identifier;

    mixin field!(string, "accountHolderName", "account_holder_name");
    mixin field!(string, "accountHolderType", "account_holder_type");
    mixin field!(string, "bankName", "bank_name");
    mixin field!(string, "country");
    mixin field!(string, "currency");
    mixin field!(string, "fingerprint");
    mixin field!(string, "last4");
    mixin field!(JSONValue, "metadata");
    mixin field!(string, "routingNumber", "routing_number");
    mixin field!(string, "status");

    mixin expandable!(StripeCustomer, "customer");
}
