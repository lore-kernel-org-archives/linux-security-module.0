From: ebiederm@xmission.com (Eric W. Biederman)
Date: Mon, 19 Feb 2018 15:47:45 -0600
Subject: [PATCH v1 1/2] ima: fail signature verification on untrusted
	filesystems
In-Reply-To: <1519053483-18396-2-git-send-email-zohar@linux.vnet.ibm.com>
	(Mimi Zohar's message of "Mon, 19 Feb 2018 10:18:02 -0500")
References: <1519053483-18396-1-git-send-email-zohar@linux.vnet.ibm.com>
	<1519053483-18396-2-git-send-email-zohar@linux.vnet.ibm.com>
Message-ID: <87zi44mz26.fsf@xmission.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Mimi Zohar <zohar@linux.vnet.ibm.com> writes:

> Files on untrusted filesystems, such as fuse, can change at any time,
> making the measurement(s) and by extension signature verification
> meaningless.

Filesystems with servers?
Remote filesystems?
Perhaps unexpected changes.

Untrusted sounds a bit harsh, and I am not certain it quite captures
what you are looking to avoid.

Does proc count?
Does sysfs count?
Does nfs count?

> FUSE can be mounted by unprivileged users either today with fusermount
> installed with setuid, or soon with the upcoming patches to allow FUSE
> mounts in a non-init user namespace.

There is one other way to mount a fuse filesystem and I feel it should
be considered int he mix.  Mounting a filesystem as root.  Where you
trust the server as much as you would trust an in kernel filesystem.  So
if the fuse protocol provides enough information it will be as safe to
trust as any other filesystem.

> This patch differentiates between the new unprivileged non-init mounted
> filesystems and everything else, by always failing file signature
> verification on unprivileged non-init mounted untrusted filesystems, but
> only failing everything else based on policy to avoid breaking existing
> systems.

Why the differentiation?

>From the previous conversation it feels like this is a differentiation
just because there is a chance of breaking existing users.

At the same time my understanding from the earlier conversation is that
you have no reason to suspect those users actually exist.

So I ask again.  Why differentiate?  Why have the complication?

There are two cases I can see for not trusting a filesystem here:

a) The protocol (like at least early nfs) does not provide enough
   information to know when the file changed on the server.  So caching
   an ima result can not be reliable.

b) The server is potentially hostile/malicious and may speak the
   protocol improperly in order to get around ima signatures (assuming
   the protocol is good enough).

Right now I am concerned the the patches are conflating those two cases.

Especially for cases where fuse is implementing a local filesystem that
root trusts (say ntfs-3g), and the mount is made by root (not
fusermount), I don't see an obvious reason for ima not to trust such
a filesystem.


> This patch defines a new sb->s_iflags option named SB_I_IMA_UNTRUSTED_FS
> and a new builtin IMA policy named "untrusted_fs".

This patch does make it clear what you are implementing but I am not yet
clear on the reasons for the various pieces.

Eric

