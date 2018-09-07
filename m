From: l.pawelczyk@samsung.com (Lukasz Pawelczyk)
Date: Fri, 07 Sep 2018 11:47:39 +0200
Subject: Fwd: Smack: wrong-looking capable() check in
	smk_ptrace_rule_check()
In-Reply-To: <2fafaca2-73c4-d344-98be-089e17e95055@schaufler-ca.com>
References: <CAG48ez0nCC0_on95q7x_8cwSyJ8ATReA0ysDnEr=CW2tkqE=7w@mail.gmail.com>
	<CGME20180906185359epcas4p249c16d651266a1cb8ee8273a6daff3a5@epcas4p2.samsung.com>
	<2fafaca2-73c4-d344-98be-089e17e95055@schaufler-ca.com>
Message-ID: <20180907094740eucas1p10389694601d4d8f62bee71bb489922b2~SFSKD3ZrN0052200522eucas1p19@eucas1p1.samsung.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Hi,

On Thu, 2018-09-06 at 11:53 -0700, Casey Schaufler wrote:
> Lukasz, does this analysis seem correct to you? This is code you
> wrote in 2014.

It seems correct.
Moreover I've sent a patch that fixes this bug long time ago with the
namespace series.

https://lists.linux-foundation.org/pipermail/containers/2015-October/036318.html

Not sure this is the latest version. The latest I ever wrote can be
found here:
https://github.com/Havner/smack-namespace/commit/52d6e4be2db51e9aca53e0e112a7ff9625000994

Without namespaces, parts of this patch are probably irrelevant, but it
does fix this bug and one or two similar elsewhere.

Best regards,
Lukasz



> 
> -------- Forwarded Message --------
> Subject:	Smack: wrong-looking capable() check in
> smk_ptrace_rule_check()
> Date:	Thu, 6 Sep 2018 20:22:35 +0200
> From:	Jann Horn <jannh@google.com>
> To:	Casey Schaufler <casey@schaufler-ca.com>
> CC:	linux-security-module <linux-security-module@vger.kernel.org>,
> kernel list <linux-kernel@vger.kernel.org>
> 
> Hi!
> 
> I noticed the following check in smk_ptrace_rule_check():
> 
>                 if (tracer_known->smk_known == tracee_known-
> >smk_known)
>                         rc = 0;
>                 else if (smack_ptrace_rule == SMACK_PTRACE_DRACONIAN)
>                         rc = -EACCES;
>                 else if (capable(CAP_SYS_PTRACE))
>                         rc = 0;
>                 else
>                         rc = -EACCES;
> 
> Note that smk_ptrace_rule_check() can be called from not just
> smack_ptrace_access_check() and smack_ptrace_traceme(), but also
> smack_bprm_set_creds(). AFAICS this means that if a task executes
> with
> a smack privilege transition and smack_ptrace_rule is
> SMACK_PTRACE_EXACT, whether the execution is permitted depends on
> whether _the debugged task_ has CAP_SYS_PTRACE (and not on whether
> the
> debugger has that capability).
> This seems like it's probably unintentional?
> 
> 


-- 
Lukasz Pawelczyk
Samsung R&D Institute Poland
Samsung Electronics
