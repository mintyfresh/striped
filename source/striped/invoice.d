module striped.invoice;

import striped.charge;
import striped.object;

struct StripeInvoice
{
    mixin StripeObject!("invoice");

    mixin field!(bool, "autoAdvance", "auto_advance");
    mixin field!(string, "collectionMethod", "collection_method");
    mixin field!(string, "currency");
    mixin field!(string, "description");
    mixin field!(string, "hostedInvoiceUrl", "hosted_invoice_url");
    mixin field!(JSONValue, "metadata");
    mixin field!(string, "periodEnd", "period_end");
    mixin field!(string, "periodStart", "period_start");
    mixin field!(string, "status");
    mixin field!(int, "total");

    mixin expandable!(StripeCharge, "charge");

    @property
    bool isDraft() const
    {
        return status == "draft";
    }

    @property
    bool isOpen() const
    {
        return status == "open";
    }

    @property
    bool isPaid() const
    {
        return status == "paid";
    }

    @property
    bool isUncollectable() const
    {
        return status == "uncollectable";
    }

    @property
    bool isVoid() const
    {
        return status == "void";
    }
}
