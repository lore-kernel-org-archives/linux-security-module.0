Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC9CB360745
	for <linux-security-module@vger.kernel.org>; Tue,  6 Oct 2026 15:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791302100; cv=none; b=Pu39ciY+u1xjlTUV1nsCtWegGwUm+u1OKCr6VLw1w417pViX1dhCm0NuMMnj6RkVri7he26zmqfQiBKFE9rd15ilZm+Di0vsE/Axl14L246M4eBEJ3H0ifH6/FGXSKKKw6E+8APlvQ8Qu4M0sZB3umcWr8cAw1g4EPRYhA3vHoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791302100; c=relaxed/simple;
	bh=dnwE52vCduM+5nk0cPusUnbs8lidEb5O0Y2mhli1wQM=;
	h=From:Subject:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=q2Nr7u2+G2ktfvg1LMnPx9zvtuYOojmvqvoLYTq+k0itQvxXnA4nv7lawhbzTnueKBNLc0HDZkEgOMEeDbH2bD0+zDM+3vGZ40I72+KpvDz+44fMYt7cN2gkMygKvfTSjNChbJz5JkVS1mNMR5TyiOgdhiqsszr4toeZsi9ZfJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ogRS2wSx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ogRS2wSx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B78CF1F0089B
	for <linux-security-module@vger.kernel.org>; Tue,  6 Oct 2026 15:54:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791302099;
	bh=i0PlFfbp/uZS0x3ZAZ2YtqJGjBVUqnkeJDNReEJLpOM=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=ogRS2wSx7KesPAw8W0xL4m4W+sQ5bEt4LCm5ZLTbntT7pR+EFuxAWVoOAX6Ak5Y6Y
	 wueTE0RnDkwPuuYhU9L0ybOZSOpUKCr+CU7/Xn8WTgkgZwIAKTmYQn9ND65+EtFKMr
	 1LJ/ANsRFQsuWwVLW3Izx5SOSn/A+xapSSUA3zV/UUJ5qgzQJhcMElm4DcTM0qWlEu
	 vht3gaE9Q+wdvGaR50tjmAkf3XIEeR1cX7enPrJgSIbwMeidCROC5Nt1+MqhWcYpwu
	 NSEHcuDFrvBA4elz7dPcMJyRu9LLb4Iq0bn6sRzaTbNmQDz53c5+DJKgoIt7j0HJlk
	 aFjaYJyUM3Geg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/5] userns: don't let setns() lend the right to map uid
 0
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20261006-b4-setfcap-userns-v1-2-f47e7ed66072@toxicpanda.com>
References: <20261006-b4-setfcap-userns-v1-0-f47e7ed66072@toxicpanda.com>
 <20261006-b4-setfcap-userns-v1-2-f47e7ed66072@toxicpanda.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 06 Oct 2026 15:54:59 +0000
Message-Id: <20261006155459.B78CF1F0089B@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>

> Mapping uid 0 of the parent into a user namespace requires CAP_SETFCAP,
> because a task in such a namespace can write file capabilities that are
> honoured in the parent.  For a writer that already sits in the new
> namespace nothing can be read from its capability sets any more, so
> create_user_ns() records in ns->parent_could_setfcap whether the creator
> had the capability and verify_root_map() trusts that.
>=20
> The flag describes the creator, but it is applied to whoever opens
> /proc/self/uid_map from inside the namespace, and setns() lets other
> tasks in:
>=20
>   task A: uid 0, full caps          task B: uid 0, no CAP_SETFCAP
>   unshare(CLONE_NEWUSER)
>     ns->parent_could_setfcap =3D 1
>                                     setns(A's user ns)
> [ ... ]
> nesting namespaces below one of their own are not affected.
>=20
> Fixes: db2e718a4798 ("capabilities: require CAP_SETFCAP to map uid 0")
> Assisted-by: LLM
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261006-b4-setfcap=
-userns-v1-0-f47e7ed66072@toxicpanda.com?part=3D2

