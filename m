From: casey@schaufler-ca.com (Casey Schaufler)
Date: Wed, 21 Jun 2017 16:45:29 -0700
Subject: The secmark "one user" policy
In-Reply-To: <935eeedd-95d0-168b-c2ac-331c49b14f2b@canonical.com>
References: <d256e588-fd3c-b981-6d55-6723b5615cc9@schaufler-ca.com>
	<alpine.LRH.2.20.1706211713010.1310@namei.org>
	<2fbe01aa-8f9b-37f0-f79a-e34dcd1d0705@schaufler-ca.com>
	<935eeedd-95d0-168b-c2ac-331c49b14f2b@canonical.com>
Message-ID: <5ead7b1d-f4e6-c550-6b5b-1c5494e66147@schaufler-ca.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On 6/21/2017 4:07 PM, John Johansen wrote:
> On 06/21/2017 08:23 AM, Casey Schaufler wrote:
>> On 6/21/2017 12:13 AM, James Morris wrote:
>>> On Tue, 20 Jun 2017, Casey Schaufler wrote:
>>>
>>>> I'm looking at the secmark code and am looking in
>>>> particular at the places where it explicitly says
>>>> that it is intended for one security module at a
>>>> time. For extreme stacking I can either enforce this
>>>> restriction by configuration or remove it by clever
>>>> uses of secid mappings. Either can be made "transparent"
>>>> to existing user-space. Paul has expressed distaste for
>>>> using configuration as a shortcut for dealing with this
>>>> kind of problem, and I generally agree with him. On the
>>>> other hand, the code is quite clear that it is designed
>>>> for one and only one kind of secid at a time. I don't
>>>> want to put a lot of effort into patches that are
>>>> unacceptable to the author.
>>> How would you see this working, ideally?
>> Ideally there would be a separate secmark for each security
>> module that wants to use the mechanism. Mechanism would be
>> provided* so that user-space can identify which security
>> module it is referring to when interacting with the kernel.
>> My understanding is that we're unlikely to get an expanded
>> secmark, so I have concentrated elsewhere.
>>
>> A "clever" secid mapping takes the secids from all the
>> security modules and gently manipulates them until they
>> fit into a single u32. This might be an index into a list
>> of secid sets, but if you have two modules using secids
>> you can give each half of the secmark and accommodate
>> many configurations, including Fedora. Again, you need
>> mechanism* for user-space. This option would require changes
>> to the xt_SECMARK implementation, which goes out of it's
>> way to ensure all secmarks come from the same security
>> module. One option is to add a SECMARK_MODE_COMPOUND, but
>> that isn't any more helpful then removing the restriction.
>>
>> As for configuration options, SELinux only uses secmarks
>> when user-space introduces them. If netfilter doesn't have
>> any security rules that add secmarks, none are used. Smack
>> can be configured to set secmarks on all packets, with the
>> potential for change by user-space, but can also be set up
>> without any use of secmarks. There doesn't need to be any
>> significant change to xt_SECMARK if it is important to
>> maintain the "one user" model. Requiring that the user-space
>> use of netfilter be sane for the multiple security module
>> case (e.g. don't use SELinux firewall if Smack has the
>> secmark) seems somewhat reasonable.
>>
>> I can work with any of these three solutions. Multiple
>> secmarks would be ideal, but I understand is a lost cause.
>> Clever secids add overhead and complexity. Restricting
>> configuration options is unsavory, but I don't think
>> unreasonably so.
>>
> I too would prefer multiple secmarks, but doing some sort of mapping
> seems like what we will be stuck with. For a first pass I think the
> restricted configurations options is reasonable, but I think it will
> become a problem as people start trying to actually use LSM stacking.
>
> I think for now sticking with restricted configurations and dealing
> with mappings when it becomes an actual issue and we have better use
> cases is not an unreasonable approach.

It boils down to how many security modules are going to
implement network controls that require passing information
with the packet. I can easily see a bunch of use cases
beyond what SELinux and Smack do, but I can't say that I'd
see those used in conjunction with the "old school" security
modules. We can have a lousy mapping scheme if we don't
expect it to be used except in unnatural cases.

Is AppArmor going to be using secmarks? I haven't looked at
what's going into 4.13 yet. If you are, are they required or
optional, or used when netfilter assigns them?

>> ---
>> * There's already need to identity which security module
>> you're dealing with at a given time for SO_PEERSEC and
>> /proc/.../attr/current. In the past I've suggested decorating
>> attribute values with the name of the module (smack='System')
>> but I'm currently leaning more toward a prctl() to set the
>> value if you don't want to get whatever comes first. That
>> should maximize the effectiveness of existing user-space
>> tools.
>>

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
