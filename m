Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6724C07E9D
	for <linux-security-module@archiver.kernel.org>; Fri, 23 Sep 2022 17:43:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232301AbiIWRn3 (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 23 Sep 2022 13:43:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232086AbiIWRn2 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 23 Sep 2022 13:43:28 -0400
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com [IPv6:2607:f8b0:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D4D346622
        for <linux-security-module@vger.kernel.org>; Fri, 23 Sep 2022 10:43:27 -0700 (PDT)
Received: by mail-il1-x133.google.com with SMTP id x2so511639ill.10
        for <linux-security-module@vger.kernel.org>; Fri, 23 Sep 2022 10:43:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=5stcw+uIDRgVc9Plsx5V6s+xhKAjxvD0uENxMGoP9E0=;
        b=T1TIIFo9pU0lPZIysJm9cMD7hhyFIxifFigWXMwXnO5SFfqoN+419qACXZrEqg65KM
         6WtQP1BoBCoGvCxOa89DgMbVpJE5x0TaBy2Q4BzMoVWClyS3RLexaMOw2WiAnxMmOQFg
         9cyyL1/k5F65eT4TJkloqWmCxaEqMjbhS/P9Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=5stcw+uIDRgVc9Plsx5V6s+xhKAjxvD0uENxMGoP9E0=;
        b=d4jwiUmLi3Y7T7/56BUZYJkl5DNH4Gr4MbkTcgjvNlFOx8tEncBvIfZELaz8uoLe1p
         vn/KTRyOurVaxJqfh1gPZdEMZnW9491fALpIIHV6mX96LOmcp1lO/kBaSdEewUjfd9P3
         rHCbU+P5VJIdNzdOBGmBIqkER/LoYthNQg3dXk8jsp6Ig+jqVXs2BAxidfZhb6Gs+BcX
         Ff5O1vMbPw2UxMG32229Fky5YuIqETQGh2AHnjBV8edR8xOUH0UJwbowbAQmbw6N9v8+
         xKek4UwhTa8gvK1oz4GWGKDcc9TfjY/IChwpol5fFS5w56MlfUSWGR2mgar7rRIKuC3B
         w6yw==
X-Gm-Message-State: ACrzQf3vsnPrxhRBKzviDC0RPoSJT7X3+qGL8J/7NW6bPeL/yz1lV5/r
        2rsaxEJm3PoZ3QazKv8r5Y8V7zVIcwa25gch1SEYYQ==
X-Google-Smtp-Source: AMsMyM5X33chRaSWqveDMcHCUsJ6bvqlkq21+nd+sESAcr70AlIxSMWdFo/7WtKNEeVeE4cVodLv+ZsxySliE94bU20=
X-Received: by 2002:a05:6e02:158a:b0:2d3:f1c0:6b68 with SMTP id
 m10-20020a056e02158a00b002d3f1c06b68mr4801930ilu.38.1663955006966; Fri, 23
 Sep 2022 10:43:26 -0700 (PDT)
MIME-Version: 1.0
References: <20220921185426.1663357-1-jeffxu@chromium.org> <20220921185426.1663357-2-jeffxu@chromium.org>
 <CAHC9VhS-jv5cpSdq7dxFGYH=z=5grQceNMyjroeL2KHdrVUV6g@mail.gmail.com>
In-Reply-To: <CAHC9VhS-jv5cpSdq7dxFGYH=z=5grQceNMyjroeL2KHdrVUV6g@mail.gmail.com>
From:   Jeff Xu <jeffxu@chromium.org>
Date:   Fri, 23 Sep 2022 10:43:16 -0700
Message-ID: <CABi2SkXRxomrYn-xUf3B+XswmQjXZUJXmYJECmr_nBfrZWwqkA@mail.gmail.com>
Subject: Re: [PATCH 1/1] Add CONFIG_SECURITY_SELINUX_PERMISSIVE_DONTAUDIT
To:     Paul Moore <paul@paul-moore.com>
Cc:     selinux@vger.kernel.org, linux-security-module@vger.kernel.org,
        jorgelo@chromium.org, groeck@chromium.org,
        Luis Hector Chavez <lhchavez@google.com>,
        Luis Hector Chavez <lhchavez@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Wed, Sep 21, 2022 at 12:11 PM Paul Moore <paul@paul-moore.com> wrote:
>
> On Wed, Sep 21, 2022 at 2:54 PM <jeffxu@chromium.org> wrote:
> >
> > From: Jeff Xu <jeffxu@chromium.org>
> >
> > When SECURITY_SELINUX_DEVELOP=y and the system is running in permissive
> > mode, it is useful to disable logging from permissive domain, so audit
> > log does not get spamed.
> >
> > Signed-off-by: Jeff Xu <jeffxu@chromium.org>
> > Signed-off-by: Luis Hector Chavez <lhchavez@google.com>
> > Tested-by: Luis Hector Chavez <lhchavez@chromium.org>
> > Tested-by: Jeff Xu<jeffxu@chromium.org>
> > ---
> >  security/selinux/Kconfig | 10 ++++++++++
> >  security/selinux/avc.c   |  9 +++++++++
> >  2 files changed, 19 insertions(+)
>
> I'm sorry, but I can't accept this into the upstream kernel.
> Permissive mode, both per-domain and system-wide, is not intended to
> be a long term solution.  Permissive mode should really only be used
> as a development tool or emergency "hotfix" with the proper solution
> being either an adjustment of the existing policy (SELinux policy
> booleans, labeling changes, etc.) or the development of a new policy
> module which better fits your use case.
>

Thanks for the response.
For a system that wants to control a few daemons, is there a
recommended pattern from selinux ?
I read this blog about unconfined domain (unconfined_t), maybe this is one way ?
https://wiki.gentoo.org/wiki/SELinux/Tutorials/What_is_this_unconfined_thingie_and_tell_me_about_attributes

I have two questions on unconfined domain:
1> Is unconfined_t domain supported in SECURITY_SELINUX_DEVELOP=n mode ?
2> will unconfined_t domain log also as permissive domain ?

Thanks
Jeff

> --
> paul-moore.com
