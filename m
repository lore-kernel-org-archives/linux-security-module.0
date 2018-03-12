From: zohar@linux.vnet.ibm.com (Mimi Zohar)
Date: Mon, 12 Mar 2018 15:32:39 -0400
Subject: [PATCH v3 3/4] ima: fail signature verification based on policy
In-Reply-To: <20180312192806.GD29878@mail.hallyn.com>
References: <1520540650-7451-1-git-send-email-zohar@linux.vnet.ibm.com>
	<1520540650-7451-4-git-send-email-zohar@linux.vnet.ibm.com>
	<20180312192806.GD29878@mail.hallyn.com>
Message-ID: <1520883159.3547.156.camel@linux.vnet.ibm.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Mon, 2018-03-12 at 14:28 -0500, Serge E. Hallyn wrote:
> Quoting Mimi Zohar (zohar at linux.vnet.ibm.com):
> > This patch addresses the fuse privileged mounted filesystems in
> > environments which are unwilling to accept the risk of trusting the
> > signature verification and want to always fail safe, but are for example
> > using a pre-built kernel.
> > 
> > This patch defines a new builtin policy named "fail_securely", which can
> > be specified on the boot command line as an argument to "ima_policy=".
> > 
> > Signed-off-by: Mimi Zohar <zohar@linux.vnet.ibm.com>
> > Cc: Miklos Szeredi <miklos@szeredi.hu>
> > Cc: Seth Forshee <seth.forshee@canonical.com>
> > Cc: Eric W. Biederman <ebiederm@xmission.com>
> > Cc: Dongsu Park <dongsu@kinvolk.io>
> > Cc: Alban Crequy <alban@kinvolk.io>
> > Cc: Serge E. Hallyn <serge@hallyn.com>
> 
> Acked-by: Serge Hallyn <serge@hallyn.com>

Thanks!

> 
> but,
> 
> > 
> > ---
> > Changelog v3:
> > - Rename the builtin policy name
> > 
> > Changelog v2:
> > - address the fail safe environement
> > 
> >  Documentation/admin-guide/kernel-parameters.txt |  8 +++++++-
> >  security/integrity/ima/ima_appraise.c           | 11 ++++++-----
> >  security/integrity/ima/ima_main.c               |  3 ++-
> >  security/integrity/ima/ima_policy.c             |  5 +++++
> >  security/integrity/integrity.h                  |  1 +
> >  5 files changed, 21 insertions(+), 7 deletions(-)
> > 
> > diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> > index 1d1d53f85ddd..2cc17dc7ab84 100644
> > --- a/Documentation/admin-guide/kernel-parameters.txt
> > +++ b/Documentation/admin-guide/kernel-parameters.txt
> > @@ -1525,7 +1525,8 @@
> >  
> >  	ima_policy=	[IMA]
> >  			The builtin policies to load during IMA setup.
> > -			Format: "tcb | appraise_tcb | secure_boot"
> > +			Format: "tcb | appraise_tcb | secure_boot |
> > +				 fail_securely"
> >  
> >  			The "tcb" policy measures all programs exec'd, files
> >  			mmap'd for exec, and all files opened with the read
> > @@ -1540,6 +1541,11 @@
> >  			of files (eg. kexec kernel image, kernel modules,
> >  			firmware, policy, etc) based on file signatures.
> >  
> > +			The "fail_securely" policy forces file signature
> > +			verification failure also on privileged mounted
> > +			filesystems with the SB_I_UNVERIFIABLE_SIGNATURE
> > +			flag.
> > +
> >  	ima_tcb		[IMA] Deprecated.  Use ima_policy= instead.
> >  			Load a policy which meets the needs of the Trusted
> >  			Computing Base.  This means IMA will measure all
> > diff --git a/security/integrity/ima/ima_appraise.c b/security/integrity/ima/ima_appraise.c
> > index 4bafb397ee91..3034935e1eb3 100644
> > --- a/security/integrity/ima/ima_appraise.c
> > +++ b/security/integrity/ima/ima_appraise.c
> > @@ -304,12 +304,13 @@ int ima_appraise_measurement(enum ima_hooks func,
> >  out:
> >  	/*
> >  	 * File signatures on some filesystems can not be properly verified.
> > -	 * On these filesytems, that are mounted by an untrusted mounter,
> > -	 * fail the file signature verification.
> > +	 * On these filesytems, that are mounted by an untrusted mounter or
> 
> How about "When such filesystems are mounted by an untrusted mounter or
> on a system not willing to accept such a risk, ..." ?
> 
> (also filesytems is misspelled :)

It definitely sounds better.

> 
> > +	 * for systems not willing to accept the risk, fail the file signature
> > +	 * verification.
> >  	 */
> 

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
