module striped.billing_details;

import striped.address;
import striped.embeddable;

struct StripeBillingDetails
{
    mixin Embeddable;

    mixin field!(string, "name");
    mixin field!(string, "email");
    mixin field!(string, "phone");

    mixin embeddable!(StripeAddress, "address");
}
