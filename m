Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACDE3C433F5
	for <linux-security-module@archiver.kernel.org>; Mon, 13 Dec 2021 20:38:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238690AbhLMUi1 (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 13 Dec 2021 15:38:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242021AbhLMUi0 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 13 Dec 2021 15:38:26 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 688D6C061748
        for <linux-security-module@vger.kernel.org>; Mon, 13 Dec 2021 12:38:26 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id np6-20020a17090b4c4600b001a90b011e06so14302284pjb.5
        for <linux-security-module@vger.kernel.org>; Mon, 13 Dec 2021 12:38:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=GwERbAEJEYetlBmVr24GKF6wnmy9fFMxfSPteuwkvvo=;
        b=QkmtBO5ecCKOZ1yTEfXFCCEy2xRBZ4PtTMSi0hv/hRUjHqGSEs7j1w2ic+7SFt5May
         Z6QlP2HDNFJGAXp4Sj6V6jqVJ/2J6gWF+PMnxAsDKRPokuVfAc6hAQvtXz4C87td4OYC
         wcFhxBziORrdQgWQZiOCK3QXH3RFOIDx9XLv0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=GwERbAEJEYetlBmVr24GKF6wnmy9fFMxfSPteuwkvvo=;
        b=6kRXtkXI3TtWhopniBELcoYmyjVdKY8Y9MPBOqUz5HZ56laXwtMbLt1g0aCaTjOeOD
         X5N4owitAn4ZP7gNmoZta/h/6cHonyyDr+00jH3M/eFiwOVRexlrusv9lnuuzyI0Yv1q
         K3oQtrOuWABekal1RCmfGaKHYS6X35LqtF8Lh0LUKzr71i4RbiUtISBhZKfuoThks7KS
         zgHZ2eWXQ64Ff18QlzHChDX9hzVcrNUgzylJgFv9h0ArYgESKt7pR278+OGZUcxIFrkG
         SFpjvdKeV8opa7S7vgDpBW07Hwc+4xdteqUARkG536Y87jSkPpZ+Jdx2dPoVGrznpKKv
         W/9g==
X-Gm-Message-State: AOAM532i0VARNNQ9HvNAni4PcfVlr7LYTSEww5vZtk0T1i4SXYr8PAVB
        zG+OnT9x6lie+JD33fqkzI0iaA==
X-Google-Smtp-Source: ABdhPJwo2Nr0F37opgJzEGzkcrZjV2E64UleT9NH5LxGOFMvGsMYzel84/SkNj6ItbHIGzS/d3PWtA==
X-Received: by 2002:a17:90a:c257:: with SMTP id d23mr611796pjx.42.1639427905929;
        Mon, 13 Dec 2021 12:38:25 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id q1sm14244472pfu.33.2021.12.13.12.38.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Dec 2021 12:38:25 -0800 (PST)
Date:   Mon, 13 Dec 2021 12:38:25 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     catalin.marinas@arm.com, will@kernel.org, shuah@kernel.org,
        mic@digikod.net, davem@davemloft.net, kuba@kernel.org,
        peterz@infradead.org, paulmck@kernel.org, boqun.feng@gmail.com,
        akpm@linux-foundation.org, linux-kselftest@vger.kernel.org,
        linux-security-module@vger.kernel.org, netdev@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH 09/12] selftests/seccomp: remove ARRAY_SIZE define from
 seccomp_benchmark
Message-ID: <202112131238.245527E@keescook>
References: <cover.1639156389.git.skhan@linuxfoundation.org>
 <80fa7078e0645649b6e31be4844a3cffbe67a79b.1639156389.git.skhan@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <80fa7078e0645649b6e31be4844a3cffbe67a79b.1639156389.git.skhan@linuxfoundation.org>
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Fri, Dec 10, 2021 at 10:33:19AM -0700, Shuah Khan wrote:
> ARRAY_SIZE is defined in several selftests. Remove definitions from
> individual test files and include header file for the define instead.
> ARRAY_SIZE define is added in a separate patch to prepare for this
> change.
> 
> Remove ARRAY_SIZE from seccomp_benchmark and pickup the one defined in
> kselftest.h.
> 
> Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>

Good idea to clean these up; thanks!

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
