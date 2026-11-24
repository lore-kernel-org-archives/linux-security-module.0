Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.215.177
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795540255;
	b=hg/dmAl0CPe+LU4eDQ9NkniQ5+ZUGKDdlMQq6R87l3rxVN1DSJbuPs40j9pH666HorSo
	 G2HiIHIpgGMhWjLHKJtZ/sT+Q7X9IVEg8Cp0uNrvXa3da9zsG7OdJvp5G869KKIK1E69M
	 0Qzx7SJiC+8tK3N3JP7HPAOLvZMOgSkkavdJzUimlH0Di8U6ZwIqsZM+ugca9urUlYWs/
	 ctowQh61Zsp70glZ4AmhVxMm+vc4k1OkwCqmqb8cn9vzuV2Jc6rEXeEIh14sfalTCh10I
	 mKPY5SXWT2oIaEnRPEkzxa8NoRDpMMNikT/FU57vZ3DBhkuDpcBRyZfQxJ053gToYdQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795540255;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=YD659iZbhB9OAfnpI+8tlGtmEiCdl2kb0qCNC7Yp8ls=;
	b=V5vsbyybJvRFz1frZPCSFryQPjg5HA0x+HvNg2IL5UZpKu7KScxzm287KzjeYWjZdvN3
	 KQFGS1DjQMwakFBCamFH7ylLGw+/XvKkgEinGc0DdIiQCSCwl18W2AjEb7CXGNQ/CJcu8
	 7DxGjibj5t424V3GuM/0UpvlYO8Vm9Y6zXu898w+p5WQTIyPp/cXXBT/RW8vgQfmGVKeN
	 i7DpCAHQGGv6/EVImQuq6xHaRsO1WJ9xbiWQBlNxrdtX+W9Eqqc3avnrbM+nrRnJXa6d+
	 ys2+TyLIsmii16rsjHeSRCYRiXG3ppYg9GqEXYXXMmx+OQe7R/OTXCxzRa+6zan+OJQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=paul-moore.com;
	spf=pass smtp.mailfrom=paul-moore.com;
	dkim=pass header.d=paul-moore.com header.i=@paul-moore.com header.a=rsa-sha256 header.s=google header.b=XGZP1B9e;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.215.177
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA44E606E145
	for <linux-security-module@vger.kernel.org>; Tue, 24 Nov 2026 17:10:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AA44E606E145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.a=rsa-sha256 header.s=google header.b=XGZP1B9e
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-cc4be0e5351so3851043a12.0
        for <linux-security-module@vger.kernel.org>; Tue, 24 Nov 2026 09:10:54 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795540254; cv=none;
        d=google.com; s=arc-20260327;
        b=f5xiXSZSRlWBpvge0YkTFBl5ONOAy33GkKvi2u/XHk5oP7U1n7yInXHKQns2xKXQD2
         HeS2TcWEYPGAW8RdNOSsclc3/3Le/lMuAA4vOKTDHvmSE9DTVDU6SitL0wJVnedju+F2
         GzmW8eNmz0fOIE2ArZ/anKMBw1H5BHrNT605tCOoFSD3tfSYwfg7WJHRdUKCoTIEUG4r
         bqNHlRADpNxeXOrL0AsHhTPbCqktwt99L9WSfLAeOm63zTckyT2/lOLQxrRVu6QvqTff
         CmjmMTI4BxWnOwhKS8iFHMsmOBflFNcX6EFM1ZDSNtC4vqlGpycRdlHiL+LW/rEccryD
         mmdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=YD659iZbhB9OAfnpI+8tlGtmEiCdl2kb0qCNC7Yp8ls=;
        fh=kQmiiw/mGhjvHtG2AfM/9j2D9XYyNb9MibBcBP3Ko2g=;
        b=ZiZe1fqsnZX3I9EtD6WmXSG6lvbBk3JCmTX6k+yuBAOtoLnA3Q6iUv/+fMr0CoyfMZ
         HzJecWJhmAyjyzeuZD+Ctwzo6ZHJgNgGqa7q1d1t03uB+u+r4J+ZhEVOhQE+LJEMNnJ6
         WVAqcCF7Oy5qmTndxtb08//KJMTWpOKHqac8kyAs20riBd1xkb+85vNhk9FZPe1IxcKN
         UQZXWivM7ffzeCSjTuivQ64Xnwzx20Gn9JEdxC5TjXyuEgbttMcl+eWl7+JrXwTn3kU8
         ap2M3LiytHKCe+Pj4Wl5kkDGCi6m/Kp7nlyMrXe8WxJC5M+rHPdlwzhGsCILGWNi0YUt
         3EnA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1795540254; x=1796145054; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=YD659iZbhB9OAfnpI+8tlGtmEiCdl2kb0qCNC7Yp8ls=;
        b=XGZP1B9ebdkS8ePIk89ZuzQ1iCcHMbjCNYVdkW1Ikavfb7BfPm2cIFvIY/wrKRe72B
         sgtUsrG0y94ks58sAPWoPUZbaXTVzgig7BodyAWi6buZ0/NCmjX8E7Xfnq/JXDVG1uOG
         gZmhWdPv5Y4dY390ZwAB3s+ccss4ZSLw2/FwNYsfSGt8q4qrX7ZMBdKbJIYEOW8LtS7z
         Npr7U/WjzZAIMnhBXhD2TiYX3sPVYyxAi7D7cu4ltg1q/lUVnLTeEwduU2vlu+2Pccuk
         wuolouFPHsPqHmaPGaztToyeO/jvTkDu6eHV/VvaKPn2hibcKXvDCckQQZ30iZidEfwA
         ic6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795540254; x=1796145054;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YD659iZbhB9OAfnpI+8tlGtmEiCdl2kb0qCNC7Yp8ls=;
        b=t9i+1cVCBgK7Yv4Ceq0cj8j4VJOndBmQblzaFJ5WHiHCjNBT8wgLmtfDkhf5P2g4VS
         Ylmn1qHUyNLmJlwHm3JIJsItW6do47f4eEwC/wIVCUBUDI/ULCM4RSF3bDfjdj4A2Nar
         by71u6m3lgxuNt/hiaDUFhakFv9Ox3c9xIyNL8OC6VXLAU5LKO8uTr+vrtf4Qbfdd8zh
         Tv46oNlBNkuAbcu+52wOjIBNGO2T1Riv1H/A0lwKvOnDzxm7yXpxDnYYwQeZWmSdODkF
         A0Gw5ntj+9BTGaI4X0H+Khd4A13cUVwnqg3SEPS2J9mV8R882D4aLbFNHghmaMrySlA4
         y7Lw==
