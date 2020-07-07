Return-Path: <SRS0=axxp=AS=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC9CFC433E2
	for <linux-security-module@archiver.kernel.org>; Tue,  7 Jul 2020 23:59:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AB5DF20771
	for <linux-security-module@archiver.kernel.org>; Tue,  7 Jul 2020 23:59:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="E5Bv52U3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728769AbgGGX7C (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 7 Jul 2020 19:59:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727945AbgGGX7C (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 7 Jul 2020 19:59:02 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05F76C061755
        for <linux-security-module@vger.kernel.org>; Tue,  7 Jul 2020 16:59:01 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id t11so14268955pfq.11
        for <linux-security-module@vger.kernel.org>; Tue, 07 Jul 2020 16:59:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=rdv9aWYxdWzi7YuZEHxXGYFHP62AjpgpR6iHCVdleuI=;
        b=E5Bv52U3XPTKQk/JUCHmdsxbrjEBV7kFdiIQaCyIgOqHSS133VrkT0uweCNwnEouhB
         D6ChoBGorNNXQRd5vuzzcx1j8GUi9ZQpXJ/p70YeFpe/j26iafcL6ByrwDGUqHuT5A/I
         RFDzv7/AV7eJ4KbBcjAjcMhpYwiZT3d6/TEnI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=rdv9aWYxdWzi7YuZEHxXGYFHP62AjpgpR6iHCVdleuI=;
        b=O/rhWFz5qvLevON/zUQ2LhA1xOsQ0DVg5uzOVxdaLuCgNN3AYa8hRywR600hXuUV9P
         gUBS+moiBCqNafsp/1+e/4Z1IfESSEOF8K+JIiyjNm7ZuVLO98bHP+G/c37i0R6uhtuh
         hpi2HDAAhBg2qX5BP4XcUhZSmtu0XMxDyfGWNPf3uD4ZIHB2tOYD98tQgMoGAMZZv21Z
         xV3HBQ/urznnpNVzHsxTpzKlmQ6YfLUGcda4hOn5JJnivJ67WPacJw5r3Lpd5cSxCJjK
         sNkUvcswFb8frwQhOE63K/IeZ/QpRiPsLYTMPtCkECKeyCqe7WsEnA6DmgAg32MIprKN
         +npw==
X-Gm-Message-State: AOAM5331gbBRQov+eefTNFeLA/a9/NBUcUmL7CdzS5dnWnlHrf4Np4KC
        QpjdF9Yyr7+bolfdpDOmoWoD0A==
X-Google-Smtp-Source: ABdhPJzYvJrtZ8JwyO03TQIq0tpFYVl2WHcKj9p5wk7nKZXNGQu8Fct93qp7eRhs4GS/cWugEjuxmw==
X-Received: by 2002:a62:404:: with SMTP id 4mr53377463pfe.133.1594166341548;
        Tue, 07 Jul 2020 16:59:01 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id w123sm15793025pfd.2.2020.07.07.16.59.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2020 16:59:00 -0700 (PDT)
Date:   Tue, 7 Jul 2020 16:58:59 -0700
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
Subject: Re: [PATCH v10 3/9] firmware: add request_partial_firmware_into_buf
Message-ID: <202007071657.55C2CFA57@keescook>
References: <20200706232309.12010-1-scott.branden@broadcom.com>
 <20200706232309.12010-4-scott.branden@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200706232309.12010-4-scott.branden@broadcom.com>
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Mon, Jul 06, 2020 at 04:23:03PM -0700, Scott Branden wrote:
> Add request_partial_firmware_into_buf to allow for portions
> of firmware file to be read into a buffer.  Necessary where firmware
> needs to be loaded in portions from file in memory constrained systems.

Just tear out the differing "id" and just use FW_OPT_PARTIAL and I think
if Luis is happy, you're all set.

-- 
Kees Cook
