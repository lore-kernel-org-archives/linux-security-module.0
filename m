From: denkenz@gmail.com (Denis Kenzior)
Date: Tue, 18 Sep 2018 00:24:50 -0500
Subject: [PATCH 00/22] KEYS: Support TPM-wrapped key and crypto ops
In-Reply-To: <14067.1537285833@warthog.procyon.org.uk>
References: <fdee179b-cfdf-7a2b-3193-e114f0084ecb@gmail.com>
	<153618445730.7946.10001472635835806478.stgit@warthog.procyon.org.uk>
	<1537253993.20009.62.camel@infradead.org>
	<14067.1537285833@warthog.procyon.org.uk>
Message-ID: <745318a0-51bd-be8f-2251-44701ad75830@gmail.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Hi David,

On 09/18/2018 10:50 AM, David Howells wrote:
> Denis Kenzior <denkenz@gmail.com> wrote:
> 
>>    openssl asn1parse -inform pem -in /tmp/privkey.2048.tpm -noout \
>> 			-out /tmp/privkey.2048.der
> 
> You can use "... -out - | ..." instead.

Aha! okay, that is even more elegant.  Your openssl-fu is better than 
mine :)

Regards,
-Denis
