From: mic@digikod.net (=?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?=)
Date: Thu, 20 Apr 2017 00:03:16 +0200
Subject: [PATCH net-next v6 04/11] landlock: Add LSM hooks related to
	filesystem
In-Reply-To: <CAGXu5jKCr1qPqJ8YWAjK1Lj-fThAhMnrxFW8twFcj6C9ODBpsA@mail.gmail.com>
References: <20170328234650.19695-1-mic@digikod.net>
	<20170328234650.19695-5-mic@digikod.net>
	<CAGXu5jJKNp8R5kZ1U=K7KwgnV=NvH5aoAbftA-05a_Sa4pOg1Q@mail.gmail.com>
	<9a69055a-b4cf-00b0-da5e-2e45ff88059c@digikod.net>
	<c122415d-c2be-d013-efb4-833ba87d144d@schaufler-ca.com>
	<CAGXu5jKCr1qPqJ8YWAjK1Lj-fThAhMnrxFW8twFcj6C9ODBpsA@mail.gmail.com>
Message-ID: <35272f2b-ec5f-d032-ae2e-9fc0b4c0e2e3@digikod.net>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org


On 19/04/2017 01:40, Kees Cook wrote:
> On Tue, Apr 18, 2017 at 4:16 PM, Casey Schaufler <casey@schaufler-ca.com> wrote:
>> On 4/18/2017 3:44 PM, Micka?l Sala?n wrote:
>>> On 19/04/2017 00:17, Kees Cook wrote:
>>>> On Tue, Mar 28, 2017 at 4:46 PM, Micka?l Sala?n <mic@digikod.net> wrote:
>>>>> +void __init landlock_add_hooks(void)
>>>>> +{
>>>>> +       pr_info("landlock: Version %u", LANDLOCK_VERSION);
>>>>> +       landlock_add_hooks_fs();
>>>>> +       security_add_hooks(NULL, 0, "landlock");
>>>>> +       bpf_register_prog_type(&bpf_landlock_type);
>>>> I'm confused by the separation of hook registration here. The call to
>>>> security_add_hooks is with count=0 is especially weird. Why isn't this
>>>> just a single call with security_add_hooks(landlock_hooks,
>>>> ARRAY_SIZE(landlock_hooks), "landlock")?
>>> Yes, this is ugly with the new security_add_hooks() with three arguments
>>> but I wanted to split the hooks definition in multiple files.
>>
>> Why? I'll buy a good argument, but there are dangers in
>> allowing multiple calls to security_add_hooks().

I prefer to have one file per hook "family" (e.g. filesystem, network,
ptrace?). This reduce the mess with all the included files (needed for
LSM hook argument types) and make the files easier to read, understand
and maintain.

>>
>>>
>>> The current security_add_hooks() use lsm_append(lsm, &lsm_names) which
>>> is not exported. Unfortunately, calling multiple security_add_hooks()
>>> with the same LSM name would register multiple names for the same LSM?
>>> Is it OK if I modify this function to not add duplicated entries?
>>
>> It may seem absurd, but it's conceivable that a module might
>> have two hooks it wants called. My example is a module that
>> counts the number of times SELinux denies a process access to
>> things (which needs to be called before and after SELinux in
>> order to detect denials) and takes "appropriate action" if
>> too many denials occur. It would be weird, wonky and hackish,
>> but that never stopped anybody before.

Right, but now, with the new lsm_append(), module names are concatenated
("%s,%s") in the lsm_names variable. It would be nice to not pollute
this string with multiple time the same module name.

> 
> If ends up being sane and clear, I'm fine with allowing multiple calls.
> 
> -Kees
> 

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 488 bytes
Desc: OpenPGP digital signature
URL: <http://kernsec.org/pipermail/linux-security-module-archive/attachments/20170420/48883516/attachment.sig>
