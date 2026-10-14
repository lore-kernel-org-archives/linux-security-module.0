Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F09D41F5D7
	for <linux-security-module@vger.kernel.org>; Wed, 14 Oct 2026 20:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792011508; cv=none; b=u3ZkFgRTbgDS4XKHowBZk6eemuu5VfeGZUfhqgFInFB2BH1jM67IlkEVGSAFddLf/KmSM+GcSqUaxhvPXtUAhocsg2Hz+SXur1ysTGp0sSjGJsEDCMsJM8/plwv57OJWLv+5XWHVddtnzvsUmVlK6HclDQEXVKE8fuyYklMJTKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792011508; c=relaxed/simple;
	bh=sarabV8J1cqd6R3UG9N2OYF8JzlIZAiCs79Diby2Yy4=;
	h=Message-ID:From:Subject:Cc:In-Reply-To:References:Content-Type:
	 Date; b=C6ydegfgWm/Jl+FGXlRVFrG/fGRvaSiAcrfXFZx1toaF971dqo7AeEqXPQ1rAdJQl3jTUyOB7RXQICxkUrFWbNzagCaao2/d5wiZqNnu/E1NQyU+OunGkiBJm0YHrXJiTpXTLidloKc0wEMI6KGKpX2iYO6KO0pAkBURuwkTk0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mahwO6Q1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mahwO6Q1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13D491F000C5
	for <linux-security-module@vger.kernel.org>; Wed, 14 Oct 2026 20:58:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792011507;
	bh=JCWQKONarus1X07Bn7L19EoIQZzJ1qp7QLtztocVEwc=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=mahwO6Q1lKE67U77k+w1gqa8RioMBLXflCg0mrINicbyCGcs3Zev5ctdgSanweTPh
	 YD3gzpPSGSRSUnvwMm1jyXLrxImNXiGoMYgqPxsFsW38pJnPtSZYr+WTL/yoOpGesl
	 fui5MA4l4EQZis69l9WEh2kB9v6M0wdvaVNBGLswXquJsRUr9glwMu53zp6t7RlhUD
	 cg5JB7jn5ItjWeOVhjQ46LnLnQSQ+kT6aM92SBDKZQzTJl0C6EcYgVzCZekH5Rdb4+
	 V6lQRAdKeDOHIe3Ih92CaSRXzfPiPqoVvCFOFy/4nCm04dmLtN80oWFEEapuW556we
	 jGREPsZS7KxSQ==
Message-ID: <sashiko-outbox-171919@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/5] userns: don't let setns() lend CAP_SETFCAP
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20261014-b4-setfcap-userns-v2-2-fac4d19281d7@toxicpanda.com>
References: <20261014-b4-setfcap-userns-v2-0-fac4d19281d7@toxicpanda.com>
 <20261014-b4-setfcap-userns-v2-2-fac4d19281d7@toxicpanda.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 14 Oct 2026 20:58:26 +0000
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>

> Mapping uid 0 of the parent into a user namespace requires CAP_SETFCAP,
> because a task in such a namespace can write file capabilities that are
> honoured in the parent.  A task that is already in the namespace has a
> full capability set there and can't be asked any more, so
> verify_root_map() goes by what the creator had, now ns->setfcap_level.
>=20
> But setns() lets other tasks in, and they get the full set as well:
>=20
>   task A: uid 0, full caps          task B: uid 0, no CAP_SETFCAP
>   unshare(CLONE_NEWUSER)
>                                     setns(A's user ns)
>                                       allowed, euid =3D=3D ns->owner
>                                     write "0 0 1" to /proc/self/uid_map
>                                       ns->setfcap_level is A's -> allowed
>=20
> [ ... ]
> unprivileged users joining their own namespaces, are not affected.
>=20
> Fixes: db2e718a4798 ("capabilities: require CAP_SETFCAP to map uid 0")
> Assisted-by: LLM
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261014-b4-setfcap=
-userns-v2-0-fac4d19281d7@toxicpanda.com?part=3D2

