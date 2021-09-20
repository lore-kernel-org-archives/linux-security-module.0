Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 059BDC433EF
	for <linux-security-module@archiver.kernel.org>; Mon, 20 Sep 2021 02:49:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D9A88604DA
	for <linux-security-module@archiver.kernel.org>; Mon, 20 Sep 2021 02:49:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233763AbhITCuw (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Sun, 19 Sep 2021 22:50:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229805AbhITCuv (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Sun, 19 Sep 2021 22:50:51 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95A88C061574
        for <linux-security-module@vger.kernel.org>; Sun, 19 Sep 2021 19:49:25 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id h17so55342875edj.6
        for <linux-security-module@vger.kernel.org>; Sun, 19 Sep 2021 19:49:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0PP3bc+mj1V45SFNdXYKQe5FNL6cSGV9CSgoKWm4SK8=;
        b=k20AHUyc/YOtmR9xEdj7hvYERAXgH8ckegkKEY9mnl2Z/o8dqA9xE2SwDhH5qCfhvz
         AwP7q1ueg27rwry+MV2Mlqy/K0WHshxcVokp+14F9+o9ewkj9GJiAIOPsEAwwBFz1hSD
         blzLcI2ys7yslE4ReMhpvrhPy3n/y4swYzduNlPokGpnmNhbbqKI0iu/Zub/+2OD1Cyy
         WxYXTU9LXaa1aPNQqA6CdQlHon7mLqjQReM6KvcRJk9q+Q2axQmS9ALv0ZxsRgSLC905
         Q6IXnD8lfzWvGALQNeWJ2mz1j5ILhHRVngNhnf2VMxUT8QD+upKm2K7bX6IeioyYFQg/
         qCtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0PP3bc+mj1V45SFNdXYKQe5FNL6cSGV9CSgoKWm4SK8=;
        b=5q65PfjZgMnWaDJmxkYUAET/LzxWP/wAM4q5cYgjjio/sZZN3ntYvg6416FhCgpXWT
         5deyM2YonP9qr+1CKp6xNkB90ZnR6jxJfBnMPFK0FqHLLbe65VpTAMM0kul0uPA7gGoM
         Cu7uycR0KSCSZH+Izu9lQvjR3e5Q416t47l6cE7FvzXbSR5qlos9NnWWs33+ctgvRbYn
         t/0hndr5eJKeV88rf7SzK54Aj/kpyu3d8d83nkpzk8g2GEmOoJwbw+qNadNgOhiQRCQG
         sFhnbHPKGD4qIEeuTRfG3oh9ciW3+X7mM2hSoI3bJ5MtIo54yhf7akTaHQjcMMEJ5kI8
         Eykg==
X-Gm-Message-State: AOAM533831WoaQQTBeWymVsUqydz07DqCIOQSdBz6dLscC9w5X4Kw97e
        z7IJswjRZbw4WYskC0iUaDWq9qBOhsoA29115CWGsrFr4A==
X-Google-Smtp-Source: ABdhPJypXxL+vQ5ePHV7fGZpHgMBFe/zfZbAaSuCtCNp63BRQj0+oVqEIlD8zVZiGPyLrR7QFTFLq+iYNGmo9mxXnb0=
X-Received: by 2002:a50:d805:: with SMTP id o5mr25868291edj.104.1632106164164;
 Sun, 19 Sep 2021 19:49:24 -0700 (PDT)
MIME-Version: 1.0
References: <20210914131516.128823-1-omosnace@redhat.com> <CAHC9VhTLvAy4QtmSunpA+cHSuYrnYt_-f6dTiu+VSX2ifiJ2Xg@mail.gmail.com>
In-Reply-To: <CAHC9VhTLvAy4QtmSunpA+cHSuYrnYt_-f6dTiu+VSX2ifiJ2Xg@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Sun, 19 Sep 2021 22:49:13 -0400
Message-ID: <CAHC9VhRKqcxg5kYC7VvAriZA7-CJ2QGA9-n68r7AvyCCmCJQYw@mail.gmail.com>
Subject: Re: [PATCH] lsm_audit: avoid overloading the "key" audit field
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     linux-security-module@vger.kernel.org,
        James Morris <jmorris@namei.org>,
        Steve Grubb <sgrubb@redhat.com>, linux-audit@redhat.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Tue, Sep 14, 2021 at 10:49 AM Paul Moore <paul@paul-moore.com> wrote:
>
> On Tue, Sep 14, 2021 at 9:15 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> >
> > The "key" field is used to associate records with the rule that
> > triggered them, os it's not a good idea to overload it with an
> > additional IPC key semantic. Moreover, as the classic "key" field is a
> > text field, while the IPC key is numeric, AVC records containing the IPC
> > key info actually confuse audit userspace, which tries to interpret the
> > number as a hex-encoded string, thus showing garbage for example in the
> > ausearch "interpret" output mode.
> >
> > Hence, change it to "ipc_key" to fix both issues and also make the
> > meaning of this field more clear.
> >
> > Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> > ---
> >  security/lsm_audit.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
>
> Seems reasonable to me, I can merge it via the audit/next tree unless
> James would prefer to take it via the LSM tree.

As this is pretty minor and unlikely to conflict with any LSMs, I've
gone ahead and merged this into the audit/next tree.

-- 
paul moore
www.paul-moore.com
