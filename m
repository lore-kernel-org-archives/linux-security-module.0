Return-Path: <SRS0=TMVc=CZ=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3AB4C433E2
	for <linux-security-module@archiver.kernel.org>; Wed, 16 Sep 2020 19:15:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4101F20715
	for <linux-security-module@archiver.kernel.org>; Wed, 16 Sep 2020 19:15:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="T5oWizwJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727301AbgIPTPn (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 16 Sep 2020 15:15:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727270AbgIPRiM (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 16 Sep 2020 13:38:12 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA25AC02526A
        for <linux-security-module@vger.kernel.org>; Wed, 16 Sep 2020 09:59:37 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id d4so3463684wmd.5
        for <linux-security-module@vger.kernel.org>; Wed, 16 Sep 2020 09:59:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VkWUpVUhJm5M+uhJs8eXOgl2X85aT9m+yJLWexWDssM=;
        b=T5oWizwJbCJmJMI28ZimkDVchUiuRL3d6zUAGcpwNItNmc7l8aP9blPSULOi1eLIP6
         gZLMi9SVCIUMZMSJO1shI6zAeHnGNMK9vZ0h9LoHNHX8rCxF6o58J0T/jB+aalKJwXyx
         oV2LHwxQyZtcfKTz/vfkPL11osgxv2Zu44HZ0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VkWUpVUhJm5M+uhJs8eXOgl2X85aT9m+yJLWexWDssM=;
        b=af9mu+IiyYwAgcv/lbavLkV6IY9uFO5rQeBn7QTiQ7Neazr+D8WP50nbYvz9a5Fh72
         50QzraauXf7rGyKtXp6DvVvjuKEezaGkSIqhEjFshZID+MYyILXFDCaOIkpcqXdfwSk6
         vmfPetmWBuET5+6lHU7FMvqPi5JqiunlFRuZeLwcpRi9NLMO18qOntg9cf8TToBN75tH
         5r1nh2GCgFOkL+Oe+LpTPzOHltV6d8YsKrGE8BwSlXaNe0I2+2TtVvPggJv470o7gvUW
         8hTk6MRawXVrgE6Vu/cSCjY+Z+N6j7c3GGBN4Bm74mmUvpR9Xg7++S4uslanlL3BjLgq
         ixWA==
X-Gm-Message-State: AOAM533ffYXOACmyMB4o9WJXpeKvJ1zrkdtyRM7eJhorRXHT9aPb3MS1
        mKrOYZr2i9biLTj5BdXuk8dQgdqlFUC5Hs4+pPk5Yw==
X-Google-Smtp-Source: ABdhPJwnkUKOf60qRo8TMjHre1NIVb64k+AgGpe80UPknU1BL6NuBCSG6NpCCQL6tyaQv8jdu8ddGyYbDK4qALFj3vs=
X-Received: by 2002:a7b:c090:: with SMTP id r16mr5835223wmh.56.1600275576323;
 Wed, 16 Sep 2020 09:59:36 -0700 (PDT)
MIME-Version: 1.0
References: <20200916124931.1254990-1-kpsingh@chromium.org> <8cee070eed5b8a3dc9f373fc9db8d99a70b7d75a.camel@linux.ibm.com>
In-Reply-To: <8cee070eed5b8a3dc9f373fc9db8d99a70b7d75a.camel@linux.ibm.com>
From:   KP Singh <kpsingh@chromium.org>
Date:   Wed, 16 Sep 2020 18:59:25 +0200
Message-ID: <CACYkzJ4C4mLZY0=Z_BHc+0u0oCuCu0xkYdUPCp=Xs12uT7175w@mail.gmail.com>
Subject: Re: [PATCH v2] ima: Fix NULL pointer dereference in ima_file_hash
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     open list <linux-kernel@vger.kernel.org>,
        Linux Security Module list 
        <linux-security-module@vger.kernel.org>,
        Florent Revest <revest@chromium.org>,
        James Morris <jmorris@namei.org>,
        Kees Cook <keescook@chromium.org>,
        Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        Jann Horn <jannh@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Wed, Sep 16, 2020 at 6:00 PM Mimi Zohar <zohar@linux.ibm.com> wrote:
>
> On Wed, 2020-09-16 at 14:49 +0200, KP Singh wrote:
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
> > Fixes: 6beea7afcc72 ("ima: add the ability to query the cached hash of a given file")
> > Signed-off-by: KP Singh <kpsingh@google.com>
> > Reviewed-by: Florent Revest <revest@chromium.org>
> > ---
> >  security/integrity/ima/ima_main.c | 10 ++++++++++
> >  1 file changed, 10 insertions(+)
> >
> > diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
> > index 8a91711ca79b..4c86cd4eece0 100644
> > --- a/security/integrity/ima/ima_main.c
> > +++ b/security/integrity/ima/ima_main.c
> > @@ -531,6 +531,16 @@ int ima_file_hash(struct file *file, char *buf, size_t buf_size)
> >               return -EOPNOTSUPP;
> >
> >       mutex_lock(&iint->mutex);
> > +
> > +     /*
> > +      * ima_file_hash can be called when ima_collect_measurement has still
> > +      * not been called, we might not always have a hash.
> > +      */
> > +     if (!iint->ima_hash) {
> > +             mutex_unlock(&iint->mutex);
> > +             return -EOPNOTSUPP;
> > +     }
> > +
>
> Not having a file hash is rather common (e.g. mknodat, prior to the
> file being closed).  Before appraising the integrity of a file, it
> checks whether it is a new file (eg. IMA_NEW_FILE), but, unfortunately,
> the flag is only set for those files in the appraise policy.

Makes sense.

>
> The patch looks fine, but you might want to reflect not having a file
> hash is common in the patch description.
>

Thanks! Will send another revision with an updated description.

- KP

> Mimi
>
> >       if (buf) {
> >               size_t copied_size;
> >
>
>
