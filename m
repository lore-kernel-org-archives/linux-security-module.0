Return-Path: <SRS0=Vtm6=VO=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FC5EC7618F
	for <linux-security-module@archiver.kernel.org>; Wed, 17 Jul 2019 19:40:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA30E21849
	for <linux-security-module@archiver.kernel.org>; Wed, 17 Jul 2019 19:40:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="bHCNywbz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725993AbfGQTkY (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 17 Jul 2019 15:40:24 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:42099 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726598AbfGQTkX (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 17 Jul 2019 15:40:23 -0400
Received: by mail-io1-f66.google.com with SMTP id e20so17314697iob.9
        for <linux-security-module@vger.kernel.org>; Wed, 17 Jul 2019 12:40:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XAQtje3xVN6zZLKy6FtX6fqxZEG02C3KM1K/siGiaSA=;
        b=bHCNywbzSvGNmK04BmApUcFx7AMqaedW7Zel4ghELj6QbEmXuXzUChsPH+QxBVfA3z
         olV9YcAX8TDIJ33/HFEQ/AeQECmLX0mC2NuJqR3HMRpVb/P+blQWSVkljvUfxM/ESu31
         +WIOCxWFbnGp0f3ZpPfenEr6bIllItN/1AdCU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XAQtje3xVN6zZLKy6FtX6fqxZEG02C3KM1K/siGiaSA=;
        b=c9TOxNzZhPfJnPQrS4P8k/4nY9HkBYbRfjkPiM4ONq6/HRoPKdYiHAY5WlQJTONCKO
         fvYYesvjTMj54VA9wPhayjLUXYg/fjqBNtuEhomE7P+KsHdCE0Ulyx7tjYu2NwYC5QCY
         PcTXmExnOlP4sWhEfceHRGTuzTDBa/IGKeKFcAPJkvttgnNAy0gYMIZHXLRhqwQ4D4L2
         UTNGRaQjohl/r6y0aXnJHKUIYxmgr0OWAX8IhHlNHpK04/DRnQRZNkFRp2/I469ig5CC
         uEd2x5o2qrxBxyICpiC0KIkPGv7VdCmYjldVok0poaHW/eZqacrUjLuuwHwZrXVdE9kU
         GR+Q==
X-Gm-Message-State: APjAAAUFkElMpDwGW6n8Rf8qN8DnYkdnK3eO2/qLVSyIe2EfkuQay/rL
        fehF2ZZFrAGSBzLi8kMVuHFqDmoUj6TzmVXJrCsIaQhb
X-Google-Smtp-Source: APXvYqyjDPl3xH2m/vy5MHs017WL9LKrLi9X2Vr7A+i01ezmewOVfT/T2pB5x6sJCSYSDHSqRWBRFjDax+BbijY5fms=
X-Received: by 2002:a6b:f816:: with SMTP id o22mr12316181ioh.166.1563392423109;
 Wed, 17 Jul 2019 12:40:23 -0700 (PDT)
MIME-Version: 1.0
References: <CAJ-EccPGqp4PmRkFk505QhDKHWn-ajxS0__Nk9VS32jV_+3Y2A@mail.gmail.com>
 <CAHk-=whY1J-LFvTa8ihiPNRSv1dwxPk9ycPCEhdcjsk7c=tGAw@mail.gmail.com>
In-Reply-To: <CAHk-=whY1J-LFvTa8ihiPNRSv1dwxPk9ycPCEhdcjsk7c=tGAw@mail.gmail.com>
From:   Micah Morton <mortonm@chromium.org>
Date:   Wed, 17 Jul 2019 12:40:12 -0700
Message-ID: <CAJ-EccNhiVk9RHvPTo7shBBE6XZqPuHi=EMwYEoXdXWhXELOzw@mail.gmail.com>
Subject: Re: [GIT PULL] SafeSetID LSM changes for 5.3
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-security-module <linux-security-module@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Tue, Jul 16, 2019 at 12:06 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Mon, Jul 15, 2019 at 9:05 AM Micah Morton <mortonm@chromium.org> wrote:
> >
> > I'm maintaining the new SafeSetID LSM and was told to set up my own
> > tree for sending pull requests rather than sending my changes through
> > James Morris and the security subsystem tree.
>
> Yes. It would be good if you also added yourself to the MAINTAINERS
> file. Right now there's no entry for security/safesetid at all.

Yes, I have a patch for this but was told it would be better to send
the patch through my tree rather than the security tree. I can send a
pull request for that.

>
> > This is my first time doing one of these pull requests so hopefully I
> > didn't screw something up.
>
> So a couple of notes:
>
>  - *please* don't rebase your work in the day before

Got it.

>
>    Was this in linux-next? was this tested at all? Hard to tell, since
> it was rebased recently, so for all I know it's all completely new

This was not in linux-next, but was tested by Jann on a Chrome OS
device. There's also the selftest for this code. But I can send
non-trivial stuff to linux-next first next time.

>
>  - don't use a random kernel-of-the-day as the base for development

Got it.

>
>    This is related to the rebasing issue, but is true even if you
> don't rebase. There is no way that it was a good idea to pick my
> random - possibly completely broken - kernel from Sunday afternoon in
> the middle of a merge window as a base for development.
>
>    If you start development, or if you have to rebase (for some *good*
> reason) you need to do so on a good stable base, not on the quick-sand
> that is "random kernel of the day during the busiest merge activity".

Makes sense. The development was not actually done on that kernel, I
just grabbed that random kernel for committing the changes on top of
(these changes were developed a little while ago, but they're all self
contained to the SafeSetID LSM), but I'll pick a stable one next time.

>
>  - Please use the "git pull-request" format and then add any extra
> notes you feel are necessary
>
>    Yes, your pull request is *almost* git pull-request, but you seem
> to have actively removed whitespace making it almost illegible. It's
> really hard to pick out the line that has the actual git repository
> address, because it's basically hidden inside one big blob of text.
>
> I've pulled this as-is since it's the first time, but I expect better next time.
>
> There are various resources on some cleanliness issues, and people
> fairly recently tried to combine it under
>
>    Documentation/maintainer/rebasing-and-merging.rst
>
> which covers at least the basics on why not to rebase etc.

Thanks for the pointer. I had not seen that yet.

>
> And if you *do* end up rebasing, consider the end result "untested",
> so then it should have been done before the merge window even started,
> and the rebased branch should have been in linux-next. And not sent to
> me the very next day.

Yep, makes sense.

>
>                    Linus

Thanks!
