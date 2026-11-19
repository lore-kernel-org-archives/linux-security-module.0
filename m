Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795117022;
	b=pdiKKFYfZyQHImRZJ7+a1shDiudQ9dgjiXocMkFvzK5S32p8Sp77QBHotj2K7sYYp2zm
	 Cm1MHpoEQRRNDfgJm54iCzliRXtBulNw3qLYl16O68NJQ1UYCwXs7R1fgTilmXAZcHR31
	 sXs1Pt3lmHDpjz3EiM0aTTlQMdaFtYwDqhmrsfBp10J+TZA1p9KCm7tzk/Os+lMSx71Ok
	 9aCC0C4OiyqsP2cnqG7B3AWxllvt6dloNuOnZdp44cqLmAWyBd1b6kJZ4A0/S4NfTG9+0
	 qdBVlEXpbe2cLXQltKeaq2IZRS/xNuvrlO1pv/J7UH/hbdl6iyxSjxUnap+RAKXJtTQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795117022;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=uIf8JVqfXCrCqU5TWMNkdcgKO/4LXBlFyneyS1Kp8eE=;
	b=aSVQ5kZmajY6QqM0121SdSNz2zo71b32NJRNU75jpQo9bWWx7MtnRJP4Pi1xpOIe9uEG
	 uLXSnheRwnYgGbYXaTFYkVDzTKWwuDBCm1uIFsJD3fCiYWuEhVaNW5TdriNAWh/GM52m/
	 MUngjoJbQzAMPz83ZOHMnTH5QxIMuqsomA8lMDtbjiVneKtpnEJ5HfvwaiajBa3VQ4aht
	 D2DTugSTPYitx0EOym7/YyOT1BTR78L/F2I1Tqz9kAUIhVl5/P2ELGkfbKgrS7OQZ43L4
	 DJyUSij6EptpDTEwhbxKoTzGZyijF/3IjREsfVhHyqoddBh/BqnALt2TfUiY/JVsqkw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=D+kAAgGb;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CECE60A2609
	for <linux-security-module@vger.kernel.org>; Thu, 19 Nov 2026 19:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=D+kAAgGb
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B6281F000CC
	for <linux-security-module@vger.kernel.org>; Thu, 19 Nov 2026 19:37:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795117022;
	bh=uIf8JVqfXCrCqU5TWMNkdcgKO/4LXBlFyneyS1Kp8eE=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=D+kAAgGbX6QBgb5i92dEUMy8zUl8I+ogp1cQi59FNJnCByUwt30NU7tNaV+TMZKML
	 1DIgmVpS/+B/KvrgGJKR1UG11cB+KRqOMHxR1fGL+YOMw0yq4QK3HPBppll6cLl/Cp
	 8cOurj21chJM6b6fshHse2sE7AV1k3RpaQ4gKxP2lYe1tXptI4BvgsrWOoW3FHI3ZQ
	 iGSb/vBR5FetHBXPyGyRHYHjWpHHsX0Ps/IKmC4sc9ol7RBGP9ZoXwsszlPKZdCrIh
	 iBL0TzZohsT5yM/G0V/8uu7TcsHtxyBWe1B8v2kwVFgZQTBqVySqXBDS/sLBso6x//
	 FaCUA8UdgNVWQ==
Message-ID: <sashiko-outbox-223952@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v3 10/13] arch: Wire up rootns system calls
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20261118193539.240065-11-jarkko@kernel.org>
References: <20261118193539.240065-1-jarkko@kernel.org>
 <20261118193539.240065-11-jarkko@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 19 Nov 2026 19:37:01 +0000
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261118193539.2400=
65-1-jarkko@kernel.org?part=3D10

