module striped.billing_details;

import striped.billing_address;
import striped.embeddable;

struct StripeBillingDetails
{
    mixin Embeddable;

    mixin field!(string, "name");
    mixin field!(string, "email");
    mixin field!(string, "phone");

    mixin embeddable!(StripeBillingAddress, "address");
}
