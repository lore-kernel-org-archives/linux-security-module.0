From: keescook@chromium.org (Kees Cook)
Date: Fri, 8 Sep 2017 11:18:00 -0700
Subject: [PATCH V4 04/10] capabilities: use root_priveleged inline to
	clarify logic
In-Reply-To: <f74d6dd6691ab4bd2cc7bee1ac8f1c77614e459a.1504591358.git.rgb@redhat.com>
References: <cover.1504591358.git.rgb@redhat.com>
	<f74d6dd6691ab4bd2cc7bee1ac8f1c77614e459a.1504591358.git.rgb@redhat.com>
Message-ID: <CAGXu5jJGcgwxDmVdQnyQbKdEjg00Qm4dMNh3_K6G2EdAAf9YiA@mail.gmail.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Mon, Sep 4, 2017 at 11:46 PM, Richard Guy Briggs <rgb@redhat.com> wrote:
> Introduce inline root_privileged() to make use of SECURE_NONROOT
> easier to read.
>
> Suggested-by: Serge Hallyn <serge@hallyn.com>
> Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
> Reviewed-by: Serge Hallyn <serge@hallyn.com>
> Acked-by: James Morris <james.l.morris@oracle.com>
> ---
>  security/commoncap.c |    9 +++++----
>  1 files changed, 5 insertions(+), 4 deletions(-)
>
> diff --git a/security/commoncap.c b/security/commoncap.c
> index 623f251..1904f49 100644
> --- a/security/commoncap.c
> +++ b/security/commoncap.c
> @@ -472,14 +472,14 @@ static int get_file_caps(struct linux_binprm *bprm, bool *effective, bool *has_f
>         return rc;
>  }
>
> +static inline bool root_privileged(void) { return !issecure(SECURE_NOROOT); }
> +
>  static void handle_privileged_root(struct linux_binprm *bprm, bool has_fcap,
>                                    bool *effective, kuid_t root_uid)
>  {
>         const struct cred *old = current_cred();
>         struct cred *new = bprm->cred;
>
> -       if (issecure(SECURE_NOROOT))
> -               return;

Seems like it'd be better to just leave this check here (with the new
inline name). But if there's no v5, then consider it:

Acked-by: Kees Cook <keescook@chromium.org>

-Kees

>         /*
>          * If the legacy file capability is set, then don't set privs
>          * for a setuid root binary run by a non-root user.  Do set it
> @@ -536,7 +536,8 @@ int cap_bprm_set_creds(struct linux_binprm *bprm)
>
>         root_uid = make_kuid(new->user_ns, 0);
>
> -       handle_privileged_root(bprm, has_fcap, &effective, root_uid);
> +       if (root_privileged())
> +               handle_privileged_root(bprm, has_fcap, &effective, root_uid);
>
>         /* if we have fs caps, clear dangerous personality flags */
>         if (__cap_gained(permitted, new, old))
> @@ -602,7 +603,7 @@ int cap_bprm_set_creds(struct linux_binprm *bprm)
>         if (__cap_grew(effective, ambient, new)) {
>                 if (!__cap_full(effective, new) ||
>                     !uid_eq(new->euid, root_uid) || !uid_eq(new->uid, root_uid) ||
> -                   issecure(SECURE_NOROOT)) {
> +                   !root_privileged()) {
>                         ret = audit_log_bprm_fcaps(bprm, new, old);
>                         if (ret < 0)
>                                 return ret;
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
