Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3835C433F5
	for <linux-security-module@archiver.kernel.org>; Sat,  4 Sep 2021 02:27:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A41D660E8B
	for <linux-security-module@archiver.kernel.org>; Sat,  4 Sep 2021 02:27:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235645AbhIDC2z (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 3 Sep 2021 22:28:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231389AbhIDC2z (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 3 Sep 2021 22:28:55 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 638F7C061575;
        Fri,  3 Sep 2021 19:27:54 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id u11-20020a17090adb4b00b00181668a56d6so749827pjx.5;
        Fri, 03 Sep 2021 19:27:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=I0YxCvUghet9DhkiuBhmPHLgPAw3XzzyXfrXY1VG23c=;
        b=oni0LfF7wnSgMcsYp+GqcVd8hC4djLUJXjwH+/Jk9+BKPNa6I9jQdtqSx2d9YDBSEl
         rIDtvRVOpVhSYIRAmrBmWFrUQ75jVh969uKlzH2N9By6yOqHrnp+NUHEEFS4h/ZX+kWJ
         J4c9Us85LJNFvQlUwpsbDGFmwUJCwd5nqqzzIC3r1KvIOvKScEj+WBczPnj99D2DJX0g
         FuhOgEliUZcFpedW2qvDNqC7+HqgS5khWLXBSibB05xlPqh3DkOXp736ZjN4QH8VXI6W
         PxVKc5mpxOgZ7DgI6hmh0LA6f2g2vIVahmW2eJLrDZ0CuMGesYrs8YilDKviiXfFae5r
         oB/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=I0YxCvUghet9DhkiuBhmPHLgPAw3XzzyXfrXY1VG23c=;
        b=CGPWpn6D9cl78LcEVC+sKfQ1/evHmQkMwFtexK3mLcF7jyntApeeJq+0/NrWXsCKg9
         OKz3AwnIIc03Gui5aVjuUGMNppSIOZ6oSAWknmpDyJ04ZCbzUuPrVkPMjhyDOXNnhZ3J
         094ygPSS5HfwcGrn8snQMeojtTZN6YGpIQFS3OvyrdDi+6FIhCE1prpMEbGQhdS6SPrQ
         yytslXsrykDfwzaZVeadhOi5BUH7V+yNeOF5jdTw8Y6B6cugIs75nJ9c1Wq4h78x4kdS
         p1i+oBJ4AlUPleDqCj0jM5ZJERp9D4DksSm3mcQDATkxn073hYNtCHl6AVXlZcLm5/8X
         mqZQ==
X-Gm-Message-State: AOAM530j0dPzsGkTF02sCe5FnU3EBJXqJ02TYiwPgG61n6WDt9qodZyb
        b7oCJKYpkKEkKILsyit2tNa+g+rtWDZeAlSkpnyk1rLr3vwwK/vt
X-Google-Smtp-Source: ABdhPJxqa28GSmTg20NdRJcEvtdeBCqNvYfDe4D1JiXScdYQVWc2bJCXCyUs4MHSF9p33xGn1jxM8AwB3HlN45GaY0Q=
X-Received: by 2002:a17:90b:3b4d:: with SMTP id ot13mr1974778pjb.67.1630722473874;
 Fri, 03 Sep 2021 19:27:53 -0700 (PDT)
MIME-Version: 1.0
References: <20210831000912.GA4588@raspberrypi> <4b68307a-26a8-c17b-bbf6-1fb9b88e7f9e@canonical.com>
In-Reply-To: <4b68307a-26a8-c17b-bbf6-1fb9b88e7f9e@canonical.com>
From:   Austin Kim <austindh.kim@gmail.com>
Date:   Sat, 4 Sep 2021 11:27:44 +0900
Message-ID: <CADLLry61wZLKeqLc=wzPV1rMe86dLDud96WXOB-r8wFKC6XPzw@mail.gmail.com>
Subject: Re: [PATCH] apparmor: remove unused argument of aa_umount()
To:     John Johansen <john.johansen@canonical.com>
Cc:     James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

2021=EB=85=84 9=EC=9B=94 4=EC=9D=BC (=ED=86=A0) =EC=98=A4=EC=A0=84 8:30, Jo=
hn Johansen <john.johansen@canonical.com>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=
=B1:
>
> On 8/30/21 5:09 PM, Austin Kim wrote:
> > The 'flags' argument in aa_umount() is not used,
> > so it had better remove unused argument.
> >
> > Signed-off-by: Austin Kim <austindh.kim@gmail.com>
>
> looks good, I'll pull this into my tree

Great, thanks!

>
> Acked-by: John Johansen <john.johansen@canonical.com>
>
> > ---
> >  security/apparmor/include/mount.h | 2 +-
> >  security/apparmor/lsm.c           | 2 +-
> >  security/apparmor/mount.c         | 2 +-
> >  3 files changed, 3 insertions(+), 3 deletions(-)
> >
> > diff --git a/security/apparmor/include/mount.h b/security/apparmor/incl=
ude/mount.h
> > index a710683b2496..9327456cda09 100644
> > --- a/security/apparmor/include/mount.h
> > +++ b/security/apparmor/include/mount.h
> > @@ -42,7 +42,7 @@ int aa_new_mount(struct aa_label *label, const char *=
dev_name,
> >                const struct path *path, const char *type, unsigned long=
 flags,
> >                void *data);
> >
> > -int aa_umount(struct aa_label *label, struct vfsmount *mnt, int flags)=
;
> > +int aa_umount(struct aa_label *label, struct vfsmount *mnt);
> >
> >  int aa_pivotroot(struct aa_label *label, const struct path *old_path,
> >                const struct path *new_path);
> > diff --git a/security/apparmor/lsm.c b/security/apparmor/lsm.c
> > Index 0834ba6a8a2e..58ba3f0605d2 100644
> > --- a/security/apparmor/lsm.c
> > +++ b/security/apparmor/lsm.c
> > @@ -574,7 +574,7 @@ static int apparmor_sb_umount(struct vfsmount *mnt,=
 int flags)
> >
> >       label =3D __begin_current_label_crit_section();
> >       if (!unconfined(label))
> > -             error =3D aa_umount(label, mnt, flags);
> > +             error =3D aa_umount(label, mnt);
> >       __end_current_label_crit_section(label);
> >
> >       return error;
> > diff --git a/security/apparmor/mount.c b/security/apparmor/mount.c
> > index aa6fcfde3051..e33de97839ec 100644
> > --- a/security/apparmor/mount.c
> > +++ b/security/apparmor/mount.c
> > @@ -610,7 +610,7 @@ static int profile_umount(struct aa_profile *profil=
e, const struct path *path,
> >                          AA_MAY_UMOUNT, &perms, info, error);
> >  }
> >
> > -int aa_umount(struct aa_label *label, struct vfsmount *mnt, int flags)
> > +int aa_umount(struct aa_label *label, struct vfsmount *mnt)
> >  {
> >       struct aa_profile *profile;
> >       char *buffer =3D NULL;
> >
>
