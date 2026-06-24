Received: from mail.networkname.de (mail.networkname.de [85.209.200.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9468834A3A5
	for <linux-security-module@vger.kernel.org>; Wed, 24 Jun 2026 17:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.209.200.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782323064; cv=none; b=K75igZZPjrMYFK9vtnRqCHx4NmQQAAJB3WGUH7sHMIH0+MrN5Ej+uZOPxB/tALJpTWEDDwRZ6chmTdBh/wzLzQXRBXZH/CG+pGys6zRGC9ju17LeyD6NUOXVMUYrpAQ7/9GLf5NQlX0A/n5T81WyzAAJ0k0B2KMCI/Kw6+8tM3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782323064; c=relaxed/simple;
	bh=oLGTfNcnUz2c+wwk6vk4c7HI3K3jQJjHHGEKRCiEVBo=;
	h=Mime-Version:Content-Type:Date:Message-ID:Cc:Subject:From:To:
	 References:In-Reply-To; b=CnijvlnO3poOIZDNuqwsuFGXDjBrT9g7JC5PJ3IZTibFOZVvFeBSitwyMSud6CPgTKtRkMCFu77jMUvRVPjkCTVoGMbOWVpco60RyOsc+DZY7Rj886Kt+SLqKnHZfxWhZubnzWQTMEa3xhejVBjlRvJ1p/Edn+QPzsz0i8WZXok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bevuta.com; spf=pass smtp.mailfrom=bevuta.com; dkim=pass (1024-bit key) header.d=bevuta.com header.i=@bevuta.com header.b=AymObAKL; dkim=pass (1024-bit key) header.d=bevuta.com header.i=@bevuta.com header.b=AymObAKL; arc=none smtp.client-ip=85.209.200.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bevuta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bevuta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bevuta.com header.i=@bevuta.com header.b="AymObAKL";
	dkim=pass (1024-bit key) header.d=bevuta.com header.i=@bevuta.com header.b="AymObAKL"
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bevuta.com; s=default;
	t=1782323047;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eLS4ZDGkBKbL1rpVPSGwS0GEt+/5ItJZ3bEqL7xYjn0=;
	b=AymObAKLsQddjaX/Fkxg0K/iZ3pjOyfP8IPu8jreJ1v2PWtZNwVZTGGQYIcVdvKVsauUdw
	XDsrnsxOUFCq+AXmxumYRtLXyM2y9JVZ2tuzZiI4oODpGC92SEVFE6wkjtNBAR1qDFGJZO
	ba7wK8FCvgy7W4AmIkNdOylpXWH8ObU=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bevuta.com; s=default;
	t=1782323047;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eLS4ZDGkBKbL1rpVPSGwS0GEt+/5ItJZ3bEqL7xYjn0=;
	b=AymObAKLsQddjaX/Fkxg0K/iZ3pjOyfP8IPu8jreJ1v2PWtZNwVZTGGQYIcVdvKVsauUdw
	XDsrnsxOUFCq+AXmxumYRtLXyM2y9JVZ2tuzZiI4oODpGC92SEVFE6wkjtNBAR1qDFGJZO
	ba7wK8FCvgy7W4AmIkNdOylpXWH8ObU=
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 24 Jun 2026 19:44:03 +0200
Message-ID: <DJHGSEVHV1M1.2DMGCPPU1YK4Z@mail.networkname.de>
Cc: <serge@hallyn.com>, <jmorris@namei.org>, <paul@paul-moore.com>
Subject: Re: [PATCH] LSM: check if lsmprop_to_secctx call is supported by
 LSM
From: "Sebastian Bockholt" <sebastian.bockholt@bevuta.com>
To: "Casey Schaufler" <casey@schaufler-ca.com>, "Sebastian Bockholt"
 <sebastian.bockholt@bevuta.com>, <linux-security-module@vger.kernel.org>
References: <20260619171945.1617498-1-sebastian.bockholt@mail.networkname.de> <a28fb6b5-cdf3-4523-813a-165c00f7aef6@schaufler-ca.com>
In-Reply-To: <a28fb6b5-cdf3-4523-813a-165c00f7aef6@schaufler-ca.com>

On Fri Jun 19, 2026 at 7:44 PM CEST, Casey Schaufler wrote:
> If you want to help with the multiple LSM support, there's still
> plenty of work to do. Let me know.

This is my first time trying to contribute to the kernel. If this is the wr=
ong
mailing list or wrong format to discuss this, please tell me directly.
Otherwise, multiple LSM support seems to be a little bit to ambitious for m=
y
first contributions.

> If the BPF LSM (the BPF LSM infrastructure, not the eBPF programs)
> is going to support security contexts you need to mark it
> LSM_FLAGS_EXCLUSIVE.

[...]

> Until then your choices are:
>
> 	- Make the BPF LSM exclusive
> 	- Do not use any of the security context or secid based hooks
>

I am not trying to load any BPF myself but I am debugging issues when using
auditd and apparmor in parallel. As soon as I try to load audit rules from
userspace our logs get spammed with "error in audit_log_subj_ctx" messages.
According to my analysis, the function call chain leading to the bug is:

1. audit_log_subj_ctx defined in kernel/audit.c
	 // the only LSM enabled is apparmor -> audit_subj_secctx_cnt =3D=3D 1
	 // confirmed using bpftrace
	 if (audit_subj_secctx_cnt < 2) {
	 	error =3D security_lsmprop_to_secctx(prop, &ctx, LSM_ID_UNDEF);
	 	if (error < 0) {
			if (error !=3D -EINVAL)
				goto error_path; // produces err msgs in logs
			return 0;
		}
		audit_log_format(ab, " subj=3D%s", ctx.context);
		security_release_secctx(&ctx);
	}

2. security_lsmprop_to_secctx defined in security/security.c
	// lsm_for_each_hook iterates over all registered LSMs
	// lsm_id =3D=3D LSM_ID_UNDEF -> the first lsmprop_to_secctx hook is used
	// tracing the following probes using bpftrace
	// 	kretprobe:apparmor_lsmprop_to_secctx
	// 	kretprobe:selinux_lsmprop_to_secctx
	// 	kretprobe:smack_lsmprop_to_secctx
	// 	kretprobe:bpf_lsm_lsmprop_to_secctx
	// 	kretprobe:security_lsmprop_to_scctx
	// bpf_lsm_lsmprop_to_secctx hook is executed and returns -EOPNOTSUPP
	lsm_for_each_hook(scall, lsmprop_to_secctx) {
		if (lsmid !=3D LSM_ID_UNDEF && lsmid !=3D scall->hl->lsmid->id)
			continue;
		return scall->hl->hook.lsmprop_to_secctx(prop, cp);
	}

3. bpf_lsm_lsmprop_to_secctx
	is defined through #include <linux/lsm_hook_defs.h> and returns
	-EOPNOTSUPP default. The return value is propagated up the call stack
	up to security_lsmprop_to_secctx and then to audit_log_subj_ctx.
	audit_log_subj_ctx checks for error return values and prints the
	audit_panic "error in audit_log_subj_ctx"

My patch could check for any errors or lsmprop_to_secctx but since some mig=
ht
be useful to check by another function in the call stack, i decided to only
check if the hook is supported by the LSM.
