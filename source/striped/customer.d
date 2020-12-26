module striped.customer;

import striped.address;
import striped.object;
import striped.shipping;

struct StripeCustomer
{
    mixin StripeObject!("customer");

    mixin field!(int, "balance");
    mixin field!(int, "created");
    mixin field!(string, "currency");
    mixin field!(bool, "delinquent");
    mixin field!(string, "description");
    mixin field!(string, "email");
    mixin field!(string, "invoicePrefix", "invoice_prefix");
    mixin field!(bool, "livemode");
    mixin field!(JSONValue, "metadata");
    mixin field!(int, "nextInvoiceSequence", "next_invoice_sequence");
    mixin field!(string[], "preferredLocales", "preferred_locales");
    mixin field!(string, "name");
    mixin field!(string, "phone");
    mixin field!(string, "taxExempt", "tax_exempt");

    mixin embeddable!(StripeAddress, "address");
    mixin embeddable!(StripeShipping, "shipping");
}
