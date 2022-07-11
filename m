Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F69AC43334
	for <linux-security-module@archiver.kernel.org>; Mon, 11 Jul 2022 17:49:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229660AbiGKRtv (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 11 Jul 2022 13:49:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231688AbiGKRth (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 11 Jul 2022 13:49:37 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A332C3C8FC
        for <linux-security-module@vger.kernel.org>; Mon, 11 Jul 2022 10:49:36 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id a5so7982835wrx.12
        for <linux-security-module@vger.kernel.org>; Mon, 11 Jul 2022 10:49:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jVwe70gQ9TPJEX1Aw/rDiqS5drjQxkBhXSDtoV6NuGM=;
        b=1lKNy+35G2zUa9ejCGsfSCSYXcK7VLuPGNs5+xLooB7Fh1Pa4qNalBhY6Ddz4emzaY
         0PlbVoUENTfinhqyT626ntny0l7c188kDI1ZMO+3py0V0PYUrTeqllU/sTzI2DRx1FLE
         5skhL74s1eHTlE4LDFzl8VYf505mU1sOyTczmkTgNq5aq8EdhZXEwkiO3pl58bjNRqne
         8CMxNOhaH9E46gmAfC0inYMPLHY4nOeEm/5ISvO6Esd8bcX0A7yYz57is7OXF/L/QObn
         E2DNdTl6QTyA7lA5VTPxMaiSoEx/tEltTYF6eUXjvUSH0y8KmxaKzHm8etm5xVfe4RUW
         eOWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jVwe70gQ9TPJEX1Aw/rDiqS5drjQxkBhXSDtoV6NuGM=;
        b=b9tEJtaCIdrjZ6j+8JHFz/sF/wdz9Ojki2FLb7S5MRoWko6DDEN8bqKDtNalrrIjSq
         xblooTHlhAKsr674UPFXFqavabXxX/kQV2FzzAFEcAjl+0FeZIfHBEKDp9laIXGKOnkw
         3k3oQqVAhXAPyULuQbbmTdxmDUIf1EssF1BlrtM1V/OeSMC4r1QJ8ARH9eZY5gcwtMQn
         VFv+5LuwHIEiTpy+Cx2WwN+fwjm9/VArDxBhho4joezJMZViCAZX0+SGPKAVjEY1i2Tl
         BvbbxDro2pfcSSP6TSupwokkgdRM/KN1kOF5SiERxNgt/W5cN5lrP0IccC5ZJogZE1V1
         qR8g==
X-Gm-Message-State: AJIora8Mge62782z8crzRAY2t4QgBMYsRX1+p7+teVL7ibZ1SFpkNcbu
        2miR538Ux1owUcdXlNYBqUOfuubv1W9b7/tslVZSNKCl/8rm
X-Google-Smtp-Source: AGRyM1s+W7BO0VaBBmSMTFPNeJT+lvBft2GqeKPJm99BEJhxKGCjCf4+Olian/0+D1JcE7PXHAQ7ggq+/k8CRuVZFIY=
X-Received: by 2002:adf:f345:0:b0:21d:6a26:6d8f with SMTP id
 e5-20020adff345000000b0021d6a266d8fmr18585100wrp.538.1657561775058; Mon, 11
 Jul 2022 10:49:35 -0700 (PDT)
MIME-Version: 1.0
References: <165731248606.335227.15503387932450699761.stgit@olly>
 <4c33604f-25ee-c1e7-4a4c-afe95b3dba15@namei.org> <CAHC9VhSowtGrY=Crgk85Yf6G+o-4SsWgDMJc_T_Jpw7yPx8zkg@mail.gmail.com>
 <2afda16b-2661-6e93-cb6c-eda673e0c3c1@namei.org>
In-Reply-To: <2afda16b-2661-6e93-cb6c-eda673e0c3c1@namei.org>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 11 Jul 2022 13:49:23 -0400
Message-ID: <CAHC9VhS_h6Kq-Y1pwer3422-eNfT-jyWP3p62oePnw9WsX-yKA@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: update the LSM maintainer info
To:     James Morris <jmorris@namei.org>
Cc:     linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Mon, Jul 11, 2022 at 12:35 PM James Morris <jmorris@namei.org> wrote:
> On Sun, 10 Jul 2022, Paul Moore wrote:
> > On Fri, Jul 8, 2022 at 5:19 PM James Morris <jmorris@namei.org> wrote:
> > > On Fri, 8 Jul 2022, Paul Moore wrote:
> > > > After many years of shepherding the LSM layer, and Linux kernel
> > > > access control in general, James has decided to take a small step
> > > > away from his technical role and has asked me to assume the
> > > > day-to-day maintenance tasks for the LSM.  This patch makes the
> > > > necessary updates to the MAINTAINERS file.
> > > >
> > > > Thanks for all you patience and stewardship over the years James,
> > > > I promise to do my best not to screw it all up :)
> > > >
> > > > Cc: linux-security-module@vger.kernel.org
> > > > Signed-off-by: Paul Moore <paul@paul-moore.com>
> > >
> > > Acked-by: James Morris <jamorris@linux.microsoft.com>
> >
> > James, are you planning to send this up to Linus during the next merge
> > window or should I?
>
> Feel free to send it directly.

Will do.  Merged into
git://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/lsm.git (next
branch) with James', Serge's, and Casey's ACKs.

Thanks all.

-- 
paul-moore.com
