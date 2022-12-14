Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97D8AC4708D
	for <linux-security-module@archiver.kernel.org>; Wed, 14 Dec 2022 18:53:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238214AbiLNSxB (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 14 Dec 2022 13:53:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229619AbiLNSxA (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 14 Dec 2022 13:53:00 -0500
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4D27275C7
        for <linux-security-module@vger.kernel.org>; Wed, 14 Dec 2022 10:52:56 -0800 (PST)
Received: by mail-pf1-x42f.google.com with SMTP id g1so5125593pfk.2
        for <linux-security-module@vger.kernel.org>; Wed, 14 Dec 2022 10:52:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3OH5piqQgYs2HTpmjsVvlC/zkWvQoKtSKrvl3IZUHZQ=;
        b=bI1QN40VfMI5YffahIskXJ19TxDe1I9BCbHooK/Oq0RHU8deXnhE+Uzgfmwy9d4kI9
         4l5UD0lWzsJh0Wh1y5ViJkI5rntsqx9KWbjNYwh6ih7fissYH/mdaOxsJXfbTnXWqtob
         pvxkFzZ/YnE344PU68pGDiTSvnfzuCbQUByWI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3OH5piqQgYs2HTpmjsVvlC/zkWvQoKtSKrvl3IZUHZQ=;
        b=q13BmSmo+kC7bpqlFkdh6Tvj17KN0rcr+JlGV1ny8gjllXJ6brJOBDdFkMqydvM6Gv
         zUi55Co0kQSKbZFZnGeZlkVvKkeLjJC/Z8+30q4Rm0R2YO+CmejPmjjXwtUR90ve1o5t
         n59EGDaj2fsegjEzcYea94CtrmLAQPqhB0k/xuGjU0r9IM3C7+aDvKYQ+xImfIaGwpSe
         66KdjTX+iPaGlpgUcomjDMjY4iaENQDmPGlG5GgB+pcf9OnVVjVQR3PvNwFWsqFG7cMV
         d9proXfVRmo+Ss37KczeYMomddYGVYvEBa0OH24h98mEu+JrQlq+b2BR/ruqcFggCVvA
         Eccg==
X-Gm-Message-State: ANoB5pn9T6N6H2eVQ15NX3Uxhvu0BNXEVPadL/z4mOKxAKU3Hj7CT6xu
        Eu0LxzTMuV/olLLSRFuv3TWwLg==
X-Google-Smtp-Source: AA0mqf65AEZDaIMr5dElxYb0kE1PXzokNGbweS278MyeHeqmjC2k8jXN/Ezzt8ghTuysEsp3KngeHQ==
X-Received: by 2002:a62:3103:0:b0:576:14a4:b76a with SMTP id x3-20020a623103000000b0057614a4b76amr22717330pfx.34.1671043976432;
        Wed, 14 Dec 2022 10:52:56 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id a2-20020a624d02000000b00576d4d69909sm228569pfb.8.2022.12.14.10.52.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Dec 2022 10:52:55 -0800 (PST)
Date:   Wed, 14 Dec 2022 10:52:54 -0800
From:   Kees Cook <keescook@chromium.org>
To:     jeffxu@chromium.org
Cc:     skhan@linuxfoundation.org, akpm@linux-foundation.org,
        dmitry.torokhov@gmail.com, dverkamp@chromium.org, hughd@google.com,
        jeffxu@google.com, jorgelo@chromium.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-mm@kvack.org, jannh@google.com,
        linux-hardening@vger.kernel.org,
        linux-security-module@vger.kernel.org
Subject: Re: [PATCH v7 2/6] selftests/memfd: add tests for F_SEAL_EXEC
Message-ID: <202212141052.3B04BF6@keescook>
References: <20221209160453.3246150-1-jeffxu@google.com>
 <20221209160453.3246150-3-jeffxu@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221209160453.3246150-3-jeffxu@google.com>
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Fri, Dec 09, 2022 at 04:04:49PM +0000, jeffxu@chromium.org wrote:
> From: Daniel Verkamp <dverkamp@chromium.org>
> 
> Basic tests to ensure that user/group/other execute bits cannot be
> changed after applying F_SEAL_EXEC to a memfd.
> 
> Signed-off-by: Daniel Verkamp <dverkamp@chromium.org>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
