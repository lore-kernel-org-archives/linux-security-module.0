From: christian.brauner@mailbox.org (Christian Brauner)
Date: Wed, 3 Jan 2018 12:23:17 +0100
Subject: [PATCH] userns: honour no_new_privs for cap_bset during user ns
	creation/switch
In-Reply-To: <87o9mqhn3v.fsf@xmission.com>
References: <20171221210605.181720-1-zenczykowski@gmail.com>
	<87wp1foiwa.fsf@xmission.com>
	<CAHo-OoyrOr5jXwU-j4Z4qYdWo40+qAdAk0r+OpfMUZ6LgbS-RA@mail.gmail.com>
	<87fu83lfw5.fsf@xmission.com>
	<CAHo-OoxoTEZuQ0ZXa9a2BnjAv83y0UWC0eqn-ok9hS31LkiiSA@mail.gmail.com>
	<87o9mqhn3v.fsf@xmission.com>
Message-ID: <20180103112317.gmpn5iatakrs7xqi@mailbox.org>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Fri, Dec 22, 2017 at 08:08:04AM -0600, Eric W. Biederman wrote:
> Maciej ?enczykowski <zenczykowski@gmail.com> writes:
> 
> >> Good point about CAP_DAC_OVERRIDE on files you own.
> >>
> >> I think there is an argument that you are playing dangerous games with
> >> the permission system there, as it isn't effectively a file you own if
> >> you can't read it, and you can't change it's permissions.
> >
> > Append-only files are useful - particularly for logging.
> > It could also simply be a non-readable file on a R/O filesystem.
> >
> >> Given little things like that I can completely see no_new_privs meaning
> >> you can't create a user namespace.  That seems consistent with the
> >> meaning and philosophy of no_new_privs.  So simple it is hard to get
> >> wrong.
> >
> > Yes, I could totally buy the argument that no_new_privs should prevent
> > creating a user ns.
> >
> > However, there's also setns() and that's a fair bit harder to reason about.
> > Entirely deny it?  But that actually seems potentially useful...
> > Allow it but cap it?  That's what this does...
> >
> >> We could do more clever things like plug this whole in user namespaces,
> >> and that would not hurt my feelings.
> >
> > Sure, this particular one wouldn't be all that easy I think... and how
> > many such holes are there?
> > I found this particular one *after* your first reply in this thread.
> >
> >> However unless that is our only
> >> choice to avoid badly breaking userspace I would have to have to depend
> >> on user namespaces being perfect for no_new_privs to be a proper jail.
> >
> > This stuff is ridiculously complex to get right from userspace. :-(
> 
> >> As a general rule user namespaces are where we tackle the subtle scary
> >> things that should work, and no_new_privs is where we implement a simple
> >> hard to get wrong jail.  Most of the time the effect is the same to an
> >> outside observer (bounded permissions), but there is a real difference
> >> in difficulty of implementation.
> >
> > So, where to now...
> >
> > Would you accept patches that:
> >
> > - make no_new_priv block user ns creation?
> >
> > - make no_new_priv block user ns transition?
> 
> Yes.
> 
> The approach will need to be rethought if there is anything deliberately
> combining user namespaces and no_new_privs.  As regressions are a no-no.
> So we need wide spread testing, to avoid that.

Just to be clear:  as soon as you set no_new_privs you should not be
able to create new user namespace anymore and you shouldn't be able to
attach to user namespaces anymore.
This should work and not cause regressions for e.g. liblxc were we
always set no_new_privs as one of the last steps and especially after we
have clone(CLONE_NEWUSER) the container and - for the attach case -
after we have already done the setns(fd, CLONE_NEWUSER). These use-cases
should be preserved. But it seems to me that they will be. But I'd like
to test this once patches are floating around.

> 
> But as much as possible I want no_new_privs to be simple and doing it's
> job.
> 
> I will also take and encourage patches that close this minor privilege
> escalation from the user namespace side.  As ideally creating a user
> namespace should be as safe as no_new_privs.
> 
> 
> > Or perhaps we can assume that lack of create privs is sufficient, and
> > if there's a pre-existing user ns for you to enter, then that's
> > acceptable...
> > Although this implies you probably always want to combine no_new_privs
> > with a leaf user ns, or no_new_privs isn't all that useful for root in
> > root ns...
> > This added complexity, probably means it should be blocked...
> 
> Yes.
> 
> > - inherits bset across user ns creation/transition based on X?
> > [this is the one we care about, because there are simply too many bugs
> > in the kernel wrt. certain caps]
> 
> That was my suspicion, and attack surface reduction is a different
> discussion.  Would no_new_privs preventing a userns transition be enough
> for the cases you care about?
> 
> Otherwise this is a different conversation because it is not about
> semantics but about making the code safer to use.  In general if code is
> simply not safe to user in a user namespace I would prefer to tighten
> the permission checks, and just not allow that code.
> 
> Mostly what I have seen in previous conversations is simply concerns
> about code that is not used or needed, being a problem.
> 
> > X could be:
> > - a new flag similar to no_new_priv
> > - a new securebit flag (w/lockbit)  [provided securebits survive a
> > userns transition, haven't checked]
> > - or perhaps a new capability
> > - something else?
> >
> > How do we make forward progress?
> 
> We start by causing no_new_privs to block userns creation and entering.

That sounds reasonable. One thing I thought about is what the
interaction between no_new_privs and /proc/sys/user/max_user_namespaces
should look like after this change. Both will basically have the same
effect, right? So wouldn't it make sense to have no_new_privs imply that
/proc/sys/user/max_user_namespaces is 0 and becomes read-only in the
in the calling process' user namespace (e.g. returning EINVAL would make
sense)? I worry that otherwise we might confuse users when they see that
/proc/sys/user/max_user_namespaces is not 0 but they still aren't able
to create user namespaces. I know that having multiple security options
block the same thing independent of each other is not unprecedented
(e.g. in addition to /proc/sys/user/max_user_namespaces CentOS and RHEL
have an additional boot parameter to {dis,en}able user namespace
creation which often confuses the heck out of users) but I'd rather not
make this a common scenario when we can establish a sensible interaction
between two security settings.

Christian
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
