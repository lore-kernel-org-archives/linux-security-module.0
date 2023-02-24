Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40CD2C6FA8E
	for <linux-security-module@archiver.kernel.org>; Fri, 24 Feb 2023 23:01:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229654AbjBXXBD (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 24 Feb 2023 18:01:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbjBXXBC (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 24 Feb 2023 18:01:02 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D467658D8;
        Fri, 24 Feb 2023 15:01:01 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id c18so759660wmr.3;
        Fri, 24 Feb 2023 15:01:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:from:references:cc:to:content-language:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9zKmwDf+aJ/7MI51ZiPSUnwnVBXbKjyIZ/JwViASkFg=;
        b=YSd+cZFKWsqxmjWU2RnNA1E8FgAAUZ2Gir0Ha/lW7E9ku0Ts+OIZ9mVhK5IrCA1vJo
         +tkBN4ntM/isVc6oHgw6w3Saal8yih3iBdfM7C6iXgOei/AL//RF8Zun50ErHFkIA7SL
         m7/fEhSKRHUOaDUQp3PJG8MD3Lu2ZttUio83raYs/QhamlyP5CNcb3rFYa89khP8olv7
         C94QjENtRzrBMcPFURn4SKcXEk7FuRgiVvJPZi5WnJgAKclfT9BC4vAQz5m1ex7G4xSP
         tvMqzSn9rmjYux1Jk2DZw508nqnsQGKw4b7MnWMy99ZqtdKF2Hg7VywAtBgSJOknKagA
         hMmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:from:references:cc:to:content-language:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=9zKmwDf+aJ/7MI51ZiPSUnwnVBXbKjyIZ/JwViASkFg=;
        b=XKIQ7JTcxa9IIv0xBbHjxwoI1BRefRPECkGtJ458hw9KiQRZF+0hSU9zFj4msUB75Q
         K6tajM0pZ2lrJw2MCOz8Kdcxe5WT7XZiBz4VRO/DsAo3IKITO6QUOdoL7WMR12zxqMu3
         NHMR2thLiWjbAxbuLZf29cdpTwcaKywNtYJ0q1ZLUbCmQ2aeZsOsE01ohreGRD96BgYd
         i41f9Y3J8z/J9EpLSSz3PX5HQkrGfflqMwID2UCfityUXUwQrWsPbHBf55JDUBF8wmwc
         0alqdkMDTatgQWUguWVaQkpujzXmFyZj5UfOQms43a4FFKpUGoeDTSNM9SNtPb3DEDCo
         vGAg==
X-Gm-Message-State: AO0yUKXF0Iih7Rz3hm78C59Jn6HB6vdkXL7qRM35oWuF0/TGarfqioub
        p4jfJKYgTXgIXY7qlybUymI=
X-Google-Smtp-Source: AK7set95wPJZwnfkKGkQ9Yi085YYwL/LuBs8HsCy9B+LFs854x4VMe+jhP2rLaPrQHVe7n3gsumdFQ==
X-Received: by 2002:a05:600c:181b:b0:3eb:2e2b:ff3d with SMTP id n27-20020a05600c181b00b003eb2e2bff3dmr1053857wmp.20.1677279659176;
        Fri, 24 Feb 2023 15:00:59 -0800 (PST)
Received: from [172.26.3.7] (240.red-88-26-240.staticip.rima-tde.net. [88.26.240.240])
        by smtp.gmail.com with ESMTPSA id n3-20020a5d4203000000b002c57384dfe0sm64619wrq.113.2023.02.24.15.00.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Feb 2023 15:00:58 -0800 (PST)
Message-ID: <f46d3b7f-71bf-7a5e-90b5-ab433f7253cd@gmail.com>
Date:   Sat, 25 Feb 2023 00:00:49 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v4] landlock: Clarify documentation for the
 LANDLOCK_ACCESS_FS_REFER right
Content-Language: en-US
To:     =?UTF-8?Q?G=c3=bcnther_Noack?= <gnoack3000@gmail.com>,
        =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>
Cc:     linux-doc@vger.kernel.org, linux-security-module@vger.kernel.org,
        Jonathan Corbet <corbet@lwn.net>,
        Paul Moore <paul@paul-moore.com>,
        Konstantin Meskhidze <konstantin.meskhidze@huawei.com>,
        Xiu Jianfeng <xiujianfeng@huawei.com>
References: <20230221165205.4231-1-gnoack3000@gmail.com>
From:   Alex Colomar <alx.manpages@gmail.com>
In-Reply-To: <20230221165205.4231-1-gnoack3000@gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------sLfvDcPF05zpLuqy3HnXm7w0"
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------sLfvDcPF05zpLuqy3HnXm7w0
Content-Type: multipart/mixed; boundary="------------BNSlSszZ5g8V8hkTXT0MZK8U";
 protected-headers="v1"
From: Alex Colomar <alx.manpages@gmail.com>
To: =?UTF-8?Q?G=c3=bcnther_Noack?= <gnoack3000@gmail.com>,
 =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>
Cc: linux-doc@vger.kernel.org, linux-security-module@vger.kernel.org,
 Jonathan Corbet <corbet@lwn.net>, Paul Moore <paul@paul-moore.com>,
 Konstantin Meskhidze <konstantin.meskhidze@huawei.com>,
 Xiu Jianfeng <xiujianfeng@huawei.com>
Message-ID: <f46d3b7f-71bf-7a5e-90b5-ab433f7253cd@gmail.com>
Subject: Re: [PATCH v4] landlock: Clarify documentation for the
 LANDLOCK_ACCESS_FS_REFER right
References: <20230221165205.4231-1-gnoack3000@gmail.com>
In-Reply-To: <20230221165205.4231-1-gnoack3000@gmail.com>

--------------BNSlSszZ5g8V8hkTXT0MZK8U
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

SGkgR8O8bnRoZXIsDQoNCk9uIDIvMjEvMjMgMTc6NTIsIEfDvG50aGVyIE5vYWNrIHdyb3Rl
Og0KWy4uLl0NCg0KU29ycnkgZm9yIHRha2luZyBzbyBtdWNoIHRpbWUgaW4gbG9va2luZyBp
bnRvIHRoaXMhDQoNCj4gKyAqDQo+ICsgKiAgICogVGhlIHJlcGFyZW50ZWQgZmlsZSBtYXkg
bm90IGdhaW4gbW9yZSBhY2Nlc3MgcmlnaHRzIGluIHRoZSBkZXN0aW5hdGlvbg0KPiArICog
ICAgIGRpcmVjdG9yeSB0aGFuIGl0IHByZXZpb3VzbHkgaGFkIGluIHRoZSBzb3VyY2UgZGly
ZWN0b3J5LiAgSWYgdGhpcyBpcw0KPiArICogICAgIGF0dGVtcHRlZCwgdGhlIG9wZXJhdGlv
biByZXN1bHRzIGluIGFuIGBgRVhERVZgYCBlcnJvci4NCj4gKyAqDQo+ICsgKiAgICogV2hl
biBsaW5raW5nIG9yIHJlbmFtaW5nLCB0aGUgYGBMQU5ETE9DS19BQ0NFU1NfRlNfTUFLRV8q
YGAgcmlnaHQgZm9yIHRoZQ0KPiArICogICAgIHJlc3BlY3RpdmUgZmlsZSB0eXBlIG11c3Qg
YmUgZ3JhbnRlZCBmb3IgdGhlIGRlc3RpbmF0aW9uIGRpcmVjdG9yeS4NCj4gKyAqICAgICBP
dGhlcndpc2UsIHRoZSBvcGVyYXRpb24gcmVzdWx0cyBpbiBhbiBgYEVBQ0NFU2BgIGVycm9y
Lg0KPiArICoNCj4gKyAqICAgKiBXaGVuIHJlbmFtaW5nLCB0aGUgYGBMQU5ETE9DS19BQ0NF
U1NfRlNfUkVNT1ZFXypgYCByaWdodCBmb3IgdGhlDQo+ICsgKiAgICAgcmVzcGVjdGl2ZSBm
aWxlIHR5cGUgbXVzdCBiZSBncmFudGVkIGZvciB0aGUgc291cmNlIGRpcmVjdG9yeS4gIE90
aGVyd2lzZSwNCj4gKyAqICAgICB0aGUgb3BlcmF0aW9uIHJlc3VsdHMgaW4gYW4gYGBFQUND
RVNgYCBlcnJvci4NCj4gKyAqDQo+ICsgKiAgIElmIG11bHRpcGxlIHJlcXVpcmVtZW50cyBh
cmUgbm90IG1ldCwgdGhlIGBgRUFDQ0VTYGAgZXJyb3IgY29kZSB0YWtlcw0KPiArICogICBw
cmVjZWRlbmNlIG92ZXIgYGBFWERFVmBgLg0KDQpJcyB0aGlzIHNvbWV0aGluZyB3b3J0aCBn
dWFyYW50ZWVpbmcsIG9yIGp1c3QgYW4gaW1wbGVtZW50YXRpb24gZGV0YWlsIA0KdGhhdCBt
YXkgZWFzaWx5IGNoYW5nZT8NCg0KQ2hlZXJzLA0KDQpBbGV4DQoNCj4gICAgKg0KPiAgICAq
IC4uIHdhcm5pbmc6Og0KPiAgICAqDQo+IA0KPiBiYXNlLWNvbW1pdDogYzljMzM5NWQ1ZTNk
Y2M2ZGFlZTY2YzY5MDgzNTRkNDdiZjk4Y2IwYw0KDQotLSANCjxodHRwOi8vd3d3LmFsZWph
bmRyby1jb2xvbWFyLmVzLz4NCkdQRyBrZXkgZmluZ2VycHJpbnQ6IEE5MzQ4NTk0Q0UzMTI4
M0E4MjZGQkREOEQ1NzYzM0Q0NDFFMjVCQjUNCg0K

--------------BNSlSszZ5g8V8hkTXT0MZK8U--

--------------sLfvDcPF05zpLuqy3HnXm7w0
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE6jqH8KTroDDkXfJAnowa+77/2zIFAmP5QaEACgkQnowa+77/
2zK9Lg//dM1Z7GVINOIsXHdiIF8EqheniaejDLUJB+5yMpBzomah0A6mkjAdYnrt
10eOk5CXuSifJcpCz6oJ70NtzWeQhjRrUHF1s/hC7ZPHZBCJj1jQeb/zlmLru/JK
YAcx4ut5g6BW3de9uOb5MZLQUHxUzkmho9hZUPylYyX6NzfWK9CK0AwRj//x5Jqs
L1TZUJ2w8Sw7heXP0G7g896Crw9mDebLaKK27jDTb5K1jOEnMK1SyX5Vd9ErnRH3
dLENYIIpZwR5YRBEb31XB3HCrvtf0Z91SBdtXi0TZv5cceiqjA+jz4tpYZeuqmpy
AwJOh07heOa9iWBBVcH4Xv+sRgKCbtPtJ4qfvdmYpuMwRYaAqpJE8DZZV3fNz8px
rKrs+WR5VEH2QaX/rMQDFLdZ2MaAVNutVIiGFKdeg+UbUogmMtBsAi2iPiRUG3dt
SfPx1CwDnS4mpTDDqbfUzjxCuAJBN06Wfc9aFeDVlVnng/66H4Emd3ybdPsO8AG2
5VC9nQQnio3OOBvBPEKLHKUyBc3aPYpkS6sXFOFB0SbWh83H/t31OLI2zzes0LiH
XufagwUTpDaWM1U8qSgOekzneUL+EpCDhsH9d/cyFQP0EhNFc/VRJ/FjYx6DSnrO
mVi66dtGkfVkrsJl1uomCar63Sy9Tdc/ny9B8fzM6Xpim5LK7zU=
=ibGO
-----END PGP SIGNATURE-----

--------------sLfvDcPF05zpLuqy3HnXm7w0--
