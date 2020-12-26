module striped.list;

import striped.object;

struct StripeList(ElementType)
{
    mixin StripeObject!("list");

    mixin field!(bool, "hasMore", "has_more");
    mixin field!(string, "url");

    mixin embeddable!(ElementType[], "data");
}

unittest
{
    import striped.card : StripeCard;
    import striped.client : StripeClient;

    import std.json : parseJSON;

    const client = StripeClient("sk_test_1");
    const list   = StripeList!(StripeCard)(client, parseJSON(`
        {
            "object": "list",
            "data": [
                {
                    "object": "card",
                    "id": "card_1234"
                }
            ]
            
        }
    `));

    assert(!list.data.isNull);

    const cards = list.data.get;
    assert(cards.length == 1);
    assert(cards[0].id == "card_1234");
}
