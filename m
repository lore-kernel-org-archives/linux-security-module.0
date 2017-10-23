From: zohar@linux.vnet.ibm.com (Mimi Zohar)
Date: Mon, 23 Oct 2017 08:57:15 -0400
Subject: [PATCH 2/2] ima: check signature enforcement against cmdline
	param instead of CONFIG
In-Reply-To: <2530819c121999268c2c40ad9b907d1ca7726919.1508524595.git.brdeoliv@redhat.com>
References: <cover.1508524595.git.brdeoliv@redhat.com>
	<2530819c121999268c2c40ad9b907d1ca7726919.1508524595.git.brdeoliv@redhat.com>
Message-ID: <1508763435.3639.92.camel@linux.vnet.ibm.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Fri, 2017-10-20 at 17:19 -0200, Bruno E. O. Meneguele wrote:
> When the user requests MODULE_CHECK policy and its kernel is compiled
> with CONFIG_MODULE_SIG_FORCE not set, all modules would not load, just
> those loaded in initram time. One option the user would have would be
> set a kernel cmdline param (module.sig_enforce) to true, but the IMA
> module check code doesn't rely on this value, it checks just
> CONFIG_MODULE_SIG_FORCE.
> 
> This patch solves this problem checking for the exported value of
> module.sig_enforce cmdline param intead of CONFIG_MODULE_SIG_FORCE,
> which holds the effective value (CONFIG || param).
> 
> Signed-off-by: Bruno E. O. Meneguele <brdeoliv@redhat.com>

Thanks!
> ---
>  security/integrity/ima/ima_main.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
> index e4ab8ef8016e..d11a7fcc5c8b 100644
> --- a/security/integrity/ima/ima_main.c
> +++ b/security/integrity/ima/ima_main.c
> @@ -356,12 +356,12 @@ void ima_post_path_mknod(struct dentry *dentry)
>   */
>  int ima_read_file(struct file *file, enum kernel_read_file_id read_id)
>  {
> +	bool sig_enforce = is_module_sig_enforced();
> +
>  	if (!file && read_id == READING_MODULE) {
> -#ifndef CONFIG_MODULE_SIG_FORCE
> -		if ((ima_appraise & IMA_APPRAISE_MODULES) &&
> +		if (!sig_enforce && (ima_appraise & IMA_APPRAISE_MODULES) &&
>  		    (ima_appraise & IMA_APPRAISE_ENFORCE))
>  			return -EACCES;	/* INTEGRITY_UNKNOWN */
> -#endif
>  		return 0;	/* We rely on module signature checking */
>  	}
>  	return 0;

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
