From: sargun@sargun.me (Sargun Dhillon)
Date: Wed, 6 Dec 2017 09:07:37 -0800
Subject: [RFC 0/3] Safe, dynamically (un)loadable LSMs
In-Reply-To: <866f86cf-d28a-3da7-4a2d-cbc5a330bd4a@schaufler-ca.com>
References: <20171126221545.GA13751@ircssh-2.c.rugged-nimbus-611.internal>
	<8c8dd781-d30a-7105-011d-127cf5188426@schaufler-ca.com>
	<CAMp4zn_=4r9_eH1pUOfzxmRuQL+nVk9megx325s=f1Myv_opZg@mail.gmail.com>
	<866f86cf-d28a-3da7-4a2d-cbc5a330bd4a@schaufler-ca.com>
Message-ID: <CAMp4zn_RCt3qVFwt_67xS1Nq-4VFpiUQqZ20GNzSo8xfy5Ledw@mail.gmail.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Tue, Dec 5, 2017 at 2:56 PM, Casey Schaufler <casey@schaufler-ca.com> wrote:
> On 12/5/2017 2:02 AM, Sargun Dhillon wrote:
>> On Wed, Nov 29, 2017 at 6:28 PM, Casey Schaufler <casey@schaufler-ca.com> wrote:
>>> On 11/26/2017 2:15 PM, Sargun Dhillon wrote:
>>>> This patchset introduces safe dynamic LSM support. It does this via
>>>> SRCU-protected security hooks. It also EXPORT_SYMBOL_GPLs the symbols
>>>> required to perform runtime loading, and unloading. The patchset is
>>>> meant to introduce as little overhead as possible when not used.
>>>> Additionally, the functionality is disabled by default.
>>> Can you explain the value in being able to unload a security module?
>>> I can see having a throttle on an active module, but what do you gain
>>> by being able to unload it? Can it possibly be worth the inevitable
>>> memory leaks and almost certain dangling pointers? The restrictions on
>>> a security module that can work safely in this environment are significant.
>>> I don't see any point in unloading a module that could work with those
>>> restrictions. The overhead of making it unloadable is likely to exceed
>>> the overhead of running it.
>>>
>> There are three things here:
>> 1) I wanted to replicate what in-kernel security hooks could do.
>> security_delete_hooks exists today, and although I'm not sure how it
>> can safely be used, even though it called as list_del_rcu, I'm not
>> sure if there is any way to ensure safety around ensuring there are no
>> more remaining references. I didn't dig into this too deeply.
>
> security_delete_hooks is only used by SELinux, and there is serious
> talk of removing that use. If that comes about, and there are no users
> of security_delete_hooks, we'll remove the interface.
>
>> 2) In the future, I want to extend this patch and add the idea of
>> "immutable hooks" i.e. hooks which can only be loaded, but not
>> unloaded. If we combine this with the sealable memory allocator, it
>> provides some interesting security guarantees, especially if we
>> incorporate some of the other patches around the sealable memory
>> allocator.
>
> Currently the only hooks that can be removed are those for SELinux,
> and as noted above, that facility may go away.
>
>> 3) My personal reason for wanting this is actually tied to my use
>> case. I have certain policies which are far easier to express by
>> writing some C-code (a module), as opposed to writing a generic
>> loader. Often times these modules are a few lines of code, and the
>> rulesets are changed on the fly. Although this could be implemented be
>> adding lots of hooks, the overhead starts to become unreasonable,
>> especially when newer hooks obsolete older hooks. -- Think nftables or
>> systemtap -- sometimes, the environment changes, and you need to
>> reconfigure your system.
>
> I'm not sure why you think there would be excessive overhead.
> I understand why you might want them to be dynamically loadable,
> but don't understand why you would want to unload them.
>
> If you want an example of a security module that can change its
> ruleset on the fly look at Smack. You can change the rules at any
> time. No way, however, would I suggest trying to make it unloadable.
>
Yeah, I can do closer to what Smack is doing. My specific use case is
something along the lines of seccomp and (Docker) containers. With the
default Docker seccomp policies, we see as much as a 40% syscall
overhead. Although we can build out better seccomp infrastructure, a
lot of these hooks make more sense to be enforced at the system level
for any container (say non-init_user_ns), and the LSM hooks are the
perfect place to enforce them, and especially a good argument for
defense-in-depth. Occasionally, you want the same level of dynamism as
Seccomp, or want to be able to debug and modify these policies. In
this case being able to do the Load -> Test -> Unload -> Compile loop
is nice, but of course I can have my LSM(s) just have a mechanism that
proxies these calls to something that supports that loop better a la
Smack.


