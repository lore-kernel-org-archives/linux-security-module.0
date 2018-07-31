From: jroedel@suse.de (Joerg Roedel)
Date: Tue, 31 Jul 2018 09:27:25 +0200
Subject: [LKP] [lkp-robot] [confidence: ] 7757d607c6 [ 56.996267] BUG:
	Bad page map in process trinity-c2 pte:0d755065 pmd:0d55b067
In-Reply-To: <20180731020036.GB22500@yexl-desktop>
References: <20180721022325.GF12513@shao2-debian>
	<20180727132542.mt35m3knpwpsyb73@suse.de>
	<20180731020036.GB22500@yexl-desktop>
Message-ID: <20180731072725.ecbhfm6642xxao5z@suse.de>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Tue, Jul 31, 2018 at 10:00:36AM +0800, Ye Xiaolong wrote:
> On 07/27, Joerg Roedel wrote:
> >May I ask how this was bisected? I found it very hard to reproduce, it
> >triggered less then two times a day with the attached reproducer. Given
> >that the report came pretty fast after the patches landed in
> >tip/x86/pti, I guess it triggered a lot faster in your testing.
> >
> 
> There is higher reproduce rate (2/310) in 0day environment, and we got dozens
> of qemu running simultaneously for bisection thus can get bisect result promptly.

Ah okay, that makes sense. Thanks for your answer and thanks for the
report again.


Regards,

	Joerg

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
