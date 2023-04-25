Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46E7CC6FD18
	for <linux-security-module@archiver.kernel.org>; Tue, 25 Apr 2023 19:12:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234881AbjDYTMr (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 25 Apr 2023 15:12:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234807AbjDYTMo (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 25 Apr 2023 15:12:44 -0400
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 366D917DC3
        for <linux-security-module@vger.kernel.org>; Tue, 25 Apr 2023 12:12:43 -0700 (PDT)
Received: by mail-io1-xd34.google.com with SMTP id ca18e2360f4ac-760dff4b701so35693439f.0
        for <linux-security-module@vger.kernel.org>; Tue, 25 Apr 2023 12:12:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20221208.gappssmtp.com; s=20221208; t=1682449962; x=1685041962;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nm/Z08Qpc4xJ1wGItB99tey8UIwra1lRMlRZ9zrzBPc=;
        b=OiRIavseMauKAEUtXkh7JKfcWJgVJMo2NFL3AlOZoYNSHaSmaKc09/PMTDMcoHdfG1
         Zg+L0Ni6fevfucvuDmaWeEZAazhPqldDSLyNSlDmEuLdydZQ2yy9TUMRcoI1HlilLzYY
         n2AUUDc5wGJ8i7y0v1pvB7c64FY4brgRaS2adob9q1jl2iqW89RTsALIlIlRIMIuq/Ht
         M60IGvHSkgkcSWt/gkYchd+m1xgdbsGQD9UlUC9BXrEkWBThlOpCXzBAlyOOFquk5sIG
         gID0XLPNKeXl7gSIzakIpytEM94g6L04b7KdVIL37AUVSMJoMuOaFBqXZWgOSyfyGfA3
         NGIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682449962; x=1685041962;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nm/Z08Qpc4xJ1wGItB99tey8UIwra1lRMlRZ9zrzBPc=;
        b=UR8qXcNs74gnQe2l6EA0ejAaKpboEdttd3CvzXMq0SB/qfCJIubNf28Zy73/bPrTWI
         NlGkEMd24CryyZPZgBXzqJAYjrBNUwAjBGtRICzQeE9y9Pe4PJ3jXzujVV1P9vKRn2yC
         ++Uf2jF+LSSSIfw2AzvEHvV9hHRqixc40Ib6WGYCuonZvUBI5HiW8Sv6Kw5Fk0dkftZL
         /lA+BQpD3hbdUi4TaqkxQY+ueDsiWX2hXplHNDiyKvKjODzL4qnUVa30zxy9ZAQi+mlc
         tXwxLDG9+ZCADGf+wVigaRPmsqfZaHnUmbgvyO1bIpKpaEfabjZ0iStmU2IE0LQhvUph
         xS2w==
X-Gm-Message-State: AAQBX9cO3+EGOUNHqGjlUaLFoOg8s7oyF2wg1pQ9FVAdFXkTp1aZde2O
        df6kKIGUUJHfS6DxRtWBsUVWsw==
X-Google-Smtp-Source: AKy350bBFu9+ThvBG9nd8IvRG+SsH1G8UJ7BBrVNqOYtp46eE8WfkBbY1hYEANxLctC3005MdoF+mA==
X-Received: by 2002:a05:6602:1555:b0:763:6aab:9f3e with SMTP id h21-20020a056602155500b007636aab9f3emr14566464iow.1.1682449962549;
        Tue, 25 Apr 2023 12:12:42 -0700 (PDT)
Received: from [192.168.1.94] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id u11-20020a02230b000000b00411a1373aa5sm3304560jau.155.2023.04.25.12.12.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Apr 2023 12:12:37 -0700 (PDT)
Message-ID: <30ab7555-8f36-cfb7-9101-0ebb92af3c2f@kernel.dk>
Date:   Tue, 25 Apr 2023 13:12:36 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH V4 2/2] blktrace: allow access trace file in lockdown mode
To:     Junxiao Bi <junxiao.bi@oracle.com>, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-block@vger.kernel.org
Cc:     paul@paul-moore.com, nathanl@linux.ibm.com, jmorris@namei.org,
        serge@hallyn.com, konrad.wilk@oracle.com, joe.jin@oracle.com
References: <20230420215331.88326-1-junxiao.bi@oracle.com>
 <20230420215331.88326-2-junxiao.bi@oracle.com>
 <05b3eebd-7a3f-13d5-1fe9-8f4ab3080521@oracle.com>
Content-Language: en-US
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <05b3eebd-7a3f-13d5-1fe9-8f4ab3080521@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On 4/25/23 11:55?AM, Junxiao Bi wrote:
> Any IO folks can help review this patch?
> 
> Paul needs a confirm from you that the information blktrace exporting
> to userspace through the relay files are safe, not leaking information
> that userspace shouldn't know in lockdown mode.

I don't know anything about what lockdown is, but in terms of blktrace,
it is a way to trace meta data associated with IO. It'll tell you things
like "task T wants to {read,write} on device D, at offset X, and of size
Y". For passthrough IO, it'll also dump the CDB. There's never any
actual data traced.

-- 
Jens Axboe

