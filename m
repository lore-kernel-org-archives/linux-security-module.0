Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0880039C63E
	for <linux-security-module@vger.kernel.org>; Thu,  8 Oct 2026 14:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791470126; cv=none; b=Wuuvg8RJZcorWqvNFC6E9A2V8kXrQBfmuqk3BQHEPCHnTS5twIRfcNPht8mKKnO4EFO2rMPn1droClAE0Nobxr9gfjBs6MkSoNIWVXhPg3Zz03sEaR+AbikoX3N2kJIVbVnIvNXY3GHpz39cFdK3GjHlw/UrszJ2ObFHQL69VrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791470126; c=relaxed/simple;
	bh=t9Y6EFekpTvOvuJ3zF8kMa+Us+7yuhVclUeEo3UvDd0=;
	h=Message-ID:From:Subject:Cc:In-Reply-To:References:Content-Type:
	 Date; b=GQjVo+RPnt4VYeApDvTrZb1AEzUEKtH0XlHJrFgGU8lQHpFTs6zucJd9Ie0RcMPG7kL2/FNYYK9puNx27TWZahs4G7Dte08KV6jXncYmkriNPXLY5tzZGNlwm0Vk8UnjdXK5FZwopVXajqISGFwRJhGyZWBbPUJPkXNXDBrqltA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nqRcgOMG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nqRcgOMG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96DB41F000FF
	for <linux-security-module@vger.kernel.org>; Thu,  8 Oct 2026 14:35:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791470125;
	bh=c2F5SP4fO7XDTdLXTazUBCu5l5dsqH3NBMQTM/K0rGA=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=nqRcgOMGsUTRuxNLBisL9zZN+i75+3VRJtiWuTYkklP4e8vfM7m3/wnWWEZQJyFEv
	 8JF+KS/mCnCkU4hOwEt35/gK0TW11K6E7eQYhhLdOwkAWGrq/8tb0pBMfoMrr75EWa
	 Woqga3zFCCuG4so6Mw9DrhipBmJKlZrECXZ+dD9fsLWifL0DKEgn3O35Qh4P0xQ2xh
	 h5prMuMs9XgLL889MqSH9iMDpyEYgyuTzLzQXGhnD+u6X/L2vIfR2NqRHMRyQAQCfm
	 cd6JDnM+T4/YPtVN0c5KAC7l4M1CmwWGSJGryJl48tI5a+QGc8zF8gz0/0C9B+0m9X
	 J9iV9pNWgyqMw==
Message-ID: <sashiko-outbox-164302@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 02/27] selftests/landlock: Propagate EXPECT failures
 from forked children
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20261008142604.39107-4-gnoack3000@gmail.com>
References: <20261008142604.39107-2-gnoack3000@gmail.com>
 <20261008142604.39107-4-gnoack3000@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 08 Oct 2026 14:35:25 +0000
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>

> A failed ASSERT in a forked child calls abort(), so the parent sees
> the child die from a signal and the test fails.  A failed EXPECT only
> sets _metadata->exit_code, and a child that exits with a fixed status
> of 0 hides that failure from the parent.  The child in
> trace_fown.deny_scope_fown has this problem.
>=20
> Exit with _metadata->exit_code in that child.  Do the same in the
> audit.log_subdomains_off_fork children.  They only use ASSERT for now,
> but this keeps them correct when a check becomes an EXPECT.
>=20
> Assisted-by: LLM
> Signed-off-by: G=C3=BCnther Noack <gnoack3000@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261008142604.3910=
7-2-gnoack3000@gmail.com?part=3D2

