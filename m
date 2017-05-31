From: mkayaalp@linux.vnet.ibm.com (Mehmet Kayaalp)
Date: Wed, 31 May 2017 11:36:16 -0400
Subject: [RFC 0/3] WhiteEgret LSM module
In-Reply-To: <CANA3KFXUTSe8XyU1S+WgjgCtgKSiENp9EJZEaAc7PkVO_tgKqQ@mail.gmail.com>
References: <20170530111157.5196-1-masanobu2.koike@toshiba.co.jp>
	<20170530205002.GA9841@srcf.ucam.org>
	<CANA3KFXUTSe8XyU1S+WgjgCtgKSiENp9EJZEaAc7PkVO_tgKqQ@mail.gmail.com>
Message-ID: <88D2080F-FEFA-4535-ACF1-01A584F469D9@linux.vnet.ibm.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org


> On May 31, 2017, at 6:59 AM, Peter Dolding <oiaohm@gmail.com> wrote:
> 
> Number 1 we need to split the idea of signed and whitelisted.   IMA is
> signed should not be confused with white-listed.    You will find
> policies stating whitelist and signed as two different things.

IMA-appraisal can do both. If the securtiy.ima extended attribute
of the file is a hash and not a signature, then it is whitelisting.

> Like you see here in Australian government policy there is another
> thing called whitelisted.
> https://www.asd.gov.au/publications/protect/top_4_mitigations_linux.htm
> Matthew Garrett you might want to call IMA whitelisting Australian
> government for one does not agree.  IMA is signed.   The difference
> between signed and white-listed is you might have signed a lot more
> than what a particular system is white-listed to allowed used.

I doubt the Australian government is an authority on Linux features.
IMA-appraisal can be set to "fix" mode with a boot parameter. If the 
policy covers what you want to whitelist (e.g. files opened by user x), 
and then when those files are accessed, the kernel writes out the hash. 
Then, you can switch to "enforce" mode to allow only files with hashes.

Also, you can achieve the same thing by signing all whitelisted 
files and add the certificate to .ima keyring and throwing away the
signing key.

> The feature need to include in it name whitelisting or just like the
> Australian Department of Defence other parties will mark Linux has not
> having this feature.

I guess we need to advertise IMA-appraisal better.

> Whitelist is program name/path and checksum/s.   If the file any more
> than that is now not a Whitelist but a Security Policy Enforcement or
> signing.   Whitelist and blacklists are meant to be simple things.
> This is also why IMA fails and is signed to too complete to be a basic
> Whitelist.

When you work out all the little details, you arrive at IMA-appraisal.
You have to consider how the scheme is bootstrapped and how it
is protected against the root. IMA-appraisal either relies on a boot
parameter and write-once policy, or the trusted keyrings.

> Peter Dolding.

Mehmet

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
