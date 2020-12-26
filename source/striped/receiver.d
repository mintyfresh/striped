module striped.receiver;

import striped.object;

struct StripeReceiver
{
    mixin StripeObject!(UNTYPED_OBJECT);

    mixin field!(string, "address");
    mixin field!(int, "amountCharged", "amount_charged");
    mixin field!(int, "amountReceived", "amount_received");
    mixin field!(int, "amountReturned", "amount_returned");
    mixin field!(string, "refundAttributesMethod", "refund_attributes_method");
    mixin field!(string, "refundAttributesStatus", "refund_attributes_status");
}
