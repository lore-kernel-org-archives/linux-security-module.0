From: torvalds@linux-foundation.org (Linus Torvalds)
Date: Fri, 11 May 2018 09:45:33 -0700
Subject: [PATCH v5 5/7] proc: instantiate only pids that we can ptrace on
	'limit_pids=1' mount option
In-Reply-To: <20180511093613.GA1330@comp-core-i7-2640m-0182e6>
References: <20180511093613.GA1330@comp-core-i7-2640m-0182e6>
Message-ID: <CA+55aFxYwH6dw=bsQJHEgkM_iZfVNerqn+RAXrrY2iufJag6Qw@mail.gmail.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Fri, May 11, 2018 at 2:46 AM Alexey Gladkov <gladkov.alexey@gmail.com>
wrote:

> +       /* Limit procfs to only ptracable tasks */
> +       if (limit_pids == PROC_LIMIT_PIDS_PTRACE) {
> +               cond_resched();
> +               if (!has_pid_permissions(fs_info, task,
HIDEPID_NO_ACCESS))
> +                       goto out_put_task;
> +       }

Where did that "cond_resched()" come from? That doesn't seem to make a lot
of sense.

                    Linus
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
