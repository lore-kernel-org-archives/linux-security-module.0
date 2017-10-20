From: jlee@suse.com (joeyli)
Date: Fri, 20 Oct 2017 14:37:28 +0800
Subject: [PATCH 04/27] Restrict /dev/mem and /dev/kmem when the kernel is
	locked down
In-Reply-To: <150842466261.7923.14359746674406637357.stgit@warthog.procyon.org.uk>
References: <150842463163.7923.11081723749106843698.stgit@warthog.procyon.org.uk>
	<150842466261.7923.14359746674406637357.stgit@warthog.procyon.org.uk>
Message-ID: <20171020063728.GM3285@linux-l9pv.suse>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Hi David,

Thanks for you send out this series.

On Thu, Oct 19, 2017 at 03:51:02PM +0100, David Howells wrote:
> From: Matthew Garrett <matthew.garrett@nebula.com>
> 
> Allowing users to write to address space makes it possible for the kernel to
> be subverted, avoiding module loading restrictions.  Prevent this when the
> kernel has been locked down.
> 
> Signed-off-by: Matthew Garrett <matthew.garrett@nebula.com>
> Signed-off-by: David Howells <dhowells@redhat.com>

I have reviewed and tested this patch. Please feel free to add:

Reviewed-by: "Lee, Chun-Yi" <jlee@suse.com>

Thanks a lot!
Joey Lee

> ---
> 
>  drivers/char/mem.c |    6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/char/mem.c b/drivers/char/mem.c
> index 593a8818aca9..b7c36898b689 100644
> --- a/drivers/char/mem.c
> +++ b/drivers/char/mem.c
> @@ -179,6 +179,9 @@ static ssize_t write_mem(struct file *file, const char __user *buf,
>  	if (p != *ppos)
>  		return -EFBIG;
>  
> +	if (kernel_is_locked_down("/dev/mem"))
> +		return -EPERM;
> +
>  	if (!valid_phys_addr_range(p, count))
>  		return -EFAULT;
>  
> @@ -540,6 +543,9 @@ static ssize_t write_kmem(struct file *file, const char __user *buf,
>  	char *kbuf; /* k-addr because vwrite() takes vmlist_lock rwlock */
>  	int err = 0;
>  
> +	if (kernel_is_locked_down("/dev/kmem"))
> +		return -EPERM;
> +
>  	if (p < (unsigned long) high_memory) {
>  		unsigned long to_write = min_t(unsigned long, count,
>  					       (unsigned long)high_memory - p);
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-efi" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
