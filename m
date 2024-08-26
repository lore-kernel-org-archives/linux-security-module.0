Received: from mail-4022.proton.ch (mail-4022.proton.ch [185.70.40.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7650C19341E
	for <linux-security-module@vger.kernel.org>; Mon, 26 Aug 2024 17:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724692056; cv=none; b=YRKHpAClk0vqe96b4y1LhijQKkOhFwk5Xfi4LJZIris5RzKw9hF5GfcZ0QPI+wisLTuFLj3/67WwOOm9iVz7Qwlu3WPuuakULptUdzQbq3uaQDrLbBk6wb1gHvho1f+b2LENcqjkQsfqyIyp+e49ritcv49Cgb5frUjLLvXaJN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724692056; c=relaxed/simple;
	bh=DrdR9/8cCu7KYcpukLWxLZpNjCJfvjYm5PmL18Wv2zM=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SPPc3fCMb8sNPxFDeykvUN1cE2ZDmBQUQN+xcqT4Nl3tJLXMrKnsHPytbbtNUI33h11+Q8YifsUJr5YgIa3RsEimMkyjUbPV0Bn5LY2Pl9cKKup6KJRUTea8JuvJsL7KT8rM6SQdyxZxY3X0GJT0+xcHdNxh3Y20P0NfEGuZ6gY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=chesswob.org; spf=pass smtp.mailfrom=chesswob.org; dkim=pass (2048-bit key) header.d=chesswob.org header.i=@chesswob.org header.b=sduMbMqk; arc=none smtp.client-ip=185.70.40.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=chesswob.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chesswob.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=chesswob.org header.i=@chesswob.org header.b="sduMbMqk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chesswob.org;
	s=protonmail; t=1724692043; x=1724951243;
	bh=i38o5ZeeYAAUpEiAtrPv7q5av8hIELFp+vRCz0DB/jI=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=sduMbMqkqNLPixc/uWDiI5oBj7mGhKMeWWVoJhfP5+oYXySqv+5+iJzHo1dNFApEh
	 GNzIpZNyMpY9tX3K7eruaG33Es1GjRDL3LwNSXf/xtsiAJASvfh3+1LAPyI5WsVQRL
	 XU5BuMwLF4nZk893LcZS2MP2ewrLr5IuIJbszAnM4SbvX/I6ej2MMue/dmqwBxwCYg
	 e9lHxduEAL+9BMfuQaq9JMF5BeDtxDn+N/uK3Jo1MxnMhof30DWlc3Z17vlRmnwJgy
	 4WPvQVX0WzjzeT2Q+eJZw87n3W5uQp3dgedff719T5tz1kONsNDPWLboYNY2UH/k/d
	 JJ5j/5GIL2HoA==
Date: Mon, 26 Aug 2024 17:07:18 +0000
To: Bagas Sanjaya <bagasdotme@gmail.com>
From: =?utf-8?B?4pK2bMOvIFDimK5sYXRlbA==?= <alip@chesswob.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Security Module Subsystem <linux-security-module@vger.kernel.org>, Kees Cook <keescook@chromium.org>, Andy Lutomirski <luto@amacapital.net>, Will Drewry <wad@chromium.org>, =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>, Theodore Ts'o <tytso@mit.edu>, Alan Stern <stern@rowland.harvard.edu>
Subject: Re: TOCTOU-free exec(), chdir(), open() with O_PATH sandbox emulation support?
Message-ID: <RpoPywKbvpClHVGTO6u6Bprtwk6A0wfF2xafV4MBEWVBFZ1xErnFrJjlVFVRx7Bo4qrWHJcOj3_-AH5LWDaOwj6Zn4Dn7w5wSgKX8BmN3cw=@chesswob.org>
In-Reply-To: <ZdbstX5p4M_-RjXC@archie.me>
References: <ZdbstX5p4M_-RjXC@archie.me>
Feedback-ID: 36787097:user:proton
X-Pm-Message-ID: cc94d0194bed081b308b005f345baddf9612c938
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg=pgp-sha256; boundary="------6ef23b8217cfaef73e605472dd78080ffc70b76c1d9d466bf8cc04e5d3e41744"; charset=utf-8

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------6ef23b8217cfaef73e605472dd78080ffc70b76c1d9d466bf8cc04e5d3e41744
Content-Type: multipart/mixed;boundary=---------------------b22cb991a0762f48d07d7539740d307d

-----------------------b22cb991a0762f48d07d7539740d307d
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;charset=utf-8

On Thursday, February 22nd, 2024 at 07:41, Bagas Sanjaya <bagasdotme@gmail=
.com> wrote:

> Hi,
> =


> Ali Polatel alip@chesswob.org opened feature request bug on Bugzilla
> =


> regarding TOCTOU-free sandbox emulation support [1]. He wrote:
[snip]
> Is the feature request viable/realistic?
> =


> Thanks.
> =


> [1]: https://bugzilla.kernel.org/show_bug.cgi?id=3D218501

Just close it as ENOTG**GLE. Sorry for the noise=C2=B9...

All of these have "safe" workarounds:
1. PTRACE_EVENT_EXEC can workaround the inability to emulate exec.
   That said, you can TOCTOU scripts (because binfmt) but not ELFs!
   Just denylist the interpreters or W^X your FS like a chad or wait
   for O_MAYEXEC to happen if you care that much really.
2. Turn O_PATH to O_RDONLY and noone will know (pinky swear). You get to
   updoot access times but who cares if the alternative is unsafe?
3. Apparently, chdir is not seen as security critical=C2=B2 so why bother?

> --
> An old man doll... just what I always wanted! - Clara

=C2=B9: you cannot cover the sun with a sieve,
gv*sor is a joke: https://mastodon.online/@alip/113028762062293426
=C2=B2: https://www.openwall.com/lists/oss-security/2024/05/20/1

--=C2=A0=C2=A0
-=E2=92=B6l=C3=AFp.
-----------------------b22cb991a0762f48d07d7539740d307d
Content-Type: application/pgp-keys; filename="publickey - alip@chesswob.org - 0x55838BF3.asc"; name="publickey - alip@chesswob.org - 0x55838BF3.asc"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="publickey - alip@chesswob.org - 0x55838BF3.asc"; name="publickey - alip@chesswob.org - 0x55838BF3.asc"

LS0tLS1CRUdJTiBQR1AgUFVCTElDIEtFWSBCTE9DSy0tLS0tCgp4c0JOQkdFWGppUUJDQUNvakdh
OTlKTnVENVFVQUxFeWNsd2Uxd01MVjVySmN5ZUhrM3NIOEVZTExsS2sKNm9wNlJ1bGhjUHdvMW5O
UmdXRkM4ZVBRaVNqMUpFRHFlRjQ3eXU5Y0xDU3BLeDRJWUVCZmxiSkwwcEI4CkpZdUk4NSs1OVE1
MXZaeUJuU3pTclBkcUdjSDM2d05wZ2d0N2lTcHVCVjk3clRWeE1ndHU4S0RtUisvSgpXQWQ2aWJl
UE93b3pnd1ZQV0VJY1NQd0FaUFlrcHJ5YnVCQkNWb2dmbUxLN09FWTNGMlozTzEyeGFHYVUKOGF6
RU5XZkI2YWJPVXM1ajlOaXJFMW5OV1h2V3FPSEVVa3grVmdFTUlkR2JTWWc5Y0dicDljUjZZZUFS
CnlpK0Y0MGJYMWZCS2ZVNFI3ZDVJQXY0Y2g2OTUxMDdrMW9qYmJCRjZDWFZ3V0tSSzBlRng1Tit6
QUJFQgpBQUhOSldGc2FYQkFZMmhsYzNOM2IySXViM0puSUR4aGJHbHdRR05vWlhOemQyOWlMbTl5
Wno3Q3dJMEUKRUFFSUFDQUZBbUVYamlRR0N3a0hDQU1DQkJVSUNnSUVGZ0lCQUFJWkFRSWJBd0ll
QVFBaENSRE81K2JkClErS2JzQlloQkZXRGkvTXNPNG9Ja28wR1NzN241dDFENHB1d2ZRRUgvaXpy
ekJkbzFGMHhYRjdNdjkzVgpkS2xFbWxlVk8rYnVjdU5hb2huNzFCNnl1SW5EM1NLYUM1SHF0dENK
MFlnNEYvQmIwdDlVYjBrWGkxOFUKRnRKU0V0TmxpUXJRTVJLZno3cFVqTHAwWkR1Y2xlaDVKUURs
ZHVZYlBVWEdGRDdnNVN6M3M4OXJuYWdXCnFKZkdxcWVlMWRDcXJYN0l2N0xwU2ZVbDlLdzhwSmRG
aFlsby95RW9SLzVnM2k1Yy8wOWtyaDdSUmk0agpPdVBteFMzWHN0aTVRT0x1U2JFUFlhWmhpZnZn
R3JOcVRyUTY0QUxDSjQ2Q3ZrQVQ0UGptWnpncE03cHcKeURQNEFJM25WRDNSQ0U4SHY3SjR2TmdC
Z1dvL1hKRlcyd0EydUFJV2xzbTd1eFNjMWh5OFVLVzFnTVl4Cm9PM1daeGl0TWQrMk81L1VuakRB
MHovT3dFMEVZUmVPSkFFSUFLOVF1b1pvNnloYlAvTVpvNDZnZjY0ZAo3Nmc5NE84VnJ1amxwazVE
cjg3T0wvVGY1dS9XMVRiZWhCYWppN0s5Z0NLczlVZUtUYldyanVlRnltSSsKY1lGMzZiclIrVFgw
cjFyMGRRbjl4Y0M2UnRDNDArV3lOdER3dTk5Ym1VZkF1dnJ5QmdOOW9aVHF1azlFClUydEUydjBh
ZTQ4MzU1L3AwQmR4c3Z6SmNPTW1FWENDZUpYcUdQa0Nrd3Fnc3JxazRTVHFQS2VRWTZXcgpOU0NX
cnE3WTVVYWVJWXZaUm5kMFRjV0ZLWVJLbk5XNkI2TnplZFdjRGJRazV1OUs2RzN5SS9vTy9EdzQK
a25PanVCWUNBa1Vodzk0M1ZwSi81N3RwMDFzd2hjdjVlcHFCYUhLNVNSYTg4TytOWUlRODdNNE5m
Z3lFCkg3Z0lDY0RTT1lMVURUM0ZmN1VBRVFFQUFjTEFkZ1FZQVFnQUNRVUNZUmVPSkFJYkRBQWhD
UkRPNStiZApRK0tic0JZaEJGV0RpL01zTzRvSWtvMEdTczduNXQxRDRwdXdiNmdILzNsaE8wdFJm
NTZrOG5Lc0hQZ0wKWHlVTUVQZWtoVFVMdG04RXFkekozSkhMUTJlNFBxWTQydlJhNEdEUzY5aVNL
UVR6UlhvdWhQWnBId2tCCnpKTk4xK3AxQ2V0LzNiRzJza0hlMkxwV2tGVVBad256MEE4SkZFMEhr
RmpZcUVLYXk3ZUs0LzIxTGhKUQpCZEZUSDMwbVBOMytiMVU5dmtOblBPY0ZQbHhmbmNzekk2Rk1j
NnU4dnYxNDc3SkFJcE0yV0pQcXRkUWMKSncvT2dHcjFaRW5OWi9icktWK3RQeHlEdmxtUklsQTNI
TnlyN0Q5NWN2bFlkVHl5emcyb3dFZHRMa3dlCjI0eUNUbWdHNnVoL29SazFsenFYcWZHaEpDYVpD
Zi83MlhpcWxSaDFRUko1ejdIM1NMcHF3MUszVXlQbApaNHg4NTliSFJMODNXeGpiR1FLMU8vMD0K
PXNtSUEKLS0tLS1FTkQgUEdQIFBVQkxJQyBLRVkgQkxPQ0stLS0tLQo=
-----------------------b22cb991a0762f48d07d7539740d307d--

--------6ef23b8217cfaef73e605472dd78080ffc70b76c1d9d466bf8cc04e5d3e41744
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: ProtonMail

wsBzBAEBCAAnBYJmzLYtCZDO5+bdQ+KbsBYhBFWDi/MsO4oIko0GSs7n5t1D
4puwAAAVCgf/VQZNkVBbHuKhPfJWiHJJyGH/bTodY9UkgDZ49I0Q0DeF2tJs
cQiLEdhtQ4yhEJmLS4rUIYCJXnW/fWBRfD3n6YQdnLbcsUVxcCLdmPYcznQ4
7Wjx+4Tc2swkpdGIpltlkrXTR671j2rfAkdeLd++q1FpjTtks9YxTnlj7QPe
bv+JJjvlDC7FY8OBQnoWZghHmsBmYx9WAkkRSQn50y3wdjGWky/uFEohjKFW
eEFCDGxEtWl76RLI8a0aQ9gzVRhqEIZLPCwrf4/7FXkGO3ZDKegSDGIYBvJR
7BKnT9SCcmKLFA8Qm6WOy2jBUL7Abut6JyPJwlPe6IxLVEO/PHP8Gg==
=iTGy
-----END PGP SIGNATURE-----


--------6ef23b8217cfaef73e605472dd78080ffc70b76c1d9d466bf8cc04e5d3e41744--

