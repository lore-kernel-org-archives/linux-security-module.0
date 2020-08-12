Return-Path: <SRS0=RtEY=BW=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50013C433E0
	for <linux-security-module@archiver.kernel.org>; Wed, 12 Aug 2020 13:09:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2C0A920639
	for <linux-security-module@archiver.kernel.org>; Wed, 12 Aug 2020 13:09:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="f3imS+8n"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727050AbgHLNJt (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 12 Aug 2020 09:09:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727000AbgHLNJm (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 12 Aug 2020 09:09:42 -0400
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3ECC9C06178A
        for <linux-security-module@vger.kernel.org>; Wed, 12 Aug 2020 06:09:39 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id c10so1469370edk.6
        for <linux-security-module@vger.kernel.org>; Wed, 12 Aug 2020 06:09:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dDaKIw34dbl2BS19WgtGHw4f1WrFR2cMDs9vgYrFqRA=;
        b=f3imS+8nyoc+AeGEyfplnYFj1FbYpGqeslu9w52ddIfQ/9dI/X2nGcCAKVKStLE6Dp
         9/bG54SxegeZiSz6ojev1zwm6xgk7bREoz2f33F4iLpDVdGYn749mq7xMDWbwNmnTo5r
         sy2qzQIlhF5PDon4IfaUAfEgRmQOA5q+0cTuo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dDaKIw34dbl2BS19WgtGHw4f1WrFR2cMDs9vgYrFqRA=;
        b=AJETAb16UEy7um9MEv0VgHLcJjiMwm+n4rXzbRGaz8lIA2D3qFgcNyDp72IPS24U8e
         2cVojPUiLklKoYeuoEUibK5NRMRBOU6Aif3CCHyfGclRvkY5yh3jZQXRGRXytsDHegkW
         BjOIgXYHveWq4Z7gDFLhHbc2uc3uqjZ2Ium4qVkt+mF2yheNKxCBOWaiDbYz9Qceb98v
         NSULET3+5q+ykDKVsax7IiMqMkxMupDsysYgmou4q9QBM7Q8CMfavn43NRD8TsI9xRgf
         QDzhrzb5vJgjRlYWQZpY8ZtbixuxaQXEypL2+X4jJ6HarkR+L2XPQD82W8eeaeas8WWo
         HYTQ==
X-Gm-Message-State: AOAM530ncjBx6WFYHXs3vgE+7tmRKWW91fYX8BWR3AuOKUjvjEJnJEaT
        00YPke89XCfvG8fBQ341m6oGz+ftIJwPSv74oCwwIw==
X-Google-Smtp-Source: ABdhPJy+Hr/67owQkNGvK1aBkG90FSTzz/k2k/Fp5hemfnktI3EmSZYkogSqjcd19XWiEp4n5RNRJT0KfkhES6hsxXo=
X-Received: by 2002:a50:fb10:: with SMTP id d16mr31093480edq.134.1597237777804;
 Wed, 12 Aug 2020 06:09:37 -0700 (PDT)
MIME-Version: 1.0
References: <1842689.1596468469@warthog.procyon.org.uk> <1845353.1596469795@warthog.procyon.org.uk>
 <CAJfpegunY3fuxh486x9ysKtXbhTE0745ZCVHcaqs9Gww9RV2CQ@mail.gmail.com>
 <ac1f5e3406abc0af4cd08d818fe920a202a67586.camel@themaw.net>
 <CAJfpegu8omNZ613tLgUY7ukLV131tt7owR+JJ346Kombt79N0A@mail.gmail.com>
 <CAJfpegtNP8rQSS4Z14Ja4x-TOnejdhDRTsmmDD-Cccy2pkfVVw@mail.gmail.com>
 <20200811135419.GA1263716@miu.piliscsaba.redhat.com> <CAHk-=wjzLmMRf=QG-n+1HnxWCx4KTQn9+OhVvUSJ=ZCQd6Y1WA@mail.gmail.com>
 <20200812101405.brquf7xxt2q22dd3@ws.net.home>
In-Reply-To: <20200812101405.brquf7xxt2q22dd3@ws.net.home>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Wed, 12 Aug 2020 15:09:26 +0200
Message-ID: <CAJfpegs4gzvJMBz=su8KgXXxX41tv8tVhO88Eap9pDeHRaSDPA@mail.gmail.com>
Subject: Re: file metadata via fs API (was: [GIT PULL] Filesystem Information)
To:     Karel Zak <kzak@redhat.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        David Howells <dhowells@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Jeff Layton <jlayton@redhat.com>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Nicolas Dichtel <nicolas.dichtel@6wind.com>,
        Christian Brauner <christian@brauner.io>,
        Lennart Poettering <lennart@poettering.net>,
        Linux API <linux-api@vger.kernel.org>,
        Ian Kent <raven@themaw.net>,
        LSM <linux-security-module@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Wed, Aug 12, 2020 at 12:14 PM Karel Zak <kzak@redhat.com> wrote:

> For example,  by fsinfo(FSINFO_ATTR_MOUNT_TOPOLOGY) you get all
> mountpoint propagation setting and relations by one syscall,

That's just an arbitrary grouping of attributes.

You said yourself, that what's really needed is e.g. consistent
snapshot of a complete mount tree topology.  And to get the complete
topology FSINFO_ATTR_MOUNT_TOPOLOGY and FSINFO_ATTR_MOUNT_CHILDREN are
needed for *each* individual mount.  The topology can obviously change
between those calls.

So there's no fundamental difference between getting individual
attributes or getting attribute groups in this respect.

> It would be also nice to avoid some strings formatting and separators
> like we use in the current mountinfo.

I think quoting non-printable is okay.

> I can imagine multiple values separated by binary header (like we already
> have for watch_notification, inotify, etc):

Adding a few generic binary interfaces is okay.   Adding many
specialized binary interfaces is a PITA.

Thanks,
Miklos
