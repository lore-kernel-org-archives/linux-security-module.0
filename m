Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794523589;
	b=Fk2VWG9not6mVty6Fl7rat+uzbx8AOb5pX5+l0gEbvpXGRApetTQtUIU5wLRhsvpEibZ
	 o2v7hVOHzXz+Qk0VEmiBpXB/juLBoi7yAoi84FCEvTztgEn+xchqH4PyFJDJRt44eAm1q
	 KPvWd4VtOkgar5ECO1vgMpA7OunuR64lXcjRpqHymVWj44AnvAbW8Ou/XmsfWrApuDpf2
	 84BsMul+LBteZyOkd9KLmNCiquVbCsZL9NiKkRavAGRA/YT71xufmmrYAgkKO+chMhxKK
	 fpHn93QU4rkr34Y+H5LkAMdKcfVh96M7fK/47Dt5jpVKwWQ9iGa8kbmGGwF72ttxU6g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794523589;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Disposition:Message-ID:User-Agent;
	bh=Qp/CYO9Y9QR0dXHUfw6yCZHzw+ctBhl7YE1TC+1vOS8=;
	b=uKW8h+MwZeBKyatWAeSePlkzkRKMpnLwWt2ln+OExfExR6KMF4evgEIdyUNMjc7cu2lT
	 x5XRThrLxrDwFx/NEm0/DyNt1sbfHu+R6a98Bs9+3JlRfIdHX8YfxieZThpIKlxK6UhsJ
	 kniT0oRyFifDtBUWEXxm8B7XV8uXKM0G8pnDro/ijV897HX/gt06NR0m+yqYSAMaFxUrA
	 XkoVvZ/6gQCAv6NUmxB4sp9VOKju1K1aok4Vq2oJZZCCAzZgLpxU9jl4uwZ9dhEkEO5Gc
	 LLwHB8NhloTW1vFJ7+B8Gz2AVVcS9zyytS+8gWG34NvVOhvJdzsHuAUOqoEqNeZj4fA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chrisdown.name;
	spf=pass smtp.mailfrom=chrisdown.name;
	dkim=pass header.d=chrisdown.name header.i=@chrisdown.name header.a=rsa-sha256 header.s=google header.b=ebkrXilb;
	arc=none smtp.remote-ip=209.85.221.50
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FADB606A32D
	for <linux-security-module@vger.kernel.org>; Thu, 12 Nov 2026 22:46:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1FADB606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=chrisdown.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chrisdown.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chrisdown.name header.i=@chrisdown.name header.a=rsa-sha256 header.s=google header.b=ebkrXilb
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-492f563d1c6so158084f8f.3
        for <linux-security-module@vger.kernel.org>; Thu, 12 Nov 2026 14:46:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google; t=1794523587; x=1795128387; darn=vger.kernel.org;
        h=user-agent:message-id:content-disposition:content-type:mime-version
         :references:in-reply-to:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Qp/CYO9Y9QR0dXHUfw6yCZHzw+ctBhl7YE1TC+1vOS8=;
        b=ebkrXilbj9spVaHW9PDW3KQNpqmqI4+4NOB68oQOLq+07vtNzaBA8OzPAUS9CcsePT
         8Kjg8BdAuCo3mV77DJ+j0I94WcjCRoV9fZV+wxCYZ49UIFzTMPcPTgg29Atqgy9WVWs2
         OlA64TH/oKxQCTcIaOXxFG9ghWOzXAc97hNLU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794523587; x=1795128387;
        h=user-agent:message-id:content-disposition:content-type:mime-version
         :references:in-reply-to:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Qp/CYO9Y9QR0dXHUfw6yCZHzw+ctBhl7YE1TC+1vOS8=;
        b=b1PyzZQGmxvfVpDLjKnrynJw7aNhi8xU1u3fLdU8m53VQUdIluoRr5n9DersM0VOPt
         SS+joXwxCRER7GjKC9cL9xagLSGel6Z3ZqWNKyLnOWvWo7islx+6fQfQS1dvxbc6S/Me
         D/NILXYE52hEuQNB7/cvfR2NPkd3DElb7i6wk+QXgtBR216g19s71txRfq3yrWGfT30D
         lFm97paIpK3WQckOqsSDRnBmlx1scBaOUIufMaF5t1moRkGqTO81GaB5W1aN773mfavm
         85ywQaYIP5lpHbFDuU3V6rnAqPQn3rzw2xKkoDNnhyFg4r6Mz8ZgR7KX9/0cqdg0a8mh
         PR+w==
