Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793312306;
	b=ZiJR095DBxs8x/EyCdXcKyrUvAQm2/RJnuZ9SlwGro5hmGEKrjlCMnn/IlCnJPxsM3Gb
	 F+klpbKtnVPXP0vRbKbsNuJGVXJys1Uk41XQO1M05Ph5AXXG+sK103W9lyLd60eiK/4Wv
	 +3T3RJGPJPC2F9BuzgQuUA1dyf6N+cYsVs7h5x1epSLMhuIvD8/Ud7muJmI3fb+g81ePY
	 w0BhtuaWIvescuSRFHXob63L9W9VYHgGib8zGLtpmvxUmYUnsyOEbPwV9uhDoA+yIHe19
	 8XbIAnUm1X0cYg48jYJaw+uBIAExMkwRKU8KzjRsi2j6WVQczuBzib7KEOvnRu6Gr7w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793312306;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=phiULCF2KlOQb+4UBW/xR2SzUJpvscqV0oa+Qy8x0w0=;
	b=rYNbIzWAee6IRDhh6VQ1UxLC8if2Jv7rOLIcoSKyBwu7og90+T8J3X8plXJDVYp0R040
	 VJDdNna2t1aUOYPVd+Wv0w/Gs2EYGIa/6al2O6imMDLV6dCBPsZPb92J1btSZIj4/UH3U
	 3g7QxC8Dtp+ca5e++6vcXUpXZ5x4ephQAkAm6qvQsaJcV1iZUEPKjx6oVdQIlWKBlvM6t
	 eicnSsWHF+IAei8lFug7Yj3cuVo2iG4wLqqFVR/UOCw6Elxlh0xH0ukEtOwLP0ez4WsNu
	 aIxNo1uz5Ky3f1ribjfdbEtV0TOB32vo7sp9nq4anOOZ1J22dwAkyekwtI7ebEs770g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eHzxbNf5;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96A47606A31C
	for <linux-security-module@vger.kernel.org>; Thu, 29 Oct 2026 22:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eHzxbNf5
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61AE71F01824
	for <linux-security-module@vger.kernel.org>; Thu, 29 Oct 2026 22:18:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793312306;
	bh=phiULCF2KlOQb+4UBW/xR2SzUJpvscqV0oa+Qy8x0w0=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=eHzxbNf5HuieYgSWR/yUW8IfWrLm+3mc10PuNOmrp2hziDAakfqm3GFUrJh5xQHEI
	 JnuK8jH8mnJtlWJAQwrKkMQUvDOrpBwqrjc5gMxgKbHrvzAbxrnPu4ahPFKFxmBuhD
	 KLvzujZuSy4Dl5jdT5N2KRKoKxva0Aztf/wqnn9n8v15PyHxyOhr2kDRgFvw6+nV51
	 p8vXviy1iBSHvkv9AfLkJXsWuUuZo1uudKzKdxW47K6fLegpUvJXxEXis6tjwHETZj
	 dje/+154OkFi5xHabbMEKAWKoi/A4dRfi7RL7ONoixbFXtQoSHGoGAUG0/0F4FgWKz
	 238rTWS2b/Jhw==
Message-ID: <sashiko-outbox-190063@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/8] userns: introduce capability bounding set for user
 namespaces
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20261028221705.3915340-3-halg@google.com>
References: <20261028221705.3915340-1-halg@google.com>
 <20261028221705.3915340-3-halg@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 29 Oct 2026 22:18:25 +0000
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] userns: cap_ptrace_access_check() denies owner access without CA=
P_SYS_PTRACE
--

commit 16037e714ad5686658566ccf9fa3273e7c4c0615
Author: Hallgrimur H. Gunnarsson <halg@google.com>

userns: introduce capability bounding set for user namespaces

This commit introduces a per-user-namespace capability bounding set
(cap_bset) and a global sysctl ceiling knob
(kernel.unprivileged_userns_caps_allowed) to restrict the capabilities
granted when unprivileged tasks create user namespaces. It also bounds
the implicit capabilities granted to a parent-namespace owner over an
owned child user namespace by the child namespace's cap_bset.

