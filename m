Return-Path: <SRS0=3Yzx=EP=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FDD8C388F9
	for <linux-security-module@archiver.kernel.org>; Mon,  9 Nov 2020 03:38:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 01DE820853
	for <linux-security-module@archiver.kernel.org>; Mon,  9 Nov 2020 03:38:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RYltIajF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728814AbgKIDiZ (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Sun, 8 Nov 2020 22:38:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728038AbgKIDiZ (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Sun, 8 Nov 2020 22:38:25 -0500
Received: from mail-vk1-xa42.google.com (mail-vk1-xa42.google.com [IPv6:2607:f8b0:4864:20::a42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED797C0613CF;
        Sun,  8 Nov 2020 19:38:24 -0800 (PST)
Received: by mail-vk1-xa42.google.com with SMTP id o73so1593024vka.5;
        Sun, 08 Nov 2020 19:38:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EXvLdoZOLK2vkCmDQBWkezTalz+11c+8ptopOVr4sJo=;
        b=RYltIajFnXKs/5AMCFp48j07wmtIAEgd/VwxVU65E7v1XdhKDshNGXRVLYxFNOQLUI
         yFZj5gMaxtYPgHgzzcqjBZtmSmpyYVXixQlNZHfjTmLB9iS/sR+pWHZmwHR77S9W8fqH
         Ifcfm7aavxZhDWDKW0TJj2ysS44h3StBIB1+R+VcmZjOz9+NRanUpLs6ALizPq66WQ3S
         jWFUZzv70dGL1OdR5y2e2J1s3oF+D9cQl12YtmZBrfidymaenjtNeXyFuLy6q7n4od/W
         NMcNhTQGTb5IYKUmpj5KEgPn87QFS5Y/+ApqRycR7UKW6fdNMBDY3Jut+Y4gMUhJRb5/
         TZkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EXvLdoZOLK2vkCmDQBWkezTalz+11c+8ptopOVr4sJo=;
        b=eq+lQN+QsmWdZI1pFTHxVGuVKIG/MzTRTiAD9wwyaI5R7OH8fpHvlN6QVAlPlORo7r
         NZFH555bYbW5+HciUXw8CmQVeErf/WlH6eVXeFT8NpWnMqOGNjKiG2UeZi8QMypsG2n+
         C0Fg3hObCVBFiXgPuQKkv89+acSp+ijCYLXdEumiyV4KpgUl0dSGGWQuX2uTDuW42U0d
         iX76PnAZPyZcoigox+Q+6UMEWvvEJVJ839qItXzGBgYgYDABhCHyHkOxh9Ag7+snmr13
         LTLBHKor3ZIJvDCaThYu3StoDG3CdGYIaXNceMzDNa9T6P5GxDyDiuV8HaerEcQbkFOG
         WePg==
X-Gm-Message-State: AOAM530npEHltdO0sy5D/B2n14I5sFMYGLv1F9IJ5VBGQbMzqIAUxQKj
        5lCy4RUf1Y8Leoo1wpBhYfwKbhsdPqFZBJBsUjs=
X-Google-Smtp-Source: ABdhPJwEEKUtrQCBK0PR0Qi0f0uqtamAFlHl8H1VdcMWJzPkQJ+4+C/plG4cD4dY32hnunRBo21AgvUWRjwRe5UQBMA=
X-Received: by 2002:a1f:5c4e:: with SMTP id q75mr6010923vkb.6.1604893104103;
 Sun, 08 Nov 2020 19:38:24 -0800 (PST)
MIME-Version: 1.0
References: <1604737451-19082-1-git-send-email-jrdr.linux@gmail.com>
 <e5401549-8c31-2c6d-58dd-864232de17af@nvidia.com> <e6859981-bc3c-9513-99e5-a99849786156@nvidia.com>
 <5efeb909-3e02-ba14-7a86-f18562a2fe69@i-love.sakura.ne.jp>
 <8590eb4c-256b-9ab0-5291-de8ec8d75276@nvidia.com> <40bd424d-6c4d-8b03-5d97-c572ca777b77@i-love.sakura.ne.jp>
 <1174ed3e-d33c-6de9-3873-b122013b295a@nvidia.com>
In-Reply-To: <1174ed3e-d33c-6de9-3873-b122013b295a@nvidia.com>
From:   Souptick Joarder <jrdr.linux@gmail.com>
Date:   Mon, 9 Nov 2020 09:08:12 +0530
Message-ID: <CAFqt6zbC_-y8FAyGLv_QG2VMSa8HhfR+sd=W-E4eyuWfgSXnDQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] tomoyo: Convert get_user_pages*() to pin_user_pages*()
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        linux-kernel@vger.kernel.org, Jan Kara <jack@suse.cz>,
        Matthew Wilcox <willy@infradead.org>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Sun, Nov 8, 2020 at 10:30 AM John Hubbard <jhubbard@nvidia.com> wrote:
>
> On 11/7/20 8:12 PM, Tetsuo Handa wrote:
> > On 2020/11/08 11:17, John Hubbard wrote:
> >>> Excuse me, but Documentation/core-api/pin_user_pages.rst says
> >>> "CASE 5: Pinning in order to _write_ to the data within the page"
> >>> while tomoyo_dump_page() is for "_read_ the data within the page".
> >>> Do we want to convert to pin_user_pages_remote() or lock_page() ?
> >>>
> >>
> >> Sorry, I missed the direction here, was too focused on the Case 5
> >> aspect. Yes. Case 5 (which, again, I think we're about to re-document)
> >> is only about *writing* to data within the page.
> >>
> >> So in this case, where it is just reading from the page, I think it's
> >> already from a gup vs pup point of view.
> >>
> >> btw, it's not clear to me whether the current code is susceptible to any
> >> sort of problem involving something writing to the page while it
> >> is being dumped (I am curious). But changing from gup to pup wouldn't
> >> fix that, if it were a problem. It a separate question from this patch.
> >
> > The "struct page" tomoyo_dump_page() accesses is argv/envp arguments passed
> > to execve() syscall. Therefore, these pages are not visible from threads
> > except current thread, and thus there is no possibility that these pages
> > are modified by other threads while current thread is reading.
> >
>
> Perfect. So since I accidentally left out the word "correct" above (I meant
> to write, "it's already correct"), let me be extra clear: Souptick, we
> should just drop this patch.
>

Agreed. I will drop this patch.
