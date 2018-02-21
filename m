From: dhowells@redhat.com (David Howells)
Date: Wed, 21 Feb 2018 16:20:51 +0000
Subject: [PATCH 08a/30] kexec_file: split KEXEC_VERIFY_SIG into KEXEC_SIG
	and KEXEC_SIG_FORCE
In-Reply-To: <20180119125425.l72meyyc2qtrriwe@dwarf.suse.cz>
References: <20180119125425.l72meyyc2qtrriwe@dwarf.suse.cz>
	<20180116193936.oiycvwlk5xy3gm77@dwarf.suse.cz>
	<20180111120157.23qceywzi6omvvkb@dwarf.suse.cz>
	<151024863544.28329.2436580122759221600.stgit@warthog.procyon.org.uk>
	<151024869793.28329.4817577607302613028.stgit@warthog.procyon.org.uk>
	<20180111115915.dejachty3l7fwpmf@dwarf.suse.cz>
	<4582.1516120311@warthog.procyon.org.uk>
	<24618.1516206864@warthog.procyon.org.uk>
Message-ID: <23576.1519230051@warthog.procyon.org.uk>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Jiri Bohac <jbohac@suse.cz> wrote:

> Key verification may and will fail for lots of reasons which is
> just going to make a user's life harder. E.g. you want to kexec
> an old kernel with an expired key. Or your date is just wrong and
> you get -EKEYEXPIRED.

Note that we can't check for expired keys as we can't trust the system clock
to be correct at this point.

> Also, only now I found that some of the error codes the crypto
> code returns yield really confusing messages (e.g.
> kexec_file_load of an unsigned kernel returns -ELIBBAD which
> makes kexec exit with "kexec_file_load failed: Accessing a
> corrupted shared library").

Yeah, that should be fixed.

> Maybe the error code could be unified to -EKEYREJECTED for all
> sorts of key verification failures?

Things like ENOMEM and EINTR definitely need to stay separate (not that I
allow interruption at the moment).

ENOKEY (couldn't find matching key), EINVAL (didn't recognise identifier),
ENOPKG (couldn't find a crypto algo) and EBADMSG (couldn't parse signature)
are arguable.  I think there's a valid case for treating ENOKEY, EINVAL and
ENOPKG differently to EKEYREJECTED - more so for ENOKEY.  In my opinion,
ENOKEY, EINVAL and ENOPKG are not fatal errors if we're not enforcing
signature checking, but EKEYREJECTED and EBADMSG are.

David
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
