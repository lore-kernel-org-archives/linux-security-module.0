From: sargun@sargun.me (Sargun Dhillon)
Date: Mon, 26 Mar 2018 14:10:55 -0700
Subject: [RFC PATCH 2/2] security: Add mechanism to (un)load LSMs after
	boot time
In-Reply-To: <9ec6273d-ab7e-1e9d-1cac-6464d0b78860@schaufler-ca.com>
References: <cover.1522091329.git.sargun@sargun.me>
	<af077529868a212caeb822ae79d72a1ac40f17ba.1522091329.git.sargun@sargun.me>
	<fbe62489-42a7-6418-351a-5661de7deee3@huawei.com>
	<CAMp4zn-NK4gre0cwaBnYrujVXEpA97OGzcbxqrySz=X91Lu+kQ@mail.gmail.com>
	<9ec6273d-ab7e-1e9d-1cac-6464d0b78860@schaufler-ca.com>
Message-ID: <CAMp4zn_u-zU1wLViqNe6jZ_rzDoE0G270BtZ8dNO4+MpW8piOg@mail.gmail.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Mon, Mar 26, 2018 at 2:04 PM, Casey Schaufler <casey@schaufler-ca.com> wrote:
> On 3/26/2018 1:24 PM, Sargun Dhillon wrote:
>> On Mon, Mar 26, 2018 at 1:17 PM, Igor Stoppa <igor.stoppa@huawei.com> wrote:
>>>
>>> On 26/03/18 22:24, Sargun Dhillon wrote:
>>>> This patch introduces a mechanism to add mutable hooks at the end of the
>>>> callback chain for each LSM hook. It allows for built-in kernel LSMs
>>>> to be unloaded, as well as modular LSMs to be loaded after boot-time.
>>>> It also does not compromise the security of hooks which are never
>>>> meant to be unloaded.
>>> Looking at this from the perspective of really convincing people to use
>>> other modules, there is a problem, imho.
>>>
>>> [...]
>>>
>>>>       /*
>>>>        * Register with LSM
>>>>        */
>>>> -     security_add_hooks(smack_hooks, ARRAY_SIZE(smack_hooks), "smack");
>>>> +     security_add_hooks(smack_hooks, ARRAY_SIZE(smack_hooks), "smack",
>>>> +                             false);
>>> Hardcoding what is (im)mutable will never satisfy everyone.
>>> If, instead, this decision was delegated to the kernel command line, it
>>> would be possible to have any module to become immutable -or not-
>>> depending on the default values and the configuration received at boot.
>>>
>>> A distro could ship with its defaults and then any user could
>>> reconfigure it, without having to recompile or install anything, just
>>> editing the command line.
>>>
>>> --
>>> igor
>> Today, the only "mutable" module we have is SELinux.
>
> Paul Moore has threatened to remove the "mutable" option from
> SELinux should it bump up high enough on his priority list.
> The conditions under which you can disable SELinux are very
> limited, you can't unload it after the policy has been loaded.
>
>>  It has a kernel
>> config flag which determines if it is unloadable (mutable) or not. If
>> you look at the patchset, it, in fact, sets mutability based on that
>> config flag:
>>
>>
>> -       security_add_hooks(selinux_hooks, ARRAY_SIZE(selinux_hooks), "selinux");
>> +       security_add_hooks(selinux_hooks, ARRAY_SIZE(selinux_hooks), "selinux",
>> +                               IS_ENABLED(CONFIG_SECURITY_SELINUX_DISABLE));
>>
>> Similarly, modules can change this behaviour based on their own
>> choices, whether that be config flags, boot parameters, or similar. In
>> my opinion, most LSMs should never be unloadable. In fact, we don't
>> really have a safe way (in this patchset) to unload the security
>> modules' code safely. Doing this would either require usage of (s)rcu,
>> or a similar concurrency control mechanism.
>
> If you can't safely unload the code, what is the point of making
> a module unloadable? Start every hook with:
s/module/hook/
Ask the SELinux folk?
>
>         if (!gonkulator_enabled)
>                 return appropriately;
>
> and provide mechanism for flipping the switch.
>

I intend to eventually follow-up this patch with a way to safely
unload the code, but I'd prefer to get (safe) dynamic *hooking* and
*unhooking* first, and then later on we can make it so the code can
get unloaded.
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
