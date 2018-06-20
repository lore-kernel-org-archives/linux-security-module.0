From: mail@maciej.szmigiero.name (Maciej S. Szmigiero)
Date: Wed, 20 Jun 2018 14:24:54 +0200
Subject: [PATCH v2][RESEND] X.509: unpack RSA signatureValue field from
	BIT STRING
In-Reply-To: <80e95323-eb7f-6af3-ad05-f174c69fb948@maciej.szmigiero.name>
References: <04f372f3-bc26-c629-2269-0e5d258f9d8f@maciej.szmigiero.name>
	<80e95323-eb7f-6af3-ad05-f174c69fb948@maciej.szmigiero.name>
Message-ID: <9a9bfd23-d7be-7f16-925e-5fe00cbfba9f@maciej.szmigiero.name>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On 02.06.2018 21:12, Maciej S. Szmigiero wrote:
> On 19.05.2018 14:23, Maciej S. Szmigiero wrote:
>> The signatureValue field of a X.509 certificate is encoded as a BIT STRING.
>> For RSA signatures this BIT STRING is of so-called primitive subtype, which
>> contains a u8 prefix indicating a count of unused bits in the encoding.
>>
>> We have to strip this prefix from signature data, just as we already do for
>> key data in x509_extract_key_data() function.
>>
>> This wasn't noticed earlier because this prefix byte is zero for RSA key
>> sizes divisible by 8. Since BIT STRING is a big-endian encoding adding zero
>> prefixes has no bearing on its value.
>>
>> The signature length, however was incorrect, which is a problem for RSA
>> implementations that need it to be exactly correct (like AMD CCP).
> 
> Any progress here?
> This simple patch has already been submitted 3 times in last 3+ months...
> 

A friendly ping here.

@AMD people:
Without this patch, in-kernel X.509 certificate verification is broken
on AMD CCP RSA implementation.

For example, loading wireless regulatory database gives the following
errors:
> [   21.310361] cfg80211: Problem loading in-kernel X.509 certificate (-22)
> [   21.351717] cfg80211: loaded regulatory.db is malformed or signature is missing/invalid

Kernel modules signature verification probably has similar problem, too.

That's why it would be nice if you could ack this patch, please.

Maciej
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
