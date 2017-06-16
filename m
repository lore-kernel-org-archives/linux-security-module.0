From: john.johansen@canonical.com (John Johansen)
Date: Fri, 16 Jun 2017 12:28:03 -0700
Subject: Is there a generic LSM/kernel ABI analogous to getcon_raw() and
	aa_getcon()?
In-Reply-To: <20170616161357.4nyqrye7ja5nsl7h@archetype.pseudorandom.co.uk>
References: <20170613174519.nmrdglusytvjtdem@archetype.pseudorandom.co.uk>
	<cc28a551-08b5-aeb4-382a-9ad86f51ddac@schaufler-ca.com>
	<20170614114430.ooti2gqxllkqz2fe@archetype.pseudorandom.co.uk>
	<d95670e5-837e-2cd3-7bf1-424a3cd89eec@schaufler-ca.com>
	<20170616161357.4nyqrye7ja5nsl7h@archetype.pseudorandom.co.uk>
Message-ID: <90e35675-1494-6b5d-362c-8600c32415e1@canonical.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On 06/16/2017 09:13 AM, Simon McVittie wrote:
> On Wed, 14 Jun 2017 at 09:06:38 -0700, Casey Schaufler wrote:

> 
>> Upstream only SELinux and Smack provide both /proc/.../current
>> and SO_PEERSEC. They provide label strings that can be compared.
>> AppArmor does not support SO_PEERSEC as of 4.12. So as of today,
>> there isn't a problem. Or am I missing something?
> 
> What I would need, in order to do what I had hoped, would be a general
> statement from the LSM (infrastructure) maintainers something along the
> lines of: "If an LSM has labels in both /proc/.../current and SO_PEERSEC
> and they differ, then that LSM is wrong and can safely be ignored". Or,
> perhaps: "If an LSM has labels in /proc/.../current that end with a
> newline, normalizing by stripping that newline does not change the
> meaning; and if the label in /proc/.../current (after stripping a possible
> newline) differs from the label in SO_PEERSEC, then that LSM is wrong
> and can safely be ignored".
> 
> (Similar to the way my last thread on this list ended with consensus
> that whether an LSM label in SO_PEERSEC includes a "\0" in its length
> or not is not significant, and normalizing by adding or removing a
> single trailing "\0" does not change the meaning.)
> 
This is possibly a constraint that could be agreed on and added. Currently
only 3 lsms (selinux, smack, apparmor) use the getprocattr interface.
And 2 lsms upstream (selinux, smack) use SO_PEERSEC. With apparmor adding
support for it upstream soon.

>From experience, apparmor will not be adding \n to the end of the value
from SO_PEERSEC, as it broke some services. But I have been digging and
testing and it looks like we are good dropping the trailing \n from
the proc interface.

And I can state that the current output of the proc interface and
SO_PEERSEC should be the same except for the trailing \n, which
can (and is in libapparmor) thrown away.

So today we have all 3 users of the interfaces with output that meets your
requirement modulo the trailing garbage, and apparmor is going to bring
its use of proc intro compliance so that all 3 LSMs meet the requested
requirement of the output from the proc interface and SO_PEERSEC being
the same.

So while the interfaces do not currently guarantee the output of the
two interfaces is the same, since no LSMs use the interfaces
differently than requested I don't think its unreasonable to ask the
community to add the additional requirement that procgetattr and
SO_PEERSEC output match.

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
