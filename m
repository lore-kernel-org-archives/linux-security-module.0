From: keescook@chromium.org (Kees Cook)
Date: Thu, 9 Mar 2017 11:18:17 -0800
Subject: [PATCH] security/Kconfig: further restrict HARDENED_USERCOPY
In-Reply-To: <1489080561-30786-1-git-send-email-tycho@docker.com>
References: <1489080561-30786-1-git-send-email-tycho@docker.com>
Message-ID: <CAGXu5jLZjjbgD+-Wn=6hZzKtf-A83oK8M_2iK3132Qv+0sdC8g@mail.gmail.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Thu, Mar 9, 2017 at 9:29 AM, Tycho Andersen <tycho@docker.com> wrote:
> It doesn't make sense to have HARDENED_USERCOPY when either /dev/kmem is
> enabled or /dev/mem can be used to read kernel memory.
>
> v2: add !MMU depend as well

Sorry I keep revising my thoughts on this... so, the bad combos, IMO,
are /dev/kmem or /dev/mem. kmem is easy: we unconditionally require
!DEVKMEM. The /dev/mem one continues to hurt my head, but here's my
current thinking (which, if it seems correct should likely be
reflected in the commit message):

The following cases for /dev/mem should be safe:
- /dev/mem entirely disabled (!DEVMEM)
- /dev/mem with strict checking (STRICT_DEVMEM)

Everything else is not okay, i.e. if an architecture lacks
ARCH_HAS_DEVMEM_IS_ALLOWED, we must reject DEVMEM entirely since it
cannot select STRICT_DEVMEM.

So, sorry for the confusion, but I think this is the correct combo:

depends on !DEVKMEM
depends on !DEVMEM || STRICT_DEVMEM

That should cover it, unless I'm still thinking sideways.

-Kees

>
> Signed-off-by: Tycho Andersen <tycho@docker.com>
> CC: Kees Cook <keescook@chromium.org>
> CC: "Serge E. Hallyn" <serge@hallyn.com>
> CC: James Morris <james.l.morris@oracle.com>
> ---
>  security/Kconfig | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/security/Kconfig b/security/Kconfig
> index 3ff1bf9..aeabd40 100644
> --- a/security/Kconfig
> +++ b/security/Kconfig
> @@ -142,6 +142,8 @@ config HARDENED_USERCOPY
>         bool "Harden memory copies between kernel and userspace"
>         depends on HAVE_ARCH_HARDENED_USERCOPY
>         depends on HAVE_HARDENED_USERCOPY_ALLOCATOR
> +       depends on !DEVKMEM
> +       depends on !ARCH_HAS_DEVMEM_IS_ALLOWED || STRICT_DEVMEM || !MMU
>         select BUG
>         help
>           This option checks for obviously wrong memory regions when
> --
> 2.7.4
>



-- 
Kees Cook
Pixel Security
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
