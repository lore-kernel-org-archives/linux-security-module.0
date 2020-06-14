Return-Path: <SRS0=sigj=73=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A974DC433E0
	for <linux-security-module@archiver.kernel.org>; Sun, 14 Jun 2020 18:04:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 74360206B7
	for <linux-security-module@archiver.kernel.org>; Sun, 14 Jun 2020 18:04:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="DRIIJe/5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726648AbgFNSEL (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Sun, 14 Jun 2020 14:04:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726513AbgFNSEL (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Sun, 14 Jun 2020 14:04:11 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CF80C03E969
        for <linux-security-module@vger.kernel.org>; Sun, 14 Jun 2020 11:04:10 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id k11so14995701ejr.9
        for <linux-security-module@vger.kernel.org>; Sun, 14 Jun 2020 11:04:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=JIDHezerTgnL7GKr3m2iwi84CeS+iRS083MytP4Y2ng=;
        b=DRIIJe/5ZgOSSlM4TfHCBt9MFGwrDs7/9v9LqnO6gj/8EgG2QoDbv/MIuBAanE6F3t
         CPW2l6QinshfB3h2r4AmZDck48INalnQhwQonzVNyyJyMLWDL8eoZZQpUBlgLmTBQ/0O
         FqeUK+ySBJOXrkLCIzPVo9r0+D1OZUV3o61nw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=JIDHezerTgnL7GKr3m2iwi84CeS+iRS083MytP4Y2ng=;
        b=XjF5qEQdfxjQ16kfELFU4p/6FJml8TkiAhadLJUwJyExnMYxx7aM8W3df8uCIMpikn
         9pOJVZ9Ri9jXpzTVt2i/JphIO5QG429zhug+Poxd8BbZmg8lpyFQ7Lh+DZadiZUywco3
         eZq0i09TfcnXVjnGr/Elw89FmH2Ku8/5lnwD65klq2KBkb84anJqj5ImoU+8Zjdi10hu
         huw/x/Es2R3gACA8X4yVQ1jHUcosqKBE79EcPnH2WEjY4X+BSWw6I/F+/SbAO4BlnCGS
         09Sod/QxWMrun26cXfOqAoi9XjpzihRLLVudKAdjMtxJeN5XrV3ZZ+yf4OCYXSSP/Oie
         A2Bg==
X-Gm-Message-State: AOAM533rxZsT0qVvmYoDzqPy5dUqH0g16yXa3lrjY9AKYXC9jNrQfXz1
        JWSPrxM/R8CmeC84BP3Ws06QKts4o4LBnMBbsg9j5g==
X-Google-Smtp-Source: ABdhPJy1JcEZ408/kq8pZO4Js7eml05zSaz139bH6w3ncN57svLFY4pmDNRDM00fDbe4eH9f32xBt2TKD2SLwVFh85A=
X-Received: by 2002:a17:906:2c5b:: with SMTP id f27mr23397357ejh.413.1592157848942;
 Sun, 14 Jun 2020 11:04:08 -0700 (PDT)
MIME-Version: 1.0
References: <CAJ-EccOy4qDpbfrP5=KH40LSOx1F4-ciY2=hFv_c+goUHLJ6PQ@mail.gmail.com>
 <CAHk-=wiLXXR1+o4VAuw5MM3V1D8h6C6te3y8VMvW8iAJw6noJg@mail.gmail.com>
In-Reply-To: <CAHk-=wiLXXR1+o4VAuw5MM3V1D8h6C6te3y8VMvW8iAJw6noJg@mail.gmail.com>
From:   Micah Morton <mortonm@chromium.org>
Date:   Sun, 14 Jun 2020 11:03:58 -0700
Message-ID: <CAJ-EccPGQ62yMK1Nmvie4qWzproSqb4POwAD4_0Nt62KLbGhqg@mail.gmail.com>
Subject: Re: [GIT PULL] SafeSetID LSM changes for v5.8
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-security-module <linux-security-module@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

I amended the author on the lone commit in this pull request. For some
reason I was thinking using the "From:" line in the commit body was
how I should make things show up as Thomas as the author and me as the
committer, but looks like that=E2=80=99s not true.

I also removed my own Signed-off-by line from the pull request body
and included it in the commit instead of the Reviewed-by line.

Thanks,
Micah


The following changes since commit 3d77e6a8804abcc0504c904bd6e5cdf3a5cf8162=
:

  Linux 5.7 (2020-05-31 16:49:15 -0700)

are available in the Git repository at:

  https://github.com/micah-morton/linux.git
tags/LSM-add-setgid-hook-5.8-author-fix

for you to fetch changes up to 39030e1351aa1aa7443bb2da24426573077c83da:

  security: Add LSM hooks to set*gid syscalls (2020-06-14 10:52:02 -0700)

----------------------------------------------------------------
Add additional LSM hooks for SafeSetID

SafeSetID is capable of making allow/deny decisions for set*uid calls
on a system, and we want to add similar functionality for set*gid
calls. The work to do that is not yet complete, so probably won't make
it in for v5.8, but we are looking to get this simple patch in for
v5.8 since we have it ready. We are planning on the rest of the work
for extending the SafeSetID LSM being merged during the v5.9 merge
window.

This patch was sent to the security mailing list and there were no objectio=
ns.

----------------------------------------------------------------
Thomas Cedeno (1):
      security: Add LSM hooks to set*gid syscalls

 include/linux/lsm_hook_defs.h |  2 ++
 include/linux/lsm_hooks.h     |  9 +++++++++
 include/linux/security.h      |  9 +++++++++
 kernel/sys.c                  | 15 ++++++++++++++-
 security/security.c           |  6 ++++++
 5 files changed, 40 insertions(+), 1 deletion(-)

On Fri, Jun 12, 2020 at 2:23 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> Finally emptied my normal pull request queue and starting to look at
> things I wanted to look at more closely..
>
> On Tue, Jun 9, 2020 at 11:26 AM Micah Morton <mortonm@chromium.org> wrote=
:
> >
> > This patch was sent to the security mailing list and there were no obje=
ctions.
>
> That patch as committed has both the wrong authorship, and the wrong
> sign-off chain.
>
> Not pulling.
>
>                  Linus