>
> Signed-off-by: Mimi Zohar <zohar@linux.vnet.ibm.com>
> Cc: Miklos Szeredi <miklos@szeredi.hu>
> Cc: Seth Forshee <seth.forshee@canonical.com>
> Cc: Eric W. Biederman <ebiederm@xmission.com>
> Cc: Dongsu Park <dongsu@kinvolk.io>
> Cc: Alban Crequy <alban@kinvolk.io>
> Cc: Serge E. Hallyn <serge@hallyn.com>
>
> ---
> Changelog v1:
> - Merged the unprivileged and privileged patches.
> - Dropped IMA fsname support.
> - Introduced a new IMA builtin policy named "untrusted_fs".
> - Replaced fs_type flag with sb->s_iflags flag.
>
>  Documentation/admin-guide/kernel-parameters.txt |  6 +++++-
>  include/linux/fs.h                              |  1 +
>  security/integrity/ima/ima_appraise.c           | 16 +++++++++++++++-
>  security/integrity/ima/ima_policy.c             |  5 +++++
>  security/integrity/integrity.h                  |  1 +
>  5 files changed, 27 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index 90cefbddf1ed..f9eb24cea9a6 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -1522,7 +1522,7 @@
>  
>  	ima_policy=	[IMA]
>  			The builtin policies to load during IMA setup.
> -			Format: "tcb | appraise_tcb | secure_boot"
> +			Format: "tcb | appraise_tcb | secure_boot | untrusted_fs"
>  
>  			The "tcb" policy measures all programs exec'd, files
>  			mmap'd for exec, and all files opened with the read
> @@ -1537,6 +1537,10 @@
>  			of files (eg. kexec kernel image, kernel modules,
>  			firmware, policy, etc) based on file signatures.
>  
> +			The "untrusted_fs" policy fails the file signature
> +			verification on privileged mounted untrusted
> +			filesystems.
> +
>  	ima_tcb		[IMA] Deprecated.  Use ima_policy= instead.
>  			Load a policy which meets the needs of the Trusted
>  			Computing Base.  This means IMA will measure all
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index 2a815560fda0..1d3fe0fe49ee 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -1320,6 +1320,7 @@ extern int send_sigurg(struct fown_struct *fown);
>  
>  /* sb->s_iflags to limit user namespace mounts */
>  #define SB_I_USERNS_VISIBLE		0x00000010 /* fstype already mounted */
> +#define SB_I_IMA_UNTRUSTED_FS	0x00000020 /* Kernel unaware of fs changes */
>  
>  /* Possible states of 'frozen' field */
>  enum {
> diff --git a/security/integrity/ima/ima_appraise.c b/security/integrity/ima/ima_appraise.c
> index f2803a40ff82..ebfeec9b579f 100644
> --- a/security/integrity/ima/ima_appraise.c
> +++ b/security/integrity/ima/ima_appraise.c
> @@ -292,7 +292,20 @@ int ima_appraise_measurement(enum ima_hooks func,
>  	}
>  
>  out:
> -	if (status != INTEGRITY_PASS) {
> +	/*
> +	 * Files on both privileged and unprivileged mounted untrusted
> +	 * filesystems (eg. FUSE) should fail signature verification, but
> +	 * this might break existing systems.  Differentiate between the
> +	 * new unprivileged non-init mounted filesystems and everything else.
> +	 */
> +	if ((inode->i_sb->s_iflags & SB_I_IMA_UNTRUSTED_FS) &&
> +	    ((inode->i_sb->s_user_ns != &init_user_ns) ||
> +	     (iint->flags & IMA_FAIL_UNTRUSTED_FS))) {
> +		status = INTEGRITY_FAIL;
> +		cause = "untrusted-filesystem";
> +		integrity_audit_msg(AUDIT_INTEGRITY_DATA, inode, filename,
> +				    op, cause, rc, 0);
> +	} else if (status != INTEGRITY_PASS) {
>  		if ((ima_appraise & IMA_APPRAISE_FIX) &&
>  		    (!xattr_value ||
>  		     xattr_value->type != EVM_IMA_XATTR_DIGSIG)) {
> @@ -309,6 +322,7 @@ int ima_appraise_measurement(enum ima_hooks func,
>  	} else {
>  		ima_cache_flags(iint, func);
>  	}
> +
>  	ima_set_cache_status(iint, func, status);
>  	return status;
>  }
> diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
> index 915f5572c6ff..43fb05b9686d 100644
> --- a/security/integrity/ima/ima_policy.c
> +++ b/security/integrity/ima/ima_policy.c
> @@ -188,6 +188,7 @@ __setup("ima_tcb", default_measure_policy_setup);
>  
>  static bool ima_use_appraise_tcb __initdata;
>  static bool ima_use_secure_boot __initdata;
> +static bool ima_fail_untrusted_fs __initdata;
>  static int __init policy_setup(char *str)
>  {
>  	char *p;
> @@ -201,6 +202,8 @@ static int __init policy_setup(char *str)
>  			ima_use_appraise_tcb = true;
>  		else if (strcmp(p, "secure_boot") == 0)
>  			ima_use_secure_boot = true;
> +		else if (strcmp(p, "untrusted_fs") == 0)
> +			ima_fail_untrusted_fs = true;
>  	}
>  
>  	return 1;
> @@ -385,6 +388,8 @@ int ima_match_policy(struct inode *inode, enum ima_hooks func, int mask,
>  		if (entry->action & IMA_APPRAISE) {
>  			action |= get_subaction(entry, func);
>  			action ^= IMA_HASH;
> +			if (ima_fail_untrusted_fs)
> +				action |= IMA_FAIL_UNTRUSTED_FS;
>  		}
>  
>  		if (entry->action & IMA_DO_MASK)
> diff --git a/security/integrity/integrity.h b/security/integrity/integrity.h
> index 50a8e3365df7..f8fa60f560a6 100644
> --- a/security/integrity/integrity.h
> +++ b/security/integrity/integrity.h
> @@ -35,6 +35,7 @@
>  #define IMA_PERMIT_DIRECTIO	0x02000000
>  #define IMA_NEW_FILE		0x04000000
>  #define EVM_IMMUTABLE_DIGSIG	0x08000000
> +#define IMA_FAIL_UNTRUSTED_FS	0x10000000
>  
>  #define IMA_DO_MASK		(IMA_MEASURE | IMA_APPRAISE | IMA_AUDIT | \
>  				 IMA_HASH | IMA_APPRAISE_SUBMASK)
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
