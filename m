Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792695144;
	b=2OXsG1VIfVcZp5H2nl8+Gmc5cram0x526alHot/7+Fbs/8BMeHwIYsizuLzGf4+2ZKB7
	 UCyYOgUl+utTu4QnxBm+JnASJzSE2hHu4LETCjE0hA6JQMrdn4aMLP9JRh347p3ebTnoS
	 GByRlIjLU4A/ObFiTZQMGAXQN9dkpBh33XRiJHKP5tYY1rH4I3//+1j+d+TORxdhPij98
	 AMol97W1La8y+kYCyCPAPC1M+adm+x8Fs/SjmUX/bwN8yq2cbB5whhCKWGcTGOjs2wYC2
	 lq71I/zjIo4mQ2OwzGLjvE0BuENMsG0Oaauj/BDhT5jTHWTTBfeqmku0zubg9TrMN0g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792695144;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=hAT0GNMXG6m+Mek3nrFSK4GGcj4sZzFhW/dkEnVrDzk=;
	b=VruZ+DzmDGo++joatdJHDdShm3YHiXB8WxJvfjmdzel9f2Qr4DZKv//ZAKx+ZH1t2m2B
	 V3gx+XND+oRrZFHCRT5XhFJ/5BZUZIo4kzMowto1RE9nCLkQ+5Z8VpTAC0s7Yw2249x4M
	 iGYqtne0khUKS9oFzlE52V76hf1AP3shLWJWo72RVAB0DBlVFMQEjW4mBsyelpNgsTKyc
	 TnKb0l8NKrSQRGE0XVSLpchb0MVCdirgvskNF1OOyOvI39Ocx9cZjpLKds5mWiP3n/1CZ
	 6Sr2lv5kGKOXFU5LvpCZb9Mqre1Hft68puNktbAIJGEa7vdQmw5thyadpEhQuIFS4ig==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=grtZdHFK;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B795D606A31A
	for <linux-security-module@vger.kernel.org>; Thu, 22 Oct 2026 18:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=grtZdHFK
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4967E1F01825
	for <linux-security-module@vger.kernel.org>; Thu, 22 Oct 2026 18:52:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792695143;
	bh=hAT0GNMXG6m+Mek3nrFSK4GGcj4sZzFhW/dkEnVrDzk=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=grtZdHFKOmlH/jxRBRD2miP61ygw7Be6+vmM/XU1jsrs/sfe2BDT0e+q8E9E8W967
	 bLr2f3tYOpkdp1c/SSdjTChCZNhVt0k4cKvXQ7iTmyTNKdNDdrokWdH9SOUyjJUFIe
	 alJ36DA8TNeYCKVvffGaGOGSJ1Z2HchmQEgMTwHeBhF9E3upn8nz6Vi/skqL/Xi7nK
	 5eSkClJWZBiZLWYFuPSznQ2+7Vs0vha7WtKH0RD0e4OcrptagMxnuWZxwdcnmhy9K+
	 X1AN+01E0EZdlh/2TINxb22f+cwZ5rdlf34Wsb//smsLGbKwuiDx7ZMc2ZCl0e9WbG
	 RVXFyZLDvnH0A==
Message-ID: <sashiko-outbox-181937@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 5/5] capabilities: don't let ptrace borrow
 CAP_SETFCAP
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20261022-b4-setfcap-userns-v4-5-88aa0ffaa08f@toxicpanda.com>
References: <20261022-b4-setfcap-userns-v4-0-88aa0ffaa08f@toxicpanda.com>
 <20261022-b4-setfcap-userns-v4-5-88aa0ffaa08f@toxicpanda.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 22 Oct 2026 18:52:22 +0000
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261022-b4-setfcap=
-userns-v4-0-88aa0ffaa08f@toxicpanda.com?part=3D5

