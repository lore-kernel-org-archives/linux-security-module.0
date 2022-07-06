Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B2EAC433EF
	for <linux-security-module@archiver.kernel.org>; Wed,  6 Jul 2022 15:51:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234124AbiGFPvH (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 6 Jul 2022 11:51:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234461AbiGFPuw (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 6 Jul 2022 11:50:52 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 039392AC79
        for <linux-security-module@vger.kernel.org>; Wed,  6 Jul 2022 08:47:38 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id i18so26600416lfu.8
        for <linux-security-module@vger.kernel.org>; Wed, 06 Jul 2022 08:47:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=EJFFlspLJbZWlOQgQAQBbAVkWdGZIDpDXjqFWYx9otk=;
        b=EReYmeXlMhMzLylXW6ZCBQUI6hMECRI79aRxtdUkHAJz91Z7pSKMm2znI6v/kI8qbt
         yPJqiK+vICWzWxH8qUaUjw2UDA91wkw7bqZEm6qdCSXx27mtVyCQ8DUd+tO6PUa60g5y
         jhNbyXmuwfsoo6tLqAYk8a06k8nD/7ucSjZM7f3/YzHxjQJNC0iSbefGBS8VVcHTl08X
         As907EbADr6VDUSG5wfIVoelGjkaRVBDYKIXpFToWzTX+GLSaiEgiCPbKzVLaZPBvzPE
         xV7gf8nJkyXz6PbNIirSCB9E19suozUk3+pshtawANlYqZWyJdyzVpwUUFwN2vGF9G1t
         LZCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=EJFFlspLJbZWlOQgQAQBbAVkWdGZIDpDXjqFWYx9otk=;
        b=S6B74+lpcVMzK5okkrAHu1Es77dxlguvfA3tawAj6XxBuyNtz+KVrtBay7TC+xLkVR
         VIGB+N2RCfcSr4BEAuezoEvy7NLWDCGQ8+TR6M+oAdpc3rUsniJ6BzHaaDGVy9YSL341
         +eML/TPe8Lt0GcvjlV2X9E7sr1qQLAbEu3GVxDcWv3AWHf6/gcsNi0/KRzlLJviXhGBz
         EeaFudcfMEwtkH/0M8aPfU9txfewUx5e+MxqFKPZrwUQwCI1bVFjMcQnfJCNWCaeZj4M
         MEvs/Q5PliJvNoInv03i0n6H0IubYX44KdXV43Klo32+Xfbi1u2Fz89xCXHrmSFMyoMC
         YbKg==
X-Gm-Message-State: AJIora+Jf6ovhi6OUjSobLAYi9l7rvCvtwmDNlvVusII5O9oazdotfKj
        eqaGehOpB2pIvRVrwjWqFGw=
X-Google-Smtp-Source: AGRyM1v5XygfKAU4yxblD00cVrGlbweuM7KMjNf9anOglGWYAkz620q8jPHDHUpjRF32hmC1GNnWNQ==
X-Received: by 2002:ac2:4f16:0:b0:47f:9437:43c9 with SMTP id k22-20020ac24f16000000b0047f943743c9mr27421060lfr.118.1657122455509;
        Wed, 06 Jul 2022 08:47:35 -0700 (PDT)
Received: from [192.168.0.101] (0855025014.static.corbina.ru. [89.179.245.198])
        by smtp.gmail.com with ESMTPSA id 5-20020ac25f05000000b004866226ea3csm366081lfq.256.2022.07.06.08.47.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Jul 2022 08:47:34 -0700 (PDT)
Message-ID: <1980b9da-fa51-44c8-9d8c-160e9bffd327@gmail.com>
Date:   Wed, 6 Jul 2022 18:47:35 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: LSM performance measurement
Content-Language: en-US
To:     Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        linux-security-module <linux-security-module@vger.kernel.org>
References: <CACE9dm-cNq+m04StHREnUj+r4Cf4z=dTaPN0odkYQSLb8KAmSw@mail.gmail.com>
From:   Igor Zhbanov <izh1979@gmail.com>
In-Reply-To: <CACE9dm-cNq+m04StHREnUj+r4Cf4z=dTaPN0odkYQSLb8KAmSw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Hi Dmitry,

On 06.07.2022 18:22, Dmitry Kasatkin wrote:
> Could anybody suggest a good approach/test suite to measure LSMs
> runtime overheads?

There are a couple of old articles on the same subject.
So, you can get some ideas from there:
- Evaluation of Performance of Secure OS Using Performance Evaluation
  Mechanism of LSM-Based LSMPMON
  http://www.swlab.cs.okayama-u.ac.jp/~yamauchi/research/sectech2010_yamamoto.pdf
- Analyzing the Overhead of Filesystem Protection Using Linux Security Modules
  https://arxiv.org/pdf/2101.11611

