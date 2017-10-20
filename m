From: jlee@suse.com (joeyli)
Date: Fri, 20 Oct 2017 14:33:20 +0800
Subject: [PATCH 03/27] Enforce module signatures if the kernel is locked
	down
In-Reply-To: <150842465546.7923.6762214527898273559.stgit@warthog.procyon.org.uk>
References: <150842463163.7923.11081723749106843698.stgit@warthog.procyon.org.uk>
	<150842465546.7923.6762214527898273559.stgit@warthog.procyon.org.uk>
Message-ID: <20171020063320.GL3285@linux-l9pv.suse>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Hi David,

Thanks for you send our this series.

On Thu, Oct 19, 2017 at 03:50:55PM +0100, David Howells wrote:
> If the kernel is locked down, require that all modules have valid
> signatures that we can verify.
> 
> Signed-off-by: David Howells <dhowells@redhat.com>

I have reviewed and tested this patch. Please feel free to add:

Reviewed-by: "Lee, Chun-Yi" <jlee@suse.com>

Thanks a lot!
Joey Lee

> ---
> 
>  kernel/module.c |    3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/module.c b/kernel/module.c
> index de66ec825992..3d9a3270c179 100644
> --- a/kernel/module.c
> +++ b/kernel/module.c
> @@ -2781,7 +2781,8 @@ static int module_sig_check(struct load_info *info, int flags)
>  	}
>  
>  	/* Not having a signature is only an error if we're strict. */
> -	if (err == -ENOKEY && !sig_enforce)
> +	if (err == -ENOKEY && !sig_enforce &&
> +	    !kernel_is_locked_down("Loading of unsigned modules"))
>  		err = 0;
>  
>  	return err;
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-efi" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
