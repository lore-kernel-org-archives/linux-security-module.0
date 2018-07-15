From: keescook@chromium.org (Kees Cook)
Date: Sat, 14 Jul 2018 19:21:38 -0700
Subject: [PATCH v6 3/8] ima: based on policy require signed kexec kernel
	images
In-Reply-To: <1531505163-20227-4-git-send-email-zohar@linux.vnet.ibm.com>
References: <1531505163-20227-1-git-send-email-zohar@linux.vnet.ibm.com>
	<1531505163-20227-4-git-send-email-zohar@linux.vnet.ibm.com>
Message-ID: <CAGXu5jKDE0mPzi8RUhsViEwjhZX1=M-xU4DEa70tk3i2tN+rPA@mail.gmail.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Fri, Jul 13, 2018 at 11:05 AM, Mimi Zohar <zohar@linux.vnet.ibm.com> wrote:
> The original kexec_load syscall can not verify file signatures, nor can
> the kexec image be measured.  Based on policy, deny the kexec_load
> syscall.
>
> Signed-off-by: Mimi Zohar <zohar@linux.vnet.ibm.com>
> Cc: Eric Biederman <ebiederm@xmission.com>
> Cc: Kees Cook <keescook@chromium.org>

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

-- 
Kees Cook
Pixel Security
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
