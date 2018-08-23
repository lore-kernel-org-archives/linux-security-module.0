From: john.johansen@canonical.com (John Johansen)
Date: Thu, 23 Aug 2018 11:21:20 -0700
Subject: [PATCH] apparmor: remove dead code
In-Reply-To: <20180823134255.GA12128@embeddedor.com>
References: <20180823134255.GA12128@embeddedor.com>
Message-ID: <715ebd74-d147-df40-436b-79fe26dee606@canonical.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On 08/23/2018 06:42 AM, Gustavo A. R. Silva wrote:

thank you for the patch, but a fix for this issue was pushed to apparmor-next yesterday

> Due to commit fb5841091f28 ("apparmor: remove no-op permission check
> in policy_unpack"), there is some leftover code.
> 
> Coverity reports this issue as Structurally dead code. Fix this by
> removing such code.
> 
> Addresses-Coverity-ID: 1472998 ("Structurally dead code")
> Fixes: fb5841091f28 ("apparmor: remove no-op permission check in policy_unpack")
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> ---
>  security/apparmor/policy_unpack.c | 4 ----
>  1 file changed, 4 deletions(-)
> 
> diff --git a/security/apparmor/policy_unpack.c b/security/apparmor/policy_unpack.c
> index 3647b58..21cb384 100644
> --- a/security/apparmor/policy_unpack.c
> +++ b/security/apparmor/policy_unpack.c
> @@ -422,10 +422,6 @@ static struct aa_dfa *unpack_dfa(struct aa_ext *e)
>  	}
>  
>  	return dfa;
> -
> -fail:
> -	aa_put_dfa(dfa);
> -	return ERR_PTR(-EPROTO);
>  }
>  
>  /**
> 
