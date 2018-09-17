From: john.johansen@canonical.com (John Johansen)
Date: Mon, 17 Sep 2018 16:25:08 -0700
Subject: [PATCH 16/18] LSM: Allow arbitrary LSM ordering
In-Reply-To: <a51a4d34-7077-bfbe-5979-00e79680f514@digikod.net>
References: <20180916003059.1046-1-keescook@chromium.org>
	<20180916003059.1046-17-keescook@chromium.org>
	<84e1a5a8-8997-829f-cf09-1d29895a3f99@schaufler-ca.com>
	<CAGXu5jK5CzXUii97q_yk3KzBTw0SOmoc=-zcm+3jAqEHe76AgQ@mail.gmail.com>
	<35b0af5b-e37e-e192-73b5-0d0b37d9e37f@schaufler-ca.com>
	<CAGXu5jJ71RLGh0nDgOaN3vCXFGE0poXFU2Gb9o+20aO+AEdOvw@mail.gmail.com>
	<8f0bd39b-29a6-325d-4558-d9f484249c22@schaufler-ca.com>
	<CAGXu5jLeTfwEXAZLz_H1PCx0ySWZcRhXQMfnE14TG8BvxY46JA@mail.gmail.com>
	<53377892-695f-6336-8574-54c7aa0a4201@schaufler-ca.com>
	<7ecfffc3-d2a4-3ff7-4bf5-db3029d73c59@canonical.com>
	<fbdc2a75-8364-c743-f9c3-9dcd2570c569@schaufler-ca.com>
	<e9292d89-12bd-2c4a-9ca2-5758de790f2f@canonical.com>
	<a51a4d34-7077-bfbe-5979-00e79680f514@digikod.net>
Message-ID: <8a11b293-6094-0b5e-5e75-3a9709a2bd00@canonical.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On 09/17/2018 04:10 PM, Micka?l Sala?n wrote:
> 

<< snip >>

>>>>> If "lsm.enable=apparmor lsm.disable=apparmor" is specified the last value
>>>>> specified is used giving "lsm.disable=apparmor".
>>>>>
>>>> makes sense
>>>
>>> The rules for modification are pretty obvious. The downside is, as
>>> you point out, that they don't address ordering. Maybe we address that
>>> directly:
>>>
>>> 	lsm.order=*,tomoyo
>>>
>>> 		TOMOYO should be last.
>>>
>>> 	lsm.order=apparmor,*
>>>
>>> 		AppArmor should be first.
>>>
>>>
>>> 	lsm.order=*,sara,selinux,*
>>>
>>> 		SELinux should come directly after SARA but we otherwise don't care.
>>>
>>> 	lsm.order=smack,*,landlock,*
>>>
>>> 		Smack should be first and LandLock should come sometime later.
>>>
>>> 	lsm.order=*,yama,*
>>>
>>> 		Is meaningless.
>>>
>>> Modules not listed may go anywhere there is a "*" in the order.
>>> An lsm.order= without a "*" is an error, and ignored.
>>> If a module is specified in lsm.order but not built in it is ignored.
>>> If a module is specified but disabled it is ignored.
>>> The capability module goes first regardless.
>>>
>>
>> I don't mind using lsm.order if we must but really do not like the '*'
>> idea. It makes this way more complicated than it needs to be
>>
>>
> 
> Landlock, because it target unprivileged users, should only be called
> after all other major (access-control) LSMs. The admin or distro must
> not be able to change that order in any way. This constraint doesn't
> apply to current LSMs, though.
> 

And yet another complication :)

I don't know that we can enforce a strict only after all other LSMs. Imagine
the hypothetical case of 2 LSMs targeting unprivileged users. Which one
should be called first?
