From: casey@schaufler-ca.com (Casey Schaufler)
Date: Fri, 24 Mar 2017 08:48:28 -0700
Subject: [PATCH] smack: fix double free in smack_parse_opts_str()
In-Reply-To: <1490355725-13867-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
References: <1490355725-13867-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
Message-ID: <a92eb2ac-50a1-e943-da9d-8ed8bd58ce32@schaufler-ca.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On 3/24/2017 4:42 AM, Tetsuo Handa wrote:
> smack_parse_opts_str() calls kfree(opts->mnt_opts) when kcalloc() for
> opts->mnt_opts_flags failed. But it should not have called it because
> security_free_mnt_opts() will call kfree(opts->mnt_opts).
>
> Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> fixes: 3bf2789cad9e6573 ("smack: allow mount opts setting over filesystems with binary mount data")
> Cc: Vivek Trivedi <t.vivek@samsung.com>
> Cc: Amit Sahrawat <a.sahrawat@samsung.com>
> Cc: Casey Schaufler <casey@schaufler-ca.com>

Acked-by: Casey Schaufler <casey@schaufler-ca.com>

I will take this in the Smack tree.
 

> ---
>  security/smack/smack_lsm.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
> index 927e60e..658f5d8 100644
> --- a/security/smack/smack_lsm.c
> +++ b/security/smack/smack_lsm.c
> @@ -695,10 +695,8 @@ static int smack_parse_opts_str(char *options,
>  
>  	opts->mnt_opts_flags = kcalloc(NUM_SMK_MNT_OPTS, sizeof(int),
>  			GFP_KERNEL);
> -	if (!opts->mnt_opts_flags) {
> -		kfree(opts->mnt_opts);
> +	if (!opts->mnt_opts_flags)
>  		goto out_err;
> -	}
>  
>  	if (fsdefault) {
>  		opts->mnt_opts[num_mnt_opts] = fsdefault;

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
