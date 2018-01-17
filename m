From: dhowells@redhat.com (David Howells)
Date: Wed, 17 Jan 2018 16:16:56 +0000
Subject: [PATCH 08/30] kexec_file: Restrict at runtime if the kernel is
	locked down
In-Reply-To: <20180111154445.duootisvanetnr24@dwarf.suse.cz>
References: <20180111154445.duootisvanetnr24@dwarf.suse.cz>
	<12880.1515674600@warthog.procyon.org.uk>
	<20180111115915.dejachty3l7fwpmf@dwarf.suse.cz>
	<151024863544.28329.2436580122759221600.stgit@warthog.procyon.org.uk>
	<151024869793.28329.4817577607302613028.stgit@warthog.procyon.org.uk>
	<13005.1515674877@warthog.procyon.org.uk>
Message-ID: <24245.1516205816@warthog.procyon.org.uk>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Jiri Bohac <jbohac@suse.cz> wrote:

> > Having said that, I do see your point, I think.  We should still let through
> > validly signed images, even if signatures aren't mandatory in lockdown mode.
> 
> yes, to be clear, the problem I'm trying to fix is:
> - without CONFIG_KEXEC_VERIFY_SIG kexec in a locked down kernel
>   will not work at all -> every distro that wants to support
>   secureboot will need to enable CONFIG_KEXEC_VERIFY_SIG;
> 
> - once CONFIG_KEXEC_VERIFY_SIG is enabled, kexec images need to
>   be signed even if secureboot is not used
>
> The problem is that CONFIG_KEXEC_VERIFY_SIG enables both the
> implementation and the enforcement of the signature checking.

Yep.  I understand that.

> What I'm proposing are new config options that allow a kernel to
> be compiled in such a way that:
> - kexec works even without signatures if secureboot is off
> - kexec works with secureboot but requires signed images

Agreed to both of those.  I also agree with making it possible to
configurationally require signatures, which your first patch does.

> The semantics should be the same as with signed modules, because
> requiring kexec signatures when you can load unsigned modules is
> futile. But with your original patchset, that's exactly what
> distro kernels will be doing when booted with secureboot off,
> MODULE_SIG_FORCE=n and KEXEC_VERIFY_SIG=y.

I should fix that.

David
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
