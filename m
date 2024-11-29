Received: from mout.web.de (mout.web.de [217.72.192.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C9DD153598;
	Fri, 29 Nov 2024 12:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732883961; cv=none; b=HRx28l8z40KESZQav8T0Ns59B1o1DScjGneTs125tRoEycgs6MsoQSjuZJRAk89myRerIBXfb+ewX6X0zOTgw9uV2zXWSpSfWpg9v8qGSaIJXv/edLM8VELmkhW+DUixjRhu6D1lBHB8jb4LRX2h3xnQrk1S11BEVU+Rp3akBn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732883961; c=relaxed/simple;
	bh=zmd5dRQw1Z0wyoAWVm4LhnCDum5cMoIqVeSTNInUDxo=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=LDjqy1o4od6iKwg/pTHc192EuDzTehOj+sOkSQ7uft2Kw8UGVrJlBvbGtXvXqhgjwTWP19zWRWHH2/1TD0kjqamPYmYhvXrmAPNVikNDG+DB51FJS+8a2joips8l/Ew6QOK6edMlnGgBit03rZoxqjmnyyAE75eeMFxc4CdtWN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=BeOA8iYd; arc=none smtp.client-ip=217.72.192.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="BeOA8iYd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1732883929; x=1733488729; i=markus.elfring@web.de;
	bh=XBduW3SM3+NMMILO/IqPvm90LNGwHqgc69m7I7FFaM8=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:Cc:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=BeOA8iYdWx7gWqN/WcujJEk4fTqdjx95sW4D9ihtxa+OovXF832fo1GaPKEwftKD
	 ZpMN1Qbhbslceu7Ouk0GOf+qM0xuyiZOpel3tUS6mgqWwT5PNsHCZL4qjHtrJ8zgD
	 D+atgd6ApmZ/6itX0kEX5g4wvI7wg6bt7NeDd2CrbvVAcmTxkO1yvx/oMGSNnCk1C
	 K6no2wa9Ia8em8b7VMqm/PTUNhqNythmC//yOdmazzuWrqu6GbOmMKohSl4+dvGqa
	 pGRF6mI8x0wWZvgV5u+ircbuZeqZKwlr0RqUCM+rCfHF+0PIjeS3xX14vw09Z1SkQ
	 FHgP52CXoij/ZIvhUQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.91.95]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MTfol-1t6rmW36A1-00TrwK; Fri, 29
 Nov 2024 13:38:49 +0100
Message-ID: <b30c7227-c596-4980-aa46-a75b1d429354@web.de>
Date: Fri, 29 Nov 2024 13:38:39 +0100
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
X-Provags-ID: V03:K1:74y8QeqmuatnpqkylLeQMkZwt407mLqdiWTnlCxHrle9Og4CK9R
 DGqAzLJ8BHp/JAsXJi3ePht9owxsEcnR+ZRwB4if4h4w3rL4+uzJ1AFJ1CKpqm54TFEHoP0
 TlpVnqTxdnKqOlOzN6rD+KzJWo14sGOVTkJpJfeogrvFM1LcBDYAzTlJJGqUg8xTcohGLlk
 REaX1gTQU/yjzayGAS6jQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:KDhbbpCfHaY=;n/DXPrV9jGKBnLsK7ZRYQ6TFV8y
 VX29y5mEjbtc2JE6T6k2A9gio0nOxfTk3Jq2xoBM6VB/dlNoLtSvMaAvdHmtK//vPLoiaNN8C
 G8iXusnZBX5xch3DrF4M+6D+P3AAl00SR/Z/KKGACBuZvr+h4FO9os7icGG3OTrpyTAF/R+yV
 nUZZVcrCmjusA6SD83PCo0HsY+s9yDznDPeZ+9v5Uj9fo1nxinqavBYaGS3lfeJ8EQHZrFVs3
 TH6IjDLeHqE6hpIiqudsGbTCfu1iLiCR+xb51lBP7s2GeKdtpIy5wedfAl8IDZJNsZtwNkpY/
 UrwSCD6tNAi71CAAjDuIv1Xe1VCG9nPVSCu7pxxzcu4Cq1mMnRMPWVNLrjBxQEY5SpICXHchX
 O+StCL4/Rr/PoPszUxQIrQFhrYEjn2c4JY4OpQhJp4mFnCZbICuJWWRAjk/y1nEopcjih5Dhm
 YE9PSdTslJk6LklL1QjIsjUJKVafsJ+Gc+tzj7mI3hFGzlASQ799Mw3UBIlsTepwogAzuXRAN
 Jiy/wfNLoFFQgVXEWD3u83lOoZDJ0dml9tCWxYSG+BDxZh6pd6W3NKW6+N0aMfZXAr19H2L06
 X5MV8sYnz4GnbwdXw+RiEuXK2i5MiBsHtLOL8JmVPnzVDZYzYz0DBhmj2sGwcjMMSQX6GdqzJ
 CypFaO9qfr6ZTJtSo6JVnwmyGP1GzgWolbkWYJJXm2m5jDeuHf2h5dY5/ZJ2tLLliZkJpE15I
 N6Qk6Vwvsmkz86xNBsytrx1csve3mPyN+xvYxigGj6ngzlAVY/WiKT3ZN0JMlA0ZxFlD9nWuu
 JuCVAVOR7xzWzjggZRpbNgw/p7KLarcTN6QBNUj9MHP3r3GFmB2/vyzd0mwEk2zf9zrD8MoQJ
 H7PJHUxDAlURDmDh455Y6J3cfU6zLl4A5VPpyNoePr5EPcYAdlI8jAsWCGH1yeNjEPJZ/p505
 Vx3JpGHxjA89ummM3Slgaj/VctxeoVLGnoRbqZH45ucdOcz4FPnKcrkcTcVYmJ5fZEOvU3idj
 B2zlver55TBP87Lv0sKTaRNXZESJoDl2FQFuUHS0omnQjt90vyRaFF0bR6Ct9/6JFaj7wXjil
 ETmITs9oE=

=E2=80=A6
> +++ b/scripts/coccinelle/api/capable_order.cocci
=E2=80=A6
> +@ depends on patch@
> +identifier F =3D { capable, ns_capable, sockopt_ns_capable };
> +binary operator op,op1,op2;
=E2=80=A6
> +-  F@p(EL) op E
> ++  E op F(EL)
=E2=80=A6

It can be amazing how many source code places can be handled by such
a transformation approach already.
I hope that corresponding data processing requirement analyses will trigge=
r
further collateral evolution.
You propose to use the metavariable types =E2=80=9Cexpression=E2=80=9D and=
 =E2=80=9Cbinary operator=E2=80=9D.
These filters have got the potential to match more source code than it wou=
ld be
intended here.
The length of computations behind a selected operator is not really restri=
cted.
Such expressions can probably contain varying operator chains.
There is a desire to split the affected code into subexpressions.
Special development challenges are involved accordingly.
I find it safer and more promising to use scripting interfaces for this us=
e case.
https://gitlab.inria.fr/coccinelle/coccinelle/-/blob/620463b4bfb8bdc5c99da=
bfdfa337b34cbaa9ef1/docs/manual/cocci_syntax.tex#L655

Unfortunately, required programming interfaces (for OCaml and Python) prob=
ably
need significant improvements.

Regards,
Markus
