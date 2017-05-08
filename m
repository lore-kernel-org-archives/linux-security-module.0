From: casey@schaufler-ca.com (Casey Schaufler)
Date: Mon, 8 May 2017 13:07:50 -0700
Subject: [PATCH v1] LSM: Enable multiple calls to security_add_hooks() for
	the same LSM
In-Reply-To: <ca662813-e078-c579-d5a8-46ea03542f4b@digikod.net>
References: <20170429190257.27137-1-mic@digikod.net>
	<alpine.LRH.2.20.1705010926080.12672@namei.org>
	<ca662813-e078-c579-d5a8-46ea03542f4b@digikod.net>
Message-ID: <aabebe53-f4e6-c91e-01f4-e027bec38cd9@schaufler-ca.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On 5/8/2017 12:24 PM, Micka?l Sala?n wrote:
> On 01/05/2017 01:28, James Morris wrote:
>> On Sat, 29 Apr 2017, Micka?l Sala?n wrote:
>>
>>> Check if the registering LSM already registered hooks just before. This
>>> enable to split hook declarations into multiple files without
>>> registering multiple time the same LSM name, starting from commit
>>> d69dece5f5b6 ("LSM: Add /sys/kernel/security/lsm").
>> Please include a detailed rationale for these patches.  The above tells us 
>> very little about why they are needed.
> Right, what do you think about that?
>
> The commit d69dece5f5b6 ("LSM: Add /sys/kernel/security/lsm") extend
> security_add_hooks() with a new parameter to register the LSM name,
> which may be useful to make the list of currently loaded LSM available
> to userspace. However, there is no clean way for an LSM no split its
> hook declarations into multiple files, which may reduce the mess with
> all the included files (needed for LSM hook argument types) and make the
> source code easier to review and maintain.
>
> This change allows an LSM to register multiple times its hook while
> keeping a consistent list of LSM names as described in
> Documentation/security/LSM.txt . The list reflects the order in which
> checks are made. This patch only check for the last registered LSM,
> which should be the only case. If an LSM register multiple times its
> hooks, interleaved with other LSM registrations, which should not
> happen, its name will still appear in the same order that the hooks are
> called, hence multiple times.
>
>
> Casey, Tetsuo, are you OK with this approach or do you want me to handle
> the case with interleaved hook registration, i.e. no duplicate name nor
> following the current Documentation/security/LSM.txt?
> What about the API with the NULL name (which is much simpler)?

Initially I thought that the module name should
never appear more than once, however I could see
a module that would bracket another or another set,
so

	capability,spiffy,selinux

might be different behaviorally than

	capability,spiffy,selinux,spiffy

and userspace might care. I still don't see any value
in

	capability,selinux,spiffy,spiffy

Passing a NULL name could lead to ambiguity if more
than one module did that, so I can't say I approve.


>
> Regards,
>  Micka?l
>

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
