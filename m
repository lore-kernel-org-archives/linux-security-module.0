From: casey@schaufler-ca.com (Casey Schaufler)
Date: Wed, 31 May 2017 08:22:34 -0700
Subject: [RFC 0/3] WhiteEgret LSM module
In-Reply-To: <CANA3KFXUTSe8XyU1S+WgjgCtgKSiENp9EJZEaAc7PkVO_tgKqQ@mail.gmail.com>
References: <20170530111157.5196-1-masanobu2.koike@toshiba.co.jp>
	<20170530205002.GA9841@srcf.ucam.org>
	<CANA3KFXUTSe8XyU1S+WgjgCtgKSiENp9EJZEaAc7PkVO_tgKqQ@mail.gmail.com>
Message-ID: <0e0aa575-263a-893a-7ade-f2dc7ce679c2@schaufler-ca.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org



On 5/31/2017 3:59 AM, Peter Dolding wrote:
> ...
>
> Like you see here in Australian government policy there is another
> thing called whitelisted.
> https://www.asd.gov.au/publications/protect/top_4_mitigations_linux.htm
> Matthew Garrett you might want to call IMA whitelisting Australian
> government for one does not agree.  IMA is signed.   The difference
> between signed and white-listed is you might have signed a lot more
> than what a particular system is white-listed to allowed used.
>
To be clear, I'm all for a security module to support this policy.
As the explicit requirement is for a whitelist, as opposed to allowing
for a properly configured system*, you can't use any of the existing
technologies to meet it. This kind of thing** is why we have a LSM
infrastructure.

Unfortunately, the implementation proposed has very serious issues.
You can't do access control from userspace. You can't count on
identifying programs strictly by pathname. It's much more complicated
than it needs to be for the task.

Suggestion:

Create an security module that looks for the attribute

	security.WHITELISTED

on things being executed/mmapped and denys it if the attribute isn't
present. Create a program (whitelistd) that reads /etc/whitelist.conf
and scans the system to ensure that only things on the list have the
attribute. Or, download the list into the kernel and only allow the
attribute to be set on files on the list. That's harder, what with
rename, links, symlinks, mounts, chroot and containers. I wrote a
security module (Datastate) back in 2010 that did much the same thing
for a different purpose.

Please, don't give up because of negative initial feedback. Believe
it or not, the community (well, most of us, anyway) is willing to
help to the extent possible.


---
*  A script that checks for the 'x' mode bit on files should suffice.
** A return to the heady days of the Orange Book?

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
