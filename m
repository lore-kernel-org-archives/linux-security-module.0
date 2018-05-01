From: jmorris@namei.org (James Morris)
Date: Wed, 2 May 2018 06:42:05 +1000 (AEST)
Subject: [PATCH v7 0/6] Safe LSM (un)loading, and immutable hooks
In-Reply-To: <f4f44e71-8df2-e5e6-d213-cf97eda6cb4a@digikod.net>
References: <CAMp4zn85hvdT2b0qsKWqxyC-5m=Y414akM1wjVH5qrZpgLE-bw@mail.gmail.com>
	<CAMp4zn-Y333bSX2EX-5M+-Mu1m9EeeAP203v=HJOFLPVmoUpNA@mail.gmail.com>
	<201804272225.DAC82348.OFtSVOJOHLFMQF@I-love.SAKURA.ne.jp>
	<CAMp4zn-9UdDNzJJhz1=kGp1=4kLXk=v8TVwWhpyNQVyyo=Xr6w@mail.gmail.com>
	<a27ccccf-7436-5049-8554-79638d3bdbb2@schaufler-ca.com>
	<201804292049.CJG18734.FJMOOHVOFFQtSL@I-love.SAKURA.ne.jp>
	<0cf314e6-af7d-7e93-4249-944431202327@schaufler-ca.com>
	<CAMp4zn9Mfm6Spq1S+u-ny+Sf8Umn29+SWTWLbOrMm7_PPfXeTw@mail.gmail.com>
	<3638568b-bb10-b0f7-d54f-6f2055db07aa@schaufler-ca.com>
	<CAMp4zn-qREqj0ewUs7dupLT0C_v6Ctz6Sre9QgTJHceGu7vZpw@mail.gmail.com>
	<f4f44e71-8df2-e5e6-d213-cf97eda6cb4a@digikod.net>
Message-ID: <alpine.LRH.2.21.1805020635001.15926@namei.org>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Tue, 1 May 2018, Micka?l Sala?n wrote:

> > I've been a long-time proponent of programmable LSMs (before it was
> > cool): https://lkml.org/lkml/2016/8/4/58
> 
> Happy to know that Landlock started before programmable access-control
> was cool, too. :)
> https://lkml.kernel.org/r/1458784008-16277-1-git-send-email-mic at digikod.net
> 

Not to brag or anything, but this was c.2000 (AD)  
https://linux.die.net/man/3/libipq ;-)


Landlock is by far the better approach to this than C, and may generally 
solve the use-case of (un)loadable, simple, ad-hoc policies.

-- 
James Morris
<jmorris@namei.org>
