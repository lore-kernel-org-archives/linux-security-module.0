Return-Path: <SRS0=MF6I=UR=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB265C31E51
	for <linux-security-module@archiver.kernel.org>; Tue, 18 Jun 2019 05:07:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7FE5F2084D
	for <linux-security-module@archiver.kernel.org>; Tue, 18 Jun 2019 05:07:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="le3JAsoW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725919AbfFRFHo (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 18 Jun 2019 01:07:44 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:32772 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725900AbfFRFHn (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 18 Jun 2019 01:07:43 -0400
Received: by mail-pl1-f195.google.com with SMTP id c14so5191435plo.0
        for <linux-security-module@vger.kernel.org>; Mon, 17 Jun 2019 22:07:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=jnbiF6PM75BR23D0fug4o/KmiVF/a7iA4ZJbUbk0ou8=;
        b=le3JAsoW0dSW819/UcwrgN8EH4ftLCyDsaZAgc7BOsWEPsmUX0qr3b1uAwcH5U9Ht1
         rYLqymUfXJnabzvyyX1WX3d/KTwGSvrT8fnKeDa6nGKyqmaAbpptt0uOXdARKhOgLrZp
         er1miUtYnUqo/19kfQnQOzsv/7Dso4BiTuyW0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=jnbiF6PM75BR23D0fug4o/KmiVF/a7iA4ZJbUbk0ou8=;
        b=JQZL22MNX1+q7+YjocSKJkw/2U9mOWy6GHOLEUwM1C5rM1PRlyoBEwyVij/9OMnO4/
         RXpFGbaR2IN8Dic4nMkwntqr6NMryuR3kXL40YvwNAS9E25/qQuwqJrW0HtZpVNBIa+f
         raZ3SihX5LxNT4PvBpt4prDXSKuqrTH/K52dxBVuiGSaIJS0oSLAkP0j9mEFgztApZU+
         6PcPunEGrxYZS7il0XaMP2YdJz62QG3mF+w7fZ+ve/N77/+mHQMNRD+insuRPok8rc0M
         RvCh5cdtteazS0aWuofaWeAgIO+/XE5+kQzkrMLhlvNbpy54PDzFhWpYYvVmtpBEbkWz
         MahA==
X-Gm-Message-State: APjAAAUl3+cHl/7YWrFPGERtA/rnCG0ArNBECKPDQsn56wWT13EnZuZw
        FZz8JXm7dui9AbZAR4jUXJIRSw==
X-Google-Smtp-Source: APXvYqzorbbiv4F/V5ltmPIt8/jvpUkr2OK7EJlOoHFOkJ7aNwm7NJJnDee7dkk++naciFbEgk4+6w==
X-Received: by 2002:a17:902:704a:: with SMTP id h10mr4439628plt.337.1560834463257;
        Mon, 17 Jun 2019 22:07:43 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id l44sm1116128pje.29.2019.06.17.22.07.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 17 Jun 2019 22:07:42 -0700 (PDT)
Date:   Mon, 17 Jun 2019 22:07:41 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Alexander Potapenko <glider@google.com>,
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
Subject: Re: [PATCH v7 1/2] mm: security: introduce init_on_alloc=1 and
 init_on_free=1 boot options
Message-ID: <201906172157.8E88196@keescook>
References: <20190617151050.92663-1-glider@google.com>
 <20190617151050.92663-2-glider@google.com>
 <20190617151027.6422016d74a7dc4c7a562fc6@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190617151027.6422016d74a7dc4c7a562fc6@linux-foundation.org>
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Mon, Jun 17, 2019 at 03:10:27PM -0700, Andrew Morton wrote:
> On Mon, 17 Jun 2019 17:10:49 +0200 Alexander Potapenko <glider@google.com> wrote:
> 
> > Slowdown for the new features compared to init_on_free=0,
> > init_on_alloc=0:
> > 
> > hackbench, init_on_free=1:  +7.62% sys time (st.err 0.74%)
> > hackbench, init_on_alloc=1: +7.75% sys time (st.err 2.14%)
> 
> Sanity check time.  Is anyone really going to use this?  Seriously,
> honestly, for real?  If "yes" then how did we determine that?

Absolutely! This is expected to be on-by-default on Android and Chrome
OS. And it gives the opportunity for anyone else to use it under distros
too via the boot args. (The init_on_free feature is regularly requested
by folks where memory forensics is included in their thread models.)

As for the performance implications, the request during review was to
do that separately.

> Also, a bit of a nit: "init_on_alloc" and "init_on_free" aren't very
> well chosen names for the boot options - they could refer to any kernel
> object at all, really.  init_pages_on_alloc would be better?  I don't think
> this matters much - the boot options are already chaotic.  But still...

I agree; it's awkward. It covers both the page allocator and the slab
allocator, though, so naming it "page" seems not great. It's part of
a larger effort to auto-initialize all memory (stack auto-init has
been around in a few forms with the Clang support now in Linus's tree
for v5.2), and the feature has kind of ended up with the short name
of "meminit". As this is the "heap" side of "meminit", what about
"meminit.alloc=..." and "meminit.free=..." as alternative straw-men?

-- 
Kees Cook
