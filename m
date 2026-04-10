Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEEF81990C7
	for <linux-security-module@vger.kernel.org>; Fri, 10 Apr 2026 12:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775825001; cv=none; b=Gb+i7x4u/wEumdk/CnjgfIz8H8yCLySu+IBil3CMDRE1UwjfO2rTt8J1gsVhFOeDvFWFiv8/JwJnh2Wp4wA/YaTJNR8NOWgmv7SjbVPLkzfBRv2yjl8LGhTp3oZnqOch3uXCx2I35ZFdewGE/hpCY4dZqGBBPTDlb2g2SMlmy/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775825001; c=relaxed/simple;
	bh=Sc7/+ledvDd6/XfbwzrxfD6WLiQg32gmFdGOcx0PMx0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ftDLJ/eZE3AN0X1Mn8A0ZWuk2t7Ny78IkWOEFXlvdiIIP38xqTmDT0YMWKZ8aqbU7dUw98VkUf5qXVGAE9w17ZnsjlBoSbgHfBdVzM17fBCvo4Y8GJaEmos44tks7NrbgjGYUKuBdL/23sW/Xwr/iSxevDW9DEGc36XottKkxU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OfyAlhqI; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OfyAlhqI"
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-79a2ee65171so21492657b3.2
        for <linux-security-module@vger.kernel.org>; Fri, 10 Apr 2026 05:43:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775824999; x=1776429799; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=3wPTYprFWv5OAAQY713DVZBl5oogf+yV0PVKx1wdxoc=;
        b=OfyAlhqIfGIIvXcSWlNUkcQ2ak83d3+Ct0PhDTbKJFretZhIvPJ6PpJ30WDVN5BRRe
         ZAvmGau+bZ6ywAYYSWrRrrrQRYSyqMEGeuVv5U52yylovJXvLxXmQ0nAD37+jHF8+y2D
         OANoP9deVe1y2x0dGj/vUS5c5RSktWrVbXseHq9fS2DNtknICHmZ1NJSd/vQq6K9SgP4
         sut8UjxLr9i3gVKc2zTYItAnwy7gt4hY9Z/vm9dgnbSd9+Jy+Wu7E39KJRiFWAfueHcI
         Oy6nUvJa39k54pT07bLT65HB0VI3Hoy+AWITpPahGeKqID/sJCovklFF3Xaq6RuvjsKh
         LTHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775824999; x=1776429799;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3wPTYprFWv5OAAQY713DVZBl5oogf+yV0PVKx1wdxoc=;
        b=jxpBasScYTqIc6+en4QdWA6XrVhkDSQf3CmsqSyHrcv5U8DZRNAEmyPugOb8pt1PTr
         E/6GOZ9SZuoL6soOZ0xCQt37bVzAC5Wc8cxTB2UVBs+84g41qMKphDlpy8bJ888Zo3PJ
         xsm4UGkIVWv3J3VYekBwduTyHVzCsjmoaJlourl0i9pk2jKCZ744WFw+f4Mp8udj+Sm8
         K2xPsxCYmz7BL6wWaSH8kD/pMxjUETZ7oyDtaculSnRK/DePXkFUmuUyJRdiK0yGqI29
         D9N6QALgCIKmuhaW+GDc38oG1egbd9QaDM2g8bw9Zz+cn5euWbKQe6tD7teCP+6VWLl+
         VdZQ==
X-Forwarded-Encrypted: i=1; AJvYcCXNYL1nOAhmu7Iyv/LYpQ+S75vQ3/VuUMhq3J99WSamxP7X9tLaIQZcSTuJqiF0MLcSxCmtuBGQHppD+/O+5qQGcq14NRc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yylm8VQsjPpdzXzlDd6DeDnGOR0vWRM/tX+QZdfoOZjY6ZU8c4r
	H0d7lFcKjQmW45hYOiX3JEDMNz1UsJx+mBFJQSHiYcV8+YslCaXINhxC
