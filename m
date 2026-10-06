Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27D8C1E505;
	Tue,  6 Oct 2026 00:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791246451; cv=none; b=tmUNZEqUw9BTlleJjYtAC8DoIdRNoKlEGhfMM58x7j0lGJwJHvRZCfXDu/Ee3ShDFmnorO18FvDOXjFn6I5iZ9RRjyLDJuBZ6cBumUYN0WWIdDDHeGWgFAIeyA2z+YTbpb6Tuzc6SFf+areSEkcQmql+/iQjs1//epNrj7x7fAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791246451; c=relaxed/simple;
	bh=caFmVMJpqCRNDidzEzkGMEOC+jc6KdWdhFAt4cBrji8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=QzFzImBnFGuK9dVL2DgZdQJg4zJAC/Zjn679CplAuirZNeiNZCWjX2UUJpA/okU8x6ledUfHC+xxQzTMr5JPcyZ8vU6puFoJ3grAkEJ88q0QQiqjfPYbc4k3heDNbabaqnCVVDNW1Brh+SkAk7PMTCDFUlGLg5ElqdHlrAIlZr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BiCXQB+H; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BiCXQB+H"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77E2D1F000FF;
	Tue,  6 Oct 2026 00:27:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791246449;
	bh=b/9XzCSdZavpQvAo0YZE7rExkW66rdgnPRoOiZPrJY8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=BiCXQB+HAQwpzEW8O5AZv6M/7rC1bhdKPxnHasmr1P/mxHwfzMwASSCzj5LmbWaP7
	 9ijx7g6Xfk20crausmha2zylHJCwicfbsgoHzYTn/moVqBr26ExnfZXITsls2b/KNa
	 Fyu6v3Z+l6QvfAySp+++yWxF2sww96A2kXNm9DKb9AzaE1LuVsVzzgIDlguNKdwlqK
	 XbKbgPIwttqfciDxH/5t/ToyxKyW0Bil6Dg+QPYpW2VGoZ5b0rSOH9vfMbNBDrljso
	 jf7gxfR937kAAJGx6wWlgbO9YFVe2VAFRBPZwak11fFl8shtlbThtqm0HOFRBOrLVu
	 s2bFbpgVHsiEw==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH bpf-next 01/12] namei: introduce
 __path_walk_parent()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Justin Suess" <utilityemal77@gmail.com>
Cc: bpf@vger.kernel.org, linux-security-module@vger.kernel.org
In-Reply-To: <20261006002020.2890858-2-utilityemal77@gmail.com>
References: <20261006002020.2890858-1-utilityemal77@gmail.com>
 <20261006002020.2890858-2-utilityemal77@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 06 Oct 2026 00:27:29 +0000
Message-Id: <20261006002729.77E2D1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>

> From: Song Liu <song@kernel.org>
>=20
> Factor the step-to-parent logic out of follow_dotdot() into
> __path_walk_parent(), which walks a plain struct path to its parent,
> crossing mount trees via choose_mountpoint().
>=20
> This will be used by a VFS ancestor walker serving landlock and BPF.
>=20
> Suggested-by: Neil Brown <neil@brown.name>
> Signed-off-by: Song Liu <song@kernel.org>
> [justin: rebased, kept the helper static to namei.c, dropped the
>  path_walk_parent() wrapper and the namei.h export]
> Signed-off-by: Justin Suess <utilityemal77@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261006002020.2890=
858-1-utilityemal77@gmail.com?part=3D1

