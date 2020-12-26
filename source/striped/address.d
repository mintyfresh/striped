module striped.address;

import striped.object;

struct StripeAddress
{
    mixin StripeObject!(UNTYPED_OBJECT);

    mixin field!(string, "city");
    mixin field!(string, "country");
    mixin field!(string, "line1");
    mixin field!(string, "line2");
    mixin field!(string, "postalCode", "postal_code");
    mixin field!(string, "state");
}
