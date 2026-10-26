Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793030176;
	b=KLomDeGjA7F7S6nuXLlVwzaxZqACSUmlxEVk2xrDcRjcrnEiQ06ZfU0G3L/FhtXXSZkG
	 x2pi6KMVYeDt+p58Ylm1Wqd9ycVjO9AwxVACw/tNMtzwlJ19iX8ZnEwH+QVtzcXQbv1vz
	 +7B0bC6y5/6tc1u2gdgaxZCi986yQvtA/0UKZJNKb/opxMlhL8xFfpnFwM7UzmSbqjlPJ
	 6HvrFE0ETjRh4QciMGwnqz+m+ZfsdZ7UIGgbrNGZnQg1P4YuD1er+snPQsx+yu9Rb4F6l
	 KHJmTq1CNOH9zuaaRAbjVqPPBFiieqTLO9z3dC3RKBzyrmSVGCP/tYDt9DR/MOEiZGA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793030176;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=SfzPCjAxcer+gXhgrGNsLkNaqTRB0JPn+dnhXU2gvcE=;
	b=oK6T3cuevBQi1Yr9ZZSTdT001O6oRzI8dcejBOvxGSMzUvk2T14kx7o1HDyogoLKMe2v
	 X7M0c/EeN1OsZ1LdqHYWvEJO6OFj5hkFHz/F/tXBbkhvr5vCHYpPU28ZaV/PnNp70LB3p
	 dJ5JQTQRtDJ9aMPYr4ap7SV7oRFRjsWFKjbw3C4pc+g8qHmd8LyLLUTviR71dP6VV0gnA
	 0gAKC+Sag/+u44fhOOM8m7NLlb7euIVyjuNSvaNH04WAydYmaZZB+8T7eP8i+QoXBoB4H
	 5YkDNHWHhWiDEqnezx2rtIJkQHzOx3p0//jwYfXRjVlFNX+TzJklnz3bb5IpNgI6gnQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QWVZibfH;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B18D9606A31A
	for <linux-security-module@vger.kernel.org>; Mon, 26 Oct 2026 15:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QWVZibfH
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77D5D1F01825
	for <linux-security-module@vger.kernel.org>; Mon, 26 Oct 2026 15:56:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793030175;
	bh=SfzPCjAxcer+gXhgrGNsLkNaqTRB0JPn+dnhXU2gvcE=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=QWVZibfH3KGLJ+kr7WBhnoWN7C64sZFF3dv4meTP28dhp1H7M4DEgFavc6EzrRJNu
	 SazXmaXftO3uV3Uuo2V88m+wLmstM1TcuxbvTG7u/U+w32I1JbudUEyThBvC1HmVmn
	 6mh3L6MWvBCjI9WXU3qu+t1yEB4l+vUl6w3uECFrywfiAT3KRyaGZldMlrNj03Hmhs
	 qxxLLz5HdDcWPEJdpNwATmLHoYrWN1wXv/kf+0EnACWaNybQ8vwFHk4F6uTfdzcOY6
	 G9R3Aa6tYkohm8cKIWohmKDUxExcTPXXj6Qs1jehcUpJPmX+aunotNXrmp3VBLXko7
	 yVQP9h9fSmV1Q==
Message-ID: <sashiko-outbox-185472@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 5/6] capabilities: don't let ptrace borrow
 CAP_SETFCAP
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20261026-b4-setfcap-userns-v6-5-25f10b7ca497@toxicpanda.com>
References: <20261026-b4-setfcap-userns-v6-0-25f10b7ca497@toxicpanda.com>
 <20261026-b4-setfcap-userns-v6-5-25f10b7ca497@toxicpanda.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 26 Oct 2026 15:56:15 +0000
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list

> Tasks in a user namespace created by a task with CAP_SETFCAP may map uid
> 0 of the parent and write file capabilities that are honoured there.
> That is the one privilege they keep outside of their namespace.  setns()
> no longer lets anybody in who doesn't have it, but the ptrace checks
> don't know about it: for a target in another user namespace
> cap_ptrace_access_check() is satisfied with CAP_SYS_PTRACE over the
> target's namespace, which the owner rule hands to any task with the
> right euid.
>=20
>   task A: uid 0, full caps          task B: uid 0, no CAP_SETFCAP
>   unshare(CLONE_NEWUSER)
>                                     ptrace(PTRACE_ATTACH, A)
>                                       uids match, euid =3D=3D ns->owner
>                                     make A write "0 0 1" to its uid_map,
>                                     or set file capabilities
> [ ... ]
> tracer can't setns() into either.  PTRACE_MODE_READ is unchanged.
>=20
> Fixes: db2e718a4798 ("capabilities: require CAP_SETFCAP to map uid 0")
> Assisted-by: LLM
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261026-b4-setfcap=
-userns-v6-0-25f10b7ca497@toxicpanda.com?part=3D5

