From: keescook@chromium.org (Kees Cook)
Date: Thu, 7 Sep 2017 12:42:11 -0700
Subject: [PATCH V4 01/10] capabilities: factor out cap_bprm_set_creds
	privileged root
In-Reply-To: <c9900dda93bac311a7ce7da753eb430905301276.1504591358.git.rgb@redhat.com>
References: <cover.1504591358.git.rgb@redhat.com>
	<c9900dda93bac311a7ce7da753eb430905301276.1504591358.git.rgb@redhat.com>
Message-ID: <CAGXu5jLEU_SMacBtX3jOqih0OoAEUqWH8J2wqj+AkDKhsZgGQQ@mail.gmail.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Mon, Sep 4, 2017 at 11:46 PM, Richard Guy Briggs <rgb@redhat.com> wrote:
> Factor out the case of privileged root from the function
> cap_bprm_set_creds() to make the latter easier to read and analyse.
>
> Suggested-by: Serge Hallyn <serge@hallyn.com>
> Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
> Reviewed-by: Serge Hallyn <serge@hallyn.com>

Acked-by: Kees Cook <keescook@chromium.org>

Note below...

> ---
>  security/commoncap.c |   63 +++++++++++++++++++++++++++----------------------
>  1 files changed, 35 insertions(+), 28 deletions(-)
>
> diff --git a/security/commoncap.c b/security/commoncap.c
> index d8e26fb..927fe93 100644
> --- a/security/commoncap.c
> +++ b/security/commoncap.c
> @@ -472,6 +472,39 @@ static int get_file_caps(struct linux_binprm *bprm, bool *effective, bool *has_c
>         return rc;
>  }
>
> +static void handle_privileged_root(struct linux_binprm *bprm, bool has_cap,
> +                                  bool *effective, kuid_t root_uid)

If you do a v5 of this, I think it'd be nice to add a comment here
describing what is being checked and the side-effects (i.e.
cap_permitted changes, when effective is set, etc).

-Kees

> +{
> +       const struct cred *old = current_cred();
> +       struct cred *new = bprm->cred;
> +
> +       if (issecure(SECURE_NOROOT))
> +               return;
> +       /*
> +        * If the legacy file capability is set, then don't set privs
> +        * for a setuid root binary run by a non-root user.  Do set it
> +        * for a root user just to cause least surprise to an admin.
> +        */
> +       if (has_cap && !uid_eq(new->uid, root_uid) && uid_eq(new->euid, root_uid)) {
> +               warn_setuid_and_fcaps_mixed(bprm->filename);
> +               return;
> +       }
> +       /*
> +        * To support inheritance of root-permissions and suid-root
> +        * executables under compatibility mode, we override the
> +        * capability sets for the file.
> +        *
> +        * If only the real uid is 0, we do not set the effective bit.
> +        */
> +       if (uid_eq(new->euid, root_uid) || uid_eq(new->uid, root_uid)) {
> +               /* pP' = (cap_bset & ~0) | (pI & ~0) */
> +               new->cap_permitted = cap_combine(old->cap_bset,
> +                                                old->cap_inheritable);
> +       }
> +       if (uid_eq(new->euid, root_uid))
> +               *effective = true;
> +}
> +
>  /**
>   * cap_bprm_set_creds - Set up the proposed credentials for execve().
>   * @bprm: The execution parameters, including the proposed creds
> @@ -484,46 +517,20 @@ int cap_bprm_set_creds(struct linux_binprm *bprm)
>  {
>         const struct cred *old = current_cred();
>         struct cred *new = bprm->cred;
> -       bool effective, has_cap = false, is_setid;
> +       bool effective = false, has_cap = false, is_setid;
>         int ret;
>         kuid_t root_uid;
>
>         if (WARN_ON(!cap_ambient_invariant_ok(old)))
>                 return -EPERM;
>
> -       effective = false;
>         ret = get_file_caps(bprm, &effective, &has_cap);
>         if (ret < 0)
>                 return ret;
>
>         root_uid = make_kuid(new->user_ns, 0);
>
> -       if (!issecure(SECURE_NOROOT)) {
> -               /*
> -                * If the legacy file capability is set, then don't set privs
> -                * for a setuid root binary run by a non-root user.  Do set it
> -                * for a root user just to cause least surprise to an admin.
> -                */
> -               if (has_cap && !uid_eq(new->uid, root_uid) && uid_eq(new->euid, root_uid)) {
> -                       warn_setuid_and_fcaps_mixed(bprm->filename);
> -                       goto skip;
> -               }
> -               /*
> -                * To support inheritance of root-permissions and suid-root
> -                * executables under compatibility mode, we override the
> -                * capability sets for the file.
> -                *
> -                * If only the real uid is 0, we do not set the effective bit.
> -                */
> -               if (uid_eq(new->euid, root_uid) || uid_eq(new->uid, root_uid)) {
> -                       /* pP' = (cap_bset & ~0) | (pI & ~0) */
> -                       new->cap_permitted = cap_combine(old->cap_bset,
> -                                                        old->cap_inheritable);
> -               }
> -               if (uid_eq(new->euid, root_uid))
> -                       effective = true;
> -       }
> -skip:
> +       handle_privileged_root(bprm, has_cap, &effective, root_uid);
>
>         /* if we have fs caps, clear dangerous personality flags */
>         if (!cap_issubset(new->cap_permitted, old->cap_permitted))
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
