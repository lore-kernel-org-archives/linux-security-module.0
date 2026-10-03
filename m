Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45BFF4207A
	for <linux-security-module@vger.kernel.org>; Sat,  3 Oct 2026 02:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790996342; cv=none; b=c53bosTTLqPopXB5inDJEm1WzwzP3SviQfYgy3U8mh+wEvhCP5d5KOWuvpszb6lf3/Uoscv0P3E/c/LzJpwIoto0o0kIzx1LpvKUDKswvsn02eUCEB+knO+OX8vx9wOk/Fo+L10TuR/wjhER31AjEa0k4eZQH9V6NDcdnxIEceg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790996342; c=relaxed/simple;
	bh=qby5SNiyELrxy2qGvxFdUr5D2c2mWUm4Pfuz2P+SUP4=;
	h=From:Subject:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Hl93aTSX2Sp2R6UR1XI5RZOgUXY2fuc3nTbsSBfbjFgjRkNbHGFGpI3NuLUhUlPLUCYgrbEXxmzDOjc0Mqk6cw8Rx0Lmmzl9CsG9s7sF8QUqRMMheefpUUdErmbSXb9redG8SHLzJYm+Q4JtUTBKx3DTxCe1iWt1rFvn56q32yg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oBgyTi1E; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oBgyTi1E"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA0D21F000FF
	for <linux-security-module@vger.kernel.org>; Sat,  3 Oct 2026 02:59:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790996341;
	bh=qby5SNiyELrxy2qGvxFdUr5D2c2mWUm4Pfuz2P+SUP4=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=oBgyTi1Ez/3WsD58c7zyQ2hS1SfapJ50ryDNxv5rgPMfxwrboV5Nf13hSoAl+WjbX
	 eOueOZJxX2DOEbmWEAMPfWZ1H2G0MrjRBwjLNLItOG1oynhymZMBuU2r79MkXqzosU
	 onHZo7ApVGsL/L7VpVIcqcuiKz5LguwtYBAK0J8ahnbc3hIfMmsO3skrZw1BTublSR
	 jqDLjeqN2guIFBxSacjoPinkqg0UgBhR2kPgMJKfGvM93uHfAu81TwzQcfdDJTQw3j
	 PM6O7j/ze8UNeRxVJV5wfXryiQTEfoB1bVu8Nh5B7zyQtqGF8OTAvJT3k9mQVLhUMo
	 bXwbRgC3obTuA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/6] ipe: use designated initializers for audit name
 tables
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20261003025135.3666767-3-wufan@kernel.org>
References: <20261003025135.3666767-1-wufan@kernel.org>
 <20261003025135.3666767-3-wufan@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 03 Oct 2026 02:59:00 +0000
Message-Id: <20261003025900.CA0D21F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>

> The audit name tables are indexed by enum values but initialized
> positionally. Adding an enum value in the middle can associate the
> following names with the wrong values.
>=20
> Use designated initializers to bind each name to its enum value.
>=20
> No functional changes.
>=20
> Assisted-by: LLM
> Signed-off-by: Fan Wu <wufan@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261003025135.3666=
767-1-wufan@kernel.org?part=3D2

