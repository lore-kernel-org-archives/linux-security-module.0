Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CD6EC27C40
	for <linux-security-module@archiver.kernel.org>; Thu, 24 Aug 2023 14:27:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241610AbjHXO0f (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 24 Aug 2023 10:26:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241683AbjHXO0W (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 24 Aug 2023 10:26:22 -0400
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com [IPv6:2607:f8b0:4864:20::112f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7D1D1BCE
        for <linux-security-module@vger.kernel.org>; Thu, 24 Aug 2023 07:26:17 -0700 (PDT)
Received: by mail-yw1-x112f.google.com with SMTP id 00721157ae682-5921a962adfso45686197b3.1
        for <linux-security-module@vger.kernel.org>; Thu, 24 Aug 2023 07:26:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1692887177; x=1693491977;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QGP6/LbeEHsJtc9AXv1aIkTp3x9dNPX7hclZu5wr4Y4=;
        b=YpxIekLxHKUSRQzXqL7LApmMuILMSNmT1t9SUS4kjPAXtRSGVcxy+ZIA0/7FuGIN0U
         3XcvJ1ZTVs5n6PbN+s+cyu1mae1k5CVelp/e/Slc0fHw5Pi3ox148aw44nr3wL6nU5/m
         ROm+7If277ZXw3hrIbSh2lM8j6cZWh0C8XFOJuVCdvXBgRe0hmntmX7vOSDX3Pd/rY23
         iFCslS57twiCMhfXc1DVdVw0GDEHVL9RV6RwbqcByZAY4BdtDAWCipCfT6nhPqxU+ZA2
         nx06/11Rpwedmv8QlJOuzP5Q18K1pAZFNWQucYxVAlUT1kTC+TW/4ApKokgwjgTUdzGE
         d+ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692887177; x=1693491977;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QGP6/LbeEHsJtc9AXv1aIkTp3x9dNPX7hclZu5wr4Y4=;
        b=iElT/lIUPgmnhYMcLwRFRZJddEjinAQt2zAA3wlHpI+NSJP4xRt+fT02cVOmV9QDqO
         znnPnWpWjKWBej7A15xfa0Jx/au045/rEXHr/K7Q0S3/RjaBQtiKC23rrYnJ4G/+Jhcu
         1yAeJACqCkIklyn6sjOlhbOG3p6Hs4CI3vmM8i3gHyvhlioAmvtv54EsyAPXw9+iPIpt
         MruxlJWIKYh1Gb06Xc3FumsVtJZmJyc1eaWhH4nSGlzC3zhoW0SWP68jb8GwfqsBkpx1
         ARAuChDFMhCVYIeA5bJon6YwHNKyZtiKBlNNa/7WFLt3FDUsss2mqZxFcMmvZUEISUSn
         V73w==
X-Gm-Message-State: AOJu0Yz5/tBbjuu/sddIio7Z4ClQejubC4ZCC7R7jtOU93+qoMfvhxFz
        tXuItT/qyeO5s5wEoXuS733DoMgCR8ICZ3ont8nR
X-Google-Smtp-Source: AGHT+IHl3NM8vm7cLOKE3+nd7wsJCWNCuL99CMcc0vTdr0+3ZFXdYX5pmvqo0mTr9XkYOGAXhXvyy81Cxy64434mr5Q=
X-Received: by 2002:a0d:c781:0:b0:58a:d281:a275 with SMTP id
 j123-20020a0dc781000000b0058ad281a275mr17321106ywd.21.1692887176882; Thu, 24
 Aug 2023 07:26:16 -0700 (PDT)
MIME-Version: 1.0
References: <36b65eb1-ccbf-8b81-468f-b8d88c4be5a3@I-love.SAKURA.ne.jp>
 <CAHC9VhTLQjjQ0QMfBDHYCz9LOAuO=rJWSDEUqPsFE+dowFbN=Q@mail.gmail.com>
 <b06dbdd8-d2f6-b190-5635-948c0a966103@I-love.SAKURA.ne.jp>
 <CAHC9VhSz=3utr_CigGvkMEb6_avJUQq1Ak2smB7neSd76mzjFw@mail.gmail.com>
 <6957af54-16a2-4c28-56ff-dafe95f4e276@I-love.SAKURA.ne.jp>
 <CAHC9VhTj-PQ0qPTiphPLXyJx3bWeqgVS_GPCWNgjqFqBgH6Njg@mail.gmail.com>
 <b0b60fdc-4484-2265-7fdf-8367bf218d18@I-love.SAKURA.ne.jp>
 <CAHC9VhRaUxN=oEyKCOrfrGzJeXDGxv2EKbZH3qwAB6AhKcSfog@mail.gmail.com>
 <68a0ef90-b452-2096-3729-b5c208878ff9@I-love.SAKURA.ne.jp>
 <CAHC9VhTPgnzdn1tmEmufcbseN_Q1CyzxTEzfvZW7OCBTeAadmA@mail.gmail.com>
 <d2557f88-0cda-b0bf-5c76-7c18912798c9@I-love.SAKURA.ne.jp>
 <CAHC9VhTZE2BinivPRLJ9S_21YcmXA6tMdDtAm5w3nk0dbZ0j1w@mail.gmail.com>
 <e9c593d9-6369-2987-ce20-5832dbebd027@I-love.SAKURA.ne.jp> <e56ed3a6-9d82-a181-bbc7-e322ea47cb98@I-love.SAKURA.ne.jp>
In-Reply-To: <e56ed3a6-9d82-a181-bbc7-e322ea47cb98@I-love.SAKURA.ne.jp>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 24 Aug 2023 10:26:06 -0400
Message-ID: <CAHC9VhRTVsoMWhP1+j7RcUqy2EiV=Z7W_00h55PE-WezzLg=Ew@mail.gmail.com>
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

On Thu, Aug 24, 2023 at 9:47=E2=80=AFAM Tetsuo Handa
<penguin-kernel@i-love.sakura.ne.jp> wrote:
> On 2023/08/24 22:39, Tetsuo Handa wrote:
> >>>   (1) Catch _all_ process creations (both via fork()/clone() system c=
alls and
> >>>       kthread_create() from the kernel), and duplicate the history up=
on process
> >>>       creation.
> >>
> >> Create an audit filter rule to record the syscalls you are interested
> >> in logging.
> >
> > I can't interpret what you are talking about. Please show me using comm=
and line.
>
> I'm not interested in logging the syscalls just for maintaining process h=
istory
> information.

That's unfortunate because I'm not interested in merging your patch
when we already have an audit log which can be used to trace process
history information.

--=20
paul-moore.com
