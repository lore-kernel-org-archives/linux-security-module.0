Return-Path: <SRS0=DuHk=TR=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE9B4C04AB4
	for <linux-security-module@archiver.kernel.org>; Fri, 17 May 2019 16:36:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 990DD20848
	for <linux-security-module@archiver.kernel.org>; Fri, 17 May 2019 16:36:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="LKtwsZc+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726462AbfEQQgi (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 17 May 2019 12:36:38 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:36164 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725932AbfEQQgi (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 17 May 2019 12:36:38 -0400
Received: by mail-pl1-f193.google.com with SMTP id d21so3597669plr.3
        for <linux-security-module@vger.kernel.org>; Fri, 17 May 2019 09:36:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=IxZh0SFkgKtgTvTNPdcwfcLCN5N/2CbppecqxizinxM=;
        b=LKtwsZc+FJwBUNCIrb11Y8GMSqCZzahf6uwtE13uOAtzpkKArDH0dIAHVyh3q8Aw/I
         Y4JNbF8h+RK2YX8THwM9WWZfYiZndP/ijiJWhxq83LPfS7ocwy7iMhbMiGe+pULQw//3
         aF2hXKEvTcj8VBtfWGt+/eQWXW1mCx/Jpv9gY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=IxZh0SFkgKtgTvTNPdcwfcLCN5N/2CbppecqxizinxM=;
        b=VfZFHvYot4NCvcDp0nQAgB4YWzy7rekEz3cmDV7NGW8GV3k0cMt8AXxHLPHf5gHCys
         jVCYFOzyqy81r1E0/cN39gAQqHmBoAnqpX5Vbx8aVVGqhqYDh4K2gYtZ7X/rslVJoQnr
         MpjjSL0GrSalPz/dm0dzhOZDd3Dhio38M28mYdPRw19spK6DMA6i7uFbcYMBP+cC5w2w
         d2gwIx2i6UHbYyRLlcK/DkAj26No8n/AjPgj7iphkBH0qhkyqjGQSW+XBVVp7Oy4gGUE
         x9+OgqnOJKZGDNRUWCrp14qJrBlBl7SzE7/Sd3YIu0WmjznAvIXNfQXVuvhCGP8eEZxS
         RQFA==
X-Gm-Message-State: APjAAAVhT+qlpC/T5DEd8BkJariB+Qszh83oCCI9R7F1V+ruLoYyX2Zb
        sNvxfY2uSYY0dJPyZQ9ugg+ttw==
X-Google-Smtp-Source: APXvYqwar3NELFkZUW3aLvqx4k8Fr6KsRKzOY1J6woNFnEa2TxFFiU3swrxEMldmcv15oXzwZrP4YA==
X-Received: by 2002:a17:902:2bc5:: with SMTP id l63mr59603305plb.202.1558110998204;
        Fri, 17 May 2019 09:36:38 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id t25sm18130915pfq.91.2019.05.17.09.36.37
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 17 May 2019 09:36:37 -0700 (PDT)
Date:   Fri, 17 May 2019 09:36:36 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Alexander Potapenko <glider@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Lameter <cl@linux.com>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
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
        Linux Memory Management List <linux-mm@kvack.org>,
        linux-security-module <linux-security-module@vger.kernel.org>
Subject: Re: [PATCH v2 1/4] mm: security: introduce init_on_alloc=1 and
 init_on_free=1 boot options
Message-ID: <201905170928.A8F3BEC1B1@keescook>
References: <20190514143537.10435-1-glider@google.com>
 <20190514143537.10435-2-glider@google.com>
 <20190517140446.GA8846@dhcp22.suse.cz>
 <CAG_fn=W4k=mijnUpF98Hu6P8bFMHU81FHs4Swm+xv1k0wOGFFQ@mail.gmail.com>
 <20190517142048.GM6836@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190517142048.GM6836@dhcp22.suse.cz>
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Fri, May 17, 2019 at 04:20:48PM +0200, Michal Hocko wrote:
> On Fri 17-05-19 16:11:32, Alexander Potapenko wrote:
> > On Fri, May 17, 2019 at 4:04 PM Michal Hocko <mhocko@kernel.org> wrote:
> > >
> > > On Tue 14-05-19 16:35:34, Alexander Potapenko wrote:
> > > > The new options are needed to prevent possible information leaks and
> > > > make control-flow bugs that depend on uninitialized values more
> > > > deterministic.
> > > >
> > > > init_on_alloc=1 makes the kernel initialize newly allocated pages and heap
> > > > objects with zeroes. Initialization is done at allocation time at the
> > > > places where checks for __GFP_ZERO are performed.
> > > >
> > > > init_on_free=1 makes the kernel initialize freed pages and heap objects
> > > > with zeroes upon their deletion. This helps to ensure sensitive data
> > > > doesn't leak via use-after-free accesses.
> > >
> > > Why do we need both? The later is more robust because even free memory
> > > cannot be sniffed and the overhead might be shifted from the allocation
> > > context (e.g. to RCU) but why cannot we stick to a single model?
> > init_on_free appears to be slower because of cache effects. It's
> > several % in the best case vs. <1% for init_on_alloc.
> 
> This doesn't really explain why we need both.

There are a couple reasons. The first is that once we have hardware with
memory tagging (e.g. arm64's MTE) we'll need both on_alloc and on_free
hooks to do change the tags. With MTE, zeroing comes for "free" with
tagging (though tagging is as slow as zeroing, so it's really the tagging
that is free...), so we'll need to re-use the init_on_free infrastructure.

The second reason is for very paranoid use-cases where in-memory
data lifetime is desired to be minimized. There are various arguments
for/against the realism of the associated threat models, but given that
we'll need the infrastructre for MTE anyway, and there are people who
want wipe-on-free behavior no matter what the performance cost, it seems
reasonable to include it in this series.

All that said, init_on_alloc looks desirable enough that distros will
likely build with it enabled by default (I hope), and the very paranoid
users will switch to (or additionally enable) init_on_free for their
systems.

-- 
Kees Cook
