From: keescook@chromium.org (Kees Cook)
Date: Sat, 14 Jul 2018 19:13:39 -0700
Subject: [PATCH v6 1/8] security: define new LSM hook named
	security_kernel_load_data
In-Reply-To: <1531505163-20227-2-git-send-email-zohar@linux.vnet.ibm.com>
References: <1531505163-20227-1-git-send-email-zohar@linux.vnet.ibm.com>
	<1531505163-20227-2-git-send-email-zohar@linux.vnet.ibm.com>
Message-ID: <CAGXu5jKU-cdYCQePZAr_eEUEsaK92kABFF=UowhaO6yuWVXEVA@mail.gmail.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Fri, Jul 13, 2018 at 11:05 AM, Mimi Zohar <zohar@linux.vnet.ibm.com> wrote:
> Differentiate between the kernel reading a file specified by userspace
> from the kernel loading a buffer containing data provided by userspace.
> This patch defines a new LSM hook named security_kernel_load_data().
>
> Signed-off-by: Mimi Zohar <zohar@linux.vnet.ibm.com>
> Cc: Eric Biederman <ebiederm@xmission.com>
> Cc: Luis R. Rodriguez <mcgrof@kernel.org>
> Cc: Kees Cook <keescook@chromium.org>
> Cc: Casey Schaufler <casey@schaufler-ca.com>
> Acked-by: Serge Hallyn <serge@hallyn.com>

Acked-by: Kees Cook <keescook@chromium.org>

-Kees

-- 
Kees Cook
Pixel Security
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
