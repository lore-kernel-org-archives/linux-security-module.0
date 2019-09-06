Return-Path: <SRS0=Mc7W=XB=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4549AC43331
	for <linux-security-module@archiver.kernel.org>; Fri,  6 Sep 2019 15:53:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19808214DE
	for <linux-security-module@archiver.kernel.org>; Fri,  6 Sep 2019 15:53:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567785210;
	bh=mpgGkKCrnRxhITt5MelQZFoxgsQdwiTo40PnPEOkVf8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=tFd9G4LpvmzZer5X8XlFycVZdnpDuFcIdGM2ooOuUXVRJap3ggpxBSh/6mtVbG60G
	 kFmZ6P1upg3sLkgcw5TKzIFLZAg5bz76Kgef/+Bt2x+Ji8vKUj32YQ0GNqDJp1gghb
	 Rcgv9MuUIyVGsrMPtlyKQVw/TepCq5q/IxsNGpBo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390811AbfIFPx3 (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 6 Sep 2019 11:53:29 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:45140 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728485AbfIFPx3 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 6 Sep 2019 11:53:29 -0400
Received: by mail-lj1-f194.google.com with SMTP id l1so6428329lji.12
        for <linux-security-module@vger.kernel.org>; Fri, 06 Sep 2019 08:53:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SLIGvVtM1MWun0WWtqWDQtU9G8VMp6qsOxjP6sOjf2I=;
        b=Ia8xZ4G7EXG0h3CEDdsSAnGPbD1nnF6pet2NWhAAqHOXPjQLBhaQh07F0TSGTC2pQA
         4aORuaabR+7VQbbIPbEwZhlj4N84fOFkTe7F+AH5iR91RRW0/A+v490l9anWhBNdAZMu
         chcmmRDkVHmVtn5FD+klXo/q67grBESatc/HU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SLIGvVtM1MWun0WWtqWDQtU9G8VMp6qsOxjP6sOjf2I=;
        b=ZAHqNRA4nUTzJJEGpeqRz9y+SlWVJyMknwwZkmDeW0ulHWesDjHOGNSH6Nc7YfA2xf
         kKrDmcQovAzQn3Eypf+gdO7fElpbHXyop/XZHDn/woJnyITW2QDCrd9qHg/BL/DJXTb1
         dWjQA0VDzAk+ZFJGEnJyG5xKLZSalXQignHdISIQS4EaqRsV3InjzkdlscMYGDBHScGV
         WiMAtBvg3rFRwKWL4jtaLEXmnx+9YZmKBgJZAX5K6Ew7mLRQabZs5mF/hjVvxWZze0Of
         RGTQVfhngv8nWtfJhIjhwmf7dF/TS+Sj/Hg5uECEn74WW3VtCe4lJi/qsl0U6aBDubco
         waiA==
X-Gm-Message-State: APjAAAWDBdfIiYDd3I0ZbnIEA7V6D19kd0C1B6BdQkQ/z9zk0NdnO6oU
        64CING431tTiPXMSloJHUDv5Tlrt8og=
X-Google-Smtp-Source: APXvYqxkWDLbKodOLr+Nd2Q1EWQSPhD/PATTHy5pz29aU61NRqBMavvLTBeKP0jgIxyds+wtAKIl6Q==
X-Received: by 2002:a2e:9104:: with SMTP id m4mr6147129ljg.28.1567785206667;
        Fri, 06 Sep 2019 08:53:26 -0700 (PDT)
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com. [209.85.208.172])
        by smtp.gmail.com with ESMTPSA id z9sm991972ljn.78.2019.09.06.08.53.25
        for <linux-security-module@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Sep 2019 08:53:25 -0700 (PDT)
Received: by mail-lj1-f172.google.com with SMTP id y23so6126968ljn.5
        for <linux-security-module@vger.kernel.org>; Fri, 06 Sep 2019 08:53:25 -0700 (PDT)
X-Received: by 2002:a2e:814d:: with SMTP id t13mr6334227ljg.72.1567785205260;
 Fri, 06 Sep 2019 08:53:25 -0700 (PDT)
