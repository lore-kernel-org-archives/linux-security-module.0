From: keescook@chromium.org (Kees Cook)
Date: Fri, 8 Sep 2017 11:22:18 -0700
Subject: [PATCH V4 05/10] capabilities: use intuitive names for id changes
In-Reply-To: <89d36249a96b5dce96c30608916e5c2aa2b77744.1504591358.git.rgb@redhat.com>
References: <cover.1504591358.git.rgb@redhat.com>
	<89d36249a96b5dce96c30608916e5c2aa2b77744.1504591358.git.rgb@redhat.com>
Message-ID: <CAGXu5jKPFFULZMTv2jgsqOy1m+9eV4yOHDihU51gY9ajQOVdAg@mail.gmail.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Mon, Sep 4, 2017 at 11:46 PM, Richard Guy Briggs <rgb@redhat.com> wrote:
> Introduce a number of inlines to make the use of the negation of
> uid_eq() easier to read and analyse.
>
> Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
> Reviewed-by: Serge Hallyn <serge@hallyn.com>
> Acked-by: James Morris <james.l.morris@oracle.com>

Acked-by: Kees Cook <keescook@chromium.org>

-Kees

> ---
>  security/commoncap.c |   28 ++++++++++++++++++++++------
>  1 files changed, 22 insertions(+), 6 deletions(-)
>
> diff --git a/security/commoncap.c b/security/commoncap.c
> index 1904f49..d37ebec 100644
> --- a/security/commoncap.c
> +++ b/security/commoncap.c
> @@ -474,6 +474,15 @@ static int get_file_caps(struct linux_binprm *bprm, bool *effective, bool *has_f
>
>  static inline bool root_privileged(void) { return !issecure(SECURE_NOROOT); }
>
> +static inline bool __is_real(kuid_t uid, struct cred *cred)
> +{ return uid_eq(cred->uid, uid); }
> +
> +static inline bool __is_eff(kuid_t uid, struct cred *cred)
> +{ return uid_eq(cred->euid, uid); }
> +
> +static inline bool __is_suid(kuid_t uid, struct cred *cred)
> +{ return !__is_real(uid, cred) && __is_eff(uid, cred); }
> +
>  static void handle_privileged_root(struct linux_binprm *bprm, bool has_fcap,
>                                    bool *effective, kuid_t root_uid)
>  {
> @@ -485,7 +494,7 @@ static void handle_privileged_root(struct linux_binprm *bprm, bool has_fcap,
>          * for a setuid root binary run by a non-root user.  Do set it
>          * for a root user just to cause least surprise to an admin.
>          */
> -       if (has_fcap && !uid_eq(new->uid, root_uid) && uid_eq(new->euid, root_uid)) {
> +       if (has_fcap && __is_suid(root_uid, new)) {
>                 warn_setuid_and_fcaps_mixed(bprm->filename);
>                 return;
>         }
> @@ -496,12 +505,12 @@ static void handle_privileged_root(struct linux_binprm *bprm, bool has_fcap,
>          *
>          * If only the real uid is 0, we do not set the effective bit.
>          */
> -       if (uid_eq(new->euid, root_uid) || uid_eq(new->uid, root_uid)) {
> +       if (__is_eff(root_uid, new) || __is_real(root_uid, new)) {
>                 /* pP' = (cap_bset & ~0) | (pI & ~0) */
>                 new->cap_permitted = cap_combine(old->cap_bset,
>                                                  old->cap_inheritable);
>         }
> -       if (uid_eq(new->euid, root_uid))
> +       if (__is_eff(root_uid, new))
>                 *effective = true;
>  }
>
> @@ -511,6 +520,13 @@ static void handle_privileged_root(struct linux_binprm *bprm, bool has_fcap,
>         !cap_issubset(cred->cap_##target, cred->cap_##source)
>  #define __cap_full(field, cred) \
>         cap_issubset(CAP_FULL_SET, cred->cap_##field)
> +
> +static inline bool __is_setuid(struct cred *new, const struct cred *old)
> +{ return !uid_eq(new->euid, old->uid); }
> +
> +static inline bool __is_setgid(struct cred *new, const struct cred *old)
> +{ return !gid_eq(new->egid, old->gid); }
> +
>  /**
>   * cap_bprm_set_creds - Set up the proposed credentials for execve().
>   * @bprm: The execution parameters, including the proposed creds
> @@ -548,7 +564,7 @@ int cap_bprm_set_creds(struct linux_binprm *bprm)
>          *
>          * In addition, if NO_NEW_PRIVS, then ensure we get no new privs.
>          */
> -       is_setid = !uid_eq(new->euid, old->uid) || !gid_eq(new->egid, old->gid);
> +       is_setid = __is_setuid(new, old) || __is_setgid(new, old);
>
>         if ((is_setid || __cap_gained(permitted, new, old)) &&
>             ((bprm->unsafe & ~LSM_UNSAFE_PTRACE) ||
> @@ -602,7 +618,7 @@ int cap_bprm_set_creds(struct linux_binprm *bprm)
>          */
>         if (__cap_grew(effective, ambient, new)) {
>                 if (!__cap_full(effective, new) ||
> -                   !uid_eq(new->euid, root_uid) || !uid_eq(new->uid, root_uid) ||
> +                   !__is_eff(root_uid, new) || !__is_real(root_uid, new) ||
>                     !root_privileged()) {
>                         ret = audit_log_bprm_fcaps(bprm, new, old);
>                         if (ret < 0)
> @@ -619,7 +635,7 @@ int cap_bprm_set_creds(struct linux_binprm *bprm)
>         bprm->cap_elevated = 0;
>         if (is_setid) {
>                 bprm->cap_elevated = 1;
> -       } else if (!uid_eq(new->uid, root_uid)) {
> +       } else if (!__is_real(root_uid, new)) {
>                 if (effective ||
>                     __cap_grew(permitted, ambient, new))
>                         bprm->cap_elevated = 1;
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
