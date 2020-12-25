module striped.charge;

import striped.client;

import std.json;
import std.typecons;

struct StripeCharge
{
private:
    StripeClient _client;
    string       _id;
    JSONValue    _charge;

public:
    @disable this();

    this(StripeClient client)
    {
        _client = client;
        _charge = JSONValue((string[string]).init);
    }

    this(StripeClient client, JSONValue charge)
    {
        _client = client;
        _id     = charge["id"].str;
        _charge = charge;
    }

    @property
    string id() const
    {
        return _id;
    }

    @property
    bool isPersisted() const
    {
        return _id !is null;
    }

    @property
    Nullable!(int) amount() const
    {
        Nullable!(int) result;

        if (auto value = "amount" in _charge)
        {
            result = value.get!(int);
        }

        return result;
    }

    @property
    void amount(uint amount)
    {
        _charge["amount"] = JSONValue(amount);
    }
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
            "amount": 15000
        }
    `));

    assert(charge.id == "ch_12345");
    assert(charge.isPersisted == true);
    assert(charge.amount == 150_00);
}
