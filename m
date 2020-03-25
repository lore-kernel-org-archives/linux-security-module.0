Return-Path: <SRS0=gnGb=5K=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15150C2D0E7
	for <linux-security-module@archiver.kernel.org>; Wed, 25 Mar 2020 20:07:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0E2820719
	for <linux-security-module@archiver.kernel.org>; Wed, 25 Mar 2020 20:07:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="iwwJs37q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727501AbgCYUHw (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 25 Mar 2020 16:07:52 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:34357 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727374AbgCYUHv (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 25 Mar 2020 16:07:51 -0400
Received: by mail-pl1-f195.google.com with SMTP id a23so1245117plm.1
        for <linux-security-module@vger.kernel.org>; Wed, 25 Mar 2020 13:07:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=6P5bTAGsE0amInvCSHC0blEKE/ToIH6x//KXcxXkD08=;
        b=iwwJs37qnuJfDrZ3hbRFpiXq4hpsEHFv3tJYxWCys78aTmwq9KISIsEDfCqkhpgAqe
         Xb74jT1J0Y1159WgIYJBvSdCm3J8XpLgm7TTaK5Qv34pzY64c3WvrpCgW9G+rTJWxuQ5
         qxyy8aSw7Jgob9XNWo+qA0mvugPw1SHcL4ePw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=6P5bTAGsE0amInvCSHC0blEKE/ToIH6x//KXcxXkD08=;
        b=UVPvA/L7nOUxOdl6P/Fx+5+9Nkl4eX1W89mhbp/sWJoXKxKkXyyRe1hXvm0uup6GJy
         0o5PuvyV7qAH8WI+v9Eh0ngpqY1uGzBuPWL7EG2Vom8Cf+L6yupBa2lRPPp5lV2DHElT
         xRevnun7QJc5k0cOf5cr3tVXs5zvtxHLSMB03A+9qmQaN/u8AfIIGsQ55MV4rMhOjPIL
         Vi7DdH/j+crt4wvk0VbT3bmd0bUp2bWHwlc6XHY8aNdz8/OFVHoLqlmxjGfGj4a7SnKq
         iluDYTIpBbPtCPxnonFzdQWuzW7OiWz7GvHIwB5XMydMs9LnHtkU7yc/Hv9ZqUkvUivj
         dwIQ==
X-Gm-Message-State: ANhLgQ3gwMBF5s/L7Op0uMsHRRS5fTRrXXlsW896ZVil6qwcQQxJIcrp
        0NCKHie5F0pYnVVTolY5MsKr/Q==
X-Google-Smtp-Source: ADFU+vsnCDdTqQ/eLFXY+637edokg88uorV6An1aox+orWo/paerQoA15rocN1ChqG2o5GuJsfRNhw==
X-Received: by 2002:a17:90a:2a89:: with SMTP id j9mr5435067pjd.64.1585166870475;
        Wed, 25 Mar 2020 13:07:50 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id r63sm12610703pfr.42.2020.03.25.13.07.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Mar 2020 13:07:49 -0700 (PDT)
Date:   Wed, 25 Mar 2020 13:07:48 -0700
From:   Kees Cook <keescook@chromium.org>
To:     KP Singh <kpsingh@chromium.org>
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
Message-ID: <202003251257.AD4381C861@keescook>
References: <20200325152629.6904-1-kpsingh@chromium.org>
 <20200325152629.6904-4-kpsingh@chromium.org>
 <202003251225.923FF1DD7@keescook>
 <20200325193956.GA22898@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200325193956.GA22898@chromium.org>
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Wed, Mar 25, 2020 at 08:39:56PM +0100, KP Singh wrote:
> On 25-Mär 12:28, Kees Cook wrote:
> > On Wed, Mar 25, 2020 at 04:26:24PM +0100, KP Singh wrote:
> > > +noinline __weak RET bpf_lsm_##NAME(__VA_ARGS__)	\
> > 
> > I don't think the __weak is needed any more here?
> 
> This was suggested in:
> 
>  https://lore.kernel.org/bpf/20200221022537.wbmhdfkdbfvw2pww@ast-mbp/
> 
> "I think I saw cases when gcc ignored 'noinline' when function is
> defined in the same file and still performed inlining while keeping
> the function body.  To be safe I think __weak is necessary. That will
> guarantee noinline."
> 
> It happened to work nicely with the previous approach for the special
> hooks but the actual reason for adding the __weak was to guarrantee
> that these functions don't get inlined.

Oh, hrm. Well, okay. That rationale would imply that the "noinline"
macro needs adjustment instead, but that can be separate, something like:

include/linux/compiler_attributes.h

-#define noinline __attribute__((__noinline__))
+#define noinline __attribute__((__noinline__)) __attribute__((__weak__))

With a comment, etc...

-Kees

> 
> > 
> > > +{						\
> > > +	return DEFAULT;				\
> > 
> > I'm impressed that LSM_RET_VOID actually works. :)
> 
> All the credit goes to Andrii :)
> 
> - KP
> 
> > 
> > -Kees
> > 
> > > +}
> > > +
> > > +#include <linux/lsm_hook_defs.h>
> > > +#undef LSM_HOOK
> > >  
> > >  const struct bpf_prog_ops lsm_prog_ops = {
> > >  };
> > > -- 
> > > 2.20.1
> > > 
> > 
> > -- 
> > Kees Cook

-- 
Kees Cook
