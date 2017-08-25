From: jmorris@namei.org (James Morris)
Date: Fri, 25 Aug 2017 15:55:20 +1000 (AEST)
Subject: [PATCH V3 01/10] capabilities: factor out cap_bprm_set_creds
	privileged root
In-Reply-To: <63333a7ed7e3ce62e3142b5e34ee942f3874a0d6.1503459890.git.rgb@redhat.com>
References: <cover.1503459890.git.rgb@redhat.com>
	<63333a7ed7e3ce62e3142b5e34ee942f3874a0d6.1503459890.git.rgb@redhat.com>
Message-ID: <alpine.LRH.2.20.1708251554500.29541@namei.org>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Wed, 23 Aug 2017, Richard Guy Briggs wrote:

> Factor out the case of privileged root from the function
> cap_bprm_set_creds() to make the latter easier to read and analyse.
> 
> Suggested-by: Serge Hallyn <serge@hallyn.com>
> Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
> ---
>  security/commoncap.c |   62 +++++++++++++++++++++++++++----------------------
>  1 files changed, 34 insertions(+), 28 deletions(-)
> 
> diff --git a/security/commoncap.c b/security/commoncap.c
> index 78b3783..b7fbf77 100644
> --- a/security/commoncap.c
> +++ b/security/commoncap.c
> @@ -481,6 +481,38 @@ static int get_file_caps(struct linux_binprm *bprm, bool *effective, bool *has_c
>  	return rc;
>  }
>  
> +void handle_privileged_root(struct linux_binprm *bprm, bool has_cap, bool *effective, kuid_t root_uid)

Can this be static?


-- 
James Morris
<jmorris@namei.org>

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
