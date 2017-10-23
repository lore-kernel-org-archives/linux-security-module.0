From: zohar@linux.vnet.ibm.com (Mimi Zohar)
Date: Mon, 23 Oct 2017 11:54:43 -0400
Subject: [PATCH 07/27] kexec_file: Disable at runtime if securelevel has
	been set
In-Reply-To: <150842468754.7923.10037578333644594134.stgit@warthog.procyon.org.uk>
References: <150842463163.7923.11081723749106843698.stgit@warthog.procyon.org.uk>
	<150842468754.7923.10037578333644594134.stgit@warthog.procyon.org.uk>
Message-ID: <1508774083.3639.124.camel@linux.vnet.ibm.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Thu, 2017-10-19 at 15:51 +0100, David Howells wrote:
> From: Chun-Yi Lee <joeyli.kernel@gmail.com>
> 
> When KEXEC_VERIFY_SIG is not enabled, kernel should not loads image
> through kexec_file systemcall if securelevel has been set.

The patch title and description needs to be updated to refer to
lockdown, not securelevel.

As previously mentioned the last time these patches were posted, this
leaves out testing to see if the integrity subsystem is enabled.

Commit 503ceaef8e2e "ima: define a set of appraisal rules requiring
file signatures" was upstreamed. ?An additional patch could force
these rules to be added to the custom policy, if lockdown is enabled.
?This and other patches in this series could then check to see if
is_ima_appraise_enabled() is true.

Mimi


> This code was showed in Matthew's patch but not in git:
> https://lkml.org/lkml/2015/3/13/778
> 
> Cc: Matthew Garrett <mjg59@srcf.ucam.org>
> Signed-off-by: Chun-Yi Lee <jlee@suse.com>
> Signed-off-by: David Howells <dhowells@redhat.com>
> cc: kexec at lists.infradead.org
> ---
> 
>  kernel/kexec_file.c |    7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
> index 9f48f4412297..ff6523f2dcc2 100644
> --- a/kernel/kexec_file.c
> +++ b/kernel/kexec_file.c
> @@ -255,6 +255,13 @@ SYSCALL_DEFINE5(kexec_file_load, int, kernel_fd, int, initrd_fd,
>  	if (!capable(CAP_SYS_BOOT) || kexec_load_disabled)
>  		return -EPERM;
> 
> +	/* Don't permit images to be loaded into trusted kernels if we're not
> +	 * going to verify the signature on them
> +	 */
> +	if (!IS_ENABLED(CONFIG_KEXEC_VERIFY_SIG) &&
> +	    kernel_is_locked_down("kexec of unsigned images"))
> +		return -EPERM;
> +
>  	/* Make sure we have a legal set of flags */
>  	if (flags != (flags & KEXEC_FILE_FLAGS))
>  		return -EINVAL;
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
