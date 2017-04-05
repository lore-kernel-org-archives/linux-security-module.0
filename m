From: casey@schaufler-ca.com (Casey Schaufler)
Date: Wed, 5 Apr 2017 15:22:58 -0700
Subject: FW: [PATCH] Smack: Use GFP_KERNEL for smk_netlbl_mls().
In-Reply-To: <201703271933.FDC56292.FOOOVJMFtFQHSL@I-love.SAKURA.ne.jp>
References: <1479121976-13429-2-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
	<201703271933.FDC56292.FOOOVJMFtFQHSL@I-love.SAKURA.ne.jp>
Message-ID: <015cb956-494a-1ef3-bf9f-196e224ec375@schaufler-ca.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On 3/27/2017 3:33 AM, Tetsuo Handa wrote:
> Casey, I think you haven't applied this one.
>
> ------- Forwarded Message
> From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> To: casey at schaufler-ca.com
> Cc: linux-security-module at vger.kernel.org,Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> Subject: [PATCH] Smack: Use GFP_KERNEL for smk_netlbl_mls().
> Date: Mon, 14 Nov 2016 20:12:56 +0900
>
> Since all callers of smk_netlbl_mls() are GFP_KERNEL context
> (smk_set_cipso() calls memdup_user_nul(), init_smk_fs() calls
> __kernfs_new_node(), smk_import_entry() calls kzalloc(GFP_KERNEL)),
> it is safe to use GFP_KERNEL from netlbl_catmap_setbit().
>
> Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>

Applied-to: git://github.com/cschaufler/smack-next#smack-for-4.12

> ---
>  security/smack/smack_access.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/security/smack/smack_access.c b/security/smack/smack_access.c
> index 23e5808..1f1ac3d 100644
> --- a/security/smack/smack_access.c
> +++ b/security/smack/smack_access.c
> @@ -509,7 +509,7 @@ int smk_netlbl_mls(int level, char *catset, struct netlbl_lsm_secattr *sap,
>  			if ((m & *cp) == 0)
>  				continue;
>  			rc = netlbl_catmap_setbit(&sap->attr.mls.cat,
> -						  cat, GFP_ATOMIC);
> +						  cat, GFP_KERNEL);
>  			if (rc < 0) {
>  				netlbl_catmap_free(sap->attr.mls.cat);
>  				return rc;

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
