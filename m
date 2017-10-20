From: jlee@suse.com (joeyli)
Date: Fri, 20 Oct 2017 14:41:09 +0800
Subject: [PATCH 09/27] uswsusp: Disable when the kernel is locked down
In-Reply-To: <150842470227.7923.15293760935442172683.stgit@warthog.procyon.org.uk>
References: <150842463163.7923.11081723749106843698.stgit@warthog.procyon.org.uk>
	<150842470227.7923.15293760935442172683.stgit@warthog.procyon.org.uk>
Message-ID: <20171020064109.GQ3285@linux-l9pv.suse>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Thu, Oct 19, 2017 at 03:51:42PM +0100, David Howells wrote:
> From: Matthew Garrett <mjg59@srcf.ucam.org>
> 
> uswsusp allows a user process to dump and then restore kernel state, which
> makes it possible to modify the running kernel.  Disable this if the kernel
> is locked down.
> 
> Signed-off-by: Matthew Garrett <mjg59@srcf.ucam.org>
> Signed-off-by: David Howells <dhowells@redhat.com>
> cc: linux-pm at vger.kernel.org

I have reviewed and tested this patch. Please feel free to add:

Reviewed-by: "Lee, Chun-Yi" <jlee@suse.com>

Thanks a lot!
Joey Lee

> ---
> 
>  kernel/power/user.c |    3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/kernel/power/user.c b/kernel/power/user.c
> index 22df9f7ff672..678ade9decfe 100644
> --- a/kernel/power/user.c
> +++ b/kernel/power/user.c
> @@ -52,6 +52,9 @@ static int snapshot_open(struct inode *inode, struct file *filp)
>  	if (!hibernation_available())
>  		return -EPERM;
>  
> +	if (kernel_is_locked_down("/dev/snapshot"))
> +		return -EPERM;
> +
>  	lock_system_sleep();
>  
>  	if (!atomic_add_unless(&snapshot_device_available, -1, 0)) {
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-efi" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
