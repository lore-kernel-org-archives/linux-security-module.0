Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D231FC7619A
	for <linux-security-module@archiver.kernel.org>; Wed, 12 Apr 2023 17:47:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229798AbjDLRrT (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 12 Apr 2023 13:47:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjDLRrT (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 12 Apr 2023 13:47:19 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2E25359D
        for <linux-security-module@vger.kernel.org>; Wed, 12 Apr 2023 10:47:15 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id i8so3199017plt.10
        for <linux-security-module@vger.kernel.org>; Wed, 12 Apr 2023 10:47:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1681321635; x=1683913635;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:subject:cc:to:from:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=JVhObB3pFB3+JaaniJO6XIrsQw2d1LVxP2LuKs9XZcc=;
        b=EACknNnvIxO6koyXmnNqiJIkak12zcKqoOsIpv9DlCgPnOMR917+6w8Vp4Grp+axS3
         Z5HvRHpJ2Y98pwuH9wGwt73A8Kxb/lOCaDllT51WTfYGVFL7QjJDNPCZ/BsAWyzRbr2Y
         fJRmYlUNV62evckDMG5VPOjRY3eN6N5G0sBCY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681321635; x=1683913635;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:subject:cc:to:from:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JVhObB3pFB3+JaaniJO6XIrsQw2d1LVxP2LuKs9XZcc=;
        b=N+a/okmpd51nr+OCmEU0fykGo1GapkDlIVo22wKthNfUQWP6M5odFT5NNLCV0g1+fg
         tsWiABzLjx9LoBBzB4oHZFaPlrFvVMgJ9KQhhEdYleQwqy6mO829lWfaQhfmz8u1wZ17
         ubR1Zi4s6NtNElpGLDjm1p0kI9wVSyWcvpNLumER+mT8gv4wLnffuOagNLaFASvCPTyw
         IJ62FbrFUmCbXtDPB9Fq3C8UmGaoO6ZuWMuI1Q1z+dBumzS6ppTv0pu/sUAowQLi9Tz6
         XCMns6acQudcN0wDZ8DWCYUCrsQ4dcf6Oa9boeqgy/gezGPMUTlxk8sutVJvtXKW2HxZ
         ZaBQ==
X-Gm-Message-State: AAQBX9f3W8osS2oRzTTKE0VusbKgpwA+atyU9KD5svtFpbBDEMF1q/bt
        LMtQWmxqf2BoE1y+LIn+v1+w0w==
X-Google-Smtp-Source: AKy350ayXHsJOaz7sthyWDNvlrnlCi/IYkmMb5i+Ay7iGfbZS5PWGv/Kdg7GW3zkdy+nL1m8hjlAlQ==
X-Received: by 2002:a17:90b:390d:b0:23f:9fac:6b31 with SMTP id ob13-20020a17090b390d00b0023f9fac6b31mr8987145pjb.25.1681321635270;
        Wed, 12 Apr 2023 10:47:15 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id w11-20020a1709027b8b00b001a5266b90aesm2147553pll.122.2023.04.12.10.47.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Apr 2023 10:47:14 -0700 (PDT)
Message-ID: <6436eea2.170a0220.97ead.52a8@mx.google.com>
X-Google-Original-Message-ID: <202304121033.@keescook>
Date:   Wed, 12 Apr 2023 10:47:13 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Paul Moore <paul@paul-moore.com>
Cc:     Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
        ast@kernel.org, daniel@iogearbox.net, kpsingh@kernel.org,
        linux-security-module@vger.kernel.org
Subject: Re: [PATCH bpf-next 0/8] New BPF map and BTF security LSM hooks
References: <20230412043300.360803-1-andrii@kernel.org>
 <CAHC9VhQHmdZYnR=+rX-3FcRh127mhJt=jAnototfTiuSoOTptg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHC9VhQHmdZYnR=+rX-3FcRh127mhJt=jAnototfTiuSoOTptg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Wed, Apr 12, 2023 at 12:49:06PM -0400, Paul Moore wrote:
> On Wed, Apr 12, 2023 at 12:33 AM Andrii Nakryiko <andrii@kernel.org> wrote:
> >
> > Add new LSM hooks, bpf_map_create_security and bpf_btf_load_security, which
> > are meant to allow highly-granular LSM-based control over the usage of BPF
> > subsytem. Specifically, to control the creation of BPF maps and BTF data
> > objects, which are fundamental building blocks of any modern BPF application.
> >
> > These new hooks are able to override default kernel-side CAP_BPF-based (and
> > sometimes CAP_NET_ADMIN-based) permission checks. It is now possible to
> > implement LSM policies that could granularly enforce more restrictions on
> > a per-BPF map basis (beyond checking coarse CAP_BPF/CAP_NET_ADMIN
> > capabilities), but also, importantly, allow to *bypass kernel-side
> > enforcement* of CAP_BPF/CAP_NET_ADMIN checks for trusted applications and use
> > cases.
> 
> One of the hallmarks of the LSM has always been that it is
> non-authoritative: it cannot unilaterally grant access, it can only
> restrict what would have been otherwise permitted on a traditional
> Linux system.  Put another way, a LSM should not undermine the Linux
> discretionary access controls, e.g. capabilities.
> 
> If there is a problem with the eBPF capability-based access controls,
> that problem needs to be addressed in how the core eBPF code
> implements its capability checks, not by modifying the LSM mechanism
> to bypass these checks.

I think semantics matter here. I wouldn't view this as _bypassing_
capability enforcement: it's just more fine-grained access control.

For example, in many places we have things like:

	if (!some_check(...) && !capable(...))
		return -EPERM;

I would expect this is a similar logic. An operation can succeed if the
access control requirement is met. The mismatch we have through-out the
kernel is that capability checks aren't strictly done by LSM hooks. And
this series conceptually, I think, doesn't violate that -- it's changing
the logic of the capability checks, not the LSM (i.e. there no LSM hooks
yet here).

The reason CAP_BPF was created was because there was nothing else that
would be fine-grained enough at the time.

-- 
Kees Cook
