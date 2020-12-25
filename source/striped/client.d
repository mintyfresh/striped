module striped.client;

import std.algorithm;

immutable string[] sandboxKeyPrefixes = [
    "pk_test_",
    "sk_test_"
];

struct StripeClient
{
private:
    string _key;

public:
    this(string key)
    {
        _key = key;
    }

    @property
    string key()
    {
        return _key;
    }

    @property
    bool isSandbox()
    {
        foreach (prefix; sandboxKeyPrefixes)
        {
            if (_key.startsWith(prefix))
            {
                return true;
            }
        }

        return false;
    }

    @property
    bool isPublic()
    {
        return _key.startsWith("pk_");
    }

    @property
    bool isSecret()
    {
        return _key.startsWith("sk_");
    }
}
