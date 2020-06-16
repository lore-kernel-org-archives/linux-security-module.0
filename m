Return-Path: <SRS0=f9XP=75=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BEBDC433E0
	for <linux-security-module@archiver.kernel.org>; Tue, 16 Jun 2020 16:18:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1BCB420882
	for <linux-security-module@archiver.kernel.org>; Tue, 16 Jun 2020 16:18:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="XjCEbPGQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732376AbgFPQSO (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 16 Jun 2020 12:18:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731646AbgFPQSK (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 16 Jun 2020 12:18:10 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FA84C061573
        for <linux-security-module@vger.kernel.org>; Tue, 16 Jun 2020 09:18:10 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id 10so9722589pfx.8
        for <linux-security-module@vger.kernel.org>; Tue, 16 Jun 2020 09:18:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=VPiig07nxQc9lwVFwfYIH3T1ET4UEo+E1D0Wd8u+hBk=;
        b=XjCEbPGQUfD9AjE8Hevx52b4HKLCh8oQsGbdC1PHF3Q3QbQn9Ygd51hLvkzVjxG3RX
         UtN728e+HKmcQcP8keX/4Kwc+Ht/ZOiBd+tejEg6vDoXtD7HbPCgbRcKvY43gkmThxUy
         bNcZxPwfyTV9TOAjM5Nf8FXt7R7jq7FXYA3UM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=VPiig07nxQc9lwVFwfYIH3T1ET4UEo+E1D0Wd8u+hBk=;
        b=jRDrZ9VSIQYoaqlC5A7Z7mUgomOPPIFB+1G8Gd4NuGt0pFcT3sobpjLjSDFNAEvSU/
         7VCFsEH/D+UDeBJZiAiihxLMaHVrno5HmTTvsVIi+qgbezSI8jZkGml/RlnIoP8YHIif
         OENWqyG2JU9kUiwlOAKPKyuVC4ABdHdsmhC6SBVxUwjoCwKTcuLRlO83gJxKwcu4Davx
         9UiempFhVTu0c18eVB8q/TF1tc/SrYxtp+ir20pGPWfcSKusdkOWSwJNgYU/M7U3WPNY
         pc3Iny3YJvv1G/WfaLQ0WfsMZ1hIk7TGxOtjSXQ5/gNAkbRZ0GmjZcKpT/z8AiV9KFED
         ifZw==
X-Gm-Message-State: AOAM532zHiAXe/6o0ftgr7TY0wK00nsR/5K8lavTCosAapOsliXtOjUd
        Bcbmh36wsxcmzKb63lA8kMvEtQ==
X-Google-Smtp-Source: ABdhPJyXAmJNtObOlU+rzC52vUgZGrV4mSFDLUt84VwfrotzrnZ8vPKhz8hCE9vZvCTtbLg7XCtYDQ==
X-Received: by 2002:a65:484c:: with SMTP id i12mr2637328pgs.267.1592324290000;
        Tue, 16 Jun 2020 09:18:10 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id w6sm2996602pjy.15.2020.06.16.09.18.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2020 09:18:08 -0700 (PDT)
Date:   Tue, 16 Jun 2020 09:18:07 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Alexander Potapenko <glider@google.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        James Morris <jmorris@namei.org>,
        Maciej =?utf-8?Q?=C5=BBenczykowski?= <maze@google.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] [RFC] security: allow using Clang's zero
 initialization for stack variables
Message-ID: <202006160911.BD403B5@keescook>
References: <20200616083435.223038-1-glider@google.com>
 <20200616100309.GA2614426@kroah.com>
 <CAG_fn=VYN6ynu2bnW96-p-QRi77NstHC6DXS+AN0r0bm5K2j7w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAG_fn=VYN6ynu2bnW96-p-QRi77NstHC6DXS+AN0r0bm5K2j7w@mail.gmail.com>
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Tue, Jun 16, 2020 at 02:15:52PM +0200, Alexander Potapenko wrote:
> > > +KBUILD_CFLAGS        += -ftrivial-auto-var-init=zero -enable-trivial-auto-var-init-zero-knowing-it-will-be-removed-from-clang
> > > +endif
> >
> > Gotta love the name...
> 
> This is basically the reason why we've been hesitating to add it to
> the kernel from the very beginning.
> 
> > Anyway, if this is enabled, and clang changes the flag or drops it, does
> > the build suddenly break?
> 
> My original intention (see v1 of this patch) was to make
> zero-initialization a secondary option of INIT_STACK_ALL, so that
> nothing changes for the existing users.
> But I agree with Kees that these options should be made distinct, as
> people may want to use them for different purposes (think debug vs.
> release builds).

Yeah, and if the flag changes again, we can adapt. But at this point,
it's getting used downstream, so we need to land the config in the
kernel.

> We could make INIT_STACK_ALL_ZERO fall back to INIT_STACK_ALL_PATTERN
> if the compiler flag goes away - does this make sense?

I don't like this idea -- I'm very hesitant to make security options do
something different than what they document. It means the end user can't
reason about how their kernel is built when looking at their CONFIGs.

> > And does gcc have something like this as well, or does that have to come
> > in a compiler plugin?
> 
> Kees mentioned someone's plans to implement that in GCC, but I don't
> think they have done it already.

I've had some GCC folks reach about about these features, but I haven't
seen any public discussion yet.

-- 
Kees Cook
