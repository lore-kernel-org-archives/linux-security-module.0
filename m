From: tixxdz@gmail.com (Djalal Harouni)
Date: Tue, 28 Nov 2017 22:33:27 +0100
Subject: [PATCH v5 next 1/5] modules:capabilities: add request_module_cap()
In-Reply-To: <20171128211659.GP729@wotan.suse.de>
References: <1511803118-2552-1-git-send-email-tixxdz@gmail.com>
	<1511803118-2552-2-git-send-email-tixxdz@gmail.com>
	<20171128191405.GO729@wotan.suse.de>
	<CAGXu5jKgHWNE4NH_xqcM084-BNBPy+HmEVPbTA+w_=K3S6gC=w@mail.gmail.com>
	<20171128211659.GP729@wotan.suse.de>
Message-ID: <CAEiveUf3Zdw=+MPTHRSRsNq3o9M0XOgnXBVszdsGAPvhyS5wLw@mail.gmail.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Tue, Nov 28, 2017 at 10:16 PM, Luis R. Rodriguez <mcgrof@kernel.org> wrote:
> On Tue, Nov 28, 2017 at 12:11:34PM -0800, Kees Cook wrote:
>> On Tue, Nov 28, 2017 at 11:14 AM, Luis R. Rodriguez <mcgrof@kernel.org> wrote:
>> > kmod is just a helper to poke userpsace to load a module, that's it.
>> >
>> > The old init_module() and newer finit_module() do the real handy work or
>> > module loading, and both currently only use may_init_module():
>> >
>> > static int may_init_module(void)
>> > {
>> >         if (!capable(CAP_SYS_MODULE) || modules_disabled)
>> >                 return -EPERM;
>> >
>> >         return 0;
>> > }
>> >
>> > This begs the question:
>> >
>> >   o If userspace just tries to just use raw finit_module() do we want similar
>> >     checks?
>> >
>> > Otherwise, correct me if I'm wrong this all seems pointless.
>>
>> Hm? That's direct-loading, not auto-loading. This series is only about
>> auto-loading.
>
> And *all* auto-loading uses aliases? What's the difference between auto-loading
> and direct-loading?

Not all auto-loading uses aliases, auto-loading is when kernel code
calls request_module() to loads the feature that was not present, and
direct-loading in this thread is the direct syscalls like
finit_module().

>> We already have a global sysctl for blocking direct-loading (modules_disabled).
>
> My point was that even if you have a CAP_NET_ADMIN check on request_module(),
> finit_module() will not check for it, so a crafty userspace could still try
> to just finit_module() directly, and completely then bypass the CAP_NET_ADMIN
> check.

The finit_module() uses CAP_SYS_MODULE which should allow all modules
and in this context it should be more privileged than CAP_NET_ADMIN
which is only for "netdev-%s" (to not load arbitrary modules with it).

finit_module() coming from request_module() always has the
CAP_NET_ADMIN, hence the check is done before.

> So unless I'm missing something, I see no point in adding extra checks for
> request_module() but nothing for the respective load_module().

I see, request_module() is called from kernel context which runs in
init namespace will full capabilities, the spawned userspace modprobe
will get CAP_SYS_MODULE and all other caps, then after comes modprobe
and load_module().

Btw as suggested by Linus I will update with request_module_cap() and
I can offer my help maintaining these bits too.


>
>   Luis



-- 
tixxdz
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
