Return-Path: <SRS0=7AUc=BI=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C4DEC433E1
	for <linux-security-module@archiver.kernel.org>; Wed, 29 Jul 2020 14:33:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 26C09207E8
	for <linux-security-module@archiver.kernel.org>; Wed, 29 Jul 2020 14:33:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="WnK6zVse"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726650AbgG2OdR (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 29 Jul 2020 10:33:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726391AbgG2OdQ (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 29 Jul 2020 10:33:16 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31AE3C061794
        for <linux-security-module@vger.kernel.org>; Wed, 29 Jul 2020 07:33:16 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id y10so24620458eje.1
        for <linux-security-module@vger.kernel.org>; Wed, 29 Jul 2020 07:33:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kMlKqVpMYZrkq++S2RWxZ8THr8EJ0z+y5ejuGh6soGk=;
        b=WnK6zVseynpYShz7AuRIaVykQvUyr0PeVQ+YEYnugHbrxaPTg77BOqUSx+H2KBXM90
         zw/paDsb8vkp0/OZUl2xs+7ygdSQRg4NI2g9Jwz4Fk10Twtc8cpCHx+S8Ap/7hExNtA6
         Hu9L2x/lVBxvSXEjHdf6Pr0V7+zzd39waCyQTvSz6DPcpPdKsJP6tA48AihdTV2SmUeO
         HNJwe6HGBi6mFDaC0EZ7qT8yiGYcxvJBRgzvZ8XoUf7A4RZqwAaIkwBzssEXW6BQal5q
         /FMsF+6sAVsfK+X6uBrpfnNJlYdQSume74AVeI1gtosVjPYW1BUwpAaRsSJnStmGab3/
         5Yow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kMlKqVpMYZrkq++S2RWxZ8THr8EJ0z+y5ejuGh6soGk=;
        b=niiWAEKF+6cslAM4CLMez50Zvo5iDMkhdPWHIH4rUdQYk1GAAO61NC5ajsFIIMrA9R
         KUsk7BWhl+okMD1Ss0BtRfVj5i/b1OeBD4Mbmi64ccqdihz8nVVwqYQWxoftL/QhGne0
         Oy2DS6itehyg1RvMWxDD4mkVrLDWxWh8cxO5e6KtgJSIG+b8J2RP1lEWrPRs1AYbME3o
         6FovYyDoaWHvVg6eZkzb2k1+rCfPU5AqZ6wtqwFXOS/W8rrjTqJxvVA0LKj2yzRqVpU2
         p9mXASMSrpCHCIhZZ7Jhuo6pyKWihYXdXv7Z/8Sh4Ry2ywHgReZ50+9Mo6KFWdmQLe2g
         SKvg==
X-Gm-Message-State: AOAM530qo64qVEhbQRIfjMlR8HTTQxwMHVHzwDxHL9JwGvDD/kgF3q2m
        +ZWYS6ezM6PuDWvKQXJ9NQxq1nHyh/EbLqn4gIgvc7qPtA==
X-Google-Smtp-Source: ABdhPJxu3J7ZoN3kZhJpKA1IX3J82l3Bi86eK/HpPbP3LYDzrwmhud5SD+ftjnc27nh35GLdzF1yxpuRBb6pIis3cPs=
X-Received: by 2002:a17:906:43c9:: with SMTP id j9mr14520051ejn.542.1596033194870;
 Wed, 29 Jul 2020 07:33:14 -0700 (PDT)
MIME-Version: 1.0
References: <e3e9c9da9115fd233c5a7895dbb4a698a365b1b0.1595884394.git.rgb@redhat.com>
 <CAHC9VhSx23JiN6GprskxdEcs9uftJOp03Svh7YJbQLOV91AMiQ@mail.gmail.com>
 <20200728162722.djvy3qyclj57wsfn@madcap2.tricolour.ca> <CAHC9VhSDoi8QS3c6Wmx6agmmphja60cS3+aTKVx76xvdkxJ0DQ@mail.gmail.com>
 <20200729020106.x5tfijvnxdmujtbj@madcap2.tricolour.ca>
In-Reply-To: <20200729020106.x5tfijvnxdmujtbj@madcap2.tricolour.ca>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 29 Jul 2020 10:33:03 -0400
Message-ID: <CAHC9VhSf6eSjTvUA4FfUP+qBv_GDufBPfs=t3+BPPdFcTCD_4w@mail.gmail.com>
Subject: Re: [PATCH V3fix ghak120] audit: initialize context values in case of
 mandatory events
To:     Richard Guy Briggs <rgb@redhat.com>
Cc:     Eric Paris <eparis@parisplace.org>,
        Linux Security Module list 
        <linux-security-module@vger.kernel.org>,
        Linux-Audit Mailing List <linux-audit@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Tue, Jul 28, 2020 at 10:01 PM Richard Guy Briggs <rgb@redhat.com> wrote:
>
> On 2020-07-28 14:47, Paul Moore wrote:
> > On Tue, Jul 28, 2020 at 12:27 PM Richard Guy Briggs <rgb@redhat.com> wrote:
> > > I know you like only really minimal fixes this late, but this seemed
> > > pretty minimal to me...
> >
> > Minimal is a one (two?) line NULL check in audit_log_name(), this
> > patch is not that.
>
> I didn't try and test that since I'm not sure that would have worked
> because there appeared to be a low non-NULL value in it.  brauer1's trace had
> 0x60 and mine had 0xd0.  Or am I missing something obvious?

Well, you mentioned the obvious already: both 0x60 and 0xd0 are not
NULL.  We already have a NULL check for context->pwd elsewhere so
there is precedence for this solving a similar problem, although
without going through the git log I'm not sure what problem that
solved, or if it was precautionary.

I agree the low value looks suspicious, it almost looks like an offset
to me, ideally it would be good to understand how/why that value is
"off'.  It could be that the audit_context is not being properly
initialized, reset, or something unrelated is clobbering the value;
all things that would be nice to know.

> The patch provided the information rather than ignoring the problem ...

I disagree.

--
paul moore
www.paul-moore.com
