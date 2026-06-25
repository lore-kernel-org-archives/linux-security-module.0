Received: from mail.networkname.de (mail.networkname.de [85.209.200.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3697F3DBD5E
	for <linux-security-module@vger.kernel.org>; Thu, 25 Jun 2026 15:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.209.200.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782401068; cv=none; b=BGAz3N6GarTDqjFJwiEz8Luk+zNjITwakpWpWgiB+4+PvLwlnyhTsbBuZOjiJYgjrxPj1FA26IrnKBvLvmYGSyueCTnmHiHp7RfLb+L0P5V9rm2nOXqu0XueMfuC11JZALikgnI/OHYKZvgaNUeCqMDZG/6OAv8jPToBaYrHAxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782401068; c=relaxed/simple;
	bh=cVjGtakYYQKTaHt80rXgce/3qo5yBkdoxWaqKJ85Iyc=;
	h=Mime-Version:Content-Type:Date:Message-ID:Subject:From:To:Cc:
	 References:In-Reply-To; b=hnYssPLmVfbzlt7+N4j/g5qbDQZTWi0KaTvEGgFndLV10wQK6x9hVOV9Fu7vt9L5QrIOzt8iHxQYpjHe116pFMvvsmvHZlYnd8HNuzhJ3UfSJh6ZzVSB5oQHaDEIuGlTFNBVa7AyVGpGtS7IGbFym+ylG/67+gqBymT6L7a7F9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bevuta.com; spf=pass smtp.mailfrom=bevuta.com; dkim=pass (1024-bit key) header.d=bevuta.com header.i=@bevuta.com header.b=ei3okMLK; dkim=pass (1024-bit key) header.d=bevuta.com header.i=@bevuta.com header.b=ei3okMLK; arc=none smtp.client-ip=85.209.200.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bevuta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bevuta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bevuta.com header.i=@bevuta.com header.b="ei3okMLK";
	dkim=pass (1024-bit key) header.d=bevuta.com header.i=@bevuta.com header.b="ei3okMLK"
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bevuta.com; s=default;
	t=1782401060;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HdaPbtti9hjZV9ATLYhaCinSiuPaJ28My8r0Yub7yGo=;
	b=ei3okMLKaU4jtDD36VebZKfu10/vld4SQPDPW0/KE2oC8n6wzSM7+3nULe4lQQ1KMtrG4f
	k4U2y0zXwQ2ZyYT0vLldmexinb4COS1vSysM7EuQhCsNd+uWBvYDIiXWoP+ii3D9yeCJTO
	Uh3MUh50rgbNNQvNpg+Yb9coXEOnXHQ=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bevuta.com; s=default;
	t=1782401060;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HdaPbtti9hjZV9ATLYhaCinSiuPaJ28My8r0Yub7yGo=;
	b=ei3okMLKaU4jtDD36VebZKfu10/vld4SQPDPW0/KE2oC8n6wzSM7+3nULe4lQQ1KMtrG4f
	k4U2y0zXwQ2ZyYT0vLldmexinb4COS1vSysM7EuQhCsNd+uWBvYDIiXWoP+ii3D9yeCJTO
	Uh3MUh50rgbNNQvNpg+Yb9coXEOnXHQ=
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 25 Jun 2026 17:24:07 +0200
Message-ID: <DJI8FTANOKXU.2R1GP19EC657G@mail.networkname.de>
Subject: Re: [PATCH] LSM: check if lsmprop_to_secctx call is supported by
 LSM
From: "Sebastian Bockholt" <sebastian.bockholt@bevuta.com>
To: "Casey Schaufler" <casey@schaufler-ca.com>, "Sebastian Bockholt"
 <sebastian.bockholt@bevuta.com>, <linux-security-module@vger.kernel.org>
Cc: <serge@hallyn.com>, <jmorris@namei.org>, <paul@paul-moore.com>
References: <20260619171945.1617498-1-sebastian.bockholt@mail.networkname.de> <a28fb6b5-cdf3-4523-813a-165c00f7aef6@schaufler-ca.com> <DJHGSEVHV1M1.2DMGCPPU1YK4Z@mail.networkname.de> <3a6208ae-ed80-4859-8c41-76010fad3f0d@schaufler-ca.com>
In-Reply-To: <3a6208ae-ed80-4859-8c41-76010fad3f0d@schaufler-ca.com>

On Wed Jun 24, 2026 at 9:36 PM CEST, Casey Schaufler wrote:
> On 6/24/2026 10:44 AM, Sebastian Bockholt wrote:
>> On Fri Jun 19, 2026 at 7:44 PM CEST, Casey Schaufler wrote:
>>> If you want to help with the multiple LSM support, there's still
>>> plenty of work to do. Let me know.
>> This is my first time trying to contribute to the kernel. If this is the=
 wrong
>> mailing list or wrong format to discuss this, please tell me directly.
>
> You have come to the right place.
>

Thank you and very much appreciated.

>>> If the BPF LSM (the BPF LSM infrastructure, not the eBPF programs)
>>> is going to support security contexts you need to mark it
>>> LSM_FLAGS_EXCLUSIVE.
>> [...]
>>
>>> Until then your choices are:
>>>
>>> 	- Make the BPF LSM exclusive
>>> 	- Do not use any of the security context or secid based hooks
>>>
>> I am not trying to load any BPF myself but I am debugging issues when us=
ing
>> auditd and apparmor in parallel.
>
> Where does BPF appear in your LSM order?
>
> 	% cat /sys/kernel/security/lsm
>
> If bpf shows up ahead of apparmor you will see this problem.
>

You were right:

% cat /sys/kernel/security/lsm
capability,landlock,yama,bpf,apparmor

Reordering the LSM order to capability,landlock,yama,apparmor,bpf fixed
the issue.

Thank you

>>  As soon as I try to load audit rules from
>> userspace our logs get spammed with "error in audit_log_subj_ctx" messag=
es.
>> According to my analysis, the function call chain leading to the bug is:
>>
>> 1. audit_log_subj_ctx defined in kernel/audit.c
>> 	 // the only LSM enabled is apparmor -> audit_subj_secctx_cnt =3D=3D 1
>> 	 // confirmed using bpftrace
>> 	 if (audit_subj_secctx_cnt < 2) {
>> 	 	error =3D security_lsmprop_to_secctx(prop, &ctx, LSM_ID_UNDEF);
>> 	 	if (error < 0) {
>> 			if (error !=3D -EINVAL)
>> 				goto error_path; // produces err msgs in logs
>> 			return 0;
>> 		}
>> 		audit_log_format(ab, " subj=3D%s", ctx.context);
>> 		security_release_secctx(&ctx);
>> 	}
>>
>> 2. security_lsmprop_to_secctx defined in security/security.c
>> 	// lsm_for_each_hook iterates over all registered LSMs
>> 	// lsm_id =3D=3D LSM_ID_UNDEF -> the first lsmprop_to_secctx hook is us=
ed
>> 	// tracing the following probes using bpftrace
>> 	// 	kretprobe:apparmor_lsmprop_to_secctx
>> 	// 	kretprobe:selinux_lsmprop_to_secctx
>> 	// 	kretprobe:smack_lsmprop_to_secctx
>> 	// 	kretprobe:bpf_lsm_lsmprop_to_secctx
>> 	// 	kretprobe:security_lsmprop_to_scctx
>> 	// bpf_lsm_lsmprop_to_secctx hook is executed and returns -EOPNOTSUPP
>> 	lsm_for_each_hook(scall, lsmprop_to_secctx) {
>> 		if (lsmid !=3D LSM_ID_UNDEF && lsmid !=3D scall->hl->lsmid->id)
>> 			continue;
>> 		return scall->hl->hook.lsmprop_to_secctx(prop, cp);
>> 	}
>>
>> 3. bpf_lsm_lsmprop_to_secctx
>> 	is defined through #include <linux/lsm_hook_defs.h> and returns
>> 	-EOPNOTSUPP default. The return value is propagated up the call stack
>> 	up to security_lsmprop_to_secctx and then to audit_log_subj_ctx.
>> 	audit_log_subj_ctx checks for error return values and prints the
>> 	audit_panic "error in audit_log_subj_ctx"
>>
>> My patch could check for any errors or lsmprop_to_secctx but since some =
might
>> be useful to check by another function in the call stack, i decided to o=
nly
>> check if the hook is supported by the LSM.