X-Gm-Gg: AeBDietALFUcF0A+aSa59wP1b2GiFNYvftPGvbpGu270efbyDnxWSP5xONaubsJ8DYS
	5yqM3BQTXYSY6qfWTNW96RSutZ4pDk1idUtVvNES3nOGsEJMw5xTzIa4FKS9ZJqmJaq7UmqyEmH
	/rAn/UzAGBr2ufizo3FVJ19gv5hLPuIjQe/aX08vSMUmyRZIenAQ37/et39o/hjvt3tKNlRerzx
	tg52z6aXjfuz8K2iUmyGfdsOSGSEhGr06F21jiTluxjso9azPE1RXNAYMLPbK1/sfz4graa+HGy
	gUTLBklXesV6F4vTTEWzK/NKEEOW6OTPsEt+WO+3kgSIMwRZjS58XdGCE6kBDLDwzf5FrQm5+5W
	+XjYmUCuxrkHsQIRzVX4HWbEOCH7YYYqSJdJDXNI6NT24OFB9PEQjkekvIxhAqnUJijRFxYBTZo
	bLa7vdWKp0uPxNbJu/q6uCenfbNDB4eBUZfesGXjZORh3ufmLlH9Hqsz4ujHNZpcuY0dy3HfWUH
	cU=
X-Received: by 2002:a05:690c:110:b0:7a2:9a26:d3da with SMTP id 00721157ae682-7af72923e2cmr31495347b3.53.1775824998737;
        Fri, 10 Apr 2026 05:43:18 -0700 (PDT)
Received: from suesslenovo ([2600:1700:18fb:6011:19ff:af81:e78c:e10d])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7af400ec8dcsm12766097b3.46.2026.04.10.05.43.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Apr 2026 05:43:18 -0700 (PDT)
Date: Fri, 10 Apr 2026 08:43:16 -0400
From: Justin Suess <utilityemal77@gmail.com>
To: =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>
Cc: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org,
	brauner@kernel.org, daniel@iogearbox.net, eddyz87@gmail.com,
	fred@cloudflare.com, gnoack@google.com, jack@suse.cz,
	jmorris@namei.org, john.fastabend@gmail.com, kees@kernel.org,
	kpsingh@kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org,
	m@maowtm.org, martin.lau@linux.dev, paul@paul-moore.com
Subject: Re: [RFC PATCH 00/20] BPF interface for applying Landlock rulesets
Message-ID: <adjwZAevNaDguilw@suesslenovo>
References: <20260408.ong9Eshe0omu@digikod.net>
 <20260408171030.4083129-1-utilityemal77@gmail.com>
 <20260408.ainu5Chohnge@digikod.net>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260408.ainu5Chohnge@digikod.net>