X-Forwarded-Encrypted: i=1; AL+hErFAELYAcX+cUh6tli+KjV/rSSrSO4+AGByemwt115tAo4Pi04BQck8Zwk1apTPg5RnIu1s7i1Fj4MYsBPLXqzb74vmdMCs=@vger.kernel.org
X-Gm-Message-State: APuU4Z9q+a4YvCWLpXyBRkgjbjeeL1J4w/ixi6kep1VsNhczBKg0Jc8Q
	w/u7O1HVkJOg8D7I9u/w8e4kDlhJx87zF8MBLukIQWsGLZorT2RnvWvDE44KNK1Arlc=
X-Gm-Gg: AYBFou2SdjdICPIyDxw1h2nyFYZ+jcNJ2bbvEN1x5PMSTjWtJWa4AGZ8qsmNgmS/0M7
	kaDlvR47Z7c4+6D1vZgsB34Y9To2xC0g7yxLelAPPKjUKtw817bmM9SG5EA+zrrH18tdw1U7kde
	TVUMXb8erTGJ8KtOvdY7lJpLighPhPZpcoymwdZPEnN85duHgoYcudXk2dRFP2eYagXBaDdv8mg
	IgyJQv8Ur9dvU3fK0dkYStrIQ106xB0654kPHkVceDfW3hdw7g28KN7hbM8OEEKr9c4ZEuOHL3G
	qJ5Y19HHMHHgO0wm91QEML8gMNF7lKqjcvo7T2Vbva43JcXp6Zt56XtrRpEJkKUXYLd0FKdXjQ4
	I1B3feHzpJrWMsG3e1Jz4MhlPqPRCIPHwisvL1hUKKV4TMeoTR1PNE1kNizg+eZ670Atw/lFKyL
	rosjeDhO7MFX1eBJPGjwjFwZiaaYMxRTK0ONBeOX/gID40tRGKWBQivonRXTDuCyHOBcRUume1Q
	jq2WNrckQv8eX4ygN8nDlt7JegsjMNGdeoyf1bOpvJwiKF8FT2oMHZlq3561J1RDLWHoXi9Bnhz
	ZQpAZrokq55/gY7USm4B+W+kBvkgj22iEdKwbiqeHU35FidGTJffwd2sAjipcKLGvluA+ZN8kie
	vlkNf9nG4rDx9AqzGl4zUpjYxFX8cyVHiBxI4fBMdASx2mnmQ4AnleeQSDdQaStKUZINFRnQdOr
	5PZmR2y3+ReFMZJie4Ju62mfa6PFVvYGXjkZBdrUClyvLzrHDF1m5PUEaMJA==
X-Received: by 2002:a05:6000:2087:b0:488:57ad:d5c8 with SMTP id ffacd0b85a97d-49c6d453dbbmr2169176f8f.3.1794523587286;
        Thu, 12 Nov 2026 14:46:27 -0800 (PST)
Received: from [172.18.0.2] ([199.201.64.8])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-49c6020bb0fsm1504046f8f.34.2026.11.12.14.46.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 14:46:26 -0800 (PST)
Date: Thu, 12 Nov 2026 14:46:15 -0800
From: Chris Down <chris@chrisdown.name>
To: Aaron Tomlin <atomlin@atomlin.com>
Cc: tsbogend@alpha.franken.de, paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com, mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com, vincent.guittot@linaro.org, stephen.smalley.work@gmail.com, casey@schaufler-ca.com, longman@redhat.com, tj@kernel.org, hannes@cmpxchg.org, mkoutny@suse.com, chenridong@huaweicloud.com, dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de, vschneid@redhat.com, kprateek.nayak@amd.com, omosnace@redhat.com, kees@kernel.org, neelx@suse.com, sean@ashe.io, chjohnst@gmail.com, steve@abita.co, mproche@gmail.com, nick.lange@gmail.com, cgroups@vger.kernel.org, linux-mips@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-security-module@vger.kernel.org, selinux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5] security: Expand task_setscheduler LSM hook
In-Reply-To: <20261105172210.76706-1-atomlin@atomlin.com>
References: <20261105172210.76706-1-atomlin@atomlin.com>
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Message-ID: <20261112144615.df72a3bef0a52f3c@chrisdown.name>
User-Agent: Mutt/2.4.3 (cc9e3943) (2026-10-09)

Hi Aaron,

