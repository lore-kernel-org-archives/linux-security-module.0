From: keescook@chromium.org (Kees Cook)
Date: Fri, 8 Sep 2017 11:26:04 -0700
Subject: [PATCH V4 07/10] capabilities: remove a layer of conditional logic
In-Reply-To: <18bed6fb4554fe339fd7e9747b1ff7dc87e8c45a.1504591358.git.rgb@redhat.com>
References: <cover.1504591358.git.rgb@redhat.com>
	<18bed6fb4554fe339fd7e9747b1ff7dc87e8c45a.1504591358.git.rgb@redhat.com>
Message-ID: <CAGXu5jL9dv1KTfhNmYQ55cJqX_b-2j_wVgd+R5SEJWKM_+DQ8Q@mail.gmail.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Mon, Sep 4, 2017 at 11:46 PM, Richard Guy Briggs <rgb@redhat.com> wrote:
> Remove a layer of conditional logic to make the use of conditions
> easier to read and analyse.
>
> Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
> Reviewed-by: Serge Hallyn <serge@hallyn.com>
> Acked-by: James Morris <james.l.morris@oracle.com>

Acked-by: Kees Cook <keescook@chromium.org>

-Kees

> ---
>  security/commoncap.c |   23 ++++++++++-------------
>  1 files changed, 10 insertions(+), 13 deletions(-)
>
> diff --git a/security/commoncap.c b/security/commoncap.c
> index eae7431..cf95d73 100644
> --- a/security/commoncap.c
> +++ b/security/commoncap.c
> @@ -543,13 +543,12 @@ static inline bool nonroot_raised_pE(struct cred *cred, kuid_t root)
>  {
>         bool ret = false;
>
> -       if (__cap_grew(effective, ambient, cred)) {
> -               if (!__cap_full(effective, cred) ||
> -                   !__is_eff(root, cred) || !__is_real(root, cred) ||
> -                   !root_privileged()) {
> -                       ret = true;
> -               }
> -       }
> +       if (__cap_grew(effective, ambient, cred) &&
> +           (!__cap_full(effective, cred) ||
> +            !__is_eff(root, cred) ||
> +            !__is_real(root, cred) ||
> +            !root_privileged()))
> +               ret = true;
>         return ret;
>  }
>
> @@ -643,13 +642,11 @@ int cap_bprm_set_creds(struct linux_binprm *bprm)
>
>         /* Check for privilege-elevated exec. */
>         bprm->cap_elevated = 0;
> -       if (is_setid) {
> +       if (is_setid ||
> +           (!__is_real(root_uid, new) &&
> +            (effective ||
> +             __cap_grew(permitted, ambient, new))))
>                 bprm->cap_elevated = 1;
> -       } else if (!__is_real(root_uid, new)) {
> -               if (effective ||
> -                   __cap_grew(permitted, ambient, new))
> -                       bprm->cap_elevated = 1;
> -       }
>
>         return 0;
>  }
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
