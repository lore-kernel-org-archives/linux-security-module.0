Return-Path: <SRS0=lnE7=U2=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6F3DC48BD6
	for <linux-security-module@archiver.kernel.org>; Thu, 27 Jun 2019 16:29:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9A6C2146E
	for <linux-security-module@archiver.kernel.org>; Thu, 27 Jun 2019 16:29:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="QZVkVU5E"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726405AbfF0Q3O (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 27 Jun 2019 12:29:14 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:40305 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726431AbfF0Q3O (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 27 Jun 2019 12:29:14 -0400
Received: by mail-pf1-f196.google.com with SMTP id p184so1489767pfp.7
        for <linux-security-module@vger.kernel.org>; Thu, 27 Jun 2019 09:29:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=j3r/LDh8YvAZ3OZnTOWNg6U8i2IFKGtlQBfJAup/Xu4=;
        b=QZVkVU5ECiQEZD8bocjFgSEpqVctlMN9h8L1wAaFRjHXqF0bnW+Ftzzw3DzKHNAcjy
         nt1g/aE2ZEZhbd+4VS6rlk8nZwJ8oWZyePXLyV+B5tlPwkyvKPf9ZyvcqXhXbwmjBpsu
         9we+HaXyTyjBsGacmNDTBFRk/MACpSqLCaF7w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=j3r/LDh8YvAZ3OZnTOWNg6U8i2IFKGtlQBfJAup/Xu4=;
        b=sKCBGeZcNZpvnPl5h/ybFpLnFuumKKr+MtUEsMHFPb+fAdql7iuFTyFYN8s2TCdYPM
         SmSxk5QFCLgb9Frefj2uM9StlJ3Vx2nrL2JQXtAWEddfBZJZ/UDhf9t24F8ovfxiQQy+
         G48rfnTu1yJHQhBvpjn3ShzQYQM/1mRDQrVF0BuEhRtSYRyszPVHxXrB9kAWUpGSIpaB
         AONkafc92KumTyUONh1CdPDT59o64iUZ4N13nG+sApPnPXQoUyl3T8WGOsS7EFgb8dN2
         9Cqo0UZ8HjiPA2LEmOByK6BbJeN6/Xzj6rb5fSMZt5pCEDwVCI61yMXoEYqBMwsOZGf7
         R6hg==
X-Gm-Message-State: APjAAAWet4zrAHAsL07QGhv8ZaqM9zsbSz89s32ExxvKvgXeMRLb/g4i
        Vd33+37hJLd50r3RJCndya18Xg==
X-Google-Smtp-Source: APXvYqwrMEoacKO75gwBZzta/Mh/OJxKqL+3tX7W1+GI48YaQAhoOPnpVsAFn4qoZf/KqcBmiY+0Bg==
X-Received: by 2002:a63:6a49:: with SMTP id f70mr4495703pgc.55.1561652953275;
        Thu, 27 Jun 2019 09:29:13 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id 12sm3220779pfi.60.2019.06.27.09.29.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 27 Jun 2019 09:29:12 -0700 (PDT)
Date:   Thu, 27 Jun 2019 09:29:11 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Qian Cai <cai@lca.pw>
Cc:     Alexander Potapenko <glider@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Lameter <cl@linux.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Hocko <mhocko@kernel.org>,
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
        kernel-hardening@lists.openwall.com
Subject: Re: [PATCH v9 1/2] mm: security: introduce init_on_alloc=1 and
 init_on_free=1 boot options
Message-ID: <201906270926.02AAEE93@keescook>
References: <20190627130316.254309-1-glider@google.com>
 <20190627130316.254309-2-glider@google.com>
 <1561641911.5154.85.camel@lca.pw>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1561641911.5154.85.camel@lca.pw>
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Thu, Jun 27, 2019 at 09:25:11AM -0400, Qian Cai wrote:
> On Thu, 2019-06-27 at 15:03 +0200, Alexander Potapenko wrote:
> > +static int __init early_init_on_alloc(char *buf)
> > +{
> > +	int ret;
> > +	bool bool_result;
> > +
> > +	if (!buf)
> > +		return -EINVAL;
> > +	ret = kstrtobool(buf, &bool_result);
> > +	if (bool_result && IS_ENABLED(CONFIG_PAGE_POISONING))
> > +		pr_warn("mem auto-init: CONFIG_PAGE_POISONING is on, will
> > take precedence over init_on_alloc\n");
> 
> I don't like the warning here. It makes people think it is bug that need to be
> fixed, but actually it is just information. People could enable both in a debug
> kernel.

How would you suggest it be adjusted? Should it be silent, or be
switched to pr_info()?

Also, doesn't this need to check "want_page_poisoning", not just
CONFIG_PAGE_POISONING? Perhaps just leave the warning out entirely?

-- 
Kees Cook
