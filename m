From: casey@schaufler-ca.com (Casey Schaufler)
Date: Sun, 19 Mar 2017 11:36:04 -0700
Subject: [PATCH RFC 1/9] LSM: Add /sys/kernel/security/lsm
In-Reply-To: <201703181653.IJE26029.OHMOOFJLFVFSQt@I-love.SAKURA.ne.jp>
References: <bdd17661-5f1f-833f-1e68-887b288616bb@schaufler-ca.com>
	<4856407a-3c94-362f-d548-5228c09c84be@schaufler-ca.com>
	<201703172152.GBD04133.QLOSVFJHOOMtFF@I-love.SAKURA.ne.jp>
	<fd0fe8c8-9c0d-ce5e-fa9e-e521d8bb0f93@schaufler-ca.com>
	<201703181653.IJE26029.OHMOOFJLFVFSQt@I-love.SAKURA.ne.jp>
Message-ID: <673eb042-0f74-0af9-73ca-b2c15a8a89b9@schaufler-ca.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On 3/18/2017 12:53 AM, Tetsuo Handa wrote:
> Casey Schaufler wrote:
>> On 3/17/2017 5:52 AM, Tetsuo Handa wrote:
>>> Casey Schaufler wrote:
>>>> Subject: [PATCH RFC 1/9] LSM: Add /sys/kernel/security/lsm
>>>>
>>>> This has been accepted into security next - provided for completeness
>>> Before going to "[PATCH RFC 5/9] LSM: General but not extreme module
>>> stacking", what do you think about below change?
>>>
>>> ----------------------------------------
>>>
>>> >From 8fe80e4b6a479a81d720571ad3b5979f6fd1e6ae Mon Sep 17 00:00:00 2001
>>> From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
>>> Date: Fri, 17 Mar 2017 21:34:51 +0900
>>> Subject: [PATCH] LSM: Pass module name via "union security_list_options".
>>>
>>> Commit d69dece5f5b6bc7a ("LSM: Add /sys/kernel/security/lsm") added
>>> "char *lsm" field to "struct security_hook_list". But it is currently
>>> never used after set at initialization time. While there is a plan that
>>> this field will be used by "LSM: General but not extreme module stacking"
>>> patch, there is no point with setting the same value to each element of
>>> "struct security_hook_list" array. We can keep "struct security_hook_list"
>>> 4 * sizeof(void *) bytes if we keep this field in "union
>>> security_list_options".
>>>
>>> The "char *" argument in security_add_hooks() was removed because we can
>>> fetch it from security_list_options"->module_name field. This implies
>>> that setting security_list_options"->module_name field is mandatory.
>> On further reflection, and spending a little time back
>> in the code, it turns out that this won't work at all.
>> The lsm field needs to be in the "struct security_hook_list"
>> so that hook processing that uses the module name such
>> as security_getprocattr has it. It wouldn't hurt to have
>> the module name in "union security_list_options", but
>> a list of module names doesn't help anything, either.
>>
> Oops. I didn't expect you to use a list of module names for
> getprocattr()/setprocattr(). I assumed you pass module name to
> individual module and let individual module return a value or -ENOENT.

Either way works, it's just a bit cleaner for the infrastructure
to call the one module that can provide the information than to
loop through calling everyone unnecessarily.

Yes, I've coded it both ways.

> But looking at PATCH 5/9, do we really want to use "context" format?
> TOMOYO uses $name=$value encoding which can include arbitrary characters
> and thus allows simple tokenizing using a whitespace like
>
>   lsm1=v1 lsm2=v2 lsm3=v3
>
> but you are trying to introduce
>
>   lsm1='v1'lsm2='v2'lsm3='v3'
>
> format at the cost of giving up ability to include arbitrary characters
> (e.g. '\n'), aren't you?

I am open (yet again, I've asked for input several times before)
to suggestions, but there has to be a way to represent the complete
"context" in a finite way. This is my best effort at doing so.

> If userspace has to concatenate strings like
>
>   lsm1='v1'lsm2='v2'lsm3='v3'
>
> and write to single file at one time like
>
>   echo lsm1='v1'lsm2='v2'lsm3='v3' > /proc/$pid/attr/context
>
> , userspace can simply do
>
>   echo $v1 > /proc/$pid/attr/$lsm1/$name
>   echo $v2 > /proc/$pid/attr/$lsm2/$name
>   echo $v3 > /proc/$pid/attr/$lsm3/$name

This isn't atomic, and while it is possible to
do it thus, there can be races in global policy.
Also, it would require user-space to know about
the available modules, and part of what
/proc/$pid/attr/context gets you is the ability
to fetch the process security data the same way
in all cases. Very useful for "id".

> which will not need to exclude characters like '\n'.

I can't see ps, ls or id being at all happy
with security attributes containing newlines,
formfeeds, bells or backspaces. There's a reason
Smack labels have a restricted character set.

> If there were hundreds of modules, the overhead might matter.
> But given that there will be only few modules which use these
> interfaces, I think userspace can tolerate such multiple writes.
>
Multiple writes aren't atomic.
I'm much more concerned with multiple reads.
lsm-1='data-1',...,lsm-n='data-n'
is as good a representation as I can come up with.
Please propose a better one. I don't think that 
anything requiring sophisticated parsing is viable.

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