MIME-Version: 1.0
References: <156763534546.18676.3530557439501101639.stgit@warthog.procyon.org.uk>
 <CAHk-=wh5ZNE9pBwrnr5MX3iqkUP4nspz17rtozrSxs5-OGygNw@mail.gmail.com>
 <17703.1567702907@warthog.procyon.org.uk> <CAHk-=wjQ5Fpv0D7rxX0W=obx9xoOAxJ_Cr+pGCYOAi2S9FiCNg@mail.gmail.com>
 <CAKCoTu7ms_Mr-q08d9XB3uascpzwBa5LF9JTT2aq8uUsoFE8aQ@mail.gmail.com>
 <CAHk-=wjcsxQ8QB_v=cwBQw4pkJg7pp-bBsdWyPivFO_OeF-y+g@mail.gmail.com>
 <5396.1567719164@warthog.procyon.org.uk> <CAHk-=wgbCXea1a9OTWgMMvcsCGGiNiPp+ty-edZrBWn63NCYdw@mail.gmail.com>
 <14883.1567725508@warthog.procyon.org.uk> <CAHk-=wjt2Eb+yEDOcQwCa0SrZ4cWu967OtQG8Vz21c=n5ZP1Nw@mail.gmail.com>
 <27732.1567764557@warthog.procyon.org.uk> <CAHk-=wiR1fpahgKuxSOQY6OfgjWD+MKz8UF6qUQ6V_y2TC_V6w@mail.gmail.com>
In-Reply-To: <CAHk-=wiR1fpahgKuxSOQY6OfgjWD+MKz8UF6qUQ6V_y2TC_V6w@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 6 Sep 2019 08:53:09 -0700
X-Gmail-Original-Message-ID: <CAHk-=wioHmz69394xKRqFkhK8si86P_704KgcwjKxawLAYAiug@mail.gmail.com>
Message-ID: <CAHk-=wioHmz69394xKRqFkhK8si86P_704KgcwjKxawLAYAiug@mail.gmail.com>
Subject: Re: Why add the general notification queue and its sources
To:     David Howells <dhowells@redhat.com>
Cc:     Ray Strode <rstrode@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Steven Whitehouse <swhiteho@redhat.com>,
        Nicolas Dichtel <nicolas.dichtel@6wind.com>, raven@themaw.net,
        keyrings@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-block <linux-block@vger.kernel.org>,
        Christian Brauner <christian@brauner.io>,
        LSM List <linux-security-module@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        "Ray, Debarshi" <debarshi.ray@gmail.com>,
        Robbie Harwood <rharwood@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Fri, Sep 6, 2019 at 8:35 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> This is why I like pipes. You can use them today. They are simple, and
> extensible, and you don't need to come up with a new subsystem and
> some untested ad-hoc thing that nobody has actually used.

The only _real_ complexity is to make sure that events are reliably parseable.

That's where you really want to use the Linux-only "packet pipe"
thing, becasue otherwise you have to have size markers or other things
to delineate events. But if you do that, then it really becomes
trivial.

And I checked, we made it available to user space, even if the
original reason for that code was kernel-only autofs use: you just
need to make the pipe be O_DIRECT.

This overly stupid program shows off the feature:

        #define _GNU_SOURCE
        #include <fcntl.h>
        #include <unistd.h>

        int main(int argc, char **argv)
        {
                int fd[2];
                char buf[10];

                pipe2(fd, O_DIRECT | O_NONBLOCK);
                write(fd[1], "hello", 5);
                write(fd[1], "hi", 2);
                read(fd[0], buf, sizeof(buf));
                read(fd[0], buf, sizeof(buf));
                return 0;
        }

and it you strace it (because I was too lazy to add error handling or
printing of results), you'll see

    write(4, "hello", 5)                    = 5
    write(4, "hi", 2)                       = 2
    read(3, "hello", 10)                    = 5
    read(3, "hi", 10)                       = 2

note how you got packets of data on the reader side, instead of
getting the traditional "just buffer it as a stream".

So now you can even have multiple readers of the same event pipe, and
packetization is obvious and trivial. Of course, I'm not sure why
you'd want to have multiple readers, and you'd lose _ordering_, but if
all events are independent, this _might_ be a useful thing in a
threaded environment. Maybe.

(Side note: a zero-sized write will not cause a zero-sized packet. It
will just be dropped).

               Linus
