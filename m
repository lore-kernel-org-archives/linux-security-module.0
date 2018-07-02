From: kamal@canonical.com (Kamal Mostafa)
Date: Mon, 2 Jul 2018 13:14:03 -0700
Subject: [PATCH] security: CONFIG_HARDENED_USERCOPY does not need to
	select BUG
In-Reply-To: <CAGXu5jKXtq75+HkziTT-8F0VHvvOiRrtfez60h8hKK1GaE64ug@mail.gmail.com>
References: <1530302661-20953-1-git-send-email-kamal@canonical.com>
	<CAGXu5jKXtq75+HkziTT-8F0VHvvOiRrtfez60h8hKK1GaE64ug@mail.gmail.com>
Message-ID: <20180702201402.GA16773@whence.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Fri, Jun 29, 2018 at 01:27:08PM -0700, Kees Cook wrote:
> On Fri, Jun 29, 2018 at 1:04 PM, Kamal Mostafa <kamal@canonical.com> wrote:
> > Allows for CONFIG_HARDENED_USERCOPY without CONFIG_BUG.
> >
> > Signed-off-by: Kamal Mostafa <kamal@canonical.com>
> > ---
> >  security/Kconfig | 1 -
> >  1 file changed, 1 deletion(-)
> >
> > diff --git a/security/Kconfig b/security/Kconfig
> > index c430206..7667774 100644
> > --- a/security/Kconfig
> > +++ b/security/Kconfig
> > @@ -153,7 +153,6 @@ config HAVE_HARDENED_USERCOPY_ALLOCATOR
> >  config HARDENED_USERCOPY
> >         bool "Harden memory copies between kernel and userspace"
> >         depends on HAVE_HARDENED_USERCOPY_ALLOCATOR
> > -       select BUG
> >         imply STRICT_DEVMEM
> >         help
> >           This option checks for obviously wrong memory regions when
> 
> Do the lkdtm tests for usercopy correctly halt the kernel thread if
> CONFIG_BUG is removed?
> 

Yes, they do...

With this config (specifically disabling 'FALLBACK'):

    CONFIG_HARDENED_USERCOPY=y
    # CONFIG_HARDENED_USERCOPY_FALLBACK is not set
    # CONFIG_BUG is not set

I ran the usercopy tests as follows:

    modprobe lkdtm
    cd /sys/kernel/debug/provoke-crash
    cat DIRECT | grep USERCOPY | while read x ; do echo $x | tee DIRECT || echo $?; done

Resulting in this command line output:

    USERCOPY_HEAP_SIZE_TO
    139
    USERCOPY_HEAP_SIZE_FROM
    139
    USERCOPY_HEAP_WHITELIST_TO
    139
    USERCOPY_HEAP_WHITELIST_FROM
    139
    USERCOPY_STACK_FRAME_TO
    139
    USERCOPY_STACK_FRAME_FROM
    139
    USERCOPY_STACK_BEYOND
    139
    USERCOPY_KERNEL
    139

Each test case yields kernel log output like:

    lkdtm: Performing direct entry USERCOPY_HEAP_SIZE_TO
    lkdtm: attempting good copy_to_user of correct size
    lkdtm: attempting bad copy_to_user of too large size
    usercopy: Kernel memory exposure attempt detected from SLUB object 'kmalloc-1024' (offset 16, size 1024)!
    invalid opcode: 0000 [#17] SMP PTI
    ... {panic dump} ...

Each 'tee' gets terminated with SIGSEGV and no instances appear of the
lkdtm/usercopy.c warning "copy_{to/from}_user failed, but lacked Oops".

If I leave CONFIG_HARDENED_USERCOPY_FALLBACK=y then the pair of
WHITELIST tests don't trigger a panic or SIGSEGV, as expected.

 -Kamal
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
