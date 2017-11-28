From: mcgrof@kernel.org (Luis R. Rodriguez)
Date: Tue, 28 Nov 2017 22:16:59 +0100
Subject: [PATCH v5 next 1/5] modules:capabilities: add request_module_cap()
In-Reply-To: <CAGXu5jKgHWNE4NH_xqcM084-BNBPy+HmEVPbTA+w_=K3S6gC=w@mail.gmail.com>
References: <1511803118-2552-1-git-send-email-tixxdz@gmail.com>
	<1511803118-2552-2-git-send-email-tixxdz@gmail.com>
	<20171128191405.GO729@wotan.suse.de>
	<CAGXu5jKgHWNE4NH_xqcM084-BNBPy+HmEVPbTA+w_=K3S6gC=w@mail.gmail.com>
Message-ID: <20171128211659.GP729@wotan.suse.de>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Tue, Nov 28, 2017 at 12:11:34PM -0800, Kees Cook wrote:
> On Tue, Nov 28, 2017 at 11:14 AM, Luis R. Rodriguez <mcgrof@kernel.org> wrote:
> > kmod is just a helper to poke userpsace to load a module, that's it.
> >
> > The old init_module() and newer finit_module() do the real handy work or
> > module loading, and both currently only use may_init_module():
> >
> > static int may_init_module(void)
> > {
> >         if (!capable(CAP_SYS_MODULE) || modules_disabled)
> >                 return -EPERM;
> >
> >         return 0;
> > }
> >
> > This begs the question:
> >
> >   o If userspace just tries to just use raw finit_module() do we want similar
> >     checks?
> >
> > Otherwise, correct me if I'm wrong this all seems pointless.
> 
> Hm? That's direct-loading, not auto-loading. This series is only about
> auto-loading.

And *all* auto-loading uses aliases? What's the difference between auto-loading
and direct-loading?

> We already have a global sysctl for blocking direct-loading (modules_disabled).

My point was that even if you have a CAP_NET_ADMIN check on request_module(),
finit_module() will not check for it, so a crafty userspace could still try
to just finit_module() directly, and completely then bypass the CAP_NET_ADMIN
check.

So unless I'm missing something, I see no point in adding extra checks for
request_module() but nothing for the respective load_module().

  Luis
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
