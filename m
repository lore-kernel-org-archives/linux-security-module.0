Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794522231;
	b=K82W6mwQ4p4yIrD3nLcbU+42szJHWImLOGBQYygaQa8FmKFLco9FT5pLPoyHCtn1RXk+
	 0SytdQqnViGjADNNpWoKNUB6w8RY1UOuXj6Q8LUNvNYvrvK0QwAQligySI3qlsjuia+p4
	 OWzK2gSuU0PzVTBeEhs2TbHCFDF6SouaKd1G5tRWcz083y/0fLLHKI4lNOrZX4ZjR6kif
	 9vnvmBEUTRdRwM8H0eOOD6sqIgyGRzxPjSKokrHAyoLQNf/Ydfak7HsLGfEUdorqJcpIx
	 LuySDAO2rR6WM/1d031ZpG6jzYD7x0hIEz0rWmwOW/Jbky8OKnUmlrtVF6DNTXygxcA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794522231;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=2sUXbcSIBNjYQNcxhwu2DzuLVLkDSq8mcQdg55BwxSw=;
	b=boA3eDNsdhcJwsKu3x6M2EHw0ckXjk2zSLgtxSDiq4mYci7ddYziULpLp6Cmwp4IRomP
	 6kFLLiUMZM75g+4NEwmDeQ2Heo8A0CmQp2GrqiM8LzSTNSZHWlRgvoiREO+ZtVye767GA
	 EO2Ymcs3OJfLsKIIwj7NLbd/sWcaYRARseJA4b31CieVOFwwOb5mlwM4t8JyOeT2rbHXt
	 UYPrQr8weGkeXTs+pc4uRxqtZHCsUJjbwHF+5b6QFBvMVAzUKWb4X1DhS9dQSLN6eurf5
	 MgKeOjIXiOAvU/RrjPRf+ybTMW8XHL9eZtpEZg1UbTLXaQLbYXgjYJuNTePssFn8Alw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KgJXuXLo;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1016606A31C
	for <linux-security-module@vger.kernel.org>; Thu, 12 Nov 2026 22:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KgJXuXLo
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1210E1F000C4
	for <linux-security-module@vger.kernel.org>; Thu, 12 Nov 2026 22:23:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794522231;
	bh=2sUXbcSIBNjYQNcxhwu2DzuLVLkDSq8mcQdg55BwxSw=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=KgJXuXLokL+SIy2qwmf35x7WzstY3MaZ3aFZP0laBRp+RiBg/up8B7hjFN7i+O9ba
	 0hDxnHJzQrxMg1XdCX20K3Yz7oKj/zFTXUfhMieCPvbZvVyOfPpQlUy6/KziC2EWST
	 LxQkwztRGs/W8HIZnTuw7DHyVcLxoemW0PGRHaUnK1nsxtqD0eDw0LDevCIRmnhobr
	 1kpapQplPn19tw416wMV1oCYZRZg/yUDtEkGLvvn2ENfdWwJOSdl3PHSZt6xuGpHTt
	 m/Jfc9AJ1zc1NSCVbaReOvOODOcAs2w79PeN0No40L/iZvRVCCDLFBf17lTzqmI1UV
	 I0jm7+omZTZDQ==
Message-ID: <sashiko-outbox-211912@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10 2/3] capabilities: don't let ptrace borrow
 CAP_SETFCAP
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20261112-b4-setfcap-userns-v10-2-84f6f7faa903@toxicpanda.com>
References: <20261112-b4-setfcap-userns-v10-0-84f6f7faa903@toxicpanda.com>
 <20261112-b4-setfcap-userns-v10-2-84f6f7faa903@toxicpanda.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 12 Nov 2026 22:23:49 +0000
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list

> A uid 0 task that gave up CAP_SETFCAP and CAP_SYS_PTRACE can still
> attach to a task in a user namespace that another root task created,
> and have it write file capabilities for its root user.  For a target in
> a child namespace cap_ptrace_access_check() asks for CAP_SYS_PTRACE over
> that namespace, and cap_capable() grants every capability there to a
> task whose euid owns it, whatever it gave up:
>=20
>   task A: uid 0, full caps          task B: uid 0, no CAP_SETFCAP,
>   unshare(CLONE_NEWUSER)              no CAP_SYS_PTRACE
>                                     ptrace(PTRACE_ATTACH, A)
>                                       euid =3D=3D ns->owner -> allowed
>                                     make A write "0 0 1" to its uid_map,
>                                     or set file capabilities
>=20
> The same goes for /proc/<pid>/mem, process_vm_writev() and
> [ ... ]
>=20
> Suggested-by: Serge Hallyn <serge@hallyn.com>
> Link: https://lore.kernel.org/all/fd159e68-c613-4c7d-bfba-8af0a3f3a96e@ha=
llyn.com/
> Fixes: db2e718a4798 ("capabilities: require CAP_SETFCAP to map uid 0")
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261112-b4-setfcap=
-userns-v10-0-84f6f7faa903@toxicpanda.com?part=3D2

