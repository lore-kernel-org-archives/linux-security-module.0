Return-Path: <SRS0=3Yzx=EP=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5D88C388F9
	for <linux-security-module@archiver.kernel.org>; Mon,  9 Nov 2020 03:37:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3ABE0206B6
	for <linux-security-module@archiver.kernel.org>; Mon,  9 Nov 2020 03:37:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cQaSW0rV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729092AbgKIDhH (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Sun, 8 Nov 2020 22:37:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728038AbgKIDhH (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Sun, 8 Nov 2020 22:37:07 -0500
Received: from mail-vs1-xe43.google.com (mail-vs1-xe43.google.com [IPv6:2607:f8b0:4864:20::e43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BF06C0613CF;
        Sun,  8 Nov 2020 19:37:07 -0800 (PST)
Received: by mail-vs1-xe43.google.com with SMTP id t8so4204951vsr.2;
        Sun, 08 Nov 2020 19:37:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rMA/ceEW9wS4NZVZe5iS6l5M0I/ugt4xfY3l5BFcub8=;
        b=cQaSW0rVF4BrsPoBDU3Oa2BOCBbIrkgaNKhzq1pLo+G6KL4XPxC1p5ClouJiYwEuVz
         2IacpRUOGvUlw71hukSQLGsXagL/Bmvg2jRZsMDtfmxRAhFGYD8LybFk3dOFT5rXIW+N
         HJjwLU83wtw7klTQMFJhYawndSUKAfQ9KcDURCJyKfWh+/8P377+HOmoGA6cHpZBfYTo
         lKNw1wRmx3h6U/C1ReGwT64lpG8II5FCh7Zefu2DgfYPjhz4DOndLpFvvFzVayIZzAuV
         CAE8nW0TYJ3HLD+o/5KTXP5k87lzIrbF1lf4pHlPt5zX98Rsft4qoqR5r4OdoU/2ZbLI
         09Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rMA/ceEW9wS4NZVZe5iS6l5M0I/ugt4xfY3l5BFcub8=;
        b=AFsHA2QJvWl+bB1taJeXo1/X1VRFR0ww0HiiPZkhWHK66nMMVjB1vUDNWyva1EvPLA
         ouijaiCTAr0Ob7W3QVYdpRagDwBjBAS6T3m4ERZQU7mYwRzkqK9gr6gSx1Ycaeg+8/8d
         cVBfLAn0FtM/JeVNHToFYOQ9c+EBR4Ta/xewqzw3PqwHPuF3JpSmKoWkMLUkyCQY2SQ/
         90Q5NkpyOENkJ5MSqg72wd6kO7Z5Bw26ubmPmL1+awzqwewHkN/QflmuQ+dVl0Npz5mr
         MUhtV95kRUr9Lf0+9OG41xcCCNjxAv9fwfe+oyDmtakK9XESKY4eeYMx92xw71YWUQPC
         ne+g==
X-Gm-Message-State: AOAM531hCF/LEfQT4LZkzAe87Sks5XwlmK1odtIZVudv81qUefSV/XM8
        +MEuuR5jXTT35+tuvvRmiE7iOSakHjIWUMz2PEs=
X-Google-Smtp-Source: ABdhPJxGn1WBFQxM1r73wOrmLlSEG0qqY8tkfzmCripRce88taW4yrVpbVNLdmHu2PVWBd+/yfKhf5wMhoF0Z4lnPD0=
X-Received: by 2002:a05:6102:671:: with SMTP id z17mr7021650vsf.32.1604893026248;
 Sun, 08 Nov 2020 19:37:06 -0800 (PST)
MIME-Version: 1.0
References: <1604737451-19082-1-git-send-email-jrdr.linux@gmail.com>
 <e5401549-8c31-2c6d-58dd-864232de17af@nvidia.com> <e6859981-bc3c-9513-99e5-a99849786156@nvidia.com>
 <5efeb909-3e02-ba14-7a86-f18562a2fe69@i-love.sakura.ne.jp> <8590eb4c-256b-9ab0-5291-de8ec8d75276@nvidia.com>
In-Reply-To: <8590eb4c-256b-9ab0-5291-de8ec8d75276@nvidia.com>
From:   Souptick Joarder <jrdr.linux@gmail.com>
Date:   Mon, 9 Nov 2020 09:06:54 +0530
Message-ID: <CAFqt6zZkDm8Eg36Lakb6Y=ePp78pa2wkJkD+w15E=5qa9ohYQA@mail.gmail.com>
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

On Sun, Nov 8, 2020 at 7:47 AM John Hubbard <jhubbard@nvidia.com> wrote:
>
> On 11/7/20 5:13 PM, Tetsuo Handa wrote:
> > On 2020/11/08 4:17, John Hubbard wrote:
> >> On 11/7/20 1:04 AM, John Hubbard wrote:
> >>> On 11/7/20 12:24 AM, Souptick Joarder wrote:
> >>>> In 2019, we introduced pin_user_pages*() and now we are converting
> >>>> get_user_pages*() to the new API as appropriate. [1] & [2] could
> >>>> be referred for more information. This is case 5 as per document [1].
> >>>
> >>> It turns out that Case 5 can be implemented via a better pattern, as long
> >>> as we're just dealing with a page at a time, briefly:
> >>>
> >>> lock_page()
> >>> write to page's data
> >>> unlock_page()
> >>>
> >>> ...which neatly synchronizes with writeback and other fs activities.
> >>
> >> Ahem, I left out a key step: set_page_dirty()!
> >>
> >> lock_page()
> >> write to page's data
> >> set_page_dirty()
> >> unlock_page()
> >>
> >
> > Excuse me, but Documentation/core-api/pin_user_pages.rst says
> > "CASE 5: Pinning in order to _write_ to the data within the page"
> > while tomoyo_dump_page() is for "_read_ the data within the page".
> > Do we want to convert to pin_user_pages_remote() or lock_page() ?
> >
>
> Sorry, I missed the direction here, was too focused on the Case 5
> aspect. Yes. Case 5 (which, again, I think we're about to re-document)
> is only about *writing* to data within the page.
>
> So in this case, where it is just reading from the page, I think it's
> already from a gup vs pup point of view.
>
> btw, it's not clear to me whether the current code is susceptible to any
> sort of problem involving something writing to the page while it
> is being dumped (I am curious). But changing from gup to pup wouldn't
> fix that, if it were a problem. It a separate question from this patch.
>
> (Souptick, if you're interested, the Case 5 documentation change and
> callsite retrofit is all yours if you want it. Otherwise it's on
> my list.)

Sure John, I will take it.
