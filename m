Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CA96C4332F
	for <linux-security-module@archiver.kernel.org>; Sun, 12 Nov 2023 20:29:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231646AbjKLU3c (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Sun, 12 Nov 2023 15:29:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229664AbjKLU3b (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Sun, 12 Nov 2023 15:29:31 -0500
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EECA8258E
        for <linux-security-module@vger.kernel.org>; Sun, 12 Nov 2023 12:29:25 -0800 (PST)
Received: by mail-yb1-xb2e.google.com with SMTP id 3f1490d57ef6-da7ea62e76cso4086913276.3
        for <linux-security-module@vger.kernel.org>; Sun, 12 Nov 2023 12:29:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1699820965; x=1700425765; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3LEiFRccVX8KiAqr8aLrNuitddMncMWdvOArUdgwYFA=;
        b=EbahUf9u52SAJyhlGTA6PhYxsSBdC5ivLbdab9QagM7D7xxDQhIfR4lPt06NwpUA69
         +i1X+9NFuw3pli+gN48bLsDQbsl8YTF7ghcUQrpsb79jZnMcwmeJMIaFP9ZOX6jb7GEw
         yO593/1b+5NSBLPMTFwX91PPOEAjVekAXWSW/u9HIUuqSrOb8XLP7t1zXJFD5PZ6Grvb
         oAQBMMu2/ThkLnxJFrBJ6vT5dmnYPmzFrdaFMcI3lDyHeH7+psGnxZAI36wyjVtyqMVz
         wsd+S97EYB5QLGU411A/MEm+AHrLZoqD2ifQD8yCVCclZucWe6gUob8eX16OfSLO3KCL
         zfbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699820965; x=1700425765;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3LEiFRccVX8KiAqr8aLrNuitddMncMWdvOArUdgwYFA=;
        b=raVacNNpWwn6Od6arAGR5uqqL/+3g5sPvkLz3E7M9WSoKT5T//BS8Mgy8SxVR3BnFX
         yTt9m66PrbNCdKQO+zhiZqOh5ekJ0CprWvHcD0wU810+J42caBg6jruACMn8dascdpF/
         3PJf7eqwWCwWm1U7f5TFTnx73GhHN96C9/oX0O70/ctESPUs6Pf+SRBBi/0aHNJvXZk8
         KyhU7XJQTupbByCnc4kfjv6j/pUDz/UU+e0GqxRAvaLsJKIYdMXYeWPRXqdYgJXofFtX
         gwMFT4TAci5rlkPAlkc7QV9TxGz6rY9CTTz7DaP2xwkI/zPpdXYrAteNEVOt2JN0dixq
         aIrw==
X-Gm-Message-State: AOJu0Yz0NeJU8cZKE2SgOpJb9X6nkbapFEERf6EezH6ezL1LbSdSkJbU
        uSK7ruAkIcZFkwt5RAgKbPHVBu+z7O9dlkU5mBy3
X-Google-Smtp-Source: AGHT+IHaPPV9MIlPUjLJpHPXhDxxIxEWB2lJUF4iF2LdqVMFQe8W4EmWqUG+SJbhoKCVuZ2gV/1GlgKZCNnUWcv98GE=
X-Received: by 2002:a25:cc8:0:b0:dae:b67e:7cd4 with SMTP id
 191-20020a250cc8000000b00daeb67e7cd4mr4193804ybm.46.1699820965122; Sun, 12
 Nov 2023 12:29:25 -0800 (PST)
MIME-Version: 1.0
References: <20231025140205.3586473-5-mszeredi@redhat.com> <4ab327f80c4f98dffa5736a1acba3e0d.paul@paul-moore.com>
 <20231108-zwerge-unheil-b3f48a84038d@brauner> <CAHC9VhSLGyFRSbeZXE7z61Y2aDJi_1Dedjw0ioFOckRCs0CRaA@mail.gmail.com>
 <CAHC9VhRvYua4noiHbMqcAqz=Rkz=pxSgp5fVxXX+uhz61jYFag@mail.gmail.com> <20231112-gemessen-lauschangriff-3352c19e676a@brauner>
In-Reply-To: <20231112-gemessen-lauschangriff-3352c19e676a@brauner>
From:   Paul Moore <paul@paul-moore.com>
Date:   Sun, 12 Nov 2023 15:29:14 -0500
Message-ID: <CAHC9VhRYtjJ9q4B_wLe89d5RBxWqpWzsKqAeAiDo5NhAYccVaQ@mail.gmail.com>
Subject: Re: [PATCH v4 4/6] add statmount(2) syscall
To:     Christian Brauner <brauner@kernel.org>
Cc:     Miklos Szeredi <mszeredi@redhat.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, linux-man@vger.kernel.org,
        linux-security-module@vger.kernel.org, Karel Zak <kzak@redhat.com>,
        Ian Kent <raven@themaw.net>,
        David Howells <dhowells@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <christian@brauner.io>,
        Amir Goldstein <amir73il@gmail.com>,
        Matthew House <mattlloydhouse@gmail.com>,
        Florian Weimer <fweimer@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Sun, Nov 12, 2023 at 8:06=E2=80=AFAM Christian Brauner <brauner@kernel.o=
rg> wrote:
> On Fri, Nov 10, 2023 at 12:00:22PM -0500, Paul Moore wrote:
> > On Wed, Nov 8, 2023 at 3:10=E2=80=AFPM Paul Moore <paul@paul-moore.com>=
 wrote:
> > > On Wed, Nov 8, 2023 at 2:58=E2=80=AFAM Christian Brauner <brauner@ker=
nel.org> wrote:
> > > > > > +static int do_statmount(struct stmt_state *s)
> > > > > > +{
> > > > > > +   struct statmnt *sm =3D &s->sm;
> > > > > > +   struct mount *m =3D real_mount(s->mnt);
> > > > > > +   size_t copysize =3D min_t(size_t, s->bufsize, sizeof(*sm));
> > > > > > +   int err;
> > > > > > +
> > > > > > +   err =3D security_sb_statfs(s->mnt->mnt_root);
> > > > > > +   if (err)
> > > > > > +           return err;
> > > > > > +
> > > > > > +   if (!capable(CAP_SYS_ADMIN) &&
> > > > > > +       !is_path_reachable(m, m->mnt.mnt_root, &s->root))
> > > > > > +           return -EPERM;
> > > > >
> > > > > In order to be consistent with our typical access control orderin=
g,
> > > > > please move the security_sb_statfs() call down to here, after the
> > > > > capability checks.
> > > >
> > > > I've moved the security_sb_statfs() calls accordingly.
> > >
> > > Okay, good.  Did I miss a comment or a patch where that happened?  I
> > > looked over the patchset and comments yesterday and didn't recall
> > > seeing anything about shuffling the access control checks.
> >
> > Gentle ping on this.  I'm asking because I know there have been issues
> > lately with the lists and some mail providers and I want to make sure
> > I'm not missing anything, I double checked lore again and didn't see
> > anything there either, but I might be missing it.
>
> Sorry, I'm traveling so I just didn't see this. Please see:
>
> https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git/commit/?h=3Dv=
fs.mount&id=3Ddc14fa93943918bee898d75d7ae72fc3623ce9ce
> https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git/commit/?h=3Dv=
fs.mount&id=3Dde17643cbf9b0282990bb9cf0e0bf01710c9ec03
>
> I've folded the fixup into these patches. I probably just accidently
> dropped the diff from my reply.

Okay, no worries, like I said I was mostly worried about mail/list
problems eating the response.

Thanks for fixing the access control ordering, but FWIW I was a little
surprised not to see a note, e.g. "[CB: changed access control
ordering]" or similar, in the metadata.

--=20
paul-moore.com
