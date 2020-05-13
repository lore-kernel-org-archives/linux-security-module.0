Return-Path: <SRS0=p5JF=63=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4DD5C433E0
	for <linux-security-module@archiver.kernel.org>; Wed, 13 May 2020 19:41:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 657D520659
	for <linux-security-module@archiver.kernel.org>; Wed, 13 May 2020 19:41:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="LatWmSXj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390784AbgEMTlK (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 13 May 2020 15:41:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2390735AbgEMTlK (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 13 May 2020 15:41:10 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F721C05BD09
        for <linux-security-module@vger.kernel.org>; Wed, 13 May 2020 12:41:10 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id l11so988975wru.0
        for <linux-security-module@vger.kernel.org>; Wed, 13 May 2020 12:41:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=m9izSOZDzA62EkVIVJaM9RQB78HtwGR7Vc4fH0Cr3MY=;
        b=LatWmSXjR+eXddCxx4Fpk4fo9igRHLhD0wdivRc/eNsLlnnZs5nWsT8gJG8meyHtw4
         UUQkcffYPMX4wdRgrMtJsNtJX3jUTj4ye3jBgUQduaGLLcqEOsJSw4CXVNHD0b8AxF3i
         nGGoOxnAcHym+F6QKUhTXu1sRVeypKEn8nPbQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=m9izSOZDzA62EkVIVJaM9RQB78HtwGR7Vc4fH0Cr3MY=;
        b=GN4L3hNNqkgGvJXvfjR2dmAhVd1jp3VSdKjh2z72XzZr5Iz+cQ8xB+W8GqJbPt2OfT
         jxuGUOQM6LW0SZHHxoimpMMBMi4CMxljTdyFBCUrvO/zjAlfx2EAuJyHtadcG6UqXTiZ
         uI01Coctq9jONz8i5QoczLc1Kd96kqS76TAaPtm6OmnzeQGENcSiyYBV6IR1i64bd6Cs
         y4VbZ/J8kgkmgZL/y+bpzivRwRW1Z2q3X3Xk7rr3iI0rz55/VxXWwLAGds1FD7TP3l8H
         MK6bTYFlb0O/XaX0vfHUI+LG1WINzlJzEHagXuRkjGwgrsnGBa0keJY6q/s/Z0rx0YVZ
         RA8A==
X-Gm-Message-State: AOAM5307f6/zKR4Prg7nioyd9EzjIiYzBJdzHVV9SJBN2/i60vFY056p
        PA0aMjKWONc2Pcz9+DfHbUe37Q==
X-Google-Smtp-Source: ABdhPJwAFFVlJnMtr4CXEiXONgk4Jd3OlSsLP62BuGb86vDdhyyIRrvNuimetMcYerb/TfC75/UB2g==
X-Received: by 2002:a5d:4950:: with SMTP id r16mr1048168wrs.350.1589398868576;
        Wed, 13 May 2020 12:41:08 -0700 (PDT)
Received: from [10.136.13.65] ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id n9sm15165510wmj.5.2020.05.13.12.41.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 May 2020 12:41:07 -0700 (PDT)
Subject: Re: [PATCH v5 1/7] fs: introduce kernel_pread_file* support
To:     Mimi Zohar <zohar@kernel.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        David Brown <david.brown@linaro.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Shuah Khan <shuah@kernel.org>, bjorn.andersson@linaro.org,
        Shuah Khan <skhan@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>,
        Olof Johansson <olof@lixom.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Colin Ian King <colin.king@canonical.com>,
        Kees Cook <keescook@chromium.org>,
        Takashi Iwai <tiwai@suse.de>, linux-kselftest@vger.kernel.org,
        Andy Gross <agross@kernel.org>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        linux-integrity <linux-integrity@vger.kernel.org>
References: <20200508002739.19360-1-scott.branden@broadcom.com>
 <20200508002739.19360-2-scott.branden@broadcom.com>
 <1589395153.5098.158.camel@kernel.org>
 <0e6b5f65-8c61-b02e-7d35-b4ae52aebcf3@broadcom.com>
 <1589396593.5098.166.camel@kernel.org>
 <e1b92047-7003-0615-3d58-1388ec27c78a@broadcom.com>
 <1589398747.5098.178.camel@kernel.org>
From:   Scott Branden <scott.branden@broadcom.com>
Message-ID: <a228ae0f-d551-e0e8-446e-5ae63462c520@broadcom.com>
Date:   Wed, 13 May 2020 12:41:01 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <1589398747.5098.178.camel@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>



On 2020-05-13 12:39 p.m., Mimi Zohar wrote:
> On Wed, 2020-05-13 at 12:18 -0700, Scott Branden wrote:
>> On 2020-05-13 12:03 p.m., Mimi Zohar wrote:
>>> On Wed, 2020-05-13 at 11:53 -0700, Scott Branden wrote:
>> Even if the kernel successfully verified the firmware file signature it
>> would just be wasting its time.  The kernel in these use cases is not always
>> trusted.  The device needs to authenticate the firmware image itself.
> There are also environments where the kernel is trusted and limits the
> firmware being provided to the device to one which they signed.
>
>>> The device firmware is being downloaded piecemeal from somewhere and
>>> won't be measured?
>> It doesn't need to be measured for current driver needs.
> Sure the device doesn't need the kernel measuring the firmware, but
> hardened environments do measure firmware.
>
>> If someone has such need the infrastructure could be added to the kernel
>> at a later date.  Existing functionality is not broken in any way by
>> this patch series.
> Wow!  You're saying that your patch set takes precedence over the
> existing expectations and can break them.
Huh? I said existing functionality is NOT broken by this patch series.
>
> Mimi

