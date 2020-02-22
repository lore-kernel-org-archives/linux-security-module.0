Return-Path: <SRS0=jUed=4K=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CEF2C35641
	for <linux-security-module@archiver.kernel.org>; Sat, 22 Feb 2020 03:36:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D6CB206DB
	for <linux-security-module@archiver.kernel.org>; Sat, 22 Feb 2020 03:36:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="AmrhPy7R"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727273AbgBVDgJ (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 21 Feb 2020 22:36:09 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:39598 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726032AbgBVDgJ (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 21 Feb 2020 22:36:09 -0500
Received: by mail-pl1-f195.google.com with SMTP id g6so1694562plp.6
        for <linux-security-module@vger.kernel.org>; Fri, 21 Feb 2020 19:36:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Dy4w/JtP1JAdelu+LxOrdV8M+iFt3K5B73WlLdHiOa4=;
        b=AmrhPy7RumaWH6FOFHW3GNC6kY68F1410q008OJPuXEzc8b4LAhybx6uLh6Twwz4mp
         TPPbGhdCnnTCDMNdemay7kGwoVq3yb/Lm2y5mAr3HCih8z3Y5MBd4E5dtlFZsluckQvO
         H7sBTTErYEOs+yTcyLb9t1sxLI8PugM5PtZrI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Dy4w/JtP1JAdelu+LxOrdV8M+iFt3K5B73WlLdHiOa4=;
        b=ZFbTqCaikkBMbCiaAa5JvD+hMISuwDV/KYl/qpu1SXftQM1wn1ehqnEtikNx92kQSI
         G52hBltrNGlmzvcx5BqJfBetah3o4MK8O8yxAlPCx37c/9c11o2fMsZq9bvh7gcPWsg/
         nlCB4dzlKfYTnfmge5LCsBjAN7KEh0twefWIm+T5YpbTBjvVyQp4AaPWR9Gs72/DCmBF
         jfAL824rMWpMDiYKlk9EYQg/JeM9Is9iCbgqC5nFJ0xoX3WnAkw+GSkyt20vCz1Ytd4e
         fE7PsGyGeoH1PJjf7gz4k1qQXUbHhVKHVl6B/bKrwOx00Zc+IaQpU1GcCbXCLSljA/go
         udKQ==
X-Gm-Message-State: APjAAAWOLbHMwmfUlng5Y7p8RnDArVkOUJuaonl+S7ygoCVBE96RSQPC
        0BXNpJbtreskVyqGyojpSY1mWOojFgs=
X-Google-Smtp-Source: APXvYqzjTBw/bhvUIWQPCmbF9AleRhd6Oh8HsREouo4o8p5KTXx04i33eeEUh7oMqMk24ma41xQegQ==
X-Received: by 2002:a17:902:be0e:: with SMTP id r14mr39370446pls.33.1582342568584;
        Fri, 21 Feb 2020 19:36:08 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id dw10sm3908095pjb.11.2020.02.21.19.36.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Feb 2020 19:36:07 -0800 (PST)
Date:   Fri, 21 Feb 2020 19:36:06 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     KP Singh <kpsingh@chromium.org>,
        Linux Security Module list 
        <linux-security-module@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
        James Morris <jmorris@namei.org>
Subject: Re: [PATCH bpf-next v4 0/8] MAC and Audit policy using eBPF (KRSI)
Message-ID: <202002211909.10D57A125@keescook>
References: <20200220175250.10795-1-kpsingh@chromium.org>
 <85e89b0c-5f2c-a4b1-17d3-47cc3bdab38b@schaufler-ca.com>
 <20200221194149.GA9207@chromium.org>
 <8a2a2d59-ec4b-80d1-2710-c2ead588e638@schaufler-ca.com>
 <202002211617.28EAC6826@keescook>
 <7fd415e0-35c8-e30e-e4b8-af0ba286f628@schaufler-ca.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7fd415e0-35c8-e30e-e4b8-af0ba286f628@schaufler-ca.com>
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Fri, Feb 21, 2020 at 05:04:38PM -0800, Casey Schaufler wrote:
> On 2/21/2020 4:22 PM, Kees Cook wrote:
> > I really like this approach: it actually _simplifies_ the LSM piece in
> > that there is no need to keep the union and the hook lists in sync any
> > more: they're defined once now. (There were already 2 lists, and this
> > collapses the list into 1 place for all 3 users.) It's very visible in
> > the diffstat too (~300 lines removed):
> 
> Erk. Too many smart people like this. I still don't, but it's possible
> that I could learn to.

Well, I admit that I am, perhaps, overly infatuatied with "fancy" macros,
but in cases like this where we're operating on a list of stuff and doing
the same thing over and over but with different elements, I've found
this is actually much nicer way to do it. (E.g. I did something like
this in drivers/misc/lkdtm/core.c to avoid endless typing, and Mimi did
something similar in include/linux/fs.h for keeping kernel_read_file_id
and kernel_read_file_str automatically in sync.) KP's macros are more
extensive, but I think it's a clever to avoid going crazy as LSM hooks
evolve.

> > Also, there is no need to worry about divergence: the BPF will always
> > track the exposed LSM. Backward compat is (AIUI) explicitly a
> > non-feature.
> 
> As written you're correct, it can't diverge. My concern is about
> what happens when someone decides that they want the BPF and hook
> to be different. I fear there will be a hideous solution.

This is related to some of the discussion at the last Maintainer's
Summit and tracepoints: i.e. the exposure of what is basically kernel
internals to a userspace system. The conclusion there (which, I think,
has been extended strongly into BPF) is that things that produce BPF are
accepted to be strongly tied to kernel version, so if a hook changes, so
much the userspace side. This appears to be proven out in the existing
BPF world, which gives me some evidence that this claim (close tie to
kernel version) isn't an empty promise.

> > I don't see why anything here is "harmful"?
> 
> Injecting large chucks of code via an #include does nothing
> for readability. I've seen it fail disastrously many times,
> usually after the original author has moved on and entrusted
> the code to someone who missed some of the nuance.

I totally agree about wanting to avoid reduced readability. In this case,
I actually think readability is improved since the macro "implementation"
are right above each #include. And then looking at the resulting included
header, all the metadata is visible in one place. But I agree: it is
"unusual", but I think on the sum it's an improvement. (But I share some
of the frustration of the kernel being filled with weird preprocessor
insanity. I will never get back the weeks I spent on trying to improve
the min/max macros.... *sob*)

> I'll drop objection to this bit, but still object to making
> BPF special in the infrastructure. It doesn't need to be and
> it is exactly the kind of additional complexity we need to
> avoid.

You mean 3/8's RUN_BPF_LSM_*_PROGS() additions to the call_*_hook()s?

I'll go comment on that thread directly instead of splitting the
discussion. :)

-- 
Kees Cook
