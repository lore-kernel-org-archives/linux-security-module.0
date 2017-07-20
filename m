From: paul@paul-moore.com (Paul Moore)
Date: Wed, 19 Jul 2017 20:03:30 -0400
Subject: [PATCH v3 04/15] selinux: Refactor to remove bprm_secureexec hook
In-Reply-To: <1500416736-49829-5-git-send-email-keescook@chromium.org>
References: <1500416736-49829-1-git-send-email-keescook@chromium.org>
	<1500416736-49829-5-git-send-email-keescook@chromium.org>
Message-ID: <CAHC9VhTLP7kpJW65y_csgnc9hvp8ouB36U2WPyHGYgGtq8M4hg@mail.gmail.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Tue, Jul 18, 2017 at 6:25 PM, Kees Cook <keescook@chromium.org> wrote:
> The SELinux bprm_secureexec hook can be merged with the bprm_set_creds
> hook since it's dealing with the same information, and all of the details
> are finalized during the first call to the bprm_set_creds hook via
> prepare_binprm() (subsequent calls due to binfmt_script, etc, are ignored
> via bprm->called_set_creds).
>
> Here, the test can just happen at the end of the bprm_set_creds hook,
> and the bprm_secureexec hook can be dropped.
>
> Cc: Paul Moore <paul@paul-moore.com>
> Cc: Stephen Smalley <sds@tycho.nsa.gov>
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
>  security/selinux/hooks.c | 24 +++++-------------------
>  1 file changed, 5 insertions(+), 19 deletions(-)

This seems reasonable in the context of the other changes.

Stephen just posted an AT_SECURE test for the selinux-testsuite on the
SELinux mailing list, it would be nice to ensure that this patchset
doesn't run afoul of that.

Acked-by: Paul Moore <paul@paul-moore.com>

> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index 0f1450a06b02..18038f73a2f7 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -2413,30 +2413,17 @@ static int selinux_bprm_set_creds(struct linux_binprm *bprm)
>
>                 /* Clear any possibly unsafe personality bits on exec: */
>                 bprm->per_clear |= PER_CLEAR_ON_SETID;
> -       }
> -
> -       return 0;
> -}
> -
> -static int selinux_bprm_secureexec(struct linux_binprm *bprm)
> -{
> -       const struct task_security_struct *tsec = current_security();
> -       u32 sid, osid;
> -       int atsecure = 0;
> -
> -       sid = tsec->sid;
> -       osid = tsec->osid;
>
> -       if (osid != sid) {
>                 /* Enable secure mode for SIDs transitions unless
>                    the noatsecure permission is granted between
>                    the two SIDs, i.e. ahp returns 0. */
> -               atsecure = avc_has_perm(osid, sid,
> -                                       SECCLASS_PROCESS,
> -                                       PROCESS__NOATSECURE, NULL);
> +               rc = avc_has_perm(old_tsec->sid, new_tsec->sid,
> +                                 SECCLASS_PROCESS, PROCESS__NOATSECURE,
> +                                 NULL);
> +               bprm->secureexec |= !!rc;
>         }
>
> -       return !!atsecure;
> +       return 0;
>  }
>
>  static int match_file(const void *p, struct file *file, unsigned fd)
> @@ -6151,7 +6138,6 @@ static struct security_hook_list selinux_hooks[] __lsm_ro_after_init = {
>         LSM_HOOK_INIT(bprm_set_creds, selinux_bprm_set_creds),
>         LSM_HOOK_INIT(bprm_committing_creds, selinux_bprm_committing_creds),
>         LSM_HOOK_INIT(bprm_committed_creds, selinux_bprm_committed_creds),
> -       LSM_HOOK_INIT(bprm_secureexec, selinux_bprm_secureexec),
>
>         LSM_HOOK_INIT(sb_alloc_security, selinux_sb_alloc_security),
>         LSM_HOOK_INIT(sb_free_security, selinux_sb_free_security),
> --
> 2.7.4

-- 
paul moore
www.paul-moore.com
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
