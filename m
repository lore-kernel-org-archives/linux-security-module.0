From: zohar@linux.vnet.ibm.com (Mimi Zohar)
Date: Wed, 23 May 2018 10:42:43 -0400
Subject: [PATCH 25/33] ima: use match_string() helper
In-Reply-To: <1526903890-35761-26-git-send-email-xieyisheng1@huawei.com>
References: <1526903890-35761-1-git-send-email-xieyisheng1@huawei.com>
	<1526903890-35761-26-git-send-email-xieyisheng1@huawei.com>
Message-ID: <1527086563.4168.0.camel@linux.vnet.ibm.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Mon, 2018-05-21 at 19:58 +0800, Yisheng Xie wrote:
> match_string() returns the index of an array for a matching string,
> which can be used intead of open coded variant.
> 
> Cc: Mimi Zohar <zohar@linux.vnet.ibm.com>
> Cc: Dmitry Kasatkin <dmitry.kasatkin@gmail.com>
> Cc: James Morris <jmorris@namei.org>
> Cc: "Serge E. Hallyn" <serge@hallyn.com>
> Cc: linux-integrity at vger.kernel.org
> Cc: linux-security-module at vger.kernel.org
> Signed-off-by: Yisheng Xie <xieyisheng1@huawei.com>

Reviewed-by: Mimi Zohar <zohar@linux.vnet.ibm.com>

> ---
>  security/integrity/ima/ima_main.c | 11 ++++-------
>  1 file changed, 4 insertions(+), 7 deletions(-)
> 
> diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
> index 74d0bd7..f807093 100644
> --- a/security/integrity/ima/ima_main.c
> +++ b/security/integrity/ima/ima_main.c
> @@ -61,14 +61,11 @@ static int __init hash_setup(char *str)
>  		goto out;
>  	}
> 
> -	for (i = 0; i < HASH_ALGO__LAST; i++) {
> -		if (strcmp(str, hash_algo_name[i]) == 0) {
> -			ima_hash_algo = i;
> -			break;
> -		}
> -	}
> -	if (i == HASH_ALGO__LAST)
> +	i = match_string(hash_algo_name, HASH_ALGO__LAST, str);
> +	if (i < 0)
>  		return 1;
> +
> +	ima_hash_algo = i;
>  out:
>  	hash_setup_done = 1;
>  	return 1;

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
