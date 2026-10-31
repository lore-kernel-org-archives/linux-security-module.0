Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.227.8
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793422162;
	b=Aw3MgRWe/G8LSJQrz3AOwWOiZ83CoSdBy6t8iPNq6pRou2d0Na3gg63YZ1IZG/9v0mx6
	 vghfsdKeLtYDJOoUocql+7i600u5VeI6KEZJCri7gUgwHzUFZfPB6xEfSFiff4cDIqp27
	 eL5NCildBHO6PSfXgfv327Eiuszih962nvfK03+yBUYwXUJNxRqYhUWi0GV1jYrHoDX1F
	 s43JKcrWkYliTxUW1S6nsHSygl4w4M7tVYBJoVom90JBZvDPwnnfa0OEQ1mFzSv3rfg9w
	 Hy232ELCUyksUCXZJV7cMpmMe+yKx0D3TJJYCbdtlxK5PkmBYnzfmy+aOA5n3+MrYig==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793422162;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=DFy0aXOcH5qGYelFMWeP0BXiiUrKikgkI3RC4XhUa28=;
	b=4Fl6mIridEgeXOsbmd8Y94fkg4jh3VHIvowj71qIcOaXR/ipOonzvFe1vNJp2prxLtku
	 nEXsvF5rVPB53n7MfAH1zS0BHOAhL8DhTocHZiStQYgluMA/4v4T34s6uNTO56VZbPvtJ
	 4xR/6CBsgklR0mJ197diNb3yZCtslTfAwvlrkow4eZeQtF9jCn23B21pzfqGW6FEDjlfT
	 2cB9bTgtTkJ4y9IVgfl6cgRMptYPG3gVjIkg8t6J/CCkbuK5RnSCDYIR3bjNcM16WOpnn
	 P/Ytqzq9VOkquUJ/21D2FFsFU81BoMWm3HZSg37XpQFGGjFuZXv6ddKlbXSq1k+AMcw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=xfBSgSCE;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.227.8
Received: from mail-vs2-f8.google.com (mail-vs2-f8.google.com [74.125.227.8])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B59D4606A31A
	for <linux-security-module@vger.kernel.org>; Sat, 31 Oct 2026 04:49:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B59D4606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=xfBSgSCE
