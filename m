From: zohar@linux.vnet.ibm.com (Mimi Zohar)
Date: Wed, 28 Feb 2018 06:38:58 -0500
Subject: [PATCH v2 3/4] ima: fail signature verification based on policy
In-Reply-To: <20180227223545.GB18767@mail.hallyn.com>
References: <1519335184-17808-1-git-send-email-zohar@linux.vnet.ibm.com>
	<1519335184-17808-4-git-send-email-zohar@linux.vnet.ibm.com>
	<20180227223545.GB18767@mail.hallyn.com>
Message-ID: <1519817938.3737.72.camel@linux.vnet.ibm.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Tue, 2018-02-27 at 16:35 -0600, Serge E. Hallyn wrote:
> Quoting Mimi Zohar (zohar at linux.vnet.ibm.com):
> > This patch addresses the fuse privileged mounted filesystems in
> > environments which are unwilling to accept the risk of trusting the
> > signature verification and want to always fail safe, but are for
> > example using a pre-built kernel.
> > 
> > This patch defines a new builtin policy "unverifiable_sigs", which can
> 
> How about recalc_unverifiable_sigs?

Cute, I really like that name, but in this case we're failing the
signature verification.

> It's long, but unverifiable_sigs
> is  not clear about whether the intent is to accept or recalculate them.
> 
> (or fail_unverifiable_sigs like the flag)

Could we abbreviate it to "fail_usigs"? ?Or perhaps allow both
"fail_unverifiable_sigs" and "fail_usigs".

Mimi

