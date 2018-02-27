From: luto@amacapital.net (Andy Lutomirski)
Date: Tue, 27 Feb 2018 23:09:18 +0000
Subject: [PATCH bpf-next v8 00/11] Landlock LSM: Toward unprivileged
	sandboxing
In-Reply-To: <2e06621c-08e9-dc12-9b6e-9c09d5d8f458@digikod.net>
References: <20180227004121.3633-1-mic@digikod.net>
	<CALCETrV3OZb70o83uOG437PubwBwaUJ6SKQucq_7g1BuBOmxzg@mail.gmail.com>
	<2e06621c-08e9-dc12-9b6e-9c09d5d8f458@digikod.net>
Message-ID: <CALCETrWnJ7WkkfiymyahQd7YqO0KXP4mG1pRMq7fp8LG8Bwtcw@mail.gmail.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Tue, Feb 27, 2018 at 10:03 PM, Micka?l Sala?n <mic@digikod.net> wrote:
>
> On 27/02/2018 05:36, Andy Lutomirski wrote:
>> On Tue, Feb 27, 2018 at 12:41 AM, Micka?l Sala?n <mic@digikod.net> wrote:
>>> Hi,
>>>

>>>
>>> ## Why use the seccomp(2) syscall?
>>>
>>> Landlock use the same semantic as seccomp to apply access rule
>>> restrictions. It add a new layer of security for the current process
>>> which is inherited by its children. It makes sense to use an unique
>>> access-restricting syscall (that should be allowed by seccomp filters)
>>> which can only drop privileges. Moreover, a Landlock rule could come
>>> from outside a process (e.g.  passed through a UNIX socket). It is then
>>> useful to differentiate the creation/load of Landlock eBPF programs via
>>> bpf(2), from rule enforcement via seccomp(2).
>>
>> This seems like a weak argument to me.  Sure, this is a bit different
>> from seccomp(), and maybe shoving it into the seccomp() multiplexer is
>> awkward, but surely the bpf() multiplexer is even less applicable.
>
> I think using the seccomp syscall is fine, and everyone agreed on it.
>

Ah, sorry, I completely misread what you wrote.  My apologies.  You
can disregard most of my email.

>
>>
>> Also, looking forward, I think you're going to want a bunch of the
>> stuff that's under consideration as new seccomp features.  Tycho is
>> working on a "user notifier" feature for seccomp where, in addition to
>> accepting, rejecting, or kicking to ptrace, you can send a message to
>> the creator of the filter and wait for a reply.  I think that Landlock
>> will want exactly the same feature.
>
> I don't think why this may be useful at all her. Landlock does not
> filter at the syscall level but handles kernel object and actions as
> does an LSM. That is the whole purpose of Landlock.

Suppose I'm writing a container manager.  I want to run "mount" in the
container, but I don't want to allow moun() in general and I want to
emulate certain mount() actions.  I can write a filter that catches
mount using seccomp and calls out to the container manager for help.
This isn't theoretical -- Tycho wants *exactly* this use case to be
supported.

But using seccomp for this is indeed annoying.  It would be nice to
use Landlock's ability to filter based on the filesystem type, for
example.  So Tycho could write a Landlock rule like:

bool filter_mount(...)
{
  if (path needs emulation)
    call_user_notifier();
}

And it should work.

This means that, if both seccomp user notifiers and Landlock make it
upstream, then there should probably be a way to have a user notifier
bound to a seccomp filter and a set of landlock filters.
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
