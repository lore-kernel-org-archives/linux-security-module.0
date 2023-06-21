Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CEA8EB64D7
	for <linux-security-module@archiver.kernel.org>; Wed, 21 Jun 2023 00:30:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229556AbjFUAaQ (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 20 Jun 2023 20:30:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbjFUAaO (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 20 Jun 2023 20:30:14 -0400
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com [IPv6:2607:f8b0:4864:20::1135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B0A9173B
        for <linux-security-module@vger.kernel.org>; Tue, 20 Jun 2023 17:30:13 -0700 (PDT)
Received: by mail-yw1-x1135.google.com with SMTP id 00721157ae682-570808d8ddeso51387387b3.0
        for <linux-security-module@vger.kernel.org>; Tue, 20 Jun 2023 17:30:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1687307412; x=1689899412;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wwNTCKmMgvc2nJrRbHQLKCJs8IWViNUrZIuXoDpTgTc=;
        b=KTmlRfuzVHIbYKZsvQLka9gLQySta0BOsnWVzXbzSnYvXPJU0KIm66yUCFPGxaZw25
         DyXgWr9lVvf7IGSkSclDGTE5/uJoOODbYkzbzOJ/axO7oRKNLDv9dS8oqiSwOiGqrVsr
         XfzrrTlBEKdZeBl+J7CvitUn/fmkBtkSHRFYMtXiSKNwdyYiC0So4dM+1qDyLfBDfZJH
         ElPVu0BH1ZudgbRubnO4XBx0TQLp6MQ2F+YofaVxyxrgcRMvFO7a38/xPVMC9SGAgDSm
         485l4OVgxNlSf7u/pz9cTeG0hiL9f7EfvSWqGht0XOfBH339WJkhjKQfSFNw/V1HwCki
         R3Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687307412; x=1689899412;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wwNTCKmMgvc2nJrRbHQLKCJs8IWViNUrZIuXoDpTgTc=;
        b=QWZiJ9EvF+ZseImgbx2C6ZHMmwYPX/xYQ+RoB69cFNt2mTLTfx6IwEEgQ1noB3tkbk
         g4GFuzDIy9ynVcMIeFxY5y93DQ+c6dSCG8+YEFP4X9roR7V7rXMVAXMNHdG22oi8M13w
         aeUIkRhqWcFuytYLgljp4+ERrlBvqb51UdkMlyrNKKH2QgtdhVq99ZCeeJ017lr5Pi2h
         z0VJ57uxeXbmUBPuSMc+LFCJrhOeSfXo0a8+3SVsfBECI5UVKYe/UH8BYlxP4zMOYWvw
         K/Yft5iEi+rZAs9z94A63U8ZUE6/X35HAqYWDU4SVM/3smIoI9lnmfwDav/zhSwD9ZZw
         Pnfg==
X-Gm-Message-State: AC+VfDwqkaRg50noEDiIUv2NzrTWd8iCedRA0Ji3XgYuJgs36oBVAvzB
        sxzSCO/uc4Ezylq1uH36xviapKoMjkANjoeRWYXh3U7i7zfjQUA=
X-Google-Smtp-Source: ACHHUZ432ixhOBQxfLZ9QEclgrfhsFFPd+GVpkZShXuAH9yfI2Lp0ijrpUA6LkS1MngsJcOXDUHiBEefyZSwfhlzsmg=
X-Received: by 2002:a81:c24b:0:b0:567:7db6:3d48 with SMTP id
 t11-20020a81c24b000000b005677db63d48mr15278626ywg.12.1687307412295; Tue, 20
 Jun 2023 17:30:12 -0700 (PDT)
MIME-Version: 1.0
References: <20230503064344.45825-1-aleksandr.mikhalitsyn@canonical.com>
 <CAHC9VhTx+6f8riuGOG40HZoaYx3F8Kf3Hm7Eb5k3-An91eMWgg@mail.gmail.com>
 <CAEivzxcVQoA9rN06BtHJzyHCaN60RG1-cyGEEw-P+dp-tCB=QA@mail.gmail.com>
 <CAHC9VhQnOszTFaFVBZACQCDxsuD6JrxDffmmJ-wBudK2MJ2pUA@mail.gmail.com> <CAHC9VhSF+j=qFH4M9bt-Q8HUOwk7qLOEkCSve8onUMgADJ7+3A@mail.gmail.com>
In-Reply-To: <CAHC9VhSF+j=qFH4M9bt-Q8HUOwk7qLOEkCSve8onUMgADJ7+3A@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 20 Jun 2023 20:30:01 -0400
Message-ID: <CAHC9VhSGhV6SoOeV2h4ehrkUCK9Sds1wx=CGdRSouvnLn0Z3Kg@mail.gmail.com>
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

On Thu, Jun 8, 2023 at 2:34=E2=80=AFPM Paul Moore <paul@paul-moore.com> wro=
te:
> On Tue, Jun 6, 2023 at 5:13=E2=80=AFPM Paul Moore <paul@paul-moore.com> w=
rote:
> > On Tue, Jun 6, 2023 at 2:50=E2=80=AFPM Aleksandr Mikhalitsyn
> > <aleksandr.mikhalitsyn@canonical.com> wrote:
> > > On Thu, May 18, 2023 at 8:59=E2=80=AFPM Paul Moore <paul@paul-moore.c=
om> wrote:
> > > > On Wed, May 3, 2023 at 2:44=E2=80=AFAM Alexander Mikhalitsyn
> > > > <aleksandr.mikhalitsyn@canonical.com> wrote:
> > > > >
> > > > > pr_warn message clearly says that GID should be printed,
> > > > > but we have UID there. Let's fix that.
> > > > >
> > > > > Found accidentaly during the work on isolated user namespaces.
> > > > >
> > > > > Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canon=
ical.com>
> > > > > ---
> > > > > v2: __kuid_val -> __kgid_val
> > > > > ---
> > > > >  security/safesetid/lsm.c | 2 +-
> > > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > >
> > > > I'm assuming you're going to pick this up Micah?
> > > >
> > > > Reviewed-by: Paul Moore <paul@paul-moore.com>
> > >
> > > Dear Paul!
> > >
> > > Thanks for your review!
> > >
> > > Gentle ping to Micah Morton :-)
> >
> > Micah?
> >
> > The right thing would be for Micah to merge this via the SafeSetID
> > tree, however, considering that it's been over a month with no
> > response, and this patch looks trivially correct, I can pick this up
> > via the LSM tree if we don't see anything from Micah this week.
>
> Searching through all of the archives on lore I don't see any email
> from Micah past August of 2022.  I'll still stick to the plan of
> merging this via the LSM tree next week if we don't see any response
> from Micah, but beyond this patch we may need to consider the
> possibility that Micah has moved on from SafeSetID.
>
>  * https://lore.kernel.org/all/?q=3Df%3Amortonm%40chromium.org

This fell through the cracks in my inbox last week, but I just went
ahead and merged this into lsm/next.

After the upcoming merge window closes we'll have to revisit
SafeSetID's status as "supported", we might need to demote it to
"maintained" or "odd fixes".

--=20
paul-moore.com
