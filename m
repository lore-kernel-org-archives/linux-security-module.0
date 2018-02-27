From: luto@amacapital.net (Andy Lutomirski)
Date: Tue, 27 Feb 2018 04:17:42 +0000
Subject: [PATCH bpf-next v8 08/11] landlock: Add ptrace restrictions
In-Reply-To: <20180227004121.3633-9-mic@digikod.net>
References: <20180227004121.3633-1-mic@digikod.net>
	<20180227004121.3633-9-mic@digikod.net>
Message-ID: <CALCETrUpDbusLPyZijR6MpZd5-0x0d9KuQHBaavqP1_GZ2tjfg@mail.gmail.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Tue, Feb 27, 2018 at 12:41 AM, Micka?l Sala?n <mic@digikod.net> wrote:
> A landlocked process has less privileges than a non-landlocked process
> and must then be subject to additional restrictions when manipulating
> processes. To be allowed to use ptrace(2) and related syscalls on a
> target process, a landlocked process must have a subset of the target
> process' rules.
>
> Signed-off-by: Micka?l Sala?n <mic@digikod.net>
> Cc: Alexei Starovoitov <ast@kernel.org>
> Cc: Andy Lutomirski <luto@amacapital.net>
> Cc: Daniel Borkmann <daniel@iogearbox.net>
> Cc: David S. Miller <davem@davemloft.net>
> Cc: James Morris <james.l.morris@oracle.com>
> Cc: Kees Cook <keescook@chromium.org>
> Cc: Serge E. Hallyn <serge@hallyn.com>
> ---
>
> Changes since v6:
> * factor out ptrace check
> * constify pointers
> * cleanup headers
> * use the new security_add_hooks()
> ---
>  security/landlock/Makefile       |   2 +-
>  security/landlock/hooks_ptrace.c | 124 +++++++++++++++++++++++++++++++++++++++
>  security/landlock/hooks_ptrace.h |  11 ++++
>  security/landlock/init.c         |   2 +
>  4 files changed, 138 insertions(+), 1 deletion(-)
>  create mode 100644 security/landlock/hooks_ptrace.c
>  create mode 100644 security/landlock/hooks_ptrace.h
>
> diff --git a/security/landlock/Makefile b/security/landlock/Makefile
> index d0f532a93b4e..605504d852d3 100644
> --- a/security/landlock/Makefile
> +++ b/security/landlock/Makefile
> @@ -3,4 +3,4 @@ obj-$(CONFIG_SECURITY_LANDLOCK) := landlock.o
>  landlock-y := init.o chain.o task.o \
>         tag.o tag_fs.o \
>         enforce.o enforce_seccomp.o \
> -       hooks.o hooks_cred.o hooks_fs.o
> +       hooks.o hooks_cred.o hooks_fs.o hooks_ptrace.o
> diff --git a/security/landlock/hooks_ptrace.c b/security/landlock/hooks_ptrace.c
> new file mode 100644
> index 000000000000..f1b977b9c808
> --- /dev/null
> +++ b/security/landlock/hooks_ptrace.c
> @@ -0,0 +1,124 @@
> +/*
> + * Landlock LSM - ptrace hooks
> + *
> + * Copyright ? 2017 Micka?l Sala?n <mic@digikod.net>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2, as
> + * published by the Free Software Foundation.
> + */
> +
> +#include <asm/current.h>
> +#include <linux/errno.h>
> +#include <linux/kernel.h> /* ARRAY_SIZE */
> +#include <linux/lsm_hooks.h>
> +#include <linux/sched.h> /* struct task_struct */
> +#include <linux/seccomp.h>
> +
> +#include "common.h" /* struct landlock_prog_set */
> +#include "hooks.h" /* landlocked() */
> +#include "hooks_ptrace.h"
> +
> +static bool progs_are_subset(const struct landlock_prog_set *parent,
> +               const struct landlock_prog_set *child)
> +{
> +       size_t i;
> +
> +       if (!parent || !child)
> +               return false;
> +       if (parent == child)
> +               return true;
> +
> +       for (i = 0; i < ARRAY_SIZE(child->programs); i++) {

ARRAY_SIZE(child->programs) seems misleading.  Is there no define
NUM_LANDLOCK_PROG_TYPES or similar?

> +               struct landlock_prog_list *walker;
> +               bool found_parent = false;
> +
> +               if (!parent->programs[i])
> +                       continue;
> +               for (walker = child->programs[i]; walker;
> +                               walker = walker->prev) {
> +                       if (walker == parent->programs[i]) {
> +                               found_parent = true;
> +                               break;
> +                       }
> +               }
> +               if (!found_parent)
> +                       return false;
> +       }
> +       return true;
> +}

If you used seccomp, you'd get this type of check for free, and it
would be a lot easier to comprehend.  AFAICT the only extra leniency
you're granting is that you're agnostic to the order in which the
rules associated with different program types were applied, which
could easily be added to seccomp.
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
