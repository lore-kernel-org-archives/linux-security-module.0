Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793019433;
	b=x1tNBfmY5WE4R0sYn4E1cettygxr5LJ6+PDEKRFvOS9VEQvTR0yMwIfHcwooomMWGmw3
	 g6lFjGYt3+iq6STXcrC5EKKcfAT+vLS8MHX9dlVzTUbF64a1WHziU0r35SiOpbt43WCpW
	 HyNmpTbztZ23Bxmcz2ENZIa/DNeXToKKQx71P/e5MjVgBiuDXXfpFsIQWHWWBOndjFYFx
	 WOgGI1FQ47ZxFn2HY7qGOe8h/iLeGeEeEAZm62/enAimZ8LRHEJBVpEJbNcpl3VGhBmP2
	 +oSWRjsRu4b9j6LZrHQGH1iKzSdQ9E1J8AakE0BYX5o+Dxhi9HW9Ev+rklNecnx0Bng==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793019433;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:Content-Transfer-Encoding:User-Agent:MIME-Version;
	bh=HMpLhaD5BcYLKQl7lpJj058Uv5YztYi1lTCdU27HcY4=;
	b=jyRcmjnetusEGmNIh4G25WTtQ2T1zdRRfie/UxrurzSP11SvqFg75uix61kT16iGmvny
	 veU4AEbanCxnnFr+RBplUIN08nSk+VXddgwhaEaIhe8Hq0Wzx0PZ047kiHEK1wG/bTMct
	 le0ExGF6we3JwwvFz4caoM9PRWempkpRGtFaTsqhrQguUjQKEFqao/63NViiqXI07HUEv
	 gS1NtMKr1LSbtFdl5i+nOWfKNiDxIqpYVJS8pa1ld9jsuN3G9R2+h/vksuZAzGos4nE/H
	 Xw4d3eKeqbCmTFLQXoy9cYlfAG98D9xsHn0uygkkNQUe9KRq0QElgM31Yy8Xo7Utj9w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=OySLaZNF;
	arc=none smtp.remote-ip=209.85.221.42
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE8FF606A32A
	for <linux-security-module@vger.kernel.org>; Mon, 26 Oct 2026 12:57:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AE8FF606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=OySLaZNF
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-48df4f540ebso1447064f8f.3
        for <linux-security-module@vger.kernel.org>; Mon, 26 Oct 2026 05:57:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793019431; x=1793624231; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=HMpLhaD5BcYLKQl7lpJj058Uv5YztYi1lTCdU27HcY4=;
        b=OySLaZNFF81ia0rVA94JSJ0z0WWlnlSpQlXbPYNdoz2t/Nvpk6+ph3yDPXdpqVsIPM
         wlDP7Z4AIMnFkaFzfTP/ie024+qWkH3xCX/k2MygTiVPAHv2EwRAm2+g536+oaCHuvLF
         KUSANP7ZxtIEbwbx79hEVEUmF0XUQQQgg0TuLbwHHTsGA50mgIh3AsV19T/ttHs6D88u
         4QNMSqBoQ8eyMeXr/+QjpcCERneb+jyIcQ6CzY8Far/ic/F2lSlx2+jBHqRl0t4QTVv2
         zDvlAinx5/+hrJf6TpZifS9F83hNDfxL8wDuKOS885dochDajAMj/tOH33lR2H/sTbBK
         ytRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793019431; x=1793624231;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HMpLhaD5BcYLKQl7lpJj058Uv5YztYi1lTCdU27HcY4=;
        b=eKU60dJuMzg+EviN8a40WsKtrasXSbuSQyIwtfZivfps4FRSZlZoATd5rUMAuVbwUy
         8jla/b0jF3O+cEIr/lmSz6S9Spq86YQR993Zd3w6tieuqUJvMPpwwpM14A3PxiX6yOzb
         S//lHd+b7tmpCirNSoqfCxOgkuzZxkLKO1TyTJr5cX3d1iDhY6wliBd1qBdcqd6OhaCI
         tdLy87muhTJPAzF9Cyeok8PHX+BTTdSOsh8NrICBWdYIW9bqCCWBhgAL44cA/IEVyPFE
         ujbqT+tcKQFCVZZnR0FfD1Gsc7ICR9Z9ryTrYfZ9R5ks27mx0qC6qndG125H3EO9ATR4
         lA8g==
X-Forwarded-Encrypted: i=1; AKwUvBxNuYrHG6YAVsg5Aj/GaHqy65UHxL2nV1g0epHmYWp5lX9KpeD2HfQaxIW73BUK2JOrEZkowf/OR3TcH3c3/iZT6dwK5z8=@vger.kernel.org
X-Gm-Message-State: AFq9FYLEOvyYM6tXi4rI1H1JCEuY7xYJVKbCxK9iAFlVw1bh50PYJejF
	uYJZZZPy+qKJz8X70taZZHl34NgJaJuw2KqsAPpLmeJcPLZEmEMcoDXJ
