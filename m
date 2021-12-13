Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30FD4C433F5
	for <linux-security-module@archiver.kernel.org>; Mon, 13 Dec 2021 20:38:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242961AbhLMUiM (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 13 Dec 2021 15:38:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242937AbhLMUiL (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 13 Dec 2021 15:38:11 -0500
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EB6EC061748
        for <linux-security-module@vger.kernel.org>; Mon, 13 Dec 2021 12:38:11 -0800 (PST)
Received: by mail-pf1-x42f.google.com with SMTP id x5so16055834pfr.0
        for <linux-security-module@vger.kernel.org>; Mon, 13 Dec 2021 12:38:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=FKvkyPX1bDE2h0Q01c3iENOpP3uB49QbVTU9+BOOcRY=;
        b=S6eeDQjmjCkWwGcRkWpNMj0zQMC14q6RphCvU5khCboVMxxVucmJWzH8rEPdPQuoUx
         emxL2yMlxrGaIm2o4duCve98uwxkUkIFKY+noBGkwk7wlXepcp96rQfJHVx5Q1XplX73
         W10VDY3Sr/UhdFzGxWJluZrc8VPW7ilyoXbWc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=FKvkyPX1bDE2h0Q01c3iENOpP3uB49QbVTU9+BOOcRY=;
        b=ofnOH1hvuE1F+mrI3C3b96nKLd91bpD8/apHsTO11rNOY+klCCAIsYV1GFebsGWL0h
         lhygHrkfKvus9BVu9H5h9jJXQPEuOCYlwcu/tBtDLuQH2HmIuvXD7NheRaPIY0zI4Bc1
         RribrYTzJMANeZzP4g2k2VvYOE8CDbqPux2BhlDPdTCUvuwugUafxFpZQhVyEUixyUSV
         cOGSu/9T8FS8DOPuMFIqnW1UAukAmzaJ+xJufNNj6ghWnFTBCGyf1kaCU+ADpo4RBJk+
         z0VMTlKeoCRvcwx+WI6vAtb5j2YVcLI8j7+KLHFG4bMJOkXy7cFvT6E6sDuXefM/uVwc
         8+dQ==
X-Gm-Message-State: AOAM532TF1Kw6q88Y1VBSeOTmP1NCJkIuEILWuVJr5U1IWgSTGwgdPsl
        jmDgvGBcqaOlcb3BepC1XmjSHQ==
X-Google-Smtp-Source: ABdhPJzTOk2cB0BO46AZlrjTU/JytY7dpEktlEQmTICo+f5zFSYYE2twDKDHZYe0PBqaQ8Rpa3MDww==
X-Received: by 2002:a62:88c3:0:b0:4a2:b2d2:7082 with SMTP id l186-20020a6288c3000000b004a2b2d27082mr425147pfd.48.1639427890914;
        Mon, 13 Dec 2021 12:38:10 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id z13sm926069pfj.160.2021.12.13.12.38.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Dec 2021 12:38:10 -0800 (PST)
Date:   Mon, 13 Dec 2021 12:38:10 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     catalin.marinas@arm.com, will@kernel.org, shuah@kernel.org,
        mic@digikod.net, davem@davemloft.net, kuba@kernel.org,
        peterz@infradead.org, paulmck@kernel.org, boqun.feng@gmail.com,
        akpm@linux-foundation.org, linux-kselftest@vger.kernel.org,
        linux-security-module@vger.kernel.org, netdev@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH 01/12] tools: fix ARRAY_SIZE defines in tools and
 selftests hdrs
Message-ID: <202112131238.24E1713A0@keescook>
References: <cover.1639156389.git.skhan@linuxfoundation.org>
 <30585e0f0acfb523c6f7a93e0b916ae756e0c7e7.1639156389.git.skhan@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <30585e0f0acfb523c6f7a93e0b916ae756e0c7e7.1639156389.git.skhan@linuxfoundation.org>
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Fri, Dec 10, 2021 at 10:33:11AM -0700, Shuah Khan wrote:
> tools/include/linux/kernel.h and kselftest_harness.h are missing
> ifndef guard around ARRAY_SIZE define. Fix them to avoid duplicate
> define errors during compile when another file defines it. This
> problem was found when compiling selftests that include a header
> with ARRAY_SIZE define.
> 
> ARRAY_SIZE is defined in several selftests. There are about 25+
> duplicate defines in various selftests source and header files.
> Add ARRAY_SIZE to kselftest.h in preparation for removing duplicate
> ARRAY_SIZE defines from individual test files.
> 
> Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