Aaron Tomlin writes:
>In modern multi-tenant and real-time environments, CPU and scheduling
>isolation are critical boundaries. The inability to audit or restrict
>specific scheduling policy changes or CPU pinning requests limits the
>effectiveness of security policies, particularly when attempting to
>shield isolated or cryptographic cores from unprivileged or compromised
>tasks.

Peter objected to this paragraph on v3, and you said there that you would
drop it. What you told him the patch is really for was auditing the
affinity mask as userspace asked for it, before cpuset intersects it with
the allowed CPUs, which seccomp can't do because the mask is behind a user
pointer. That should be in the changelog in place of this paragraph. (I
object to it as well. Please avoid such LLM grandiosity.)

>This change updates all in-tree security modules (capabilities, SELinux,
>and Smack) to accommodate the new parameters mechanically, while
>providing LSMs with the necessary context to enforce strict scheduling
>and affinity policies.

An LSM can only enforce an affinity policy through this hook if all possible
ways of changing a task's affinity go through it, but writes to cpuset.cpus
don't. With a BPF LSM program on this hook that rejects any mask containing
CPU 3, sched_setaffinity() to CPU 3 gets EPERM. An unprivileged user with a
delegated cgroup v2 subtree can still write 3 to the task's cpuset.cpus,
though, and the task ends up on CPU 3 without the hook being called.
cpuset_update_tasks_cpumask() just calls set_cpus_allowed_ptr() on every
task in the cpuset.

So what this gives an LSM is visibility into sched_setaffinity() requests
and cpuset migrations, not control over where a task runs. That may be
enough for auditing, but the changelog shouldn't promise enforcement. It
also looks like the kind of gap Paul meant on v3 when he asked how this
fits into a more comprehensive approach to resource control in the LSM.

>-LSM_HOOK(int, 0, task_setscheduler, struct task_struct *p)
>+LSM_HOOK(int, 0, task_setscheduler, struct task_struct *p,
>+	 const struct sched_attr *attr__nullable,
>+	 const struct cpumask *in_mask__nullable)

Since the BPF LSM is the only thing that reads these, please Cc
bpf@vger.kernel.org and the BPF LSM maintainers (KP Singh and Matt
Bobrowski) on the next version.

While the __nullable annotations do what you say, and a program that
dereferences either argument without a NULL check is rejected by the
verifier here, there is still a problem. Existing programs on this hook
that follow Documentation/bpf/prog_lsm.rst and pass on the previous
program's ret now get attr in that slot. One declared as

     int BPF_PROG(x, struct task_struct *p, int ret)

that returns ret when it's non-zero loads and runs fine, but with this
patch the verifier rejects it. LSM hooks aren't stable ABI, so that may
well be fine, but the BPF folks should get to say so :-)

> 		if (setsched_check) {
>-			ret = security_task_setscheduler(task);
>+			ret = security_task_setscheduler(task, NULL, cs->effective_cpus);

The kerneldoc you add in security.c says @in_mask is NULL if affinity
isn't changing, but that isn't what happens in cpuset_can_attach(). On v1
setsched_check is always true, so moving a task between two cpusets with
the same cpus and mems still calls the hook with the destination's
effective_cpus. With a v1 cpuset mount I see the hook get 0xf for a move
between two cpusets that both have cpus 0-3, and Cpus_allowed_list stays
at 0-3. On v2 the same happens for moves where only the mems differ.

The hook also can't tell this from a sched_setaffinity() call, since both
pass a NULL attr and a mask, but here the mask is the destination cpuset's
configuration, rather than something anyone asked to pin to. Please say
in the kerneldoc what @in_mask means for cgroup migration and
CLONE_INTO_CGROUP, so LSM authors don't treat it as a pinning request.

>+		lsm_attr.sched_policy = policy;
>+		retval = security_task_setscheduler(p, &lsm_attr, NULL);

For sched_setparam() and SCHED_FLAG_KEEP_POLICY, the reset-on-fork setting
that gets applied also comes from the task (reset_on_fork is set from
p->sched_reset_on_fork above), but lsm_attr.sched_flags still belongs to
the caller. On a task with SCHED_RESET_ON_FORK set, sched_setparam() reaches
the hook with sched_flags of 0, and sched_getscheduler() still reports
SCHED_RESET_ON_FORK afterwards. If lsm_attr is meant to show the hook what
will be applied, SCHED_FLAG_RESET_ON_FORK should follow reset_on_fork as
well.

Chris
