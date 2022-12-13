Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9928CC4332F
	for <linux-security-module@archiver.kernel.org>; Tue, 13 Dec 2022 15:00:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236045AbiLMPAv (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 13 Dec 2022 10:00:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235458AbiLMPAt (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 13 Dec 2022 10:00:49 -0500
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4946B209BB
        for <linux-security-module@vger.kernel.org>; Tue, 13 Dec 2022 07:00:48 -0800 (PST)
Received: by mail-pf1-x431.google.com with SMTP id n3so2352117pfq.10
        for <linux-security-module@vger.kernel.org>; Tue, 13 Dec 2022 07:00:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=GLIInnSNLsVE/J6a2Xd9bNIZvERsAp0qLY2kO8N1shU=;
        b=Zidh/R1GFynJEb18RlHBvz6IoC0Hl5ASTdipjh5/H6wQb2SnFdchuMCkvNHNhd2SFF
         3VxWkcGqLNphXP2XW2DQm0ymYpSDf1+zfFB8v/KDUQeoN2XvmqISWb3rNjY4G5HZ/D/H
         S5jQGXH2zlgbWchZ7Ao97d1ynffMYzhbG8U6RQ/93oVbsK7BpPK4EyiDuBHbcX5t8YUC
         5TN46lt8BRG1gMXFkx59ZQNCZ28+JGClpBU04vaio2+nLarBQn7EGbk4XF2WIU4ZvSxr
         c/32Pat7RujPVPPv0Z98Mx8sfGZ77eQhFGw3kJTNZ190j/MEb/2IWez4DX+gVPh9dhmL
         MeJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GLIInnSNLsVE/J6a2Xd9bNIZvERsAp0qLY2kO8N1shU=;
        b=2jugbHLug0n+/7+cgpGDbhD2Nq25Se8d0GpmMxZBHouDKUOayNHyqaj2sn0aa+NMuc
         NzYqNZFS9kSPhyKQJklYWE9nUhMO91NMpvSSLHDzj0engyFM0pc0ALWzJfM3aAqHDa2G
         LvArI0oaP2vXAncnp8NIHOyncdCsb8h3sypV74sew0K/u+1Q31iVHHRJKy+nvE2pKse+
         xeJyfcjCq4krBXTPf5jzerCjbtVbtC6jcv1iBJzUVLsNzkiPSiJh88viq5Wd8CN5l3uP
         mN3O9BE8tGvoSyPoc760ylM3RPgL5QXnIEkBoF5Yd8DHw3EddU7apSiwBbbGro9h7rp5
         vlRA==
X-Gm-Message-State: ANoB5pnbwbWoNqk8GhJOeO2xD/7mj3nUWbOXDWEEzk9D51yDHxU+WI0Y
        pLG5yy9amyjbB4M6KgI+m5lc953vSzV2yCx8RYdXUA==
X-Google-Smtp-Source: AA0mqf42WDxA4vPej1NXWlvuUSqlHsOa4aNAQrdFVrQalk7JTlYjtWMWzpWZB5ca/rP+cF+1fWJkb7w4lvvPF7AFv6Q=
X-Received: by 2002:a63:5823:0:b0:479:3a88:5e0 with SMTP id
 m35-20020a635823000000b004793a8805e0mr469934pgb.466.1670943647500; Tue, 13
 Dec 2022 07:00:47 -0800 (PST)
MIME-Version: 1.0
References: <20221209160453.3246150-1-jeffxu@google.com> <20221209160453.3246150-7-jeffxu@google.com>
 <CAHC9VhRBMTQvnBdSwMbkOsk9eemYfvCmj9TRgxtMeuex4KLCPA@mail.gmail.com>
In-Reply-To: <CAHC9VhRBMTQvnBdSwMbkOsk9eemYfvCmj9TRgxtMeuex4KLCPA@mail.gmail.com>
From:   Jeff Xu <jeffxu@google.com>
Date:   Tue, 13 Dec 2022 07:00:00 -0800
Message-ID: <CALmYWFvrasXnshO01YGWRyC7qKk4o0G88yAgkgjO1YBumF5zeA@mail.gmail.com>
Subject: Re: [PATCH v7 6/6] mm/memfd: security hook for memfd_create
To:     Paul Moore <paul@paul-moore.com>
Cc:     jeffxu@chromium.org, skhan@linuxfoundation.org,
        keescook@chromium.org, akpm@linux-foundation.org,
        dmitry.torokhov@gmail.com, dverkamp@chromium.org, hughd@google.com,
        jorgelo@chromium.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
        jannh@google.com, linux-hardening@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Fri, Dec 9, 2022 at 10:29 AM Paul Moore <paul@paul-moore.com> wrote:
>
> On Fri, Dec 9, 2022 at 11:05 AM <jeffxu@chromium.org> wrote:
> >
> > From: Jeff Xu <jeffxu@google.com>
> >
> > The new security_memfd_create allows lsm to check flags of
> > memfd_create.
> >
> > The security by default system (such as chromeos) can use this
> > to implement system wide lsm to allow only non-executable memfd
> > being created.
> >
> > Signed-off-by: Jeff Xu <jeffxu@google.com>
> > Reported-by: kernel test robot <lkp@intel.com>
> > ---
> >  include/linux/lsm_hook_defs.h | 1 +
> >  include/linux/lsm_hooks.h     | 4 ++++
> >  include/linux/security.h      | 6 ++++++
> >  mm/memfd.c                    | 5 +++++
> >  security/security.c           | 5 +++++
> >  5 files changed, 21 insertions(+)
>
> We typically require at least one in-tree LSM implementation to
> accompany a new LSM hook.  Beyond simply providing proof that the hook
> has value, it helps provide a functional example both for reviewers as
> well as future LSM implementations.  Also, while the BPF LSM is
> definitely "in-tree", its nature is such that the actual
> implementation lives out-of-tree; something like SELinux, AppArmor,
> Smack, etc. are much more desirable from an in-tree example
> perspective.
>
Thanks for the comments.
Would that be OK if I add a new LSM in the kernel  to block executable
memfd creation ?
Alternatively,  it might be possible to add this into SELinux or
landlock, it will be a larger change.

Thanks

Jeff


> --
> paul-moore.com
