Return-Path: <SRS0=TMVc=CZ=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7BB0C43461
	for <linux-security-module@archiver.kernel.org>; Wed, 16 Sep 2020 18:36:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 79971206B5
	for <linux-security-module@archiver.kernel.org>; Wed, 16 Sep 2020 18:36:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="F+8NDuo/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728041AbgIPSgm (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 16 Sep 2020 14:36:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728083AbgIPS3N (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 16 Sep 2020 14:29:13 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBC67C0A888D
        for <linux-security-module@vger.kernel.org>; Wed, 16 Sep 2020 05:48:00 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id q9so2667172wmj.2
        for <linux-security-module@vger.kernel.org>; Wed, 16 Sep 2020 05:48:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0Ak62nesCbOREDTTzpc8X9wLA7URHRevPKbppowyS5I=;
        b=F+8NDuo/1RWe7wgG2WhonViKgW4VIrYKG0fuQMdu+s7s5fBfnou/S/twaeShYbWsMb
         SpuEoGcFcKnM/hRqmfdKUbO45bKl7Q1S7ixO2QN1hVzhYdN/ZC6KlkmpSJBXli3nrJC4
         C8wZha5ZkpFJr1yLUzyj/IveBKWMSQSs7Tpis=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0Ak62nesCbOREDTTzpc8X9wLA7URHRevPKbppowyS5I=;
        b=pIoSLtrSmyEKB/ulPTnpLQ53+JATwZqfg/1XaNpn4w49JkipNthQaFdC/74qMiVrZO
         Fd4MECOgzG3/csmS7B1dICTzubMtg/7/gzCOifZGZbgt+SEk1SFs/G4wlpodUMx/RgJJ
         phDFiiTo06vucGaNduSaoCKX57fCaxhpMMrgm/NVUBlDoLqlaBnkwwOERpn+aWEIrb13
         ISAstg+XjrZRy3bgSrQ3Mbgd1JvwBmosWVdm0eEJThqPKWIVF428a0OzGGWBfglspmbX
         1b8BJD5va1QDnPhhjADEGIoTsuBWwupTeaLrxuwH+PbvB0glSkjO2jQBBYlWnzSXlatL
         lLgQ==
X-Gm-Message-State: AOAM530IZkzz5TfyNJKphFb2yJKQgIGJXooImmhn8ZH8+ZynuFEVZAGW
        f62OaHhOpQbZJMIL83efiuGWkgzAX1ZCE1YMFur8Ow==
X-Google-Smtp-Source: ABdhPJw7+Ll62XVAkpr+sbPg39fiPYa0S/X4E49SjQZq1wnxbE/A4/IKrdERM2HSi8OlQ4BlpjNN0mLfNxPL88VRoi0=
X-Received: by 2002:a1c:1902:: with SMTP id 2mr4874239wmz.26.1600260478858;
 Wed, 16 Sep 2020 05:47:58 -0700 (PDT)
MIME-Version: 1.0
References: <20200916120548.364892-1-kpsingh@chromium.org> <5ab256148e8ad5f9882e888dac809bc72cd3fe66.camel@chromium.org>
In-Reply-To: <5ab256148e8ad5f9882e888dac809bc72cd3fe66.camel@chromium.org>
From:   KP Singh <kpsingh@chromium.org>
Date:   Wed, 16 Sep 2020 14:47:48 +0200
Message-ID: <CACYkzJ7dZuOL9NhzaMmpvGqE3TWYHV=AicNmjgs1aD81TctR0Q@mail.gmail.com>
Subject: Re: [PATCH] ima: Fix NULL pointer dereference in ima_file_hash
To:     Florent Revest <revest@chromium.org>
Cc:     open list <linux-kernel@vger.kernel.org>,
        Linux Security Module list 
        <linux-security-module@vger.kernel.org>,
        Mimi Zohar <zohar@linux.ibm.com>,
        James Morris <jmorris@namei.org>,
        Kees Cook <keescook@chromium.org>,
        Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        Jann Horn <jannh@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Somehow this patch does not seem to have been picked up by any of the
mailing list archives and I am not sure if this was delivered to the
lists. I will send a v2 and add Florent's Reviewed-by tag.

On Wed, Sep 16, 2020 at 2:41 PM Florent Revest <revest@chromium.org> wrote:
>
> Reviewed-by: Florent Revest <revest@chromium.org>
>
> On Wed, 2020-09-16 at 12:05 +0000, KP Singh wrote:
> > From: KP Singh <kpsingh@google.com>
> >
> > ima_file_hash can be called when there is no iint->ima_hash available
> > even though the inode exists in the integrity cache.
> >
> > An example where this can happen (suggested by Jann Horn):
> >
> > Process A does:
> >
> >       while(1) {
> >               unlink("/tmp/imafoo");
> >               fd = open("/tmp/imafoo", O_RDWR|O_CREAT|O_TRUNC, 0700);
> >               if (fd == -1) {
> >                       perror("open");
> >                       continue;
> >               }
> >               write(fd, "A", 1);
> >               close(fd);
> >       }
> >
> > and Process B does:
> >
> >       while (1) {
> >               int fd = open("/tmp/imafoo", O_RDONLY);
> >               if (fd == -1)
> >                       continue;
> >               char *mapping = mmap(NULL, 0x1000, PROT_READ|PROT_EXEC,
> >                                    MAP_PRIVATE, fd, 0);
> >               if (mapping != MAP_FAILED)
> >                       munmap(mapping, 0x1000);
> >               close(fd);
> >       }
> >
> > Due to the race to get the iint->mutex between ima_file_hash and
> > process_measurement iint->ima_hash could still be NULL.
> >
> > Fixes: 6beea7afcc72 ("ima: add the ability to query the cached hash
> > of a given file")
> > Signed-off-by: KP Singh <kpsingh@google.com>
> > ---
> >  security/integrity/ima/ima_main.c | 10 ++++++++++
> >  1 file changed, 10 insertions(+)
> >
> > diff --git a/security/integrity/ima/ima_main.c
> > b/security/integrity/ima/ima_main.c
> > index 8a91711ca79b..4c86cd4eece0 100644
> > --- a/security/integrity/ima/ima_main.c
> > +++ b/security/integrity/ima/ima_main.c
> > @@ -531,6 +531,16 @@ int ima_file_hash(struct file *file, char *buf,
> > size_t buf_size)
> >               return -EOPNOTSUPP;
> >
> >       mutex_lock(&iint->mutex);
> > +
> > +     /*
> > +      * ima_file_hash can be called when ima_collect_measurement has
> > still
> > +      * not been called, we might not always have a hash.
> > +      */
> > +     if (!iint->ima_hash) {
> > +             mutex_unlock(&iint->mutex);
> > +             return -EOPNOTSUPP;
> > +     }
> > +
> >       if (buf) {
> >               size_t copied_size;
> >
>
