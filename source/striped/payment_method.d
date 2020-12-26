module striped.payment_method;

import striped.address;
import striped.billing_details;
import striped.charge;
import striped.customer;
import striped.object;

struct StripePaymentMethod
{
    struct Alipay
    {
        mixin StripeObject!(UNTYPED_OBJECT);
    }

    struct AuBecsDebit
    {
        mixin StripeObject!(UNTYPED_OBJECT);

        mixin field!(string, "bsbNumber", "bsb_number");
        mixin field!(string, "fingerprint");
        mixin field!(string, "last4");
    }

    struct BacsDebit
    {
        mixin StripeObject!(UNTYPED_OBJECT);

        mixin field!(string, "fingerprint");
        mixin field!(string, "last4");
        mixin field!(string, "sortCode", "sort_code");
    }

    struct BanContract
    {
        mixin StripeObject!(UNTYPED_OBJECT);
    }

    struct Card
    {
        struct Checks
        {
            mixin StripeObject!(UNTYPED_OBJECT);

            mixin field!(string, "addressLine1Check", "address_line1_check");
            mixin field!(string, "addressPostalCodeCheck", "address_postal_code_check");
            mixin field!(string, "cvcCheck", "cvc_check");
        }

        struct GeneratedFrom
        {
            struct PaymentMethodDetails
            {
                struct CardPresent
                {
                    struct Receipt
                    {
                        mixin StripeObject!(UNTYPED_OBJECT);

                        mixin field!(string, "accountType", "account_type");
                        mixin field!(string, "applicationCryptogram", "application_cryptogram");
                        mixin field!(string, "applicationPreferredName", "application_preferred_name");
                        mixin field!(string, "authorizationCode", "authorization_code");
                        mixin field!(string, "authorizationResponseCode", "authorization_response_code");
                        mixin field!(string, "cardholderVerificationMethod", "cardholder_verification_method");
                        mixin field!(string, "dedicatedFileName", "dedicated_file_name");
                        mixin field!(string, "terminalVerificationResults", "terminal_verification_results");
                        mixin field!(string, "transactionStatusInformation", "transaction_status_information");
                    }

                    mixin StripeObject!(UNTYPED_OBJECT);

                    mixin field!(string, "brand");
                    mixin field!(string, "cardholderName", "cardholder_name");
                    mixin field!(string, "country");
                    mixin field!(string, "emvAuthData", "emv_auth_data");
                    mixin field!(int, "expMonth", "exp_month");
                    mixin field!(int, "expYear", "exp_year");
                    mixin field!(string, "fingerprint");
                    mixin field!(string, "funding");
                    mixin field!(string, "generatedCard", "generated_card");
                    mixin field!(string, "last4");
                    mixin field!(string, "network");
                    mixin field!(string, "readMethod", "read_method");

                    mixin embeddable!(Receipt, "receipt");
                }

                mixin StripeObject!(UNTYPED_OBJECT);

                mixin field!(string, "type");

                mixin embeddable!(CardPresent, "cardPresent", "card_present");
            }

            mixin StripeObject!(UNTYPED_OBJECT);

            mixin field!(string, "charge");
            mixin field!(string, "setupAttempt", "setup_attempt");

            mixin embeddable!(PaymentMethodDetails, "paymentMethodDetails", "payment_method_details");
        }

        struct Networks
        {
            mixin StripeObject!(UNTYPED_OBJECT);

            mixin field!(string[], "available");
            mixin field!(string, "preferred");
        }

        struct ThreeDSecureUsage
        {
            mixin StripeObject!(UNTYPED_OBJECT);

            mixin field!(bool, "supported");
        }

        struct Wallet
        {
            struct AmexExpressCheckout
            {
                mixin StripeObject!(UNTYPED_OBJECT);
            }

            struct ApplePay
            {
                mixin StripeObject!(UNTYPED_OBJECT);
            }

            struct GooglePay
            {
                mixin StripeObject!(UNTYPED_OBJECT);
            }

            struct Masterpass
            {
                mixin StripeObject!(UNTYPED_OBJECT);

                mixin field!(string, "email");
                mixin field!(string, "name");

                mixin embeddable!(StripeAddress, "billingAddress", "billing_address");
                mixin embeddable!(StripeAddress, "shippingAddress", "shipping_address");
            }

            struct SamsungPay
            {
                mixin StripeObject!(UNTYPED_OBJECT);
            }

