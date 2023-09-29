Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D150E743FE
	for <linux-security-module@archiver.kernel.org>; Fri, 29 Sep 2023 09:10:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232883AbjI2JKW (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 29 Sep 2023 05:10:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232841AbjI2JKV (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 29 Sep 2023 05:10:21 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85B441AC
        for <linux-security-module@vger.kernel.org>; Fri, 29 Sep 2023 02:10:18 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id 4fb4d7f45d1cf-51e28cac164so937461a12.1
        for <linux-security-module@vger.kernel.org>; Fri, 29 Sep 2023 02:10:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1695978617; x=1696583417; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=MH8m71qOsOYfTIlYbU2nLX0qZUlnksErh8AJml6gZsI=;
        b=HJa/qFiCw51SAap8KA07eiWOzu4mdOeM9uhYqpP8HamJ2luEkNucgYbCSz2HYdLdbF
         8sDc6a/3t1lwM4q7dOFO/fWzTTGb8RsO2yms0QUWnyQvW79xkf/LcOeufbFK+dw4CLiV
         uzSEmbU/9ohgC4/8tCdblnqJ21HK+xWQu902o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695978617; x=1696583417;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MH8m71qOsOYfTIlYbU2nLX0qZUlnksErh8AJml6gZsI=;
        b=a4CiH32cqhq3vRzr2K7a1tobhE5FmINni5WeYj70iOuCdKHFxtm+uXhA9BApPdB7ky
         CcKNgy6ulrwHqGbxXY7uUzg33rcfC4420SKMXYm5F0lVrvXD8mZEpRa/6EyoIveR+P1E
         qPmINKQ+1ze4yntZ6fA5oPvKOTDvadLG65gg2iU1yaKfxcw9xfUKnC/QSA8LHlmTvq3a
         5QFKzwmJ3Y5TgMyNkMYjcWagdTzc85YInAP+mlh34ycWM6mH8rL9YB4XszJ0pp0VPsMN
         9d9VkaUNMDkvyVUMg1Np5/2/73s4xxbGAG6amTP55ZBDkn9uxJP7f0iphpptEbK7mwP3
         sO2Q==
X-Gm-Message-State: AOJu0YzSgmFa2IxPu6J75YSsAke3qoz36x1SbTBbrEP4wwjzQ7AF/btB
        +soygGungzn1J6p+yVFODdcRSia802c+CJO0MSmG2Q==
X-Google-Smtp-Source: AGHT+IHyl6jYqyOZcL8xPT3WtxUI5NbSnwKiR15P3UdBiaJSeqGvThML8eIxVJXSU+59W1w0fIIWjZ8R6AqpiVy0hmU=
X-Received: by 2002:a17:907:1def:b0:9a9:e71b:cd65 with SMTP id
 og47-20020a1709071def00b009a9e71bcd65mr3433801ejc.6.1695978616584; Fri, 29
 Sep 2023 02:10:16 -0700 (PDT)
MIME-Version: 1.0
References: <20230928130147.564503-1-mszeredi@redhat.com> <20230928130147.564503-4-mszeredi@redhat.com>
 <5787bac5-b368-485a-f906-44e7049d4b8f@themaw.net>
In-Reply-To: <5787bac5-b368-485a-f906-44e7049d4b8f@themaw.net>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Fri, 29 Sep 2023 11:10:04 +0200
Message-ID: <CAJfpegt80_Tyto3QyD48V_yzHSghqg8AC_OPHEMPkDjEYCcisQ@mail.gmail.com>
Subject: Re: [PATCH v3 3/4] add statmount(2) syscall
To:     Ian Kent <raven@themaw.net>
Cc:     Miklos Szeredi <mszeredi@redhat.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, linux-man@vger.kernel.org,
        linux-security-module@vger.kernel.org, Karel Zak <kzak@redhat.com>,
        David Howells <dhowells@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <christian@brauner.io>,
        Amir Goldstein <amir73il@gmail.com>,
        Matthew House <mattlloydhouse@gmail.com>,
        Florian Weimer <fweimer@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Fri, 29 Sept 2023 at 02:42, Ian Kent <raven@themaw.net> wrote:
>
> On 28/9/23 21:01, Miklos Szeredi wrote:

> > +static struct vfsmount *lookup_mnt_in_ns(u64 id, struct mnt_namespace *ns)
> > +{
> > +     struct mount *mnt;
> > +     struct vfsmount *res = NULL;
> > +
> > +     lock_ns_list(ns);
> > +     list_for_each_entry(mnt, &ns->list, mnt_list) {
> > +             if (!mnt_is_cursor(mnt) && id == mnt->mnt_id_unique) {
> > +                     res = &mnt->mnt;
> > +                     break;
> > +             }
> > +     }
> > +     unlock_ns_list(ns);
> > +     return res;
> > +}
>
> Seems like we might need to consider making (struct mnt_namespace)->list
>
> a hashed list.

Yes, linear search needs to go.  A hash table is probably the easiest solution.

But I'd also consider replacing ns->list with an rbtree.  Not as
trivial as adding a system hash table and probably also slightly
slower, but it would have some advantages:

 - most space efficient (no overhead of hash buckets)

 - cursor can go away (f_pos can just contain last ID)

Thanks,
Miklos
