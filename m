Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE81EC77B7A
	for <linux-security-module@archiver.kernel.org>; Tue,  6 Jun 2023 21:13:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231303AbjFFVNl (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 6 Jun 2023 17:13:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237466AbjFFVNj (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 6 Jun 2023 17:13:39 -0400
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 432DC1721
        for <linux-security-module@vger.kernel.org>; Tue,  6 Jun 2023 14:13:38 -0700 (PDT)
Received: by mail-yb1-xb30.google.com with SMTP id 3f1490d57ef6-bacfb7acdb7so7953557276.0
        for <linux-security-module@vger.kernel.org>; Tue, 06 Jun 2023 14:13:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1686086017; x=1688678017;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=39uw5j5XuTGu9DjyN0cv5Al3Po6ZxhAFPhk3sdMi2Fw=;
        b=DKJQTgOo05HezKqlZ9DS24TwMox0bUnFdDpVF3dgI7CN2ObBD3SaEYsbUktmTDW3nM
         cHhKGrXhZu1KqsaCP9jnv0Bp34rx+PYS100YfKOKjM4mxA02CdLOte/kP9xZfzXsU7Jr
         TVsk8/Y9qLEb8qdVpsBs1+1hJa/fIPVVsmVwSC5ndAVa7wzGueVULvzXn1GP/M9Y8MiN
         qDmSp76aEitGo90Zj5XHY850+R8ZbbjUNosIBlhmd+7ntSi4yOLtYtjUq1hxRFx85V8u
         f4aBwZg4fN7Z3DJuHteCJdtybkK6yfduBhNRkpMcRce73D+gy8uTl0/tRwQ7+GYiVlCC
         vHzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686086017; x=1688678017;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=39uw5j5XuTGu9DjyN0cv5Al3Po6ZxhAFPhk3sdMi2Fw=;
        b=BWTKoR2mL9IPjdeKtmUxWMFLNA5qtuJs2zc0c2a9/JauzLNgM5XGA5oQ1S/kB93WnV
         1MecNL0BKITeCYS4nRmsoA+WPeeWtSgf7OCkyGTrZ9f6irm26AmqD/s/jYg01ECr4sC5
         CDkImZpGJ+t7hYhVLb2MdqH35oBs5N182eMeG+Ssg0EWTXmAthTkLTCPm5cZUQ8krTa+
         g6w1H+dPegxUMjlMh2o02auiAg+i/83FzJQ0lJx+Z5zBTUbzdQd1TAnNbnt8WlDJ01+Y
         zm1+VtVRLXQnlswHblehkZP2Xv1poiv0r+Nq8GLYggYhpcofEOsMZeWr90sU2dTDOVsE
         mqPQ==
X-Gm-Message-State: AC+VfDyAjnTJG6ExdnTkWP1cAWGJZYhGnso6Rl4Gx3U2FYe/FTwasAoJ
        kkm71i7XCrz/B0bmqzUNvPoHdH3qYjBmYPRSOYmS
X-Google-Smtp-Source: ACHHUZ7Qa99BZOB/MZdSXvp3X6lxNXMZNKUrs6bg5e4zcI6VWeiSNpPtkZjfFbJkTd4DlqH77r4OYNrsM6vZLPMRQeg=
X-Received: by 2002:a25:a007:0:b0:ba8:620b:38a7 with SMTP id
 x7-20020a25a007000000b00ba8620b38a7mr3428219ybh.53.1686086017436; Tue, 06 Jun
 2023 14:13:37 -0700 (PDT)
MIME-Version: 1.0
References: <20230503064344.45825-1-aleksandr.mikhalitsyn@canonical.com>
 <CAHC9VhTx+6f8riuGOG40HZoaYx3F8Kf3Hm7Eb5k3-An91eMWgg@mail.gmail.com> <CAEivzxcVQoA9rN06BtHJzyHCaN60RG1-cyGEEw-P+dp-tCB=QA@mail.gmail.com>
In-Reply-To: <CAEivzxcVQoA9rN06BtHJzyHCaN60RG1-cyGEEw-P+dp-tCB=QA@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 6 Jun 2023 17:13:26 -0400
Message-ID: <CAHC9VhQnOszTFaFVBZACQCDxsuD6JrxDffmmJ-wBudK2MJ2pUA@mail.gmail.com>
Subject: Re: [PATCH v2] LSM: SafeSetID: fix UID printed instead of GID
To:     Aleksandr Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
Cc:     mortonm@chromium.org, penguin-kernel@i-love.sakura.ne.jp,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Tue, Jun 6, 2023 at 2:50=E2=80=AFPM Aleksandr Mikhalitsyn
<aleksandr.mikhalitsyn@canonical.com> wrote:
> On Thu, May 18, 2023 at 8:59=E2=80=AFPM Paul Moore <paul@paul-moore.com> =
wrote:
> > On Wed, May 3, 2023 at 2:44=E2=80=AFAM Alexander Mikhalitsyn
> > <aleksandr.mikhalitsyn@canonical.com> wrote:
> > >
> > > pr_warn message clearly says that GID should be printed,
> > > but we have UID there. Let's fix that.
> > >
> > > Found accidentaly during the work on isolated user namespaces.
> > >
> > > Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical=
.com>
> > > ---
> > > v2: __kuid_val -> __kgid_val
> > > ---
> > >  security/safesetid/lsm.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > I'm assuming you're going to pick this up Micah?
> >
> > Reviewed-by: Paul Moore <paul@paul-moore.com>
>
> Dear Paul!
>
> Thanks for your review!
>
> Gentle ping to Micah Morton :-)

Micah?

The right thing would be for Micah to merge this via the SafeSetID
tree, however, considering that it's been over a month with no
response, and this patch looks trivially correct, I can pick this up
via the LSM tree if we don't see anything from Micah this week.

--=20
paul-moore.com
