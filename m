From: keescook@chromium.org (Kees Cook)
Date: Sat, 14 Jul 2018 19:28:28 -0700
Subject: [PATCH v6 6/8] ima: add build time policy
In-Reply-To: <1531505163-20227-7-git-send-email-zohar@linux.vnet.ibm.com>
References: <1531505163-20227-1-git-send-email-zohar@linux.vnet.ibm.com>
	<1531505163-20227-7-git-send-email-zohar@linux.vnet.ibm.com>
Message-ID: <CAGXu5jL8_nbUKKNO-PCyGwOdQ+vjPZ7_17FKNH1fssgtfjk=Rw@mail.gmail.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Fri, Jul 13, 2018 at 11:06 AM, Mimi Zohar <zohar@linux.vnet.ibm.com> wrote:
> IMA by default does not measure, appraise or audit files, but can be
> enabled at runtime by specifying a builtin policy on the boot command line
> or by loading a custom policy.
>
> This patch defines a build time policy, which verifies kernel modules,
> firmware, kexec image, and/or the IMA policy signatures.  This build time
> policy is automatically enabled at runtime and persists after loading a
> custom policy.
>
> Signed-off-by: Mimi Zohar <zohar@linux.vnet.ibm.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

-- 
Kees Cook
Pixel Security
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
