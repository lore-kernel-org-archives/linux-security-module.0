From: roberto.sassu@huawei.com (Roberto Sassu)
Date: Wed, 24 May 2017 10:18:46 +0200
Subject: [Linux-ima-devel] [PATCH 0/7] IMA: new parser for
	ima_restore_measurement_list()
In-Reply-To: <08bd9fcb-d3ba-e76e-928e-f569e8a4be74@linux.vnet.ibm.com>
References: <20170516125347.10574-1-roberto.sassu@huawei.com>
	<4f5bc289-92cb-1ce2-4496-387efbb11769@linux.vnet.ibm.com>
	<42b629dd-0d1f-b066-03e4-c013d0891ba7@huawei.com>
	<4b536b04-0e61-aea4-fc27-8dd12f2e3a1b@linux.vnet.ibm.com>
	<3b204e09-c1c0-b3bc-90fe-a8dfb86baadc@huawei.com>
	<08bd9fcb-d3ba-e76e-928e-f569e8a4be74@linux.vnet.ibm.com>
Message-ID: <e7386c0d-332b-1d61-a927-ad9b9dcd1449@huawei.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On 5/23/2017 10:48 PM, Ken Goldman wrote:
> On 5/18/2017 5:38 AM, Roberto Sassu wrote:
>> On 5/17/2017 6:28 PM, Ken Goldman wrote:
>>> On 5/17/2017 3:25 AM, Roberto Sassu wrote:
>>>>
>>>> The format of digestN is: <algo name>:\0<digest value>, the same used
>>>> for the file digest.
>>>
>>> Since the format is changing from the SHA-1 log format anyway ...
>>>
>>> How do people feel about the colon and null terminated string format for
>>> algorithm identifiers?
>>>
>>> The TCG standard enumerations are uint16_t, and there is a registry of
>>> hash algorithms.
>>>
>>> As a consuming parser, it feels nice to know it's always 2 bytes and not
>>> have to worry about a missing colon or a missing nul terminator risking
>>> a buffer overflow.
>>
>> There cannot be buffer overflow, because the length of each digest
>> field is known.
>>
>> Roberto
>>
>
> I was not referring to the digest, but the digest algorithm.
>
> I wanted opinions on the colon and null terminated string format for
> algorithm identifiers.
>
> The TCG standard log uses the TCG standard enumerations.  They're always
> exactly 2 bytes.  Parsing is trivial.

I have two concerns regarding this:

is there a standard way to convert TPM_ALG_ to strings, like a function
exposed by the TSS? If not, suppose that a parser uses openssl to verify
the integrity of event data, by calculating the digest. Then,
the parser should maintain an association table between TPM_ALG_
and a string (the string will be passed to EVP_get_digestbyname()).
When a new TPM algorithm is added to the TCG registry, all parsers
should be modified to update the association table. If IMA sends
a string, only the crypto subsystem has to be updated.

The format I'm proposing for event data digests would be the same
of that used for file digests. Should IMA provide a list with
two different formats?

Roberto


> If IMA uses strings, the attacker can send, e.g., sha1: and not null
> terminate it.  A careful parser can go a byte at a time until it reaches
> a maximum length - if you specify a maximum length.  But it is an attack
> surface.  Is there a corresponding advantage?
>
>
> ------------------------------------------------------------------------------
> Check out the vibrant tech community on one of the world's most
> engaging tech sites, Slashdot.org! http://sdm.link/slashdot
> _______________________________________________
> Linux-ima-devel mailing list
> Linux-ima-devel at lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-ima-devel
>
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
