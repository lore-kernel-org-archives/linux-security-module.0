From: tytso@mit.edu (Theodore Ts'o)
Date: Tue, 19 Sep 2017 21:16:42 -0400
Subject: [kernel-hardening] Re: [PATCH v4] security/keys: rewrite all of
	big_key crypto
In-Reply-To: <CACXcFmmBzHu-9sCs+gJDbjeR4MTdOfMtUaBr+YjkwyfFquQMBA@mail.gmail.com>
References: <20170916130034.17706-1-Jason@zx2c4.com>
	<2681038.03lnYPhpsa@tauon.chronox.de>
	<CAHmME9p6uq0ELtgxB94bc4bUppa7UogWSEgj_9o8p2xXQfrz5A@mail.gmail.com>
	<20170919133959.5fgtioyonlsdyjf5@thunk.org>
	<CACXcFmmBzHu-9sCs+gJDbjeR4MTdOfMtUaBr+YjkwyfFquQMBA@mail.gmail.com>
Message-ID: <20170920011642.cczekznqebf2zq5u@thunk.org>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Tue, Sep 19, 2017 at 03:04:29PM -0400, Sandy Harris wrote:
> On the other hand, I do not see why the driver should not
> use a FIPS-compliant PRNG where it can. This would make
> things easier for anyone who does seek certification. One
> of the big distro vendors? A gov't department or contractor
> that wants to use Linux? A corporation's sys admin or
> security reviewer? Stefan?

First, making it easier for a sysadmin to seek certification is
creating an attractive nuisance.  That means that after said company
sinks $100,000+ into getting a certification, they will be hesitant to
take the kernel update to fix that zero-day bug, less it causes them
to lose that certification.

Secondly, I've worked with a defense contractor wanting to use (and
did use) Linux.  Specifically, on the Zumwalt class destroyer, DD-21,
although back when I worked on it was the DD(X) program.  I can assure
you the fact that /dev/random wasn't FIPS certified wasn't a problem
with either Raytheon or the US Navy.  Really.  If you're really
serious about crypto, and you do government work, it will be type 1
ciphers implemented in hardware, courtesy of the NSA.

So really.  You can use Linux without getting FIPS certification.
Lots of copies of Linux are used in the government already, without
FIPS certification.

> I cannot see much downside to this. Is the current PRNG
> more efficient? More easily maintained? Is it still the case
> that random(4) must use only hashes, not ciphers, to
> avoid restrictions under export laws?

Linux is now using a Chacha20 based random number generator, much like
OpenBSD.  It's stream cipher-based CSPRNG, which is much more
efficient than a block cipher or HMAC based DRBG.  Unfortunately, it's
also not one of the types defined in NIST 800-90A rev 1.

       	     	     	     	     	 - Ted




--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