> diff --git a/security/commoncap.c b/security/commoncap.c
> index 3399535808fec..f153e7bad1baf 100644
> --- a/security/commoncap.c
> +++ b/security/commoncap.c
> @@ -88,11 +88,13 @@ static inline int cap_capable_helper(const struct cre=
d *cred,
>  		if (ns->level <=3D cred_ns->level)
>  			return -EPERM;
> =20
> -		/*=20
> +		/*
>  		 * The owner of the user namespace in the parent of the
> -		 * user namespace has all caps.
> +		 * user namespace has all caps, subject to the bounding
> +		 * set of the owned user namespace.
>  		 */
> -		if ((ns->parent =3D=3D cred_ns) && uid_eq(ns->owner, cred->euid))
> +		if (ns->parent =3D=3D cred_ns && uid_eq(ns->owner, cred->euid) &&
> +		    userns_has_cap(ns, cap))
>  			return 0;

[Severity: Medium]
When CAP_SYS_PTRACE is excluded from a child user namespace's cap_bset
(either via the unprivileged_userns_caps_allowed sysctl or via
CLONE_NEWUSER_BSET in "userns: allow restricting capability bounding set
via clone3()"), does this break ptrace_may_access() and PTRACE_TRACEME for
the parent-namespace owner inspecting its own child processes in that
namespace?

In __ptrace_may_access(), a caller with the same UID/GID as a dumpable
target passes the UID/GID and dumpability checks without needing
CAP_SYS_PTRACE, and then calls security_ptrace_access_check() ->
cap_ptrace_access_check():

security/commoncap.c:cap_ptrace_access_check() {
	...
	if (cred->user_ns =3D=3D child_cred->user_ns &&
	    cap_issubset(child_cred->cap_permitted, *caller_caps))
		goto out;
	if (ns_capable(child_cred->user_ns, CAP_SYS_PTRACE))
		goto out;
	ret =3D -EPERM;
}

And similarly in cap_ptrace_traceme():

security/commoncap.c:cap_ptrace_traceme() {
	...
	if (cred->user_ns =3D=3D child_cred->user_ns &&
	    cap_issubset(child_cred->cap_permitted, cred->cap_permitted))
		goto out;
	if (has_ns_capability(parent, child_cred->user_ns, CAP_SYS_PTRACE))
		goto out;
	ret =3D -EPERM;
}

Although the kernel-doc comments on both functions state that access is
allowed if the caller is in the same or an ancestor user_ns and holds all
of the target task's capabilities (matching cred_cap_issubset() in
kernel/cred.c), both functions only check cap_issubset() when
cred->user_ns =3D=3D child_cred->user_ns. For an ancestor user_ns, they rely
entirely on ns_capable(child_cred->user_ns, CAP_SYS_PTRACE) or
has_ns_capability(parent, child_cred->user_ns, CAP_SYS_PTRACE).

Because cap_capable_helper() now requires userns_has_cap(ns, cap) for the
owner in the parent namespace, ns_capable(child_cred->user_ns,
CAP_SYS_PTRACE) returns false whenever CAP_SYS_PTRACE is not in
child_ns->cap_bset. As a result, an unprivileged parent task that spawns a
sandboxed child in a new user namespace without CAP_SYS_PTRACE is denied
access to its own child even when the child has no capabilities beyond the
owned namespace (or cap_permitted =3D=3D CAP_EMPTY_SET).

This causes parent-side operations gated on ptrace_may_access() to fail
with -EPERM, -EACCES, or -ENOENT, including opening /proc/<child>/ns/*,
setns(pidfd, ...) via validate_nsset() (even when CAP_SYS_ADMIN is set in
child_ns->cap_bset), pidfd_getfd(), reading /proc/<child>/maps or
/proc/<child>/fd/*, ptrace attach / PTRACE_TRACEME, and accessing
/proc/<child>/uid_map when procfs is mounted with hidepid.

Should cap_ptrace_access_check() and cap_ptrace_traceme() permit access
when the caller is the owner of an ancestor user namespace (similar to
cred_cap_issubset(), where all capabilities in the child namespace are a
subset of the owner's privileges over that namespace), rather than
requiring CAP_SYS_PTRACE to be present in the child namespace's cap_bset?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261028221705.3915=
340-1-halg@google.com?part=3D2
