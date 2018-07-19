From: zohar@linux.ibm.com (Mimi Zohar)
Date: Thu, 19 Jul 2018 18:39:17 -0400
Subject: [PATCH] security: export security_kernel_load_data to fix
	firmware_loader build
In-Reply-To: <7a8dd892-39ec-3973-5f41-5ec23f1feb3f@infradead.org>
References: <7a8dd892-39ec-3973-5f41-5ec23f1feb3f@infradead.org>
Message-ID: <1532039957.4196.2.camel@linux.ibm.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Thanks, Randy.

On Thu, 2018-07-19 at 13:15 -0700, Randy Dunlap wrote:
> From: Randy Dunlap <rdunlap@infradead.org>
> 
> Fix build error when CONFIG_FW_LOADER=m, CONFIG_FW_LOADER_USER_HELPER=y,
> CONFIG_FW_LOADER_USER_HELPER_FALLBACK=y, and CONFIG_SECURITY=y:
> 
> ERROR: "security_kernel_load_data" [drivers/base/firmware_loader/firmware_class.ko] undefined!
> 
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: James Morris <jmorris@namei.org>
> Cc: "Serge E. Hallyn" <serge@hallyn.com>
> Cc: linux-security-module at vger.kernel.org
> Cc: Luis R. Rodriguez <mcgrof@kernel.org>
> ---
>  security/security.c |    1 +
>  1 file changed, 1 insertion(+)
> 
> --- linux-next-20180717.orig/security/security.c
> +++ linux-next-20180717/security/security.c
> @@ -1121,6 +1121,7 @@ int security_kernel_load_data(enum kerne
>  		return ret;
>  	return ima_load_data(id);
>  }
> +EXPORT_SYMBOL_GPL(security_kernel_load_data);

Arnd Bergmann already posted a similar patch, which is now staged in
James' tree.

Mimi

> 
>  int security_task_fix_setuid(struct cred *new, const struct cred *old,
>  			     int flags)
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
