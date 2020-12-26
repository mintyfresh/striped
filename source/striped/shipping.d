module striped.shipping;

import striped.address;
import striped.object;

struct StripeShipping
{
    mixin StripeObject!(UNTYPED_OBJECT);

    mixin field!(string, "name");
    mixin field!(string, "phone");

    mixin embeddable!(StripeAddress, "address");
}
