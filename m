From: casey@schaufler-ca.com (Casey Schaufler)
Date: Mon, 17 Sep 2018 17:24:37 -0700
Subject: [PATCH 16/18] LSM: Allow arbitrary LSM ordering
In-Reply-To: <CAGXu5jKhZTcz_+uQpNRh6Mg34pP2+aNSo9cV=c8pC0r=oJBJog@mail.gmail.com>
References: <20180916003059.1046-1-keescook@chromium.org>
	<20180916003059.1046-17-keescook@chromium.org>
	<84e1a5a8-8997-829f-cf09-1d29895a3f99@schaufler-ca.com>
	<CAGXu5jK5CzXUii97q_yk3KzBTw0SOmoc=-zcm+3jAqEHe76AgQ@mail.gmail.com>
	<35b0af5b-e37e-e192-73b5-0d0b37d9e37f@schaufler-ca.com>
	<CAGXu5jJ71RLGh0nDgOaN3vCXFGE0poXFU2Gb9o+20aO+AEdOvw@mail.gmail.com>
	<8f0bd39b-29a6-325d-4558-d9f484249c22@schaufler-ca.com>
	<CAGXu5jLeTfwEXAZLz_H1PCx0ySWZcRhXQMfnE14TG8BvxY46JA@mail.gmail.com>
	<53377892-695f-6336-8574-54c7aa0a4201@schaufler-ca.com>
	<7ecfffc3-d2a4-3ff7-4bf5-db3029d73c59@canonical.com>
	<fbdc2a75-8364-c743-f9c3-9dcd2570c569@schaufler-ca.com>
	<e9292d89-12bd-2c4a-9ca2-5758de790f2f@canonical.com>
	<CAGXu5jKhZTcz_+uQpNRh6Mg34pP2+aNSo9cV=c8pC0r=oJBJog@mail.gmail.com>
Message-ID: <ee3b287d-95a4-db16-e3c6-fc6f6172a5ae@schaufler-ca.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On 9/17/2018 5:00 PM, Kees Cook wrote:
> On Mon, Sep 17, 2018 at 3:36 PM, John Johansen
> <john.johansen@canonical.com> wrote:
>> On 09/17/2018 02:57 PM, Casey Schaufler wrote:
>>> Modules not listed may go anywhere there is a "*" in the order.
>>> An lsm.order= without a "*" is an error, and ignored.
>>> If a module is specified in lsm.order but not built in it is ignored.
>>> If a module is specified but disabled it is ignored.
>>> The capability module goes first regardless.
>> I don't mind using lsm.order if we must but really do not like the '*'
>> idea. It makes this way more complicated than it needs to be
> Having the "*" means that _not_ having it in "lsm.order=" is an
> implicit form of LSM disabling.

That's not what I said. What I said was that without a "*" the ordering
goes back to what was specified at build time. lsm.order does nothing
with enablement or disablement. If you say "lsm.order=smack,sara,*" and
sara is not compiled in you get smack followed by everything else.

> And I think we've gotten to the point
> where we agree on the enable/disable logic, so I don't want to mess
> that up again.
>
> For enable/disable, I think we're agreed on:
>
>     lsm.enable=$lsm
>     lsm.disable=$lsm

Works for me.

> lsm.disable takes precedent for disabling. (e.g. "lsm.disable=apparmor
> apparmor.enable=1" will leave apparmor disabled)
> lsm.enable will allow per-LSM enable/disable to operate. (e.g.
> "lsm.enable=apparmor apparmor.enable=0" will leave apparmor disabled)
>
> lsm.enable/disable ordering will be "last match": "lsm.disable=smack
> lsm.enable=smack" will leave smack enabled.

So far do good.

> The legacy per-LSM
> enable/disable ordering is the same, but ordering between
> lsm.enable/disable and the per-LSM options is NOT ordered. i.e. the
> precedent mentioned in the prior paragraph.

That is, capability,yama,loadpin,<major>

> To support "security=", we'll still have some kind of legacy
> LSM_FLAG_MAJOR to perform implicit disabling of the non-operational
> other "major" LSMs. This means "security=$foo" will be a short-hand
> for "lsm.disable=all-LSM_FLAG_MAJOR-who-are-not-$foo". This will
> exactly match current behavior (i.e. "security=smack" and if smack
> fails initialization, we do not then fall back to another major).

Right.

> I think we have to support runtime ordering for the reasons John
> specifies. Additionally, I have the sense that anything we can
> configure in Kconfig ultimately ends up being expressed at runtime
> too, so better to just make sure the design includes it now.

Right.

> What we have now:
>
> "first" then "order-doesn't-matter-minors" then "exclusive-major"
>
> - we can't change first.
> - exclusivity-ordering only matters in the face of enable/disable
> which we have solved now (?)

I'm not sure where you get the conclusion we've solved this.
Today I can't say "lsm.enable=smack lsm.enable=apparmor", and
there's no mechanism to prevent that.

> so, ordering can be totally arbitrary after "first" (but before some
> future "last"). We must not allow a token for "everything else" since
> that overlaps with enable/disable, so "everything else" stay implicit
> (I would argue a trailing implicit ordering).

There's an assumption you're making that I'm not getting. Where does
this overlap between ordering and enable/disable come from?

> The one complication I see with ordering, then, is that if we change
> the exclusivity over time, we change what may be present on the
> system. For example, right now tomoyo is exclusive. Once we have
> blob-sharing, it doesn't need to be.
>
> so: lsm.order=tomoyo  after this series means
> "capability,tomoyo,yama,loadpin,integrity", but when tomoyo becomes
> non-exclusive, suddenly we get
> "capability,tomoyo,yama,loadpin,{selinux,smack,apparmor},integrity".
> (i.e. if selinux is disabled then move on to trying smack, then
> apparmor, etc.)

We're missing a description of what happens at build time.
It's hard to see what you expect to happen if I want to build in
all the major modules and don't plan to use the boot command line
options.

> I would argue that this is a design feature (LSMs aren't left behind),
> and order of enabled exclusive LSMs "wins" the choice for the
> exclusivity (instead of operating "by name" the way "security="
> works).

I think I see more, but I'm guessing. At build time it looks like
you're dropping the specification on the "major" module. We can't
do that because I want to build kernels that run Smack by default
but include SELinux for when I'm feeling less evil than normal.
