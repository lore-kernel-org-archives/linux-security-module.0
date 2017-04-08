From: casey@schaufler-ca.com (Casey Schaufler)
Date: Sat, 8 Apr 2017 10:29:38 -0700
Subject: [PATCH RFC 00/11] LSM: Stacking for major security modules
In-Reply-To: <CAHC9VhQ5dG_wNUmmreaEKhXoNSj=gPEnug5Ft5wszVdYYJ13pg@mail.gmail.com>
References: <509e0281-9f8a-83c2-f9d6-5532903cda46@schaufler-ca.com>
	<1491503171.4532.10.camel@tycho.nsa.gov>
	<c6d9da56-fd4d-e8e5-caa5-718de74db261@schaufler-ca.com>
	<1491511104.4532.17.camel@tycho.nsa.gov>
	<alpine.LRH.2.20.1704070758310.27111@namei.org>
	<d812c25c-bb74-9e0c-a607-6a5e7efb73cc@schaufler-ca.com>
	<CAHC9VhQ5dG_wNUmmreaEKhXoNSj=gPEnug5Ft5wszVdYYJ13pg@mail.gmail.com>
Message-ID: <352aafb2-9c31-b92e-6d78-dd9a5b47da5a@schaufler-ca.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On 4/8/2017 6:14 AM, Paul Moore wrote:
> On Thu, Apr 6, 2017 at 6:50 PM, Casey Schaufler <casey@schaufler-ca.com> wrote:
>> On 4/6/2017 3:24 PM, James Morris wrote:
>>> On Thu, 6 Apr 2017, Stephen Smalley wrote:
>>>
>>>> Yes, but in the meantime, if you want to be able to test
>>>> CONFIG_SECURITY_STACKING=y with modules in enforcing mode on
>>>> distributions that enable a major security module, it seems like you
>>>> need to provide some way of handling this compatibly.
>>> Regardless of the config option, we can't break existing userspace. This
>>> is a long-standing Linux kernel development rule.
>>>
>>> You'll need to implement new interfaces for any changes.
>> The big question is SO_PEERSEC. SO_PEERSEC provides
>> undefined "security credentials". You don't need to
>> define a new interface here because the interface allows
>> different configurations (e.g. Smack active, SELinux
>> active, both active) to provide different information.
> Just a gentle reminder that ignoring existing conventions because the
> formal (?) specification declares the interface as "undefined" is a
> really good way to break userspace :)

Indeed. That's the lesson of /proc/.../attr/current. I
should *never* have reused that for Smack. Even the rationale
that "id wouldn't have to change" was flawed because that
program checks to see if SELinux is active and refuses to
even look if it isn't.

Alas, there is going to be a balance between "break old"
and "enable new". Of course we can create all new everything,
but I'm not a fan of API bloat. It's good to keep getting
feedback, even when I don't like it.

> In all seriousness, a new interface with a well defined specification
> that could support multiple labels/LSM might not be a bad idea if for
> no other reason that what we currently have is a bit broken, but works
> due to dumb luck (see the discussion in the GH issue below).
>
> https://github.com/SELinuxProject/selinux-kernel/issues/24
>
Oh my. I thought the mechanism was sort of peculiar,
but I wasn't really aware of all the details.

lsm_setsockattr(sock, "lsmname", "attrname", attr, attrlen);

lsm_getsockattr(sock, "lsmname" "attrname", attr, &attrlen);

These could be based on the current mechanisms or purpose
written for a new world order. There'd also have to be
something network magic-like for sendmsg() and recvmsg().
That's starting to sound like a lot of work.

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
