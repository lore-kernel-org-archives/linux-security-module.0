From: casey@schaufler-ca.com (Casey Schaufler)
Date: Thu, 20 Sep 2018 16:39:12 -0700
Subject: [PATCH security-next v2 01/26] LSM: Correctly announce start of
	LSM initialization
In-Reply-To: <20180920162338.21060-2-keescook@chromium.org>
References: <20180920162338.21060-1-keescook@chromium.org>
	<20180920162338.21060-2-keescook@chromium.org>
Message-ID: <d273e21a-4323-f2ed-84ef-6b47e89633e4@schaufler-ca.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On 9/20/2018 9:23 AM, Kees Cook wrote:
> For a while now, the LSM core has said it was "initializED", rather than
> "initializING". This adjust the report to be more accurate (i.e. before
> this was reported before any LSMs had been initialized.)
>
> Signed-off-by: Kees Cook <keescook@chromium.org>

Reviewed-by: Casey Schaufler <casey@schaufler-ca.com>

> ---
>  security/security.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/security/security.c b/security/security.c
> index 736e78da1ab9..4cbcf244a965 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -72,10 +72,11 @@ int __init security_init(void)
>  	int i;
>  	struct hlist_head *list = (struct hlist_head *) &security_hook_heads;
>  
> +	pr_info("Security Framework initializing\n");
> +
>  	for (i = 0; i < sizeof(security_hook_heads) / sizeof(struct hlist_head);
>  	     i++)
>  		INIT_HLIST_HEAD(&list[i]);
> -	pr_info("Security Framework initialized\n");
>  
>  	/*
>  	 * Load minor LSMs, with the capability module always first.
