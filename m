From: keescook@chromium.org (Kees Cook)
Date: Wed, 5 Apr 2017 10:04:15 -0700
Subject: [PATCH 34/38] Annotate hardware config module parameters in
	fs/pstore/
In-Reply-To: <149141171185.29162.10595534113980773776.stgit@warthog.procyon.org.uk>
References: <149141141298.29162.5612793122429261720.stgit@warthog.procyon.org.uk>
	<149141171185.29162.10595534113980773776.stgit@warthog.procyon.org.uk>
Message-ID: <CAGXu5j+1qtNNXz8XSnifT7uy97u-Hox76bBHN3H-VsmVB_VwKg@mail.gmail.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Wed, Apr 5, 2017 at 10:01 AM, David Howells <dhowells@redhat.com> wrote:
> When the kernel is running in secure boot mode, we lock down the kernel to
> prevent userspace from modifying the running kernel image.  Whilst this
> includes prohibiting access to things like /dev/mem, it must also prevent
> access by means of configuring driver modules in such a way as to cause a
> device to access or modify the kernel image.
>
> To this end, annotate module_param* statements that refer to hardware
> configuration and indicate for future reference what type of parameter they
> specify.  The parameter parser in the core sees this information and can
> skip such parameters with an error message if the kernel is locked down.
> The module initialisation then runs as normal, but just sees whatever the
> default values for those parameters is.
>
> Note that we do still need to do the module initialisation because some
> drivers have viable defaults set in case parameters aren't specified and
> some drivers support automatic configuration (e.g. PNP or PCI) in addition
> to manually coded parameters.
>
> This patch annotates drivers in fs/pstore/.
>
> Suggested-by: Alan Cox <gnomes@lxorguk.ukuu.org.uk>
> Signed-off-by: David Howells <dhowells@redhat.com>
> cc: Anton Vorontsov <anton@enomsg.org>
> cc: Colin Cross <ccross@android.com>
> cc: Kees Cook <keescook@chromium.org>
> cc: Tony Luck <tony.luck@intel.com>

Acked-by: Kees Cook <keescook@chromium.org>

-Kees

> ---
>
>  fs/pstore/ram.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/fs/pstore/ram.c b/fs/pstore/ram.c
> index 11f918d34b1e..cce1d38417ca 100644
> --- a/fs/pstore/ram.c
> +++ b/fs/pstore/ram.c
> @@ -58,7 +58,7 @@ module_param_named(pmsg_size, ramoops_pmsg_size, ulong, 0400);
>  MODULE_PARM_DESC(pmsg_size, "size of user space message log");
>
>  static unsigned long long mem_address;
> -module_param(mem_address, ullong, 0400);
> +module_param_hw(mem_address, ullong, other, 0400);
>  MODULE_PARM_DESC(mem_address,
>                 "start of reserved RAM used to store oops/panic logs");
>
>



-- 
Kees Cook
Pixel Security
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
