From: keescook@chromium.org (Kees Cook)
Date: Thu, 20 Sep 2018 10:25:28 -0700
Subject: [PATCH v3 10/16] LSM: Infrastructure management of the file
	security blob
In-Reply-To: <5b95b037-521f-3402-2097-c0f9c427d235@schaufler-ca.com>
References: <748c61cb-b6fa-c36d-a7b3-2315ff6292af@schaufler-ca.com>
	<5b95b037-521f-3402-2097-c0f9c427d235@schaufler-ca.com>
Message-ID: <CAGXu5jKUfHAK-cFj0YtqqGXypFGigpWNitVOPJx9SubSbnfkzw@mail.gmail.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Wed, Sep 19, 2018 at 5:21 PM, Casey Schaufler <casey@schaufler-ca.com> wrote:
> diff --git a/security/smack/smack.h b/security/smack/smack.h
> index 01a922856eba..62a22ad8ce92 100644
> --- a/security/smack/smack.h
> +++ b/security/smack/smack.h
> @@ -361,6 +361,11 @@ static inline struct task_smack *smack_cred(const struct cred *cred)
>         return cred->security;
>  }
>
> +static inline struct smack_known **smack_file(const struct file *file)
> +{
> +       return file->f_security;
> +}
> +

This (and related) still needs splitting out into it's own refactoring
patch for Smack.

-Kees

-- 
Kees Cook
Pixel Security
