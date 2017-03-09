From: keescook@chromium.org (Kees Cook)
Date: Thu, 9 Mar 2017 13:31:08 -0800
Subject: [PATCH v3] security/Kconfig: further restrict HARDENED_USERCOPY
In-Reply-To: <1489094389-28007-1-git-send-email-tycho@docker.com>
References: <1489094389-28007-1-git-send-email-tycho@docker.com>
Message-ID: <CAGXu5j+7qu8R6+pMYHTG-MbtkN+xBSympnmFLQii-6M29BW52w@mail.gmail.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Thu, Mar 9, 2017 at 1:19 PM, Tycho Andersen <tycho@docker.com> wrote:
> It doesn't make sense to have HARDENED_USERCOPY when either /dev/kmem is
> enabled or /dev/mem can be used to read kernel memory (i.e.
> !STRICT_DEVMEM).
>
> v2: add !MMU depend as well
> v3: drop !MMU, s/ARCH_HAS_DEVMEM_IS_ALLOWED/DEVMEM, which makes the above
>     commit message actually match the logic again
>
> Signed-off-by: Tycho Andersen <tycho@docker.com>
> CC: Kees Cook <keescook@chromium.org>
> CC: "Serge E. Hallyn" <serge@hallyn.com>
> CC: James Morris <james.l.morris@oracle.com>

Awesome, thanks! I'll add this to the usercopy tree.

-Kees

> ---
>  security/Kconfig | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/security/Kconfig b/security/Kconfig
> index 3ff1bf9..4619cee 100644
> --- a/security/Kconfig
> +++ b/security/Kconfig
> @@ -142,6 +142,8 @@ config HARDENED_USERCOPY
>         bool "Harden memory copies between kernel and userspace"
>         depends on HAVE_ARCH_HARDENED_USERCOPY
>         depends on HAVE_HARDENED_USERCOPY_ALLOCATOR
> +       depends on !DEVKMEM
> +       depends on !DEVMEM || STRICT_DEVMEM
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
