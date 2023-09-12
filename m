Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EB96EE3F0C
	for <linux-security-module@archiver.kernel.org>; Tue, 12 Sep 2023 19:03:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231454AbjILTDb (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 12 Sep 2023 15:03:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230204AbjILTDb (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 12 Sep 2023 15:03:31 -0400
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com [IPv6:2607:f8b0:4864:20::112a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3079DE6
        for <linux-security-module@vger.kernel.org>; Tue, 12 Sep 2023 12:03:27 -0700 (PDT)
Received: by mail-yw1-x112a.google.com with SMTP id 00721157ae682-58c92a2c52dso57217997b3.2
        for <linux-security-module@vger.kernel.org>; Tue, 12 Sep 2023 12:03:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1694545406; x=1695150206; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wQ1VKdN/aBfUAopT+hjJ8o44myACeHU5luAW7mCybTQ=;
        b=RsEhX3eLLEzfIDPk1fqE0zP03ve6e+bKfSqKGPyvHiz2cs4JkUX0VYsDtKQijE2bmI
         ZQ8GS0WtQX7cuVeXTukkAIJCdhEKk9tFzKKiPjUVdoyRabPIZB+OrCRMcZTegoniH3z1
         KbDxYlkWIhOTwvlJHoz9EWIgtHvqhr9LsQ/2Geh6W/7GmUk6OfC6kRgev6OJfRWwBQp5
         /QcLyZJbbsR2W2qShXB6r2H8Gz3ZZtsRokVTi2fvefIW1zXK7rZ2mD7XY/nTo50COHPI
         OoY/L4VGXGcRyoVguX/W2EUOc04ye3zPTMW5q0LDjyZXKjhYzJuRQXcQt6AT8zc6ST+p
         K4Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694545406; x=1695150206;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wQ1VKdN/aBfUAopT+hjJ8o44myACeHU5luAW7mCybTQ=;
        b=ibskaQnqkLO70UyoxFdItKhSqPA1nWPKQKwSYHIlDzhnhmzoivXMFcwMHKQEB/66fb
         dzOwEhK2j1gaHe2Cf7noiQ1IVmeE0XG6PKKp9k7lw0g+8OEt3IETNj9B9f8OIQqpGspS
         y+yFjxx2sn7334KWFxzhhPdWm8sNUcWkNnWFLFGtAL+I1YdKneXmTUiBSBJg1aoSR4U3
         F1xzIXVLYTIHVPXpGHqWZU3NRV1ei/CWHFQrFTbCW4M6a+AAaRm5zXa/kf6zqy9lKinA
         p81b8LaNmdSjBBQo/kTOSkQsBn5Mofh2dCbaHw+tNAKaShosS01hIh6qrRblSBKgkuvg
         M1AQ==
X-Gm-Message-State: AOJu0YxxktpJqUqotSRRNimSAMmM6+1Ff+Ta+YgPhUYKPKWHMOVlHXos
        c7Ap/zgIAWdkbx6jUDbvUElHR5p8ldMhe5R5o43CPxraIKW08sI=
X-Google-Smtp-Source: AGHT+IFI+lUutYWATIzO1Rj/u84oQuaK0f+o0uPgJsL+KQ5ISKdIp8saLOGc8LfYWJyuz6TNGxKzqilqJpZHtuUhIZ4=
X-Received: by 2002:a0d:c947:0:b0:592:2d33:16b8 with SMTP id
 l68-20020a0dc947000000b005922d3316b8mr356914ywd.30.1694545406339; Tue, 12 Sep
 2023 12:03:26 -0700 (PDT)
MIME-Version: 1.0
References: <CAHC9VhRsxARUsFcJC-5zp9pX8LWbKQLE4vW+S6n-PMG5XJZtDA@mail.gmail.com>
 <4708afda-8867-735a-2f55-ca974e76cc9c@schaufler-ca.com> <CAHC9VhTepATGki_8_nyUcmCCvJ2hpLO4bWFhF-gJ3CQceEBMfA@mail.gmail.com>
 <CAHC9VhQ9EfH5sb85+uwyB726iDNR47k=sfr0zBCENz=-PerR9A@mail.gmail.com>
 <CAHC9VhQhf+ik5S_aJOVn59pax1Aa0vO5gJ4YoxrtGRKtoWh7sA@mail.gmail.com>
 <f8f32da5-6f31-d197-7405-8f308bd29228@I-love.SAKURA.ne.jp>
 <CAHC9VhTktg4RFWw+rSZ6wWQ8iR3n2p8XaOO95BbJ1QGAd4y9fg@mail.gmail.com>
 <43d84d6c-18ac-6689-cddc-d079cfa19d4d@I-love.SAKURA.ne.jp>
 <CAHC9VhSG2UzE9N0-tAJc8B3Mj1PEuJ2b6wso_DUs_Y83yqwhjA@mail.gmail.com>
 <c8d58922-9af4-b425-03c6-6710ad17b739@schaufler-ca.com> <CAHC9VhTdtF=_4nj3-eQvBUhWhnEss28KKUKCciBCrBL9pN+uQw@mail.gmail.com>
In-Reply-To: <CAHC9VhTdtF=_4nj3-eQvBUhWhnEss28KKUKCciBCrBL9pN+uQw@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 12 Sep 2023 15:03:15 -0400
Message-ID: <CAHC9VhQ4xAvNK8QaHpYL4bUankB86fi6NW9eo6VNnrbi_dTd+Q@mail.gmail.com>
Subject: Re: ANN: new LSM guidelines
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        linux-security-module@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Tue, Sep 12, 2023 at 3:00=E2=80=AFPM Paul Moore <paul@paul-moore.com> wr=
ote:
> On Tue, Sep 12, 2023 at 2:40=E2=80=AFPM Casey Schaufler <casey@schaufler-=
ca.com> wrote:
> > On 9/12/2023 11:08 AM, Paul Moore wrote:
> > >
> > > Once again, we've already discussed this many, many times: out-of-tre=
e
> > > LSMs are not the priority and that is not going to change.  One
> > > corollary of this is that we are not going to assign LSM IDs to LSMs
> > > that remain out-of-tree as this would negatively impact the LSM layer
> > > by cluttering/depleting the LSM ID space.  LSMs that are working
> > > towards integration with the upstream Linux kernel can self-assign a
> > > temporary LSM ID which will be finalized upon merging in the LSM tree=
.
> > > Based on all of the arguments you have already submitted - and let us
> > > be very clear: you are the only one speaking out against this - I see
> > > no reason to change this policy.
> >
> > I won't say this is a great idea, or that I endorse it, but we could
> > allocate a range of LSM ID values ( 10000 - 10999 ? ) that we promise
> > will never be given to an upstream LSM. We wouldn't make any guarantees
> > about conflicts otherwise. These could be used by LSMs before they are
> > accepted upstream or by LSMs that don't have upstream aspirations. I
> > seriously doubt that anyone using such an LSM is going to be mixing
> > multiple such LSMs without being capable of managing ID conflicts.
>
> Not a crazy idea.  I had debated something similar, a reserved
> "private use" or "experimentation" range; there is definitely
> precedence for that in other areas, e.g. network protocols.  What held
> me back is that invariably folks will want to create long-term
> persistent registrations against this space for their out-of-tree LSMs
> which would require some sort of unofficial, adhoc registration
> authority which starts to get a bit silly in my opinion (the
> registration authority for the Linux kernel API is the upstream Linux
> kernel community).
>
> Temporary assignments while a LSM is undergoing the review-revision
> cycle on its way to being merged is something different and if we need
> a couple of reserved numbers for that (one or two MAX) we can consider
> that, but I don't expect this to be a major problem in practice.  LSMs
> that are in this transient pre-merge state shouldn't be used for
> production purposes and thus a LSM ID change on merging shouldn't be a
> problem.

Just to avoid any confusion on this, a reserved range at this point in
time is currently a NACK from my perspective.  I am open to consider
reserving one, maybe two, ID numbers in the future for in-development
LSMs if we start having problems, but I will need to see persistent
problems first.

--=20
paul-moore.com
