From: jmorris@namei.org (James Morris)
Date: Fri, 25 Aug 2017 15:48:45 +1000 (AEST)
Subject: [PATCH V3 09/10] capabilities: fix logic for effective root or
	real root
In-Reply-To: <0d9646956d9b2d99e8699c009de21f14fa592e7a.1503459890.git.rgb@redhat.com>
References: <cover.1503459890.git.rgb@redhat.com>
	<0d9646956d9b2d99e8699c009de21f14fa592e7a.1503459890.git.rgb@redhat.com>
Message-ID: <alpine.LRH.2.20.1708251548360.29541@namei.org>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Wed, 23 Aug 2017, Richard Guy Briggs wrote:

> Now that the logic is inverted, it is much easier to see that both real root
> and effective root conditions had to be met to avoid printing the BPRM_FCAPS
> record with audit syscalls.  This meant that any setuid root applications would
> print a full BPRM_FCAPS record when it wasn't necessary, cluttering the event
> output, since the SYSCALL and PATH records indicated the presence of the setuid
> bit and effective root user id.
> 
> Require only one of effective root or real root to avoid printing the
> unnecessary record.
> 
> Ref: 3fc689e96c0c (Add audit_log_bprm_fcaps/AUDIT_BPRM_FCAPS)
> See: https://github.com/linux-audit/audit-kernel/issues/16
> 
> Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
> ---
>  security/commoncap.c |    6 +++---
>  1 files changed, 3 insertions(+), 3 deletions(-)


Acked-by: James Morris <james.l.morris@oracle.com>


> 
> diff --git a/security/commoncap.c b/security/commoncap.c
> index eb2da69..49cce06 100644
> --- a/security/commoncap.c
> +++ b/security/commoncap.c
> @@ -540,7 +540,7 @@ static inline bool is_setgid(struct cred *new, const struct cred *old)
>   *
>   * We do not bother to audit if 3 things are true:
>   *   1) cap_effective has all caps
> - *   2) we are root
> + *   2) we became root *OR* are root
>   *   3) root is supposed to have all caps (SECURE_NOROOT)
>   * Since this is just a normal root execing a process.
>   *
> @@ -553,8 +553,8 @@ static inline bool nonroot_raised_pE(struct cred *cred, kuid_t root)
>  
>  	if (cap_grew(effective, ambient, cred) &&
>  	    !(cap_full(effective, cred) &&
> -	      is_eff(root, cred) &&
> -	      is_real(root, cred) &&
> +	      (is_eff(root, cred) ||
> +	       is_real(root, cred)) &&
>  	      root_privileged()))
>  		ret = true;
>  	return ret;
> 

-- 
James Morris
<jmorris@namei.org>

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
