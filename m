From: john.johansen@canonical.com (John Johansen)
Date: Wed, 14 Jun 2017 15:59:07 -0700
Subject: Is there a generic LSM/kernel ABI analogous to getcon_raw() and
	aa_getcon()?
In-Reply-To: <a934d38f-5794-1ec7-3abd-40051593ae3c@canonical.com>
References: <20170613174519.nmrdglusytvjtdem@archetype.pseudorandom.co.uk>
	<cc28a551-08b5-aeb4-382a-9ad86f51ddac@schaufler-ca.com>
	<20170614114430.ooti2gqxllkqz2fe@archetype.pseudorandom.co.uk>
	<d95670e5-837e-2cd3-7bf1-424a3cd89eec@schaufler-ca.com>
	<a934d38f-5794-1ec7-3abd-40051593ae3c@canonical.com>
Message-ID: <11419d24-27cf-10d4-295e-daba6427623c@canonical.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On 06/14/2017 03:44 PM, John Johansen wrote:
> On 06/14/2017 09:06 AM, Casey Schaufler wrote:
>> On 6/14/2017 4:44 AM, Simon McVittie wrote:
>>> On Tue, 13 Jun 2017 at 11:56:00 -0700, Casey Schaufler wrote:
>>>> On 6/13/2017 10:45 AM, Simon McVittie wrote:
>>>>> For specific LSMs, we can do this: libselinux and libapparmor
>>>>> both have function calls that wrap a read from /proc/self/current/attr[1].
>>>> I assume you mean /proc/self/attr/current
>>> You assume correctly.
>>>
>>>>> However, I'm really keen to keep GetConnectionCredentials() LSM-agnostic:
>>>>> using libselinux and libapparmor wouldn't cover Smack or new LSMs,
>>>> Nor should they. 
>>>>
>>>> There is a smack_new_label_from_self() in libsmack, which is maintained at:
>>>>
>>>> 	https://github.com/smack-team/smack
>>> That works up to a point, but I hope you can see why this doesn't
>>> really scale very well! For LSMs that are less widespread than SELinux
>>> and AppArmor, we get an unappealing choice between writing and supporting
>>> new LSM-specific code for each LSM, or ignoring those LSMs.
>>
>> Thank you for taking on the mantle of the bold pioneer who is
>> (finally) working on the LSM API. You are very brave.
>>
>> One of your greatest challenges will be fending off the people
>> who believe that you're done once you support their favorite
>> security module. If it's going to be a proper LSM API it's got
>> to support all the existing modules and provide design guidance
>> to someone creating a new module. I assume that you knew the job
>> was dangerous when you took it.
>>
>> Consider the option of eschewing the existing module specific APIs
>> and going directly to /proc/self/attr/current and SO_PEERSEC.
>>
>>> We already don't really have enough SELinux expertise among the active
>>> dbus maintainers for that part to be a first-class citizen, and we only
>>> have AppArmor knowledge because I happen to be using it in another
>>> project, so I'd be very reluctant to add new LSM-specifics without
>>> someone from the relevant LSM committing to being available to
>>> support it.
>>
>> Thank you for asking. How do I get on your list?
>>
>>> That's why LinuxSecurityLabel in the result of GetConnectionCredentials()
>>> is defined in terms of SO_PEERSEC, so we can delegate the exact behaviour
>>> to the Linux kernel and LSM maintainers - whatever happens to that socket
>>> option in future LSM development, that's what we make available to clients.
>>
>> The issue is that /proc/.../current doesn't give you the same thing as
>> SO_PEERSEC? Or that the format of what comes out of one isn't the same
>> as what comes out of the other? I'm a little confused about what problem
>> you are solving by using GetConnectionCredentials() instead of reading
>> /proc/.../current
>>
> dbus is a userspace acts as a userspace proxy
> 
> A <===> dbus <====> B
> 
> A wants to know the credentials of B. GetConnectionCredentials() is
> essentially the dbus equiv of using SO_PEERSEC in the situation of
> 
> A <===> B
> 
> 
And for this situation it makes sense to pass the output of using SO_PEERSEC
directly and not using the lsm api's.

I know its a little more complicated than that in that them LSM specific
extensions are also doing things and directly poking at /proc/ and
SO_PEERSEC.

And of course I haven't followed enough to know how else Simon wants
to use this info.

I can say from the apparmor end we aren't using the troublesome trailing
\n\0 (at least at the api) and those can be thrown away without
affecting the dbus apprmor dbus code.

I haven't been able to find my notes on why I had leave that trailing
garbage in back in 2009.
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