            struct VisaCheckout
            {
                mixin StripeObject!(UNTYPED_OBJECT);

                mixin field!(string, "email");
                mixin field!(string, "name");

                mixin embeddable!(StripeAddress, "billingAddress", "billing_address");
                mixin embeddable!(StripeAddress, "shippingAddress", "shipping_address");
            }

            mixin StripeObject!(UNTYPED_OBJECT);

            mixin field!(string, "dynamicLast4");
            mixin field!(string, "type");
        }

        mixin StripeObject!(UNTYPED_OBJECT);

        mixin field!(string, "brand");
        mixin field!(string, "country");
        mixin field!(int, "expMonth");
        mixin field!(int, "expYear");
        mixin field!(string, "fingerprint");
        mixin field!(string, "funding");
        mixin field!(string, "last4");

        mixin embeddable!(Checks, "checks");
        mixin embeddable!(GeneratedFrom, "generatedFrom", "generated_from");
        mixin embeddable!(Networks, "networks");
        mixin embeddable!(ThreeDSecureUsage, "threeDSecureUsage", "three_d_secure_usage");
        mixin embeddable!(Wallet, "wallet");
    }

    struct CardPresent
    {
        mixin StripeObject!(UNTYPED_OBJECT);
    }

    struct Eps
    {
        mixin StripeObject!(UNTYPED_OBJECT);

        mixin field!(string, "bank");
    }

    struct Fpx
    {
        mixin StripeObject!(UNTYPED_OBJECT);

        mixin field!(string, "bank");
    }

    struct Giropay
    {
        mixin StripeObject!(UNTYPED_OBJECT);
    }

    struct Grabpay
    {
        mixin StripeObject!(UNTYPED_OBJECT);
    }

    struct Ideal
    {
        mixin StripeObject!(UNTYPED_OBJECT);

        mixin field!(string, "bank");
        mixin field!(string, "bic");
    }

    struct InteracPresent
    {
        mixin StripeObject!(UNTYPED_OBJECT);
    }

    struct Oxxo
    {
        mixin StripeObject!(UNTYPED_OBJECT);
    }

    struct P24
    {
        mixin StripeObject!(UNTYPED_OBJECT);

        mixin field!(string, "bank");
    }

    struct SepaDebit
    {
        struct GeneratedFrom
        {
            mixin StripeObject!(UNTYPED_OBJECT);

            mixin field!(string, "setupAttempt", "setup_attempt"); // TODO: Expandable SetupAttempt

            mixin expandable!(StripeCharge, "charge");
        }

        mixin StripeObject!(UNTYPED_OBJECT);

        mixin field!(string, "bankCode", "bank_code");
        mixin field!(string, "branchCode", "branch_code");
        mixin field!(string, "country");
        mixin field!(string, "fingerprint");
        mixin field!(string, "last4");

        mixin expandable!(GeneratedFrom, "generatedFrom", "generated_from");
    }

    struct Sofort
    {
        mixin StripeObject!(UNTYPED_OBJECT);

        mixin field!(string, "country");
    }

    mixin StripeObject!("payment_method");

    mixin identifier;

    mixin field!(int, "created");
    mixin field!(bool, "livemode");
    mixin field!(JSONValue, "metadata");
    mixin field!(string, "type");

    mixin embeddable!(StripeBillingDetails, "billingDetails", "billing_details");
    mixin embeddable!(Alipay, "alipay");
    mixin embeddable!(AuBecsDebit, "auBecsDebit", "au_becs_debit");
    mixin embeddable!(BacsDebit, "bacsDebit", "bacs_debit");
    mixin embeddable!(BanContract, "banContract", "ban_contract");
    mixin embeddable!(Card, "card");
    mixin embeddable!(CardPresent, "cardPresent", "card_present");
    mixin embeddable!(Eps, "eps");
    mixin embeddable!(Fpx, "fpx");
    mixin embeddable!(Giropay, "giropay");
    mixin embeddable!(Grabpay, "grabpay");
    mixin embeddable!(Ideal, "ideal");
    mixin embeddable!(InteracPresent, "interacPresent", "interac_present");
    mixin embeddable!(Oxxo, "oxxo");
    mixin embeddable!(P24, "p24");
    mixin embeddable!(SepaDebit, "sepaDebit", "sepa_debit");
    mixin embeddable!(Sofort, "sofort");

    mixin expandable!(StripeCustomer, "customer");
}
