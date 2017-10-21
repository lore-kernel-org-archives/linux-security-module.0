From: casey@schaufler-ca.com (Casey Schaufler)
Date: Sat, 21 Oct 2017 10:17:55 -0700
Subject: [PATCH 0/8] CaitSith LSM module
In-Reply-To: <201710211959.CEC65165.SQJOLOFVOtFFHM@I-love.SAKURA.ne.jp>
References: <201611231531.DGH52135.QtFVOFJLOHFOSM@I-love.SAKURA.ne.jp>
	<2908442d-90f1-7fa2-24ff-0833f6bd2d95@canonical.com>
	<201705211359.BBE26079.LSJFOMHFOVQFOt@I-love.SAKURA.ne.jp>
	<8c6da617-3325-d60d-805f-5e5c1fa322c6@canonical.com>
	<201705211459.EGB48959.OFVFOSHtFJMLQO@I-love.SAKURA.ne.jp>
	<201710211959.CEC65165.SQJOLOFVOtFFHM@I-love.SAKURA.ne.jp>
Message-ID: <7cab86a5-e115-0905-4d72-8cae7f6540b9@schaufler-ca.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On 10/21/2017 3:59 AM, Tetsuo Handa wrote:
> Tetsuo Handa wrote:
>> John Johansen wrote:
>>> On 05/20/2017 09:59 PM, Tetsuo Handa wrote:
>>>> John Johansen wrote:
>>>>> On 11/22/2016 10:31 PM, Tetsuo Handa wrote:
>>>>>> Tetsuo Handa wrote:
>>>>>>> John Johansen wrote:
>>>>>>>>> In order to minimize the burden of reviewing, this patchset implements
>>>>>>>>> only functionality of checking program execution requests (i.e. execve()
>>>>>>>>> system call) using pathnames. I'm planning to add other functionalities
>>>>>>>>> after this version got included into mainline. You can find how future
>>>>>>>>> versions of CaitSith will look like at http://caitsith.osdn.jp/ .
>>>>>>>>>
>>>>>>>> Thanks I've started working my way through this, but it is going to take
>>>>>>>> me a while.
>>>>>>>>
>>>>>>> Thank you for your time.
>>>>>> May I hear the status? Is there something I can do other than waiting?
>>>>>>
>>>>> progressing very slowly, I have some time over the next few days as its a
>>>>> long weekend here in the US some hopefully I can finish this up
>>>>>
>>>> May I hear the status again?
>>>>
>>> Yes, sorry. I just haven't had time too look at it recently. I am sorry that
>>> it has been so long. I am just going to have to book a day off and do it. I'll
>>> see if I can't get a day next week (getting late but I can try or the following)
>> No problem. ;-) I assume reviewing a new module takes at least one year.
>> Thank you for remembering.
>>
> I'm still fighting with OOM killer related problems at MM subsystem. ;-)
>
> As one year elapsed since I proposed CaitSith for upstream, I'd like to
> hear the status again. I looked at
> http://schd.ws/hosted_files/lss2017/8b/201709-LinuxSecuritySummit-Stacking.pdf .
> How is ETA for Security Module Stacking? Is it a half year or so?

Assuming that I can keep working on stacking at my current level,
and that we can work out a couple issues with audit and networking
there is a possibility we're looking at mid 2018 for stacking. The
increased interest in security module namespaces for containers is
helping make stacking seem important to more people.

> If it is likely take longer, should I resume proposing CaitSith for now
> as one of "Minor modules" except security_module_enable() check added
> until Security Module Stacking work completes? Or should I wait for
> completion of stacking work? I want to know it, for recent proposals are
> rather staying silent.

I wouldn't wait if it was my project, but I have been known
to be more aggressive than is good for me from time to time.

> Regards.
>

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
