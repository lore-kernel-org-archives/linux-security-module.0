Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B9C2C4167B
	for <linux-security-module@archiver.kernel.org>; Mon, 13 Nov 2023 04:06:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233097AbjKMEGV (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Sun, 12 Nov 2023 23:06:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233089AbjKMEGU (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Sun, 12 Nov 2023 23:06:20 -0500
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58A66111
        for <linux-security-module@vger.kernel.org>; Sun, 12 Nov 2023 20:06:17 -0800 (PST)
Received: by mail-yb1-xb36.google.com with SMTP id 3f1490d57ef6-dae0ab8ac3eso3920922276.0
        for <linux-security-module@vger.kernel.org>; Sun, 12 Nov 2023 20:06:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1699848376; x=1700453176; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DdulfEzSfHGU40Qe7T9MI/Dcb3TiqFwbhF9mJITGshA=;
        b=Rs9HkzrE1T4yo2QGbYc/4pXVHXDWmZDRA81eYugBeS/+46GBU6A1etnOI0XFICVgJj
         cQVPLcbntuWQjCdDUMm020jQbS54y4kfvM4uAFrIUijL13fL0xGinBYIPQ/N/yaVwZgS
         jkzs6k5tZm84mXjjhjKwg0bJHXSFSBDV++ICurpIrdfMvtWcBWSY7X+o7Xvp3bahMLie
         lJAkqqh9idYkZNBUMGxMpxGraKiGUv1KHBW45lvvCfEfpwkgje+fffQHm+2COPxePc19
         e0Fsz5vpjfLFXdoRQuyAcnuPqgmTclt0p0yHGdZ2z4XA7fhgj6iNa3mbgcpVWZ2wjeo2
         d8MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699848376; x=1700453176;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DdulfEzSfHGU40Qe7T9MI/Dcb3TiqFwbhF9mJITGshA=;
        b=aatVaq5PRd/m+afQkSVTqxA2uEZVs5/CHfjrV5n1cWwACfUm/jhn3TcBR9rKjH6Y+H
         cIzfxRj+59qsQoxKJxJN/glO9KkTvj1R01Ev2dgohaacpOLL0XWqC8HGrLYpC1V9A3QJ
         LSsBqQVwfcwvVFQ/Yz7MN2p2y5Y7RyVBQn0HfK9erJJGHZHLKO7/qH92WKfSiOVbamGN
         K+KrQgPI1jSdljpQgc516LL/9853Rz71jOFR9So9krL1Dsf9JymRbqCKtX7lHZQA5raA
         75wwNqy04MTLWNLVdRt5YhY9vrZyBupDz8iUmd8EH9U58y2DfihPp3qsRYH8yvv0iQeI
         QvTg==
X-Gm-Message-State: AOJu0YwFGG8uZmvQUTPFo9d/8L2vnZqWePFCMEhwTXwhbMt9PR8hVA12
        gUtb0Db9kZGaHy7rbWlnw537TN6Ue1t/pkAECq3K
X-Google-Smtp-Source: AGHT+IEI/peI91Cg3UawMcuS9Yk9mFblaeeU97N3bZNmx6UjEdef/ZKk/ovoWf1eG3YjVOz6NHCes6ELqTMs8g5M1d8=
X-Received: by 2002:a25:dd8:0:b0:d9c:a485:332b with SMTP id
 207-20020a250dd8000000b00d9ca485332bmr4377065ybn.4.1699848376543; Sun, 12 Nov
 2023 20:06:16 -0800 (PST)
MIME-Version: 1.0
References: <20231026090259.362945-1-roberto.sassu@huaweicloud.com>
 <dd0f6611c7b46f3cecee2b84681c45b1.paul@paul-moore.com> <447298d65b497fb1a7f8d47c4f1a3137eba24511.camel@huaweicloud.com>
 <CAHC9VhSMVpEvLwWvBCgz0EMEb=DG_AZ7fenVUk5vPM=v5c6kYQ@mail.gmail.com> <CAHC9VhQW1mi5Z72cia7sqC7jERcCxO93xZJnvER=e7U6RqNFxQ@mail.gmail.com>
In-Reply-To: <CAHC9VhQW1mi5Z72cia7sqC7jERcCxO93xZJnvER=e7U6RqNFxQ@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Sun, 12 Nov 2023 23:06:05 -0500
Message-ID: <CAHC9VhSwPb71C1Z4DULv_8VyXO-wdjuvf2QqcbUCPvJgdg+H4g@mail.gmail.com>
Subject: Re: [PATCH] security: Don't yet account for IMA in LSM_CONFIG_COUNT calculation
To:     Roberto Sassu <roberto.sassu@huaweicloud.com>
Cc:     jmorris@namei.org, serge@hallyn.com,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, zohar@linux.ibm.com,
        linux-integrity@vger.kernel.org,
        Roberto Sassu <roberto.sassu@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Thu, Oct 26, 2023 at 12:36=E2=80=AFPM Paul Moore <paul@paul-moore.com> w=
rote:
> On Thu, Oct 26, 2023 at 11:59=E2=80=AFAM Paul Moore <paul@paul-moore.com>=
 wrote:
> > On Thu, Oct 26, 2023 at 11:12=E2=80=AFAM Roberto Sassu
> > <roberto.sassu@huaweicloud.com> wrote:
> > > On Thu, 2023-10-26 at 10:48 -0400, Paul Moore wrote:
> > > > On Oct 26, 2023 Roberto Sassu <roberto.sassu@huaweicloud.com> wrote=
:
> > > > >
> > > > > Since IMA is not yet an LSM, don't account for it in the LSM_CONF=
IG_COUNT
> > > > > calculation, used to limit how many LSMs can invoke security_add_=
hooks().
> > > > >
> > > > > Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> > > > > ---
> > > > >  security/security.c | 1 -
> > > > >  1 file changed, 1 deletion(-)
> > > >
> > > > Merged into lsm/dev-staging, thanks!
> > >
> > > Welcome!
> > >
> > > Could you please also rebase lsm/dev-staging, to move ab3888c7198d
> > > ("LSM: wireup Linux Security Module syscalls") after f7875966dc0c
> > > ("tools headers UAPI: Sync files changed by new fchmodat2 and
> > > map_shadow_stack syscalls with the kernel sources")?
> >
> > Let me look into that, as long as it doesn't blow up the stuff in
> > lsm/dev (I don't think it would), I'll go ahead and rebase to v6.6-rc4
> > which should resolve the syscall numbering conflict.
> >
> > FWIW, I also hit the same problem with my kernel-secnext builds, if
> > you're using those RPMs you'll find it's already resolved there.
>
> That wasn't very messy so I've rebased lsm/dev-staging to v6.6-rc4 and
> regenerated lsm/next.  If you notice any problems please let me know.

Now merged into lsm/dev, thanks Roberto!

--=20
paul-moore.com
