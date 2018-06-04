From: serge@hallyn.com (Serge E. Hallyn)
Date: Mon, 4 Jun 2018 15:00:11 -0500
Subject: [PATCH v4 2/8] kexec: add call to LSM hook in original
	kexec_load syscall
In-Reply-To: <1527616920-5415-3-git-send-email-zohar@linux.vnet.ibm.com>
References: <1527616920-5415-1-git-send-email-zohar@linux.vnet.ibm.com>
	<1527616920-5415-3-git-send-email-zohar@linux.vnet.ibm.com>
Message-ID: <20180604200011.GC14454@mail.hallyn.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Quoting Mimi Zohar (zohar at linux.vnet.ibm.com):
> In order for LSMs and IMA-appraisal to differentiate between kexec_load
> and kexec_file_load syscalls, both the original and new syscalls must
> call an LSM hook.  This patch adds a call to security_kernel_load_data()
> in the original kexec_load syscall.
> 
> Signed-off-by: Mimi Zohar <zohar@linux.vnet.ibm.com>
> Cc: Eric Biederman <ebiederm@xmission.com>

Acked-by: Serge Hallyn <serge@hallyn.com>

> Cc: Luis R. Rodriguez <mcgrof@kernel.org>
> Cc: Kees Cook <keescook@chromium.org>
> Cc: David Howells <dhowells@redhat.com>
> ---
>  kernel/kexec.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/kernel/kexec.c b/kernel/kexec.c
> index aed8fb2564b3..68559808fdfa 100644
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
> +	result = security_kernel_load_data(LOADING_KEXEC_IMAGE);
> +	if (result < 0)
> +		return result;
> +
>  	/*
>  	 * Verify we have a legal set of flags
>  	 * This leaves us room for future extensions.
> -- 
> 2.7.5
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
