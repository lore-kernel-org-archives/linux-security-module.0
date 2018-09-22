From: keescook@chromium.org (Kees Cook)
Date: Fri, 21 Sep 2018 19:43:16 -0700
Subject: [PATCH v4 04/19] SELinux: Remove cred security blob poisoning
In-Reply-To: <5360cd42-5827-58af-515c-6e1ded1d9154@schaufler-ca.com>
References: <e9bfb2d5-d987-55ce-4011-9b32ff745d36@schaufler-ca.com>
	<5360cd42-5827-58af-515c-6e1ded1d9154@schaufler-ca.com>
Message-ID: <CAGXu5j+9w-+i2F3-w=5QRzNEC1QaF_nwSZRgdLk+M4LpwmZ2Qg@mail.gmail.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Fri, Sep 21, 2018 at 5:17 PM, Casey Schaufler <casey@schaufler-ca.com> wrote:
> The SELinux specific credential poisioning only makes sense
> if SELinux is managing the credentials. As the intent of this
> patch set is to move the blob management out of the modules
> and into the infrastructure, the SELinux specific code has
> to go. The poisioning could be introduced into the infrastructure
> at some later date.
>
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees


> ---
>  kernel/cred.c            | 13 -------------
>  security/selinux/hooks.c |  6 ------
>  2 files changed, 19 deletions(-)
>
> diff --git a/kernel/cred.c b/kernel/cred.c
> index ecf03657e71c..fa2061ee4955 100644
> --- a/kernel/cred.c
> +++ b/kernel/cred.c
> @@ -704,19 +704,6 @@ bool creds_are_invalid(const struct cred *cred)
>  {
>         if (cred->magic != CRED_MAGIC)
>                 return true;
> -#ifdef CONFIG_SECURITY_SELINUX
> -       /*
> -        * cred->security == NULL if security_cred_alloc_blank() or
> -        * security_prepare_creds() returned an error.
> -        */
> -       if (selinux_is_enabled() && cred->security) {
> -               if ((unsigned long) cred->security < PAGE_SIZE)
> -                       return true;
> -               if ((*(u32 *)cred->security & 0xffffff00) ==
> -                   (POISON_FREE << 24 | POISON_FREE << 16 | POISON_FREE << 8))
> -                       return true;
> -       }
> -#endif
>         return false;
>  }
>  EXPORT_SYMBOL(creds_are_invalid);
> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index 9d6cdd21acb6..80614ca25a2b 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -3920,12 +3920,6 @@ static void selinux_cred_free(struct cred *cred)
>  {
>         struct task_security_struct *tsec = selinux_cred(cred);
>
> -       /*
> -        * cred->security == NULL if security_cred_alloc_blank() or
> -        * security_prepare_creds() returned an error.
> -        */
> -       BUG_ON(cred->security && (unsigned long) cred->security < PAGE_SIZE);
> -       cred->security = (void *) 0x7UL;
>         kfree(tsec);
>  }
>
> --
> 2.17.1
>
>



-- 
Kees Cook
Pixel Security
