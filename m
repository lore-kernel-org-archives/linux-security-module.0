Return-Path: <SRS0=85Tz=45=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E38D9C1975A
	for <linux-security-module@archiver.kernel.org>; Thu, 12 Mar 2020 16:25:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA4F02071C
	for <linux-security-module@archiver.kernel.org>; Thu, 12 Mar 2020 16:25:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584030310;
	bh=ddWJc/y1QKwNk/gZuKYYvjPwEwiqhkKFnnziYv4zvfk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=F6mVJmInMDtzR2u4KrQSAeHxWKtn8sTGjor4vzc/oOmtJqttQfq1ba/PKY4A4ax04
	 KY83g0BsAcfvCbzVj/p/Hrm9TbSnkHurLPb4B+SyJCJY3yRaSw00lDJZHvAJLnF/Vh
	 pAAOSGJ/rm2beH3aiHEIWocg3cAzAUxUjZGT1A2k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727474AbgCLQZJ (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 12 Mar 2020 12:25:09 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:34871 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727123AbgCLQZJ (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 12 Mar 2020 12:25:09 -0400
Received: by mail-lf1-f67.google.com with SMTP id v8so4420699lfe.2
        for <linux-security-module@vger.kernel.org>; Thu, 12 Mar 2020 09:25:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yWmhDJUXIQr81tj3eSt5MgpUhrk7gN9oxNOVOserS9E=;
        b=SLSsz7RVVX6b52ACz/JyPLLkZkcdatfCUWkrNphSGRxiTdH3i/0ZPWuxLZejrvrNCB
         aFQ0QGNvMrCZqvQ81uTwGrZDythrUJ4hlHcbAsrlg/62jd40y8byXiREO1aPKzcKDQnY
         TxyLyZdVZ/bL1I3pgBX8P/qMMqbm0kUimV1sA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yWmhDJUXIQr81tj3eSt5MgpUhrk7gN9oxNOVOserS9E=;
        b=FsYQv10VyakkKJAqx009PnHJYFrpSrjeBknAL9hSOp3wcdil9hqPoprQLBdJoopcEJ
         znIv155YnWRSCj6AlV6ldI5iyXJ55emnqcVUA/7yY0LDsfy3rWZyMxlBon8sHTg1R/g7
         zkjseqj4a1ZPXCnPV/2Ta9dNy7xveYG5EVzkQuwql+wjaIqM0L4L10suYqdcwz+gfmbv
         guAT/84JCum4GNerdZB+g8OJn/cdFNMbyj8vXe6R2GBUE5ocl6d+2cOdnsjtdIWN6+SR
         Ib70eMblEiUqeL3J1fzFdmezVPY7KV0xsgt+OQtWYzjjjU7g5XeTaa/fLpjMp+yEorIO
         5VUw==
X-Gm-Message-State: ANhLgQ1+AvXoLTTABiGHzRx71TrXDD4jXq9h1N6qgdyt4DrcaPk1r0Mh
        WcnXo//QA1FZsvH9g3UC1sSFUt7uSW8=
X-Google-Smtp-Source: ADFU+vtsHRCt9Yra8wOwgUMyzroiEy0l7VL/7yxPDO/Wj18mvKsrbkhWu9dmS90O4oEXaeaAUPmjYA==
X-Received: by 2002:ac2:4c18:: with SMTP id t24mr5788838lfq.54.1584030307283;
        Thu, 12 Mar 2020 09:25:07 -0700 (PDT)
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com. [209.85.167.44])
        by smtp.gmail.com with ESMTPSA id d12sm11617933lfi.86.2020.03.12.09.25.06
        for <linux-security-module@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Mar 2020 09:25:07 -0700 (PDT)
Received: by mail-lf1-f44.google.com with SMTP id j15so5365022lfk.6
        for <linux-security-module@vger.kernel.org>; Thu, 12 Mar 2020 09:25:06 -0700 (PDT)
X-Received: by 2002:a19:6144:: with SMTP id m4mr5637868lfk.192.1584030305566;
 Thu, 12 Mar 2020 09:25:05 -0700 (PDT)
MIME-Version: 1.0
References: <158376244589.344135.12925590041630631412.stgit@warthog.procyon.org.uk>
 <158376245699.344135.7522994074747336376.stgit@warthog.procyon.org.uk>
 <20200310005549.adrn3yf4mbljc5f6@yavin> <CAHk-=wiEBNFJ0_riJnpuUXTO7+_HByVo-R3pGoB_84qv3LzHxA@mail.gmail.com>
 <580352.1583825105@warthog.procyon.org.uk> <CAHk-=wiaL6zznNtCHKg6+MJuCqDxO=yVfms3qR9A0czjKuSSiA@mail.gmail.com>
 <3d209e29-e73d-23a6-5c6f-0267b1e669b6@samba.org>
In-Reply-To: <3d209e29-e73d-23a6-5c6f-0267b1e669b6@samba.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 12 Mar 2020 09:24:49 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgu3Wo_xcjXnwski7JZTwQFaMmKD0hoTZ=hqQv3-YojSg@mail.gmail.com>
Message-ID: <CAHk-=wgu3Wo_xcjXnwski7JZTwQFaMmKD0hoTZ=hqQv3-YojSg@mail.gmail.com>
Subject: Re: [PATCH 01/14] VFS: Add additional RESOLVE_* flags [ver #18]
To:     Stefan Metzmacher <metze@samba.org>
Cc:     David Howells <dhowells@redhat.com>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Al Viro <viro@zeniv.linux.org.uk>, Ian Kent <raven@themaw.net>,
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

On Thu, Mar 12, 2020 at 2:08 AM Stefan Metzmacher <metze@samba.org> wrote:
>
> The whole discussion was triggered by the introduction of a completely
> new fsinfo() call:
>
> Would you propose to have 'at_flags' and 'resolve_flags' passed in here?

Yes, I think that would be the way to go.

> > If we need linkat2() and friends, so be it. Do we?
>
> Yes, I'm going to propose something like this, as it would make the life
> much easier for Samba to have the new features available on all path
> based syscalls.

Will samba actually use them? I think we've had extensions before that
weren't worth the non-portability pain?

But yes, if we have a major package like samba use it, then by all
means let's add linkat2(). How many things are we talking about? We
have a number of system calls that do *not* take flags, but do do
pathname walking. I'm thinking things like "mkdirat()"?)

> In addition I'll propose to have a way to specify the source of
> removeat and unlinkat also by fd in addition to the the source parent fd
> and relative path, the reason are also to detect races of path
> recycling.

Would that be basically just an AT_EMPTY_PATH kind of thing? IOW,
you'd be able to remove a file by doing

   fd = open(path.., O_PATH);
   unlinkat(fd, "", AT_EMPTY_PATH);

Hmm. We have _not_ allowed filesystem changes without that last
component lookup. Of course, with our dentry model, we *can* do it,
but this smells fairly fundamental to me.

It might avoid some of the extra system calls (ie you could use
openat2() to do the path walking part, and then
unlinkat(AT_EMPTY_PATH) to remove it, and have a "fstat()" etc in
between the verify that it's the right type of file or whatever - and
you'd not need an unlinkat2() with resolve flags).

I think Al needs to ok this kind of change. Maybe you've already
discussed it with him and I just missed it.

            Linus
