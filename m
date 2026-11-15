Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794751639;
	b=UlIr6BDAzrNC4kwpsXi3l4YXAIC2oYE7okupQ6N3pyDett3a5FThx9LyJytonbaISx+R
	 ANTDYx01eCahAbsCzGMOj2X6iX974O5/QW7GkS9VxrCdFzWDtQffGMXJ/yzRl5iDkCglj
	 X9+bbp4mE+KiOQYw5aAFdGXI3cO/7zNWuQ+vzAHiPq1YTqqZoX0okqhMctzuiMxBfmtj2
	 WhHWih/IIKDqVPvTa8qFCh/02dTUpkZiUbJQ3vzmprW1lM3/lQKkuA8RRLgbFD+pdcs1/
	 dUtliYLIH1n3E4MmGb4jdJv4mRgKgsn1rWxXrrapXLqPyI0kQOZRkmcU0jVbkojOhww==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794751639;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=mle4fkTHwOr6Bfzt5dOganiBb84EJpCL5Bebj3hPizw=;
	b=j9OjJk8UYhyB+ipiLjT34woY5MwHI8L3zjssqj3h8xxqO+mxRq1dNZOdhrw5DKtw1A9z
	 UD+foYfXm/W0M2pPNwXlZLt5NUTdo+1cKuIVlsjXOOlmmgZb1wcoPjUf8lJjET8kkdR2y
	 ++jm/2hYFNboor7ZAEZMgElAVl6+zuWKoXEWxtaR/eDTWUlM4KCVhKopXNpOT3mSE21wp
	 cQWz3OW2wHPIWY9YuRl4PgH+GSmnFX/olYF5eBS+55extm2RhPT8RmciW1QvWrrgnkG3X
	 slUtkxvCHAidxb7HS8S+TSSjv+SASpBUzonkZ/sC8hJab1DPPj9aBnUciCPulvwoszQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=E5+c0hsR;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D46D606A31E
	for <linux-security-module@vger.kernel.org>; Sun, 15 Nov 2026 14:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=E5+c0hsR
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 143941F000C4
	for <linux-security-module@vger.kernel.org>; Sun, 15 Nov 2026 14:07:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794751639;
	bh=mle4fkTHwOr6Bfzt5dOganiBb84EJpCL5Bebj3hPizw=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=E5+c0hsRazN9ynDDuLYIsm3VL8/IsoaR2udbLTZPDXi62mEbQFKeDK0LWHUP8Xq6W
	 YD5E4gScqQ/U40WTX+bfBnyYGsszP7Ez5DqibJRzRmCkNPTaQlCZ9gYc/nFHaS01GO
	 UdcrqzLn1kydZR4CIJEq6q+mIEpoOpF7QZAuqNMePgqgugxNjGmPXtzoOqn2elftDX
	 m9geKyJl3bqSOKRg5nBBpBw/XL96YdNzzmDqe4yaxtdJpDEo02dkX79Jar9v8gq3GZ
	 z8Ta288NY7HqudBUAshR8pQzVAEnGiauGvJc4OSjn65On7Y//vmzjyleMCituB1xxt
	 ep2Pns0PEeDIw==
Message-ID: <sashiko-outbox-215561@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 03/13] tracing/uprobes: handle errors from resolving the
 real inode
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20261115-work-ovl-d_real-v1-3-ca155efbcb2e@kernel.org>
References: <20261115-work-ovl-d_real-v1-0-ca155efbcb2e@kernel.org>
 <20261115-work-ovl-d_real-v1-3-ca155efbcb2e@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 15 Nov 2026 14:07:18 +0000
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list

> d_real() is about to be able to fail for D_REAL_DATA. So switch
> trace_uprobe from d_real_inode() to d_real_data_inode() and deal with
> the error.
>=20
> Currently, nothing checks whether the data can be resolved when a uprobe
> is created. The first resolution happens in validate_ref_ctr_offset()
> under event_mutex and the last one when the event is enabled. If the
> data of a metacopy file in an overlayfs data-only layer can't be found
> the event is created just fine and enabling it fails later with an -EIO
> from uprobe_register() because the overlayfs inode has no
> ->read_folio().
>=20
> Instead, resolve the inode hosting the data once in
> __trace_uprobe_create() right after kern_path(). That happens outside
> of event_mutex and if it fails the write to uprobe_events or
> [ ... ]
> for uprobes created through tracefs.
>=20
> This is a no-op until d_real() can actually fail.
>=20
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261115-work-ovl-d=
_real-v1-0-ca155efbcb2e@kernel.org?part=3D3