Received: by mail-vs2-f8.google.com with SMTP id ada2fe7eead31-7cc2c327e1fso283687137.0
        for <linux-security-module@vger.kernel.org>; Fri, 30 Oct 2026 21:49:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793422161; cv=none;
        d=google.com; s=arc-20260327;
        b=fbtfpzE9UAzwWhiVIHkOuT7ZZOQLZ1gMSILs6QGr99sQ9kft1NUHeLuywWYdyJPLuM
         o+546VdPITEuzl1mB3O+y8BJJajL6TDHmn/C+U4qkZzCh5aNu6VN7GViQVv/um1H6bFW
         K7FHhaITk3HXMOzgoqO1izIeNbEODrNtg/ftFulbCv3csz1luPIfN/8ngKpiQuFDJ2zy
         mNd19Q83oral7b0FHSXR5xkcgMPnjp14xsNmFWNvPhhfF7q9suPOnwt8NzFeENAnGsd4
         20tQZgzog0z6lsa1drlrTKkmLRwPv4adaRw+fqRhgTuJr3GxwBv6nSeXLbhGfha48Xo8
         nGSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=DFy0aXOcH5qGYelFMWeP0BXiiUrKikgkI3RC4XhUa28=;
        fh=on2+N7K4EC+U7zKc80nHH1N2w/uy0JdxYppYlkb6qpw=;
        b=QE+gKEMDQijabNX5ty53QwwcP75vnROPVjhZxMXQRARr9lRUS55bzGN3qZ3OnunHRK
         EmjZ7VvK5Ra2OtpUE2GuhNhyolkoa2oX64jMCxHwLeGMCAfz8csSkmh5DUQn/MSHXvn5
         JboFT/65xvxmpf05kG2AGYqzUWMfcI/NWwS77USPL55fgXCNz13m3x7TspCU2ryvdKrm
         3c3YBsGClVR1FcMSnR1c06/w0BCODtoIt5I910Ondby1OwsEDPC327UTLmfo2F2x8MLs
         DWAsusCmPiWUA5Smcx4CbjZ7U06XxXpbcX7akJvkJP8fqmZKCXgNASyhJO2j2aGoumAH
         CX1g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793422161; x=1794026961; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=DFy0aXOcH5qGYelFMWeP0BXiiUrKikgkI3RC4XhUa28=;
        b=xfBSgSCEWJzIq7AjGQNCQPuTQvYK9qaFK9vqMVQWIAIMv39PJy/essix3RXjual/6v
         Y8dbuZiPFSm1jVVOKX5CNi8r1q2aBVTe0QdmS9cvpBkLQuZbERj1Ork6wSqcNQbh1wbC
         rzjz6sc7IGnuv3LGlNMD3FOBjyrnRL8ma9bHG+a3/mihH1wtmgYJap54Dol9LO5qFljY
         ENzU8SACdZFhayVjas109bcVz2o/g47bUZ2M14spABocCEBJ00nuckG7kn4YxoCGAXYw
         x+HC1hxg10v1kAz6hB37Yf1/HHCcpDCfoNxTKzY30aMk1V5ze2Sg9djLqmaByVCbtzt3
         hHbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793422161; x=1794026961;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DFy0aXOcH5qGYelFMWeP0BXiiUrKikgkI3RC4XhUa28=;
        b=1EUyj+E2MFb7+GG5kO0Z5VN3J5e/AbcFY5M+9ky4OSaXCio8UWF/nXa6pTHkFUYTZw
         0GH2PpPpDh/R9PbwrT3ZscszSRlwc8ftO3H8q5+Og5UhABky69LLZ/hu6FRPFImaz+2/
         QhVxg3FRjkQsPnr30E+vSJPzamyslJKq5qtf2f1ytwcaYuNIcZfEedUoWsS13uAWURd/
         orxiHrWInA7UtopW64WkbJh5uW23+IrOVP7CCJntwhrqRr8WVsyOTu76NN1K7xdoVKSz
         eWugnM/Vs5JUBr1PWVYx+7biNEDi1OUyzAbPB7UeqBB4VPzQWiXeoREG4vUYIyTDi6af
         kgEQ==
X-Forwarded-Encrypted: i=1; AKwUvBz6coQ9TtUhK9B1Ur9hmVmm+BytqbVxdr+WJt7fTYADZfevkpVOV2zC8REpgyq7u8FeLD+15QHSZucE7IX1w9JMBBI4WFI=@vger.kernel.org
X-Gm-Message-State: AFq9FYJmdmp9R/UffxuYdVn8yPIWPPkCIk6GPuGocKlSX8I1ixn/n9zy
	4OBBzqo1ZVTdUycZsYOeE1RjlTlDLgRmAf4bAApy0pXRhZm/sPI+Bw9qdUWmTRDIbKul96dYm1/
	xeavxkxyxKc55ZOcy8ACfv20SAyfYKZdE8aiUPkpM
X-Gm-Gg: AYBFou2WB/FVqll9UEv+05th2EVh6BQ4LhhzhdWwYKFiyO7b26dbbnCPlK6jxQJVPzx
	hQAVjpHgkFpXwH+7Df4bAqKRk0diXZzVHnNeJPGgV20O8VBw0yaO6gazDRDOgtDXCgDbHOZ2p2F
	tRX4HoUjfjzMLf4aHzX7/KWwoXsn2VzWeR5uoobGXR5Jhbql+hA71F8kfHx3OtTkecoBOByoS9F
	+dG3V3ozKLRWVfmr+RgAuU+Vs3Wr5jQn8MKU7HVtQCf+Gs/OlR80PxOrG7ogGlIrAshWdXqi4da
	ImrJg7UXujFlHHgZRxjWd35jHUynPXBmrJ7xidDVGxb4hkGKGMDTrpRrhE+qdvbsebDwn+vmtwo
	G/u1RLukpmmR6nViKFzA6RfXdRKQKVkzTPs1uFRRa9qMvSA83ebTrDsDT5tr7NGKRghTL
