Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BD86C4332F
	for <linux-security-module@archiver.kernel.org>; Wed, 14 Dec 2022 18:53:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237585AbiLNSxn (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 14 Dec 2022 13:53:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238989AbiLNSx1 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 14 Dec 2022 13:53:27 -0500
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E7282A96F
        for <linux-security-module@vger.kernel.org>; Wed, 14 Dec 2022 10:53:20 -0800 (PST)
Received: by mail-pg1-x534.google.com with SMTP id 142so2613816pga.1
        for <linux-security-module@vger.kernel.org>; Wed, 14 Dec 2022 10:53:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=x9cSnaEhv8Xds1q1FVg4f4vmMN7yeuDq7gGdjSEFO6Y=;
        b=DPayc+N/6klm+cJJopr92jIZbcDzMcXAgHRTd0IdOF/l4lVMTfSv9uiMdbB9vgE7Rn
         KbN0Mf0w8PPxXiyyFo2dcpPrOOs/0smlRbhGYtuM7nD8UC7C5xF9GWVy9VrRO8OTEMv3
         4YqQIBNhShJXwz7nnmrlPdy5R/1q13TzzW7ZY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x9cSnaEhv8Xds1q1FVg4f4vmMN7yeuDq7gGdjSEFO6Y=;
        b=iSYJF7ZNbR+GXEP40Cn9rFrCyhbfMA9fsvPd1IjkkA12ID2O3WhwmfhH840a97h8DD
         4fL53I/wOw1odsqOrNQ08Kzy/PlY7gqnLHrE2BIaY3mLvsb2945bCRnTcxKKk3MN4OoQ
         Z/CQpKHSdNwbRH836EgAZBNWT/lDWUkDPDFkog1X6hRxLiLCE8VoRLRF+C19mr/oxxja
         Rcho0hmB7LXjykokxAXTgBoepfBjTRK/cbHsTFrindZDsmwW78Q4sxM496Im/Mlh5VRi
         lAbXwpgHzfJpxvZl+mdfryREA9/SjwGczDydzs20lkPu3KS6eiv1FTVtazD13FK5zaBh
         NsEA==
X-Gm-Message-State: ANoB5plyikn3IW+h0AenPvXvnm1x67GXWdML9gKAWphjaFGL3GAi36z2
        q5+Z9grYPpkvOKLrPun1+q4j1w==
X-Google-Smtp-Source: AA0mqf4dRo8AoZc0bYEWLv4+RgOdgi6k/5UHIiZnszRrU+HEBbp0UQLJCi++JGunvqp7GrihTtWLRw==
X-Received: by 2002:a05:6a00:791:b0:577:f836:6bcb with SMTP id g17-20020a056a00079100b00577f8366bcbmr23822313pfu.29.1671044000031;
        Wed, 14 Dec 2022 10:53:20 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id c129-20020a624e87000000b0056b9ec7e2desm198403pfb.125.2022.12.14.10.53.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Dec 2022 10:53:19 -0800 (PST)
Date:   Wed, 14 Dec 2022 10:53:19 -0800
From:   Kees Cook <keescook@chromium.org>
To:     jeffxu@chromium.org
Cc:     skhan@linuxfoundation.org, akpm@linux-foundation.org,
        dmitry.torokhov@gmail.com, dverkamp@chromium.org, hughd@google.com,
        jeffxu@google.com, jorgelo@chromium.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-mm@kvack.org, jannh@google.com,
        linux-hardening@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v7 3/6] mm/memfd: add MFD_NOEXEC_SEAL and MFD_EXEC
Message-ID: <202212141053.DD016F79B@keescook>
References: <20221209160453.3246150-1-jeffxu@google.com>
 <20221209160453.3246150-4-jeffxu@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221209160453.3246150-4-jeffxu@google.com>
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Fri, Dec 09, 2022 at 04:04:50PM +0000, jeffxu@chromium.org wrote:
> From: Jeff Xu <jeffxu@google.com>
> 
> The new MFD_NOEXEC_SEAL and MFD_EXEC flags allows application to
> set executable bit at creation time (memfd_create).
> 
> When MFD_NOEXEC_SEAL is set, memfd is created without executable bit
> (mode:0666), and sealed with F_SEAL_EXEC, so it can't be chmod to
> be executable (mode: 0777) after creation.
> 
> when MFD_EXEC flag is set, memfd is created with executable bit
> (mode:0777), this is the same as the old behavior of memfd_create.
> 
> The new pid namespaced sysctl vm.memfd_noexec has 3 values:
> 0: memfd_create() without MFD_EXEC nor MFD_NOEXEC_SEAL acts like
>         MFD_EXEC was set.
> 1: memfd_create() without MFD_EXEC nor MFD_NOEXEC_SEAL acts like
>         MFD_NOEXEC_SEAL was set.
> 2: memfd_create() without MFD_NOEXEC_SEAL will be rejected.
> 
> The sysctl allows finer control of memfd_create for old-software
> that doesn't set the executable bit, for example, a container with
> vm.memfd_noexec=1 means the old-software will create non-executable
> memfd by default. Also, the value of memfd_noexec is passed to child
> namespace at creation time. For example, if the init namespace has
> vm.memfd_noexec=2, all its children namespaces will be created with 2.
> 
> Signed-off-by: Jeff Xu <jeffxu@google.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
