Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58899C433E6
	for <linux-security-module@archiver.kernel.org>; Sat, 20 Feb 2021 14:51:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2C719614A7
	for <linux-security-module@archiver.kernel.org>; Sat, 20 Feb 2021 14:51:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229543AbhBTOvS (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Sat, 20 Feb 2021 09:51:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229667AbhBTOvP (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Sat, 20 Feb 2021 09:51:15 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8E68C061786
        for <linux-security-module@vger.kernel.org>; Sat, 20 Feb 2021 06:50:33 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id h10so15887129edl.6
        for <linux-security-module@vger.kernel.org>; Sat, 20 Feb 2021 06:50:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=g9x+oRQ4dxdX/Lcd7XzVC8mAPWvFSQ3BbpYDOmT75qU=;
        b=i1GvJWnnZAmMYuZbNa5SxOkH0LNxxBrMyouPhWfS2CgRWKPx1K1SsgK/q4TcmiLgaz
         XM8jCX60i599PSPWcd2ecI6TxjeeF7LlcymqdkKntxfLjq5gYh4+S6W7qEURIROkL3m0
         JwM+2iQzu4ecyYXjddKkeCkV6ZuBx9/BSFMOc8c8AN3rvqwLAy/BCjD2hLQf412U1Tpu
         L2vWHeTAZeGCYrluhzIm9MAziLEFqq/wdC9nRxtpQRLFwBi/djVoxC3rSsv6umkZzB9W
         u3msz0I5d7i74DZao+ZbUQ7ee13P3y/wDkc5cs+xcnmqgT2p9ogCWRR4DSlt8J+deGmk
         OlzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=g9x+oRQ4dxdX/Lcd7XzVC8mAPWvFSQ3BbpYDOmT75qU=;
        b=kp9ZxhPrRqdLgi3cVojfekrIvapM/hc0v5ubU/kDl82rakQ5m6TptaNKRM+XCHlZUQ
         89xpuYtvf8svP3L+jPHv0PnrKv2uEzcXKJyOTKt+sSPvWcfX4hfSKwen/847/sCgmv2R
         Dw0vYTtiC3oXFdZLCap3UH8ijD1XUi2JvDA92hfbGAoCXICWya1CoccPAFilkmNkof2f
         kkcQgZ2K2sgdhUNfqYb7ufe6WhyHfeDjPM57t1rqvG242Nyh/5j1Ei8iwAyISWbOhoV+
         6QeodOOdIXTJbGtepri8wQ05WgAzsShejDsDQ+RtMPsBipjfs/SuGjqiqJ8y44cAN3YM
         Z3sA==
X-Gm-Message-State: AOAM533LjhJWyLwQK25JMQgej0haQRntQPzAmy1s9BIIoIPbSyKq7cdH
        T4DDbbABLqTe99crgwgVhzVc5amPTck4vc+XP/IsSlpNU/K+
X-Google-Smtp-Source: ABdhPJxDoQDl1riak88nhmzRFC5m+4Ns2U3daQUcXKO4UHBPAml5XfjQwYfQDJVh7yqcBX+pQqn608ufvJbf4pPLn4Y=
X-Received: by 2002:a05:6402:438d:: with SMTP id o13mr14030563edc.135.1613832632309;
 Sat, 20 Feb 2021 06:50:32 -0800 (PST)
MIME-Version: 1.0
References: <CAHC9VhSiq5gqY1bfouia4GwYsE9MGGXnUOqwEtHi2u0-1=8aZQ@mail.gmail.com>
 <67cacc61-4d6a-39d5-f2c0-5530e8d1e39@namei.org>
In-Reply-To: <67cacc61-4d6a-39d5-f2c0-5530e8d1e39@namei.org>
From:   Paul Moore <paul@paul-moore.com>
Date:   Sat, 20 Feb 2021 09:50:21 -0500
Message-ID: <CAHC9VhRmFFqiF8oW_K_Rm3cKS9iEE97pjHeiTDcnYxR-HrpbeQ@mail.gmail.com>
Subject: Re: security_task_getsecid() and subjective vs objective task creds
To:     James Morris <jmorris@namei.org>
Cc:     linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        linux-audit@redhat.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Fri, Feb 19, 2021 at 9:55 PM James Morris <jmorris@namei.org> wrote:
> On Thu, 18 Feb 2021, Paul Moore wrote:
>
> > Hi all,
> >
> > When looking into a problem I noticed that audit was recording the
> > wrong subject label for a process.
>
> Is this a public bug? It would be good to know what the extent of this
> issue may be and whether it warrants a CVE.

Let me rephrase, "When looking into a problem with some new patches
that I am working on I noticed ...".

I am not aware of any public bugs relating to this subj/obj confusion,
this was simply something I noticed while doing some new work.  I
would post those patches now, but they are still incomplete.
Regardless, this subj/obj confusion is something we should resolve.

-- 
paul moore
www.paul-moore.com
