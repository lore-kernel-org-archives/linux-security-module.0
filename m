From: gladkov.alexey@gmail.com (Alexey Gladkov)
Date: Mon, 14 May 2018 10:29:08 +0200
Subject: [PATCH v5 5/7] proc: instantiate only pids that we can ptrace on
	'limit_pids=1' mount option
In-Reply-To: <CA+55aFxYwH6dw=bsQJHEgkM_iZfVNerqn+RAXrrY2iufJag6Qw@mail.gmail.com>
References: <20180511093613.GA1330@comp-core-i7-2640m-0182e6>
	<CA+55aFxYwH6dw=bsQJHEgkM_iZfVNerqn+RAXrrY2iufJag6Qw@mail.gmail.com>
Message-ID: <20180514082908.GA28179@comp-core-i7-2640m-0182e6>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Fri, May 11, 2018 at 09:45:33AM -0700, Linus Torvalds wrote:
> On Fri, May 11, 2018 at 2:46 AM Alexey Gladkov <gladkov.alexey@gmail.com>
> wrote:
> 
> > +       /* Limit procfs to only ptracable tasks */
> > +       if (limit_pids == PROC_LIMIT_PIDS_PTRACE) {
> > +               cond_resched();
> > +               if (!has_pid_permissions(fs_info, task,
> HIDEPID_NO_ACCESS))
> > +                       goto out_put_task;
> > +       }
> 
> Where did that "cond_resched()" come from? That doesn't seem to make a lot
> of sense.

This call came along with has_pid_permissions from proc_pid_readdir [1]. It
seems to me that proc_pid_readdir and proc_pid_lookup should act in a
similar way in this case.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=3ba4bceef23206349d4130ddf140819b365de7c8

-- 
Rgrds, legion

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
