From: jlee@suse.com (joeyli)
Date: Fri, 20 Oct 2017 14:40:33 +0800
Subject: [PATCH 08/27] hibernate: Disable when the kernel is locked down
In-Reply-To: <150842469486.7923.10376463083069013490.stgit@warthog.procyon.org.uk>
References: <150842463163.7923.11081723749106843698.stgit@warthog.procyon.org.uk>
	<150842469486.7923.10376463083069013490.stgit@warthog.procyon.org.uk>
Message-ID: <20171020064033.GP3285@linux-l9pv.suse>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Thu, Oct 19, 2017 at 03:51:34PM +0100, David Howells wrote:
> From: Josh Boyer <jwboyer@fedoraproject.org>
> 
> There is currently no way to verify the resume image when returning
> from hibernate.  This might compromise the signed modules trust model,
> so until we can work with signed hibernate images we disable it when the
> kernel is locked down.
> 
> Signed-off-by: Josh Boyer <jwboyer@fedoraproject.org>
> Signed-off-by: David Howells <dhowells@redhat.com>
> cc: linux-pm at vger.kernel.org

I have reviewed and tested this patch. Please feel free to add:

Reviewed-by: "Lee, Chun-Yi" <jlee@suse.com>

Thanks a lot!
Joey Lee

> ---
> 
>  kernel/power/hibernate.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/power/hibernate.c b/kernel/power/hibernate.c
> index a5c36e9c56a6..f2eafefeec50 100644
> --- a/kernel/power/hibernate.c
> +++ b/kernel/power/hibernate.c
> @@ -70,7 +70,7 @@ static const struct platform_hibernation_ops *hibernation_ops;
>  
>  bool hibernation_available(void)
>  {
> -	return (nohibernate == 0);
> +	return nohibernate == 0 && !kernel_is_locked_down("Hibernation");
>  }
>  
>  /**
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-efi" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
