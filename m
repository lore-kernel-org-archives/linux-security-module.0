Return-Path: <SRS0=76oK=SQ=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BC5BC282CE
	for <linux-security-module@archiver.kernel.org>; Sun, 14 Apr 2019 20:28:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D5E72070D
	for <linux-security-module@archiver.kernel.org>; Sun, 14 Apr 2019 20:28:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hoZP9u5e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726399AbfDNU2b (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Sun, 14 Apr 2019 16:28:31 -0400
Received: from mail-yw1-f68.google.com ([209.85.161.68]:46969 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725797AbfDNU2a (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Sun, 14 Apr 2019 16:28:30 -0400
Received: by mail-yw1-f68.google.com with SMTP id v127so5302251ywe.13;
        Sun, 14 Apr 2019 13:28:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kDRgLTNF+Ntj5TKZmb4m8NFC6FQT4vbIqcWKsvB1hpw=;
        b=hoZP9u5euJxMEG2HAlk5gjwVklrL5Af9WDBPARA4ZDrL6yBp71FAeN5PB+7pAcEcVy
         KMx0XEonadi+tVHRNHEmnxXNnpCUawvxG2D9Ghq4HPXMfect8ilbIikE7PZhgU8zjFwO
         ruAk10bTSIALQbngQDuI/diMVFPfFaTWjWBCQoIivWVY+t8J5aXp9qq+/Iql4WfQvKP2
         V1n2j+ZfAU2yevujlDKZczCkCqZrfAkKrXBTClT5VmRPkYPe1Aa+L2S8UzbbAFlE/Mm/
         6LnVUdN1woS6JHH70OyitrV5SSA6BHGjyUHcZCfHIy9a101aMjb9nAXzzR44qo6G8EfP
         u5Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kDRgLTNF+Ntj5TKZmb4m8NFC6FQT4vbIqcWKsvB1hpw=;
        b=Pt4VvhnGowaem/oP7ctxQ5D2cIDJJU9SdWrqIFYrN86eA0Zz3jFvlX6EB/BLn0fOGV
         ZBdaSu98LXt46klmsz5amjj7ta51uDlLTzwkfrlOy1EDZu0aQJragvuod0RFUpCqnG5w
         zpOw4p07eaNii8w/f8WEE01UCKxP597w/2lnB+Jo5eh6RYz4WICjNJyrROn7D14OMBcJ
         4KBkvqvQ2nU5k/v2MOlSj4YhuhcW71+m4FvR/EV1aCjK8J0jholDqVnaCZihpV3Ju5Os
         wMze5i3Lx1Vwe6Y/8gCNkcAInwBVM4adDHUhFhyj5vVkSyux7E93uTjReozSL1YZKGpY
         Q1LA==
X-Gm-Message-State: APjAAAXhwlq5sXjAdjF6SfTGCgMTij8p1HDz/lV63wpdyAv+z2Vm4PsH
        TiK7gZPb4yDvFVCOCznA7otpGZJTlvIdn/M/XPg=
X-Google-Smtp-Source: APXvYqy2akj3AP+yyRtYMzzjlXr8pZxA9oPrk1G4Irx90roQu/oZrSVXJl26aMZelIt0jCRm5JsCQkLUbj8qQYiI0ic=
X-Received: by 2002:a81:2502:: with SMTP id l2mr55899640ywl.451.1555273709958;
 Sun, 14 Apr 2019 13:28:29 -0700 (PDT)
MIME-Version: 1.0
References: <CAOQ4uxgn=YNj8cJuccx2KqxEVGZy1z3DBVYXrD=Mc7Dc=Je+-w@mail.gmail.com>
 <20190414163950.GQ2217@ZenIV.linux.org.uk> <CAOQ4uxg-NsccKfhzJbZnCnXhKA90VfVdV0_qLRt+8iVa53655g@mail.gmail.com>
 <20190414192601.GR2217@ZenIV.linux.org.uk>
In-Reply-To: <20190414192601.GR2217@ZenIV.linux.org.uk>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Sun, 14 Apr 2019 23:28:18 +0300
Message-ID: <CAOQ4uxiXVJVV1vT-DLOJBA=u3YV8FPYKUfzaac-Y_J8wN3_tiQ@mail.gmail.com>
Subject: Re: fanotify and LSM path hooks
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Jan Kara <jack@suse.cz>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        James Morris <jmorris@namei.org>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Matthew Bobrowski <mbobrowski@mbobrowski.org>,
        Kentaro Takeda <takedakn@nttdata.co.jp>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        John Johansen <john.johansen@canonical.com>
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Sun, Apr 14, 2019 at 10:26 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> On Sun, Apr 14, 2019 at 09:51:38PM +0300, Amir Goldstein wrote:
>
> > But the truth is I would much rather that users have a way to mark
> > a subtree root and ask fanotify for events under that subtree.
> > As a matter of fact, I have some private POC patches that allow users to
> > setup a mark on a "subtree root" dentry, which really marks the super block
> > and keep a reference to the dentry. Than every event on that super block
> > is filtered with is_subdir() against the marked dentry.
>
> And that is_subdir() is protected by what, exactly?  And what happens
> if you have many such dentries?
>
> Or, for that matter, what happens if that dentry gets invalidated?

Well, as I said, its just a POC, it only supports filtering by a single dentry
and I didn't think that was the way to go forward. I am looking for the best way
to go forward.

That's why I was looking for an API to "fence" renaming objects in/out of
of a subtree root. It sounds useful to have something like this for
containers and chroots.

Let's look at the options users have today.
Users can use recursive inotify that is racy and pins too many inodes in cache.
Users can use the new fanotify sb mark to get all events on filesystem and
filter them by path is userspace (also racy w.r.t ancestry).

I donno, maybe filtering by projid or another inherited persistent
inode property
is good enough for the existing use cases out there - this seems to be the way
ext4 is going with encrypted subtrees and case insensitive subtrees.

Thanks,
Amir.
