Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795043725;
	b=2N72YNns3WBaLcxiWDBKmQ8hMpfnaGs3ccsUeDnVl3xs+531BO6MvKtWPclVgl+Gc7Ip
	 Ng8qXjJPgkwITvSPNT454o/3WYn/esyOaMtcA17FF2NxDkRkFVTuIK7R7bbwgNMv4aeBM
	 GcDgCVxE3yPKMes1A+UBJQ6UzUJ+KwkfYa/qeEd87RQVmOeWNpzxpFjb5hIZDKBHKIFxu
	 Sdgk7rPguxSz5V9NFMBj43hIoAcQxnVqsHlHh8GQnBjtfdQjqevuGzWrYbu66S/Kug6Yf
	 eLJPZ/3RFCcumHk6abwmZmPdYRvKTzHjt7tmktLyAzEiR2yTrLBzHeXO+lXhC9OS6yQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795043725;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=8pdmIC+c7INMHnvoANO0+K+V8N55CF+7U3yWdwYgZGw=;
	b=qW2Fj4u8u3xFupmQ1wVPtaXJd4iaMnTOIRguAkFK29CLZiTM+f5QFACfKHJgbbpg5LQo
	 h2AJuRpilVKrgnq9Ohr2MvZ8WWFn6WFgKNt4n7zc4XaCpg4yx7CoQH747j7OvpreHmd8c
	 ZPKrxpgRKiIF+S3h0VPj06P6wu+tET54LE5tN8Um1iGXy35B2qLzztVoycOalKoZkB4BK
	 Gl5nKab2WMBS8aDhKqSeafWTWZD3uAGcfCpV+uf3UoELDMJGiaoCZ4Ea5A+tCjLQE2Nft
	 Xpx4fXAMTyYui9J/TmQmLyEVDPFlcy2f5OlzQvgKgwMghK49NboCmHqzQ9l+H+wIjog==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cTIQb8og;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3338606A32C
	for <linux-security-module@vger.kernel.org>; Wed, 18 Nov 2026 23:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cTIQb8og
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D1181F000C4
	for <linux-security-module@vger.kernel.org>; Wed, 18 Nov 2026 23:15:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795043724;
	bh=8pdmIC+c7INMHnvoANO0+K+V8N55CF+7U3yWdwYgZGw=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=cTIQb8ogZksf8fpEvnpxzPci7WXF2vjiDMsIfBZupZtGWFD1Yz9pEghCiWrSELLjn
	 R7sLMZ97AZ4v11LilCybpMFo/dem7nessSiy8RjUV4syN6QoTpWbVtDt7yfKuo27dc
	 lFit/k5pBQ+69Kx6ONB5IPzQRfy8IJq/tWtx7NSTuaCn7k1oclbTKy/lxQ0PZSOS+6
	 J8eqtDMDL48DXCuwvLqThQl89AtMByD7KYzd2HSAwE7+Iqt+oRMb11XzJ3oxm50Yu8
	 zqGCj2GS08H3umNnmxCzwIO9uIYBm4xsrtpKo2N4CmRx9NNLT2ksYzHQ+7mnxnQe9x
	 asrb+gQBXSi3A==
Message-ID: <sashiko-outbox-222164@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v2 10/13] arch: Wire up rootns system calls
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20261117231352.3816603-11-jarkko@kernel.org>
References: <20261117231352.3816603-1-jarkko@kernel.org>
 <20261117231352.3816603-11-jarkko@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 18 Nov 2026 23:15:24 +0000
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list

> Now that the core root namespace lifecycle and VFS mount-tree
> installation are in place, expose rootns_create() (473), rootns_wait()
> (474), and rootns_kill() (475) across all architecture system call
> tables and asm-generic unistd.h.
>=20
> Co-developed-by: David Howells <dhowells@redhat.com>
> Signed-off-by: David Howells <dhowells@redhat.com>
> Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261117231352.3816=
603-1-jarkko@kernel.org?part=3D10

