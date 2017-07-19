From: john.johansen@canonical.com (John Johansen)
Date: Tue, 18 Jul 2017 17:00:04 -0700
Subject: [PATCH v3 03/15] apparmor: Refactor to remove bprm_secureexec hook
In-Reply-To: <1500416736-49829-4-git-send-email-keescook@chromium.org>
References: <1500416736-49829-1-git-send-email-keescook@chromium.org>
	<1500416736-49829-4-git-send-email-keescook@chromium.org>
Message-ID: <265c3b84-36c2-53cf-ca7f-b70413c16fff@canonical.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On 07/18/2017 03:25 PM, Kees Cook wrote:
> The AppArmor bprm_secureexec hook can be merged with the bprm_set_creds
> hook since it's dealing with the same information, and all of the details
> are finalized during the first call to the bprm_set_creds hook via
> prepare_binprm() (subsequent calls due to binfmt_script, etc, are ignored
> via bprm->called_set_creds).
> 
> Here, all the comments describe how secureexec is actually calculated
> during bprm_set_creds, so this actually does it, drops the bprm flag that
> was being used internally by AppArmor, and drops the bprm_secureexec hook.
> 
> Cc: John Johansen <john.johansen@canonical.com>
> Signed-off-by: Kees Cook <keescook@chromium.org>

Acked-by: John Johansen <john.johansen@canonical.com>


> ---
>  security/apparmor/domain.c         | 22 +---------------------
>  security/apparmor/include/domain.h |  1 -
>  security/apparmor/include/file.h   |  3 ---
>  security/apparmor/lsm.c            |  1 -
>  4 files changed, 1 insertion(+), 26 deletions(-)
> 
> diff --git a/security/apparmor/domain.c b/security/apparmor/domain.c
> index 878407e023e3..1a1b1ec89d9d 100644
> --- a/security/apparmor/domain.c
> +++ b/security/apparmor/domain.c
> @@ -485,14 +485,11 @@ int apparmor_bprm_set_creds(struct linux_binprm *bprm)
>  	 *
>  	 * Cases 2 and 3 are marked as requiring secure exec
>  	 * (unless policy specified "unsafe exec")
> -	 *
> -	 * bprm->unsafe is used to cache the AA_X_UNSAFE permission
> -	 * to avoid having to recompute in secureexec
>  	 */
>  	if (!(perms.xindex & AA_X_UNSAFE)) {
>  		AA_DEBUG("scrubbing environment variables for %s profile=%s\n",
>  			 name, new_profile->base.hname);
> -		bprm->unsafe |= AA_SECURE_X_NEEDED;
> +		bprm->secureexec = 1;
>  	}
>  apply:
>  	/* when transitioning profiles clear unsafe personality bits */
> @@ -521,23 +518,6 @@ int apparmor_bprm_set_creds(struct linux_binprm *bprm)
>  }
>  
>  /**
> - * apparmor_bprm_secureexec - determine if secureexec is needed
> - * @bprm: binprm for exec  (NOT NULL)
> - *
> - * Returns: %1 if secureexec is needed else %0
> - */
> -int apparmor_bprm_secureexec(struct linux_binprm *bprm)
> -{
> -	/* the decision to use secure exec is computed in set_creds
> -	 * and stored in bprm->unsafe.
> -	 */
> -	if (bprm->unsafe & AA_SECURE_X_NEEDED)
> -		return 1;
> -
> -	return 0;
> -}
> -
> -/**
>   * apparmor_bprm_committing_creds - do task cleanup on committing new creds
>   * @bprm: binprm for the exec  (NOT NULL)
>   */
> diff --git a/security/apparmor/include/domain.h b/security/apparmor/include/domain.h
> index 30544729878a..2495af293587 100644
> --- a/security/apparmor/include/domain.h
> +++ b/security/apparmor/include/domain.h
> @@ -24,7 +24,6 @@ struct aa_domain {
>  };
>  
>  int apparmor_bprm_set_creds(struct linux_binprm *bprm);
> -int apparmor_bprm_secureexec(struct linux_binprm *bprm);
>  void apparmor_bprm_committing_creds(struct linux_binprm *bprm);
>  void apparmor_bprm_committed_creds(struct linux_binprm *bprm);
>  
> diff --git a/security/apparmor/include/file.h b/security/apparmor/include/file.h
> index 38f821bf49b6..076ac4501d97 100644
> --- a/security/apparmor/include/file.h
> +++ b/security/apparmor/include/file.h
> @@ -66,9 +66,6 @@ struct path;
>  #define AA_X_INHERIT		0x4000
>  #define AA_X_UNCONFINED		0x8000
>  
> -/* AA_SECURE_X_NEEDED - is passed in the bprm->unsafe field */
> -#define AA_SECURE_X_NEEDED	0x8000
> -
>  /* need to make conditional which ones are being set */
>  struct path_cond {
>  	kuid_t uid;
> diff --git a/security/apparmor/lsm.c b/security/apparmor/lsm.c
> index 8f3c0f7aca5a..291c7126350f 100644
> --- a/security/apparmor/lsm.c
> +++ b/security/apparmor/lsm.c
> @@ -624,7 +624,6 @@ static struct security_hook_list apparmor_hooks[] __lsm_ro_after_init = {
>  	LSM_HOOK_INIT(bprm_set_creds, apparmor_bprm_set_creds),
>  	LSM_HOOK_INIT(bprm_committing_creds, apparmor_bprm_committing_creds),
>  	LSM_HOOK_INIT(bprm_committed_creds, apparmor_bprm_committed_creds),
> -	LSM_HOOK_INIT(bprm_secureexec, apparmor_bprm_secureexec),
>  
>  	LSM_HOOK_INIT(task_setrlimit, apparmor_task_setrlimit),
>  };
> 

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
