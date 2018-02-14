From: serge@hallyn.com (Serge E. Hallyn)
Date: Wed, 14 Feb 2018 08:49:03 -0600
Subject: [RFC PATCH 2/4] ima: fail signature verification on unprivileged
	& untrusted filesystems
In-Reply-To: <1518615315-7162-2-git-send-email-zohar@linux.vnet.ibm.com>
References: <1518615315-7162-1-git-send-email-zohar@linux.vnet.ibm.com>
	<1518615315-7162-2-git-send-email-zohar@linux.vnet.ibm.com>
Message-ID: <20180214144903.GA1953@mail.hallyn.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Quoting Mimi Zohar (zohar at linux.vnet.ibm.com):
> Files on untrusted filesystems, such as fuse, can change at any time,
> making the measurement(s) and by extension signature verification
> meaningless.
> 
> FUSE can be mounted by unprivileged users either today with fusermount
> installed with setuid, or soon with the upcoming patches to allow FUSE
> mounts in a non-init user namespace.
> 
> This patch always fails the file signature verification on unprivileged
> and untrusted filesystems.  To also fail file signature verification on

Why only untrusted?  Fuse could cause the same issue if it just
messes up when mounted from init userns right?

> privileged, untrusted filesystems requires a custom policy.

(I'm not saying you shouldn't do this, but) does this mean that
a container whose rootfs is fuse-mounted by the unprivileged user
cannot possibly use IMA?

Good thing we can partially work around that by intercepting real
mount calls with Tycho's new patchset :)

> (This patch is based on Alban Crequy's use of fs_flags and patch
>  description.)
> 
> Signed-off-by: Mimi Zohar <zohar@linux.vnet.ibm.com>
> Cc: Miklos Szeredi <miklos@szeredi.hu>
> Cc: Seth Forshee <seth.forshee@canonical.com>
> Cc: Eric W. Biederman <ebiederm@xmission.com>
> Cc: Dongsu Park <dongsu@kinvolk.io>
> Cc: Alban Crequy <alban@kinvolk.io>
> Cc: "Serge E. Hallyn" <serge@hallyn.com>
> ---
>  include/linux/fs.h                    |  1 +
>  security/integrity/ima/ima_appraise.c | 10 +++++++++-
>  2 files changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index 2a815560fda0..faffe4aab43d 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -2069,6 +2069,7 @@ struct file_system_type {
>  #define FS_BINARY_MOUNTDATA	2
>  #define FS_HAS_SUBTYPE		4
>  #define FS_USERNS_MOUNT		8	/* Can be mounted by userns root */
> +#define FS_UNTRUSTED		16	/* Defined filesystem as untrusted */
>  #define FS_RENAME_DOES_D_MOVE	32768	/* FS will handle d_move() during rename() internally. */
>  	struct dentry *(*mount) (struct file_system_type *, int,
>  		       const char *, void *);
> diff --git a/security/integrity/ima/ima_appraise.c b/security/integrity/ima/ima_appraise.c
> index f2803a40ff82..af8add31fe26 100644
> --- a/security/integrity/ima/ima_appraise.c
> +++ b/security/integrity/ima/ima_appraise.c
> @@ -292,7 +292,14 @@ int ima_appraise_measurement(enum ima_hooks func,
>  	}
>  
>  out:
> -	if (status != INTEGRITY_PASS) {
> +	/* Fail untrusted and unpriviliged filesystems (eg FUSE) */
> +	if ((inode->i_sb->s_type->fs_flags & FS_UNTRUSTED) &&
> +	    (inode->i_sb->s_user_ns != &init_user_ns)) {
> +		status = INTEGRITY_FAIL;
> +		cause = "untrusted-filesystem";
> +		integrity_audit_msg(AUDIT_INTEGRITY_DATA, inode, filename,
> +				    op, cause, rc, 0);
> +	} else if (status != INTEGRITY_PASS) {
>  		if ((ima_appraise & IMA_APPRAISE_FIX) &&
>  		    (!xattr_value ||
>  		     xattr_value->type != EVM_IMA_XATTR_DIGSIG)) {
> @@ -309,6 +316,7 @@ int ima_appraise_measurement(enum ima_hooks func,
>  	} else {
>  		ima_cache_flags(iint, func);
>  	}
> +
>  	ima_set_cache_status(iint, func, status);
>  	return status;
>  }
> -- 
> 2.7.5
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
