Return-Path: <SRS0=MGza=UZ=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71D2AC48BD3
	for <linux-security-module@archiver.kernel.org>; Wed, 26 Jun 2019 20:23:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44F392085A
	for <linux-security-module@archiver.kernel.org>; Wed, 26 Jun 2019 20:23:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="P/scPxgJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726508AbfFZUXh (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 26 Jun 2019 16:23:37 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:45207 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726320AbfFZUXh (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 26 Jun 2019 16:23:37 -0400
Received: by mail-pf1-f193.google.com with SMTP id r1so60180pfq.12
        for <linux-security-module@vger.kernel.org>; Wed, 26 Jun 2019 13:23:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=muTYyZgRfl/88mIFAVs1e5kjaDnXa1/tEbRZdzaGsjo=;
        b=P/scPxgJwc5farJAuIHByPDzINLlpr/5LkI5Tz6+ai7Kj6UtSOEPgw/pAPCJhurLrb
         ZQ0eibdOJyW6g/M6uGhLEpiSkeN4GKncEIPlWE3Fza8R3XpnXSMtSrmpdDBC74OQmyy4
         JbJbO0Oym2obl8mXnsLlMjJEvdkuFyPhp8y6U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=muTYyZgRfl/88mIFAVs1e5kjaDnXa1/tEbRZdzaGsjo=;
        b=bzIWHncIuhkb5Re9P3YomCAfMFYPSdQ/WCZdrRyIg+2Lqt+Mk1uGLkhaZHsLaL2uP5
         KGUTNt0XuwWaI2RHQDrcjJOGdiDzWrSZEg2KaouEAiDwCUUiU+ZCnJ/UZ0yk/x05FQYq
         KsZO/xVnRzHk+qlTrDJe2i+1rz8gp6frKMqvNK3JjHclR/Y81+5Px+zRtUWkEyZcibKY
         nkFVgQ0PKd23Zo44PLbOH1vfBPECpTlSzS8MG9mU7po3l1XgY0gFyum5G6b805//nNAN
         EDU3ZSNv48h+H+A4k0+vl2Pu00W2ymy9YpsQpHVfjQCeb2x3Wne+wfoDlBZYcCs2Stwv
         V3XQ==
X-Gm-Message-State: APjAAAVML6oN56lyBghcCKE9M2lGo/n5r2tG06UUdtLoSAn0UunLFzDa
        Qodn6F6P6u4/Sa9A1QRmuX3XEQ==
X-Google-Smtp-Source: APXvYqzqyJA+jcyGndR/DWIwWD+l17OEz6109S6f0/nlZGL0QzbHiaGQY6O+Vl51hxMnbBXTaxumMg==
X-Received: by 2002:a65:5003:: with SMTP id f3mr4639488pgo.75.1561580616571;
        Wed, 26 Jun 2019 13:23:36 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id d4sm2593109pju.19.2019.06.26.13.23.35
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 26 Jun 2019 13:23:35 -0700 (PDT)
Date:   Wed, 26 Jun 2019 13:23:34 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Qian Cai <cai@lca.pw>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Alexander Potapenko <glider@google.com>,
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
        kernel-hardening@lists.openwall.com,
        clang-built-linux@googlegroups.com
Subject: Re: [PATCH v8 1/2] mm: security: introduce init_on_alloc=1 and
 init_on_free=1 boot options
