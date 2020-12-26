module striped.code_verification;

import striped.object;

struct StripeCodeVerification
{
    mixin StripeObject!(UNTYPED_OBJECT);

    mixin field!(int, "attemptsRemaining", "attempts_remaining");
    mixin field!(string, "status");

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
