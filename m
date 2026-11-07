Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794066959;
	b=37f+Y3opasAUXMW2mMm0FuWxbkog80m85+t/7ayCERVF7l619KnGzY8XGska2quq+EYz
	 LqzvqSbqcsm+3nXFWEdF4Vc3uXtfu0AzfDEJmZ86skovrMZFlzcf3915V1OiHHIh/bDcu
	 cOb0Z8p84fxC5fM+PW1ykeQ9PRSR0VA05AmDKGGaOmf8oesafZvHt9fub8IglLh4MBF4h
	 ByM0VfpobhZzaCC2y/AM4fc2yIosqDwmOKowwSQw/0r26mSfUkerWvEPFH4B2IvwQoVDs
	 AK6AK4inQ4q1OZr+ImqXywq//lSRXVsfkp9SuWqTMvcUZe2dRAr9uMBlWxYa03fON1g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794066959;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=83h62mGO7UoY2PmdY1QMZ35Sjt1U6B+DnOerehftN6k=;
	b=iY2ua6P0TYp0+W5zQYY9V3n55FhgXaUxUj6wQgCrqHxlrqc0dMnFJuYt55h+C0pP4dWX
	 RFRKQZSsQIygjWI9KnuSWo6l3moPtWjoasklBZU6CY+mCotH6/a39RXZhjeJAo7AW0/ON
	 cpFE76qMQLI2BvXEKH9XQv/jQJiitudkM9LdaumRaA/dwZWMljIAAS4HNaI5zlrFQVbAv
	 qrwuictDGYAdhGaAjdDSoWYmkU5gV7Je+lyfLX2SrDTF50B+X5xKnHdQL1F6znrrK3Qf6
	 uvNp4CDc+q17A512HZAbPReKpPbwSxkwrvkyAlWwzYJHHnZjMu6LA/OwFEPFNd1aQ6w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=g+d7P8uD;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68758606A326
	for <linux-security-module@vger.kernel.org>; Sat,  7 Nov 2026 15:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=g+d7P8uD
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CAE861F0089F
	for <linux-security-module@vger.kernel.org>; Sat,  7 Nov 2026 15:55:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794066958;
	bh=83h62mGO7UoY2PmdY1QMZ35Sjt1U6B+DnOerehftN6k=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=g+d7P8uDHtQ13HIN4ejW8oVK4WKOUiE6Exe85fYcFah2FH6ae6CZ0k1OqLAU/tegZ
	 WcwG9R0VZHSI2aqClJqSZr5roHxWZeRHXIKRwwwNEwT8342Vlu679+WU/XXIK9Fr85
	 hbGimPiBR42FmY73fHi+qT4Qz/KwXzzfReY2tnhFtAHKoWtE1NXr1Nfm6k0XRgMyET
	 I5esqB18uwozC4unrCkK/TIlk1USqv7f9lJHoOz88b0F2zM/0BiyYmZkcjjDsvZrb/
	 Z9rsIwIMZCQvP+Ruo8B3vvLjZ6hpWE5yFxnhezs4XMejyXLHDgHbKIRQfbXaVZfK4l
	 G5lS6gB5ZaLzA==
Message-ID: <sashiko-outbox-203000@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 2/2] fcntl: recheck signal permissions before
 falling back to SIGIO
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <4C916018FDDAFB60+20261107154928.3519030-3-shilc2025@mail.sustech.edu.cn>
References: <20261107154928.3519030-1-shilc2025@mail.sustech.edu.cn>
 <4C916018FDDAFB60+20261107154928.3519030-3-shilc2025@mail.sustech.edu.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 07 Nov 2026 15:55:58 +0000
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list

> F_SETSIG allows a file owner to request a signal other than SIGIO.
> send_sigio_to_task() checks permission for the configured signal, but
> if queuing fails, it falls back to SIGIO without checking permission
> for the fallback. Permission for the configured signal does not imply
> permission for SIGIO.
>=20
> Recheck permission before falling back from a different signal to
> SIGIO. Keep the existing behavior when SIGIO itself has already been
> checked.
>=20
> This was reproduced on x86-64 QEMU/KVM with AppArmor file signal
> mediation added: a recipient allowed a real-time signal but denied
> SIGIO reception and set RLIMIT_SIGPENDING to zero. Queuing the
> real-time signal failed, and the denied SIGIO was delivered. With this
> change, the fallback SIGIO is blocked; allowing SIGIO still permits
> fallback.
>=20
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Signed-off-by: Shi Lecun <shilc2025@mail.sustech.edu.cn>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/B01DC8398B429509+20=
261107154928.3519030-2-shilc2025@mail.sustech.edu.cn?part=3D2

