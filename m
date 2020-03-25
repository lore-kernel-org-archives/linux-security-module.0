Return-Path: <SRS0=gnGb=5K=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04E1DC2D0E6
	for <linux-security-module@archiver.kernel.org>; Wed, 25 Mar 2020 20:15:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE48E2076F
	for <linux-security-module@archiver.kernel.org>; Wed, 25 Mar 2020 20:15:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="hwnn3Ir6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727328AbgCYUPA (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 25 Mar 2020 16:15:00 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:50442 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727275AbgCYUPA (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 25 Mar 2020 16:15:00 -0400
Received: by mail-wm1-f65.google.com with SMTP id d198so4069683wmd.0
        for <linux-security-module@vger.kernel.org>; Wed, 25 Mar 2020 13:14:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=0OQaYSA4nZ2gXySsRJHDk1KXoSC2YVOYU+F8UZAf+F8=;
        b=hwnn3Ir68Lfzy19akJriEz5wwoiXbl+3c2wZp4BAUkbVG9nIp+//So75WSrFTx+5qh
         7QV8fbMyUIE0UcueiX/ErLGabclX1TuHwPq7sPfVa49rUtx3pTfT/2O+3WKNtEa8/xFF
         mfptOdRKmsYkjD07FFfpFuUE8n0vyQrAFtB3Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=0OQaYSA4nZ2gXySsRJHDk1KXoSC2YVOYU+F8UZAf+F8=;
        b=SLjvAro2K76Uj2OZo8GRLLYDv2u/mIc4pECTGBJqROVKYahr9MZEyOO8QJfs/8Xiqn
         aBwYkJCiLO89G8NSF8LXP649XRf8jGDL7lHrQsspoQzf7O/ifaGhTSrKE2JEZlO1yOtX
         WXNrsYOZBldcXOpXSCxP/qxmvGXhs82sGImZvWn+Sg+dvoDqQl/CeySIuBoTizYOMQFF
         DNeY2nThvP8GwBAgZ1maHXK0vU14OtzS8YCOC4ILsDX8XJh7VqyUqRrxRrW8CB4wUM2c
         SSIssdlcfowL4Mg96gC6nnRtUbKwLydrD0O3ihWSp/JKhD2WkxYB+pN7x0YwWSud/fPM
         9bNQ==
X-Gm-Message-State: ANhLgQ3CeFJbqXyynBUDxp4SFmWkNWZZVKqayS8QM/NaybDbC9r3UMy3
        dShx0ROP0N7uAxoZmo8DYCY+pQ==
X-Google-Smtp-Source: ADFU+vtR78/5TV4j/RhUUACat+o7Zx3yuL90WC4GLgjN9JgBU6U7lQg4W+7dAXk8Am9gfUuv1zpbAw==
X-Received: by 2002:a1c:740f:: with SMTP id p15mr5152828wmc.98.1585167298609;
        Wed, 25 Mar 2020 13:14:58 -0700 (PDT)
Received: from chromium.org (77-56-209-237.dclient.hispeed.ch. [77.56.209.237])
        by smtp.gmail.com with ESMTPSA id z188sm176869wme.46.2020.03.25.13.14.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Mar 2020 13:14:58 -0700 (PDT)
From:   KP Singh <kpsingh@chromium.org>
X-Google-Original-From: KP Singh <kpsingh>
Date:   Wed, 25 Mar 2020 21:14:56 +0100
To:     Kees Cook <keescook@chromium.org>
Cc:     linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Brendan Jackman <jackmanb@google.com>,
        Florent Revest <revest@google.com>, Yonghong Song <yhs@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        James Morris <jmorris@namei.org>, Paul Turner <pjt@google.com>,
        Jann Horn <jannh@google.com>,
        Florent Revest <revest@chromium.org>,
        Brendan Jackman <jackmanb@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH bpf-next v6 3/8] bpf: lsm: provide attachment points for
 BPF LSM programs
Message-ID: <20200325201456.GA30568@chromium.org>
References: <20200325152629.6904-1-kpsingh@chromium.org>
 <20200325152629.6904-4-kpsingh@chromium.org>
 <202003251225.923FF1DD7@keescook>
 <20200325193956.GA22898@chromium.org>
 <202003251257.AD4381C861@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <202003251257.AD4381C861@keescook>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On 25-Mär 13:07, Kees Cook wrote:
> On Wed, Mar 25, 2020 at 08:39:56PM +0100, KP Singh wrote:
> > On 25-Mär 12:28, Kees Cook wrote:
> > > On Wed, Mar 25, 2020 at 04:26:24PM +0100, KP Singh wrote:
> > > > +noinline __weak RET bpf_lsm_##NAME(__VA_ARGS__)	\
> > > 
> > > I don't think the __weak is needed any more here?
> > 
> > This was suggested in:
> > 
> >  https://lore.kernel.org/bpf/20200221022537.wbmhdfkdbfvw2pww@ast-mbp/
> > 
> > "I think I saw cases when gcc ignored 'noinline' when function is
> > defined in the same file and still performed inlining while keeping
> > the function body.  To be safe I think __weak is necessary. That will
> > guarantee noinline."
> > 
> > It happened to work nicely with the previous approach for the special
> > hooks but the actual reason for adding the __weak was to guarrantee
> > that these functions don't get inlined.
> 
> Oh, hrm. Well, okay. That rationale would imply that the "noinline"
> macro needs adjustment instead, but that can be separate, something like:
> 
> include/linux/compiler_attributes.h
> 
> -#define noinline __attribute__((__noinline__))
> +#define noinline __attribute__((__noinline__)) __attribute__((__weak__))
> 
> With a comment, etc...

Sounds reasonable, I will drop the __weak from this and send a
separate patch for this.

- KP

> 
> -Kees
> 
> > 
> > > 
> > > > +{						\
> > > > +	return DEFAULT;				\
> > > 
> > > I'm impressed that LSM_RET_VOID actually works. :)
> > 
> > All the credit goes to Andrii :)
> > 
> > - KP
> > 
> > > 
> > > -Kees
> > > 
> > > > +}
> > > > +
> > > > +#include <linux/lsm_hook_defs.h>
> > > > +#undef LSM_HOOK
> > > >  
> > > >  const struct bpf_prog_ops lsm_prog_ops = {
> > > >  };
> > > > -- 
> > > > 2.20.1
> > > > 
> > > 
> > > -- 
> > > Kees Cook
> 
> -- 
> Kees Cook