Message-ID: <201906261303.020ADC9@keescook>
References: <20190626121943.131390-1-glider@google.com>
 <20190626121943.131390-2-glider@google.com>
 <1561572949.5154.81.camel@lca.pw>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1561572949.5154.81.camel@lca.pw>
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Wed, Jun 26, 2019 at 02:15:49PM -0400, Qian Cai wrote:
> On Wed, 2019-06-26 at 14:19 +0200, Alexander Potapenko wrote:
> > Both init_on_alloc and init_on_free default to zero, but those defaults
> > can be overridden with CONFIG_INIT_ON_ALLOC_DEFAULT_ON and
> > CONFIG_INIT_ON_FREE_DEFAULT_ON.
> > [...]
> > +static int __init early_init_on_alloc(char *buf)
> > +{
> > +	int ret;
> > +	bool bool_result;
> > +
> > +	if (!buf)
> > +		return -EINVAL;
> > +	ret = kstrtobool(buf, &bool_result);
> > +	if (bool_result)
> > +		static_branch_enable(&init_on_alloc);
> > +	else
> > +		static_branch_disable(&init_on_alloc);
> > +	return ret;
> > +}
> > +early_param("init_on_alloc", early_init_on_alloc);
> 
> Do those really necessary need to be static keys?
> 
> Adding either init_on_free=0 or init_on_alloc=0 to the kernel cmdline will
> generate a warning with kernels built with clang.
> 
> [    0.000000] static_key_disable(): static key 'init_on_free+0x0/0x4' used
> before call to jump_label_init()
> [    0.000000] WARNING: CPU: 0 PID: 0 at ./include/linux/jump_label.h:317
> early_init_on_free+0x1c0/0x200
> [    0.000000] Modules linked in:
> [    0.000000] CPU: 0 PID: 0 Comm: swapper Not tainted 5.2.0-rc6-next-20190626+
> #9
> [    0.000000] pstate: 60000089 (nZCv daIf -PAN -UAO)

I think the issue here is that arm64 doesn't initialize static keys
early enough.

init/main.c has the general case:

asmlinkage __visible void __init start_kernel(void)
{
        ...
        setup_arch(&command_line);
        ...
        smp_prepare_boot_cpu();
        ...
        /* parameters may set static keys */
        jump_label_init();
        parse_early_param();
        ...
}

however, x86 does even earlier early params in setup_arch():

void __init setup_arch(char **cmdline_p)
{
        ...
        jump_label_init();
        ...
        parse_early_param();
        ...
}

arm64 does similar very early early params in setup_arch()[1] too,
but not jump_label_init() which is too late in smp_prepare_boot_cpu():

void __init setup_arch(char **cmdline_p)
{
        ...
        parse_early_param();
        ...
}

void __init smp_prepare_boot_cpu(void)
{
        ...
        jump_label_init();
        ...
}

I can send a patch to fix this...

-Kees

[1] since efd9e03facd07 ("arm64: Use static keys for CPU features")

> [    0.000000] pc : early_init_on_free+0x1c0/0x200
> [    0.000000] lr : early_init_on_free+0x1c0/0x200
> [    0.000000] sp : ffff100012c07df0
> [    0.000000] x29: ffff100012c07e20 x28: ffff1000110a01ec 
> [    0.000000] x27: 000000000000005f x26: ffff100011716cd0 
> [    0.000000] x25: ffff100010d36166 x24: ffff100010d3615d 
> [    0.000000] x23: ffff100010d364b5 x22: ffff1000117164a0 
> [    0.000000] x21: 0000000000000000 x20: 0000000000000000 
> [    0.000000] x19: 0000000000000000 x18: 000000000000002e 
> [    0.000000] x17: 000000000000000f x16: 0000000000000040 
> [    0.000000] x15: 0000000000000000 x14: 6c61632065726f66 
> [    0.000000] x13: 6562206465737520 x12: 273478302f307830 
> [    0.000000] x11: 0000000000000000 x10: 0000000000000000 
> [    0.000000] x9 : 0000000000000000 x8 : 0000000000000000 
> [    0.000000] x7 : 6d756a206f74206c x6 : ffff100014426625 
> [    0.000000] x5 : ffff100012c07b28 x4 : 0000000000000007 
> [    0.000000] x3 : ffff1000101aadf4 x2 : 0000000000000001 
> [    0.000000] x1 : 0000000000000001 x0 : 000000000000005d 
> [    0.000000] Call trace:
> [    0.000000]  early_init_on_free+0x1c0/0x200
> [    0.000000]  do_early_param+0xd0/0x104
> [    0.000000]  parse_args+0x1f0/0x524
> [    0.000000]  parse_early_param+0x70/0x8c
> [    0.000000]  setup_arch+0xa8/0x268
> [    0.000000]  start_kernel+0x80/0x560
> 

-- 
Kees Cook
