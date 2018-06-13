From: zohar@linux.vnet.ibm.com (Mimi Zohar)
Date: Wed, 13 Jun 2018 16:30:30 -0400
Subject: [PATCH] integrity: add error handling for kmem_cache_create
In-Reply-To: <1528777625-40502-1-git-send-email-jiazhouyang09@gmail.com>
References: <1528777625-40502-1-git-send-email-jiazhouyang09@gmail.com>
Message-ID: <1528921830.3282.7.camel@linux.vnet.ibm.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Tue, 2018-06-12 at 12:27 +0800, Zhouyang Jia wrote:
> When kmem_cache_create fails, the lack of error-handling code may
> cause unexpected results.
> 
> This patch adds error-handling code after calling kmem_cache_create.

The slab is being create during __init. ?Under what circumstances do
you expect the allocation to fail? ?Have you tested what happens if it
fails with/without at least an IMA measurement policy?

Mimi
??
> 
> Signed-off-by: Zhouyang Jia <jiazhouyang09@gmail.com>
> ---
>  security/integrity/iint.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/security/integrity/iint.c b/security/integrity/iint.c
> index 149faa8..c074fd8 100644
> --- a/security/integrity/iint.c
> +++ b/security/integrity/iint.c
> @@ -172,6 +172,9 @@ static int __init integrity_iintcache_init(void)
>  	iint_cache =
>  	    kmem_cache_create("iint_cache", sizeof(struct integrity_iint_cache),
>  			      0, SLAB_PANIC, init_once);
> +	if (!iint_cache)
> +		return -ENOMEM;
> +
>  	return 0;
>  }
>  security_initcall(integrity_iintcache_init);





--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
