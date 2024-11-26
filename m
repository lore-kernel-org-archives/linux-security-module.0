Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 955341D4169;
	Tue, 26 Nov 2024 12:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732625766; cv=none; b=L9SUFtA42abU604ZvSYUXCGKqoIh/AbiSPMighsLj8e1Q73OdirsmkJd1jmvMezyd/U8ThvT1REim8M/TCoS/8I+PmSFQUPsCV04tbzhlWlIbxjlRrNJmGGjpKvJLggVVHHuErrXBc64IF2naliob4ABPFti8K13Ytwidq7lUtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732625766; c=relaxed/simple;
	bh=aI7+FG4RPSOgPwFDA4/SqIlk+zFiNLjorVRUZAJqHsY=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=Di6ozz4330+AgZK6esm5fydasnxT+U/GnMo9Q6QjdC5lOm/wrGUfy7Erv9zkddu+awPOK2VseTDB9jZl1tQ2/eXF/o67hEyLktGSCov/eAJhBXnJt1VUMuPt0bB8Gx3huQLWtRoiSbCy+bL6EkvmIHIimEnpBx+aIGu9fhehEoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=Ws0PxqQD; arc=none smtp.client-ip=212.227.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="Ws0PxqQD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1732625738; x=1733230538; i=markus.elfring@web.de;
	bh=gK3YHcEUeZ+zgADUiKv/PJwsDoDZu3Bm0tlV3ysUn1E=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:Cc:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=Ws0PxqQDC4XZm2wteDC2J3YFTVpgUeNaV7Pys1K/oBjCS3USX2Lr3IQbzsFXmEVI
	 bezYVgEGestzd5+pHFvLqhp0IFwhofb5EjkC1l8W15KQT0V9rFc19eRmKCxL+Altr
	 /j0ijHcKBeeak7lKy0wF09kMMCBFWkoje33nTjm/isWQV28lsUcsZW5VzLkNp/sIY
	 FmMJxTLyNSei5FGdlPamriRxu+kw2XJNoSiEpiZfxa+4TS/xK87Mng778wns6HDRl
	 7xiUGFzordrLFW9FSq+vmpZNtQqNU1H4O5/gdpN/Gu+3i7CVElgyO3k9SpZrQnduV
	 BfeCe6vDcqTnzID5eQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.91.95]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MjBVv-1ts19D2HxN-00en7K; Tue, 26
 Nov 2024 13:55:38 +0100
Message-ID: <8e49861c-123d-4d78-9da7-bdf747c9c33a@web.de>
Date: Tue, 26 Nov 2024 13:55:36 +0100
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [cocci] [PATCH 01/11] coccinelle: Add script to reorder capable()
 calls
To: =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>,
 linux-security-module@vger.kernel.org, cocci@inria.fr,
 Julia Lawall <Julia.Lawall@inria.fr>, Nicolas Palix <nicolas.palix@imag.fr>,
 Serge Hallyn <serge@hallyn.com>
References: <20241125104011.36552-1-cgoettsche@seltendoof.de>
 <20241125104011.36552-11-cgoettsche@seltendoof.de>
Content-Language: en-GB
Cc: =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgoettsche@seltendoof.de>,
 LKML <linux-kernel@vger.kernel.org>
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20241125104011.36552-11-cgoettsche@seltendoof.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:MDBaCd5Ogw2HMK7C+j9ZJzpAn0WcQvq6r/9CqpSCCwTa/pHw77Z
 z29khTQMVIoaz+4QqnLEzWe/ypodb9ldfFheccW3ousjK1py8Cb/+kCL0JZy/BH9qQv5WYt
 qpOa1QAs43MpmSFuElXXieOK+Z4diFseMlqhZSsGWoYlui2blbEQy/Ab8bjUi6KSe65zdBm
 WON7+b3IX2YQB6f5D8p7A==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:o8lRbajgDeg=;DDK1KaYZnjqCcyqvQm63NFF+INt
 CKuiNH3fyOqSfxRWfzyEODHBWSNpfw7bmpIlwV4lTnl24NXEjWLE0hPMKdDsMwrG0uxoYHhn3
 dxvXqQVsRDiyJc89tnLJgPjNo2a9GFuzP4KqMpA/RpaIQPEv2X99K1fJwujDZDgwYztvQe2K3
 F5jYpRUuXPsxm6hOKGYB+3C3df5nTX/VnqUZ1FHUNh87hhgtJabOIRbiHQxvoY5SrgluVW2qd
 1g06360v5WijjEG7QdL+c49nNi7XOwd3hHAKn9I9tv1coJ1mw8hLBQ5VY8EpzXW8Qpan5pjKS
 81Drw9jb3cw+AL5JJhtQTNuLhQC9jiqGJrnUmcMm3R9x48MZt3dmeFtJU1XOQYhMWiY0PHnYY
 rvVosnr7WPIS7tohynjqdwHvolU1jdX7jVCYnzsttAeoHGccmNalLAlIJN75KYxfClH/NXac7
 yvLj/iYvcbVZvK/IO+lGzEiFfzrP2CP2K6StAvmieMEBlsEuCFxbQa0ddOk+j9aU9C0Z3w86K
 jVRZOqIoJ9TKk47BwoTgkg/63Dhu7fTD3g8IAvl/l86aZP5fY3+vL8/txY1jQe2Q1WValROCy
 kyNzSHofJ1/y7WISW+ymD/j6fopIopi0aSujHfApUlhztfYsk0wQ+yW7mGl4ITDWZ60Q0T1+N
 xNYOCGf80SZS6SnSdnvUJhqJEaDjbP55fIWZxadUvtR1bjm6KLHn89WcFo+dq5ixamEgE6A3h
 OzIusA4klgIDtykVWVQG+RglIVeT28s+QLOWLBEnJyAVHWZEGxvLM3xVTf1bhxDkr7X/vT0X+
 DPRKZWOQD3cVJfzPBD6meWSz7SOSDni015L1vsFhCV+hBF4MOX2smYmA2ZjSMw7eP1tOar9VT
 91No5+V5jugl4/+/zxnIsfmJqXV0kl/6cdbaKi+Y6GgTw+6eBPv3p32CSIaSSJXSkTG8gUaOd
 XicZuuVNWUNIGFvycq+soIWSYONRN2Q5KKIxvzfadKxgAKBmac7YJ+ZEpsmSF6r9hKGf6V5sW
 ECY7bizU1wxIJXGN5y1TyqyUeKwqmGW0FRsufzO2K3HW5wM9kRJb+y0lpVNQBhe5fXcGya2Ag
 qesnjVmYc=

=E2=80=A6
> +(
> +-  F@p(EL) op E
> ++  E op F(EL)
> +|
> +-  E1 op1 F@p(EL) op2 E2
> ++  E1 op1 E2 op2 F(EL)
> +)

How do you think about to use an SmPL code variant like the following?

(
 E1 op1
-F@p(EL)
+E2
 op2
-E2
+F(EL)
|
-F@p(EL) op
 E
+op F(EL)
)


> +//----------------------------------------------------------
> +//  For context mode
> +//----------------------------------------------------------
> +
> +@r1 depends on !patch exists@
=E2=80=A6

I would prefer the dependency specification =E2=80=9Ccontext=E2=80=9D for =
this SmPL rule.
The SmPL asterisk functionality should be better distinguished here.


=E2=80=A6
> +@script:python depends on org@
> +p << r1.p;
> +@@
=E2=80=A6

I got the impression that source code search approaches can be safely
shared only between the operation modes =E2=80=9Corg=E2=80=9D and =E2=80=
=9Creport=E2=80=9D so far.

Regards,
Markus
