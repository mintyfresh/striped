module striped.shipping;

import striped.address;
import striped.embeddable;

struct StripeShipping
{
    mixin Embeddable;

    mixin field!(string, "name");
    mixin field!(string, "phone");

    mixin embeddable!(StripeAddress, "address");
}
