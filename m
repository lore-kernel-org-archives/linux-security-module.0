Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794822814;
	b=YLhvqEBhSxPt9AwGDJqjv3QqJIfTHmEwgg0nUeS7ld1sZP/U36Fib5N3XeUdpEmBl/Uw
	 nPt3blD4VP40Q31zbEnzcfcaE0CCfiwiaR2uEtUELO4MHeTAFNmiEPmQgCOtMkvlYhWK4
	 YjBvL4cvfKqgY/e7rzTQnqF6wZqrEw6Lp1OhWj4ghw/xswAzWrwY4khs2QwSo9Pc2Pzf2
	 V2ZoFw4DD1jHdfAqReUeF6qAfSjn41HVeqTaaTlf4ZX3ATv1AgcyXSesv6ZTLFBBICgmT
	 VWabiQJcnov43l22AJiGzSWSQ84cBfuNjpgTFUbTHYcHlG07boCcc3vQWhk97OuV/Hg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794822814;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=ThF1MEPM1yDYP4cd6BZps6Yaa24v7c0lGg+zlHHcuC4=;
	b=v6V3g10w1X5NrxtD8s4FplVwPZveBSX+qa8iyKaBgaFDIjVLAYMwwWpi7cPWMi7Yz5Q+
	 6bO255irSLvk1Z9noUcTz6Cyt2Hx6ClWloxwbpCCbuIn+5gj9UJKiJkfDsWXKBy3oI13L
	 2qiHlyzNYcQmHu+hrBYJZhSs5bLMyqrnGHZEvM7pRcK1OFDALoCm5Z6L9bp/W6njZGABR
	 vyCsNrvB87HYNFtyRageNyld8rJDSy+TXHRXhmXGkI0kojaFpyDDcu3gEYk1hJolsIPQV
	 zIbzX0RjDnOny0Pvnc8bx7mKHr8Gg71mkLA3+NuEIpCXBvXIxbJVBeWekrS/iuk3M6A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TBV3hm9f;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8498606A31C
	for <linux-security-module@vger.kernel.org>; Mon, 16 Nov 2026 09:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TBV3hm9f
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 884821F000C5
	for <linux-security-module@vger.kernel.org>; Mon, 16 Nov 2026 09:53:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794822813;
	bh=ThF1MEPM1yDYP4cd6BZps6Yaa24v7c0lGg+zlHHcuC4=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=TBV3hm9fnvcR54qumhcoamDw0ukShhIe/CDkvoR6V4Qz17eido6QnTPu956fjrXYv
	 gLG9GmPo3qsa8vfuImcp692P3cGjJLfi7LUVuvqOsHjn0Zf4Qg/P4hkgOiw/Rv6wD0
	 66SJEJQ2jTzJzbAzo2md8YNimydp3uW2imi3zFuTbtI0INrLOQuEY9GdcnmeqXsO3z
	 DXAcryVmNUXLfSeeF/y9v3rtSCyargIPesz3E8gu370ijdJh68XlWqwQiiL12Cw5Eh
	 sGU1XKoS4IgpMsUCyRWIk498vlN+byZE8OmBk3xDinwHLQEdfheqhZ1uwkbrXbDiCX
	 5/EFsmItUNF+g==
Message-ID: <sashiko-outbox-216664@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 03/13] tracing/uprobes: handle errors from resolving
 the real inode
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20261116-work-ovl-d_real-v2-3-90564c4ae347@kernel.org>
References: <20261116-work-ovl-d_real-v2-0-90564c4ae347@kernel.org>
 <20261116-work-ovl-d_real-v2-3-90564c4ae347@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 16 Nov 2026 09:53:32 +0000
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261116-work-ovl-d=
_real-v2-0-90564c4ae347@kernel.org?part=3D3

