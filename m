From: john.johansen@canonical.com (John Johansen)
Date: Wed, 14 Jun 2017 15:44:41 -0700
Subject: Is there a generic LSM/kernel ABI analogous to getcon_raw() and
	aa_getcon()?
In-Reply-To: <d95670e5-837e-2cd3-7bf1-424a3cd89eec@schaufler-ca.com>
References: <20170613174519.nmrdglusytvjtdem@archetype.pseudorandom.co.uk>
	<cc28a551-08b5-aeb4-382a-9ad86f51ddac@schaufler-ca.com>
	<20170614114430.ooti2gqxllkqz2fe@archetype.pseudorandom.co.uk>
	<d95670e5-837e-2cd3-7bf1-424a3cd89eec@schaufler-ca.com>
Message-ID: <a934d38f-5794-1ec7-3abd-40051593ae3c@canonical.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On 06/14/2017 09:06 AM, Casey Schaufler wrote:
> On 6/14/2017 4:44 AM, Simon McVittie wrote:
>> On Tue, 13 Jun 2017 at 11:56:00 -0700, Casey Schaufler wrote:
>>> On 6/13/2017 10:45 AM, Simon McVittie wrote:
>>>> For specific LSMs, we can do this: libselinux and libapparmor
>>>> both have function calls that wrap a read from /proc/self/current/attr[1].
>>> I assume you mean /proc/self/attr/current
>> You assume correctly.
>>
>>>> However, I'm really keen to keep GetConnectionCredentials() LSM-agnostic:
>>>> using libselinux and libapparmor wouldn't cover Smack or new LSMs,
>>> Nor should they. 
>>>
>>> There is a smack_new_label_from_self() in libsmack, which is maintained at:
>>>
>>> 	https://github.com/smack-team/smack
>> That works up to a point, but I hope you can see why this doesn't
>> really scale very well! For LSMs that are less widespread than SELinux
>> and AppArmor, we get an unappealing choice between writing and supporting
>> new LSM-specific code for each LSM, or ignoring those LSMs.
> 
> Thank you for taking on the mantle of the bold pioneer who is
> (finally) working on the LSM API. You are very brave.
> 
> One of your greatest challenges will be fending off the people
> who believe that you're done once you support their favorite
> security module. If it's going to be a proper LSM API it's got
> to support all the existing modules and provide design guidance
> to someone creating a new module. I assume that you knew the job
> was dangerous when you took it.
> 
> Consider the option of eschewing the existing module specific APIs
> and going directly to /proc/self/attr/current and SO_PEERSEC.
> 
>> We already don't really have enough SELinux expertise among the active
>> dbus maintainers for that part to be a first-class citizen, and we only
>> have AppArmor knowledge because I happen to be using it in another
>> project, so I'd be very reluctant to add new LSM-specifics without
>> someone from the relevant LSM committing to being available to
>> support it.
> 
> Thank you for asking. How do I get on your list?
> 
>> That's why LinuxSecurityLabel in the result of GetConnectionCredentials()
>> is defined in terms of SO_PEERSEC, so we can delegate the exact behaviour
>> to the Linux kernel and LSM maintainers - whatever happens to that socket
>> option in future LSM development, that's what we make available to clients.
> 
> The issue is that /proc/.../current doesn't give you the same thing as
> SO_PEERSEC? Or that the format of what comes out of one isn't the same
> as what comes out of the other? I'm a little confused about what problem
> you are solving by using GetConnectionCredentials() instead of reading
> /proc/.../current
> 
dbus is a userspace acts as a userspace proxy

A <===> dbus <====> B

A wants to know the credentials of B. GetConnectionCredentials() is
essentially the dbus equiv of using SO_PEERSEC in the situation of

A <===> B


>> The SELinux support in dbus-daemon (from Fedora/Red Hat) came first,
>> and I think it may have been the only widespread LSM at the time; but for
>> the AppArmor support (from Ubuntu) I insisted on generalizing the parts
>> that could be generalized.
> 
> General being something other than a text string?
> 
>> If the kernel/LSMs don't offer a reliable way to find out our own
>> security label in a form compatible with SO_PEERSEC, then we might have
>> to just not offer that to clients either.
> 
>  
> Upstream only SELinux and Smack provide both /proc/.../current
> and SO_PEERSEC. They provide label strings that can be compared.
> AppArmor does not support SO_PEERSEC as of 4.12. So as of today,
> there isn't a problem. Or am I missing something?
> 
Simon has been using kernels with Ubuntu patchset for apparmor which
does support SO_PEERSEC.

The 3.13 pull request updates the upstream code to a common base, so
you should be seeing RFCs for this stuff soon.

> 
> 
>>> You also need to be aware that there is work ongoing to allow
>>> multiple modules that currently provide these facilities to work
>>> at the same time. That work could make your efforts both easier
>>> and harder.
>> How does this work in SO_PEERSEC? If the result is a "bytestring"
>> (like a path or environment variable - 0 or more bytes other than '\0',
>> followed by a '\0' terminator, with length considered to be either
>> strlen(x) or strlen(x)+1) then dbus-daemon will continue to pass it
>> through faithfully, without needing to parse or understand it.
> 
> What I've proposed in the past in a string like:
> 
> 	selinux="mumble_t",smack="Mumble",apparmor="aa_mumble"
> 
> This has a problem with AppArmor's use of newlines, but we had
> discussions that led me to believe this is surmountable.
> 
I am trying to get rid of those, and force tightening of the spec.
We are also moving the write end of our set_execon equiv away
from the proc interface so that won't be the issue it was in the
past

> An option which I have been investigating is to add a
> sockopt to specify which security module's data you want
> getsockopt(..., SO_PEERSEC, ...) to provide. If you haven't
> specified, you get the first available (per the wishes of the
> SELinux crowd). If you specify an LSM name you get the value
> for that. If you specify "context" you get the wacky string
> with all the available modules. I'm leaning in this direction
> because it should be easier on the existing userspace. Only
> those that are aware of the possibility of multiple security
> modules need to be modified.
> 
>> Obviously, the eventual consumer of this information (the D-Bus service,
>> in this case systemd) will need LSM-specific code to parse the forwarded
>> SO_PEERSEC result and use it in their security rules, and that code
>> would need to use a suitably updated libselinux or similar that can
>> parse out just the SELinux label from a stack of labels; but they'd
>> need those LSM-specifics to make an informed policy decision anyway.
>> So the LSM-specifics are confined to just the producer (the kernel)
>> and the eventual consumer (systemd or whatever other service).
>>
>> Thanks,
>>     S
>>
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
