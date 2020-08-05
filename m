Return-Path: <SRS0=iE4T=BP=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A23CC433E0
	for <linux-security-module@archiver.kernel.org>; Wed,  5 Aug 2020 08:25:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2B20020792
	for <linux-security-module@archiver.kernel.org>; Wed,  5 Aug 2020 08:25:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="UYk0LJ7z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726707AbgHEIYx (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 5 Aug 2020 04:24:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726104AbgHEIYp (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 5 Aug 2020 04:24:45 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2983FC06179E
        for <linux-security-module@vger.kernel.org>; Wed,  5 Aug 2020 01:24:39 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id jp10so18880516ejb.0
        for <linux-security-module@vger.kernel.org>; Wed, 05 Aug 2020 01:24:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YRkoVvZyMZKrXPZJsbTSg0eFnj2VcDca+RKzJ60eyTc=;
        b=UYk0LJ7zSStHb1U495GvSSdmH6LUhiPYmcg6PAq1rMqY11Eyd7mimZZrA3M0EtvJUe
         vvHGhC/9MvozJfhIiIgBsFE7xq5Hm++FVNDlJ2kUw02Jto10O7BN/4nzlscTmBPJj7xg
         U2829Bced+hHMLcR8pAqx46/TL8W7/1KfFh6M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YRkoVvZyMZKrXPZJsbTSg0eFnj2VcDca+RKzJ60eyTc=;
        b=qOcRpSvZJ7plI9TT2XeqWo/PyH4p9fA6SiqMw8eEdNwmc4SEtUf2rlgIKnQTApm7Wb
         27Wj/CrGT1G6iwzggqvg3IcM3S8YVvlOoIIwvArrUg4ciOpg7rHlI6KCQr6Y4mXdjK6y
         Kp2Xu5+zPwFRK13rfi7voRxJcWlJOwLCU/KQKgG5nYkXFH1iDDfmLNQqr8DTlEkkeKXH
         Lk/wbepyns1PVm8B4dRtmziYG8sMDADdfzp30yjNlLDKbYJiJhzGQZpsQhJCh42C4b6V
         59zo8SS71F9RuQoLRQw6rQFZkxlkYTKC2Z+oM0onc2jD9O7fTMNYpyID8lYJ2d959orV
         9p3g==
X-Gm-Message-State: AOAM530zYs33hBaKJiML/VohHtfN7sJJA/Ob3TW9sUAYL3IWRCYLo1CS
        78sv5ZBfcLeOEYvoyX2K4I9Ijf4fYcyHx9ZX8jY9xw==
X-Google-Smtp-Source: ABdhPJxrLumgFgqYyoKDBG2k5IrM0kpKGeRUM6PbmX2nVN5dA62HAF0gWDOE78RgoqsR4O8I2bJbm1frFluN5es5kOU=
X-Received: by 2002:a17:906:22c1:: with SMTP id q1mr2028127eja.443.1596615874689;
 Wed, 05 Aug 2020 01:24:34 -0700 (PDT)
MIME-Version: 1.0
References: <1842689.1596468469@warthog.procyon.org.uk> <1845353.1596469795@warthog.procyon.org.uk>
 <CAJfpegunY3fuxh486x9ysKtXbhTE0745ZCVHcaqs9Gww9RV2CQ@mail.gmail.com>
 <ac1f5e3406abc0af4cd08d818fe920a202a67586.camel@themaw.net> <CAJfpegu8omNZ613tLgUY7ukLV131tt7owR+JJ346Kombt79N0A@mail.gmail.com>
In-Reply-To: <CAJfpegu8omNZ613tLgUY7ukLV131tt7owR+JJ346Kombt79N0A@mail.gmail.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Wed, 5 Aug 2020 10:24:23 +0200
Message-ID: <CAJfpegtNP8rQSS4Z14Ja4x-TOnejdhDRTsmmDD-Cccy2pkfVVw@mail.gmail.com>
Subject: file metadata via fs API (was: [GIT PULL] Filesystem Information)
To:     Ian Kent <raven@themaw.net>
Cc:     David Howells <dhowells@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>, Karel Zak <kzak@redhat.com>,
        Jeff Layton <jlayton@redhat.com>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Nicolas Dichtel <nicolas.dichtel@6wind.com>,
        Christian Brauner <christian@brauner.io>,
        Lennart Poettering <lennart@poettering.net>,
        Linux API <linux-api@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org,
        LSM <linux-security-module@vger.kernel.org>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Tue, Aug 4, 2020 at 4:36 PM Miklos Szeredi <miklos@szeredi.hu> wrote:

> I think we already lost that with the xattr API, that should have been
> done in a way that fits this philosophy.  But given that we  have "/"
> as the only special purpose char in filenames, and even repetitions
> are allowed, it's hard to think of a good way to do that.  Pity.

One way this could be solved is to allow opting into an alternative
path resolution mode.

E.g.
  openat(AT_FDCWD, "foo/bar//mnt/info", O_RDONLY | O_ALT);

Yes, the implementation might be somewhat tricky, but that's another
question.  Also I'm pretty sure that we should be reducing the
POSIX-ness of anything below "//" to the bare minimum.  No seeking,
etc....

I think this would open up some nice possibilities beyond the fsinfo thing.

Thanks,
Miklos
