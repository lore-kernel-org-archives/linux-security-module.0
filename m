Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 830DAEE49A3
	for <linux-security-module@archiver.kernel.org>; Wed, 23 Aug 2023 14:49:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236671AbjHWOtD (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 23 Aug 2023 10:49:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234019AbjHWOtB (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 23 Aug 2023 10:49:01 -0400
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com [IPv6:2607:f8b0:4864:20::1130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBEE7E69
        for <linux-security-module@vger.kernel.org>; Wed, 23 Aug 2023 07:48:59 -0700 (PDT)
Received: by mail-yw1-x1130.google.com with SMTP id 00721157ae682-579de633419so63779167b3.3
        for <linux-security-module@vger.kernel.org>; Wed, 23 Aug 2023 07:48:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1692802139; x=1693406939;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V/+ivp6vJDmXpgPPA/3jYksCM8MKkjsRczn9dsLl71s=;
        b=eNtSHbOfJY2Z2fsX0JPHYlkuIaI71AtZcSzWqN4v8sR2ZxlimDvMhs0uVnfgrexPvV
         9OKY1tZSridOBeSRnSalWEDPDbbBP81D6pqY79Hrw240cg3FrSeADvPARhQcNow6zAjP
         R5l/+cANwQqkfwIRuGG/Eh8CSuRNTMA4MyBNcbc+/uFb1HDAUyrtCBWx2ir8zUp2gIzS
         3RctIBXxMMD/ZKO38oyy2Wu2HJ30H8AgrSq7UtvX7Xh9w7+jugdDr6DWbldtaqvIVfV1
         Gfk7JP3tF1o3TvjpK2ZYksUIGpDVBujANdxTica1fi7VQykFlUzd/MsXOS4GXZg4TdLw
         gQmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692802139; x=1693406939;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V/+ivp6vJDmXpgPPA/3jYksCM8MKkjsRczn9dsLl71s=;
        b=FkJl9lrgbbpTEIb9LX8Rw4O/BO3g/Kj8/wUA52CGCj3TvEQeQaXgAnN+MInd1Qpi/8
         3Wz+iR6sngvmOaUCjNKN/KZeZ/XzfVZ9159eOTWTgi/RvUMQYgkWzkUxHfVfeRjH/h5J
         Edrmuu+g0C42aJCTrfW6gu9IzgiPU7iWQ5uZ4UJ/nCXr0BYSqDv+c5sD0fkGJEoS9eWb
         TjyHlmtcIXSmI1OzxBMz3LMg4sLL92y3Q23F9bXj95NoXmK7564YAkXNkiiAaqNz3gw2
         xdk1o44AXi+CO5dJqUsw5Bn1enSlCIHgrd4U3BARCJi319hMffGENG6f7mt976XbECJE
         CiDA==
X-Gm-Message-State: AOJu0YzqecEPc/KQMgecx03w/xVWRwrX8PzZbDz5x+5w2ve5HwxKtiLU
        bdbbf4VBhiydHTzYFUE9DmyJsECWeqnViLvZQGInwvUK6F1BxVFVqg==
X-Google-Smtp-Source: AGHT+IGWYAxc/rT9LekKb3CWpl8QjTcpXVvzoIlbFjFdm8dSrgnVA6ibXst0kmh0MuHZkbHN4COAoj6YsSWBvRhbLWQ=
X-Received: by 2002:a81:8782:0:b0:589:a9fc:ffcd with SMTP id
 x124-20020a818782000000b00589a9fcffcdmr12701700ywf.20.1692802138972; Wed, 23
 Aug 2023 07:48:58 -0700 (PDT)
MIME-Version: 1.0
References: <36b65eb1-ccbf-8b81-468f-b8d88c4be5a3@I-love.SAKURA.ne.jp>
 <CAHC9VhTLQjjQ0QMfBDHYCz9LOAuO=rJWSDEUqPsFE+dowFbN=Q@mail.gmail.com>
 <b06dbdd8-d2f6-b190-5635-948c0a966103@I-love.SAKURA.ne.jp>
 <CAHC9VhSz=3utr_CigGvkMEb6_avJUQq1Ak2smB7neSd76mzjFw@mail.gmail.com>
 <6957af54-16a2-4c28-56ff-dafe95f4e276@I-love.SAKURA.ne.jp>
 <CAHC9VhTj-PQ0qPTiphPLXyJx3bWeqgVS_GPCWNgjqFqBgH6Njg@mail.gmail.com>
 <b0b60fdc-4484-2265-7fdf-8367bf218d18@I-love.SAKURA.ne.jp>
 <CAHC9VhRaUxN=oEyKCOrfrGzJeXDGxv2EKbZH3qwAB6AhKcSfog@mail.gmail.com> <68a0ef90-b452-2096-3729-b5c208878ff9@I-love.SAKURA.ne.jp>
In-Reply-To: <68a0ef90-b452-2096-3729-b5c208878ff9@I-love.SAKURA.ne.jp>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 23 Aug 2023 10:48:47 -0400
Message-ID: <CAHC9VhTPgnzdn1tmEmufcbseN_Q1CyzxTEzfvZW7OCBTeAadmA@mail.gmail.com>
Subject: Re: [PATCH] audit: add task history record
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     linux-audit@redhat.com, audit@vger.kernel.org,
        Steve Grubb <sgrubb@redhat.com>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Wed, Aug 23, 2023 at 10:18=E2=80=AFAM Tetsuo Handa
<penguin-kernel@i-love.sakura.ne.jp> wrote:
> On 2023/08/22 1:35, Paul Moore wrote:
> >>   "auditctl -D" must not clear rules for tracing fork()/execve()/exit(=
)
> >>   system calls. This is impossible because this change will break user=
space
> >>   programs expecting that "auditctl -D" clears all rules.
> >
> > It's a good thing that 'audtictl -d ...' exists so that one can
> > selectively delete audit rules from the kernel.  If someone wants to
> > preserve specific audit rules, that is the way to do it; 'auditctl -D'
> > is a very coarse tool and not something that is likely very useful for
> > users with strict auditing requirements.
>
> In most systems, "auditctl -D" is the first command done via /etc/audit/a=
udit.rules file.
> You are asking all administrators who want to emulate this patch's functi=
onality using
> auditd to customize that line. We can't afford asking such administrators=
 to become
> specialist of strict auditing configurations, as well as we can't afford =
asking
> every administrator to become specialist of strict SELinux policy configu=
rations.

If an administrator/user needs to configure the audit subsystem to do
something, removing one line in a configuration file seems like a very
reasonable thing to do.  You can expect the default configuration of
every Linux distribution to fit every conceivable use case.

> Like Steve Grubb mentions, technically possible and practically affordabl=
e are
> different. The audit subsystem could handle the load, but the system admi=
nistrator
> can't handle the load.

If an administrator/user wants this type of information in their audit
logs they need to be prepared to handle that information.

> That's why I said
>
>   That is a "No LSM modules other than SELinux is needed because SELinux =
can do
>   everything" assertion.

What?  That doesn't make any sense following what you said above.
You're starting to cherry pick quotes and apply them out of context,
which only hurts your argument further.

> and your response
>
>   Except we are not talking SELinux or LSMs here, we are talking about
>   audit and the audit subsystem is very different from the LSM layer.
>   The LSM layer is designed to be pluggable with support for multiple
>   individual LSMs, whereas the audit subsystem is designed to support a
>   single audit implementation.
>
> is totally missing the point.

It makes perfect sense in the original context, see my comment above,
and perhaps go re-read that original email.

> For example, doing
>
>   auditctl -a exit,always -F arch=3Db64 -S exit,exit_group
>
> (in order to allow userspace daemon which tries to emulate this patch's
> functionality) will let auditd to generate process termination logs via e=
xit()
> system call. This command alone can generate too much stress on a busy sy=
stem
> (performance DoS and storage DoS).

However, in this very same email, a few paragraphs above you conceded
that "The audit subsystem could handle the load".

> And moreover, this command will not let
> auditd to generate process termination logs via kill() system call.
>
>   kill -9 $$
>
> Auditing kill system call may generate more stress than auditing exit sys=
tem call.
> Too much noisy logs for catching the exact one event we want to know.

We've already discussed this both from a kernel load perspective (it
should be able to handle the load, if not that is a separate problem
to address) as well as the human perspective (if you want auditing,
you need to be able to handle auditing).

Tetsuo, as should be apparent at this point, I'm finding your
arguments unconvincing at best, and confusing at worst.  If you or
someone else wants to take a different approach towards arguing for
this patch I'll entertain the discussion further, but please do not
reply back with the same approach; it simply isn't constructive at
this point.

--=20
paul-moore.com
