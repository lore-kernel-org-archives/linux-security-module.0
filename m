From: keescook@chromium.org (Kees Cook)
Date: Tue, 18 Apr 2017 15:54:41 -0700
Subject: [kernel-hardening] [PATCH net-next v6 06/11] seccomp,landlock:
	Handle Landlock events per process hierarchy
In-Reply-To: <b0662712-53f4-1293-aa61-f0455301d7cc@digikod.net>
References: <20170328234650.19695-1-mic@digikod.net>
	<20170328234650.19695-7-mic@digikod.net>
	<CAEiveUcp6xpUW764zupy8ekttnQGaonXFn-JEFg7nhXUKzenDg@mail.gmail.com>
	<b0662712-53f4-1293-aa61-f0455301d7cc@digikod.net>
Message-ID: <CAGXu5j+jEiRHmbr4_4NXf0X=THGbzj1TsbGDRdVk8UMQ0ipvQQ@mail.gmail.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Fri, Mar 31, 2017 at 2:15 PM, Micka?l Sala?n <mic@digikod.net> wrote:
>
>
> On 29/03/2017 12:35, Djalal Harouni wrote:
>> On Wed, Mar 29, 2017 at 1:46 AM, Micka?l Sala?n <mic@digikod.net> wrote:
>
>>> @@ -25,6 +30,9 @@ struct seccomp_filter;
>>>  struct seccomp {
>>>         int mode;
>>>         struct seccomp_filter *filter;
>>> +#if defined(CONFIG_SECCOMP_FILTER) && defined(CONFIG_SECURITY_LANDLOCK)
>>> +       struct landlock_events *landlock_events;
>>> +#endif /* CONFIG_SECCOMP_FILTER && CONFIG_SECURITY_LANDLOCK */
>>>  };
>>
>> Sorry if this was discussed before, but since this is mean to be a
>> stackable LSM, I'm wondering if later you could move the events from
>> seccomp, and go with a security_task_alloc() model [1] ?
>>
>> Thanks!
>>
>> [1] http://kernsec.org/pipermail/linux-security-module-archive/2017-March/000184.html
>>
>
> Landlock use the seccomp syscall to attach a rule to a process and using
> struct seccomp to store this rule make sense. There is currently no way
> to store multiple task->security, which is needed for a stackable LSM
> like Landlock, but we could move the events there if needed in the future.

It does stand out to me that the only thing landlock is using seccomp
for is its syscall... :P

-Kees

-- 
Kees Cook
Pixel Security
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
