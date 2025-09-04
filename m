Received: from mail-ot1-f97.google.com (mail-ot1-f97.google.com [209.85.210.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1653F24167F
	for <linux-security-module@vger.kernel.org>; Thu,  4 Sep 2025 08:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756976244; cv=none; b=M1eYL7X6Tm/ZMgwjlETtHO36kOcv3hF+BkPTiqs4NUH+v3Y3XkLqKNP/cFuiNoM8stIrClF3q7uXWa8xdfh1MUraMpjZdHf5GKHRdBJifQoVXCdF2V3dMYRDQWLq3R6ATAwpLbahRSuWi69C4QKXdGEx208L57mlsrlWjLmc9i8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756976244; c=relaxed/simple;
	bh=9ouRP8nwHgCG+D+NXUPtkxn3V77Q8S/Nk+x7pii4U+4=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=kT0Ie5o7072AWacGLBHtwTbXnNi/mJC1GEMk8+hyZs5a+R6XtQyR9bw5dCrjckB0q3bB+XlGye1IKZ9bWMl98keFA0v69/U+n9hAFpcuYlYXMQpZydmc/iorUk2CUPRKcsDei10RF7Rh9bcgggVe3AjYMF26tVagIgmJtpZH7Ko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=BkWIIA7k; arc=none smtp.client-ip=209.85.210.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="BkWIIA7k"
Received: by mail-ot1-f97.google.com with SMTP id 46e09a7af769-74381e2079fso783970a34.0
        for <linux-security-module@vger.kernel.org>; Thu, 04 Sep 2025 01:57:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756976242; x=1757581042;
        h=to:subject:message-id:date:from:mime-version:dkim-signature
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9ouRP8nwHgCG+D+NXUPtkxn3V77Q8S/Nk+x7pii4U+4=;
        b=Pygnu5g4DScMknpUxi6oGupZZTilenmbXT9DjAt9QSEfq87XLu1SkIv2olTLBjSC0Z
         k+KPBaZ/Ze2IJ1LBgFm6bxGcn0MFKBxsaLcIKlI9OktScNczgp+TTgumBHc+QU4+eo3I
         GDUoJGtWHw2LHXI4YSLBrQxytEEu+ErZ2k79AgTh1KN2pYF21o7tRFxQOHccqVMVCyxd
         DpBDrg72V70g1yS6RFatiauK9SUrbVifHVZiRMIx4/IYdJ9nm+09EAcqvKZDWdsM75hA
         ItllZkKQQNSTXW2H2lIwG7lJx/OHzsrHu8TudMsXG0yO3Mee8onPYSp+j+9+wPCdGw8h
         3TiA==
X-Gm-Message-State: AOJu0Yzdc6XV2xnOL9AJA36Jjw7cLI/v2U+oG7GyzK8jtCTK/zRmccDx
	0+InvCxNJygeuo6V6AN9Y2YS6eV2qFDPCcUY7WCXi4IxNB977eEULNn4osl33mPrbb+fOYsI0Ix
	hWo69QeZ/q1UcfueWdvc9wVdlGv53vJ1Nwql0E73BmcfZmfyEeceBu319NU+0PCZav2Sgo2SJwb
	fsTpIXlbXc3CKNwqOKHa+76EcqL+pX58Ne6348GGPib1Tt8rRk41E5FE0POxXWldozZMjiI7w7E
	ibe1h3BOxPhx1VsuOoyjlDppJeqobD0b50=
X-Gm-Gg: ASbGnctJ60lKWhz5ILEo1Ovg/fbYU+hV6qac8+T8Z+OSBd2LJzg3fkQ94pCGIQN58cw
	eIiSclCEsJtxQ5BKCczuGZLwi7v34YbnbX0K4t0WWC+1Hdrl9DQiYgbnY6jqhbKfSsWPTS3r6H2
	VU4MIhjjFRBGadOeVOuP0tOr6w7uUk/s4xIrS5v0idHXZPbvUOEnDKc3urvCrbC1dGLT8EGElzM
	Q2K+blV/PQixjv8U+Ln/Sa+sF/KlsXSPdbhKju07YcRoAxPF8h4WTySD0tUslNp/u8j9Mf4vESt
	ax8HRmxdhjxQH1evE11DMZnqgoK1ybv9VjZrRyRBCNf9Ih0vd4ELtVBHKhz1pyKuCH9L1l6OWNY
	pV0J05D4P6Nhu7KWvkqD1Fpl0jOlLaD1Ihsy+D798W3rR4hOIGLsQvo6BZS4gfHNOxSK1Lon/An
	oz2Hun6w==
X-Google-Smtp-Source: AGHT+IHPsMTHPV78xJ/RcP4F41BvHUKO6OoMB0j89MZlv1jrAg7aM2V2Zb3luOkeGnUJ9BG84drssu6D6P8M
X-Received: by 2002:a05:6808:3305:b0:437:d705:9b91 with SMTP id 5614622812f47-437f7db6704mr9724544b6e.46.1756976241880;
        Thu, 04 Sep 2025 01:57:21 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-103.dlp.protect.broadcom.com. [144.49.247.103])
        by smtp-relay.gmail.com with ESMTPS id 586e51a60fabf-319b58949b0sm571322fac.2.2025.09.04.01.57.21
        for <linux-security-module@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 04 Sep 2025 01:57:21 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-24cc19f830fso12347775ad.3
        for <linux-security-module@vger.kernel.org>; Thu, 04 Sep 2025 01:57:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1756976239; x=1757581039; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=9ouRP8nwHgCG+D+NXUPtkxn3V77Q8S/Nk+x7pii4U+4=;
        b=BkWIIA7kX1AMRvwOtey5nQlHg9AJl8DFPF32G5SPWHztKEmUoQvCiEKPlccDx+1oPW
         DGLXuPa3wj2rE4GHdpNH5XbhQNYiKt0hnBdOepfsrEF9uRdi/q5ZA6125B5Y+NU0ZoJU
         q1GGsBId+cgDCoMoTl4Q6YRdCP14HEeCXJkeU=
X-Received: by 2002:a17:90b:5250:b0:32b:96fa:5f46 with SMTP id 98e67ed59e1d1-32b96fa9670mr1481799a91.5.1756976239532;
        Thu, 04 Sep 2025 01:57:19 -0700 (PDT)
X-Received: by 2002:a17:90b:5250:b0:32b:96fa:5f46 with SMTP id
 98e67ed59e1d1-32b96fa9670mr1481784a91.5.1756976239114; Thu, 04 Sep 2025
 01:57:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Muneendra Kumar M <muneendra.kumar@broadcom.com>
Date: Thu, 4 Sep 2025 14:27:06 +0530
X-Gm-Features: Ac12FXzBzsXVqLLRna3CmGQg73MyNx_xdLeMJjMqlIXCYvcnXjC0HBKx-szj524
Message-ID: <CAJtR8wWp3XWmf53KOx1P5Q5h+DrsdF8kAum2Eo2=rG7xsrDf7g@mail.gmail.com>
Subject: subscribe
To: linux-security-module@vger.kernel.org
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000a7ea6c063df5e8ab"

--000000000000a7ea6c063df5e8ab
Content-Type: multipart/alternative; boundary="0000000000009ca331063df5e896"

--0000000000009ca331063df5e896
Content-Type: text/plain; charset="UTF-8"

regards,
Muneendra.

--0000000000009ca331063df5e896
Content-Type: text/html; charset="UTF-8"

<div dir="ltr">regards,<div>Muneendra.</div></div>

--0000000000009ca331063df5e896--

--000000000000a7ea6c063df5e8ab
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
ys9fYL+GlV3PS9wS3h0MI90cAfs5ZQjER5eWqMBARhfrW70fFVMSdZzBpXljqRjD+GOJm711FgvN
RsH9iq2Ndn7XY7jpnxND6cwSKympBXWuvQ54YyFDLr0m9eC6BNU5bQIDAQABo4IB3TCCAdkwDgYD
VR0PAQH/BAQDAgWgMIGjBggrBgEFBQcBAQSBljCBkzBOBggrBgEFBQcwAoZCaHR0cDovL3NlY3Vy
ZS5nbG9iYWxzaWduLmNvbS9jYWNlcnQvZ3NnY2NyM3BlcnNvbmFsc2lnbjJjYTIwMjAuY3J0MEEG
CCsGAQUFBzABhjVodHRwOi8vb2NzcC5nbG9iYWxzaWduLmNvbS9nc2djY3IzcGVyc29uYWxzaWdu
MmNhMjAyMDBNBgNVHSAERjBEMEIGCisGAQQBoDIBKAowNDAyBggrBgEFBQcCARYmaHR0cHM6Ly93
d3cuZ2xvYmFsc2lnbi5jb20vcmVwb3NpdG9yeS8wCQYDVR0TBAIwADBJBgNVHR8EQjBAMD6gPKA6
hjhodHRwOi8vY3JsLmdsb2JhbHNpZ24uY29tL2dzZ2NjcjNwZXJzb25hbHNpZ24yY2EyMDIwLmNy
bDAnBgNVHREEIDAegRxtdW5lZW5kcmEua3VtYXJAYnJvYWRjb20uY29tMBMGA1UdJQQMMAoGCCsG
AQUFBwMEMB8GA1UdIwQYMBaAFJYz0eZYF1s0dYqBVmTVvkjeoY/PMB0GA1UdDgQWBBTJvvnIS4Qf
Z+gEeC51xAB2l3lqOzANBgkqhkiG9w0BAQsFAAOCAQEAE6G8pLIpwrdO0Dmi603StqsNLN3t3i5m
SU/J+ZHnSeVNQFmfJjYSlZHSeAYrw+nsLEw08xiT4N2dPLbnowDKw0cVDRV5hL6+Uis2nqNkp9Kk
dXMVNlGeqGqBo98QRdRdzLgc/3FBQp3XIGUo2VDOMYW/RPbI1muHQOBKaVx4q8jqitNbqThvZkt/
t8KBiojEq4d7/scDRRtEsaL6Hl7cAYNMrS5EpijZrYjNYercaQNHcHP38l/XM9n36jllylt12koc
Dfj3D142STRRnexoNURmkc9EAKyZPRv/JRGz6YP0i2y1JqgpjF8CggD2osV3pA9e8ecXWQ7/ZJly
zHlFgjGCAmAwggJcAgEBMGswWzELMAkGA1UEBhMCQkUxGTAXBgNVBAoTEEdsb2JhbFNpZ24gbnYt
c2ExMTAvBgNVBAMTKEdsb2JhbFNpZ24gR0NDIFIzIFBlcnNvbmFsU2lnbiAyIENBIDIwMjACDEnR
Sel9Ku9INR0BhDANBglghkgBZQMEAgEFAKCBxzAvBgkqhkiG9w0BCQQxIgQggdxtxIqCWil/HlDY
yuMiKqoJHqjHcH9+P02toy21DuAwGAYJKoZIhvcNAQkDMQsGCSqGSIb3DQEHATAcBgkqhkiG9w0B
CQUxDxcNMjUwOTA0MDg1NzE5WjBcBgkqhkiG9w0BCQ8xTzBNMAsGCWCGSAFlAwQBKjALBglghkgB
ZQMEARYwCwYJYIZIAWUDBAECMAoGCCqGSIb3DQMHMAsGCSqGSIb3DQEBBzALBglghkgBZQMEAgEw
DQYJKoZIhvcNAQEBBQAEggEAYV/7iAJXLZ6Dby311gNWyy/JMxocSOVkO65OjLsR//DTX/Yz3gIg
dmKWyq5s7ZNaZLPv4ankMv8v/km9NohvUeWhwTVIJGXpuoY1GZBiFIKQFxPiBX7RMd2WgL5mO/9p
MPhYWb/nAsQcU4TkhDgurgqFaaZrM74/mmGugeWUmebnu/o4WTcKry5hA/OzDf6bmPCPK3mX9GWD
CPntG8Y6OByLmUFUuc4qVp3mREBqQHIJG9Our/GmaBB0tuHt0nV3xa1b/ZoNL/ITAG8/J+XASmkD
ACM+Houd6m4WUvI8y0o+gc5TX2k4CHAyFar/gmsVljiY3QwSteh6xFul05g+mQ==
--000000000000a7ea6c063df5e8ab--