> 
> > be specified on the boot command line as an argument to "ima_policy=".
> > 
> > Signed-off-by: Mimi Zohar <zohar@linux.vnet.ibm.com>
> > Cc: Miklos Szeredi <miklos@szeredi.hu>
> > Cc: Seth Forshee <seth.forshee@canonical.com>
> > Cc: Eric W. Biederman <ebiederm@xmission.com>
> > Cc: Dongsu Park <dongsu@kinvolk.io>
> > Cc: Alban Crequy <alban@kinvolk.io>
> > Cc: Serge E. Hallyn <serge@hallyn.com>
> > 
> > Changelog v2:
> > - address the fail safe environement
> > ---
> >  Documentation/admin-guide/kernel-parameters.txt |  8 +++++++-
> >  security/integrity/ima/ima_appraise.c           | 10 ++++++----
> >  security/integrity/ima/ima_main.c               |  3 ++-
> >  security/integrity/ima/ima_policy.c             |  5 +++++
> >  security/integrity/integrity.h                  |  1 +
> >  5 files changed, 21 insertions(+), 6 deletions(-)
> > 
> > diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> > index 1d1d53f85ddd..c655cd8dbaa0 100644
> > --- a/Documentation/admin-guide/kernel-parameters.txt
> > +++ b/Documentation/admin-guide/kernel-parameters.txt
> > @@ -1525,7 +1525,8 @@
> >  
> >  	ima_policy=	[IMA]
> >  			The builtin policies to load during IMA setup.
> > -			Format: "tcb | appraise_tcb | secure_boot"
> > +			Format: "tcb | appraise_tcb | secure_boot |
> > +				 unverifiable_sigs"
> >  
> >  			The "tcb" policy measures all programs exec'd, files
> >  			mmap'd for exec, and all files opened with the read
> > @@ -1540,6 +1541,11 @@
> >  			of files (eg. kexec kernel image, kernel modules,
> >  			firmware, policy, etc) based on file signatures.
> >  
> > +			The "unverifiable_sigs" policy forces file signature
> > +			verification failure on privileged mounted
> > +			filesystems with the SB_I_UNVERIFIABLE_SIGNATURE
> > +			flag.
> > +
> >  	ima_tcb		[IMA] Deprecated.  Use ima_policy= instead.
> >  			Load a policy which meets the needs of the Trusted
> >  			Computing Base.  This means IMA will measure all
> > diff --git a/security/integrity/ima/ima_appraise.c b/security/integrity/ima/ima_appraise.c
> > index f34901069e78..3034935e1eb3 100644
> > --- a/security/integrity/ima/ima_appraise.c
> > +++ b/security/integrity/ima/ima_appraise.c
> > @@ -304,11 +304,13 @@ int ima_appraise_measurement(enum ima_hooks func,
> >  out:
> >  	/*
> >  	 * File signatures on some filesystems can not be properly verified.
> > -	 * On these filesytems, that are mounted by an untrusted mounter,
> > -	 * fail the file signature verification.
> > +	 * On these filesytems, that are mounted by an untrusted mounter or
> > +	 * for systems not willing to accept the risk, fail the file signature
> > +	 * verification.
> >  	 */
> > -	if (inode->i_sb->s_iflags &
> > -	    (SB_I_IMA_UNVERIFIABLE_SIGNATURE | SB_I_UNTRUSTED_MOUNTER)) {
> > +	if ((inode->i_sb->s_iflags & SB_I_IMA_UNVERIFIABLE_SIGNATURE) &&
> > +	    ((inode->i_sb->s_iflags & SB_I_UNTRUSTED_MOUNTER) ||
> > +	     (iint->flags & IMA_FAIL_UNVERIFIABLE_SIGS))) {
> >  		status = INTEGRITY_FAIL;
> >  		cause = "unverifiable-signature";
> >  		integrity_audit_msg(AUDIT_INTEGRITY_DATA, inode, filename,
> > diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
> > index f550f25294a3..5d122daf5c8a 100644
> > --- a/security/integrity/ima/ima_main.c
> > +++ b/security/integrity/ima/ima_main.c
> > @@ -238,7 +238,8 @@ static int process_measurement(struct file *file, const struct cred *cred,
> >  	 */
> >  	if (test_and_clear_bit(IMA_CHANGE_XATTR, &iint->atomic_flags) ||
> >  	    ((inode->i_sb->s_iflags & SB_I_IMA_UNVERIFIABLE_SIGNATURE) &&
> > -	     !(inode->i_sb->s_iflags & SB_I_UNTRUSTED_MOUNTER))) {
> > +	     !(inode->i_sb->s_iflags & SB_I_UNTRUSTED_MOUNTER) &&
> > +	     !(action & IMA_FAIL_UNVERIFIABLE_SIGS))) {
> >  		iint->flags &= ~IMA_DONE_MASK;
> >  		iint->measured_pcrs = 0;
> >  	}
> > diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
> > index e3da29af2c16..ead3f7fe6998 100644
> > --- a/security/integrity/ima/ima_policy.c
> > +++ b/security/integrity/ima/ima_policy.c
> > @@ -188,6 +188,7 @@ __setup("ima_tcb", default_measure_policy_setup);
> >  
> >  static bool ima_use_appraise_tcb __initdata;
> >  static bool ima_use_secure_boot __initdata;
> > +static bool ima_fail_unverifiable_sigs __ro_after_init;
> >  static int __init policy_setup(char *str)
> >  {
> >  	char *p;
> > @@ -201,6 +202,8 @@ static int __init policy_setup(char *str)
> >  			ima_use_appraise_tcb = true;
> >  		else if (strcmp(p, "secure_boot") == 0)
> >  			ima_use_secure_boot = true;
> > +		else if (strcmp(p, "unverifiable_sigs") == 0)
> > +			ima_fail_unverifiable_sigs = true;
> >  	}
> >  
> >  	return 1;
> > @@ -390,6 +393,8 @@ int ima_match_policy(struct inode *inode, const struct cred *cred, u32 secid,
> >  		if (entry->action & IMA_APPRAISE) {
> >  			action |= get_subaction(entry, func);
> >  			action ^= IMA_HASH;
> > +			if (ima_fail_unverifiable_sigs)
> > +				action |= IMA_FAIL_UNVERIFIABLE_SIGS;
> >  		}
> >  
> >  		if (entry->action & IMA_DO_MASK)
> > diff --git a/security/integrity/integrity.h b/security/integrity/integrity.h
> > index 843ae23ba0ac..8224880935e0 100644
> > --- a/security/integrity/integrity.h
> > +++ b/security/integrity/integrity.h
> > @@ -35,6 +35,7 @@
> >  #define IMA_PERMIT_DIRECTIO	0x02000000
> >  #define IMA_NEW_FILE		0x04000000
> >  #define EVM_IMMUTABLE_DIGSIG	0x08000000
> > +#define IMA_FAIL_UNVERIFIABLE_SIGS	0x10000000
> >  
> >  #define IMA_DO_MASK		(IMA_MEASURE | IMA_APPRAISE | IMA_AUDIT | \
> >  				 IMA_HASH | IMA_APPRAISE_SUBMASK)
> > -- 
> > 2.7.5
> 

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
