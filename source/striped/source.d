module striped.source;

import striped.code_verification;
import striped.object;
import striped.receiver;

struct StripeSource
{
    mixin StripeObject!("source");

    mixin identifier;

    mixin field!(int, "amount");
    mixin field!(string, "clientSecret", "client_secret");
    mixin field!(int, "created");
    mixin field!(string, "currency");
    mixin field!(string, "customer");
    mixin field!(string, "flow");
    mixin field!(bool, "livemode");
    mixin field!(JSONValue, "metadata");
    mixin field!(string, "statementDescriptor", "statement_descriptor");
    mixin field!(string, "status");
    mixin field!(string, "type");
    mixin field!(string, "usage");

    mixin embeddable!(StripeCodeVerification, "codeVerification", "code_verification");
    mixin embeddable!(StripeReceiver, "receiver");
}
