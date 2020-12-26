module striped.card;

import striped.customer;
import striped.object;

struct StripeCard
{
    mixin StripeObject!("card");

    mixin field!(string, "addressCity", "address_city");
    mixin field!(string, "addressCountry", "address_country");
    mixin field!(string, "addressLine1", "address_line1");
    mixin field!(string, "addressLine1Check", "address_line1_check");
    mixin field!(string, "addressLine2", "address_line2");
    mixin field!(string, "addressState", "address_state");
    mixin field!(string, "addressZip", "address_zip");
    mixin field!(string, "addressZipCheck", "address_zip_check");
    mixin field!(string, "brand");
    mixin field!(string, "country");
    mixin field!(string, "cvcCheck", "cvc_check");
    mixin field!(string, "currency");
    mixin field!(string, "dynamicLast4", "dynamic_last4");
    mixin field!(int, "expMonth", "exp_month");
    mixin field!(int, "expYear", "exp_year");
    mixin field!(string, "fingerprint");
    mixin field!(string, "funding");
    mixin field!(string, "last4");
    mixin field!(JSONValue, "metadata");
    mixin field!(string, "name");
    mixin field!(string, "tokenizationMethod", "tokenization_method");
    
    mixin expandable!(StripeCustomer, "customer");
}
