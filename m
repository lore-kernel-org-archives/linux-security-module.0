From: jbohac@suse.cz (Jiri Bohac)
Date: Fri, 19 Jan 2018 13:54:25 +0100
Subject: [PATCH 08a/30] kexec_file: split KEXEC_VERIFY_SIG into KEXEC_SIG
	and KEXEC_SIG_FORCE
In-Reply-To: <24618.1516206864@warthog.procyon.org.uk>
References: <20180116193936.oiycvwlk5xy3gm77@dwarf.suse.cz>
	<20180111120157.23qceywzi6omvvkb@dwarf.suse.cz>
	<151024863544.28329.2436580122759221600.stgit@warthog.procyon.org.uk>
	<151024869793.28329.4817577607302613028.stgit@warthog.procyon.org.uk>
	<20180111115915.dejachty3l7fwpmf@dwarf.suse.cz>
	<4582.1516120311@warthog.procyon.org.uk>
	<24618.1516206864@warthog.procyon.org.uk>
Message-ID: <20180119125425.l72meyyc2qtrriwe@dwarf.suse.cz>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Wed, Jan 17, 2018 at 04:34:24PM +0000, David Howells wrote:
> Jiri Bohac <jbohac@suse.cz> wrote:
> 
> > > If sig_err is -EKEYREJECTED, -EKEYEXPIRED or -EKEYREVOKED then it must fail,
> > > even if the signature check isn't forced.
> > 
> > It wasn't my intention to fail in these cases. What additional
> > security does this bring? If simply stripping an invalid
> > signature from the image before loading will make it pass, why
> > should the image with an invalid signature be rejected?
> 
> If there is a signature, then if we're checking signatures, in my opinion we
> should check it - and fail if the signature can't be parsed, is revoked, we
> have a key and the signature doesn't match - or even if we run out of memory.

Key verification may and will fail for lots of reasons which is
just going to make a user's life harder. E.g. you want to kexec
an old kernel with an expired key. Or your date is just wrong and
you get -EKEYEXPIRED. And you don't care about the signing at
all; it's just compiled in because your distro also needs to work
with secureboot. As a user, you will have to debug what's wrong
for no good reason. And an actual attacker will just strip the
signature off the image and load it.

This makes no sense.
 
> The cases for which enforcement is required are when (a) there is no
> signature, (b) we don't support the algorithms used, or (c) we don't have a
> key.
> 
> If we're going to completely discard the result, why do your patches even
> bother to check the signature at all?

I thought that the debug message might be useful. E.g. when
you're testing a kernel and you see "kernel signature
verification failed" in dmesg then you know this would fail on a
system with secure boot. 

But if ignoring the return code seems like too bad a thing, I would
rather skip the signature checking if it's not going to be
enforced with lockdown or CONFIG_KEXEC_SIG_FORCE.

Also, only now I found that some of the error codes the crypto
code returns yield really confusing messages (e.g.
kexec_file_load of an unsigned kernel returns -ELIBBAD which
makes kexec exit with "kexec_file_load failed: Accessing a
corrupted shared library").
Maybe the error code could be unified to -EKEYREJECTED for all
sorts of key verification failures?

Thanks,

-- 
Jiri Bohac <jbohac@suse.cz>
SUSE Labs, Prague, Czechia

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
