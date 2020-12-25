module striped.charge;

import striped.customer;
import striped.object;

struct StripeCharge
{
    mixin StripeObject!("charge");

    mixin field!(int, "amount");
    mixin field!(int, "amountCaptured", "amount_captured");
    mixin field!(int, "amountRefunded", "amount_refunded");

    mixin expandable!(StripeCustomer, "customer");
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
