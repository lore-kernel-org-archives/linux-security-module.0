From: dhowells@redhat.com (David Howells)
Date: Thu, 11 Jan 2018 12:43:20 +0000
Subject: [PATCH 08/30] kexec_file: Restrict at runtime if the kernel is
	locked down
In-Reply-To: <20180111115915.dejachty3l7fwpmf@dwarf.suse.cz>
References: <20180111115915.dejachty3l7fwpmf@dwarf.suse.cz>
	<151024863544.28329.2436580122759221600.stgit@warthog.procyon.org.uk>
	<151024869793.28329.4817577607302613028.stgit@warthog.procyon.org.uk>
Message-ID: <12880.1515674600@warthog.procyon.org.uk>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Jiri Bohac <jbohac@suse.cz> wrote:

> I don't like the idea that the lockdown (which is a runtime
> thing) requires a compile time option (KEXEC_VERIFY_SIG) that
> forces the verification even when the kernel is then not locked
> down at runtime.

It doesn't.  The EPERM only triggers if:

 (1) File signatures aren't mandatory (ie. CONFIG_KEXEC_VERIFY_SIG) is not
     set, and

 (2) you're not using IMA appraisal to validate the file contents, and

 (3) lockdown mode is enabled.

If file signatures are mandatory or IMA appraisal is in use, then the lockdown
state doesn't need to be checked.

David
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
