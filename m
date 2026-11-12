Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794505202;
	b=bNbSEczNg/Gk9yyDFkL6XXKKTsQOlmg/LODcjX4UpBrIYagfvQX4TyxPYVAJfoGbFLTS
	 OG2c8r8Tg08yTstQi0qHXP9Act3HHJ7JqIDvUs0Gk156lvY2+YDdK3EP0l4/Of27Mtcha
	 dBdqxeQSema/fS9UjzSCrR0/7X+UXTPe66eVRY+jR3vJpt2fTtt882yGEngjTQqbwUbsY
	 6RZ4Sw9NUDftzQQue50I7kHeUaKrozaT2ce25uO0ZnsEbtURMgDlY+o8RcjwkT1LW0CM7
	 PaZD5og5SIQsDiliYF6UKTZpwFbmyVMaUu6sI70OcBz4Cn6JVQ7q5D/Pne/N43eFPYA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794505202;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=sLnDVXVjRJ7so3dsF80tdrQnGNyLD9hcR3AhHC65nYA=;
	b=wXGSBrpRB1RVbQjRWBc10HzytDNEria6pPdG75IXtt4Zh67+ceHHDhCLiAvMzW31DWqq
	 hNMNUGH9OQ3q0rHv1hjvljKQ+zc949HWyt2SUiQ1EUH6D1sWqmdwjUUt3JgQ8P/wSW0Aj
	 Q5Nkks3/qAbtWy+crqZDyFU4K7IkY/WyQl5mICPQM+cH/1wuAK0l/sCTTlBk/a3rZ3C78
	 Csm+cBSvWSG9F994R7l7HFuB+zeX2SRU3NAVbDuF8MHHDn+vrlom3lBBYjMwMB+05FZc2
	 0Pfb2kZqjT46SRhieo1XnI7Q0GU7JREMhJHe5EO1nKnFoF8VtQPUVDEG4dzfBuObwig==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EL0LUO2u;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09DD1606A33E
	for <linux-security-module@vger.kernel.org>; Thu, 12 Nov 2026 17:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EL0LUO2u
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71EFB1F000C4
	for <linux-security-module@vger.kernel.org>; Thu, 12 Nov 2026 17:40:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794505201;
	bh=sLnDVXVjRJ7so3dsF80tdrQnGNyLD9hcR3AhHC65nYA=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=EL0LUO2u5Jw7cauGuCZomfLuFj7m0qgnShLabBd4/kAVm9ezrGpVJMSpoQjVG69rS
	 tMplTZQ2+IOLLR7ztWYTDz4wqMVmFOBdFqqCmE1bVAPoVGg9lJzQ0Db0MQ+fyQfI83
	 4fyqQ8cr/JWgv6nwWrjiGNIE8hb63xfVwueFUfUkqIUyl9eQwzkJy3ENby15EZ0Fuy
	 +XbxkwTVTwiQKXND4h0aOnfoxKwwKd5IQMUyCHD5Y5n3EfjSUq8/FPl2xo65clPx1x
	 dVCsqmKN2DvPKub3SG7iN8FpcM639l9ZwRuWRSCtBuRrelugGUjGdbp2WYft1yFvmE
	 8Ck/NNgOZbDHg==
Message-ID: <sashiko-outbox-211615@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] security: update lockdown_reasons[] reference
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <3283a389cc21862ab98eb891436568fc1d23b869.1794505077.git.baruch@tkos.co.il>
References: <3283a389cc21862ab98eb891436568fc1d23b869.1794505077.git.baruch@tkos.co.il>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 12 Nov 2026 17:40:01 +0000
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list

> Commit 59438b46471ae6 ("security,lockdown,selinux: implement SELinux
> lockdown") moved lockdown_reasons[] from security/lockdown/lockdown.c to
> security/security.c. Update the documentation comment to match.
>=20
> Fixes: 59438b46471ae6 ("security,lockdown,selinux: implement SELinux lock=
down")
> Signed-off-by: Baruch Siach <baruch@tkos.co.il>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/3283a389cc21862ab98=
eb891436568fc1d23b869.1794505077.git.baruch@tkos.co.il?part=3D1

