From: serge@hallyn.com (Serge E. Hallyn)
Date: Mon, 28 May 2018 00:17:17 -0500
Subject: [PATCH -next] integrity: fix the error return code in
	integrity_load_keys()
In-Reply-To: <1527473316-35602-1-git-send-email-weiyongjun1@huawei.com>
References: <1527473316-35602-1-git-send-email-weiyongjun1@huawei.com>
Message-ID: <20180528051717.GA11155@mail.hallyn.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Mon, May 28, 2018 at 02:08:36AM +0000, Wei Yongjun wrote:
> The error return code PTR_ERR(integrity_dir) is always 0 since
> integrity_dir is set to NULL in this error handling case.
> 
> Fixes: 0c343af8065b ("integrity: Add an integrity directory in securityfs")
> Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>

Huh.

Acked-by: Serge Hallyn <serge@hallyn.com>

> ---
>  security/integrity/iint.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/security/integrity/iint.c b/security/integrity/iint.c
> index 149faa8..2dfc9e8 100644
> --- a/security/integrity/iint.c
> +++ b/security/integrity/iint.c
> @@ -217,12 +217,15 @@ void __init integrity_load_keys(void)
>  
>  static int __init integrity_fs_init(void)
>  {
> +	int ret;
> +
>  	integrity_dir = securityfs_create_dir("integrity", NULL);
>  	if (IS_ERR(integrity_dir)) {
>  		pr_err("Unable to create integrity sysfs dir: %ld\n",
>  		       PTR_ERR(integrity_dir));
> +		ret = PTR_ERR(integrity_dir);
>  		integrity_dir = NULL;
> -		return PTR_ERR(integrity_dir);
> +		return ret;
>  	}
>  
>  	return 0;
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
