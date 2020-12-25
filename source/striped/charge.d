module striped.charge;

import striped.billing_details;
import striped.customer;
import striped.invoice;
import striped.object;

struct StripeCharge
{
    mixin StripeObject!("charge");

    mixin field!(int, "amount");
    mixin field!(int, "amountCaptured", "amount_captured");
    mixin field!(int, "amountRefunded", "amount_refunded");
    mixin field!(string, "currency");
    mixin field!(string, "description");
    mixin field!(bool, "disputed");
    mixin field!(JSONValue, "metadata");
    mixin field!(string, "receiptEmail", "receipt_email");
    mixin field!(bool, "refunded");
    mixin field!(string, "statementDescriptor", "statement_descriptor");
    mixin field!(string, "statementDescriptorSuffix", "statement_descriptor_suffix");
    mixin field!(string, "status");

    mixin expandable!(StripeCustomer, "customer");
    mixin expandable!(StripeInvoice, "invoice");

    mixin embeddable!(StripeBillingDetails, "billingDetails", "billing_details");

    @property
    bool isPending() const
    {
        return status == "pending";
    }

    @property
    bool isSucceeded() const
    {
        return status == "succeeded";
    }

    @property
    bool isFailed() const
    {
        return status == "failed";
    }
}

version (unittest)
{
    import std.exception;
    import std.json;
    import striped.client;
}

unittest
{
    const client = StripeClient("sk_test_1");
    const charge = StripeCharge(client);

    assert(charge.id == null);
    assert(charge.isPersisted == false);
    assert(charge.amount.isNull);
}

unittest
{
    const client = StripeClient("sk_test_1");
    const charge = StripeCharge(client, parseJSON(`
        {
            "id": "ch_12345",
            "object": "charge",
            "amount": 15000,
            "amount_refunded": 5000
        }
    `));

    assert(charge.id == "ch_12345");
    assert(charge.isPersisted == true);
    assert(charge.amount == 150_00);
    assert(charge.amountRefunded == 50_00);
}
