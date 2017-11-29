From: mkubecek@suse.cz (Michal Kubecek)
Date: Wed, 29 Nov 2017 08:49:56 +0100
Subject: [PATCH v5 next 1/5] modules:capabilities: add request_module_cap()
In-Reply-To: <20171128224849.GT729@wotan.suse.de>
References: <1511803118-2552-1-git-send-email-tixxdz@gmail.com>
	<1511803118-2552-2-git-send-email-tixxdz@gmail.com>
	<20171128191405.GO729@wotan.suse.de>
	<CAGXu5jKgHWNE4NH_xqcM084-BNBPy+HmEVPbTA+w_=K3S6gC=w@mail.gmail.com>
	<20171128211659.GP729@wotan.suse.de>
	<CAGXu5j+JaFCo+pZKvet==Kh7GQgNXi30P50SMF4cpOGoUw-8ug@mail.gmail.com>
	<20171128221237.GR729@wotan.suse.de>
	<CAGXu5jKqMeBUB4iArqw9_iyKqm3NjpCrU_byy90kZrAHDb0c9w@mail.gmail.com>
	<20171128224849.GT729@wotan.suse.de>
Message-ID: <20171129074956.7xg4gcon3zxd4xck@unicorn.suse.cz>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Tue, Nov 28, 2017 at 11:48:49PM +0100, Luis R. Rodriguez wrote:
> On Tue, Nov 28, 2017 at 02:18:18PM -0800, Kees Cook wrote:
> > On Tue, Nov 28, 2017 at 2:12 PM, Luis R. Rodriguez <mcgrof@kernel.org> wrote:
> > > On Tue, Nov 28, 2017 at 01:39:58PM -0800, Kees Cook wrote:
> > >> On Tue, Nov 28, 2017 at 1:16 PM, Luis R. Rodriguez <mcgrof@kernel.org> wrote:
> > >> > And *all* auto-loading uses aliases? What's the difference
> > >> > between auto-loading and direct-loading?
> > >>
> > >> The difference is the process privileges. Unprivilged autoloading
> > >> (e.g. int n_hdlc = N_HDLC; ioctl(fd,
> > >> TIOCSETD, &n_hdlc)), triggers a privileged call to finit_module()
> > >> under CAP_SYS_MODULE.
> > >
> > > Ah, so system call implicated request_module() calls.
> > 
> > Yup. Unprivileged user does something that ultimately hits a
> > request_module() in the kernel. Then the kernel calls out with the
> > usermode helper (which has CAP_SYS_MODULE) and calls finit_module().
> 
> Thanks, using this terminology is much better to understand than
> auto-loading, given it does make it clear an unprivileged call was one
> that initiated the request_module() call, there are many uses of
> request_module() which *are* privileged.
> 
> > > OK and since CAP_SYS_MODULE is much more restrictive one could
> > > argue, what's the point here?
> > 
> > The goal is to block an unprivileged user from being able to trigger a
> > module load without blocking root from loading modules directly.
> 
> I see now. Do we have an audit of all system calls which implicate a
> request_module() call? Networking is a good example for sure to start
> off with but I was curious if we have a grasp of how wide spread this
> could be.

I'm not sure it makes sense to classify this by syscalls. In networking,
request_module() can be triggered e.g. by a netlink message (genetlink
family lookup is an example not needing any privileges) so that one of
the syscalls would be sendmsg().

Michal Kubecek
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