>> I started going down the route of benchmarking these things, but
>> unfortunately, with the machines I have access to, I can't see the
>> performance counters, so I'm unable to see differences in performance
>> other than wall-clock time. I can dig in a little bit more, but we can
>> always gate module unloading behind a config flag if you think that's
>> best. If it's disabled, there's no reason to do this whole SRCU thing
>> at all.
>
> I still don't see an argument for unloading a module.
>
Should I respin this patch sans module unloading? Still a set of
dynamic hooks that are independent to allow for sealable memory
support. I'm also wondering what people think of the fs change? I
don't think that it makes a lot of sense just having one giant list. I
was thinking it might make more sense using the module_name instead.

>>
>>>> The SRCU was made safe to call from an interrupt context in the patch
>>>> "srcu: Allow use of Classic SRCU from both process and interrupt context"
>>>> (1123a6041654e8f889014659593bad4168e542c2) by Paolo Bonzini. Therefore
>>>> this mechanism is safe to use for traversal of the callback list,
>>>> even when a hook is called from the interrupt context.
>>>>
>>>> Currently, this maintains an entirely seperate mechanism to attach hooks
>>>> because the hooks are behind managed static_keys to prevent overhead.
>>>> This is also done so sealable memory support could be added at a later
>>>> point. The callbacks currently include a percpu_counter, but that could
>>>> sit outside of the struct itself. This may also have a benefit that these
>>>> counters, could have __cacheline_aligned_in_smp. Although, in my testing
>>>> I was unable to find much performance delta with percpu_counters that
>>>> were not aligned.
>>>>
>>>> It includes an example LSM that prevents specific time travel.
>>> Time based controls (e.g. you can't execute files in /usr/games between
>>> 8:00 and 17:00) would be cool. I suggested them in the 1980's, but
>>> no one has gotten around to implementing them. :)
>>>
>>>> Sargun Dhillon (3):
>>>>   security: Add safe, dynamic (runtime-loadable) hook support
>>>>   LSM: Add statistics about the invocation of dynamic hooks
>>>>   LSM: Add an example sample dynamic LSM
>>>>
>>>>  include/linux/lsm_hooks.h | 254 +++++++++++++++++++++++++++++++++++++
>>>>  samples/Kconfig           |   6 +
>>>>  samples/Makefile          |   2 +-
>>>>  samples/lsm/Makefile      |   4 +
>>>>  samples/lsm/lsm_example.c |  46 +++++++
>>>>  security/Kconfig          |  16 +++
>>>>  security/Makefile         |   2 +
>>>>  security/dynamic.c        | 316 ++++++++++++++++++++++++++++++++++++++++++++++
>>>>  security/dynamic.h        |  33 +++++
>>>>  security/dynamicfs.c      | 118 +++++++++++++++++
>>>>  security/inode.c          |   2 +
>>>>  security/security.c       |  66 +++++++++-
>>>>  12 files changed, 863 insertions(+), 2 deletions(-)
>>>>  create mode 100644 samples/lsm/Makefile
>>>>  create mode 100644 samples/lsm/lsm_example.c
>>>>  create mode 100644 security/dynamic.c
>>>>  create mode 100644 security/dynamic.h
>>>>  create mode 100644 security/dynamicfs.c
>>>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
>> the body of a message to majordomo at vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
