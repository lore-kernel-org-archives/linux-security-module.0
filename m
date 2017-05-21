From: penguin-kernel@I-love.SAKURA.ne.jp (Tetsuo Handa)
Date: Sun, 21 May 2017 13:59:26 +0900
Subject: [PATCH 0/8] CaitSith LSM module
In-Reply-To: <2908442d-90f1-7fa2-24ff-0833f6bd2d95@canonical.com>
References: <1477054150-4772-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
	<3232ef1d-b378-a8a2-f113-03b2db4cc332@canonical.com>
	<201610252026.HCH52140.FOtVFOJLQMSOHF@I-love.SAKURA.ne.jp>
	<201611231531.DGH52135.QtFVOFJLOHFOSM@I-love.SAKURA.ne.jp>
	<2908442d-90f1-7fa2-24ff-0833f6bd2d95@canonical.com>
Message-ID: <201705211359.BBE26079.LSJFOMHFOVQFOt@I-love.SAKURA.ne.jp>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

John Johansen wrote:
> On 11/22/2016 10:31 PM, Tetsuo Handa wrote:
> > Tetsuo Handa wrote:
> >> John Johansen wrote:
> >>>> In order to minimize the burden of reviewing, this patchset implements
> >>>> only functionality of checking program execution requests (i.e. execve()
> >>>> system call) using pathnames. I'm planning to add other functionalities
> >>>> after this version got included into mainline. You can find how future
> >>>> versions of CaitSith will look like at http://caitsith.osdn.jp/ .
> >>>>
> >>> Thanks I've started working my way through this, but it is going to take
> >>> me a while.
> >>>
> >>
> >> Thank you for your time.
> > 
> > May I hear the status? Is there something I can do other than waiting?
> > 
> progressing very slowly, I have some time over the next few days as its a
> long weekend here in the US some hopefully I can finish this up
> 

May I hear the status again?



On 5th March 2017, a CTF game was held in an event titled
"CyberColosseo x SecCon" ( http://2016.seccon.jp/news/#137 ). I gave a
simple troubleshooting-like system-analyzing quiz using SSH shell session
where operations are restricted by CaitSith.

Since the VM will be useful as an example of how to configure
CaitSith's policy configuration, I made a downloadable version.

  http://osdn.jp/frs/redir.php?m=jaist&f=/caitsith/67303/SecCon20170305-CaitSith.zip
  MD5: 99bad6936d8cdeb37d0d6af99265a2ac

This VM is configured for VMware Player 12 / 4 CPUs / 2048MB RAM.
An IPv4 address will be assigned upon boot using DHCP service on the host network.
SSH username and password are both "caitsith".
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
