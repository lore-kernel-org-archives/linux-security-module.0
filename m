From: ebiederm@xmission.com (Eric W. Biederman)
Date: Thu, 24 May 2018 15:50:03 -0500
Subject: [PATCH v3 2/7] kexec: add call to LSM hook in original kexec_load
	syscall
In-Reply-To: <1527160176-29269-3-git-send-email-zohar@linux.vnet.ibm.com>
	(Mimi Zohar's message of "Thu, 24 May 2018 07:09:31 -0400")
References: <1527160176-29269-1-git-send-email-zohar@linux.vnet.ibm.com>
	<1527160176-29269-3-git-send-email-zohar@linux.vnet.ibm.com>
Message-ID: <87k1rs22ys.fsf@xmission.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Mimi Zohar <zohar@linux.vnet.ibm.com> writes:

> In order for LSMs and IMA-appraisal to differentiate between the
> original and new syscalls, both the original and new syscalls must call
> an LSM hook.  This patch adds a call to security_kernel_read_data() in
> the original kexec syscall.

Until the lsm hook mess gets cleaned up.

Nacked-by: "Eric W. Biederman" <ebiederm@xmission.com>

>
> Signed-off-by: Mimi Zohar <zohar@linux.vnet.ibm.com>
> Cc: Eric Biederman <ebiederm@xmission.com>
> Cc: Luis R. Rodriguez <mcgrof@kernel.org>
> Cc: Kees Cook <keescook@chromium.org>
> Cc: David Howells <dhowells@redhat.com>
> ---
>  kernel/kexec.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/kernel/kexec.c b/kernel/kexec.c
> index aed8fb2564b3..061ada41c18c 100644
> --- a/kernel/kexec.c
> +++ b/kernel/kexec.c
> @@ -11,6 +11,7 @@
>  #include <linux/capability.h>
>  #include <linux/mm.h>
>  #include <linux/file.h>
> +#include <linux/security.h>
>  #include <linux/kexec.h>
>  #include <linux/mutex.h>
>  #include <linux/list.h>
> @@ -195,10 +196,17 @@ static int do_kexec_load(unsigned long entry, unsigned long nr_segments,
>  static inline int kexec_load_check(unsigned long nr_segments,
>  				   unsigned long flags)
>  {
> +	int result;
> +
>  	/* We only trust the superuser with rebooting the system. */
>  	if (!capable(CAP_SYS_BOOT) || kexec_load_disabled)
>  		return -EPERM;
>  
> +	/* Permit LSMs and IMA to fail the kexec */
> +	result = security_kernel_read_data(NULL, READING_KEXEC_IMAGE);
> +	if (result < 0)
> +		return result;
> +
>  	/*
>  	 * Verify we have a legal set of flags
>  	 * This leaves us room for future extensions.
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
