From: jmorris@namei.org (James Morris)
Date: Wed, 2 May 2018 05:02:11 +1000 (AEST)
Subject: [PATCH v7 0/6] Safe LSM (un)loading, and immutable hooks
In-Reply-To: <CAMp4zn9Mfm6Spq1S+u-ny+Sf8Umn29+SWTWLbOrMm7_PPfXeTw@mail.gmail.com>
References: <CAMp4zn85hvdT2b0qsKWqxyC-5m=Y414akM1wjVH5qrZpgLE-bw@mail.gmail.com>
	<CAMp4zn-Y333bSX2EX-5M+-Mu1m9EeeAP203v=HJOFLPVmoUpNA@mail.gmail.com>
	<201804272225.DAC82348.OFtSVOJOHLFMQF@I-love.SAKURA.ne.jp>
	<CAMp4zn-9UdDNzJJhz1=kGp1=4kLXk=v8TVwWhpyNQVyyo=Xr6w@mail.gmail.com>
	<a27ccccf-7436-5049-8554-79638d3bdbb2@schaufler-ca.com>
	<201804292049.CJG18734.FJMOOHVOFFQtSL@I-love.SAKURA.ne.jp>
	<0cf314e6-af7d-7e93-4249-944431202327@schaufler-ca.com>
	<CAMp4zn9Mfm6Spq1S+u-ny+Sf8Umn29+SWTWLbOrMm7_PPfXeTw@mail.gmail.com>
Message-ID: <alpine.LRH.2.21.1805020502050.11549@namei.org>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Mon, 30 Apr 2018, Sargun Dhillon wrote:

> > It varies. Container people are a diverse lot.
> >
> >>     Use different LSM module for different container?
> >
> One dumb use case I have is the ability to limit interactions with
> PTYs for containerized applications. Another aspect of this is being
> able to write policies in C, and actually being able to control the
> nitty gritty of what's going on, versus actively fighting with the
> LSM(s).

Writing policies in C sounds like a breach of the principle of separating 
mechanism and policy.  This has been an important aspect of the LSM API 
and also of the major LSMs.  Hard-coded security policy is likely to be 
brittle, inflexible, and difficult to manage.  It's also blurring the 
boundary of LSM with the rest of the kernel, and making it even more 
difficult for core kernel developers to know what might break in LSM land 
when they make changes elsewhere.

Can you provide an example of what you want to do?


-- 
James Morris
<jmorris@namei.org>

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