X-Gm-Gg: AYBFou2YmddV4iMw/Scofz+a3+hCGu1uM6PAF2bF6AWXv6uc0XtPQTwEmUOgo7ZhfWy
	WnagZiVoxeMcrbs0gSCRoiHU/PRbXXvA3Erkv6TCdKA+X6E+c7sZYOJUzKvaUjHA4tT9LOP80T8
	uxYASfEdWfa3vvqEi3tveIl4pTFtH+ZftEJgrQ/HTalKlsGPt2Df0O4y9povb0acr9II3ni6sFR
	mXXvMavHUN27dxPgZJ7Po8VEA/tGmchT4SxcHZfF5y5zcq0Hb808rxVLgTK6nJ42MsDneJXHPQj
	SXAu9WMUlCWcuBFvV1ntChoOLvNLgn6pSrwjeQVcWLJhXbQARgNzIuG6NlKBAGMcws7Z88QCrve
	5K/uNaRBBx77xPCHBQjB97Dm22RtAU87kqGb3C6CCkuxlcbBTe2sE+sxZ4nBg+jXTQqC0f4ilaw
	HE5W/nUg10hA2VB/gn918Jdb+2+lOhnz9Fitqc6Mf+O0/988teYyQgXwv+JbWmV8H8W3cNmYWa5
	S3XGlt4EQrZcqkddM5U55mJWdVsYZgjYRRmZc/X4FTotpQivAPMyQTXfG+k7epzFAkR2RjKJYNV
	BbaWh+xb5Q+8uTunfReKKdwN9Hnl0ZBW6Q==
X-Received: by 2002:a05:6000:4a0a:b0:48d:de0f:b79 with SMTP id ffacd0b85a97d-48e3eac8e4bmr13027887f8f.0.1793019430839;
        Mon, 26 Oct 2026 05:57:10 -0700 (PDT)
Received: from ?IPv6:2a01:4b00:d036:ae00:fa6b:a9a8:1f5a:6fcb? ([2a01:4b00:d036:ae00:fa6b:a9a8:1f5a:6fcb])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e3eb8f36asm16561378f8f.1.2026.10.26.05.57.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 05:57:10 -0700 (PDT)
Message-ID: <5143896100674c9fd744c4d7d6ce12232910e789.camel@gmail.com>
Subject: Re: [PATCH RFC 1/4] ipe: add the .ipe policy keyring
From: luca.boccassi@gmail.com
To: Paul Moore <paul@paul-moore.com>, Christian Brauner <brauner@kernel.org>
Cc: Fan Wu <wufan@kernel.org>, Manuel Huber <manuelh@nvidia.com>, David
 Howells	 <dhowells@redhat.com>, Jarkko Sakkinen <jarkko@kernel.org>, Andrew
 Halaney	 <andrew@amutable.com>, James Morris <jmorris@namei.org>, "Serge E.
 Hallyn"	 <serge@hallyn.com>, linux-security-module@vger.kernel.org, 
	keyrings@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Mon, 26 Oct 2026 12:57:09 +0000
In-Reply-To: <CAHC9VhQ4sdCRvJ+YPZoiQzR_hgQN6-=84qvnTDDGPf=7=L9-jA@mail.gmail.com>
References: <20261019-b4-ipe-keyring-rfc-v1-0-156f0b93e843@nvidia.com>
	 <20261019-b4-ipe-keyring-rfc-v1-1-156f0b93e843@nvidia.com>
	 <702ade20-a2f3-4919-97e6-c72faa89399a@kernel.org>
	 <20261021-groll-donnerstag-erfuhren-ce34a0ed4e97@brauner>
	 <CAHC9VhTHUU0h9k74CMT6wYhMwyY3YhbSSFwJoDTvoFRyTFVZwg@mail.gmail.com>
	 <20261022-hausbank-dozent-hurtig-9443f3777475@brauner>
	 <CAHC9VhQ4sdCRvJ+YPZoiQzR_hgQN6-=84qvnTDDGPf=7=L9-jA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-0+deb13u1 
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

On Thu, 2026-10-22 at 13:18 -0400, Paul Moore wrote:
> On Thu, Oct 22, 2026 at 6:19=E2=80=AFAM Christian Brauner
> <brauner@kernel.org> wrote:
> > On Wed, Oct 21, 2026 at 12:51:35PM -0400, Paul Moore wrote:
> >=20
>=20
> ...
>=20
> >=20
> > > Of course, fitting in with existing norms is important,
> > > but if it causes IPE or existing IPE uses a lot of pain, that can
> > > a
> > > good reason to diverge from those solutions.
> >=20
> > Which pain?
>=20
> As I said before, (emphasis now added for claification) "... *if* it
> causes IPE or existing IPE uses a lot of pain ...".=C2=A0 I intentionally
> did not make a claim either way.=C2=A0 Once again, I wanted to provide Fa=
n
> some support in case there was an issue and he found himself in a
> position where he had to push back to preserve IPE's model.

I think there is one issue with the design pattern where keyrings are
set up in userspace, that I have mentioned a few times already and I
got documented in
https://www.freedesktop.org/software/systemd/man/latest/systemd-system.conf=
.html#RestrictFileSystemAccess=3D
as well: they are trivially bypassable if the kernel has kexec enabled
and it is signed. The security model relies on the "good" userspace
running first, but if kexec is enabled, there's no guarantee that will
be the case, and as far as I can tell it gives root trivial capability
of overriding it and extending the trust chain as the attacker wishes.

IPE specifically was designed to avoid exactly that, and ensure
userspace could not execute untrusted code, even with root privileges.
With this enabled by default, userspace can just load the same signed
kernel image, passing in compromised initrd and command line, and gain
arbitrary code execution on the host, since only the kernel binary
itself is verified, and anything goes for the rest of the kexec
parameters.

This is of course not to say this new IPE keyring shouldn't be added.
But perhaps it would be nicer if the default build flag was mutually
exclusive with kexec being enabled? Not sure if that can be expressed
in Kconfig though? default: yes-if-kexec-off, no-if-kexec-on

At the very least IMHO this relationship should be documented
explicitly in the kconfig blurb, as it seems to me it's a major footgun
to leave laying around, and users might not necessarily be aware of it.
