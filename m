From: keescook@chromium.org (Kees Cook)
Date: Thu, 7 Sep 2017 12:57:30 -0700
Subject: [PATCH V4 02/10] capabilities: intuitive names for cap gain status
In-Reply-To: <a36af00bd25e0cfe7eeea37bd99b82b9350de1e0.1504591358.git.rgb@redhat.com>
References: <cover.1504591358.git.rgb@redhat.com>
	<a36af00bd25e0cfe7eeea37bd99b82b9350de1e0.1504591358.git.rgb@redhat.com>
Message-ID: <CAGXu5jKnB555Tu-kNPpjRe76r8RpDghxqO1499aXa2M6Bnf3pQ@mail.gmail.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Mon, Sep 4, 2017 at 11:46 PM, Richard Guy Briggs <rgb@redhat.com> wrote:
> Introduce macros cap_gained, cap_grew, cap_full to make the use of the
> negation of is_subset() easier to read and analyse.
>
> Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
> Reviewed-by: Serge Hallyn <serge@hallyn.com>
> Acked-by: James Morris <james.l.morris@oracle.com>

I still find these hard to read, but it IS better than it was before. ;)

Acked-by: Kees Cook <keescook@chromium.org>

> ---
>  security/commoncap.c |   18 +++++++++++-------
>  1 files changed, 11 insertions(+), 7 deletions(-)
>
> diff --git a/security/commoncap.c b/security/commoncap.c
> index 927fe93..cf6e2b0 100644
> --- a/security/commoncap.c
> +++ b/security/commoncap.c
> @@ -505,6 +505,12 @@ static void handle_privileged_root(struct linux_binprm *bprm, bool has_cap,
>                 *effective = true;
>  }
>
> +#define __cap_gained(field, target, source) \
> +       !cap_issubset(target->cap_##field, source->cap_##field)
> +#define __cap_grew(target, source, cred) \
> +       !cap_issubset(cred->cap_##target, cred->cap_##source)
> +#define __cap_full(field, cred) \
> +       cap_issubset(CAP_FULL_SET, cred->cap_##field)
>
>  /**
>   * cap_bprm_set_creds - Set up the proposed credentials for execve().
>   * @bprm: The execution parameters, including the proposed creds
> @@ -533,10 +539,9 @@ int cap_bprm_set_creds(struct linux_binprm *bprm)
>         handle_privileged_root(bprm, has_cap, &effective, root_uid);
>
>         /* if we have fs caps, clear dangerous personality flags */
> -       if (!cap_issubset(new->cap_permitted, old->cap_permitted))
> +       if (__cap_gained(permitted, new, old))
>                 bprm->per_clear |= PER_CLEAR_ON_SETID;
>
> -
>         /* Don't let someone trace a set[ug]id/setpcap binary with the revised
>          * credentials unless they have the appropriate permit.
>          *
> @@ -544,8 +549,7 @@ int cap_bprm_set_creds(struct linux_binprm *bprm)
>          */
>         is_setid = !uid_eq(new->euid, old->uid) || !gid_eq(new->egid, old->gid);
>
> -       if ((is_setid ||
> -            !cap_issubset(new->cap_permitted, old->cap_permitted)) &&
> +       if ((is_setid || __cap_gained(permitted, new, old)) &&
>             ((bprm->unsafe & ~LSM_UNSAFE_PTRACE) ||
>              !ptracer_capable(current, new->user_ns))) {
>                 /* downgrade; they get no more than they had, and maybe less */
> @@ -595,8 +599,8 @@ int cap_bprm_set_creds(struct linux_binprm *bprm)
>          * Number 1 above might fail if you don't have a full bset, but I think
>          * that is interesting information to audit.
>          */
> -       if (!cap_issubset(new->cap_effective, new->cap_ambient)) {
> -               if (!cap_issubset(CAP_FULL_SET, new->cap_effective) ||
> +       if (__cap_grew(effective, ambient, new)) {
> +               if (!__cap_full(effective, new) ||
>                     !uid_eq(new->euid, root_uid) || !uid_eq(new->uid, root_uid) ||
>                     issecure(SECURE_NOROOT)) {
>                         ret = audit_log_bprm_fcaps(bprm, new, old);
> @@ -616,7 +620,7 @@ int cap_bprm_set_creds(struct linux_binprm *bprm)
>                 bprm->cap_elevated = 1;
>         } else if (!uid_eq(new->uid, root_uid)) {
>                 if (effective ||
> -                   !cap_issubset(new->cap_permitted, new->cap_ambient))
> +                   __cap_grew(permitted, ambient, new))
>                         bprm->cap_elevated = 1;
>         }
>
> --
> 1.7.1
>



-- 
Kees Cook
Pixel Security
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
