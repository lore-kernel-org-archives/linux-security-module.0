Return-Path: <SRS0=8CgQ=QF=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82C97C169C4
	for <linux-security-module@archiver.kernel.org>; Tue, 29 Jan 2019 21:14:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4836320881
	for <linux-security-module@archiver.kernel.org>; Tue, 29 Jan 2019 21:14:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="bGq8wq30"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728614AbfA2VOz (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 29 Jan 2019 16:14:55 -0500
Received: from mail-yb1-f195.google.com ([209.85.219.195]:33404 "EHLO
        mail-yb1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727570AbfA2VOz (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 29 Jan 2019 16:14:55 -0500
Received: by mail-yb1-f195.google.com with SMTP id m132so7048041ybf.0
        for <linux-security-module@vger.kernel.org>; Tue, 29 Jan 2019 13:14:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rMnpgGrGHhKlVTqU2sxSlRR8gFF7F74hSHWXn3EMg3I=;
        b=bGq8wq30My03SlpBnYl6JBjIFkMLQBib4aNVxAAPMPW2WzaIqztXo3RTHJrYlcUBfh
         P4GtcmdJEfqQjGTlAw1+dWg5lVhe8qEFY4t7Iei7ViCoOYeOvqyrKUpZRdaB1KTIsMVL
         4Fnts98H22RgwTzvexoGyBAD8voXubw2j9M7U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rMnpgGrGHhKlVTqU2sxSlRR8gFF7F74hSHWXn3EMg3I=;
        b=bd0a7T8F2icCq4GHqkCJgZpDzf3GoZQQh0Vu6cVZ0I3gA/JKgcqjP/eCYWwJb1qTHg
         cP0EAistLfYFFkMOx1DvFHDrwLs05Kspw/LHeQy+GruYwS/AQA4kQdWO2UK6uW4fPKAH
         DfJUln23a2u2erzn+e6Lm6dUUBACV6fmCOKqXQNzdGVKmbU77LyhLN8nEmjcIEsqigNh
         WP7vmd4ktKFMPXjnUhrocwtp3q4L7mTrB2PqWQ3zZrww9zkizpa/OT+3A7FLxsL9eGt6
         xud2QDxHuzhz5523Sqm67RJ632tHTv+gg2eROikqtXdOEpBa2+5aN0zhzePj9KNlkgut
         /MuA==
X-Gm-Message-State: AJcUukfwskB9fFO2Ti20ysEf3S1L+TKz3A1YWYRGACAbAEmUkneSZilV
        6pIIU4Cyx2GT2W8EYTyYZsdjvH63V1l/wS1QBGTk3w==
X-Google-Smtp-Source: ALg8bN6wtSbwuoX2sr/wrYcxDfROmtOPktB2E/lHIkzB8EoUj7KO3n+LoKRNNKfBb5R0Xu7AhmDxAclKSQ/OTQ45JsQ=
X-Received: by 2002:a5b:141:: with SMTP id c1mr26222154ybp.260.1548796494879;
 Tue, 29 Jan 2019 13:14:54 -0800 (PST)
MIME-Version: 1.0
References: <CAGXu5j+V61YOk7oAEw3Fm5rOxQAmy2-3QqOZaOP_FROLBUk2Qg@mail.gmail.com>
 <20190116154606.92331-1-mortonm@chromium.org> <alpine.LRH.2.21.1901260714380.27585@namei.org>
 <CAJ-EccMc3Xz0DZAm_u09VvTzWRzhrf9x0SpJKX=4FR6NYwqkpQ@mail.gmail.com>
 <CAJ-EccMAb-OX3R6mk4me0x6dS2bQw=yZrpKmF7JpzHDWSX5e4g@mail.gmail.com>
 <CAGXu5jKLdcadm30NwpquX1iGJRsjZY-A5grc65BC64B96RE_Eg@mail.gmail.com>
 <CAJ-EccM3BzUUS0CZuhAcj47+KR57JwvhLWiQoc86LWb87wWBcg@mail.gmail.com>
 <CAJ-EccPpb_544TgW3YtcT=ptGDwTxx=KOMBdLtqUNim7ynuCdQ@mail.gmail.com> <alpine.LRH.2.21.1901300424420.16638@namei.org>
In-Reply-To: <alpine.LRH.2.21.1901300424420.16638@namei.org>
From:   Micah Morton <mortonm@chromium.org>
Date:   Tue, 29 Jan 2019 13:14:43 -0800
Message-ID: <CAJ-EccOp4zrVT2+RZQZn7j6RchVk5S7UxFjyOBF_6mpE-fHVPA@mail.gmail.com>
Subject: Re: [PATCH v5 2/2] LSM: add SafeSetID module that gates setid calls
To:     James Morris <jmorris@namei.org>
Cc:     Kees Cook <keescook@chromium.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        linux-security-module <linux-security-module@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

testsuite meaning Linux Test Project / Autotest? We have a ChromeOS
Autotest for this already
(https://chromium.googlesource.com/chromiumos/third_party/autotest/+/master/client/site_tests/security_ProcessManagementPolicy/security_ProcessManagementPolicy.py)
but it would at least need some adaptation for configuring/flushing
policies during the test. Not sure how different Linux Autotests are
from ChromeOS, if they are used at all.

Also, could you point me at the directory that holds such test scripts
in the kernel tree? Shouldn't be too difficult to port that ChromeOS
autotest to a script if we want to go that route.

On Tue, Jan 29, 2019 at 9:25 AM James Morris <jmorris@namei.org> wrote:
>
> On Mon, 28 Jan 2019, Micah Morton wrote:
>
> > FWIW, I've now done a manual test of this LSMs functionality on a
> > Linux VM built from the next-general branch. Adding policies, policy
> > enforcement by the LSM, and flushing policies all worked as intended.
> >
> > So there hopefully won't be any more surprises.
>
> It would be useful to publish these as a testsuite, or include a test
> script in the kernel tree.
>
>
> >
> > On Mon, Jan 28, 2019 at 12:19 PM Micah Morton <mortonm@chromium.org> wrote:
> > >
> > > On Mon, Jan 28, 2019 at 11:56 AM Kees Cook <keescook@chromium.org> wrote:
> > > >
> > > > On Tue, Jan 29, 2019 at 8:47 AM Micah Morton <mortonm@chromium.org> wrote:
> > > > >
> > > > > I'm getting the following crash when booting after compiling a kernel
> > > > > with this LSM enabled, so I'll have to figure out what is going on.
> > > > > All the "core" functionality of this LSM has been tested thoroughly
> > > > > (we're already using this LSM on ChromeOS), but looks like there's
> > > > > some debugging of the initialization that still needs to be done.
> > > >
> > > >
> > > > +DEFINE_LSM(safesetid_security_init) = {
> > > > +       .init = safesetid_security_init,
> > > > +};
> > > >
> > > > I think this is from not having:
> > > >
> > > > .name = "safesetid",
> > >
> > > That fixed it for me! Thanks
> > >
> > > >
> > > > I missed that in the review, sorry!
> > > >
> > > > --
> > > > Kees Cook
> >
>
> --
> James Morris
> <jmorris@namei.org>
>
