Return-Path: <SRS0=15+v=BV=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B12F0C433DF
	for <linux-security-module@archiver.kernel.org>; Tue, 11 Aug 2020 20:28:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7D07920774
	for <linux-security-module@archiver.kernel.org>; Tue, 11 Aug 2020 20:28:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="chfynWAB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726691AbgHKU2p (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 11 Aug 2020 16:28:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726684AbgHKU2o (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 11 Aug 2020 16:28:44 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34AB9C061788
        for <linux-security-module@vger.kernel.org>; Tue, 11 Aug 2020 13:28:43 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id g19so14486826ejc.9
        for <linux-security-module@vger.kernel.org>; Tue, 11 Aug 2020 13:28:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ve5Yd3mwVy0R7O+69rb0Z3/pkYDrUBPYv3Y7SDQCiIs=;
        b=chfynWAB8HsSXn0Nq9kuiBHfOY/TZ4j75nPnyD8edBXlVosZV/a4sfirrV1K1EKGZQ
         CcdKgi6EAOOB4iCCl58grDpy8pwBziFonZaMthHTr/jQhkDC3TEiBlQCO6xUpVbJ1fwt
         zcQQlAsevZ8biY9RI4Sz9V1uGTfE6bGeW0b0g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ve5Yd3mwVy0R7O+69rb0Z3/pkYDrUBPYv3Y7SDQCiIs=;
        b=GWSqT1k93I/7FrZKnAXmNcCkLLkso+aKg92gvYJ3OQtxg2KxpqH8zsKFSk8YonR4Vu
         3OCPINR6EBxJl767kFmF+MlmDZPXE6qh2SMxRb2w2q7SZHSvh9h3Sjd327I9Y2QLqYDb
         eW3pmsCsQd2tYmi45vVlxtzSfQyGLSagCmYBGD6zO/dgbVGGfweLye+yDXwgT3hMitBr
         Myt2yj1vOW8oXsDegWpTn83squQZsibzPrPkmQK4ebWCKNTXNIoLunVlONa6RqNGb+s0
         q8M7Nun02AqwzlQ+86BunaSXGo/5mAV+LmAHLTT7wX+v6lwZ2F+v6j+yAgSa7HqzRAge
         riMg==
X-Gm-Message-State: AOAM5326iKSeTL/OTO2ETWYadxxTRMEz5qcEhRuQn0Bjg3DQ+9082XMO
        1hUtxgTZ9Ol2uT9idspeLojYIT0iVIJQubCq06TBog==
X-Google-Smtp-Source: ABdhPJynkGonNWW27v5lD0Dm9oTs5g6XNor54WFwVnAIKXdGR+PnhZVN78P+1gHxIPBKFMpGTOgrYXWyHLqEyGqEuwc=
X-Received: by 2002:a17:906:b2d7:: with SMTP id cf23mr27554943ejb.113.1597177722443;
 Tue, 11 Aug 2020 13:28:42 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=wjzLmMRf=QG-n+1HnxWCx4KTQn9+OhVvUSJ=ZCQd6Y1WA@mail.gmail.com>
 <5C8E0FA8-274E-4B56-9B5A-88E768D01F3A@amacapital.net> <a6cd01ed-918a-0ed7-aa87-0585db7b6852@schaufler-ca.com>
In-Reply-To: <a6cd01ed-918a-0ed7-aa87-0585db7b6852@schaufler-ca.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Tue, 11 Aug 2020 22:28:31 +0200
Message-ID: <CAJfpegvUBpb+C2Ab=CLAwWffOaeCedr-b7ZZKZnKvF4ph1nJrw@mail.gmail.com>
Subject: Re: file metadata via fs API (was: [GIT PULL] Filesystem Information)
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     Andy Lutomirski <luto@amacapital.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
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

On Tue, Aug 11, 2020 at 6:17 PM Casey Schaufler <casey@schaufler-ca.com> wrote:

> Since a////////b has known meaning, and lots of applications
> play loose with '/', its really dangerous to treat the string as
> special. We only get away with '.' and '..' because their behavior
> was defined before many of y'all were born.

So the founding fathers have set things in stone and now we can't
change it.   Right?

Well that's how it looks... but let's think a little; we have '/' and
'\0' that can't be used in filenames.  Also '.' and '..' are
prohibited names. It's not a trivial limitation, so applications are
probably not used to dumping binary data into file names.  And that
means it's probably possible to find a fairly short combination that
is never used in practice (probably containing the "/." sequence).
Why couldn't we reserve such a combination now?

I have no idea how to find such it, but other than that, I see no
theoretical problem with extending the list of reserved filenames.

Thanks,
Miklos
