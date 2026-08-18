Received: from oss.cyber.gouv.fr (oss.cyber.gouv.fr [51.159.188.251])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3963A43636A;
	Tue, 18 Aug 2026 11:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.159.188.251
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787051311; cv=none; b=mchL0lK2R9HSxbEMf/Nz9DJ4qcGvFw2zZrLW4+OGFAKGaGT1k+hf+et1HiDVvHlDajuVUERAVJNW2d3bJgHNLEteZJsnf4OlYHDgy5vQvLE6RX50/rajPdrH9H4F4E5ENAQwzulidFcYbxxYSCXAZwAhzhla/BiVLt6vVme45TM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787051311; c=relaxed/simple;
	bh=B+GAdKKMnh4a/scRN7acFP7sGhI1QfsXwnoywYuBhqY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=shWOm3L909W5TClwC3uujapIARVI8H+zEjorV6Ty3NcZny5goGB4ylAkc6e8cbEcQSRUiSAEWtDY1HaVPrR9ZgGTS+wU/UHzu7mgShblvINWWmh8A9fgwUthcL/i9CM8J2RryYgqNia1ivBDwSoOn82KfvoyJlclqYdgY6vlTZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.cyber.gouv.fr; spf=pass smtp.mailfrom=oss.cyber.gouv.fr; dkim=pass (2048-bit key) header.d=oss.cyber.gouv.fr header.i=@oss.cyber.gouv.fr header.b=S7oWmlY9; arc=none smtp.client-ip=51.159.188.251
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.cyber.gouv.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.cyber.gouv.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oss.cyber.gouv.fr header.i=@oss.cyber.gouv.fr header.b="S7oWmlY9"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=oss.cyber.gouv.fr; s=default; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=DoJnBGVmPmHzwIoIxoRyq2QvRJFKTli+shu8VMzn9Ls=; b=S7oWmlY9FtS+DVt+YZQG1m9tes
	i6UVmCUZ5lfNUHKENhnp8oBl9UQreO1qYWCfobrcg6VxVzKIfXMLnWiIW3mwkk1wlYMKb+0rvOnoi
	E4TVyfaVTMo7gVvsPqv4bPc4p+C/n7aFUktmTgumFs7e2tB0HBcSyvHy9SrpL4h9H0wV3swXinMkI
	YYupoYIxi5gJHqr4+l0U+cJE1J/g/PimcMO1ycCI+hu3qJOXHemG2TjDeeCLvJ+JkVEG5aSwKRYgy
	jLznBRDRcl+f9vcFcqfBCblfbOxUiP3ovaVwfPuS9Fcyqx43/9avkGW9K8mWHxJMgJQc3mbOl2gZe
	BobphJyw==;
Received: from laubervilliers-658-1-215-187.w90-63.abo.wanadoo.fr ([90.63.246.187]:29241 helo=archlinux)
	by pf-012.whm.fr-par.scw.cloud with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.99.5)
	(envelope-from <nicolas.bouchinet@oss.cyber.gouv.fr>)
	id 1wwHgC-000000081kE-0PWr;
	Tue, 18 Aug 2026 13:08:27 +0200
Date: Tue, 18 Aug 2026 11:08:25 +0000
From: Nicolas Bouchinet <nicolas.bouchinet@oss.cyber.gouv.fr>
To: Xiujianfeng <xiujianfeng@huaweicloud.com>
Cc: Justin Suess <utilityemal77@gmail.com>, 
	Alexei Starovoitov <ast@kernel.org>, Paul Moore <paul@paul-moore.com>, 
	Xiujianfeng <xiujianfeng@huawei.com>, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH bpf-next 0/2] lsm: give BPF programs a way to query
 locked_down state
Message-ID: <aoQndOlUPKN84WTm@archlinux>
References: <20260815112041.1248855-1-utilityemal77@gmail.com>
 <6ab57477-69f8-4c60-852e-58ce7ef25023@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6ab57477-69f8-4c60-852e-58ce7ef25023@huaweicloud.com>
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - pf-012.whm.fr-par.scw.cloud
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - oss.cyber.gouv.fr
X-Get-Message-Sender-Via: pf-012.whm.fr-par.scw.cloud: authenticated_id: nicolas.bouchinet@oss.cyber.gouv.fr
X-Authenticated-Sender: pf-012.whm.fr-par.scw.cloud: nicolas.bouchinet@oss.cyber.gouv.fr
X-Source: 
X-Source-Args: 
X-Source-Dir: 

