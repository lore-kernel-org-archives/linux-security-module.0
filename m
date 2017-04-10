From: tixxdz@gmail.com (Djalal Harouni)
Date: Mon, 10 Apr 2017 08:48:36 +0200
Subject: [kernel-hardening] [PATCH net-next v6 07/11] landlock: Add ptrace
	restrictions
In-Reply-To: <20170328234650.19695-8-mic@digikod.net>
References: <20170328234650.19695-1-mic@digikod.net>
	<20170328234650.19695-8-mic@digikod.net>
Message-ID: <CAEiveUdXGEOywJoYTsBcxCp02_2gtj7Zw0zT_YdGWM3fJLYY7g@mail.gmail.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Wed, Mar 29, 2017 at 1:46 AM, Micka?l Sala?n <mic@digikod.net> wrote:
> A landlocked process has less privileges than a non-landlocked process
> and must then be subject to additional restrictions when manipulating
> processes. To be allowed to use ptrace(2) and related syscalls on a
> target process, a landlocked process must have a subset of the target
> process' rules.
>
> New in v6
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
>  security/landlock/Makefile       |   2 +-
>  security/landlock/hooks_ptrace.c | 126 +++++++++++++++++++++++++++++++++++++++
>  security/landlock/hooks_ptrace.h |  11 ++++
>  security/landlock/init.c         |   2 +
>  4 files changed, 140 insertions(+), 1 deletion(-)
>  create mode 100644 security/landlock/hooks_ptrace.c
>  create mode 100644 security/landlock/hooks_ptrace.h
>
[...]

> +/**
> + * landlock_ptrace_access_check - determine whether the current process may
> + *                               access another
> + *
> + * @child: the process to be accessed
> + * @mode: the mode of attachment
> + *
> + * If the current task has Landlock rules, then the child must have at least
> + * the same rules.  Else denied.
> + *
> + * Determine whether a process may access another, returning 0 if permission
> + * granted, -errno if denied.
> + */
> +static int landlock_ptrace_access_check(struct task_struct *child,
> +               unsigned int mode)
> +{
> +       if (!landlocked(current))
> +               return 0;
> +
> +       if (!landlocked(child))
> +               return -EPERM;
> +
> +       if (landlock_task_has_subset_events(current, child))
> +               return 0;
> +
> +       return -EPERM;
> +}
> +

Maybe you want to check the mode argument here if it is a
PTRACE_ATTACH which may translate to read/writes ? PTRACE_READ are
normally for reads only. Or also which creds were used if this was a
direct syscall or a filesystem call through procfs.

I'm bringing this, since you may want to make some room for landlock
ptrace events and what others may want to do with it. Also I'm
planning to send another v2 RFC for procfs separate instances [1], the
aim is to give LSMs a security_ptrace_access_check hook path when
dealing with /proc/<pids>/ [2]  . Right now LSMs don't really have a
security path there, and the implementation does not guarantee that.
With this Yama ptrace scope or other LSMs may take advantage of it and
check the 'PTRACE_MODE_READ_FSCRED' mode for filesystem accesses.
That's why I think it would be better if the default landlock ptrace
semantics are not that wide.

Thanks!

[1] https://lkml.org/lkml/2017/3/30/670
[2] http://lxr.free-electrons.com/source/fs/proc/base.c#L719
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
