Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D69FC433ED
	for <linux-security-module@archiver.kernel.org>; Tue, 11 May 2021 02:58:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 58C3461409
	for <linux-security-module@archiver.kernel.org>; Tue, 11 May 2021 02:58:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229945AbhEKC7d (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 10 May 2021 22:59:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbhEKC7d (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 10 May 2021 22:59:33 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70A87C061760
        for <linux-security-module@vger.kernel.org>; Mon, 10 May 2021 19:58:27 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id gq14-20020a17090b104eb029015be008ab0fso44331pjb.1
        for <linux-security-module@vger.kernel.org>; Mon, 10 May 2021 19:58:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=JxJR04Xv/YnMAFrcHyESkEXBblvroZPD5TgFitfVkoo=;
        b=RbexxldZUVymd2P/sIJDv9SMCoq8cD1CsFLOcLwfXYxm4mtn7+1MJlPRjvy9LM1mBe
         ZqxuadNDV8Tg01bppw8VAYW8pmg4peKpLWe727NAwtxDpN7+5gfUp7wIHmlhe3wJ0py9
         FL0kQOiaKnzDcmer8y7tk4eExkKRwXIvKZhh8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=JxJR04Xv/YnMAFrcHyESkEXBblvroZPD5TgFitfVkoo=;
        b=tgwkc6N+B0HvG7WxNS0uloXsrhGJ4a/lniJfez2YHq9ODzk79asQiLSUgpJilCl6Xl
         1mJAyjfAe6w0eP/kSeIkG/s0eysXaift46Mk5JqDsAlWhr1nXbAMcO86+NjlAGTR+wEZ
         CZPB3iHM5rAkzCa46Ctllj73yyldojcLBlOzp8xhSbzaTHVc+eEE1UFH39wzYJzLAfn/
         +X4xBbNi4NFpLIQZxsw7eC/wCKfvhoIvOOwA4/EIZTjc5aPkiXsPfYuTiXxEtKfl9/28
         kvxq4vogjEghsOFMKxEoxvwgml3aQLIyGNo+i4NncLDue6NvuW51XBypUzOx95kxxgyG
         Ab3Q==
X-Gm-Message-State: AOAM531qdFufeKloXON5AXNL5n/L7Xwy0ZbrbUqqn9Qv6skYDlucvoGK
        Vxkw0bv9DE7hdwppU/4VfWzPTQ==
X-Google-Smtp-Source: ABdhPJxGpaEYEQ8LdJwF/HG9Ge5TJm/JyLjBconC0tYKDE8GaFJBFM5l9yLUI84vgByVcsUsovFSIQ==
X-Received: by 2002:a17:90a:df0b:: with SMTP id gp11mr13701357pjb.4.1620701906855;
        Mon, 10 May 2021 19:58:26 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id e6sm12099160pfd.219.2021.05.10.19.58.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 May 2021 19:58:26 -0700 (PDT)
Date:   Mon, 10 May 2021 19:58:25 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Maxime Coquelin <maxime.coquelin@redhat.com>
Cc:     alex.williamson@redhat.com, jmorris@namei.org, dhowells@redhat.com,
        linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, kvm@vger.kernel.org,
        mjg59@srcf.ucam.org, cohuck@redhat.com
Subject: Re: [PATCH] vfio: Lock down no-IOMMU mode when kernel is locked down
Message-ID: <202105101955.933F66A@keescook>
References: <20210506091859.6961-1-maxime.coquelin@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210506091859.6961-1-maxime.coquelin@redhat.com>
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Thu, May 06, 2021 at 11:18:59AM +0200, Maxime Coquelin wrote:
> When no-IOMMU mode is enabled, VFIO is as unsafe as accessing
> the PCI BARs via the device's sysfs, which is locked down when
> the kernel is locked down.
> 
> Indeed, it is possible for an attacker to craft DMA requests
> to modify kernel's code or leak secrets stored in the kernel,
> since the device is not isolated by an IOMMU.
> 
> This patch introduces a new integrity lockdown reason for the
> unsafe VFIO no-iommu mode.
> 
> Signed-off-by: Maxime Coquelin <maxime.coquelin@redhat.com>
> ---
>  drivers/vfio/vfio.c      | 13 +++++++++----
>  include/linux/security.h |  1 +
>  security/security.c      |  1 +
>  3 files changed, 11 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/vfio/vfio.c b/drivers/vfio/vfio.c
> index 5e631c359ef2..fe466d6ea5d8 100644
> --- a/drivers/vfio/vfio.c
> +++ b/drivers/vfio/vfio.c
> @@ -25,6 +25,7 @@
>  #include <linux/pci.h>
>  #include <linux/rwsem.h>
>  #include <linux/sched.h>
> +#include <linux/security.h>
>  #include <linux/slab.h>
>  #include <linux/stat.h>
>  #include <linux/string.h>
> @@ -165,7 +166,8 @@ static void *vfio_noiommu_open(unsigned long arg)
>  {
>  	if (arg != VFIO_NOIOMMU_IOMMU)
>  		return ERR_PTR(-EINVAL);
> -	if (!capable(CAP_SYS_RAWIO))
> +	if (!capable(CAP_SYS_RAWIO) ||
> +			security_locked_down(LOCKDOWN_VFIO_NOIOMMU))

The LSM hook check should come before the capable() check to avoid
setting PF_SUPERPRIV if capable() passes and the LSM doesn't.

> diff --git a/include/linux/security.h b/include/linux/security.h
> index 06f7c50ce77f..f29388180fab 100644
> --- a/include/linux/security.h
> +++ b/include/linux/security.h
> @@ -120,6 +120,7 @@ enum lockdown_reason {
>  	LOCKDOWN_MMIOTRACE,
>  	LOCKDOWN_DEBUGFS,
>  	LOCKDOWN_XMON_WR,
> +	LOCKDOWN_VFIO_NOIOMMU,
>  	LOCKDOWN_INTEGRITY_MAX,
>  	LOCKDOWN_KCORE,
>  	LOCKDOWN_KPROBES,

Is the security threat specific to VFIO? (i.e. could other interfaces
want a similar thing, such that naming this VFIO doesn't make sense?

-- 
Kees Cook
