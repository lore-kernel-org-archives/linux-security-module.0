From: penguin-kernel@I-love.SAKURA.ne.jp (Tetsuo Handa)
Date: Thu, 1 Jun 2017 00:10:07 +0900
Subject: [PATCH] LSM: Convert security_hook_heads into explicit array of
	struct list_head
In-Reply-To: <20170531154317.4f487300@alans-desktop>
References: <201705302329.IEB05735.FLJOFHSQVtOOFM@I-love.SAKURA.ne.jp>
	<20170530162550.19ba1811@alans-desktop>
	<alpine.LRH.2.20.1705310858430.6920@namei.org>
	<201705311941.CGD64590.MOFSOLFJtQFOVH@I-love.SAKURA.ne.jp>
	<20170531154317.4f487300@alans-desktop>
Message-ID: <201706010010.EHB81211.LFMOFSQJtFVOOH@I-love.SAKURA.ne.jp>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Alan Cox wrote:
> > I saw several companies who ship their embedded devices with
> > single-function LSM modules (e.g. restrict only mount operation and
> > ptrace operation). What is unfortunate is that their LSM modules had
> > never been proposed for upstream, and thus bugs remained unnoticed.
>
> So which of them cannot be done with seccomp ? We have a small tight
> interface for simple things like restricting a few calls.

They restricted based on hard-coded rules. seccomp is too much for their cases.

> 
> > via lack of ability to use LKM-based LSM modules). My customers cannot afford
> > enabling SELinux, but my customers cannot rebuild their kernels because
> > rebuilding makes it even more difficult to get help from support centers.
>
> And "I've loaded this third party module" doesn't ?

Situation is far much better than "I've recompiled this vmlinux". ;-)
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
