From: keescook@chromium.org (Kees Cook)
Date: Sat, 14 Jul 2018 19:30:10 -0700
Subject: [PATCH v6 7/8] module: replace the existing LSM hook in
	init_module
In-Reply-To: <1531505163-20227-8-git-send-email-zohar@linux.vnet.ibm.com>
References: <1531505163-20227-1-git-send-email-zohar@linux.vnet.ibm.com>
	<1531505163-20227-8-git-send-email-zohar@linux.vnet.ibm.com>
Message-ID: <CAGXu5j+RvX+CKMP5PWjAPmDpvO4N+t1JQ3C5zr3F-y-T-AH_ng@mail.gmail.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Fri, Jul 13, 2018 at 11:06 AM, Mimi Zohar <zohar@linux.vnet.ibm.com> wrote:
> Both the init_module and finit_module syscalls call either directly
> or indirectly the security_kernel_read_file LSM hook.  This patch
> replaces the direct call in init_module with a call to the new
> security_kernel_load_data hook and makes the corresponding changes
> in SELinux, LoadPin, and IMA.
>
> Signed-off-by: Mimi Zohar <zohar@linux.vnet.ibm.com>
> Cc: Jeff Vander Stoep <jeffv@google.com>
> Cc: Casey Schaufler <casey@schaufler-ca.com>
> Cc: Kees Cook <keescook@chromium.org>
> Acked-by: Jessica Yu <jeyu@kernel.org>
> Acked-by: Paul Moore <paul@paul-moore.com>

Acked-by: Kees Cook <keescook@chromium.org>

Thanks!

-Kees

-- 
Kees Cook
Pixel Security
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
