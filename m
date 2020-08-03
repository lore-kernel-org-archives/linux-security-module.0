Return-Path: <SRS0=Dl7R=BN=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B31A6C433E1
	for <linux-security-module@archiver.kernel.org>; Mon,  3 Aug 2020 11:17:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 92F2B20719
	for <linux-security-module@archiver.kernel.org>; Mon,  3 Aug 2020 11:17:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="eoVrCN0P"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726300AbgHCLRX (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 3 Aug 2020 07:17:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726058AbgHCLRU (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 3 Aug 2020 07:17:20 -0400
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4986C06179F
        for <linux-security-module@vger.kernel.org>; Mon,  3 Aug 2020 04:17:19 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id m20so17440932eds.2
        for <linux-security-module@vger.kernel.org>; Mon, 03 Aug 2020 04:17:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=phUao9tXf/t4b/68S+2rq16ySbBLGNbfI2sRyl9fmdU=;
        b=eoVrCN0PZZ1JS+F3fakDr2Ij8wISyKSGPN0lWQaGRrdbv1WtI1HXeY2zQorKnB7Bi0
         VRrysLvCQG2nw4yx00kjhBBvbRQCdLC+pMBHaFd4x+oUq5/iuV61KNUXUtmKl/01yaYQ
         K72k3pKjdfjjKvewHfPgkAHJIvr563YyPdSN8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=phUao9tXf/t4b/68S+2rq16ySbBLGNbfI2sRyl9fmdU=;
        b=MQvnmkqhsoKy63NZIzjEzthJ5Kdb1cM/trMH7wEeXSc04BvklR0KiJ+SB49HN4A/ie
         Lkc1fqo9Yjm+Jfws31UalWmEzQ8gYTrrxWL5C96xDg6I6KOhRTV2RD5qQbhurtIpKpMB
         GnxEBUJ7qAiaZaLIAvtHUoLKBWQKcdxer4CbOrEJlR7zo9fD4490cBcIOyPXwEeG3uT6
         nl0/VNQtkcvGzzLaGyxO1GQo0r7JNGNeN4W+pLnqpztHzgiUtElSgqQuQNs+7EOf+cHT
         anFPPqAEmlaG51IcO2QGARB4iBM0eqpYY46OOQWjaSTZuSJgBMm+72ci8nmTMOeqtVol
         178w==
X-Gm-Message-State: AOAM533G6Ii7ytAhKxamtcy1VesG8r5RNNOSoVXaCCt21HK//w6GDBM0
        yrLlzeBKpqAWlzy7jQz9wtUUeRcy8lR8A1asgrHD2w==
X-Google-Smtp-Source: ABdhPJzYkpExpfofwOysvG0SUfDHJUUcNoJnQSIchQHGMGBM9qKDjKahkgN9Xb26C1GwbhowgmIILXMGk8ZjU9gsAgI=
X-Received: by 2002:a05:6402:13d4:: with SMTP id a20mr303427edx.161.1596453438170;
 Mon, 03 Aug 2020 04:17:18 -0700 (PDT)
MIME-Version: 1.0
References: <1293241.1595501326@warthog.procyon.org.uk> <CAJfpegspWA6oUtdcYvYF=3fij=Bnq03b8VMbU9RNMKc+zzjbag@mail.gmail.com>
 <158454378820.2863966.10496767254293183123.stgit@warthog.procyon.org.uk>
 <158454391302.2863966.1884682840541676280.stgit@warthog.procyon.org.uk>
 <2003787.1595585999@warthog.procyon.org.uk> <865566fb800a014868a9a7e36a00a14430efb11e.camel@themaw.net>
 <2023286.1595590563@warthog.procyon.org.uk> <CAJfpegsT_3YqHPWCZGX7Lr+sE0NVmczWz5L6cN8CzsVz4YKLCQ@mail.gmail.com>
 <1283475.1596449889@warthog.procyon.org.uk>
In-Reply-To: <1283475.1596449889@warthog.procyon.org.uk>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Mon, 3 Aug 2020 13:17:06 +0200
Message-ID: <CAJfpeguO8Qwkzx9zfGVT7W+pT5p6fgj-_8oJqJbXX_KQBpLLEQ@mail.gmail.com>
Subject: Re: [PATCH 13/17] watch_queue: Implement mount topology and attribute
 change notifications [ver #5]
To:     David Howells <dhowells@redhat.com>
Cc:     Ian Kent <raven@themaw.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Nicolas Dichtel <nicolas.dichtel@6wind.com>,
        Christian Brauner <christian@brauner.io>, andres@anarazel.de,
        Jeff Layton <jlayton@redhat.com>, dray@redhat.com,
        Karel Zak <kzak@redhat.com>, keyrings@vger.kernel.org,
        Linux API <linux-api@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org,
        LSM <linux-security-module@vger.kernel.org>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Mon, Aug 3, 2020 at 12:18 PM David Howells <dhowells@redhat.com> wrote:
>
> Miklos Szeredi <miklos@szeredi.hu> wrote:
>
> > > fsinfo() then allows you to retrieve them by path or by mount ID.
> >
> > Shouldn't the notification interface provide the unique ID?
>
> Hmmm...  If I'm going to do that, I have to put the fsinfo-core branch first
> otherwise you can't actually retrieve the unique ID - and thus won't be able
> to make sense of the notification record.  Such a rearrangement might make
> sense anyway since Ian and Karel have been primarily concentrating on fsinfo
> and only more recently started adding notification support.

OTOH mount notification is way smaller and IMO a more mature
interface.  So just picking the unique ID patch into this set might
make sense.

Thanks,
Miklos