On Wed, Apr 08, 2026 at 09:21:11PM +0200, Mickaël Salaün wrote:
> On Wed, Apr 08, 2026 at 01:10:28PM -0400, Justin Suess wrote:
> > 
> > Add a flag LANDLOCK_RESTRICT_SELF_NO_NEW_PRIVS, which executes
> > task_set_no_new_privs on the current credentials, but only if
> > the process lacks the CAP_SYS_ADMIN capability.
> > 
> > While this operation is redundant for code running from userspace
> > (indeed callers may achieve the same logic by calling
> > prctl w/ PR_SET_NO_NEW_PRIVS), this flag enables callers without access
> > to the syscall abi (defined in subsequent patches) to restrict processes
> > from gaining additional capabilities. This is important to ensure that
> > consumers can meet the task_no_new_privs || CAP_SYS_ADMIN invariant
> > enforced by Landlock without having syscall access.
> > 
> > This is done by hooking bprm_committing_creds along with a
> > landlock_cred_security flag to indicate that the next execution should
> > task_set_no_new_privs if the process doesn't possess CAP_SYS_ADMIN. This
> > is done to ensure that task_set_no_new_privs is being done past the
> > point of no return.
> > 
> > Cc: Mickaël Salaün <mic@digikod.net>
> > Signed-off-by: Justin Suess <utilityemal77@gmail.com>
> > ---
> > 
> > On Wed, Apr 08, 2026 at 02:00:00 -0000, Mickaël Salaün wrote:
> > > > Points of Feedback
> > > > ===
> > > > 
> > > > First, the new set_nnp_on_point_of_no_return field in struct linux_binprm.
> > > > This field was needed to request that task_set_no_new_privs be set during an
> > > > execution, but only after the execution has proceeded beyond the point of no
> > > > return. I couldn't find a way to express this semantic without adding a new
> > > > bitfield to struct linux_binprm and a conditional in fs/exec.c. Please see
> > > > patch 2.
> > 
> > > What about using security_bprm_committing_creds()?
> > 
> > Good idea. Definitely cleaner.
> > 
> > Something like this? Then dropping the "execve: Add set_nnp_on_point_of_no_return"
> > commit.
> > 
> > This adds a bitfield to the landlock_cred_security struct to indicate that the flag
> > should be set on the next exec(s).
> > 
> >  include/uapi/linux/landlock.h | 14 ++++++++++++++
> >  security/landlock/cred.c      | 13 +++++++++++++
> >  security/landlock/cred.h      |  7 +++++++
> >  security/landlock/limits.h    |  2 +-
> >  security/landlock/ruleset.c   | 15 ++++++++++++---
> >  security/landlock/syscalls.c  |  5 +++++
> >  6 files changed, 52 insertions(+), 4 deletions(-)
> > 
> > diff --git a/include/uapi/linux/landlock.h b/include/uapi/linux/landlock.h
> > index f88fa1f68b77..edd9d9a7f60e 100644
> > --- a/include/uapi/linux/landlock.h
> > +++ b/include/uapi/linux/landlock.h
> > @@ -129,12 +129,26 @@ struct landlock_ruleset_attr {
> >   *
> >   *     If the calling thread is running with no_new_privs, this operation
> >   *     enables no_new_privs on the sibling threads as well.
> > + *
> > + * %LANDLOCK_RESTRICT_SELF_NO_NEW_PRIVS
> > + *    Sets no_new_privs on the calling thread before applying the Landlock domain.
> > + *    This flag is useful for convenience as well as for applying a ruleset from
> > + *    an outside context (e.g BPF). This flag only has an effect on when both
> > + *    no_new_privs isn't already set and the caller doesn't possess CAP_SYS_ADMIN.
> > + *
> > + *    This flag has slightly different behavior when used from BPF. Instead of
> > + *    setting no_new_privs on the current task, it sets a flag on the bprm so that
> > + *    no_new_privs is set on the task at exec point-of-no-return. This guarantees
> > + *    that the current execution is unaffected, and may escalate as usual until the
> > + *    next exec, but the resulting task cannot gain more privileges through later
> > + *    exec transitions.
> >   */
> >  /* clang-format off */
> >  #define LANDLOCK_RESTRICT_SELF_LOG_SAME_EXEC_OFF		(1U << 0)
> >  #define LANDLOCK_RESTRICT_SELF_LOG_NEW_EXEC_ON			(1U << 1)
> >  #define LANDLOCK_RESTRICT_SELF_LOG_SUBDOMAINS_OFF		(1U << 2)
> >  #define LANDLOCK_RESTRICT_SELF_TSYNC				(1U << 3)
> > +#define LANDLOCK_RESTRICT_SELF_NO_NEW_PRIVS			(1U << 4)
> >  /* clang-format on */
> >  
> >  /**
> > diff --git a/security/landlock/cred.c b/security/landlock/cred.c
> > index 0cb3edde4d18..bcc9b716916f 100644
> > --- a/security/landlock/cred.c
> > +++ b/security/landlock/cred.c
> > @@ -43,6 +43,18 @@ static void hook_cred_free(struct cred *const cred)
> >  		landlock_put_ruleset_deferred(dom);
> >  }
> >  
> > +static void hook_bprm_committing_creds(const struct linux_binprm *bprm)
> > +{
> > +	struct landlock_cred_security *const llcred = landlock_cred(bprm->cred);
> > +
> > +	if (llcred->set_nnp_on_committing_creds &&
> > +	    !ns_capable_noaudit(current_user_ns(), CAP_SYS_ADMIN)) {
> 
> If asked by the caller, NNP must be set, whatever the capabilities of
> the task.
>
Gotcha. I suppose checking the capability is possible from BPF anyway
(at least from bprm_creds_from_file) so that makes sense.
> > +		task_set_no_new_privs(current);
> > +		/* Don't need to set it again for subsequent execution. */
> > +		llcred->set_nnp_on_committing_creds = false;
> > +	}
> 
> Thinking more about it, it would make more sense to add another flag to
> enforce restriction on the next exec.  This new cred bit would then be
> generic and enforce both NNP (if set) and the domain once we know the
Problem is enforcing NNP after the escalation (and past the point of no
return) is NOT safe from userspace side, (at least not without CAP_SYS_ADMIN
already)

Imagine this (contrived) scenario where Landlock enforces NNP after the
point of no return:

1. Sudo is configured like this: (some system file is critical to
enforcing policy)
   /etc/sudoers.d/policy.blah.conf
   /etc/sudoers.d/policy.keep_bob_out.conf
   
2. Bob creates a program that enforces a landlock ruleset forbidding
access to /etc/sudoers.d/policy.keep_bob_out.conf but allowing access to
other configs. Then it launches sudo /bin/sh

3. Bob can now escalate because the policy file keeping him out could
not be read. NNP is only enforced after exec, so NNP only takes
place after sudo escalates already.

This is just an example, but there are other cases I'm probably not
thinking of where it's dangerous to bypass the NNP check and enforce it
on the next exec.

To be safe, NNP must be enforced BEFORE the escalation in the
unprivileged side, but problem is the escalation happens just
before the point of no return, so exec may still fail!

So the conditions

1. NNP must happen after exec cannot fail, to not leave 
side effects.
2. NNP must happen before escalation, to avoid confused deputy attacks.

Are currently unsatisfiable.
> execution is ok.  That should also bring the required plumbing to
> create the domain at syscall (or kfunc) time and handle memory
> allocation issue there, but only enforce it at exec time with
> security_bprm_committing_creds() (without any possible error).
> 
I like that flow.

I guess this poses the question about what happens if a ruleset is asked
for "on next exec" from userspace and then
bpf_landlock_restrict_binprm() is called during the same execution?

Which would get priority? Would they
be merged? (etc). What happens if one requests NNP and the other
doesn't?

This needs some thought.

