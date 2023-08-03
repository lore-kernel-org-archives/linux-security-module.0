Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A748C001DB
	for <linux-security-module@archiver.kernel.org>; Thu,  3 Aug 2023 21:24:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230163AbjHCVYd (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 3 Aug 2023 17:24:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229538AbjHCVYc (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 3 Aug 2023 17:24:32 -0400
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com [IPv6:2607:f8b0:4864:20::1132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C46BDE43
        for <linux-security-module@vger.kernel.org>; Thu,  3 Aug 2023 14:24:26 -0700 (PDT)
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-583f036d50bso16847177b3.3
        for <linux-security-module@vger.kernel.org>; Thu, 03 Aug 2023 14:24:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1691097866; x=1691702666;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5wp27Mgdl86M2hQPS3AR1RgGO+ir4xBbXiB3cLnZ3v4=;
        b=Y4NTNv/j4pFhu4LdF/P4/bLQgJyo3Ikmp298U7LAN470CNaM+s9LhvpeTY4ddbGEYF
         uXE+oM0pYdsYxXm38i4OKB04q3lqeUI6RyUXec1hPGkZbF8C5eU1Z9VdvWDwz+eAIa6w
         EtWul6dEz74yZNPrXyUPOz4yDjEkk3x+IoLAC2KyeHqW0Kfn6KF2HmRwQj5AG0h7Rxzg
         q/Pjh9PiV/V3pdu4lY00cBIYuJg7uQI7l3KvgHN9ztJLgxUo4ui10wWpxrt4Wn5aBfYm
         w8QOAGl5GkhT/1o/meozXjKm7IaFxytDDxleTRq9Dnb1Zb3EBV9DWQUVX+i6DC0w+LVr
         lliw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691097866; x=1691702666;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5wp27Mgdl86M2hQPS3AR1RgGO+ir4xBbXiB3cLnZ3v4=;
        b=DxgyypXYldzJo0acYH4644WVcWUoXAp2/dNw7Zci0yEvIKLrmiin2KEMyZI98/CM1A
         45JVd8zblUSCLpZi35nNT6+uGNnBwofmB5QwnlODjvJTPI3s0SknlS/c46q/qRQsp8+Z
         URz4MNAAe93g4aPP8B2b5hzgtmF+4iP29Hy5XiG1P6J3jKTNsZAwaGCWQiRR5+BdG5iO
         3/DrZijyla6B1q36cO4p0b7EXeyICvrqm9FR+plDPEM5WoC2unlsCadPW0JMnv+QCQEH
         NrtHuKgcVrJUgZ5ppBRAxuQvn8QibxLTYMkEX+C/6rTEyHG/UnWmeAG4jfrcfnO9ylfP
         fQUA==
X-Gm-Message-State: ABy/qLYt8A/RptS+LD/6QhjqV+J2o/wAvEy5f806dfuZAij/2R0/tqY0
        maj0RcUj6lKwsD2ZzQq/rD+9XYLllrSHhX70oNyo
X-Google-Smtp-Source: APBJJlFP455KbxY7hVVHbw/hRB40QSXKOD+AJ4rL7SG2R6ZlBgPJnroH8LC4xETTk9L2PmHowK3vTUEFlakKyHJkl9g=
X-Received: by 2002:a81:9151:0:b0:577:4387:197c with SMTP id
 i78-20020a819151000000b005774387197cmr21199072ywg.16.1691097866016; Thu, 03
 Aug 2023 14:24:26 -0700 (PDT)
MIME-Version: 1.0
References: <CAHC9VhRsxARUsFcJC-5zp9pX8LWbKQLE4vW+S6n-PMG5XJZtDA@mail.gmail.com>
 <4708afda-8867-735a-2f55-ca974e76cc9c@schaufler-ca.com> <CAHC9VhTepATGki_8_nyUcmCCvJ2hpLO4bWFhF-gJ3CQceEBMfA@mail.gmail.com>
 <CAHC9VhQ9EfH5sb85+uwyB726iDNR47k=sfr0zBCENz=-PerR9A@mail.gmail.com>
 <CAHC9VhQhf+ik5S_aJOVn59pax1Aa0vO5gJ4YoxrtGRKtoWh7sA@mail.gmail.com> <20230803.alohoMev7thu@digikod.net>
In-Reply-To: <20230803.alohoMev7thu@digikod.net>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 3 Aug 2023 17:24:15 -0400
Message-ID: <CAHC9VhQU-9gpTNMW-=R9x6_a5PKRkT=Qm3QQ1EDSmScrQv655w@mail.gmail.com>
Subject: Re: ANN: new LSM guidelines
To:     =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>
Cc:     linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Thu, Aug 3, 2023 at 5:44=E2=80=AFAM Micka=C3=ABl Sala=C3=BCn <mic@digiko=
d.net> wrote:
>
> On Wed, Aug 02, 2023 at 06:00:22PM -0400, Paul Moore wrote:
> > On Tue, Aug 1, 2023 at 6:47=E2=80=AFPM Paul Moore <paul@paul-moore.com>=
 wrote:
> > >
> > > I've updated the README.md doc based on the feedback, and copied the
> > > two new sections below for easier review.  If anyone has any
> > > additional feedback or concerns, please let me know.
> >
> > Another update based on feedback received (thanks everyone!).  Just as
> > before, I welcome any comments or feedback you are able to share.
> >
> > ## New LSM Hook Guidelines
> >
> > While LSM hooks are considered outside of the Linux Kernel's stable API
>
> s/Kernel/kernel/g

Done for the entire doc.

> > * New LSMs must be accompanied by a test suite to verify basic function=
ality
> > and help identify regressions.  Test coverage does not need to reach a =
specific
> > percentage, but core functionality and any user interfaces should be we=
ll
> > covered by the test suite.  Integration with existing automated Linux K=
ernel
> > testing services is encouraged.
>
> I'd suggest to require tests to be publicly available and easy (or not
> too difficult) to run for the sake of sanity of other kernel developers
> that might need to quickly fix (critical) bugs even without the help of
> the maintainer (who might be unavailable for various reasons).

Good point.  We mention a public repository for associated userspace
tools/patches, we should do the same for the tests.  While I also
agree that the tests should be easy to setup and run, I'm not sure I
want to put that as a requirement simply because it is so hard to
properly quantify.

> I guess
> you could argue that decent kernel code needs a reasonable bus factor
> protection, but making tests available and easy to use is a quality
> guarantee.

At one point I debated adding a requirement about having a "community"
behind new LSM submissions, but I worry that would introduce a
chicken/egg problem.  In theory, if a LSM is properly documented, has
meaningful tests, and is reasonably coded, any interested party could
pick it up if the original author/maintainer ceased maintaining the
code.

--=20
paul-moore.com
