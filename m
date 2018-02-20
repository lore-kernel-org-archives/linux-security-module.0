From: sds@tycho.nsa.gov (Stephen Smalley)
Date: Tue, 20 Feb 2018 14:01:24 -0500
Subject: [PATCH v3 14/15] selinux: allow setxattr on rootfs so initramfs
	code can set them
In-Reply-To: <1518813234-5874-17-git-send-email-takondra@cisco.com>
References: <1518813234-5874-1-git-send-email-takondra@cisco.com>
	<1518813234-5874-17-git-send-email-takondra@cisco.com>
Message-ID: <1519153284.14218.18.camel@tycho.nsa.gov>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Fri, 2018-02-16 at 20:33 +0000, Taras Kondratiuk wrote:
> From: Victor Kamensky <kamensky@cisco.com>
> 
> initramfs code supporting extended cpio format have ability to
> fill extended attributes from cpio archive, but if SELinux enabled
> and security server is not initialized yet, selinux callback would
> refuse setxattr made by initramfs code.
> 
> Solution enable SBLABEL_MNT on rootfs even if secrurity server is
> not initialized yet.

What if we were to instead skip the SBLABEL_MNT check in
selinux_inode_setxattr() if !ss_initialized?  Not dependent on
filesystem type.

> 
> Signed-off-by: Victor Kamensky <kamensky@cisco.com>
> ---
>  security/selinux/hooks.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index 8644d864e3c1..f3fe65589f02 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -706,6 +706,18 @@ static int selinux_set_mnt_opts(struct
> super_block *sb,
>  
>  	if (!ss_initialized) {
>  		if (!num_opts) {
> +			/*
> +			 * Special handling for rootfs. Is genfs but
> supports
> +			 * setting SELinux context on in-core
> inodes.
> +			 *
> +			 * Chicken and egg problem: policy may
> reside in rootfs
> +			 * but for initramfs code to fill in
> attributes, it
> +			 * needs selinux to allow that.
> +			 */
> +			if (!strncmp(sb->s_type->name, "rootfs",
> +				     sizeof("rootfs")))
> +				sbsec->flags |= SBLABEL_MNT;
> +
>  			/* Defer initialization until
> selinux_complete_init,
>  			   after the initial policy is loaded and
> the security
>  			   server is ready to handle calls. */
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
