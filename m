Return-Path: <SRS0=axxp=AS=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B7B8C433DF
	for <linux-security-module@archiver.kernel.org>; Tue,  7 Jul 2020 23:59:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 06E3C2073B
	for <linux-security-module@archiver.kernel.org>; Tue,  7 Jul 2020 23:59:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="LafhCb4t"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729412AbgGGX7m (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 7 Jul 2020 19:59:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729415AbgGGX7l (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 7 Jul 2020 19:59:41 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DACEC08C5E2
        for <linux-security-module@vger.kernel.org>; Tue,  7 Jul 2020 16:59:41 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id t6so20787559pgq.1
        for <linux-security-module@vger.kernel.org>; Tue, 07 Jul 2020 16:59:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=t+MUHlMV05Venpi+dxgNFy9m2mM7Us7wpJwUgu+0RIA=;
        b=LafhCb4tq/+15NiiNOG2BKxCpeSoxaozRMft+310cV24Ytgchd8f5pyzQOSHeWZXfw
         sY1Dm+QXQug+61+HPKC9CsVVEyxHf9zqWNxuuTHnNPhg66oQiL6GpDh7ADEmoCmMSf41
         2+4zCqnrVxslrHZBmUrwZXf+GBK3TOSDNm1TQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=t+MUHlMV05Venpi+dxgNFy9m2mM7Us7wpJwUgu+0RIA=;
        b=gddRzMo9nH4X5q75+WwEd6IFv9UTwFc5o1CDomd5ArGB3r2VuJ5cCwUL87dPBCtxIM
         ZwZ8bx7uFzvPP+9CJsOMO2EJNe23dRTrxFXRJAvV96uWUMqlMcGAk6PDR1gchqfuUmhq
         IGNk8XVKGN+BoaoKudtvFdYXZT5aBSO4nY90urbas3s+UevUgSW2j+B3bekv76xSp+sn
         EtJ5SguN9AgjpP56FJGQRCXnaIKDBbFw3GsY61jiQB12JXftAHD/CpzvTGvLBv5UXAsf
         /3+XbpiAq2saxIhY3OPnWEweCzL7UN7H9PITF1HRPBwnD3TfKNT7XJyHFrCnzThB8WHg
         K1Xg==
X-Gm-Message-State: AOAM530gGHa7mPx2mSZyimwnnOisCHFd2KQfeGe2h5gIAcLMx/KAOPfV
        zRtxXkeAUDR/6f9XIPqgith0AA==
X-Google-Smtp-Source: ABdhPJxrg7MIOsckToNcEU8cl8R/PG88U4PcKuHFAM793HgSei/rQl//+UCXuWhNnVDpB4swbIRxQw==
X-Received: by 2002:aa7:8651:: with SMTP id a17mr44429243pfo.48.1594166381010;
        Tue, 07 Jul 2020 16:59:41 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id 66sm10992837pfg.63.2020.07.07.16.59.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2020 16:59:40 -0700 (PDT)
Date:   Tue, 7 Jul 2020 16:59:39 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Scott Branden <scott.branden@broadcom.com>
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        Wolfram Sang <wsa@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        David Brown <david.brown@linaro.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Shuah Khan <shuah@kernel.org>, bjorn.andersson@linaro.org,
        Shuah Khan <skhan@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Mimi Zohar <zohar@linux.ibm.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>,
        Olof Johansson <olof@lixom.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Colin Ian King <colin.king@canonical.com>,
        Takashi Iwai <tiwai@suse.de>, linux-kselftest@vger.kernel.org,
        Andy Gross <agross@kernel.org>,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org
Subject: Re: [PATCH v10 4/9] test_firmware: add partial read support for
 request_firmware_into_buf
Message-ID: <202007071659.38721F7@keescook>
References: <20200706232309.12010-1-scott.branden@broadcom.com>
 <20200706232309.12010-5-scott.branden@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200706232309.12010-5-scott.branden@broadcom.com>
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Mon, Jul 06, 2020 at 04:23:04PM -0700, Scott Branden wrote:
> Add additional hooks to test_firmware to pass in support
> for partial file read using request_firmware_into_buf.
> buf_size: size of buffer to request firmware into
> partial: indicates that a partial file request is being made
> file_offset: to indicate offset into file to request
> 
> Signed-off-by: Scott Branden <scott.branden@broadcom.com>

I am a fan of tests. :) If Luis gives an Ack here, you're good.

-- 
Kees Cook
