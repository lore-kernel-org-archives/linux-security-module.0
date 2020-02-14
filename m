Return-Path: <SRS0=+399=4C=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98CC9C3B1A6
	for <linux-security-module@archiver.kernel.org>; Fri, 14 Feb 2020 17:40:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7654620873
	for <linux-security-module@archiver.kernel.org>; Fri, 14 Feb 2020 17:40:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="scFiUdiF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729268AbgBNRkQ (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 14 Feb 2020 12:40:16 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:33130 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390031AbgBNRkI (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 14 Feb 2020 12:40:08 -0500
Received: by mail-pf1-f195.google.com with SMTP id n7so5223741pfn.0
        for <linux-security-module@vger.kernel.org>; Fri, 14 Feb 2020 09:40:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=3eXuOgfEolpkZ5hPj8gcQuPTURlTdrMwkoy/D3yOIvc=;
        b=scFiUdiFkMp38HNXCebJUGM5/Xev4sTfpdTyi+eIORpvxEE0NyI4nWVBHUHdSXuU5d
         RiPBBexlo3EQIACh+gtrdkaprcMAxzHOwE42W3z3TOHhCccOugoonMcadDsGExGx24pZ
         H5/pvCKDjTt4FVP9c5g/C0+RgXXbdQ1Xqk7FmQlbb6AZ5h2ILWTjgqWfIwcHgBV+L7JY
         TSCYm2FabsMtQ8YOEMv0D3S/L1piI0FOoF1PWbmE6EHuG+gpgg4BZW4kiiK6A07bGmUH
         FXPJ4y0WsutSbFR4CDk3jDnnfWv6EdKE+piowBnqUmvtaAu45SrnpvEWExNeyJp8gdnO
         cUZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=3eXuOgfEolpkZ5hPj8gcQuPTURlTdrMwkoy/D3yOIvc=;
        b=k4guTXNd4Yuezghso01EEn/YpC4rzL1e8O3udiL275uyITQVBcPRuwQRZhzYtvflab
         Go7up87y5CMBVP5U9Gb9/thbfEHhaqrSidIcLXVXxU2RtQC0x8q3Ht3yOtWqxa4w6b2y
         OwDT1yRVE6mxs6LeaaoVSshuVL6sbOdT42SAc7nd1Vjy1lc1zt/OL2/jePgugJ1NS8+3
         +9pxgHcWPcFkjeiOQIT1bd7d2g3M4Cje3IEF4OB2RZbqocX3qFdjLKP9/FNH6BusvjVo
         ZshXzEQaL6Y7IsXtlo12A/OcnjxYBKSCOb3wvKGCnak69r1yJVjfnYcBaig1JAuPd9dJ
         4nog==
X-Gm-Message-State: APjAAAXEAifMJ1sgsCPEN67eHrqaabCooB/VRDr9/lfJe2FqA5Xxp2r9
        e+jNvDjAZcuWNbmnESDY+4QXkw==
X-Google-Smtp-Source: APXvYqw6w4pf9w58UmNm5LBUCfGCa8I1IoNvSrGAdVzQAvVkPnOFhecSxwSGlrlAdNuVi3wRbquU2g==
X-Received: by 2002:a63:f40d:: with SMTP id g13mr4919987pgi.374.1581702007228;
        Fri, 14 Feb 2020 09:40:07 -0800 (PST)
Received: from ?IPv6:2600:1010:b013:3558:61dd:b73f:191c:9246? ([2600:1010:b013:3558:61dd:b73f:191c:9246])
        by smtp.gmail.com with ESMTPSA id h3sm7424340pfo.102.2020.02.14.09.40.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Feb 2020 09:40:06 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Andy Lutomirski <luto@amacapital.net>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v26 10/22] x86/sgx: Linux Enclave Driver
Date:   Fri, 14 Feb 2020 09:40:00 -0800
Message-Id: <D18DD438-2458-4264-9D56-A05EB84BB545@amacapital.net>
References: <20200214171146.GD20690@linux.intel.com>
Cc:     Jethro Beekman <jethro@fortanix.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-sgx@vger.kernel.org, akpm@linux-foundation.org,
        dave.hansen@intel.com, nhorman@redhat.com, npmccallum@redhat.com,
        haitao.huang@intel.com, andriy.shevchenko@linux.intel.com,
        tglx@linutronix.de, kai.svahn@intel.com, bp@alien8.de,
        josh@joshtriplett.org, luto@kernel.org, kai.huang@intel.com,
        rientjes@google.com, cedric.xing@intel.com, puiterwijk@redhat.com,
        linux-security-module@vger.kernel.org,
        Haitao Huang <haitao.huang@linux.intel.com>
In-Reply-To: <20200214171146.GD20690@linux.intel.com>
To:     Sean Christopherson <sean.j.christopherson@intel.com>
X-Mailer: iPhone Mail (17D50)
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>



> On Feb 14, 2020, at 9:11 AM, Sean Christopherson <sean.j.christopherson@in=
tel.com> wrote:
>=20
> =EF=BB=BFOn Fri, Feb 14, 2020 at 10:24:10AM +0100, Jethro Beekman wrote:
>>> On 2020-02-13 19:07, Sean Christopherson wrote:
>>> On Thu, Feb 13, 2020 at 02:59:52PM +0100, Jethro Beekman wrote:
>>>> On 2020-02-09 22:25, Jarkko Sakkinen wrote:
>>>>> +/**
>>>>> + * struct sgx_enclave_add_pages - parameter structure for the
>>>>> + *                                %SGX_IOC_ENCLAVE_ADD_PAGE ioctl
>>>>> + * @src:    start address for the page data
>>>>> + * @offset:    starting page offset
>>>>> + * @length:    length of the data (multiple of the page size)
>>>>> + * @secinfo:    address for the SECINFO data
>>>>> + * @flags:    page control flags
>>>>> + * @count:    number of bytes added (multiple of the page size)
>>>>> + */
>>>>> +struct sgx_enclave_add_pages {
>>>>> +    __u64    src;
>>>>> +    __u64    offset;
>>>>> +    __u64    length;
>>>>> +    __u64    secinfo;
>>>>> +    __u64    flags;
>>>>> +    __u64    count;
>>>>> +};
>>>>=20
>>>> Compared to the last time I looked at the patch set, this API removes t=
he
>>>> ability to measure individual pages chunks. That is not acceptable.
>>>=20
>>> Why is it not acceptable?  E.g. what specific use case do you have that
>>> _requires_ on measuring partial 4k pages of an enclave?
>>=20
>> The use case is someone gives me an enclave and I want to load it. If I d=
on't
>> load it exactly as the enclave author specified, the enclave hash will be=

>> different, and it won't work.
>=20
> And if our ABI says "thou shall measure in 4k chunks", then it's an invali=
d
> enclave if its author generated MRENCLAVE using a different granularity.

ISTM, unless there=E2=80=99s a particularly compelling reason, if an enclave=
 is valid, we should be able to load it.=
