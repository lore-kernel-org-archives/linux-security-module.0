Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E4D6C433E0
	for <linux-security-module@archiver.kernel.org>; Thu, 24 Dec 2020 22:13:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1A760221F2
	for <linux-security-module@archiver.kernel.org>; Thu, 24 Dec 2020 22:13:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728941AbgLXWMs (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 24 Dec 2020 17:12:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728901AbgLXWMs (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 24 Dec 2020 17:12:48 -0500
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99C48C061575
        for <linux-security-module@vger.kernel.org>; Thu, 24 Dec 2020 14:12:07 -0800 (PST)
Received: by mail-lf1-x134.google.com with SMTP id o17so7115517lfg.4
        for <linux-security-module@vger.kernel.org>; Thu, 24 Dec 2020 14:12:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cF4gWolnJ46SGXTA3iokNOBB6rTqdEEZbYRTGkpsaeY=;
        b=MvN0X/pmZwkxtKecxvq3Z5pdlyl3EtTze+Z/yCEDu4b+SBlGjOcH1rOroJM5CAKO2d
         ITncuvq/yXDOOzWHRGHBxnx2Yk6KCultAXCzFrl30b7WASF+P2W8FEVBViFVWHaonL6i
         RJF1yoSkCcW9/Z4/6u/dtlCgNbEAFhP6+36dQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cF4gWolnJ46SGXTA3iokNOBB6rTqdEEZbYRTGkpsaeY=;
        b=AgnMZqR3qi8sKCMvG+FPHbQ0xQ0jhV2rwMRfg9dlTCMqgFMatBdidMIJngt9wfEH08
         VJpsQArOXC18wF3uL0xdlqlFykS7Rg4v9qjQ75UUdsHClslsNusC1maCYS1migAPqFQ2
         0FUwyin8sKOUZ126hDKH77lCdRuS2EafbqrCNZ8ccIC9Wl8VjZa7yANVbt5hEtcRuL4R
         hGKWqDLmFm9CEPT24VGmHsMu5pDf7TNk/+61zRk3X1a9olrN7JIfI3wZ0KA3wJoYPkVP
         n86baSAQxpF8nWgFPZGk+hAzVpOPHifgEF2X4Ctsm6+AOiVwtJlHpVGqlETLIKsN11/B
         FU3g==
X-Gm-Message-State: AOAM533HgUjeoOmkVTSBGwndZv0RJXfu883t+XtSNN+o4qUReHAplX5B
        2mZVH7SXFhBuhqIGH5Is0MJLXQ6A8s+H2w==
X-Google-Smtp-Source: ABdhPJzBq9TgMpNF8LORzliLH7DidPyOFkKMBvR/iFxmTbUfLqn4XWedhCC0TaGrluT+olXVwCQVoA==
X-Received: by 2002:a2e:9cc3:: with SMTP id g3mr15951008ljj.0.1608847925812;
        Thu, 24 Dec 2020 14:12:05 -0800 (PST)
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com. [209.85.167.44])
        by smtp.gmail.com with ESMTPSA id h22sm3019612lfu.128.2020.12.24.14.12.04
        for <linux-security-module@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Dec 2020 14:12:05 -0800 (PST)
Received: by mail-lf1-f44.google.com with SMTP id o19so7158711lfo.1
        for <linux-security-module@vger.kernel.org>; Thu, 24 Dec 2020 14:12:04 -0800 (PST)
X-Received: by 2002:ac2:41d9:: with SMTP id d25mr12053752lfi.377.1608847924320;
 Thu, 24 Dec 2020 14:12:04 -0800 (PST)
MIME-Version: 1.0
References: <b73e7af1-25d3-1e68-c810-3858abc489d7.ref@schaufler-ca.com> <b73e7af1-25d3-1e68-c810-3858abc489d7@schaufler-ca.com>
In-Reply-To: <b73e7af1-25d3-1e68-c810-3858abc489d7@schaufler-ca.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 24 Dec 2020 14:11:48 -0800
X-Gmail-Original-Message-ID: <CAHk-=wi3kt+T+Xyh55_ca4sUxGinhr7Y8scsNSANjGhvcy4FCQ@mail.gmail.com>
Message-ID: <CAHk-=wi3kt+T+Xyh55_ca4sUxGinhr7Y8scsNSANjGhvcy4FCQ@mail.gmail.com>
Subject: Re: [GIT PULL] Smack additional patch for v5.11
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux Security Module list 
        <linux-security-module@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Tue, Dec 22, 2020 at 4:43 PM Casey Schaufler <casey@schaufler-ca.com> wrote:
>
>   https://github.com/cschaufler/smack-next smack-for-5.11

That is not a tag.

And I really want signed tags for non-kernel.org pull requests.

Digging at that repo, I do find the tag, it's
'tags/Smack-for-5.11-io_uring-fix' and it has a proper pgp signature
from you.

So I pulled that one. But please don't make me search for these things.

                   Linus
