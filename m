From: keescook@chromium.org (Kees Cook)
Date: Sun, 16 Sep 2018 16:00:36 -0700
Subject: [PATCH 16/18] LSM: Allow arbitrary LSM ordering
In-Reply-To: <84e1a5a8-8997-829f-cf09-1d29895a3f99@schaufler-ca.com>
References: <20180916003059.1046-1-keescook@chromium.org>
	<20180916003059.1046-17-keescook@chromium.org>
	<84e1a5a8-8997-829f-cf09-1d29895a3f99@schaufler-ca.com>
Message-ID: <CAGXu5jK5CzXUii97q_yk3KzBTw0SOmoc=-zcm+3jAqEHe76AgQ@mail.gmail.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Sun, Sep 16, 2018 at 11:49 AM, Casey Schaufler
<casey@schaufler-ca.com> wrote:
> On 9/15/2018 5:30 PM, Kees Cook wrote:
>> To prepare for having a third type of LSM ("shared blob"), this implements
>> dynamic handling of LSM ordering. The visible change here is that the
>> "security=" boot commandline is now a comma-separated ordered list of
>> all LSMs, not just the single "exclusive" LSM. This means that the
>> "minor" LSMs can now be disabled at boot time by omitting them from the
>> commandline. Additionally LSM ordering becomes entirely mutable for LSMs
>> with LSM_ORDER_MUTABLE ("capability" is not mutable and is always enabled
>> first).
>
> Today if I have Yama enabled and use security=apparmor I get a
> module list of capability,yama,apparmor. With this change I would
> get a different result, capability,apparmor. I am personally OK with
> this, but I think others may see it as a violation of compatibility.

Correct. That is the problem I had asked about earlier: it means
people with existing security= for specifying the active major LSM
will _disable_ all the minor LSMs after this change. It makes me
uncomfortable.

> One solution is to leave security= as is, not affecting "minor"
> modules and only allowing specification of one major module, and adding

I would much prefer this, yes.

A question remains: how do we map the existing "security=" selection
of a "major" LSM against what will be next "exclusive" plus tomoyo,
and in the extreme case, nothing?

Perhaps as part of deprecating "security=", we could just declare that
it is selecting between SELinux, AppArmor, Smack, and Tomoyo only?

> another boot option security.stack= that overrides a security= option
> and that takes the list as you've implemented here.

or "lsm.stack=" that overrides "security=" entirely?

> An icky alternative would be to say that any security= specification
> with no commas in it retains the old behavior. So
>         security=apparmor
>         security=apparmor,
> would get you
>         capability,yama,apparmor
>         capability,apparmor
> respectively.
>
> Another option would be to require negation on the minor modules,
> such as
>         security=apparmor,-loadpin
>
> I can't honestly say which I like least or best.

The trailing comma thing gets us some compatibility, but we still have
to decide which things should be exclusive-via-"security=" since with
blob-sharing it already becomes possible to do selinux + tomoyo.

The -$lsm style may make it hard to sensibly order any unspecified
LSMs. I guess it could just fall back to "follow builtin ordering of
unspecified LSMs" (unless someone had, maybe, "-all").

so, if builtin ordering after blob-sharing is
capability,integrity,yama,loadpin,{selinux,apparmor,smack},tomoyo

security=apparmor  is  capability,apparmor,integrity,yama,loadpin,tomoyo

security=yama,smack,-all  is  capability,yama,smack

security=loadpin,selinux,yama,-integrity  is
capability,loadpin,selinux,yama,tomoyo


Whatever we design, it needs to handle both the blob-sharing
near-future, and have an eye towards "extreme stacking" in the
some-day future. In both cases, the idea of a "major" LSM starts to
get very very hazy.

As for how we classify things, based on hooks...

now:
    always: capability
    major: selinux,apparmor,smack,tomoyo
    minor: yama,loadpin
    init-only: integrity

blob-sharing:
    always: capability
    exclusive: selinux,apparmor,smack
    sharing: tomoyo,integrity,yama,loadpin

extreme:
    always: capability
    sharing: selinux,apparmor,smack,tomoyo,integrity,yama,loadpin

The most special are capability (unconditional, run first) and
integrity (init-only, no security_add_hooks() call).

Can we classify things as MAC and non-MAC for "major" vs "minor"? SARA
and Landlock aren't MAC (and neither is integrity), or should we do
the "-$lsm" thing instead?

-Kees

-- 
Kees Cook
Pixel Security
