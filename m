From: keescook@chromium.org (Kees Cook)
Date: Wed, 5 Apr 2017 10:34:20 -0700
Subject: [PATCH 14/24] x86: Restrict MSR access when the kernel is locked
	down
In-Reply-To: <149141232449.31282.15045536717220570492.stgit@warthog.procyon.org.uk>
References: <149141219387.31282.6648284836568938717.stgit@warthog.procyon.org.uk>
	<149141232449.31282.15045536717220570492.stgit@warthog.procyon.org.uk>
Message-ID: <CAGXu5jJoyPWnh6cu5D1xNjt8o3QTsYPJ5Z02U2t1NkmZf+7Yow@mail.gmail.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Wed, Apr 5, 2017 at 10:12 AM, David Howells <dhowells@redhat.com> wrote:
> From: Matthew Garrett <matthew.garrett@nebula.com>
>
> Writing to MSRs should not be allowed if the kernel is locked down, since
> it could lead to execution of arbitrary code in kernel mode.  Based on a
> patch by Kees Cook.
>
> Cc: Kees Cook <keescook@chromium.org>
> Signed-off-by: Matthew Garrett <matthew.garrett@nebula.com>
> Signed-off-by: David Howells <dhowells@redhat.com>

Acked-by: Kees Cook <keescook@chromium.org>

-Kees

> ---
>
>  arch/x86/kernel/msr.c |    7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/arch/x86/kernel/msr.c b/arch/x86/kernel/msr.c
> index ef688804f80d..fbcce028e502 100644
> --- a/arch/x86/kernel/msr.c
> +++ b/arch/x86/kernel/msr.c
> @@ -84,6 +84,9 @@ static ssize_t msr_write(struct file *file, const char __user *buf,
>         int err = 0;
>         ssize_t bytes = 0;
>
> +       if (kernel_is_locked_down())
> +               return -EPERM;
> +
>         if (count % 8)
>                 return -EINVAL; /* Invalid chunk size */
>
> @@ -131,6 +134,10 @@ static long msr_ioctl(struct file *file, unsigned int ioc, unsigned long arg)
>                         err = -EBADF;
>                         break;
>                 }
> +               if (kernel_is_locked_down()) {
> +                       err = -EPERM;
> +                       break;
> +               }
>                 if (copy_from_user(&regs, uregs, sizeof regs)) {
>                         err = -EFAULT;
>                         break;
>



-- 
Kees Cook
Pixel Security
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
