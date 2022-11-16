Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65D5CC4332F
	for <linux-security-module@archiver.kernel.org>; Wed, 16 Nov 2022 22:04:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233805AbiKPWEV (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 16 Nov 2022 17:04:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232904AbiKPWES (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 16 Nov 2022 17:04:18 -0500
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 134E8657C0
        for <linux-security-module@vger.kernel.org>; Wed, 16 Nov 2022 14:04:17 -0800 (PST)
Received: by mail-pl1-x630.google.com with SMTP id y4so17723612plb.2
        for <linux-security-module@vger.kernel.org>; Wed, 16 Nov 2022 14:04:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=VC1O7rMTvmBYyn1/bWjYQvHGFZmpsPJOUhWzFJ+UDKE=;
        b=cU1BpRMccZjJWvhPtm4flkwG+K3w6bc1YRQscCaPiee03eI4FDk3Fo3AgHmFQyDtT4
         ec26P+NTHvD1Ip1nMyiSiaj/XicJI5pgds9PrvbUr+tLRLNZwpp0ozW+CYxq3xz7qVCQ
         lejMBtbs0AWGr3ApmLrjOFhxxTWjWvnfDPZCUyRyODysJNjbu/9zCAQR5bquDHfbnKHh
         m+Ht5F9u7ozOEuN012dNaZ+CxCMRNQ3a8IAHI7QQ+KXUKLdbfDNb3/08okbxXRe1uDz2
         IjS2PqgibVExxo7c2jeXgdgkHsI/vMNQ3z95d524hFGRBaTWye8XUkFoyy6GDQimGEdV
         qbqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VC1O7rMTvmBYyn1/bWjYQvHGFZmpsPJOUhWzFJ+UDKE=;
        b=dPKNWVSdsJ2oZSsyk6YFESIlVQwJRAkhTEkzvtPXnINSVAwXNnDtAYFwsGm5MYIEiK
         vTR4hpcx8/DuiusPM1EimlJIyHFSqsul97keh58F6aK4G1K1MbVbUPidi2CCuFcJzuZ8
         1VogCk1qsj4GdVakV3T4wkF504/IVVsGwva7+/l/R9zbol7D7Ck5SVG2X8UbWx1XgagM
         Ymqis0sya6CNr/eUh19uUJYmlk3cdyu8LeqI1G6LNy2i4B+kO84yT17kqln8PGWfjfYK
         aGMYGH3Ipa/TL2c8Q5lh3yLcfMJs/nyEaLicbAkQCbbjHHVEP92Q/E1jVx6L0ep8+iIY
         2rPA==
X-Gm-Message-State: ANoB5pkdf3BvnFRVMwtrx2SnbuI69fzwzFv/4bVzYHZ1X/M0W07eGXEs
        psRDrWw5ZjTJ6cIrrOXa6+zuXl7fWGqFIkH/Qb1b
X-Google-Smtp-Source: AA0mqf5oXxU0ECvnjTunMRmFWA1TxmhY0Ow0+3ziM4fHMNKpMBbH7TE9PAAThMh3ftz2zdNo1g0IW0mEOYT4tG7RXWc=
X-Received: by 2002:a17:90a:4596:b0:1fd:5b5d:f09d with SMTP id
 v22-20020a17090a459600b001fd5b5df09dmr5820235pjg.69.1668636256527; Wed, 16
 Nov 2022 14:04:16 -0800 (PST)
MIME-Version: 1.0
References: <20221115175652.3836811-1-roberto.sassu@huaweicloud.com>
 <20221115175652.3836811-4-roberto.sassu@huaweicloud.com> <CAHC9VhTA7SgFnTFGNxOGW38WSkWu7GSizBmNz=TuazUR4R_jUg@mail.gmail.com>
 <83cbff40f16a46e733a877d499b904cdf06949b6.camel@huaweicloud.com>
In-Reply-To: <83cbff40f16a46e733a877d499b904cdf06949b6.camel@huaweicloud.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 16 Nov 2022 17:04:05 -0500
Message-ID: <CAHC9VhRX0J8Z61_fH9T5O1ZpRQWSppQekxP8unJqStHuTwQkLQ@mail.gmail.com>
Subject: Re: [RFC][PATCH 3/4] lsm: Redefine LSM_HOOK() macro to add return
 value flags as argument
To:     Roberto Sassu <roberto.sassu@huaweicloud.com>
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, revest@chromium.org,
        jackmanb@chromium.org, jmorris@namei.org, serge@hallyn.com,
        bpf@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Roberto Sassu <roberto.sassu@huawei.com>,
        stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Wed, Nov 16, 2022 at 3:11 AM Roberto Sassu
<roberto.sassu@huaweicloud.com> wrote:
> On Tue, 2022-11-15 at 21:27 -0500, Paul Moore wrote:
> > On Tue, Nov 15, 2022 at 12:58 PM Roberto Sassu
> > <roberto.sassu@huaweicloud.com> wrote:
> > > From: Roberto Sassu <roberto.sassu@huawei.com>
> > >
> > > Define four return value flags (LSM_RET_NEG, LSM_RET_ZERO, LSM_RET_ONE,
> > > LSM_RET_GT_ONE), one for each interval of interest (< 0, = 0, = 1, > 1).
> > >
> > > Redefine the LSM_HOOK() macro to add return value flags as argument, and
> > > set the correct flags for each LSM hook.
> > >
> > > Implementors of new LSM hooks should do the same as well.
> > >
> > > Cc: stable@vger.kernel.org # 5.7.x
> > > Fixes: 9d3fdea789c8 ("bpf: lsm: Provide attachment points for BPF LSM programs")
> > > Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> > > ---
> > >  include/linux/bpf_lsm.h       |   2 +-
> > >  include/linux/lsm_hook_defs.h | 779 ++++++++++++++++++++--------------
> > >  include/linux/lsm_hooks.h     |   9 +-
> > >  kernel/bpf/bpf_lsm.c          |   5 +-
> > >  security/bpf/hooks.c          |   2 +-
> > >  security/security.c           |   4 +-
> > >  6 files changed, 466 insertions(+), 335 deletions(-)
> >
> > Just a quick note here that even if we wanted to do something like
> > this, it is absolutely not -stable kernel material.  No way.
>
> I was unsure about that. We need a proper fix for this issue that needs
> to be backported to some kernels. I saw this more like a dependency.
> But I agree with you that it would be unlikely that this patch is
> applied to stable kernels.
>
> For stable kernels, what it would be the proper way? We still need to
> maintain an allow list of functions that allow a positive return value,
> at least. Should it be in the eBPF code only?

Ideally the fix for -stable is the same as what is done for Linus'
kernel (ignoring backport fuzzing), so I would wait and see how that
ends up first.  However, if the patchset for Linus' tree is
particularly large and touches a lot of code, you may need to work on
something a bit more targeted to the specific problem.  I tend to be
more conservative than most kernel devs when it comes to -stable
patches, but if you can't backport the main upstream patchset, smaller
(both in terms of impact and lines changed) is almost always better.

-- 
paul-moore.com
