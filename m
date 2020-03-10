Return-Path: <SRS0=JkyI=43=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 351A7C10F27
	for <linux-security-module@archiver.kernel.org>; Tue, 10 Mar 2020 01:14:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0772C24649
	for <linux-security-module@archiver.kernel.org>; Tue, 10 Mar 2020 01:14:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583802867;
	bh=u9kUqBJzwaMl1xWmNDrHnhfCq3UF0EHAoU/xNxKwn0g=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=sHTfmvfQpJtLH+yWTB5d1v+QPoY5prCdDlXjeh0zup+4wDGeKqMFJ+37jYhkJNeCD
	 XpqjEfwTSyejyMMxrG+c0ng0f/gZJIBUa4LuhGJeNWYqDiemaLcPkVHNefM3YWWEHL
	 T/ijHtTZEdJg+IcTiOFuXN4SEID5/jC43yd5gpuw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726486AbgCJBO0 (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 9 Mar 2020 21:14:26 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:35843 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726265AbgCJBOV (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 9 Mar 2020 21:14:21 -0400
Received: by mail-lj1-f194.google.com with SMTP id n20so9162896ljg.3
        for <linux-security-module@vger.kernel.org>; Mon, 09 Mar 2020 18:14:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nCY2IMHfivjHreZOPal2MmhDh1XB1BJ/jVXGh7sofMY=;
        b=dttz1Aai8q2mA5120RQHpU6FQZ0oWB6GoxZWjBIoKe7rJ6/0ECieO/iRN6XUsDDmpY
         P8ZM/s3EiQ2yKP5NbwrdbruCnctvDp6KQ/31+Dn7/6XLJ6IfHlJYcxNGPxHn1UbBU0iV
         LA0J4YsQpHP85wdc4zfWiUV0qC/skOAfeo6iw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nCY2IMHfivjHreZOPal2MmhDh1XB1BJ/jVXGh7sofMY=;
        b=QyLqFcszlI23DlG4iZdblESVLfLDl+ogcsDfI3lhGL/3jzu63At7QqIOdENuE4GbiK
         RUxcf9IFB6Sq/7IFqpHN6309thQFDL7upforTbn3XHkrK1O7aaGtHj85XMDBrgptTEu9
         IDMjyK2JrGwGA9AT+i6VKAPdOQLQOdTKDxbyp5dTIvHrfUnFe6assxVnA6/3GLoRjabV
         0avhF08uxG4f4JCl0vuTtasO5Y3koXq4kcAaqL7kEZ2wxed8RDPQJgbx/OObzEkVj19G
         LuL0CED1dtwaOIcAFG4n1c2FTIqlJVTV8tsL8JwwKEmBZJhepX7MytcoeGOlHrE/N+RW
         NtzA==
X-Gm-Message-State: ANhLgQ0yPypvxamvvqFFwHBuK/kB++8Z+eLDIKuatywADZC0rTFdJEyA
        6GiNMIIe3HxqrCzrAjSIm1gyRlPEHOQ=
X-Google-Smtp-Source: ADFU+vtYG0MhPT7kr68QQDt0/9I70bg5bLBSyOKrF92NQPSNu6fc6z61VKBmtRKeR9PWz4SvhTcSGQ==
X-Received: by 2002:a2e:b5c3:: with SMTP id g3mr5056700ljn.151.1583802858422;
        Mon, 09 Mar 2020 18:14:18 -0700 (PDT)
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com. [209.85.167.50])
        by smtp.gmail.com with ESMTPSA id u15sm127901lju.14.2020.03.09.18.14.16
        for <linux-security-module@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Mar 2020 18:14:17 -0700 (PDT)
Received: by mail-lf1-f50.google.com with SMTP id c20so9479541lfb.0
        for <linux-security-module@vger.kernel.org>; Mon, 09 Mar 2020 18:14:16 -0700 (PDT)
X-Received: by 2002:a19:520a:: with SMTP id m10mr11117505lfb.30.1583802856199;
 Mon, 09 Mar 2020 18:14:16 -0700 (PDT)
MIME-Version: 1.0
References: <158376244589.344135.12925590041630631412.stgit@warthog.procyon.org.uk>
 <158376245699.344135.7522994074747336376.stgit@warthog.procyon.org.uk> <20200310005549.adrn3yf4mbljc5f6@yavin>
In-Reply-To: <20200310005549.adrn3yf4mbljc5f6@yavin>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 9 Mar 2020 18:14:00 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiEBNFJ0_riJnpuUXTO7+_HByVo-R3pGoB_84qv3LzHxA@mail.gmail.com>
Message-ID: <CAHk-=wiEBNFJ0_riJnpuUXTO7+_HByVo-R3pGoB_84qv3LzHxA@mail.gmail.com>
Subject: Re: [PATCH 01/14] VFS: Add additional RESOLVE_* flags [ver #18]
To:     Aleksa Sarai <cyphar@cyphar.com>
Cc:     David Howells <dhowells@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Stefan Metzmacher <metze@samba.org>,
        Ian Kent <raven@themaw.net>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Christian Brauner <christian@brauner.io>,
        Jann Horn <jannh@google.com>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Karel Zak <kzak@redhat.com>, jlayton@redhat.com,
        Linux API <linux-api@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Mon, Mar 9, 2020 at 5:56 PM Aleksa Sarai <cyphar@cyphar.com> wrote:
>
> On 2020-03-09, David Howells <dhowells@redhat.com> wrote:
> > This is necessary for fsinfo() to use RESOLVE_* flags instead of AT_* flags
> > if the latter are to be considered deprecated for new system calls.
> >
> > Also make openat2() handle RESOLVE_NO_TRAILING_SYMLINKS.

No, please let's not do this.

We have O_NOFOLLOW, and we can't get rid of it.

So adding RESOLVE_NO_TRAILING_SYMLINKS isn't a cleanup. It's just
extra complexity for absolutely zero gain.


> After thinking about what Christian said some more, I reckon we
> shouldn't support both O_NOFOLLOW and RESOLVE_NO_TRAILING_SYMLINKS. But
> that means we'll need to cherry-pick this patch and get it into mainline
> before v5.6.

No.

It simply means that we shouldn't have RESOLVE_NO_TRAILING_SYMLINKS at all.

Adding that flag is a mistake. It causes problems like this, where
subtlenly people say "what if both flags are set".

Just don't do it.

There's no way in hell we can ever get rid of O_NOFOLLOW anyway, since
people will continue to use plain open() and openat().

So adding RESOLVE_NO_TRAILING_SYMLINKS is entirely redundant.

Don't deprecate the old flags that are going to always stay around,
don't add stupid new flags that add no value.

It's that easy.

              Linus
