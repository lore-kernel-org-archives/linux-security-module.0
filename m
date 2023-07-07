Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2501AEB64DA
	for <linux-security-module@archiver.kernel.org>; Fri,  7 Jul 2023 14:20:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230159AbjGGOUV (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 7 Jul 2023 10:20:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229695AbjGGOUU (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 7 Jul 2023 10:20:20 -0400
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com [IPv6:2607:f8b0:4864:20::1130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 083DF10B
        for <linux-security-module@vger.kernel.org>; Fri,  7 Jul 2023 07:20:19 -0700 (PDT)
Received: by mail-yw1-x1130.google.com with SMTP id 00721157ae682-579e212668fso28581657b3.1
        for <linux-security-module@vger.kernel.org>; Fri, 07 Jul 2023 07:20:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1688739618; x=1691331618;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GPkKVjmExliTZN7Renhs8xf2T2UTRJPTYJgznZNyApI=;
        b=XcVlXM8X3sO34EO2jtPLmNpCW8JSGltzYQyLv9SNi35+9poIGcvyYkgDUb7jmi9ajt
         mBSN4JkLgkNiJexZVa7kciHqwPrkBFT9ME5eAIg24fgk/tC3H3lFU4tMikM9EL6c7TEv
         ON7v2n6VwB8PxiJjwheEAAz7mjCayPxgaCONcJ+K/+sJsWugFxved6ynWJm1gpdkVhW6
         sqMvXzZc7yv8Np0/5vezAcb+zM0Lptu05b7z8sZzzWPnqbxh/6EZcPDBLd7QT0yNSWEu
         Tu4PS6TmwqTKHzBEMLvWf6MIK8CO2BUMeS2JlFNrxzv1C6m1gICrSPvH09e1DeXTT+KT
         ws3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688739618; x=1691331618;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GPkKVjmExliTZN7Renhs8xf2T2UTRJPTYJgznZNyApI=;
        b=Ep1AwukRmAgK0Vjsvv1F225Ot7wgUZfZpF1JcrTgcagtGAxm+FqW/BlxBaZFpZ2IVq
         k0g0r4PjpEsKHoXClMjk9KwgdQiPM/6ZoUIDlJhHX25pQOp6ykAKiNMVn9ZOn6fbf6iq
         qmLYJ3kllXNUVIGUS0BaZ6iyQ52TJ0kF5OYZcRtO8dDpOif9/0SxBXwvnniY5gG1Q6p6
         fa/Mkw0GK8H1zaYdm1CZMDcqAsDIBc1WZDUAKGxNqU97ytJq7LyqhY77CGY7hpIQSfe1
         nAOYu3LsQjsUsI/EL/vNXzh0b/fre5YEjPPKoSHSS55d9Ij5PLYe+NuZWr3PGS9uNZfH
         KzWw==
X-Gm-Message-State: ABy/qLa/QC2hBG9VvldoMSKw5LRxMtagYbFnZ7JjRkX3U2x1ZYCK9Twi
        hBL8A5WHi5XBF+MaejdJJQtEEtdtHAKRmzSh7ResEuqVkcjE5W0=
X-Google-Smtp-Source: APBJJlFcz8ujSoRsWJn+dvZpwaQpQFuBTXw2BBDw3VDzfTcThQU8ct3Rjpov7GdYs1MywHwmGEn4o6KxzIPUJv04mpg=
X-Received: by 2002:a0d:d5c2:0:b0:577:15ab:bb8 with SMTP id
 x185-20020a0dd5c2000000b0057715ab0bb8mr4059652ywd.20.1688739616724; Fri, 07
 Jul 2023 07:20:16 -0700 (PDT)
MIME-Version: 1.0
References: <32e59b69-79a2-f440-bf94-fdb8f8f5fa64@wewakecorp.com>
 <CAHC9VhRdCSJwB9hpyrCe+D00ddeRLisz=9GEWJz50ybr80tnsg@mail.gmail.com> <4ec9e7ae-e95e-a737-5131-0b57922e4fce@wewakecorp.com>
In-Reply-To: <4ec9e7ae-e95e-a737-5131-0b57922e4fce@wewakecorp.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Fri, 7 Jul 2023 10:20:05 -0400
Message-ID: <CAHC9VhQBbbSu6YBbnXOPMjpBxQxc1nmgA+icfN4x6s6FeQSeiw@mail.gmail.com>
Subject: Re: [LSM Stacking] SELinux policy inside container affects a process
 on Host
To:     Leesoo Ahn <lsahn@wewakecorp.com>
Cc:     Casey Schaufler <casey@schaufler-ca.com>,
        linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Fri, Jul 7, 2023 at 4:29=E2=80=AFAM Leesoo Ahn <lsahn@wewakecorp.com> wr=
ote:
> 2023-07-06 =EC=98=A4=ED=9B=84 10:43=EC=97=90 Paul Moore =EC=9D=B4(=EA=B0=
=80) =EC=93=B4 =EA=B8=80:
> > On Thu, Jul 6, 2023 at 1:20=E2=80=AFAM Leesoo Ahn <lsahn@wewakecorp.com=
> wrote:
> >  >
> >  > Hello! Here is another weird behavior of lsm stacking..
> >  >
> >  > test env
> >  > - Ubuntu 23.04 Ubuntu Kernel v6.2 w/ Stacking patch v38
> >  > - boot param: lsm=3Dapparmor,selinux
> >  > - AppArmor (Host) + SELinux (LXD Container Fedora 36)
> >  >
> >  > In the test environment mentioned above and applying selinux policy
> >  > enforcing by running "setenforce 1" within the container, executing =
the
> >  > following command on the host will result in "Permission denied" out=
put.
> >
> > SELinux operates independently of containers, or kernel namespacing in
> > general. When you load a SELinux policy it applies to all processes
> > on the system, regardless of where they are in relation to the process
> > which loaded the policy into the kernel.
> >
> > This behavior is independent of the LSM stacking work, you should be
> > able to see the same behavior even in cases where SELinux is the only
> > loaded LSM on the system.
>
> Thank you for the reply!
>
> So as far as I understand, the environment of LSM Stacking,
> AppArmor (Host) + SELinux (Container) couldn't provide features "using
> SELinux policy inside the container shouldn't affect to the host side"
> for now.
>
> If so, I wonder if you and Casey plan to design future features like
> that, because my co-workers and I are considering taking LSM stacking of
> AppArmor + SELinux in products that both policies must be working
> separately.

What you are looking for is a combination of LSM stacking and
individual LSM namespacing.  Sadly, I think the communications around
LSM stacking have not been very clear on this and I worry that many
people are going to be disappointed with LSM stacking for this very
reason.

While stacking of LSMs is largely done at the LSM layer, namespacing
LSMs such that they can be customized for individual containers
requires work to be done at the per-LSM level as each LSM is
different.  AppArmor already has a namespacing concept, but SELinux
does not.  Due to differences in the approach taken by the two LSMs,
namespacing is much more of a challenge for SELinux, largely due to
issues around filesystem labeling.  We have not given up on the idea,
but we have yet to arrive at a viable solution for namespacing
SELinux.

If you are interested in stacking SELinux and AppArmor, I believe the
only practical solution is to run SELinux on the host system (initial
namespace) and run AppArmor in the containers.  Even in a world where
SELinux is fully namespaced, it would likely still be necessary to run
some type of SELinux policy on the host (initial namespace) in order
to support SELinux policies in the containers.

--=20
paul-moore.com
