Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793049653;
	b=tr1cR/JOuQwQYgEtr5cFepRo7T1kfDSdKkKeerKtAFgd3y5nxWcV7JMfQ4rUdKotUB9A
	 iNqa2QYWGCw2ramMgP0n0Qa5ypC0DwgXsNSd5WsKsSvefjS0txICx5OgrlANcTrBOqaGg
	 RyPKtM7osM2PWE4q5N++IM0vFHJlqV5bxYon5eyDTF+hjuQMDA8T6erae3rLYtBc7xNdo
	 wKEwcLNljP1FLUr/L+Ky7y0spA28sfmvj2AnzIE/2sCuSf3de9TCxDFIKneoBMXyxERc0
	 UXnm65phxxrHiOsJjsqPDRyCqsCBaeB6I8nQ0ltxbCBk7/2iC4m+YDO2zmuQKrs295A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793049653;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=bcXNesgTvxs/SrYBh2dWAPauNCM6uDUzRB1TKmBZkzc=;
	b=cor2DTZWlhwGVPdwR96O1DxU/WHWGQmuEXz/XLTSZZssAb43gx72QcNwfteHrUiwzcxx
	 WUiZrjefgdT3A7JZ537mWLDaPfWW022GbgtlFfnxDY1fp82Xj19EQbW/ELRA50HpBoSvx
	 Y7VoyT277eUoAe1eSCf+ezRxUww01Ynw1duJextllUZnyfI/LO6Zi4HESlb8Cqku9sDTR
	 cLOdf1XTU2b5tdbPyt1FsoSp/5zox04srCfPQDnzZJYT5LxkiSHS7shzMfVsTqVfZgXJC
	 wBbkGS/vRVjTzOYQ2nWixu1di8lxTlHF+9JE68ZwyNfFK/rIZQhPKQwGL1HjzFwcqSQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XLhhGAo8;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BD39606A31A
	for <linux-security-module@vger.kernel.org>; Mon, 26 Oct 2026 21:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XLhhGAo8
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CF1C1F01825
	for <linux-security-module@vger.kernel.org>; Mon, 26 Oct 2026 21:20:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793049652;
	bh=bcXNesgTvxs/SrYBh2dWAPauNCM6uDUzRB1TKmBZkzc=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=XLhhGAo8XavG5pBGSXpxuI99NKtEyB/nBLZc4MGKrrZZ9rt/Qs04ptTgicRhZWr5z
	 nghWeLMRtiXugxgGH51TTCNM1voRwPCOV66Vclj66S5fULSSXnAsUG4K/5YZBJ/g3u
	 n77UAAnDnLHG1CYFBHCfoj01WTLgM56C9yelfQWKfF3GvzBpv0lPn3IMaNJlCURGUx
	 0RltTODowIQzg1BJI2ZSbADzlAh0xnrryG748hqgyYWTUIO/BkstUiQElfTmDPqJ67
	 zrZ0dpTaW7Uyn105EfdyXaEFte6Ot9k85vnoxCgpE7Nfr3Nt7BMTNkiw03K/3Pqoyd
	 ecDLbsfsoMyAw==
Message-ID: <sashiko-outbox-185748@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 5/6] capabilities: don't let ptrace borrow
 CAP_SETFCAP
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20261026-b4-setfcap-userns-v7-5-bf8a576f7259@toxicpanda.com>
References: <20261026-b4-setfcap-userns-v7-0-bf8a576f7259@toxicpanda.com>
 <20261026-b4-setfcap-userns-v7-5-bf8a576f7259@toxicpanda.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 26 Oct 2026 21:20:52 +0000
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
-userns-v7-0-bf8a576f7259@toxicpanda.com?part=3D5

