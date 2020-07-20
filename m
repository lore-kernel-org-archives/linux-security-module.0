Return-Path: <SRS0=MEX0=A7=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EDE7C433DF
	for <linux-security-module@archiver.kernel.org>; Mon, 20 Jul 2020 20:22:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1976E207DF
	for <linux-security-module@archiver.kernel.org>; Mon, 20 Jul 2020 20:22:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GJSSqheo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728973AbgGTUWH (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 20 Jul 2020 16:22:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727123AbgGTUWH (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 20 Jul 2020 16:22:07 -0400
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34AA2C061794
        for <linux-security-module@vger.kernel.org>; Mon, 20 Jul 2020 13:22:07 -0700 (PDT)
Received: by mail-ot1-x344.google.com with SMTP id 18so13266540otv.6
        for <linux-security-module@vger.kernel.org>; Mon, 20 Jul 2020 13:22:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=yb0qHG3VxM7d5dCD4HDo8Pbr7p+GfWYTsYZmd9MNsB4=;
        b=GJSSqheozR65hfYOQGdBO3OAMn2AQghb7ftn+IPuaNsNPb9U2OukkemLS3P7RG41fp
         mFEcyPzNmAuGhmlnQtP0S4kB4RZz1hr7aAVy1Q04fwHBTGv8Wosfb0XA6c8e9cc2bCgN
         +JZZoI8wdygHzDOOIEdubez4WQvTaxrewm3nkvUWeNQ2WqTykxJkZjNXn15eIguSA/AE
         iXbU8jHye/Hn/eD9lZAz3qynr0Am7FYAaXSq744wGr2KSYclRutbvD8gmvmtH9Q/QMm6
         pgnIYkZ6rlsAe15UBQsxwJ3n3is87UznzKndqqsgfA0NtZfFlohDn2YqoHM5ZoWq0gM0
         7zlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=yb0qHG3VxM7d5dCD4HDo8Pbr7p+GfWYTsYZmd9MNsB4=;
        b=AMvZwzNN6HFGM4x/A7zlAB2qsRDYcNKu8dbpSLYP+qVp0O1a4qx3BLoLR8oBPmR3pq
         8gRQQnsIj2i8Gg1ijbBH42mXY66CgdM98grSBwQ9cevxyMgtoSpi+jP9l+CZipGGRTYV
         L/rTs7TFVJXSsJJHg6a1XRvspPdZgQjOsktRbOjf2rCikodGbuZ28pPS3ZxvhniQ4mq4
         ZyJHhBP0hsB+g9JpM8xSKR8BZe2hp2qRZF6A4TqYnz8tQBrkd51IZVMhOn4imRKX7W7L
         N7FKetccponvHfZ2pFxwSyng10yrkvGIiYGDGVsSrNhtDy89VW5OQphR9XkVu441YI1D
         Txdg==
X-Gm-Message-State: AOAM531MkzSfSelRsHBmz8r+i2QEt7MP5KUn1z+EzKtU1k7v2oa1k2al
        5/l3r0zegYqxN0nBaN3t+SKrEz39tydllEHvg92v2Al5
X-Google-Smtp-Source: ABdhPJw4lPWNTZOxz790n+I+n/P3Lf/s2Dcy8ei5hHSu8iA5VQpkMYM+FMCCtobUOH7pon3OmaRcXZRwSi+tzAlIFiA=
X-Received: by 2002:a9d:4c0e:: with SMTP id l14mr22436662otf.308.1595276526497;
 Mon, 20 Jul 2020 13:22:06 -0700 (PDT)
MIME-Version: 1.0
References: <20200720091328.290336-1-mtk.manpages@gmail.com>
 <20200720091328.290336-13-mtk.manpages@gmail.com> <CALQRfL5-aL3h6M+CYqkVHSpPKQ-i3s+RWD8060AicrGPP3vSfw@mail.gmail.com>
In-Reply-To: <CALQRfL5-aL3h6M+CYqkVHSpPKQ-i3s+RWD8060AicrGPP3vSfw@mail.gmail.com>
Reply-To: mtk.manpages@gmail.com
From:   "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Date:   Mon, 20 Jul 2020 22:21:55 +0200
Message-ID: <CAKgNAkh=oa2Rv-sfsY3mNsvUdTi5sO0hvY9PSQTGCraJ=3+3eA@mail.gmail.com>
Subject: Re: [PATCH 12/15] Manual pages: cap_get_file.3: NOTES: note the
 effect of the Ambient set
To:     "Andrew G. Morgan" <morgan@kernel.org>
Cc:     LSM List <linux-security-module@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Hi Andrew,

On Mon, 20 Jul 2020 at 17:36, Andrew G. Morgan <morgan@kernel.org> wrote:
>
> I've applied all but this one. This one seems to imply that if the
> effective bit is lowered, but the permitted bits are raised, the
> ambient will have some sort of effect. This isn't how it works. Any
> file caps (even an empty set) suppresses any effect of the ambient
> vector.

Thanks for catching that. I was trying to capture this piece of the
execve() transformation rules:

P'(effective)   = F(effective) ? P'(permitted) : P'(ambient)

But of course, I failed to capture the detail that it is the process's
*new* ambient set (which, as you note, is cleared if the file has any
attached capabilities) that is assigned to the effective set. Perhaps
the text is best left as is. If I have some better idea, I'll come
back to you.

Thanks,

Michael

> On Mon, Jul 20, 2020 at 2:14 AM Michael Kerrisk (man-pages)
> <mtk.manpages@gmail.com> wrote:
> >
> > The addition of Ambient capabilities in Linux 4.3 rendered the text on
> > the effect of the Effective bit during execve(2) out-of-date. Fix that.
> > Also add a couple of paragraph breaks to improve readability.
> >
> > Signed-off-by: Michael Kerrisk (man-pages) <mtk.manpages@gmail.com>
> > ---
> >  doc/cap_get_file.3 | 11 ++++++++---
> >  1 file changed, 8 insertions(+), 3 deletions(-)
> >
> > diff --git a/doc/cap_get_file.3 b/doc/cap_get_file.3
> > index ceacbaf..dc7b571 100644
> > --- a/doc/cap_get_file.3
> > +++ b/doc/cap_get_file.3
> > @@ -103,13 +103,18 @@ or
> >  These functions are specified by withdrawn POSIX.1e draft specification.
> >  .SH NOTES
> >  Support for file capabilities is provided on Linux since version 2.6.24.
> > -
> > +.PP
> >  On Linux, the file Effective set is a single bit.
> >  If it is enabled, then all Permitted capabilities are enabled
> >  in the Effective set of the calling process when the file is executed;
> > -otherwise, no capabilities are enabled in the process's Effective set
> > +otherwise, the process's Ambient capabilities
> > +(or, before the Linux 4.3 addition of Ambient capabilities, no capabilities)
> > +are enabled in the process's Effective set
> >  following an
> > -.BR execve (2).
> > +.BR execve (2)
> > +(see
> > +.BR capabilities (7)).
> > +.PP
> >  Because the file Effective set is a single bit,
> >  if any capability is enabled in the Effective set of the
> >  .I cap_t
> > --
> > 2.26.2
> >



-- 
Michael Kerrisk
Linux man-pages maintainer; http://www.kernel.org/doc/man-pages/
Linux/UNIX System Programming Training: http://man7.org/training/
