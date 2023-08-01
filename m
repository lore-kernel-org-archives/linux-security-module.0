Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91FA9C00528
	for <linux-security-module@archiver.kernel.org>; Tue,  1 Aug 2023 18:50:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229611AbjHASuK (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 1 Aug 2023 14:50:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230246AbjHASuE (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 1 Aug 2023 14:50:04 -0400
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE6A91BC7
        for <linux-security-module@vger.kernel.org>; Tue,  1 Aug 2023 11:50:03 -0700 (PDT)
Received: by mail-ot1-x332.google.com with SMTP id 46e09a7af769-6bb29b9044dso5472998a34.1
        for <linux-security-module@vger.kernel.org>; Tue, 01 Aug 2023 11:50:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1690915803; x=1691520603;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bP0kHzppqou9eIdchBF+b4nGFMSY2OtM68YQuJgktb4=;
        b=UkcZ3fw6vcBcqYCXkx6be+E+/BJWEfLFjx3k/hL9Ord8otck6p4zMOxaWGpAfoEHsx
         x4ENVBqy3o69ZBBm6QWiWn98EQYLOHvEed/U+t2Q4HoplAsyLBzHRARYP81DWlYr2e/9
         eEdrGkRRpEfKqC8IZVz5v28IAyEtGw8YWxU/L0nIMa+qKtHHtSxeAAtvKro5gqRJB0CW
         NXsWm151NggKxU2Q5P8WttYgCqW6zWcgdWzNN4TYEqVNeNKY/sJZh/6qntnkN4ZdvB+g
         48SPZ4btXb1qrnwp+uuT5o6wvC/kxBkHiDfvmY1S1vYkY3H7xzW+s1t52uryff8Dexj4
         5tMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690915803; x=1691520603;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bP0kHzppqou9eIdchBF+b4nGFMSY2OtM68YQuJgktb4=;
        b=a5y0DjHsYZGmkiormvWAod7AhdoOW+3B4OriPgnP8waW6kgviep+fGQzq2p4mjjupd
         8T65zlZmQgPbinR4QZU6ym3KPkr6ny8Xk5YzhQeGQIQAUmKSPf8AALEBKDF9ueIhGfsm
         JxEPk+eUtOuiPRBPE+gVNtyQ2jkHtxpcMhKGL8cvcNbtdaRBB8dknz7I6xgiunjHGAp6
         adzfLJExjyVMmv0P9omvNWhL5eA1vNbGVITlbw7X92NozJ23uSd9TuvDx1N+OdjiV9C+
         bmkucEyHC4MpgenxueMnwU1KOG89p8S1SK2XiyapnaB5Cc9Q5gTEPoBU1WEed+eXz4hQ
         36Mg==
X-Gm-Message-State: ABy/qLZ+VNpUSbKxd3ZqVfAxu5mbfSShBZZvTsWYcBkMwy+V+oj4EGR8
        OqQJV6H9iXYWR+GbCCu33e20GOjpSoYYjxAxEF2mTNE5lDU+SjwA4fEY
X-Google-Smtp-Source: APBJJlGOBu3jixmhs26jljFyQRGnSmedsBon71LgcOZ24/phGZSHD3EF1RUyoVnbrpvm4ob2RGQcXkB5DRqe8A+AEBI=
X-Received: by 2002:a05:6830:4b9:b0:6b7:1f33:5ec4 with SMTP id
 l25-20020a05683004b900b006b71f335ec4mr15092931otd.12.1690915803119; Tue, 01
 Aug 2023 11:50:03 -0700 (PDT)
MIME-Version: 1.0
References: <20230731103822.GA4093@wind.enjellic.com> <CAHC9VhT_6yv=hgCLUMYf154=-ARY5+V+FMi_0O+_t2rsb341Eg@mail.gmail.com>
 <20230801105421.GA23193@wind.enjellic.com> <20230801125529.GA915814@mail.hallyn.com>
In-Reply-To: <20230801125529.GA915814@mail.hallyn.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 1 Aug 2023 14:49:52 -0400
Message-ID: <CAHC9VhQYGmJtvkS_tBuRkUqBMorpkO4TByRicNPwpGr2j9N=ag@mail.gmail.com>
Subject: Re: TSEM feedback.
To:     "Serge E. Hallyn" <serge@hallyn.com>
Cc:     "Dr. Greg" <greg@enjellic.com>,
        linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Tue, Aug 1, 2023 at 8:55=E2=80=AFAM Serge E. Hallyn <serge@hallyn.com> w=
rote:
> On Tue, Aug 01, 2023 at 05:54:21AM -0500, Dr. Greg wrote:
> > On Mon, Jul 31, 2023 at 10:57:08AM -0400, Paul Moore wrote:
> >
> > Good morning, I hope the day is starting well.
> >
> > > On Mon, Jul 31, 2023 at 6:39???AM Dr. Greg <greg@enjellic.com> wrote:
> > > >
> > > > Good morning Paul, I hope this note finds your week starting well.
> > > >
> > > > We submitted the patches for the V2 release of TSEM three weeks ago=
.
> > > >
> > > > We received some feedback from Randy Dunlap on some documentations
> > > > issues that we went on to address.
> > > >
> > > > Haven't heard any reflections from you.  Was just wondering if you
> > > > were swamped or had possibly missed the submission?  We didn't incl=
ude
> > > > you as a copy on the notion that you didn't need two sets of patche=
s
> > > > landing in your inbox.
> >
> > > If your mail hits the mail archive on lore.kernel.org, it is almost
> > > a full guarantee that it has hit my inbox and/or the patchwork
> > > instance I use to ensure nothing is missed.
> >
> > So noted.
> >
> > > As one would expect, it takes a good deal of time to review a patch
> > > submission as large as TSEM, and the rather ornate language used in
> > > the documentation only slows the process.
> >
> > For whatever it is worth, as a group, we invested a considerable
> > amount of time, over a period of now 8+ years, in refining the
> > terminology and nomenclature embodied in that document.
> >
> > I guess the only defense at hand is a variant on the alleged response
> > by Austrian Emperor Joseph II to Mozart's "Die Entfuhrung aus dem
> > Serail":
> >
> > "It contains as many words, with appropriate ornateness, as was deemed
> > necessary."
>
> I cannot let such a golden opportunity pass to use
>   https://www.youtube.com/watch?v=3DgA-sEfXOaEQ

 ;)

While I don't doubt that some would view the choices made in
describing TSEM as necessary, it is important to remember that those
judgements, as well as my own, are subjective.  I appreciate the time
and effort that has gone into the TSEM documentation (and welcome the
care behind it!), but I very much agree with the sentiments in the
video snippet Serge linked.

--=20
paul-moore.com