X-Forwarded-Encrypted: i=1; AL+hErHJZXII5c5/uHl0WfU0HqYjPqnumuPeOwxb85G7EQXjzAdNs1CnSEwF3XDVRHLLwnU50hwLNMUh2PudHnR2Vs+BNEVsj1w=@vger.kernel.org
X-Gm-Message-State: APuU4Z8yMmTBXsbp12IMAWmOZN7qF4WzXCAgT2JyJ+QBlEHyhNcrexuG
	b9VKgoNIMSHsSuwDA1SVqw2uPpirD6Nnkq9xFap/lXSwOewOInP9AJ/CfNBIyfWSeDl4UnzQbC1
	KzODH1yWExi4UYY5YH1BB4USmMj5EBOac5unv6VgtCvsgfrePK0nI+A==
X-Gm-Gg: AZFdTZddRoqUTKB6PxtMRiBrhdXHdkov7ufiRpHe0NmEmFTmjnppW+8juOn3ttSeQ+c
	zFowBnssBycQb7ORAWXnPgF/t+StTL75/+GSUPUnq9YA1t7ROgNsa97Ov7MhcpOjrmog4cnIy9X
	ozQ6q3JrpVIYdC78gj3uB0M4bpDaTehHjxAHcoPjRXVkuTeM5y9wtWqxVCooeal388uaAg+GNnl
	FUyoy22J5QKtlWz2u53BgIa/WgHy/b+aN4bFLofSdRcaemnuD1fEnKNT3weB05fwI97C6N/0ioE
	9uKuWKApWXYMUfxXWmKbhbq+HH6k+3xnlskgFsFUP7uFIu+sGM9cncBA351JxjU8rKQYzFaGqKL
	tkPpx8P3ztcyZWNN0m57Jc6isTAVlm4+BrLQHBw7c2Dnn+n7EnVVr7iJObMl/1U5TFTXH
X-Received: by 2002:a17:90b:50:b0:3b0:9e2c:9b5f with SMTP id
 98e67ed59e1d1-3b41c7b6044mr14858398a91.2.1795540253878; Tue, 24 Nov 2026
 09:10:53 -0800 (PST)
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261123-x25-v1-1-4432d3892f8b@gmail.com> <c70bad57add6ff8cd52125c698f3f54a@dev.tdt.de>
In-Reply-To: <c70bad57add6ff8cd52125c698f3f54a@dev.tdt.de>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 24 Nov 2026 12:10:41 -0500
X-Gm-Features: Aa3M54pQl1423xvicd2W8eKUxg-iwZ3pBcyz1tFldZ8tVNfr4v2hJioLBtMFymY
Message-ID: <CAHC9VhTLg2FLNf3sLe3+A=q5Mo4gKs+gB7zi5sQT1jizsOPuNQ@mail.gmail.com>
Subject: Re: [PATCH net] net/x25: inherit the listening socket's security
 label on accept
To: Martin Schiller <ms@dev.tdt.de>
Cc: shyckless@gmail.com, davem@davemloft.net, kuba@kernel.org, 
	edumazet@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org, 
	linux-x25@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, stevewong@hust.edu.cn, 
	kaixuan.li@ntu.edu.sg
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 23, 2026 at 11:44=E2=80=AFAM Martin Schiller <ms@dev.tdt.de> wr=
ote:
>
> On Mon, 23 Nov 2026 01:31:20 +0100, Suyuan Wang wrote:
> > x25_make_new() creates the socket that accept() returns by copying
> > fields from the listening socket, but it never clones the listening
> > socket's LSM security state -- there is no security_sk_clone(osk, sk).
>
> Thanks!
>
> Acked-by: Martin Schiller <ms@dev.tdt.de>

My apologies, but I'm about as X.25 ignorant as possible, so a quick
question: the x25_make_new() function is called by
x25_rx_call_request(), which as far as I can tell is on pretty
analogous to an accept() operation, is that correct?

If that's the case (x25_rx_call_request() acting similar to accept()),
cloning the listening socket's LSM data makes sense, but if it's
something else we may want to leave the new socket as-is, labeled by
the process performing the operation.

--=20
paul-moore.com
