From: penguin-kernel@I-love.SAKURA.ne.jp (Tetsuo Handa)
Date: Sun, 21 May 2017 14:59:25 +0900
Subject: [PATCH 0/8] CaitSith LSM module
In-Reply-To: <8c6da617-3325-d60d-805f-5e5c1fa322c6@canonical.com>
References: <201610252026.HCH52140.FOtVFOJLQMSOHF@I-love.SAKURA.ne.jp>
	<201611231531.DGH52135.QtFVOFJLOHFOSM@I-love.SAKURA.ne.jp>
	<2908442d-90f1-7fa2-24ff-0833f6bd2d95@canonical.com>
	<201705211359.BBE26079.LSJFOMHFOVQFOt@I-love.SAKURA.ne.jp>
	<8c6da617-3325-d60d-805f-5e5c1fa322c6@canonical.com>
Message-ID: <201705211459.EGB48959.OFVFOSHtFJMLQO@I-love.SAKURA.ne.jp>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

John Johansen wrote:
> On 05/20/2017 09:59 PM, Tetsuo Handa wrote:
> > John Johansen wrote:
> >> On 11/22/2016 10:31 PM, Tetsuo Handa wrote:
> >>> Tetsuo Handa wrote:
> >>>> John Johansen wrote:
> >>>>>> In order to minimize the burden of reviewing, this patchset implements
> >>>>>> only functionality of checking program execution requests (i.e. execve()
> >>>>>> system call) using pathnames. I'm planning to add other functionalities
> >>>>>> after this version got included into mainline. You can find how future
> >>>>>> versions of CaitSith will look like at http://caitsith.osdn.jp/ .
> >>>>>>
> >>>>> Thanks I've started working my way through this, but it is going to take
> >>>>> me a while.
> >>>>>
> >>>>
> >>>> Thank you for your time.
> >>>
> >>> May I hear the status? Is there something I can do other than waiting?
> >>>
> >> progressing very slowly, I have some time over the next few days as its a
> >> long weekend here in the US some hopefully I can finish this up
> >>
> > 
> > May I hear the status again?
> > 
> Yes, sorry. I just haven't had time too look at it recently. I am sorry that
> it has been so long. I am just going to have to book a day off and do it. I'll
> see if I can't get a day next week (getting late but I can try or the following)

No problem. ;-) I assume reviewing a new module takes at least one year.
Thank you for remembering.
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
