Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53022CE79AB
	for <linux-security-module@archiver.kernel.org>; Tue, 19 Sep 2023 16:47:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231707AbjISQrj (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 19 Sep 2023 12:47:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229648AbjISQri (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 19 Sep 2023 12:47:38 -0400
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51455D7
        for <linux-security-module@vger.kernel.org>; Tue, 19 Sep 2023 09:47:32 -0700 (PDT)
Received: by mail-yb1-xb34.google.com with SMTP id 3f1490d57ef6-d8521c7172eso1905161276.1
        for <linux-security-module@vger.kernel.org>; Tue, 19 Sep 2023 09:47:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1695142051; x=1695746851; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b0a58sjbAG0A2Db53/Y8qtKDwxJA4NQiN/zlKOHGSV8=;
        b=TM5ZUjOAzUYh87fKhiMIZzbDLLxZSC9g19dR6Q+EqAjA3RUbVL08w5sQA0i/jRpJwF
         tPoFJz7i1Iw8+NicI8zzMJtfE/IxN9SOqt0mwSVX9BgcAg3MYT5ASg9mIGBOhD1xe2Nh
         e+u6g+Y+raaSc8Rlza9rqVA7+VfU0JoGmVGmONTXc7BHTjLfGFHdDteXVXiaeamEhaX8
         HG5Z1H4PLT5JrUycpXIiKN679HLoI8QnvpWbEfFUl2SwzVhZofsDtNQqAnE/N6NPlfm6
         oK10qiklJ9CXHOAZqLbx7SajBzbMwAelNZO2AOckBqL0L6yDHb+QrDHEyAr0zbseh6BA
         PbdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695142051; x=1695746851;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b0a58sjbAG0A2Db53/Y8qtKDwxJA4NQiN/zlKOHGSV8=;
        b=i/AYa5UJwTUdE4e87oEUYKt7bY4KtcbrDYoj3xk0F3wXBXS6EW4hZTnPBt8I3IGwDc
         PQ9PId2VjcvR0bEU1kAfh/4mJxR5+0eiy1LkIX5o46Ngjq3OqNNfoHtIZlbp83Zgb1Ce
         pM6CFwGpJftw3vHuLorewV6baf4SdJeWD/QVr6rDwLi+kGUSGbTs3bxeIMXGm1YBZ9Ou
         xdfnJKiFmfYMJbGF1OCs0MghNrPmkemnHwvCKFhDNfoNExA9OatU+JIYXdY0BmW8p/AT
         +16Dtu0Ur4/D/0H7DVqDBRMtOhEDU3RiS1REpRXvJdoqZ2z6AebIvljzQPskot/4wRQT
         T1Qg==
X-Gm-Message-State: AOJu0Yx2q5KRtq/mipKPxeGrlnpmCbSQK/JmuF/97KXx/OJBFH2I4hXf
        dT3jXrw0z3BENxGujhpZ5Qwi8FoIQ/ODkyu3R3n2QfnfcIWBaN0wHw==
X-Google-Smtp-Source: AGHT+IHQGZRJnMfzYeI6Lr+HTWzOiuLwrjHGYMEEG1yEiRl6RXbYpezvkhRILNjas2h7ziHxZ5/E1l2+WRXKacc09uc=
X-Received: by 2002:a5b:8d2:0:b0:d5d:4df9:b6e2 with SMTP id
 w18-20020a5b08d2000000b00d5d4df9b6e2mr105144ybq.46.1695142051445; Tue, 19 Sep
 2023 09:47:31 -0700 (PDT)
MIME-Version: 1.0
References: <20230913152238.905247-1-mszeredi@redhat.com> <20230913152238.905247-4-mszeredi@redhat.com>
 <20230917005419.397938-1-mattlloydhouse@gmail.com> <CAOssrKcECS_CvifP1vMM8YOyMW7dkGXTDTKY2CRr-fPrJk76ZA@mail.gmail.com>
 <20230918-einblick-klaut-0a010e0abc70@brauner>
In-Reply-To: <20230918-einblick-klaut-0a010e0abc70@brauner>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 19 Sep 2023 12:47:20 -0400
Message-ID: <CAHC9VhQsChQO9aaY+NTtmvJgXBodvXO6rUN3d7ZyHGqitLBABw@mail.gmail.com>
Subject: Re: [RFC PATCH 3/3] add listmnt(2) syscall
To:     Christian Brauner <brauner@kernel.org>
Cc:     Miklos Szeredi <mszeredi@redhat.com>,
        Matthew House <mattlloydhouse@gmail.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, linux-man@vger.kernel.org,
        linux-security-module@vger.kernel.org, Karel Zak <kzak@redhat.com>,
        Ian Kent <raven@themaw.net>,
        David Howells <dhowells@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <christian@brauner.io>,
        Amir Goldstein <amir73il@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Mon, Sep 18, 2023 at 12:52=E2=80=AFPM Christian Brauner <brauner@kernel.=
org> wrote:
> On Sun, Sep 17, 2023 at 04:32:04PM +0200, Miklos Szeredi wrote:
> > On Sun, Sep 17, 2023 at 2:54=E2=80=AFAM Matthew House <mattlloydhouse@g=
mail.com> wrote:
> >
> > > > +       list_for_each_entry(r, &m->mnt_mounts, mnt_child) {
> > > > +               if (!capable(CAP_SYS_ADMIN) &&
>
>
> > Good point.  That issue was nagging at the back of my mind.  Having an
> > explicit flag nicely solves the issue.
>
> Ideally we avoid multiple capable(CAP_SYS_ADMIN) calls by only doing it
> once and saving the return value. capable() call's aren't that cheap.

Agreed.  The capability check doesn't do any subject/object
comparisons so calling it for each mount is overkill.  However, I
would think we would want the LSM hook called from inside the loop as
that could involve a subject (@current) and object (individual mount
point) comparison.

> Plus, we should decide whether this should trigger an audit event or
> not: capable(CAP_SYS_ADMIN) triggers an audit event,
> ns_capable_noaudit(&init_user_ns, CAP_SYS_ADMIN) wouldn't.

Why would we not want to audit the capable() call?

--=20
paul-moore.com
