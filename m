Return-Path: <SRS0=lnE7=U2=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD6CEC48BD7
	for <linux-security-module@archiver.kernel.org>; Thu, 27 Jun 2019 16:24:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A20E42133F
	for <linux-security-module@archiver.kernel.org>; Thu, 27 Jun 2019 16:24:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="gSaPGz9S"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726441AbfF0QYA (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 27 Jun 2019 12:24:00 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:36011 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726315AbfF0QYA (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 27 Jun 2019 12:24:00 -0400
Received: by mail-pg1-f194.google.com with SMTP id c13so1253658pgg.3
        for <linux-security-module@vger.kernel.org>; Thu, 27 Jun 2019 09:23:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=/8WNz6km09cjJozBXv1ttJOzdwKWqBjOCAwXZrmYZQY=;
        b=gSaPGz9S5mfM2IyW50EIddVjXzosJmFwIvLy5/3d96Mmi9TwrjccATn1f1RZjIlMFe
         g6G3RU+uVrFmGFVIUCd9KSLCraVscKPuB43D5SpFa4Cv14trV2iOCfUw1w+dnm1He+No
         Zzm+bbolLanUL6IWtcmRDluyh9DqPXsyiUfrY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=/8WNz6km09cjJozBXv1ttJOzdwKWqBjOCAwXZrmYZQY=;
        b=QNcKGjrxay5hdXudBl0ZcN2lFmayxT26Q8dGuc8SzCfS4eiKO2D/7zmljey/SscK+L
         gkyN0s8IJiIeTCraJELQChDipWjrAesW04JFv2ClbqRrD84uZAboGvWm0Gno7aGb5U+H
         MtL8CI8X+Bs/Ejx0WIwtLJBT9gkSiLyCXAEy/iI5tm/aFhEMC9cQJETfCeCZdrrzgVnh
         4naBCpmrWcuhCCZ/Co2fxNJaGqdl8ZWk2EdwQbcM/d8uLVVBzMr7hjE6OiCye/2mciGp
         1SBldt1FuNiWxSwL1G4qjgoBiEIHAx4XbO6OlQmO7bD7AC2Tw2Sh1k4moA5o/ZT7WDDm
         YE0w==
X-Gm-Message-State: APjAAAVmlX1qBxwMmgHpOR4nlCy1n3FncyLXVWA/Lu5SSXNHOL1Rydj2
        Dynef33wVynXLPyn9XEvP4UtsA==
X-Google-Smtp-Source: APXvYqzwszuLB5KUZT0GR9HWRZ7xGjWVY5pOYkuBOrrtrH5Vd2d27l5XG9aT2UNpuYPJaeE7Xhvg+A==
X-Received: by 2002:a17:90a:cf0d:: with SMTP id h13mr7015152pju.63.1561652639486;
        Thu, 27 Jun 2019 09:23:59 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id a3sm6766104pje.3.2019.06.27.09.23.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 27 Jun 2019 09:23:58 -0700 (PDT)
Date:   Thu, 27 Jun 2019 09:23:57 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Qian Cai <cai@lca.pw>, Catalin Marinas <catalin.marinas@arm.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Alexander Potapenko <glider@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Lameter <cl@linux.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Kostya Serebryany <kcc@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Sandeep Patil <sspatil@android.com>,
        Laura Abbott <labbott@redhat.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Jann Horn <jannh@google.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Marco Elver <elver@google.com>, linux-mm@kvack.org,
        linux-security-module@vger.kernel.org,
        kernel-hardening@lists.openwall.com,
        clang-built-linux@googlegroups.com
Subject: Re: [PATCH v8 1/2] mm: security: introduce init_on_alloc=1 and
 init_on_free=1 boot options
Message-ID: <201906270923.C73BAD213@keescook>
References: <20190626121943.131390-1-glider@google.com>
 <20190626121943.131390-2-glider@google.com>
 <1561572949.5154.81.camel@lca.pw>
 <201906261303.020ADC9@keescook>
 <20190627061534.GA17798@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190627061534.GA17798@dhcp22.suse.cz>
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Thu, Jun 27, 2019 at 08:15:34AM +0200, Michal Hocko wrote:
> This sounds familiar: http://lkml.kernel.org/r/CABXOdTd-cqHM_feAO1tvwn4Z=kM6WHKYAbDJ7LGfMvRPRPG7GA@mail.gmail.com

Your memory is better than mine! I entirely forgot about this and it was
only 2 months ago. Whoops. :P

-- 
Kees Cook
