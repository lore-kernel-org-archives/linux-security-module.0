From: selven@hackers.mu (Pirabarlen Cheenaramen)
Date: Sun, 23 Apr 2017 08:48:32 +0200
Subject: [PATCH] selinux: hooks: security content must be properly cleared
In-Reply-To: <20170423000551.GA25768@hackers.mu>
References: <20170423000551.GA25768@hackers.mu>
Message-ID: <20170423064832.GA4042@hackers.mu>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Please disregard this patch.

On Sun, Apr 23, 2017 at 02:05:51AM +0200, Pirabarlen-Cheenaramen wrote:
> Signed-off-by: Pirabarlen-Cheenaramen <selven@hackers.mu>
> ---
>  security/selinux/hooks.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index e67a526..ef3fa80 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -4969,7 +4969,7 @@ static int selinux_tun_dev_alloc_security(void **security)
>  
>  static void selinux_tun_dev_free_security(void *security)
>  {
> -	kfree(security);
> +	kzfree(security);
>  }
>  
>  static int selinux_tun_dev_create(void)
> -- 
> 1.9.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
