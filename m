From: casey@schaufler-ca.com (Casey Schaufler)
Date: Mon, 17 Sep 2018 17:57:43 -0700
Subject: [PATCH 16/18] LSM: Allow arbitrary LSM ordering
In-Reply-To: <CAGXu5jK4pa7-G8zhHE-noM4qVQGytTzcKX4BkQFkuJmEbLONaw@mail.gmail.com>
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
	<ee3b287d-95a4-db16-e3c6-fc6f6172a5ae@schaufler-ca.com>
	<CAGXu5jK4pa7-G8zhHE-noM4qVQGytTzcKX4BkQFkuJmEbLONaw@mail.gmail.com>
Message-ID: <580f7894-14d7-c0a3-75b7-9a5f4e3af0b8@schaufler-ca.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On 9/17/2018 5:45 PM, Kees Cook wrote:
> On Mon, Sep 17, 2018 at 5:24 PM, Casey Schaufler <casey@schaufler-ca.com> wrote:
>> On 9/17/2018 5:00 PM, Kees Cook wrote:
>>> The legacy per-LSM
>>> enable/disable ordering is the same, but ordering between
>>> lsm.enable/disable and the per-LSM options is NOT ordered. i.e. the
>>> precedent mentioned in the prior paragraph.
>> That is, capability,yama,loadpin,<major>
> Yeah, sorry, I didn't mean LSM order there, I meant the commandline
> order of appearance of the options. If you mix them, the last
> lsm.enable/disable for an LSM is the "real" setting, and the last
> $LSM.enabled= setting is the last of _that_ one.
>
>>> To support "security=", we'll still have some kind of legacy
>>> LSM_FLAG_MAJOR to perform implicit disabling of the non-operational
>>> other "major" LSMs. This means "security=$foo" will be a short-hand
>>> for "lsm.disable=all-LSM_FLAG_MAJOR-who-are-not-$foo". This will
>>> exactly match current behavior (i.e. "security=smack" and if smack
>>> fails initialization, we do not then fall back to another major).
>> Right.
> Cool.
>
>>> I think we have to support runtime ordering for the reasons John
>>> specifies. Additionally, I have the sense that anything we can
>>> configure in Kconfig ultimately ends up being expressed at runtime
>>> too, so better to just make sure the design includes it now.
>> Right.
>>
>>> What we have now:
>>>
>>> "first" then "order-doesn't-matter-minors" then "exclusive-major"
>>>
>>> - we can't change first.
>>> - exclusivity-ordering only matters in the face of enable/disable
>>> which we have solved now (?)
>> I'm not sure where you get the conclusion we've solved this.
>> Today I can't say "lsm.enable=smack lsm.enable=apparmor", and
>> there's no mechanism to prevent that.
>>
>>> so, ordering can be totally arbitrary after "first" (but before some
>>> future "last"). We must not allow a token for "everything else" since
>>> that overlaps with enable/disable, so "everything else" stay implicit
>>> (I would argue a trailing implicit ordering).
>> There's an assumption you're making that I'm not getting. Where does
>> this overlap between ordering and enable/disable come from?
> Handling exclusivity means the non-active LSMs are disabled. We had
> been saying "the other majors are disabled", but the concept of major
> will become arbitrary. If instead we move to "first exclusive wins
> among the exclusives", we still have the "the others are disabled"
> case. So exclusivity begets disabling.
>
>>> The one complication I see with ordering, then, is that if we change
>>> the exclusivity over time, we change what may be present on the
>>> system. For example, right now tomoyo is exclusive. Once we have
>>> blob-sharing, it doesn't need to be.
>>>
>>> so: lsm.order=tomoyo  after this series means
>>> "capability,tomoyo,yama,loadpin,integrity", but when tomoyo becomes
>>> non-exclusive, suddenly we get
>>> "capability,tomoyo,yama,loadpin,{selinux,smack,apparmor},integrity".
>>> (i.e. if selinux is disabled then move on to trying smack, then
>>> apparmor, etc.)
>> We're missing a description of what happens at build time.
>> It's hard to see what you expect to happen if I want to build in
>> all the major modules and don't plan to use the boot command line
>> options.
>>
>>> I would argue that this is a design feature (LSMs aren't left behind),
>>> and order of enabled exclusive LSMs "wins" the choice for the
>>> exclusivity (instead of operating "by name" the way "security="
>>> works).
>> I think I see more, but I'm guessing. At build time it looks like
>> you're dropping the specification on the "major" module. We can't
>> do that because I want to build kernels that run Smack by default
>> but include SELinux for when I'm feeling less evil than normal.
> Do we need build time _ordering_, or can we just go with build time
> "first exclusive"? For the v1, I went with "first exclusive" from
> CONFIG_SECURITY_DEFAULT, and left the rest of the ordering up to the
> Makefile.

If I read you correctly, "first exclusive" would suit my needs just fine.
I like the notion of build time ordering because I hate using the boot
command line.