> > +}
> > +
> >  #ifdef CONFIG_AUDIT
> >  
> >  static int hook_bprm_creds_for_exec(struct linux_binprm *const bprm)
> > @@ -55,6 +67,7 @@ static int hook_bprm_creds_for_exec(struct linux_binprm *const bprm)
> >  #endif /* CONFIG_AUDIT */
> >  
> >  static struct security_hook_list landlock_hooks[] __ro_after_init = {
> > +	LSM_HOOK_INIT(bprm_committing_creds, hook_bprm_committing_creds),
> >  	LSM_HOOK_INIT(cred_prepare, hook_cred_prepare),
> >  	LSM_HOOK_INIT(cred_transfer, hook_cred_transfer),
> >  	LSM_HOOK_INIT(cred_free, hook_cred_free),
> > diff --git a/security/landlock/cred.h b/security/landlock/cred.h
> > index c10a06727eb1..7ec6dd12ebc3 100644
> > --- a/security/landlock/cred.h
> > +++ b/security/landlock/cred.h
> > @@ -49,6 +49,13 @@ struct landlock_cred_security {
> >  	 * not require a current domain.
> >  	 */
> >  	u8 log_subdomains_off : 1;
> > +	/**
> > +	 * @set_nnp_on_committing_creds: Set if the domain should set NO_NEW_PRIVS on the
> > +	 * execution past the point of no return in security_bprm_committing_creds().
> > +	 * This is not a hierarchy configuration because the nnp state is inherited by
> > +	 * exec and doesn't need further configuration.
> > +	 */
> > +	u8 set_nnp_on_committing_creds : 1;
> >  #endif /* CONFIG_AUDIT */
> >  } __packed;
> >  
> > diff --git a/security/landlock/limits.h b/security/landlock/limits.h
> > index eb584f47288d..d298086a4180 100644
> > --- a/security/landlock/limits.h
> > +++ b/security/landlock/limits.h
> > @@ -31,7 +31,7 @@
> >  #define LANDLOCK_MASK_SCOPE		((LANDLOCK_LAST_SCOPE << 1) - 1)
> >  #define LANDLOCK_NUM_SCOPE		__const_hweight64(LANDLOCK_MASK_SCOPE)
> >  
> > -#define LANDLOCK_LAST_RESTRICT_SELF	LANDLOCK_RESTRICT_SELF_TSYNC
> > +#define LANDLOCK_LAST_RESTRICT_SELF	LANDLOCK_RESTRICT_SELF_NO_NEW_PRIVS
> >  #define LANDLOCK_MASK_RESTRICT_SELF	((LANDLOCK_LAST_RESTRICT_SELF << 1) - 1)
> >  
> >  /* clang-format on */
> > diff --git a/security/landlock/ruleset.c b/security/landlock/ruleset.c
> > index 1d6fa74f2a52..ad0bd5994ec5 100644
> > --- a/security/landlock/ruleset.c
> > +++ b/security/landlock/ruleset.c
> > @@ -121,11 +121,13 @@ int landlock_restrict_cred_precheck(const __u32 flags,
> >  
> >  	/*
> >  	 * Similar checks as for seccomp(2), except that an -EPERM may be
> > -	 * returned.
> > +	 * returned, or no_new_privs may be set by the caller via
> > +	 * LANDLOCK_RESTRICT_SELF_NO_NEW_PRIVS.
> >  	 */
> >  	if (!task_no_new_privs(current) &&
> >  	    !ns_capable_noaudit(current_user_ns(), CAP_SYS_ADMIN)) {
> > -		return -EPERM;
> > +		if (!(flags & LANDLOCK_RESTRICT_SELF_NO_NEW_PRIVS))
> > +			return -EPERM;
> >  	}
> >  
> >  	if (flags & ~LANDLOCK_MASK_RESTRICT_SELF)
> > @@ -140,7 +142,7 @@ int landlock_restrict_cred(struct cred *const cred,
> >  {
> >  	struct landlock_cred_security *new_llcred;
> >  	bool __maybe_unused log_same_exec, log_new_exec, log_subdomains,
> > -		prev_log_subdomains;
> > +		prev_log_subdomains, set_nnp_on_committing_creds;
> >  
> >  	/*
> >  	 * It is allowed to set LANDLOCK_RESTRICT_SELF_LOG_SUBDOMAINS_OFF without
> > @@ -157,6 +159,12 @@ int landlock_restrict_cred(struct cred *const cred,
> >  	log_new_exec = !!(flags & LANDLOCK_RESTRICT_SELF_LOG_NEW_EXEC_ON);
> >  	/* Translates "off" flag to boolean. */
> >  	log_subdomains = !(flags & LANDLOCK_RESTRICT_SELF_LOG_SUBDOMAINS_OFF);
> > +	/*
> > +	 * Translates "on" flag to boolean. This flag is not inherited by exec,
> > +	 * but the resulting nnp state is.
> > +	 */
> > +	set_nnp_on_committing_creds =
> > +		!!(flags & LANDLOCK_RESTRICT_SELF_NO_NEW_PRIVS);
> >  
> >  	new_llcred = landlock_cred(cred);
> >  
> > @@ -165,6 +173,7 @@ int landlock_restrict_cred(struct cred *const cred,
> >  	new_llcred->log_subdomains_off = !prev_log_subdomains ||
> >  					 !log_subdomains;
> >  #endif /* CONFIG_AUDIT */
> > +	new_llcred->set_nnp_on_committing_creds = set_nnp_on_committing_creds;
> >  
> >  	/*
> >  	 * The only case when a ruleset may not be set is if
> > diff --git a/security/landlock/syscalls.c b/security/landlock/syscalls.c
> > index c6c7be7698a2..f3520c764360 100644
> > --- a/security/landlock/syscalls.c
> > +++ b/security/landlock/syscalls.c
> > @@ -397,6 +397,7 @@ SYSCALL_DEFINE4(landlock_add_rule, const int, ruleset_fd,
> >   *         - %LANDLOCK_RESTRICT_SELF_LOG_NEW_EXEC_ON
> >   *         - %LANDLOCK_RESTRICT_SELF_LOG_SUBDOMAINS_OFF
> >   *         - %LANDLOCK_RESTRICT_SELF_TSYNC
> > + *         - %LANDLOCK_RESTRICT_SELF_NO_NEW_PRIVS
> >   *
> >   * This system call enforces a Landlock ruleset on the current thread.
> >   * Enforcing a ruleset requires that the task has %CAP_SYS_ADMIN in its
> > @@ -450,6 +451,10 @@ SYSCALL_DEFINE2(landlock_restrict_self, const int, ruleset_fd, const __u32,
> >  	if (!new_cred)
> >  		return -ENOMEM;
> >  
> > +	if (flags & LANDLOCK_RESTRICT_SELF_NO_NEW_PRIVS &&
> > +	    !ns_capable_noaudit(current_user_ns(), CAP_SYS_ADMIN))
> > +		task_set_no_new_privs(current);
> > +
> >  	err = landlock_restrict_cred(new_cred, ruleset, flags);
> >  	if (err) {
> >  		abort_creds(new_cred);
> > -- 
> > 2.53.0
> > 
> > 
