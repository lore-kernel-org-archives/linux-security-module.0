Return-Path: <SRS0=YGRx=XF=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB7DAC49ED7
	for <linux-security-module@archiver.kernel.org>; Tue, 10 Sep 2019 22:19:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F05F2168B
	for <linux-security-module@archiver.kernel.org>; Tue, 10 Sep 2019 22:19:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WVW4+EiZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726242AbfIJWTD (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 10 Sep 2019 18:19:03 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:43641 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726026AbfIJWTC (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 10 Sep 2019 18:19:02 -0400
Received: by mail-wr1-f67.google.com with SMTP id q17so17569063wrx.10
        for <linux-security-module@vger.kernel.org>; Tue, 10 Sep 2019 15:19:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nBXRx5mVHWci6I1kgFy5zlBZuu5oArTugqhP9VSH4To=;
        b=WVW4+EiZTPikhA8mWWD85POMnoVIYIN3GSDFGaUoJ3/cTkSfxPsjieHMepOmXvO0ll
         nYVFncoBEitbXaZ5HDQda7CkFq7VsJHDIbKbZJGptRJwiP17M/3RHaay8Pw5anLIYAtP
         0i4tR9nL7EmWoKzl5iQKFdBuc69sIia2wh5nZinjChhsWEsQGhd2Ur4nXpreI+c5EoyZ
         s06d+SU154yFhGMHVRWFs2l6lyOWObTvSVDAZ0MJ0oi80iCnaws6+H7J0kzAGWw8kkhF
         yMyKm80GQJR/l4fyAiM8FZauZFZvAXHULgsplfdcrHXYqWFCQyZgLG6eEVGB0cTpmBfc
         xtMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nBXRx5mVHWci6I1kgFy5zlBZuu5oArTugqhP9VSH4To=;
        b=IWBM6fNNK5rbGGgW73cpIGN122Ise7Kzp7s6+JIt7j49MmzpTL6lwRwZYZtIEerl40
         3cQJ1lpTdCwQDcupSbGCU4RLsEYjAY8mslaPGhTww/hcjzr1H6uZCrFCzVzJGEfhzWEY
         syh/PN4+Cd9DeSjh9i4Fb6l60N24ah6xh02OhZrqqYdA+Yjn2G2eILhep3HScEPQmZVB
         pydMuIyuSzc8kZNDQYRq6Wg3Tgc7D7e5+0YXWwtkhmCP66hfLv6RtbnVJf3H+5qMrBps
         /u2SmW02bBUeonAxefmDi3BFvXHWa9P3bXyaugHX39Gr5UKoB8sg7cEg0vkSbdX0qCsr
         fHwg==
X-Gm-Message-State: APjAAAUt9VeNtHN8ymL12WwRb9lki/NiSrqpsN8TdD21JAWVtHooCpt4
        +1H85+u5Dcm2Hoonq+BLP/JgtxezRRHoBIg8Shz+Aa/A
X-Google-Smtp-Source: APXvYqyATwYB64PHAoqvPXhoWSiffkkoqOvV20ZSR7htj9lga5zeNel2ZFU7WKXkKQS6UEvwINTv8aR5ajpu5AWx+9k=
X-Received: by 2002:adf:d4c3:: with SMTP id w3mr27547933wrk.100.1568153940787;
 Tue, 10 Sep 2019 15:19:00 -0700 (PDT)
MIME-Version: 1.0
References: <20190830154549.vss6h5tlrl6d5r5y@decadent.org.uk>
 <20190830154720.eekfjt6c4jzvlbfz@decadent.org.uk> <CACdnJuutzv+0nPKeizsiaix5YtYHU4RSoH-hPFfG1Z8sW_yy2w@mail.gmail.com>
 <alpine.LRH.2.21.1909100816170.3709@namei.org>
In-Reply-To: <alpine.LRH.2.21.1909100816170.3709@namei.org>
From:   Richard Weinberger <richard.weinberger@gmail.com>
Date:   Wed, 11 Sep 2019 00:18:49 +0200
Message-ID: <CAFLxGvxRVwt0=wtKJnZB6s+VDCoGT3vsW27P2MECO999sJKAHw@mail.gmail.com>
Subject: Re: [PATCH 2/2] mtd: phram,slram: Disable when the kernel is locked down
To:     James Morris <jmorris@namei.org>
Cc:     Matthew Garrett <mjg59@google.com>,
        David Howells <dhowells@redhat.com>,
        Joern Engel <joern@lazybastard.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        Ben Hutchings <ben@decadent.org.uk>,
        linux-mtd@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Tue, Sep 10, 2019 at 5:17 PM James Morris <jmorris@namei.org> wrote:
>
> On Tue, 10 Sep 2019, Matthew Garrett wrote:
>
> > On Fri, Aug 30, 2019 at 11:47 AM Ben Hutchings <ben@decadent.org.uk> wrote:
> > >
> > > These drivers allow mapping arbitrary memory ranges as MTD devices.
> > > This should be disabled to preserve the kernel's integrity when it is
> > > locked down.
> > >
> > > * Add the HWPARAM flag to the module parameters
> > > * When slram is built-in, it uses __setup() to read kernel parameters,
> > >   so add an explicit check security_locked_down() check
> > >
> > > Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
> > > Cc: Matthew Garrett <mjg59@google.com>
> > > Cc: David Howells <dhowells@redhat.com>
> > > Cc: Joern Engel <joern@lazybastard.org>
> > > Cc: linux-mtd@lists.infradead.org
> >
> > Reviewed-by: Matthew Garrett <mjg59@google.com>
> >
> > James, should I pick patches like this up and send them to you, or
> > will you queue them directly after they're acked?
>
> As long as I'm on the to or cc when they're acked, I can grab them.

Acked-by: Richard Weinberger <richard@nod.at>

BTW: I don't have 1/2 in my inbox, is it also MTD related?

-- 
Thanks,
//richard
