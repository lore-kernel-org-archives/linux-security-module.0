From: jmorris@namei.org (James Morris)
Date: Fri, 25 Aug 2017 15:47:52 +1000 (AEST)
Subject: [PATCH V3 08/10] capabilities: invert logic for clarity
In-Reply-To: <6c9745800b15f096639297937ea53b0ec60c2183.1503459890.git.rgb@redhat.com>
References: <cover.1503459890.git.rgb@redhat.com>
	<6c9745800b15f096639297937ea53b0ec60c2183.1503459890.git.rgb@redhat.com>
Message-ID: <alpine.LRH.2.20.1708251547450.29541@namei.org>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Wed, 23 Aug 2017, Richard Guy Briggs wrote:

> The way the logic was presented, it was awkward to read and verify.  Invert the
> logic using DeMorgan's Law to be more easily able to read and understand.
> 
> Signed-off-by: Richard Guy Briggs <rgb@redhat.com>


Acked-by: James Morris <james.l.morris@oracle.com>

> ---
>  security/commoncap.c |    8 ++++----
>  1 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/security/commoncap.c b/security/commoncap.c
> index ffcaff0..eb2da69 100644
> --- a/security/commoncap.c
> +++ b/security/commoncap.c
> @@ -552,10 +552,10 @@ static inline bool nonroot_raised_pE(struct cred *cred, kuid_t root)
>  	bool ret = false;
>  
>  	if (cap_grew(effective, ambient, cred) &&
> -	    (!cap_full(effective, cred) ||
> -	     !is_eff(root, cred) ||
> -	     !is_real(root, cred) ||
> -	     !root_privileged()))
> +	    !(cap_full(effective, cred) &&
> +	      is_eff(root, cred) &&
> +	      is_real(root, cred) &&
> +	      root_privileged()))
>  		ret = true;
>  	return ret;
>  }
> 

-- 
James Morris
<jmorris@namei.org>

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
