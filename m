From: sargun@sargun.me (Sargun Dhillon)
Date: Mon, 30 Apr 2018 14:29:02 -0700
Subject: [PATCH v7 0/6] Safe LSM (un)loading, and immutable hooks
In-Reply-To: <alpine.LRH.2.21.1805010712570.21544@namei.org>
References: <CAMp4zn85hvdT2b0qsKWqxyC-5m=Y414akM1wjVH5qrZpgLE-bw@mail.gmail.com>
	<CAMp4zn-Y333bSX2EX-5M+-Mu1m9EeeAP203v=HJOFLPVmoUpNA@mail.gmail.com>
	<201804272225.DAC82348.OFtSVOJOHLFMQF@I-love.SAKURA.ne.jp>
	<CAMp4zn-9UdDNzJJhz1=kGp1=4kLXk=v8TVwWhpyNQVyyo=Xr6w@mail.gmail.com>
	<a27ccccf-7436-5049-8554-79638d3bdbb2@schaufler-ca.com>
	<201804292049.CJG18734.FJMOOHVOFFQtSL@I-love.SAKURA.ne.jp>
	<0cf314e6-af7d-7e93-4249-944431202327@schaufler-ca.com>
	<CAMp4zn9Mfm6Spq1S+u-ny+Sf8Umn29+SWTWLbOrMm7_PPfXeTw@mail.gmail.com>
	<alpine.LRH.2.21.1805010712570.21544@namei.org>
Message-ID: <CAMp4zn-hUTArkb44eLPAac6M2CedAPVpf7qBC2csKqNsdg70YQ@mail.gmail.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Mon, Apr 30, 2018 at 2:16 PM, James Morris <jmorris@namei.org> wrote:
> On Mon, 30 Apr 2018, Sargun Dhillon wrote:
>
>> I guess I'm just a little bit frustrated, because, in my mind, some of
>> my patches provide immediate value, and are ready to be reviewed, and
>> or respun.
>
> I'm not seeing much value in this functionality, given that SELinux is the
> only unloadable LSM, and that is really just an historical workaround
> which may be normalized at some point.
>
> Patch 1 may be useful on its own.
Do you not think patch 2 is also useful? Is it worth me re-rolling 1-2
independently?

Do you think not think that minor loadable LSMs are valuable? -- And
if so, do you think it's okay with, or without guardrails?
>
> --
> James Morris
> <jmorris@namei.org>
>
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