X-Received: by 2002:a05:6102:5106:b0:7c1:e804:3c91 with SMTP id
 ada2fe7eead31-7d072c398bdmr1240318137.8.1793422160846; Fri, 30 Oct 2026
 21:49:20 -0700 (PDT)
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261030173930.40948-1-permissiontogallop@gmail.com> <auTfZL8RjQqT8uiW@kernel.org>
In-Reply-To: <auTfZL8RjQqT8uiW@kernel.org>
From: Gallop Permission <permissiontogallop@gmail.com>
Date: Sat, 31 Oct 2026 10:10:36 +0530
X-Gm-Features: AclHuK-FdSUYVJnYySxi8P-Zi8EKZ3CeyjPrglCec33fiP5ieEc_Yb5Fdpv6Yas
Message-ID: <CAMdFwLH_cg_=cLaL-j2B_0kzAEof89r13=cYR--hgeLxC7Bubw@mail.gmail.com>
Subject: Re: [PATCH] KEYS: request_key: enforce keyring restrictions on
 constructed keys
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: keyrings@vger.kernel.org, David Howells <dhowells@redhat.com>, 
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, Jarkko

1. you asked: What does "key becoming positive" mean here broken down?
    Here key becoming positive=E2=80=9D means the transition from
KEY_IS_UNINSTANTIATED to KEY_IS_POSITIVE
    after the type=E2=80=99s instantiate() succeeded and the payload is pre=
sent.

2. And on the second para
    For an unrestricted destination, construct_alloc_key() still
pre-links the under-construction key,
    so concurrent request_key() calls for the same type/description
find it and wait instead of
    starting another helper. That visibility is what deduplicates construct=
ion.

    For a restricted destination, the patch skips that provisional
link until the key has been
    constructed and checked. A concurrent request for the same key may
therefore fail to find
    the in-progress key and start a second helper. The keyring still
holds at most one link for
    a given type/description; each result is offered through
key_link(), and only a key accepted by
    the restriction is cached. This is a duplicate-work tradeoff, not
duplicate links in the keyring.

    KEY_ALLOC_BYPASS_RESTRICTION callers are excluded from the deferral,
    they keep the existing provisional-link behavior and bypass the
restriction check as before.

3. the rationale for the code change will be to stop an un priviledge
actor with write access to
a restricted keyring from bypassing the restriction checks.

As for the points raised by sashiko ai (concerning
potential outer-search bypasses in request_key_and_link)
im going to need some more time to verify them and fold any necessary
fixes for v2.

Best regards,
Anvik


On Fri, 30 Oct 2026 at 23:48, Jarkko Sakkinen <jarkko@kernel.org> wrote:
>
> On Fri, Oct 30, 2026 at 11:09:30PM +0530, Anvik Loitongbam wrote:
> > construct_alloc_key() pre-links a newly allocated key into the destinat=
ion
> > keyring with __key_link(), bypassing __key_link_check_restriction(). If
> > the request-key helper instantiates the key with ringid 0 (or any keyri=
ng
> > other than the restricted destination), the key becomes positive while =
the
> > provisional link in a restricted keyring remains, so the restriction ne=
ver
> > sees the payload, potentially resulting in a policy violation, where a
> > user with write access can inject keys which are restricted on the rest=
ricted
> > keyring.
>
> What does "key becoming positive" mean here broken down?
>
> Also I have really hard time on reading the second paragrah as it is,
> let me count, over five lines long. I honestly cannot say that I
> understood what I read. I tried it three times.
>
> If you understand your fix, you should be able to nail it.
>
> >
> > Restricted destinations lose the provisional-link deduplication while t=
he
> > key is being constructed. Callers that pass
> > KEY_ALLOC_BYPASS_RESTRICTION keep the existing provisional-link behavio=
r.
>
> The second paragraph should be reformatted and there is no rationale
> or descriptio for the code change.
>
> Br, Jarkko
