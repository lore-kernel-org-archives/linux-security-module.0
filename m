From: john.johansen@canonical.com (John Johansen)
Date: Mon, 13 Mar 2017 10:50:57 -0700
Subject: [PATCH] apparmor: move task specific domain change info out of
	cred
In-Reply-To: <1489425378.4780.2.camel@tycho.nsa.gov>
References: <1489293309-41929-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
	<f502734d-a16c-5414-a6bd-ee9b8b40618f@canonical.com>
	<20170313164710.GA30654@mail.hallyn.com>
	<3b32053a-0dae-cc77-01bf-b70880c1cc85@canonical.com>
	<1489425378.4780.2.camel@tycho.nsa.gov>
Message-ID: <027fcbbe-708f-2bee-a117-05651cbd4125@canonical.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On 03/13/2017 10:16 AM, Stephen Smalley wrote:
> On Mon, 2017-03-13 at 10:05 -0700, John Johansen wrote:
>> On 03/13/2017 09:47 AM, Serge E. Hallyn wrote:
>>> Quoting John Johansen (john.johansen at canonical.com):
>>>> Now that security_task_alloc() hook and "struct task_struct"-
>>>>> security
>>>> field are revived, move task specific domain change information
>>>> for
>>>> change_onexec (equiv of setexeccon) and change_hat out of the
>>>> cred
>>>> into a context off of the task_struct.
>>>>
>>>> This cleans up apparmor's use of the cred structure so that it
>>>> only
>>>> carries the reference to current mediation.
>>>>
>>>> Signed-off-by: John Johansen <john.johansen@canonical.com>
>>>
>>> Thanks, John, that helps in compelling a review of the previous
>>> patch :)
>>>
>>> So the task_struct->security pointer is only to store requested
>>> transition profiles right?
>>>
>>
>> correct, well and support information for the transition like the
>> random
>> magic token for change_hat.
> 
> Is it really a net win for AA?  You save some space in the per-cred
> structure (but that was already shared by most tasks, particularly any
> that are not using change_onexec/change_hat), but won't you end up
> using more space overall since you will now be allocating space for
> (onexec, previous, token) for every task, even ones that don't use
> those operations?
> 
atm its more of a wash. Its a win for cred related operations but
allocating per task, instead of per cred does increase memory usage.
However this is just a first pass that is a fairly direct mapping of
onto the current code paths. There is no reason the task->security
struct couldn't be shared by tasks, or even more likely not allocated
at all except by those tasks using change_onexec/change_hat.

I just haven't had a chance to work on the improvements, long term it
will be a win for AA.


--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
