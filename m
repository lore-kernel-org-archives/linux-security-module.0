Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C0A1C47089
	for <linux-security-module@archiver.kernel.org>; Thu, 27 May 2021 14:19:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 222FA613D1
	for <linux-security-module@archiver.kernel.org>; Thu, 27 May 2021 14:19:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236361AbhE0OUj (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 27 May 2021 10:20:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235342AbhE0OUi (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 27 May 2021 10:20:38 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0802AC061760
        for <linux-security-module@vger.kernel.org>; Thu, 27 May 2021 07:19:05 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id jt22so340000ejb.7
        for <linux-security-module@vger.kernel.org>; Thu, 27 May 2021 07:19:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0KMicP7dPruhWbetN8SS8Qn8WRBhDpCdjlUFYTYIPQY=;
        b=oL8+TZNnSedYZxnjK4DI9LSvARM8ndmpxlxh6MbE8xc+bzPwC15R8Oe7BjBHBNDZJU
         TNJP8Tt8TyG1DmWC33rk+d5R2TN/mvP/gK0UeOcVkgdELmghktfHLYP8jQjpCHsvmX2b
         DhFL94mzDwpgYjyGSpg4J/rAkkNxNjR97srQQgHxVbtNcfz5kQ/cblTw8NQzxSMLaOrY
         G1r+90PQY64rR4qLSENwuRJU1aPtfVkjFCNY2D6JqIUDBKPVcJCgfP8G2hKezSwWEDi4
         apxq9vHVNpXDgfq28VM6AgmXZQSXQY5PyR5QvKTo1urmbFatACON7BQ19GUEX0119z5i
         Scww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0KMicP7dPruhWbetN8SS8Qn8WRBhDpCdjlUFYTYIPQY=;
        b=uR4RSlAwsXZ93T+X9d4XP/jRHsp6ssY01AjHo3Iq8Q3j40IJR6ct30kOcqlv3/wG6G
         Bpdr1Zi1sSB3qnHznBAoacRtx8LUmiaOE/rUsO0afxZHeUYZnF6dDoT6sSirEkg738ND
         RBb5QYk0L92FiC1cK+i/ry5MTJpvpbrhEQsR2vCnVfBdI52IiwBWMaKxn2KfUI0lz4en
         iTvE9tB3slhgyJPa07QPgHaJFlu46E1WWWJl9tEcuZRZNXuAPPc50kItwjD0nmtTiPOk
         /rYPeki9ry6keAENk7BEBHDb0oz94AFH0nBeRmSrXpjuv0vaCWtU1SOg0BWtUiDyeOWC
         Xs2g==
X-Gm-Message-State: AOAM530+eqqJT1jnjfABM/uovASm65UJOwvablOSk4+eND6Vm89T/IYG
        7aVCktUEQhOKLi/oEP+fkUUYqfiT5Zo9S0vNzAdY
X-Google-Smtp-Source: ABdhPJxNY45Rvc2vrfaQ2IL4Eku6yyHzxMbb+NaSgzTa9DTK2YgRMf8cywVg6CWuAUNioudc7Sfjin2qWfEjUKkshxk=
X-Received: by 2002:a17:906:f283:: with SMTP id gu3mr4078724ejb.91.1622125143443;
 Thu, 27 May 2021 07:19:03 -0700 (PDT)
MIME-Version: 1.0
References: <20210517092006.803332-1-omosnace@redhat.com> <87o8d9k4ln.fsf@mpe.ellerman.id.au>
 <CAFqZXNtUvrGxT6UMy81WfMsfZsydGN5k-VGFBq8yjDWN5ARAWw@mail.gmail.com> <3ad4fb7f-99f3-fa71-fdb2-59db751c7e2b@namei.org>
In-Reply-To: <3ad4fb7f-99f3-fa71-fdb2-59db751c7e2b@namei.org>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 27 May 2021 10:18:52 -0400
Message-ID: <CAHC9VhSSZzDeM1bcOjVBN6u5KPAvMysg3sLcSniq+cLr65WFqg@mail.gmail.com>
Subject: Re: [PATCH v2] lockdown,selinux: avoid bogus SELinux lockdown
 permission checks
To:     James Morris <jmorris@namei.org>
Cc:     Ondrej Mosnacek <omosnace@redhat.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Linux Security Module list 
        <linux-security-module@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        SElinux list <selinux@vger.kernel.org>,
        linuxppc-dev@lists.ozlabs.org,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>, network dev <netdev@vger.kernel.org>,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>,
        Casey Schaufler <casey@schaufler-ca.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Thu, May 27, 2021 at 12:33 AM James Morris <jmorris@namei.org> wrote:
> On Wed, 26 May 2021, Ondrej Mosnacek wrote:
>
> > Thanks, Michael!
> >
> > James/Paul, is there anything blocking this patch from being merged?
> > Especially the BPF case is causing real trouble for people and the
> > only workaround is to broadly allow lockdown::confidentiality in the
> > policy.
>
> It would be good to see more signoffs/reviews, especially from Paul, but
> he is busy with the io_uring stuff.

Yes, it's been a busy week with various things going on around here.
I looked at the v1 posting but haven't had a chance yet to look at v2;
I promise to get to it today, but it might not happen until later
tonight.

> Let's see if anyone else can look at this in the next couple of days.

-- 
paul moore
www.paul-moore.com
