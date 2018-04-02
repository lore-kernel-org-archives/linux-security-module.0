From: tycho@tycho.ws (Tycho Andersen)
Date: Sun, 1 Apr 2018 18:39:47 -0600
Subject: [PATCH bpf-next v8 00/11] Landlock LSM: Toward unprivileged
	sandboxing
In-Reply-To: <0f355079-7ee2-c06a-2d47-a7a2fa6d98fe@digikod.net>
References: <2e06621c-08e9-dc12-9b6e-9c09d5d8f458@digikod.net>
	<CALCETrWnJ7WkkfiymyahQd7YqO0KXP4mG1pRMq7fp8LG8Bwtcw@mail.gmail.com>
	<a70b41ee-78cb-52cc-152c-ac5e43b7e45c@digikod.net>
	<CALCETrUQYp0ta4tLgUWJ79pZVwp3WRY7cp-XaPcn1WyTc=wZyg@mail.gmail.com>
	<20180306224636.wf5z3kujtc7r5qyh@cisco>
	<7082be04-d6af-b853-4bb7-f331836662e2@digikod.net>
	<CALCETrXT8JUXVwDNKGVRG7=aenthDRePD+T+YiDY6cceaazDeA@mail.gmail.com>
	<cd811155-9e0d-283a-9291-4adfcec848e6@digikod.net>
	<CALCETrUwkV4_65y7UjSgrq5WHOcZZ=+znKArehvhb1xEGG9HXw@mail.gmail.com>
	<0f355079-7ee2-c06a-2d47-a7a2fa6d98fe@digikod.net>
Message-ID: <20180402003947.GE5586@cisco>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Hi Micka?l,

On Mon, Apr 02, 2018 at 12:04:36AM +0200, Micka?l Sala?n wrote:
> >> vDSO is a code mapped for all processes. As you said, these processes
> >> may use it or not. What I was thinking about is to use the same concept,
> >> i.e. map a "shim" code into each processes pertaining to a particular
> >> hierarchy (the same way seccomp filters are inherited across processes).
> >> With a seccomp filter matching some syscall (e.g. mount, open), it is
> >> possible to jump back to the shim code thanks to SECCOMP_RET_TRAP. This
> >> shim code should then be able to emulate/patch what is needed, even
> >> faking a file opening by receiving a file descriptor through a UNIX
> >> socket. As did the Chrome sandbox, the seccomp filter may look at the
> >> calling address to allow the shim code to call syscalls without being
> >> catched, if needed. However, relying on SIGSYS may not fit with
> >> arbitrary code. Using a new SECCOMP_RET_EMULATE (?) may be used to jump
> >> to a specific process address, to emulate the syscall in an easier way
> >> than only relying on a {c,e}BPF program.
> >>
> > 
> > This could indeed be done, but I think that Tycho's approach is much
> > cleaner and probably faster.
> > 
> 
> I like it too but how does this handle file descriptors?

I think it could be done fairly simply, the most complicated part is
probably designing an API that doesn't suck. But the basic idea would
be:

struct seccomp_notif_resp {
    __u64 id;
    __s32 error;
    __s64 val;
    __s32 fd;
};

if the handler responds with fd >= 0, we grab the tracer's fd,
duplicate it, and install it somewhere in the tracee's fd table. Since
things like socket() will want to return the fd number as its
installed and the handler doesn't know that, we'll probably want some
way to indicate that the kernel should return this value. We could
either mandate that if fd >= 0, that's the value that will be returned
from the syscall, or add another flag that says "no, install the fd,
but really return what's in val instead).

I guess we can't mandate that we return fd, because e.g. netlink
sockets can sometimes return fds as part of the netlink messages, and
not as the return value from the syscall.

Tycho
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
