From: jbohac@suse.cz (Jiri Bohac)
Date: Thu, 11 Jan 2018 12:59:15 +0100
Subject: [PATCH 08/30] kexec_file: Restrict at runtime if the kernel is
	locked down
In-Reply-To: <151024869793.28329.4817577607302613028.stgit@warthog.procyon.org.uk>
References: <151024863544.28329.2436580122759221600.stgit@warthog.procyon.org.uk>
	<151024869793.28329.4817577607302613028.stgit@warthog.procyon.org.uk>
Message-ID: <20180111115915.dejachty3l7fwpmf@dwarf.suse.cz>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Hi,

sorry for replying to such an old thread.

On Thu, Nov 09, 2017 at 05:31:38PM +0000, David Howells wrote:
> When KEXEC_VERIFY_SIG is not enabled, kernel should not load images through
> kexec_file systemcall if the kernel is locked down unless IMA can be used
> to validate the image.

I don't like the idea that the lockdown (which is a runtime
thing) requires a compile time option (KEXEC_VERIFY_SIG) that
forces the verification even when the kernel is then not locked
down at runtime.

Distribution kernels will then have KEXEC_VERIFY_SIG on and
everyone will need signed kexec images even when totally
uninterested in secureboot.

So instead of this patch, I propose the two followup patches that
split KEXEC_VERIFY_SIG into KEXEC_SIG and KEXEC_SIG_FORCE just as
we have with modules:

[PATCH 08a/30] kexec_file: split KEXEC_VERIFY_SIG into KEXEC_SIG and KEXEC_SIG_FORCE
[PATCH 08b/30] kexec_file: Restrict at runtime if the kernel is locked down

Lockdown would not require KEXEC_SIG_FORCE but when enabled it
would check the signature.

Thanks,

-- 
Jiri Bohac <jbohac@suse.cz>
SUSE Labs, Prague, Czechia

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
