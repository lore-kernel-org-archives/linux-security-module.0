Return-Path: <SRS0=15+v=BV=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F57DC433E1
	for <linux-security-module@archiver.kernel.org>; Tue, 11 Aug 2020 18:49:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 26E9B2076B
	for <linux-security-module@archiver.kernel.org>; Tue, 11 Aug 2020 18:49:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="qsi/YfmV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726457AbgHKStt (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 11 Aug 2020 14:49:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726430AbgHKSts (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 11 Aug 2020 14:49:48 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C862C061788
        for <linux-security-module@vger.kernel.org>; Tue, 11 Aug 2020 11:49:48 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id bo3so14189531ejb.11
        for <linux-security-module@vger.kernel.org>; Tue, 11 Aug 2020 11:49:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QR5EthpwytHc0ejjeS7AxrlPWVpWopYIIKYLKzP2Eq4=;
        b=qsi/YfmV5n8FbsFLNbmPsP/XkvX4WKPoDYdfXAcHJX7sKPLBuRLurDA3+/2q3dTeSc
         QR8qUCCSWYQi8swtBn5FT3wk2zToUXW4QeK5DefeOUHbAjTA30lN66ie4B4qXy6igVCz
         4BHo6BVZ9hbN3e+PMfS3B/xKbDT6XmlbbOAG8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QR5EthpwytHc0ejjeS7AxrlPWVpWopYIIKYLKzP2Eq4=;
        b=ZuzDGubH08jrfkYvsB4cYREXY7I1m/QF6YOy68DEPn0qBhnDNOtK2SWlqRy0YGXQZI
         0aE9YE0GCh4IfZtHPcUz5bxOW0zVBbHyr/fTYK6U+DPT5lDo7z55Wi2iy29fSUpu94JI
         HO02tAcDWgxrHH8d5N09jAXs2C+5iZKIWWOANbMvu168Xw5zY5KSEzfx6jwY1jLDwJ0x
         PG6xjLCYGI1hlzc9BvHEZuATsABfHwgDnowDIOhcgkf8klfJfs5a8/uO9PXyl0XqSTc0
         bMfxgevGn9+pWy11BhdaFOtQJPTlew+qTbLNFswEyhJYh0vXKKtGNBOftCraK3TMkLaM
         TIFA==
X-Gm-Message-State: AOAM532pSdVKY5Mr2zvXDl1Dd7bi9VBC0+xYczFYKSAnxcPWyqu/++5d
        cXJ+KGOp1wfCe3pItYJhqCxwRMKXRkF1HKZkTXSXvg==
X-Google-Smtp-Source: ABdhPJwnvaq93oJFCq5dS1yTahe560sCcekZabn8tDE66ijpKnt1L+Oo8yrivZ6IVjeel10rJKNsayxlhVFf1TUW2Xc=
X-Received: by 2002:a17:907:94ca:: with SMTP id dn10mr27509087ejc.110.1597171786328;
 Tue, 11 Aug 2020 11:49:46 -0700 (PDT)
MIME-Version: 1.0
References: <1842689.1596468469@warthog.procyon.org.uk> <1845353.1596469795@warthog.procyon.org.uk>
 <CAJfpegunY3fuxh486x9ysKtXbhTE0745ZCVHcaqs9Gww9RV2CQ@mail.gmail.com>
 <ac1f5e3406abc0af4cd08d818fe920a202a67586.camel@themaw.net>
 <CAJfpegu8omNZ613tLgUY7ukLV131tt7owR+JJ346Kombt79N0A@mail.gmail.com>
 <CAJfpegtNP8rQSS4Z14Ja4x-TOnejdhDRTsmmDD-Cccy2pkfVVw@mail.gmail.com>
 <20200811135419.GA1263716@miu.piliscsaba.redhat.com> <CAHk-=wjzLmMRf=QG-n+1HnxWCx4KTQn9+OhVvUSJ=ZCQd6Y1WA@mail.gmail.com>
 <CAJfpegtWai+5Tzxi1_G+R2wEZz0q66uaOFndNE0YEQSDjq0f_A@mail.gmail.com> <CAHk-=wg_bfVf5eazwH2uXTG-auCYZUpq-xb1kDeNjY7yaXS7bw@mail.gmail.com>
In-Reply-To: <CAHk-=wg_bfVf5eazwH2uXTG-auCYZUpq-xb1kDeNjY7yaXS7bw@mail.gmail.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Tue, 11 Aug 2020 20:49:35 +0200
Message-ID: <CAJfpeguo5nAWcmduX4frknQGiRJeaj9Rdj018xUBrwqOJhVufw@mail.gmail.com>
Subject: Re: file metadata via fs API (was: [GIT PULL] Filesystem Information)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        David Howells <dhowells@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>, Karel Zak <kzak@redhat.com>,
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

On Tue, Aug 11, 2020 at 6:05 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:

> and then people do "$(srctree)/". If you haven't seen that kind of
> pattern where the pathname has two (or sometimes more!) slashes in the
> middle, you've led a very sheltered life.

Oh, I have.   That's why I opted for triple slashes, since that should
work most of the time even in those concatenated cases.  And yes, I
know, most is not always, and this might just be hiding bugs, etc...
I think the pragmatic approach would be to try this and see how many
triple slash hits a normal workload gets and if it's reasonably low,
then hopefully that together with warnings for O_ALT would be enough.

>  (b) even if the new user space were to think about that, and remove
> those (hah! when have you ever seen user space do that?), as Al
> mentioned, the user *filesystem* might have pathnames with double
> slashes as part of symlinks.
>
> So now we'd have to make sure that when we traverse symlinks, that
> O_ALT gets cleared.

That's exactly what I implemented in the proof of concept patch.

> Which means that it's not a unified namespace
> after all, because you can't make symlinks point to metadata.

I don't think that's a great deal.  Also I think other limitations
would make sense:

 - no mounts allowed under ///
 - no ./.. resolution after ///
 - no hardlinks
 - no special files, just regular and directory
 - no seeking (regular or dir)

>     cat my-file.tar/inside/the/archive.c
>
> or similar.
>
> Al has convinced me it's a horrible idea (and there you have a
> non-ambiguous marker: the slash at the end of a pathname that
> otherwise looks and acts as a non-directory)

Umm, can you remind me what's so horrible about that?  Yeah, hard
linked directories are a no-no.  But it doesn't have to be implemented
in a way to actually be a problem with hard links.

Thanks,
Miklos
