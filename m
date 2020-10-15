Return-Path: <SRS0=3ULx=DW=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85477C43457
	for <linux-security-module@archiver.kernel.org>; Thu, 15 Oct 2020 23:06:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 33917207DE
	for <linux-security-module@archiver.kernel.org>; Thu, 15 Oct 2020 23:06:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1602803188;
	bh=z+fHkeoc+SdFIMzQryaf5p4T5IH/eRj3B/VcjPe/yTE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=2GbpK1lstd7t+IY75Y+3/wZccqik0OSYGgB0nmcpI0diuBWYz1i9+ZH5eHfG6htSq
	 73Q0stvKkCRcLoXiXQi1pK2ZLzmUlEWPnyKaect27ySIZKDzljgyNuBO14Meeg4M8M
	 0UStSQJv1uplwyFLneL0WdFqNmHD8mAIORugwTzY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732441AbgJOXGZ (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 15 Oct 2020 19:06:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732436AbgJOXGY (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 15 Oct 2020 19:06:24 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31135C0613CF
        for <linux-security-module@vger.kernel.org>; Thu, 15 Oct 2020 16:06:24 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id f21so507077ljh.7
        for <linux-security-module@vger.kernel.org>; Thu, 15 Oct 2020 16:06:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/ySCIwp29O4ociJzzOVOKh5KY68CfkZIAay+F6Ok3yY=;
        b=e3so42TRsxuJ5mfPkYxoGNiW4GBI/Yl75Lc/i38Ex2+2KqlheN4ZFDlPXUX0UKQnhA
         JMtYEt1aWnwC1ngp0X+lLfsTMfzivxRw90SqLT+MnFlkj7RWmj4zvVQDRAi2bY9yacEZ
         UuE9J4R3Xd701mCWp6XRRasGIN1q0IKac4DUQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/ySCIwp29O4ociJzzOVOKh5KY68CfkZIAay+F6Ok3yY=;
        b=gBu/+uBH+9rg7lF0WIvKWbE33mg7bLnE5oz2IgEO4THwx9F4LyqTeMjLMf109xbWTY
         /OUDx+EN+DKGFiFs5XGe8yOYY4UhURC+i5PzULoGgCf4Rq7fLgvJVZj+LnCtQ7WjJB37
         3oLON0/uTvKmAr9756Qcz9xpnBZn88xvJIC2IUDprFRWxNPG+peljl4JxpPvMdud44Y6
         rAr1nkZ6LYoLBH0ZOcKMZ5MGNQ6pzzkPOCJrbpPgxZEOyltGj2ShcBMcdMW3XpeB1ish
         6SBd1x8+3u/FTvlNjtyH2hZMDl7mpbtIzWysV4aVmH8bDb9BNOWvanHtQ6esqhIIN9OW
         468w==
X-Gm-Message-State: AOAM533z76cvNS3k34i/KSD4+ja/zqYBzGIMLYHQqLYPKqaQ7YYhR5hX
        70kfzlgNwai0UMzQFYKH8p94x5+BLjmCCw==
X-Google-Smtp-Source: ABdhPJyaMUmqDLK9M7M2mPoQsKihHxsiZ8CpBIqPPkeYgNNMnLi31xNIsC6xtkumKl9lZEfZ6uyXjw==
X-Received: by 2002:a05:651c:1b6:: with SMTP id c22mr388288ljn.447.1602803181942;
        Thu, 15 Oct 2020 16:06:21 -0700 (PDT)
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com. [209.85.167.48])
        by smtp.gmail.com with ESMTPSA id 80sm158149lff.61.2020.10.15.16.06.20
        for <linux-security-module@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Oct 2020 16:06:21 -0700 (PDT)
Received: by mail-lf1-f48.google.com with SMTP id z2so621732lfr.1
        for <linux-security-module@vger.kernel.org>; Thu, 15 Oct 2020 16:06:20 -0700 (PDT)
X-Received: by 2002:a19:4815:: with SMTP id v21mr291703lfa.603.1602803180597;
 Thu, 15 Oct 2020 16:06:20 -0700 (PDT)
MIME-Version: 1.0
References: <CAJ-EccOQxDjSgUL0AsCywoKDbOUNWDyxCKHQc+s6+ZemUh9Uzw@mail.gmail.com>
In-Reply-To: <CAJ-EccOQxDjSgUL0AsCywoKDbOUNWDyxCKHQc+s6+ZemUh9Uzw@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 15 Oct 2020 16:06:04 -0700
X-Gmail-Original-Message-ID: <CAHk-=wg3kHxMP67XmQyCg7J+KfFgAsQqj1goUa3dKR-A812ZbA@mail.gmail.com>
Message-ID: <CAHk-=wg3kHxMP67XmQyCg7J+KfFgAsQqj1goUa3dKR-A812ZbA@mail.gmail.com>
Subject: Re: [GIT PULL] SafeSetID changes for v5.10
To:     Micah Morton <mortonm@chromium.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-security-module <linux-security-module@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

These were rebased since the merge window started, for no apparent reason.

Were they in linux-next?

And if so, why was I sent some different version?

             Linus
