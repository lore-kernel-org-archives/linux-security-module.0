From: jbohac@suse.cz (Jiri Bohac)
Date: Thu, 11 Jan 2018 16:44:45 +0100
Subject: [PATCH 08/30] kexec_file: Restrict at runtime if the kernel is
	locked down
In-Reply-To: <13005.1515674877@warthog.procyon.org.uk>
References: <12880.1515674600@warthog.procyon.org.uk>
	<20180111115915.dejachty3l7fwpmf@dwarf.suse.cz>
	<151024863544.28329.2436580122759221600.stgit@warthog.procyon.org.uk>
	<151024869793.28329.4817577607302613028.stgit@warthog.procyon.org.uk>
	<13005.1515674877@warthog.procyon.org.uk>
Message-ID: <20180111154445.duootisvanetnr24@dwarf.suse.cz>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Thu, Jan 11, 2018 at 12:47:57PM +0000, David Howells wrote:
> > > I don't like the idea that the lockdown (which is a runtime
> > > thing) requires a compile time option (KEXEC_VERIFY_SIG) that
> > > forces the verification even when the kernel is then not locked
> > > down at runtime.
> > 
> > It doesn't.  The EPERM only triggers if:
> > 
> >  (1) File signatures aren't mandatory (ie. CONFIG_KEXEC_VERIFY_SIG) is not
> >      set, and
> > 
> >  (2) you're not using IMA appraisal to validate the file contents, and
> > 
> >  (3) lockdown mode is enabled.
> > 
> > If file signatures are mandatory or IMA appraisal is in use, then the lockdown
> > state doesn't need to be checked.
> 
> Having said that, I do see your point, I think.  We should still let through
> validly signed images, even if signatures aren't mandatory in lockdown mode.

yes, to be clear, the problem I'm trying to fix is:
- without CONFIG_KEXEC_VERIFY_SIG kexec in a locked down kernel
  will not work at all -> every distro that wants to support
  secureboot will need to enable CONFIG_KEXEC_VERIFY_SIG;

- once CONFIG_KEXEC_VERIFY_SIG is enabled, kexec images need to
  be signed even if secureboot is not used

The problem is that CONFIG_KEXEC_VERIFY_SIG enables both the
implementation and the enforcement of the signature checking.

What I'm proposing are new config options that allow a kernel to
be compiled in such a way that:
- kexec works even without signatures if secureboot is off
- kexec works with secureboot but requires signed images

The semantics should be the same as with signed modules, because
requiring kexec signatures when you can load unsigned modules is
futile. But with your original patchset, that's exactly what
distro kernels will be doing when booted with secureboot off,
MODULE_SIG_FORCE=n and KEXEC_VERIFY_SIG=y.

Thanks,

-- 
Jiri Bohac <jbohac@suse.cz>
SUSE Labs, Prague, Czechia

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
