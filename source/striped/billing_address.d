module striped.billing_address;

import striped.embeddable;

struct StripeBillingAddress
{
    mixin Embeddable;

    mixin field!(string, "city");
    mixin field!(string, "country");
    mixin field!(string, "line1");
    mixin field!(string, "line2");
    mixin field!(string, "postalCode", "postal_code");
    mixin field!(string, "state");
}
