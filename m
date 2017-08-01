From: keescook@chromium.org (Kees Cook)
Date: Mon, 31 Jul 2017 17:23:31 -0700
Subject: [PATCH v4 03/15] binfmt: Introduce secureexec flag
In-Reply-To: <1501545093-56634-4-git-send-email-keescook@chromium.org>
References: <1501545093-56634-1-git-send-email-keescook@chromium.org>
	<1501545093-56634-4-git-send-email-keescook@chromium.org>
Message-ID: <CAGXu5j+Ubbp6guLUUDF7PuF7chbj5V1M=VjkjYfif=hW9bst9w@mail.gmail.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Mon, Jul 31, 2017 at 4:51 PM, Kees Cook <keescook@chromium.org> wrote:
> diff --git a/include/linux/binfmts.h b/include/linux/binfmts.h
> index 3cd98e8bc9dc..6cfd36a27d4e 100644
> --- a/include/linux/binfmts.h
> +++ b/include/linux/binfmts.h
> @@ -34,6 +34,12 @@ struct linux_binprm {
>                 cap_effective:1;/* true if has elevated effective capabilities,
>                                  * false if not; except for init which inherits
>                                  * its parent's caps anyway */
> +               /*
> +                * Set by bprm_set_creds hook to indicate a privilege-gaining
> +                * exec has happened. Used to sanitize execution environment
> +                * and to set AT_SECURE auxv for glibc.
> +                */
> +               secureexec:1;
>  #ifdef __alpha__
>         unsigned int taso:1;
>  #endif

Grrr. git rebase messed me up. (; vs , in variable list.) I will send
a v5 and double-check the per-patch builds. Bleh.

-Kees

-- 
Kees Cook
Pixel Security
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
