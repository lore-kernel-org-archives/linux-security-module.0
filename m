Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4650CD13D2
	for <linux-security-module@archiver.kernel.org>; Sun, 17 Sep 2023 14:33:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235553AbjIQOdX (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Sun, 17 Sep 2023 10:33:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233530AbjIQOdD (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Sun, 17 Sep 2023 10:33:03 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AEFD127
        for <linux-security-module@vger.kernel.org>; Sun, 17 Sep 2023 07:32:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1694961137;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fd2SQIw5RGzEP/oFXtTGteoLvZh3GLziCsZTny7nBwk=;
        b=ZFqR+lPmrapQIkgyMFKtHKBeMD3Yvr1lkidi5ty2TPWApuzRdWoo6/TbVHlkKwulWJS00x
        noPZs+AOieN4yUSYFE/rMdyZ5Rp2yfpthaoJO7QFSXqUOA0tYlDtqDDXzLHE7fNMP4vRNo
        KyVcC/orrALqtJtsBLDx50Rowc9HDaA=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-541-cDo0ZLIXOWSdGl5pB_0bLw-1; Sun, 17 Sep 2023 10:32:16 -0400
X-MC-Unique: cDo0ZLIXOWSdGl5pB_0bLw-1
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-27489394741so2075264a91.1
        for <linux-security-module@vger.kernel.org>; Sun, 17 Sep 2023 07:32:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694961135; x=1695565935;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fd2SQIw5RGzEP/oFXtTGteoLvZh3GLziCsZTny7nBwk=;
        b=Op6uW4nTBkwXS7S07FwKM6VNp/pQagNBsPkAGmZJpJKdt9ToqLKrNKPgCLS90cUFpA
         DjEuYW2COTOuiOW5UOcU0Je3Ys55FHULL0UiGFdY723VBB3YKdPMQgDNKi+kcJ+bYNM3
         Ze/kHrbr9luselw28yZDiLpx7E1i6IvnhDkUuDxwaUlpLbzo69yVGb/EGAWWpJbTld3m
         H3NHsAoAjxvf7nrt0p0HMXqDO4/3L+mboFfhhmT6ziR1GKUZFU0zvjPbm704rSJi6O7w
         ExNbvLUwF6Rmn0j5ADQ2E38IyDfTtsMJ0HYCDVCg26WfoyFhUcyErOuR4DtbpWMzmtN5
         jofg==
X-Gm-Message-State: AOJu0YzcEqpEWkaMWCX6XzAhv5zbtDPed207J60IUy4ihb2Z6MJwtYAz
        uDIvCDYjP9VNDxviL++JItUIXlE1xx/joW09aqO+HOTXdAdzjxCrgxXrkim7dshfFUyh/jS379v
        4mHxfTY4loPq4m0sruiiUPmyJ5t7g9UoPQ0bQ5JtIhiipf0Aa/2ER
X-Received: by 2002:a17:90a:31c9:b0:25e:d727:6fb4 with SMTP id j9-20020a17090a31c900b0025ed7276fb4mr4479061pjf.2.1694961135576;
        Sun, 17 Sep 2023 07:32:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHxaKD5CAfPDp+ptbao2NQtHRlf3cdqB0MlFwsD5D8HxKapmYDbW+OyM4JgBC0g1lRVqg8MaST0ACrIZLk6h88=
X-Received: by 2002:a17:90a:31c9:b0:25e:d727:6fb4 with SMTP id
 j9-20020a17090a31c900b0025ed7276fb4mr4479048pjf.2.1694961135300; Sun, 17 Sep
 2023 07:32:15 -0700 (PDT)
MIME-Version: 1.0
References: <20230913152238.905247-1-mszeredi@redhat.com> <20230913152238.905247-4-mszeredi@redhat.com>
 <20230917005419.397938-1-mattlloydhouse@gmail.com>
In-Reply-To: <20230917005419.397938-1-mattlloydhouse@gmail.com>
From:   Miklos Szeredi <mszeredi@redhat.com>
Date:   Sun, 17 Sep 2023 16:32:04 +0200
Message-ID: <CAOssrKcECS_CvifP1vMM8YOyMW7dkGXTDTKY2CRr-fPrJk76ZA@mail.gmail.com>
Subject: Re: [RFC PATCH 3/3] add listmnt(2) syscall
To:     Matthew House <mattlloydhouse@gmail.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, linux-man@vger.kernel.org,
        linux-security-module@vger.kernel.org, Karel Zak <kzak@redhat.com>,
        Ian Kent <raven@themaw.net>,
        David Howells <dhowells@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <christian@brauner.io>,
        Amir Goldstein <amir73il@gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Sun, Sep 17, 2023 at 2:54=E2=80=AFAM Matthew House <mattlloydhouse@gmail=
.com> wrote:

> > +       list_for_each_entry(r, &m->mnt_mounts, mnt_child) {
> > +               if (!capable(CAP_SYS_ADMIN) &&
> > +                   !is_path_reachable(r, r->mnt.mnt_root, root))
> > +                       continue;
>
> I'm not an expert on the kernel API, but to my eyes, it looks a bit weird
> to silently include or exclude unreachable mounts from the list based on
> the result of a capability check. I'd normally expect a more explicit
> design, where (e.g.) the caller would set a flag to request unreachable
> mounts, then get an -EPERM back if it didn't have the capability, as
> opposed to this design, where the meaning of the output ("all mounts" vs.
> "all reachable mounts") changes implicitly depending on the caller. Is
> there any precedent for a design like this, where inaccessible results
> are silently omitted from a returned list?

Good point.  That issue was nagging at the back of my mind.  Having an
explicit flag nicely solves the issue.

Thanks,
Miklos

