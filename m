Return-Path: <SRS0=Mc7W=XB=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0306BC43331
	for <linux-security-module@archiver.kernel.org>; Fri,  6 Sep 2019 17:15:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7B5C206A5
	for <linux-security-module@archiver.kernel.org>; Fri,  6 Sep 2019 17:15:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567790156;
	bh=HHQWMX/RVYod409nhseiVQqsQ+InudwbsY3vud7WzqU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=UD+NFsXMT5nSAY+MPX8MvCReNc6eALQD4RbG+9SiqcKqpcfDmK3Ke0NDK2FTId2j7
	 jPirGEAKO9SO1NeqnUVe+cO7FMBH9rQAyko8pVJYntr4mPpFSNBTq/WEj9pE/KFiqe
	 ny0nZzmwHP/0euN72V8L4ASb0qh7B/Ow0Xtu/ftA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391743AbfIFRP4 (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 6 Sep 2019 13:15:56 -0400
Received: from mail-lj1-f176.google.com ([209.85.208.176]:44257 "EHLO
        mail-lj1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732540AbfIFRP4 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 6 Sep 2019 13:15:56 -0400
Received: by mail-lj1-f176.google.com with SMTP id u14so6667496ljj.11
        for <linux-security-module@vger.kernel.org>; Fri, 06 Sep 2019 10:15:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=px6LlxUmzkx1m0e18cjKznO/fFTclAviZPrgSZRKBVI=;
        b=MCWoYx3wwPNe3ejnJN5r5oIxq9QPmZRawZ44NCyAtTl3MEC96N3xYQha1TuJooW6hy
         9YlTT61GP1L5xuTti11KucisLSfvTL5wG4swlhrjsZCCW2j7m8wFJW8y7EMIvNgAYJy+
         xzirKOyunebm6EAqZhhsgW62bHn0OrSMJb0FQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=px6LlxUmzkx1m0e18cjKznO/fFTclAviZPrgSZRKBVI=;
        b=GrRtpXwCeIJY4uGHRCvmXyRyPiE94p2xDvo7o2g1GRwKzgNiMf5ABnFsXHncF2Z7EJ
         dL0IXgVPu6YsS9zdp4uvgtlE1RrtMi4ZlMYzIfiwBWEAHg/Ep11NigXLHgbdWHwh0aU4
         ipCPlWKrN9wwefroajPHzBQloHdySYeA/oPnf/LmZnpOcJ00nBFGzna+FdEvL1ekuQCH
         sDTtVvKQebHJShVtcPXZffJYgLnundaB7zRHggY9+1wUkI3IEC8lMDZdGoH6AITBkSVg
         QlT2LZlrgqPOyZae6Gq2eFP9lxcK/WSDeZsd+kMo31lFoclEi8yCi10BAg92Feqdwwbh
         KjKg==
X-Gm-Message-State: APjAAAVHN3yBlZgDC/iIKvZqwrhSUge+RS4zO4ihxij79FN2VF5F4SXT
        Uzs3gYl8alHPLjxcosWxXXBq2qriBh4=
X-Google-Smtp-Source: APXvYqwuafBjyWVNZ5VH6Y81iBIY0W/OVjVhCOg675fI8tV0NCpZEbQNK+knmrRNWc4QxGtwy8nD6A==
X-Received: by 2002:a2e:99cc:: with SMTP id l12mr6457587ljj.5.1567790152825;
        Fri, 06 Sep 2019 10:15:52 -0700 (PDT)
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com. [209.85.208.174])
        by smtp.gmail.com with ESMTPSA id t6sm1005555lji.3.2019.09.06.10.15.52
        for <linux-security-module@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Sep 2019 10:15:52 -0700 (PDT)
Received: by mail-lj1-f174.google.com with SMTP id 7so6669295ljw.7
        for <linux-security-module@vger.kernel.org>; Fri, 06 Sep 2019 10:15:52 -0700 (PDT)
X-Received: by 2002:a2e:3a0e:: with SMTP id h14mr6369908lja.180.1567789694898;
 Fri, 06 Sep 2019 10:08:14 -0700 (PDT)
MIME-Version: 1.0
References: <156763534546.18676.3530557439501101639.stgit@warthog.procyon.org.uk>
 <CAHk-=wh5ZNE9pBwrnr5MX3iqkUP4nspz17rtozrSxs5-OGygNw@mail.gmail.com>
 <17703.1567702907@warthog.procyon.org.uk> <CAHk-=wjQ5Fpv0D7rxX0W=obx9xoOAxJ_Cr+pGCYOAi2S9FiCNg@mail.gmail.com>
 <CAKCoTu7ms_Mr-q08d9XB3uascpzwBa5LF9JTT2aq8uUsoFE8aQ@mail.gmail.com>
 <CAHk-=wjcsxQ8QB_v=cwBQw4pkJg7pp-bBsdWyPivFO_OeF-y+g@mail.gmail.com>
 <5396.1567719164@warthog.procyon.org.uk> <CAHk-=wgbCXea1a9OTWgMMvcsCGGiNiPp+ty-edZrBWn63NCYdw@mail.gmail.com>
 <14883.1567725508@warthog.procyon.org.uk> <CAHk-=wjt2Eb+yEDOcQwCa0SrZ4cWu967OtQG8Vz21c=n5ZP1Nw@mail.gmail.com>
 <27732.1567764557@warthog.procyon.org.uk> <CAHk-=wiR1fpahgKuxSOQY6OfgjWD+MKz8UF6qUQ6V_y2TC_V6w@mail.gmail.com>
 <CAHk-=wioHmz69394xKRqFkhK8si86P_704KgcwjKxawLAYAiug@mail.gmail.com> <8e60555e-9247-e03f-e8b4-1d31f70f1221@redhat.com>
In-Reply-To: <8e60555e-9247-e03f-e8b4-1d31f70f1221@redhat.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 6 Sep 2019 10:07:58 -0700
X-Gmail-Original-Message-ID: <CAHk-=wg6=qhw0-F=2_8y=VdT+fj8k7G1+t2XNSkRYimXhampVg@mail.gmail.com>
Message-ID: <CAHk-=wg6=qhw0-F=2_8y=VdT+fj8k7G1+t2XNSkRYimXhampVg@mail.gmail.com>
Subject: Re: Why add the general notification queue and its sources
To:     Steven Whitehouse <swhiteho@redhat.com>
Cc:     David Howells <dhowells@redhat.com>,
        Ray Strode <rstrode@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
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

On Fri, Sep 6, 2019 at 9:12 AM Steven Whitehouse <swhiteho@redhat.com> wrote:
>
> The events are generally not independent - we would need ordering either
> implicit in the protocol or explicit in the messages.

Note that pipes certainly would never re-order messages. It's just
that _if_ you have two independent and concurrent readers of the same
pipe, they could read one message each, and you couldn't tell which
was first in user space.

Of course, I would suggest that anything that actually has
non-independent messages should always use a sequence number or
something like that in the message anyway. But then it would have to
be on a protocol level.

And it's not clear that all notifications need it. If it's just a
random "things changed" notification, mnaybe that doesn't need a
sequence number or anything else. So being on a protocol/data stream
level might be the right thing regardless.

Another possibility is to just say "don't do that then". If you want
multiple concurrent readers, open multiple pipes for them and use
separate events, and be happy in the knowledge that you don't have any
complicated cases.

>  We also need to
> know in case messages are dropped too - doesn't need to be anything
> fancy, just some idea that since we last did a read, there are messages
> that got lost, most likely due to buffer overrun.

Pipes don't have that, but another flag certainly wouldn't be _hard_ to add.

But one problem (and this is fundamental) is that while O_DIRECT works
today (and works with kernels going back years), any new features like
overflow notification would obviously not work with legacy kernels.

On the user write side, with an O_NONBLOCK pipe, you currently just
get an -EAGAIN, so you _see_ the drop happening. But (again) there's
no sticky flag for it anywhere else, and there's no clean automatic
way for the reader to see "ok, the writer overflowed".

That's not a problem for any future extensions - the feature sounds
like a new flag and a couple of lines to do it - but it's a problem
for the whole "prototype in user space using existing pipe support"
that I personally find so nice, and which I think is such a good way
to prove the user space _need_ for anything like this.

But if people are ok with the pipe model in theory, _that_ kind of
small and directed feature I have absolutely no problem with adding.
It's just whole new untested character mode drivers with odd semantics
that I find troublesome.

Hmm. Maybe somebody can come up with a good legacy signaling solution
(and "just use another pipe for error notification and OOB data" for
the first one may _work_, but that sounds pretty hacky and just not
very convenient).

               Linus
