From: john.johansen@canonical.com (John Johansen)
Date: Wed, 5 Sep 2018 09:22:28 -0700
Subject: [PATCH 0/8] CaitSith LSM module
In-Reply-To: <b72491b3-834e-e073-0e40-a61d134725db@I-love.SAKURA.ne.jp>
References: <201611231531.DGH52135.QtFVOFJLOHFOSM@I-love.SAKURA.ne.jp>
	<2908442d-90f1-7fa2-24ff-0833f6bd2d95@canonical.com>
	<201705211359.BBE26079.LSJFOMHFOVQFOt@I-love.SAKURA.ne.jp>
	<8c6da617-3325-d60d-805f-5e5c1fa322c6@canonical.com>
	<201705211459.EGB48959.OFVFOSHtFJMLQO@I-love.SAKURA.ne.jp>
	<201710211959.CEC65165.SQJOLOFVOtFFHM@I-love.SAKURA.ne.jp>
	<7cab86a5-e115-0905-4d72-8cae7f6540b9@schaufler-ca.com>
	<b72491b3-834e-e073-0e40-a61d134725db@I-love.SAKURA.ne.jp>
Message-ID: <bf4ead8e-cf63-68f2-2315-daa68a2e6fd7@canonical.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On 09/01/2018 06:04 AM, Tetsuo Handa wrote:
> On 2017/10/22 2:17, Casey Schaufler wrote:
>>> As one year elapsed since I proposed CaitSith for upstream, I'd like to
>>> hear the status again. I looked at
>>> http://schd.ws/hosted_files/lss2017/8b/201709-LinuxSecuritySummit-Stacking.pdf .
>>> How is ETA for Security Module Stacking? Is it a half year or so?
>>
>> Assuming that I can keep working on stacking at my current level,
>> and that we can work out a couple issues with audit and networking
>> there is a possibility we're looking at mid 2018 for stacking. The
>> increased interest in security module namespaces for containers is
>> helping make stacking seem important to more people.
>>
>>> If it is likely take longer, should I resume proposing CaitSith for now
>>> as one of "Minor modules" except security_module_enable() check added
>>> until Security Module Stacking work completes? Or should I wait for
>>> completion of stacking work? I want to know it, for recent proposals are
>>> rather staying silent.
>>
>> I wouldn't wait if it was my project, but I have been known
>> to be more aggressive than is good for me from time to time.
>>
> 
> It seems that stacking needs some more time. Manual with updated patch for
> current source code is available at https://caitsith.osdn.jp/index2.html .
> John, if you can resume reviewing, I'd like to propose CaitSith as one of
> "Minor modules" except security_module_enable() check.
> 
Hey Tetsuo,

yes finishing up the Caitsith review is on my short list
