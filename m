From: keescook@chromium.org (Kees Cook)
Date: Thu, 20 Sep 2018 10:56:30 -0700
Subject: [PATCH v3 16/16] LSM: Blob sharing support for S.A.R.A and
	LandLock
In-Reply-To: <8ef63a94-c7b6-226d-2d60-a05f79406819@schaufler-ca.com>
References: <748c61cb-b6fa-c36d-a7b3-2315ff6292af@schaufler-ca.com>
	<8ef63a94-c7b6-226d-2d60-a05f79406819@schaufler-ca.com>
Message-ID: <CAGXu5j+aWyiQ_aGCkeoyvYC7Aj2hfuvKei+SAOMrfOWyfpP8xw@mail.gmail.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Wed, Sep 19, 2018 at 5:21 PM, Casey Schaufler <casey@schaufler-ca.com> wrote:
> diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
> index 8f3b809d7c26..0156ffea7f8c 100644
> --- a/security/smack/smack_lsm.c
> +++ b/security/smack/smack_lsm.c
> @@ -3475,18 +3475,16 @@ static int smack_getprocattr(struct task_struct *p, char *name, char **value)
>  {
>         struct smack_known *skp = smk_of_task_struct(p);
>         char *cp;
> -       int slen;
>
> -       if (strcmp(name, "current") != 0)
> +       if (strcmp(name, "current") == 0) {
> +               cp = kstrdup(skp->smk_known, GFP_KERNEL);
> +               if (cp == NULL)
> +                       return -ENOMEM;
> +       } else
>                 return -EINVAL;
>
> -       cp = kstrdup(skp->smk_known, GFP_KERNEL);
> -       if (cp == NULL)
> -               return -ENOMEM;
> -
> -       slen = strlen(cp);
>         *value = cp;
> -       return slen;
> +       return strlen(cp);
>  }

This should be separate: it looks like unrelated refactoring? (I
mentioned this before, I think?)

> diff --git a/security/tomoyo/common.h b/security/tomoyo/common.h
> index 0110bebe86e2..f386f92c57c5 100644
> --- a/security/tomoyo/common.h
> +++ b/security/tomoyo/common.h
> @@ -1216,8 +1221,13 @@ static inline struct tomoyo_domain_info **tomoyo_cred(const struct cred *cred)
>   */
>  static inline struct tomoyo_domain_info *tomoyo_domain(void)
>  {
> -       struct tomoyo_domain_info **blob = tomoyo_cred(current_cred());
> +       const struct cred *cred = current_cred();
> +       struct tomoyo_domain_info **blob;
> +
> +       if (cred->security == NULL)
> +               return NULL;
>
> +       blob = tomoyo_cred(cred);
>         return *blob;
>  }

I think this is another lost hunk?

-Kees

-- 
Kees Cook
Pixel Security
