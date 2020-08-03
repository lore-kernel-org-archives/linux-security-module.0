Return-Path: <SRS0=Dl7R=BN=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2291C433E0
	for <linux-security-module@archiver.kernel.org>; Mon,  3 Aug 2020 10:02:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7457D2068F
	for <linux-security-module@archiver.kernel.org>; Mon,  3 Aug 2020 10:02:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="RpfQtFsH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726579AbgHCKCh (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 3 Aug 2020 06:02:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726534AbgHCKCb (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 3 Aug 2020 06:02:31 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8ABB4C06179F
        for <linux-security-module@vger.kernel.org>; Mon,  3 Aug 2020 03:02:31 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id d6so24150010ejr.5
        for <linux-security-module@vger.kernel.org>; Mon, 03 Aug 2020 03:02:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Vsw86Ioh4FX2LjY9IRNgVl3ySN874HqeJp7Mv8isep4=;
        b=RpfQtFsHlbz8r366bIDazEG7v/rOLrIkoCqHg8rE2DUKq52Z8mwzP137tJ/5s7tPUj
         VLb1iezTLNPzIJG1c0Pkm89UBzyKPJeX6JGIivqYWsnaSCB6ZaglPy5t0gDZQCPFTCU7
         8llZA5AlGWWNzDr8tBx5EpJDGB/QTw7bpfPc8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Vsw86Ioh4FX2LjY9IRNgVl3ySN874HqeJp7Mv8isep4=;
        b=aMyz4YxLFN5vj7KDugpZhU8+9VV1QJW1iyFMGYCYzNm32D5B+IN8iA7hmsjSt6d6SZ
         MHCgUM542d//DxN2JOTdrp/ff7bFUc2eJiDiFdqRLXXn/Tl+obNwws1Z7Rbg5F6CGyXB
         IZhBC1vVFyFCDGBSYcZhoGKr6Pihj3b3cfLHJKwM65MRDBZjCPJjVJuCoG9IatEYHKaU
         g+cLY7mQJpSMWzeMFueBoPtttzpAEIyj/sptz/Ohdf7PKy9sfyqVPhsXXUu3T14kTuux
         DSKqSjVKKgUne4O7qdkvLKvSgxWQ+DYoZzfPXWT/NdZ2K6RF47fr+4C11ThMoiEdfmAQ
         VDkw==
X-Gm-Message-State: AOAM531i9i2tcXy05M6rwU0SXG6zw/qfo5dfidq/SmRrw+eWh8ptt7HA
        EdU1rSFf+osmbHi0rC9iFlVcsXfQwIeuGT0QZ1wTXw==
X-Google-Smtp-Source: ABdhPJyBZEAYQ6WLR1Z0AfPVD+Khagrgtzu1YRtwovnq6WreKbtRGY02vgjzms1nTRrPans2kaPI2wtS5NWP0loHJ+k=
X-Received: by 2002:a17:906:4c46:: with SMTP id d6mr16814326ejw.14.1596448949388;
 Mon, 03 Aug 2020 03:02:29 -0700 (PDT)
MIME-Version: 1.0
References: <1293241.1595501326@warthog.procyon.org.uk> <CAJfpegspWA6oUtdcYvYF=3fij=Bnq03b8VMbU9RNMKc+zzjbag@mail.gmail.com>
 <158454378820.2863966.10496767254293183123.stgit@warthog.procyon.org.uk>
 <158454391302.2863966.1884682840541676280.stgit@warthog.procyon.org.uk>
 <2003787.1595585999@warthog.procyon.org.uk> <865566fb800a014868a9a7e36a00a14430efb11e.camel@themaw.net>
 <2023286.1595590563@warthog.procyon.org.uk>
In-Reply-To: <2023286.1595590563@warthog.procyon.org.uk>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Mon, 3 Aug 2020 12:02:18 +0200
Message-ID: <CAJfpegsT_3YqHPWCZGX7Lr+sE0NVmczWz5L6cN8CzsVz4YKLCQ@mail.gmail.com>
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

On Fri, Jul 24, 2020 at 1:36 PM David Howells <dhowells@redhat.com> wrote:
>
> Ian Kent <raven@themaw.net> wrote:
>
> > I was wondering about id re-use.
> >
> > Assuming that ids that are returned to the idr db are re-used
> > what would the chance that a recently used id would end up
> > being used?
> >
> > Would that chance increase as ids are consumed and freed over
> > time?
>
> I've added something to deal with that in the fsinfo branch.  I've given each
> mount object and superblock a supplementary 64-bit unique ID that's not likely
> to repeat before we're no longer around to have to worry about it.
>
> fsinfo() then allows you to retrieve them by path or by mount ID.

Shouldn't the notification interface provide the unique ID?

Thanks,
Miklos

>
> So, yes, mnt_id and s_dev are not unique and may be reused very quickly, but
> I'm also providing uniquifiers that you can check.
>
> David
>
