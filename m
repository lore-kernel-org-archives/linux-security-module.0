From: james.l.morris@oracle.com (James Morris)
Date: Tue, 5 Dec 2017 23:04:35 +1100 (AEDT)
Subject: [PATCH] security: Export few symbols referred by other modules
In-Reply-To: <1512471537-23865-1-git-send-email-hareeshg@codeaurora.org>
References: <1512471537-23865-1-git-send-email-hareeshg@codeaurora.org>
Message-ID: <alpine.LFD.2.20.1712052259390.14735@localhost>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Tue, 5 Dec 2017, Hareesh Gundu wrote:

> Export mmap_min_addr and security_mmap_addr() to allow
> kernel modules to use them.
> 
> Signed-off-by: Hareesh Gundu <hareeshg@codeaurora.org>

I'm not sure whether this should be EXPORT_SYMBOL or EXPORT_SYMBOL_GPL, as 
this hook was added in 2009, well after EXPORT_SYMBOL_GPL came into being.

Most of the LSM hooks are marked EXPORT_SYMBOL because they were part of 
an existing interface when EXPORT_SYMBOL_GPL was introduced, IIRC.

What do folks think?




> ---
>  security/min_addr.c | 1 +
>  security/security.c | 1 +
>  2 files changed, 2 insertions(+)
> 
> diff --git a/security/min_addr.c b/security/min_addr.c
> index 94d2b0c..4653711 100644
> --- a/security/min_addr.c
> +++ b/security/min_addr.c
> @@ -6,6 +6,7 @@
>  
>  /* amount of vm to protect from userspace access by both DAC and the LSM*/
>  unsigned long mmap_min_addr;
> +EXPORT_SYMBOL(mmap_min_addr);
>  /* amount of vm to protect from userspace using CAP_SYS_RAWIO (DAC) */
>  unsigned long dac_mmap_min_addr = CONFIG_DEFAULT_MMAP_MIN_ADDR;
>  /* amount of vm to protect from userspace using the LSM = CONFIG_LSM_MMAP_MIN_ADDR */
> diff --git a/security/security.c b/security/security.c
> index 1cd8526..27874a3 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -931,6 +931,7 @@ int security_mmap_addr(unsigned long addr)
>  {
>  	return call_int_hook(mmap_addr, 0, addr);
>  }
> +EXPORT_SYMBOL(security_mmap_addr);
>  
>  int security_file_mprotect(struct vm_area_struct *vma, unsigned long reqprot,
>  			    unsigned long prot)
> -- 
> 1.9.1
> 

-- 
James Morris
<james.l.morris@oracle.com>

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
