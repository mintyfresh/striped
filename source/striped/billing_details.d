module striped.billing_details;

import striped.address;
import striped.object;

struct StripeBillingDetails
{
    mixin StripeObject!(UNTYPED_OBJECT);

    mixin field!(string, "name");
    mixin field!(string, "email");
    mixin field!(string, "phone");

    mixin embeddable!(StripeAddress, "address");
}
