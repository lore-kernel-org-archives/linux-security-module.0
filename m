From: keescook@chromium.org (Kees Cook)
Date: Mon, 17 Sep 2018 09:24:07 -0700
Subject: [PATCH 16/18] LSM: Allow arbitrary LSM ordering
In-Reply-To: <35b0af5b-e37e-e192-73b5-0d0b37d9e37f@schaufler-ca.com>
References: <20180916003059.1046-1-keescook@chromium.org>
	<20180916003059.1046-17-keescook@chromium.org>
	<84e1a5a8-8997-829f-cf09-1d29895a3f99@schaufler-ca.com>
	<CAGXu5jK5CzXUii97q_yk3KzBTw0SOmoc=-zcm+3jAqEHe76AgQ@mail.gmail.com>
	<35b0af5b-e37e-e192-73b5-0d0b37d9e37f@schaufler-ca.com>
Message-ID: <CAGXu5jJ71RLGh0nDgOaN3vCXFGE0poXFU2Gb9o+20aO+AEdOvw@mail.gmail.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Mon, Sep 17, 2018 at 8:06 AM, Casey Schaufler <casey@schaufler-ca.com> wrote:
>> The trailing comma thing gets us some compatibility, but we still have
>> to decide which things should be exclusive-via-"security=" since with
>> blob-sharing it already becomes possible to do selinux + tomoyo.
>>
>> The -$lsm style may make it hard to sensibly order any unspecified
>> LSMs. I guess it could just fall back to "follow builtin ordering of
>> unspecified LSMs" (unless someone had, maybe, "-all").
>
> That's why I'm not especially happy with either one.
>
>> so, if builtin ordering after blob-sharing is
>> capability,integrity,yama,loadpin,{selinux,apparmor,smack},tomoyo
>>
>> security=apparmor  is  capability,apparmor,integrity,yama,loadpin,tomoyo
>
> I would expect capability,integrity,yama,loadpin,apparmor to reflect
> today's behavior.

If that's desired then we have to declare tomoyo as "exclusive" even
though it doesn't use blobs. But then what happens in the extreme
stacking case? Do we add "lsm.extreme=1" to change how security= is
parsed?

>> security=yama,smack,-all  is  capability,yama,smack
>
> Yes
>
>> security=loadpin,selinux,yama,-integrity  is
>> capability,loadpin,selinux,yama,tomoyo
>
> I think that the negation should only apply to
> integrity, yama and loadpin. All blob-using modules
> must be explicitly stated if you want to use them.

What about tomoyo, though? It's presently considered a major LSM (i.e.
security=tomoyo disables the other majors), but it doesn't use blobs.

>> Whatever we design, it needs to handle both the blob-sharing
>> near-future, and have an eye towards "extreme stacking" in the
>> some-day future. In both cases, the idea of a "major" LSM starts to
>> get very very hazy.
>
> Long term the only distinction is "minor" and blob using. So long as
> there's a way to enforce incompatibility (i.e. not Smack and SELinux)
> in the sorter term we can adopt that mindset already.

Given that tomoyo doesn't share blobs and integrity doesn't register
hooks, how would they be considered in that world? Or rather, what
distinguishes a "minor" LSM? It seems there are three cases: uses
blobs with sharing, uses blobs without sharing, uses no blobs. What
happens if an LSM grows a feature that needs blob sharing? If "uses no
blobs" should be considered "shares blobs", then there is no
distinction between "minor" and "blob sharing".

>> As for how we classify things, based on hooks...
>>
>> now:
>>     always: capability
>>     major: selinux,apparmor,smack,tomoyo
>>     minor: yama,loadpin
>>     init-only: integrity
>>
>> blob-sharing:
>>     always: capability
>>     exclusive: selinux,apparmor,smack
>>     sharing: tomoyo,integrity,yama,loadpin
>>
>> extreme:
>>     always: capability
>>     sharing: selinux,apparmor,smack,tomoyo,integrity,yama,loadpin
>>
>> The most special are capability (unconditional, run first) and
>> integrity (init-only, no security_add_hooks() call).
>>
>> Can we classify things as MAC and non-MAC for "major" vs "minor"? SARA
>> and Landlock aren't MAC (and neither is integrity), or should we do
>> the "-$lsm" thing instead?
>
> I don't like using MAC because the use of the module isn't the issue,
> it's the interfaces used. As ugly as it is, I like the -$lsm better.

Agreed on MAC. And yes, I think -$lsm is best here. Should we overload
"security=" or add "lsm.stacking="?

-Kees

-- 
Kees Cook
Pixel Security
