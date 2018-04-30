From: jmorris@namei.org (James Morris)
Date: Tue, 1 May 2018 05:15:32 +1000 (AEST)
Subject: Security tree merge to v4.17-rc2
In-Reply-To: <aec6cdfe-5db7-f3cc-9a2a-157d90b1a45f@schaufler-ca.com>
References: <alpine.LRH.2.21.1804240425200.14030@namei.org>
	<4adbd739-06b3-f42b-f2ef-fb06ea655919@schaufler-ca.com>
	<201804272216.JHE30765.QSOJtFHLOOFFVM@I-love.SAKURA.ne.jp>
	<aec6cdfe-5db7-f3cc-9a2a-157d90b1a45f@schaufler-ca.com>
Message-ID: <alpine.LRH.2.21.1805010515130.18517@namei.org>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Fri, 27 Apr 2018, Casey Schaufler wrote:

> On 4/27/2018 6:16 AM, Tetsuo Handa wrote:
> > Casey Schaufler wrote:
> >> On 4/23/2018 11:26 AM, James Morris wrote:
> >>> FYI, I've merged the next-general and next-testing branches of the 
> >>> security subsystem tree to v4.17-rc2.
> >> Thanks! The fun begins!
> >>
> >>> git://git.kernel.org/pub/scm/linux/kernel/git/jmorris/linux-security.git
> > FYI, 4.17-rc2 contains a lockup bug due to GFP_KERNEL allocation from IRQ context.
> 
> crng_reseed counts as an old friend at this point.
> 
> > This bug was fixed in linux.git by now. But there is still another lockup bug
> > which will be fixed by 4fb48871409e2fcd in vfs.git#for-next.
> >
> > You might want to update again after 4.17-rc3 is out.
> 
> Nothing has shown up that's causing problems for me. I'd
> rather stay where I am than start over.

You don't need to start over, git will handle a merge easily.


-- 
James Morris
<jmorris@namei.org>

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
