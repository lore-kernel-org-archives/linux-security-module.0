Received: from mail-yx2-f12.google.com (mail-yx2-f12.google.com [74.125.224.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7A3C377A8F
	for <linux-security-module@vger.kernel.org>; Sat, 12 Sep 2026 05:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789191599; cv=none; b=T6gIWyF2igOuG6j88VsQuXx8yPy7X45penqilMx8PbSe1myC/xd842ZdMhT4ABkCVMTMvbM5QK2tvORgM3+MUm68EqxAZc4nmZ0QsCgYIP+ODtMl1aJ9c+hDn35MsjhjmzfxIvYHDsniRHSLowjVNU/8sDqItAo0SZyLpXLqGSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789191599; c=relaxed/simple;
	bh=EkFebyEhROfUpGMY14FIxRPanKfoSxiWxg0RxsaITyw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tDXr2ZyK4Tzdj4Ng89hQPFm/CIs/7lVCbgHWWfkx0aY6Dq1Z5RmPjd7mJ/OF5XUJB/kGcLrcEo3tXBPKJTz4Bk4vj+AW1kTqwMmQLkXTATKR6Bwm0+tM0WfI0FQvEdz0C5uIM5HS07W+OY1m2pz+8Hs1GMPt7pgJRWqlbGkhY7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YCVzpFMf; arc=none smtp.client-ip=74.125.224.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YCVzpFMf"
Received: by mail-yx2-f12.google.com with SMTP id 956f58d0204a3-66f943b286fso206939d50.2
        for <linux-security-module@vger.kernel.org>; Fri, 11 Sep 2026 22:39:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789191596; x=1789796396; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=CYxmSci5RsA6cvKpTRXhPLC+rNBAf6+Oj4ac05xenYM=;
        b=YCVzpFMfN71QA0n9Z4B5YekyPAAYtNWA9WYZ3IT3SPiSgE1js6BeRuHSmopaIMMmRP
         GwZpf98kq1bHvt9/XlIRjcd/BlpUbjZux6XUbrVlylgeV3TtJ9kz1hKJGhDa7bB6C26x
         9j4NcQrpdq2nx+VVvgfzr9odi9i2JT6Eyc8t7fbMQzqXmAKjnNF/URUr84zbqUqR2XOc
         mUks2JWU40G5TC1uI1Tglz5ALxZ8L09+VkNTEBN/3Pi93n7fVskgdUpfQDMlWT2/n2CK
         6kadvaBuMaA8nbSSUES8Pa/UbNKoX8RKgvkObSNthYl8RTlZBCC5hCGAjEXn52QdYn23
         pZkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789191596; x=1789796396;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CYxmSci5RsA6cvKpTRXhPLC+rNBAf6+Oj4ac05xenYM=;
        b=T3ADs1DB/uvKhPi2SzLRf1Eq1EtWpOUeBP9GmnaClOYg4MRWMuvk/PNDaSV3OwjCJs
         Cv/hAHgTSGlKoZsjxgZIA3d1vZ2X0msBgE0Jo1I/VI1MdVeqxfFj0sMwzXprto+9+O2W
         /6iqQutgt2VkM/TNbl6To3c5/gm92OWSUFWWWwaATsSct7pPq03xyfekCokZposDj8Ud
         er+bQsRh3pIMrFyaWjW2Afwh8W80nhk868edlqumxRi2EgjRGYsyO837fQYBu7y72PAB
         Pf+7fkZWMgXgCKXL4GtiqVMokNINDnnwGhHXlR5TRXyFQK32cuw4asRniBYisdVVKrRc
         C8jg==
X-Forwarded-Encrypted: i=1; AKwUvBwMqewVXIply4W7nVv2/fao1RBKT33l7dKTm1lgDMcwkfA2zTxkp40eD96iUEayNAWH6gETVjKU1UhIj0o3P2AzNXlreac=@vger.kernel.org
X-Gm-Message-State: AFuF++kW7mly1q1aL/GXNfliU3DvYj0eGiEeZo8riWmVAwCdpf7cxaVE
	0x/Jvez7fqJ0Y5hPJrdTiTNDN3uOn8q1P0nVCwYo4v4Qm3tKWfwcQwrn
X-Gm-Gg: AYBFou1TYrrR4Y8s4OwxUn9lk3a4c5dWu6TBsklEplZx8bZO9PIqPA43Zn0ZcdpIHqf
	SaPVuab0mHnS5Qg6ZiTk/eOkr2LCODN+9pJtDqQGJLs6w+89hytDwuVWesGnQCK+ZOcZQseGR5r
	CovxeH+AzKsTS+zOCM6ttgEGffmLeO9sPLKRzJ93qG1P7nMTLncmEH08zOtZdLeAnJ1jqv7CE5W
	0d4FN5G7KlL0gLkqqLckGzWMR9+bN4Puhfra7dgPq3l57f7J4rU9v3S/8aBd99bqspiSc+DuI/F
	YTEYAdLbW77eZZ3qXE4prGpTQ+elIgu9/juB/50H2mD8jhsXmSz9/jW8HsDjwnhjObDfOhQPmup
	D9sm1ZhrkLfKG+Zg+YddND8/8Ni8/9MvUA55Fkv24cwkrVyb8YfRqofqhgjQjfpTNyFK2yncpw6
	JK6uUMita5KHP1p+fgt17/fzAfFgrMIF92OFjO7kCXL/Lro8Q8gjJcKshD3IIb3xAIbNjY2boOA
	78rOTKsYZcsQ18ISfw+zM3yHRD5YYCN67mcuQv0CqP8
X-Received: by 2002:a05:690e:c4c:b0:671:2c69:78aa with SMTP id 956f58d0204a3-67135997185mr282518d50.42.1789191595731;
        Fri, 11 Sep 2026 22:39:55 -0700 (PDT)
Received: from zenbox ([2600:1700:18fb:6011:70da:1bc0:eb81:aa1b])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-67125e3159fsm1940360d50.12.2026.09.11.22.39.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2026 22:39:55 -0700 (PDT)
Date: Sat, 12 Sep 2026 01:39:54 -0400
From: Justin Suess <utilityemal77@gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	kpsingh@kernel.org, matt@bobrowski.net, paul@paul-moore.com, mic@digikod.net, 
	viro@zeniv.linux.org.uk, brauner@kernel.org, kees@kernel.org, casey@schaufler-ca.com, 
	gnoack@google.com, jack@suse.cz, song@kernel.org, yonghong.song@linux.dev, 
	martin.lau@linux.dev, eddyz87@gmail.com, memxor@gmail.com, jolsa@kernel.org, 
	m@maowtm.org, bpf@vger.kernel.org, linux-security-module@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH bpf-next v3 07/15] lsm: Add the bpf_lsm_policy_apply_bprm
 kfunc
Message-ID: <aqTiqL2QCJtzwW_x@zenbox>
References: <20260909193719.518517-1-utilityemal77@gmail.com>
 <20260909193719.518517-8-utilityemal77@gmail.com>
 <DLD0WER9K97K.2V2NOAJ840CR7@gmail.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DLD0WER9K97K.2V2NOAJ840CR7@gmail.com>

On Fri, Sep 11, 2026 at 08:38:16PM -0700, Alexei Starovoitov wrote:
> On Wed Sep 9, 2026 at 12:37 PM PDT, Justin Suess wrote:
> > Add the kfunc applying a policy object to an execution:
> >
> >   bpf_lsm_policy_apply_bprm(object, bprm, flags)        KF_SLEEPABLE
> >
> > It asks the LSM owning @object, through the bprm_apply_policy_object
> > hook, to restrict the credentials prepared in @bprm, so that the
> > executed task starts confined by the policy.  The meaning of @flags
> > and the composition with restrictions the credentials already carry
> > are the owning LSM's; an LSM without execution policy support makes
> > the call fail with -EOPNOTSUPP.
> >
> > The kfunc runs the hook in a root memcg charging scope: the policy
> > restricts the execution on behalf of the BPF program, not of the
> > mediated task, so what the owning LSM allocates to compute it, e.g.
> > Landlock's merged domain, is not charged to the task the program
> > supervises.
> >
> > The filter makes the kfunc exclusive to the sleepable LSM programs
> > attached to the bprm_creds_for_exec() or bprm_creds_from_file()
> > hooks, the only contexts where the bprm's credentials are prepared
> > but not yet committed.  The verifier's argument typing does not draw
> > this boundary on its own: a trusted struct linux_binprm pointer is
> > also available at the other bprm hooks -- bprm_check_security(),
> > which runs per binfmt while an interpreter may still rewrite the
> > execution, and bprm_committing_creds()/bprm_committed_creds(), which
> > run at or past the point of no return, where the prepared
> > credentials are frozen or installed -- and to tp_btf programs via
> > the sched_prepare_exec and sched_process_exec tracepoints, which
> > resolve kfuncs from the same registration bucket as LSM programs.
> > The attach-point filter, not the argument type, is the authorization
> > boundary.
> >
> > No filter case is needed for BPF_LSM_CGROUP programs: since
> > commit 5b038319be44 ("bpf: Reject sleepable BPF_LSM_CGROUP programs
> > at load time") they cannot be sleepable, so KF_SLEEPABLE already
> > excludes them.
> >
> > Cc: Paul Moore <paul@paul-moore.com>
> > Cc: KP Singh <kpsingh@kernel.org>
> > Signed-off-by: Justin Suess <utilityemal77@gmail.com>
> > ---
> >
> > Notes:
> >     v2->v3:
> >         - Drop the BPF_LSM_CGROUP case from the kfunc filter: since
> >           commit 5b038319be44 ("bpf: Reject sleepable BPF_LSM_CGROUP
> >           programs at load time") such programs cannot be sleepable, so
> >           KF_SLEEPABLE already excludes them from the apply kfunc.
> >         - Document, in the commit message and the filter comment, why the
> >           attach-point filter rather than the verifier's argument typing
> >           is the authorization boundary.
> >
> >  security/bpf_lsm_kfuncs.c | 68 +++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 68 insertions(+)
> >
> > diff --git a/security/bpf_lsm_kfuncs.c b/security/bpf_lsm_kfuncs.c
> > index 43a4bf57fd31..857e9a316d1c 100644
> > --- a/security/bpf_lsm_kfuncs.c
> > +++ b/security/bpf_lsm_kfuncs.c
> > @@ -2,16 +2,25 @@
> >  
> >  /* BPF kfuncs exposing LSM policy objects. */
> >  
> > +#include <linux/binfmts.h>
> >  #include <linux/bpf.h>
> >  #include <linux/btf.h>
> >  #include <linux/btf_ids.h>
> >  #include <linux/cfi.h>
> >  #include <linux/init.h>
> >  #include <linux/lsm_hooks.h>
> > +#include <linux/memcontrol.h>
> > +#include <linux/sched/mm.h>
> >  #include <linux/security.h>
> >  
> >  #include "lsm.h"
> >  
> > +/* The sleepable LSM hooks bpf_lsm_policy_apply_bprm() may be called from. */
> > +BTF_SET_START(bpf_lsm_policy_bprm_hooks)
> > +BTF_ID(func, bpf_lsm_bprm_creds_for_exec)
> > +BTF_ID(func, bpf_lsm_bprm_creds_from_file)
> > +BTF_SET_END(bpf_lsm_policy_bprm_hooks)
> > +
> >  __bpf_kfunc_start_defs();
> >  
> >  /**
> > @@ -44,6 +53,49 @@ bpf_lsm_policy_acquire(struct lsm_policy_object *object)
> >  	return NULL;
> >  }
> >  
> > +/**
> > + * bpf_lsm_policy_apply_bprm - Apply a policy object to exec credentials
> > + * @object: policy object to apply
> > + * @bprm: execution context providing the prepared credentials to
> > + *        restrict
> > + * @flags: flags defined by the LSM owning @object
> > + *
> > + * Ask the LSM owning @object to restrict the credentials prepared in
> > + * @bprm with it, so that the executed task starts confined by the
> > + * policy.  How the policy composes with restrictions the credentials
> > + * already carry, and the meaning of @flags, are defined by the owning
> > + * LSM.  @object is only borrowed: the caller keeps its reference.
> > + * The hook runs in a root memcg charging scope: policy the LSM
> > + * computes on behalf of the program is not charged to the mediated
> > + * task.
> > + *
> > + * Return: 0 on success, -EOPNOTSUPP if the LSM owning @object does
> > + * not support applying policy to an execution, -EINVAL on unsupported
> > + * @flags, other negative values on LSM-specific failures.
> > + */
> > +__bpf_kfunc int bpf_lsm_policy_apply_bprm(struct lsm_policy_object *object,
> > +					  struct linux_binprm *bprm, u32 flags)
> > +{
> > +	struct lsm_static_call *scall;
> > +	struct mem_cgroup *old_memcg;
> > +	int err;
> > +
> > +	lsm_for_each_hook(scall, bprm_apply_policy_object) {
> > +		if (scall->hl->lsmid->id != object->lsmid)
> > +			continue;
> > +		/*
> > +		 * The hook runs on behalf of the BPF program, not of the
> > +		 * mediated task: charge its allocations to the root memcg.
> > +		 */
> > +		old_memcg = set_active_memcg(root_mem_cgroup);
> > +		err = scall->hl->hook.bprm_apply_policy_object(bprm, object,
> > +							       flags);
> > +		set_active_memcg(old_memcg);
> > +		return err;
> > +	}
> > +	return -EOPNOTSUPP;
> 
> Nack.

It was hard to tell why you Nack'd this patch in particular from the
context.

If you wouldn't mind, providing some guidance as to why the code is
unacceptable in the current form would give a direction to work
towards...

(This is for the kfunc placement in security/ I assume?)

Thanks,
Justin
