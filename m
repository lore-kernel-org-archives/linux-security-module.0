From: zohar@linux.ibm.com (Mimi Zohar)
Date: Mon, 16 Jul 2018 09:52:28 -0400
Subject: [PATCH v6 7/8] module: replace the existing LSM hook in
	init_module
In-Reply-To: <CAGXu5j+RvX+CKMP5PWjAPmDpvO4N+t1JQ3C5zr3F-y-T-AH_ng@mail.gmail.com>
References: <1531505163-20227-1-git-send-email-zohar@linux.vnet.ibm.com>
	<1531505163-20227-8-git-send-email-zohar@linux.vnet.ibm.com>
	<CAGXu5j+RvX+CKMP5PWjAPmDpvO4N+t1JQ3C5zr3F-y-T-AH_ng@mail.gmail.com>
Message-ID: <1531749148.3380.2.camel@linux.ibm.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Sat, 2018-07-14 at 19:30 -0700, Kees Cook wrote:
> On Fri, Jul 13, 2018 at 11:06 AM, Mimi Zohar <zohar@linux.vnet.ibm.com> wrote:
> > Both the init_module and finit_module syscalls call either directly
> > or indirectly the security_kernel_read_file LSM hook.  This patch
> > replaces the direct call in init_module with a call to the new
> > security_kernel_load_data hook and makes the corresponding changes
> > in SELinux, LoadPin, and IMA.
> >
> > Signed-off-by: Mimi Zohar <zohar@linux.vnet.ibm.com>
> > Cc: Jeff Vander Stoep <jeffv@google.com>
> > Cc: Casey Schaufler <casey@schaufler-ca.com>
> > Cc: Kees Cook <keescook@chromium.org>
> > Acked-by: Jessica Yu <jeyu@kernel.org>
> > Acked-by: Paul Moore <paul@paul-moore.com>
> 
> Acked-by: Kees Cook <keescook@chromium.org>
> 
> Thanks!

Thank you for reviewing/ack'ing all the patches, not just this one.

Mimi

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
