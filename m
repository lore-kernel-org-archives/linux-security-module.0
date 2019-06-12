Return-Path: <SRS0=c21G=UL=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17D08C31E48
	for <linux-security-module@archiver.kernel.org>; Wed, 12 Jun 2019 15:16:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E574520B1F
	for <linux-security-module@archiver.kernel.org>; Wed, 12 Jun 2019 15:16:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="Q90p5Iy5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729489AbfFLPQH (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 12 Jun 2019 11:16:07 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:44727 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729485AbfFLPQH (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 12 Jun 2019 11:16:07 -0400
Received: by mail-lf1-f66.google.com with SMTP id r15so12432809lfm.11
        for <linux-security-module@vger.kernel.org>; Wed, 12 Jun 2019 08:16:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YMusDYqalyv6pSFgNwPF4uKK+xbujszHazgInidAJjY=;
        b=Q90p5Iy5nY+5qK8J0YqslmnGkaZ2iwBDq4pyJAywiMsz2C3QwATrz7NQrLc5pGxWhS
         qus4894GAdS3fYkeWcUtJiCGmFclvQlmqvBAzIx+HHBrC0KroATQwxpCOcjPMKYRPCZf
         K2jMa0u60l4MkW07IjX6rS2RVjct7qxBYBZC2CaF873OtUXqQhaetEk5mswWLhCRs5JJ
         ujnL0lGBnbqS4xjB3gpsUi+6OqFkcz/r+ha4XlxnGYzWod02CJV1PEjVasAZba7uvVc9
         FZ92PVNUZRJkayLdyozPUvL5qOOtxrklkXQeU0NNI2ezIOoROxFVujhTZmMk6Y0cx0AR
         GB1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YMusDYqalyv6pSFgNwPF4uKK+xbujszHazgInidAJjY=;
        b=Sdo8vKo0Y/2D3KwWZumV1mMAklFRHqlwtEe7fc4JDmjxpUSrKiZxDNRyAMrfIXl5EF
         ONMRsSef4KrqUHckzzzTtcC3cN3KPUMXC63MRWHkkjtfMhDa29i4WNVunFhMFchgDYq7
         jpYuwHQuArBSbQXYWiPG7YSLRqqX9rAgTJ8ZyNFwsgCBdt0PhY4cVJy4hJxTSLpGUXwK
         7Y9vJv+xU8yMFPdfQD0gDY3n9GCsKDG6v2AigYRulMQELJGbL2MmXW6lB66kLvqflHjE
         qMcnX1ECzd5eSF3MHoysaOADKcUUKSe7cljU4ApcKdBbFCmrvQIGc/oRNDjqDu+FXXc3
         SNBg==
X-Gm-Message-State: APjAAAXSKqicijiMuG7hFZryT/Pa7T7aNvr/ECeLIdf1iWm66DqGE/sl
        nrrYXH6/Y7Y0bFAAmq+IyVM2COmKENE86ZnTlurA
X-Google-Smtp-Source: APXvYqyN6xVD96Jl8RDKNEI6HwNcqB1yanl1Pp+ZZ6oaxLPKOeAYdSl7QnbgMOG4UnWkxhi0P2GplkRuBKmiRCHX95M=
X-Received: by 2002:a19:7716:: with SMTP id s22mr24175955lfc.64.1560352565001;
 Wed, 12 Jun 2019 08:16:05 -0700 (PDT)
MIME-Version: 1.0
References: <20190612074456.2504-1-janne.karhunen@gmail.com> <1560346093.4578.18.camel@linux.ibm.com>
In-Reply-To: <1560346093.4578.18.camel@linux.ibm.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 12 Jun 2019 11:15:54 -0400
Message-ID: <CAHC9VhRbO-ua-0Y=17zg97+oopXaj_eYBRzadrgSrG=twSjYRw@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] LSM: switch to blocking policy update notifiers
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     Janne Karhunen <janne.karhunen@gmail.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Wed, Jun 12, 2019 at 9:28 AM Mimi Zohar <zohar@linux.ibm.com> wrote:
> Hi Paul,

/me waves

> On Wed, 2019-06-12 at 10:44 +0300, Janne Karhunen wrote:
> > Atomic policy updaters are not very useful as they cannot
> > usually perform the policy updates on their own. Since it
> > seems that there is no strict need for the atomicity,
> > switch to the blocking variant. While doing so, rename
> > the functions accordingly.
> >
> > Changelog v2
> > - Rebase to 'next-queued-testing'
> >
> > Signed-off-by: Janne Karhunen <janne.karhunen@gmail.com>
> > Acked-by: Paul Moore <paul@paul-moore.com>
>
> The patches need to be upstreamed together.  Do you have any problems
> with my upstreaming them via linux-integrity?

Nope, I've been operating under the assumption that you would be
taking both patches via the linux-integrity tree.

-- 
paul moore
www.paul-moore.com
