Return-Path: <SRS0=3Yzx=EP=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15C04C2D0A3
	for <linux-security-module@archiver.kernel.org>; Mon,  9 Nov 2020 03:41:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CA4472065C
	for <linux-security-module@archiver.kernel.org>; Mon,  9 Nov 2020 03:41:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BRmS3SW5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729265AbgKIDlU (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Sun, 8 Nov 2020 22:41:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729262AbgKIDlU (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Sun, 8 Nov 2020 22:41:20 -0500
Received: from mail-vs1-xe44.google.com (mail-vs1-xe44.google.com [IPv6:2607:f8b0:4864:20::e44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDC3FC0613CF;
        Sun,  8 Nov 2020 19:41:19 -0800 (PST)
Received: by mail-vs1-xe44.google.com with SMTP id y73so4196869vsc.5;
        Sun, 08 Nov 2020 19:41:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4rjchIPIccnAMkbLXmM6Vjxz/RID6wWOZqACQlKGqcU=;
        b=BRmS3SW5ujjKp38TGWSraUnPGtwiblr5DYFU+87Oay4EFKqRpRuBDJ/yKGajPUpQ5E
         WsDKAveyl3/BjH1HgZoFdDzWlXuVk5cgQ7s43OnKZ/A77xorGDuY31nGQJf75rESCSUa
         F2florO/EODLBmg0kCYPnSJsn6cXKAX9aFJhB+Q+vida+moU1E4WpyHzZzXGp8L/wOSa
         88n6Z4yp/g5t8lolHEeAXQRVF5PzggOME/QY700vzDacCyh/OJnRs2Gx2/Fn9hRAAGZZ
         xyCvA9hiPvTzf+6JSvdYD0h6FX/dNb01bydu8ZZgTllaDVKLNO3C4+jcYul9dyCdgiLM
         H3NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4rjchIPIccnAMkbLXmM6Vjxz/RID6wWOZqACQlKGqcU=;
        b=aVA1hwCnSFyuhaw/tc3vKbiVgRYtA2be10pLvxVEBvAM6zTYDiqsUC1Qs9QAb9H/XO
         uD/aTIEt5RojextNFXAHC1KE+xcxE22Wq02YE3KEh3EkDa/Ld6pRtiGGKYxt4JeScd9i
         3NE4Tv1JHpC2r7iPY0nNyUj70w4LPYm7DbAujq2SVsjvMPFQuWqMaRAJtcAFbTOCCsBU
         UW3gU0hgvuv38qcRkQfO5FpCxdSqyN0TMZTyOn562VhG0RF6rpcTLpqsYqUTjAbBO1QH
         RnEmqxmnLc9ycYP6aQySq8oSAIxGi2U61KQzg8wRmjUFy+gIo2nm6XOC8Zl9UL3vbHsH
         nb0w==
X-Gm-Message-State: AOAM533HRNZibzIBEOej7A6jyu8oNN94/Kq1U7fkPX7AhXSTBNGQb7QF
        2Y8EWGFjHu5GVt5csSguUo+w/UG68mWMco2A0Es=
X-Google-Smtp-Source: ABdhPJw4r70AChTcdWv7ZuwxvimjdBJIpe/CkSupnH8EEhdRf/iweiXhxrjFrpiZ3TJD9YE5xjXIN9AR2j+SjNPdH4M=
X-Received: by 2002:a67:2ec1:: with SMTP id u184mr7345478vsu.9.1604893279068;
 Sun, 08 Nov 2020 19:41:19 -0800 (PST)
MIME-Version: 1.0
References: <1604737451-19082-1-git-send-email-jrdr.linux@gmail.com>
 <1604737451-19082-2-git-send-email-jrdr.linux@gmail.com> <f5ed0413-315c-d5d0-e33f-c2b247a28da2@nvidia.com>
In-Reply-To: <f5ed0413-315c-d5d0-e33f-c2b247a28da2@nvidia.com>
From:   Souptick Joarder <jrdr.linux@gmail.com>
Date:   Mon, 9 Nov 2020 09:11:07 +0530
Message-ID: <CAFqt6zaRP56DPRHTGMNiY3KpdOKPB_SeeuFagUbkmQKQ6mKD2A@mail.gmail.com>
Subject: Re: [PATCH 2/2] tomoyo: Fixed typo in documentation
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     takedakn@nttdata.co.jp,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Sat, Nov 7, 2020 at 2:27 PM John Hubbard <jhubbard@nvidia.com> wrote:
>
> On 11/7/20 12:24 AM, Souptick Joarder wrote:
> > Fixed typo s/Poiner/Pointer
> >
> > Fixes: 5b636857fee6 ("TOMOYO: Allow using argv[]/envp[] of execve() as conditions.")
> > Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
> > Cc: John Hubbard <jhubbard@nvidia.com>
> > ---
> >   security/tomoyo/domain.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/security/tomoyo/domain.c b/security/tomoyo/domain.c
> > index bd748be..7b2babe 100644
> > --- a/security/tomoyo/domain.c
> > +++ b/security/tomoyo/domain.c
> > @@ -891,7 +891,7 @@ int tomoyo_find_next_domain(struct linux_binprm *bprm)
> >    *
> >    * @bprm: Pointer to "struct linux_binprm".
> >    * @pos:  Location to dump.
> > - * @dump: Poiner to "struct tomoyo_page_dump".
> > + * @dump: Pointer to "struct tomoyo_page_dump".
>
> Not worth a separate patch, especially since the original comment is merely
> copying the C sources, and as such, does not add any value.
>
> I'd either a) craft a new documentation line that adds some value, or b) just
> merge this patch into the previous one, and make a note in the commit
> description to the effect that you've included a trivial typo fix as long
> as you're there.
>

John, as patch[1/2] is dropped, can we take this patch forward with some more
updates in documentations ?
