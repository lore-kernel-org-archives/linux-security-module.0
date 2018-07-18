From: jmorris@namei.org (James Morris)
Date: Wed, 18 Jul 2018 14:28:40 +1000 (AEST)
Subject: [PATCH] security: check for kstrdup() failure in lsm_append()
In-Reply-To: <20180717173604.107840-1-ebiggers@google.com>
References: <20180717173604.107840-1-ebiggers@google.com>
Message-ID: <alpine.LRH.2.21.1807181428330.20653@namei.org>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Tue, 17 Jul 2018, Eric Biggers wrote:

> lsm_append() should return -ENOMEM if memory allocation failed.
> 
> Fixes: d69dece5f5b6 ("LSM: Add /sys/kernel/security/lsm")
> Signed-off-by: Eric Biggers <ebiggers@google.com>
> ---
>  security/security.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/security/security.c b/security/security.c
> index 03e98be76d58..259ff593d543 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -121,6 +121,8 @@ static int lsm_append(char *new, char **result)
>  
>  	if (*result == NULL) {
>  		*result = kstrdup(new, GFP_KERNEL);
> +		if (*result == NULL)
> +			return -ENOMEM;
>  	} else {
>  		/* Check if it is the last registered name */
>  		if (match_last_lsm(*result, new))
> 

Applied to
git://git.kernel.org/pub/scm/linux/kernel/git/jmorris/linux-security.git next-general


-- 
James Morris
<jmorris@namei.org>

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
