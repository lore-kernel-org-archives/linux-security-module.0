Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70680C43461
	for <linux-security-module@archiver.kernel.org>; Thu, 15 Apr 2021 14:00:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4FA4361153
	for <linux-security-module@archiver.kernel.org>; Thu, 15 Apr 2021 14:00:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233286AbhDOOA3 (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 15 Apr 2021 10:00:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233282AbhDOOA2 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 15 Apr 2021 10:00:28 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29638C061756
        for <linux-security-module@vger.kernel.org>; Thu, 15 Apr 2021 07:00:05 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id e7so28135147edu.10
        for <linux-security-module@vger.kernel.org>; Thu, 15 Apr 2021 07:00:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Y6SOtxaSvvSrMRGWadRLTdN5j/Ia40PgWlLDe/mfqno=;
        b=MtB3uFfgeAtlB7+OskzJhQgeqwn0OUXUhk2ByLLtZl2bG065DMtx6WtfeFL27cIv20
         F3h8q+RDHP8unvp7PjqcwcC3Qie+7t/E+fduqwCNU9i8Cw64UNxPyTbi93n/PELs8ZPM
         kTvAujHl7X11hfvBCj7U1z/Oqk0eqF5I9nbCDEq9pMmz2J4+tUxm7Xmiv9x4w7pQ2dlT
         HlfDfCHkqpVQBN/d2eu3lXVdPrqQ/2fVu769Th8o99VPtiH3lfZFtIkCF5mQKT56sYcT
         /S5PLABL7KFsWZKOgq2t2bKts+N2GCteAAqmzCYLrsdyXH/FqvTWgld1bk781P0leb9l
         qbpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Y6SOtxaSvvSrMRGWadRLTdN5j/Ia40PgWlLDe/mfqno=;
        b=IY5SNZOdZ1EBURj37ADVMOgfvwCj7V1UYF81t1vGCsXeDhPJmj3S+5hUNukoP/bVSo
         rvY5lk9vsRNPFufCzAjyIlkxaCQXhjefvq5DWVXwLfp1ajKQWH0TlGRsLrqSGaunVG38
         EbB9yjL7TsG507iBqqn9dknz1lQ9lgsCQM/3TjvA2wTjLbujDerRnVJbraOCC2q5MrLz
         7boajfPeX/HL5gkXh7DTk2TkhZSKvB48Kmk3bL1ieSEX1xtVrzGNBs1iE1TXvSUchU8X
         wzr5wrNbz4SLP+Brff+ZOFmYcymeUMrXO0c6J5IOqbt5UWohC9FSbzRT46vr1YTY0KTn
         Scyw==
X-Gm-Message-State: AOAM530Ewb3SUe1dK3ilRgNfd3xmILlRJesya/PXZJdj7tDfE57U8DnU
        5JaDo8InlC1GyEjitjPF7sp2NwJSZ7ENYZVxdrEj
X-Google-Smtp-Source: ABdhPJxZmXYSXlByiPXfvpOnk1xaJfWfuy87POt7oGwxO8XTzXAp9SNEduKcz1rwITJhH+c/jpKTsNSWGMSeUJRaCTQ=
X-Received: by 2002:a05:6402:1cc1:: with SMTP id ds1mr4251308edb.135.1618495203692;
 Thu, 15 Apr 2021 07:00:03 -0700 (PDT)
MIME-Version: 1.0
References: <20210309143953.142341-1-richard_c_haines@btinternet.com>
 <CAHC9VhSHm-GrmjdZKPFf8Rr5JNzo7ieR+mSy7F3n-KjfD1OEaA@mail.gmail.com>
 <20210413190150.GB26626@mail.hallyn.com> <96941e4977f38dea58a56fe19cfeb84179f0e3ef.camel@btinternet.com>
In-Reply-To: <96941e4977f38dea58a56fe19cfeb84179f0e3ef.camel@btinternet.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 15 Apr 2021 09:59:52 -0400
Message-ID: <CAHC9VhTcEx07YZ=F5M3kft+YL1aYBi-cN6PvuGr+cZ2HWMD3pA@mail.gmail.com>
Subject: Re: [RFC PATCH 0/3] LSM Documentation - Render lsm_hooks.h for kernel_docs
To:     Richard Haines <richard_c_haines@btinternet.com>
Cc:     "Serge E. Hallyn" <serge@hallyn.com>,
        linux-security-module@vger.kernel.org, linux-doc@vger.kernel.org,
        corbet@lwn.net, James Morris <jmorris@namei.org>,
        casey@schaufler-ca.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Thu, Apr 15, 2021 at 9:54 AM Richard Haines
<richard_c_haines@btinternet.com> wrote:
> Thanks for the comments, I'll rebuild on 5.12-rc7 and resubmit as a
> patch.

Thanks Richard.

-- 
paul moore
www.paul-moore.com
