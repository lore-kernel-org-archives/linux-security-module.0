Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B408C77B78
	for <linux-security-module@archiver.kernel.org>; Wed, 26 Apr 2023 18:18:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239356AbjDZSS2 (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 26 Apr 2023 14:18:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234643AbjDZSS1 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 26 Apr 2023 14:18:27 -0400
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38A3A83D4
        for <linux-security-module@vger.kernel.org>; Wed, 26 Apr 2023 11:18:26 -0700 (PDT)
Received: by mail-yb1-xb31.google.com with SMTP id 3f1490d57ef6-b9246a5f3feso13273149276.1
        for <linux-security-module@vger.kernel.org>; Wed, 26 Apr 2023 11:18:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1682533105; x=1685125105;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k+1qxOGHVHkRrPD98Sn/YZv0hR5wBqMBpBQkLKg2EAw=;
        b=C+4TVFBhuVp0jm6l04YVUZka7mb34JEyyTEUWJf1osTMczd7i5hEWV2TzsBAb8yxgB
         DmNlslPBa2Zlut/dDFFq68D7Y4OeY3/9Jg/B4i8YIVFdX+5jA9XhDw2X6l4zw3YSMpD+
         9Nh63tBj7KNbpDjsexBc14p6TsxkQ5nT80msUUC4B4VisaQVMWCBcOsVNuHDiOayPlwS
         K/47nuadYZ/L9NH9c7djhcgHdEfbKMc5IocnJwXtNHuevT/h+u2l+deJlfeJ9zNkRepL
         nC5vPVGG7g1zjLqhidyZOLOwi74z9ZZZPR5miTtggH0ZkRB6p9qY6Amsi9oIalZEsU+V
         iw2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682533105; x=1685125105;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k+1qxOGHVHkRrPD98Sn/YZv0hR5wBqMBpBQkLKg2EAw=;
        b=XKb0zq4U8AH0tbA6KkkIih67ekfSuF6/8aAxQr/kJaDEy9wtyTENhIw+wKGxNdlTjn
         8DIoY3oIxBrCfM0ppKE1/PHNNoO+2nlZNJ9ckBSFyVcvDsfKTPPr0iI6eRzhRPjSH/XE
         MdoDmTa+M3XjaKDbps5fsd/nlOa5WSeNLG8FL7g0Pb9rx1rWbJaDOKL4ymf07fdpvdB9
         2jZrr6X+FNoVVYsfdoOEmD0uSyomw6UDbCCczPIspkDAflFYoHz/m+ycvXzJcffRdqMJ
         pgt0RDOY4Xn2/dYAJAstv9lsDCSmKJA3nCa0H0d770E4ywCncE52gjGfJ29B3UIEZ71Q
         ncHg==
X-Gm-Message-State: AC+VfDyEsk/XTbtWOHtTuj4Ep4kNsMG6VPoqz5idoqgh1H23rHtJytcB
        ScGc0OET8lBuwU6KDBSQ4QkqYXYc7Zn1rT53GeeK
X-Google-Smtp-Source: ACHHUZ7PuRiZvR/La6IIPvSLwxPt5z5qVEWtyW0Uk9rxxxvkFWga52jGOFkX3y24DJcOqnynOEMD4YGtuRqnHrzbBVE=
X-Received: by 2002:a05:6902:1029:b0:b99:f3ab:8a43 with SMTP id
 x9-20020a056902102900b00b99f3ab8a43mr6853968ybt.38.1682533105363; Wed, 26 Apr
 2023 11:18:25 -0700 (PDT)
MIME-Version: 1.0
References: <CAHC9VhQmV7=+eP0Rh6f+grz6=wigoHKuX5zZuMYVazsV8HVaVw@mail.gmail.com>
 <CAHk-=wji9GerfEOQ=9O6OOULFmpHneLPdvYtv+HM2ZK+tB3FDw@mail.gmail.com>
In-Reply-To: <CAHk-=wji9GerfEOQ=9O6OOULFmpHneLPdvYtv+HM2ZK+tB3FDw@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 26 Apr 2023 14:18:14 -0400
Message-ID: <CAHC9VhSCO2-o=AMpxSJPKe0MVvHdyLBPiKcfvM_AvW156XBx8A@mail.gmail.com>
Subject: Re: [GIT PULL] LSM patches for v6.4
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Mon, Apr 24, 2023 at 2:28=E2=80=AFPM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> On Thu, Apr 20, 2023 at 4:53=E2=80=AFPM Paul Moore <paul@paul-moore.com> =
wrote:
> >
> > Due to some personal logistics challenges over the next few days I'm
> > sending the LSM pull request for Linux v6.4 a bit early.  Here is a
> > quick summary of the changes:
>
> Well, you only had the summary, not where to pull from or what the
> resulting diffstat and shortlog would be.
>
> Normally I'd ask for a proper new pull request, but  since you
> explicitly mention the logistics challenges, I looked around.
>
> And it was obvious enough what the thing you wanted me to pull was:
> you always use the same naming format for the tags etc, and the end
> result matches what you described in the summary.
>
> So I've pulled your 'lsm-pr-20230420' tag, but in general I really do
> want to see that mentioned explicitly along with the diffstat etc
> noise from 'git request-pull'.

Ooof, my apologies, I suspect I was a bit distracted (and a little
concerned about the size of the diffstat) when I sent that pull
request last week and I simply forgot to do the final cut-n-paste of
the pull request info into the email.

Regardless, thanks for poking around and finding the right tag to pull.

--=20
paul-moore.com
