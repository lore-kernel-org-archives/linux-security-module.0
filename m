Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792616106;
	b=w3tuP3jGWPb/qYBKsFN6olHlMUw33SE5hveQwV81WMunJR2lLx/j06OVWnnTUsiuED/w
	 c21NjvW2r4OldvZWgKP/rF6XDnvxrA00Q6gNf90iuWsSujDzC7KhJlSX0rXScGkvOt+Ud
	 agNphC9KKhHxZcVJ0dc/T8Lxlphf8nav7bNb6yHf4A/K3kMy/zO754pVHf3dYjA6jOd7Q
	 s5SKA1iK09vuS8QPiNmC363W293Ahgl30ce+AeXHE384NLmClVFWeWv0l2g+vJtfkSAzd
	 E2XYAu4AJdqYgq5tpEvHTSMOlBhaxL8FeZFRZbu7Vm/xpp6K3/51PmKqokDLv45/LwQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792616106;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=4cr6uX2Rv7bft7IHV1dl1H05Ou7JKtzOItiMmkHQPDo=;
	b=OtCqK2WMZyxOrB4vvxZ9+sk0+EF+iJwkvSFdEM1VhE8uamKBQxbagZrwktVx0SFFdTam
	 0PmqIaspcDDUhaxeAbWv/CaEmqC97nkAjcCr4UDLrreG53ClZL+kwovAJs7RCnL2ZLgde
	 rRBmxYqP4pcccIFVnaDzrIPwfWwDSkP+U88Kf5pfxEERianNavQtXzKpy64nfYDvzFjXz
	 nSY+A0/1vQSmkTnMfKiSZn3tt0RQ+xZ/Tjtvk4H7kqTUakgKpqvMSDoFN1lwtM7Fv93IL
	 htgDaATQojXNivmrh5OCG6Dl5Nu/efzt65NyFc9sZ3stSAd74cWyimPuTriL/bB0MfA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Fcw14BXK;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C526D606A31A
	for <linux-security-module@vger.kernel.org>; Wed, 21 Oct 2026 20:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Fcw14BXK
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B7B61F000C1
	for <linux-security-module@vger.kernel.org>; Wed, 21 Oct 2026 20:55:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792616105;
	bh=4cr6uX2Rv7bft7IHV1dl1H05Ou7JKtzOItiMmkHQPDo=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=Fcw14BXKT/HUV22sqJ8O8blXFIlCY0SQWIa2YmFHyfNPeXy1NdB0ZYfokHf47Isnj
	 QZTZtWyWLLzWCj23HdXAk5/mtHBNdRVdTml9BU9oe65SudYxovB9sQoxq72ALtvHD0
	 D5vwk10Bjox+41D3lfGhx1zXS2EqUvOcCHT/cM3uoyifp7XsMNWnVw6jRIrVULw5uN
	 XHMbZtJHujVy0Mq6BjyFamf0ySh/m2SvTmNNrXSqeEIpmQcjK2xXTwpsDl5G6LW6+B
	 dla+hQpEGdxK3ZimUu2Ub+CcWAkC3Nvkt38AUh4799nnCZLRsMj5KaTVgn47WAj3MF
	 noVTjZuSREq8w==
Message-ID: <sashiko-outbox-180662@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 5/5] capabilities: don't let ptrace borrow
 CAP_SETFCAP
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20261021-b4-setfcap-userns-v3-5-97c7ed4e43e1@toxicpanda.com>
References: <20261021-b4-setfcap-userns-v3-0-97c7ed4e43e1@toxicpanda.com>
 <20261021-b4-setfcap-userns-v3-5-97c7ed4e43e1@toxicpanda.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 21 Oct 2026 20:55:04 +0000
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261021-b4-setfcap=
-userns-v3-0-97c7ed4e43e1@toxicpanda.com?part=3D5

