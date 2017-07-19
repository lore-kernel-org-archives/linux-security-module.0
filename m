From: luto@kernel.org (Andy Lutomirski)
Date: Tue, 18 Jul 2017 18:52:31 -0700
Subject: [PATCH v3 07/15] commoncap: Move cap_elevated calculation into
	bprm_set_creds
In-Reply-To: <1500416736-49829-8-git-send-email-keescook@chromium.org>
References: <1500416736-49829-1-git-send-email-keescook@chromium.org>
	<1500416736-49829-8-git-send-email-keescook@chromium.org>
Message-ID: <CALCETrV1C_Q0XW=OENQpE=Wf_zOYzNqPHDZmK5D4ufx0EACvyQ@mail.gmail.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Tue, Jul 18, 2017 at 3:25 PM, Kees Cook <keescook@chromium.org> wrote:
> Instead of a separate function, open-code the cap_elevated test, which
> lets us entirely remove bprm->cap_effective (to use the local "effective"
> variable instead), and more accurately examine euid/egid changes via the
> existing local "is_setid".

...

> -static int is_secureexec(struct linux_binprm *bprm)
> -{
> -       const struct cred *cred = bprm->cred;
> -       kuid_t root_uid = make_kuid(cred->user_ns, 0);
> -
> -       if (!uid_eq(cred->uid, root_uid)) {
> -               if (bprm->cap_effective)
> -                       return 1;
> -               if (!cap_issubset(cred->cap_permitted, cred->cap_ambient))
> -                       return 1;
> +       bprm->cap_elevated = 0;
> +       if (is_setid) {
> +               bprm->cap_elevated = 1;
> +       } else if (!uid_eq(new->uid, root_uid)) {
> +               if (effective ||
> +                   !cap_issubset(new->cap_permitted, new->cap_ambient))
> +                       bprm->cap_elevated = 1;
>         }
>
> -       return (!uid_eq(cred->euid, cred->uid) ||
> -               !gid_eq(cred->egid, cred->gid));
> +       return 0;

I think this matches the old behavior.  IOW it looks right.
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
