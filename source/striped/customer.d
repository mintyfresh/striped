module striped.customer;

import striped.object;

struct StripeCustomer
{
    mixin StripeObject!("customer");

    mixin field!(string, "name");
    mixin field!(string, "email");
}