On Tue, Aug 18, 2026 at 11:47:55AM +0800, Xiujianfeng wrote:
> +cc Nicolas
> 
> On 8/15/2026 7:20 PM, Justin Suess wrote:
> > Howdy,
> > 
> > BPF programs can attach to the locked_down LSM hook and contribute a
> > verdict, but they have never been able to ask the locked_down question
> > themselves: there is no way for a program to invoke the hook and learn
> > whether a given operation is locked down. (i.e be a caller of
> > security_locked_down rather than a consumer).
> > 
> > Today the state has to be fed in out of band, for example userspace
> > reading /sys/kernel/security/lockdown and writing the result into a
> > map. That is a time-of-check/time-of-use race: a security_locked_down
> > verdict can be raised at runtime, so the cached answer can be stale
> > by the time the program acts on it.
> 
> Adding the bpf_security_locked_down() kfunc does not actually solve the
> TOCTOU issue you mentioned. Even after bpf_security_locked_down() is
> called, userspace can still change the lockdown state via /sys/kernel/
> security/lockdown.
> 
> I fail to see the necessity for a BPF program to know whether a specific
> operation is locked down.

I agree with Xiu.

> The test case provided in patch 2 does not
> clearly demonstrate a scenario where this is required. In my view, the
> verdict should happen exactly where security_locked_down() is currently
> invoked.
> 

> Furthermore, based on the current implementation of Lockdown, integrity
> is the prerequisite for confidentiality. It is designed to be coarse-
> grained and does not support per-operation lockdown. The fact that LSM
> BPF can already hook into locked_down seems to violate this foundational
> model, this is is analogous to the bitmap implementation [1], I’m
> considering whether we should restrict BPF from attaching to the
> locked_down hook. Nicolas, what are your thoughts on this?

I do not see any issue about LSM BPF being able to hook into
security_locked_down. If Lockdown is enabled in integrity mode, and a
BPF LSM hook authorizes let's say the LOCKDOWN_DEV_MEM reason, Lockdown
will deny it anyway.

IMHO, if one wants to disable the Lockdown LSM and implement it through
eBPF, if the implementation is bad, it is not our problem. Exactly as
for other LSM hooks.
> 
> [1]
> https://lore.kernel.org/all/20250728111517.134116-1-nik.borisov@suse.com/
> 
> > 
> > Add a bpf_security_locked_down() kfunc that calls
> > security_locked_down() and returns its verdict, letting LSM and
> > syscall programs query locked_down state at decision time. Out-of-range
> > reasons are rejected with -EINVAL before dispatching the hook, and the
> > kfunc is refused to programs attached to the locked_down hook itself,
> > which would recurse into the dispatch. (how the obvious recursion issue
> > is addressed).
> > 
> > As this is the first pure-lsm-hook kfunc, add a new file security/lsm_kfuncs.c
> > to host it.
> > 
> > This kfunc has no reliance on / relation to the Lockdown LSM, despite the
> > similar naming. It is an LSM-agnostic caller of security_locked_down, and
> > Lockdown just happens to be the only in-tree subscriber to this hook at the
> > moment.
> > 
> > In fact, the test environment does not rely on CONFIG_SECURITY_LOCKDOWN at
> > all, and uses a BPF implementation of security_locked_down.
> > 
> > This kfunc can cause notices to be printed with kmsg if the Lockdown LSM is
> > enabled due to this line in security/lockdown/lockdown.c:
> > 
> >    pr_notice_ratelimited("Lockdown: %s: %s is restricted; see man kernel_lockdown.7\n",
> > 				                 current->comm, lockdown_reasons[what]);
> > 
> > Patch 1 adds the kfunc, patch 2 the selftests. This is based on bpf-next/master, but
> > applies cleanly to the lsm tree.
> > 
> > Justin

Nicolas
