From: tycho@tycho.ws (Tycho Andersen)
Date: Tue, 6 Mar 2018 15:46:36 -0700
Subject: [PATCH bpf-next v8 00/11] Landlock LSM: Toward unprivileged
	sandboxing
In-Reply-To: <CALCETrUQYp0ta4tLgUWJ79pZVwp3WRY7cp-XaPcn1WyTc=wZyg@mail.gmail.com>
References: <20180227004121.3633-1-mic@digikod.net>
	<CALCETrV3OZb70o83uOG437PubwBwaUJ6SKQucq_7g1BuBOmxzg@mail.gmail.com>
	<2e06621c-08e9-dc12-9b6e-9c09d5d8f458@digikod.net>
	<CALCETrWnJ7WkkfiymyahQd7YqO0KXP4mG1pRMq7fp8LG8Bwtcw@mail.gmail.com>
	<a70b41ee-78cb-52cc-152c-ac5e43b7e45c@digikod.net>
	<CALCETrUQYp0ta4tLgUWJ79pZVwp3WRY7cp-XaPcn1WyTc=wZyg@mail.gmail.com>
Message-ID: <20180306224636.wf5z3kujtc7r5qyh@cisco>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Tue, Mar 06, 2018 at 10:33:17PM +0000, Andy Lutomirski wrote:
> >> Suppose I'm writing a container manager.  I want to run "mount" in the
> >> container, but I don't want to allow moun() in general and I want to
> >> emulate certain mount() actions.  I can write a filter that catches
> >> mount using seccomp and calls out to the container manager for help.
> >> This isn't theoretical -- Tycho wants *exactly* this use case to be
> >> supported.
> >
> > Well, I think this use case should be handled with something like
> > LD_PRELOAD and a helper library. FYI, I did something like this:
> > https://github.com/stemjail/stemshim
> 
> I doubt that will work for containers.  Containers that use user
> namespaces and, for example, setuid programs aren't going to honor
> LD_PRELOAD.

Or anything that calls syscalls directly, like go programs.

Tycho
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
