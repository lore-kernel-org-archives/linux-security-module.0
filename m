From: casey@schaufler-ca.com (Casey Schaufler)
Date: Fri, 31 Mar 2017 09:09:07 -0700
Subject: [PATCH] TOMOYO: Switch from per "struct cred" blob to per "struct
	task_struct" blob.
In-Reply-To: <201703310952.GED78634.OFQMFVtHSOJOLF@I-love.SAKURA.ne.jp>
References: <1490698960-29861-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
	<0dbdca69-ae69-a07e-957a-246d3e7532f2@schaufler-ca.com>
	<201703302009.HFI48472.MOFJOQStHFVOLF@I-love.SAKURA.ne.jp>
	<c0e1918a-a483-23b7-2bef-871082f80e10@schaufler-ca.com>
	<201703310952.GED78634.OFQMFVtHSOJOLF@I-love.SAKURA.ne.jp>
Message-ID: <2ad7f776-f593-8841-0009-c236980b4c8a@schaufler-ca.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On 3/30/2017 5:52 PM, Tetsuo Handa wrote:
> Casey Schaufler wrote:
>> On 3/30/2017 4:09 AM, Tetsuo Handa wrote:
>>> Even though TOMOYO uses per "struct task_struct" blob, TOMOYO can
>>> start running with any other LSM modules by applying below change.
>>> What are you worrying about?
>> Until such time as a blob sharing scheme, either the one
>> I've been working on, yours below or something else, is
>> adopted, and until another module starts using the task
>> blob, you could use TOMOYO with any other module. The
>> existing model for choosing a "major" module does not
>> allow for TOMOYO+AppArmor. Ignoring the blob management
>> issue, how would you suggest enabling TOMOYO+AppArmor? 
> Changing
>
> -#define SECURITY_NAME_MAX       10
> +#define SECURITY_NAME_MAX       64
>
>  int __init security_module_enable(const char *module)
>  {
> -	return !strcmp(module, chosen_lsm);
> +	return strstr(chosen_lsm, module) != NULL;
>  }

This will fail if a module name is a substring of
another. "joselinux", "kissysmacker", "parm", "yam"
and "botomoyodoho" would all be names that would
result in confusion. You'd have to do more serious
parsing.
 

>
> and passing
>
>   security=tomoyo,apparmor
>
> to the kernel boot command line option, with checking for currently conflicting
> choices like an example below.
>
> 	pr_info("Security Framework initialized\n");
> +	if (IS_ENABLED(CONFIG_SECURITY_SELINUX) && IS_ENABLED(CONFIG_SECURITY_SMACK) && security_module_enable("selinux") && security_module_enable("smack"))
> +		panic("Selected combination is not supported\n");

This is easy enough to handle in Kconfig.

>
>>> If we want per LSM module per "struct task_struct" blob before
>>> TOMOYO is converted to use per "struct task_struct" blob, I'm ready to
>>> propose that part (picked up from below change) first.
>> I suggest that the best thing to do regarding the task blob
>> is to adopt a general blob sharing scheme that is useful for
>> all of the blobs rather than inventing a special one for TOMOYO.
>>
> Since we are already receiving proposals of new modules which want to
> use the task blob, I think priority of sharing (isolating ?) the task
> blob (in other words, allow multiple modules to call task_alloc/task_free
> hooks) is higher than enabling SELinux+Smack.

I agree. Mr. Moore wants to see the complete "solution" before
he's willing to endorse intermediate steps, and he has a point.
There is good reason to hold off on introducing a mechanism
that isn't known to hold up long term.

We could introduce infrastructure blob management (as opposed
to the current every-module-for-itself scheme) independently
of dealing with the /proc/.../attr, secid and networking issues.
But if we're not sure the path gets us all the way it would be
foolish to start making changes of that magnitude.

I *think* I have acceptable answers to all those issues in
the works. Once there's conceptual sign-off on those I would
be very much in favor of a staged approach, with the blob
management being the first step.

> --
> To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
