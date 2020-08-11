Return-Path: <SRS0=15+v=BV=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AB71C433DF
	for <linux-security-module@archiver.kernel.org>; Tue, 11 Aug 2020 16:18:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ED52E206B5
	for <linux-security-module@archiver.kernel.org>; Tue, 11 Aug 2020 16:18:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597162691;
	bh=agiOZ1VlrH546FGYEHu+2a2fdebjGxLoWx6nls/0HZE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=SldwPGcKizQHFz7e1Fycu9mMqkYo1I9kVMZPSdWs5aNwYvuNPVXelHWJSOT99duen
	 BPs6xrNJa5U9R+wP1piyMu4kZgFJkQPpbMck9b2wTeh3mAzafkkkWyK20v5/pehRlR
	 Nk1zCDTMSrX0LSvcAuz4wRtH1HE1LbUJlYtWTXdc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729004AbgHKQSK (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 11 Aug 2020 12:18:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728947AbgHKQSJ (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 11 Aug 2020 12:18:09 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53799C06174A
        for <linux-security-module@vger.kernel.org>; Tue, 11 Aug 2020 09:18:08 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id t23so14194824ljc.3
        for <linux-security-module@vger.kernel.org>; Tue, 11 Aug 2020 09:18:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ARDqa0ttwGGpwIjIpukccBn4z80sUg1Y95J7pw/cBrc=;
        b=ARjGfgTTe8Hs0S97+HBco6KPkmP42m5OKE0ERo6Sf2t684ErIUsYZb+F9N6GI8m7VH
         sHrR/7XxUU0WvzcWkmBHB9j/WQDrOrGh9T97uhNn/7Dj2ZTIxVy3Iz23WUYyWjs31hnR
         EPcWsf2mQ8nUFDg+i2/4NJ7eEH6TQJE7uk7EY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ARDqa0ttwGGpwIjIpukccBn4z80sUg1Y95J7pw/cBrc=;
        b=BXCeGPUPAtE9cu/2Uoo53O0CwLT0DV/p4EHhIZY8KURh7+4C4Tcu415XdtXbvPNxpA
         LUZ2RUgpVqGreHRsuDO9p7cSQx0E4fzYQvWnih+GZejaVuF+yz84kbZmWSIG3KXXajSW
         IhB1A2iCDzFF360wrB8HDd05afU2Zg46YeXcYPm9m67x5/NT7ucctoE5NB7GzXFD/8bl
         AIc1JV0BucBI2Q64zLooaO7e8Dby8L7CUuj+JlyUWnvG29sza8vuBlObRvLz4F2xASPA
         /IHzbO8NWJ2kXOjgJRNQJidLPE2D28/rRJsGMF0+VKeUIjoRwrV3tZ2YU5EfUEP6Zrvl
         f3VA==
X-Gm-Message-State: AOAM531ZmWmuf1Yusws0QA1Gz7wW7HXQ9c8DvASjPMOapH972nzWHZYq
        N4HymQ+UOz4zhxha2KScv2ftxFpI/KY=
X-Google-Smtp-Source: ABdhPJzShDV8edvMHqffh3/i315X+PuaefGejC8W6io1BrLoVoBtuHdYI0XyV85N5Xs8mEZeoerkPg==
X-Received: by 2002:a2e:b04e:: with SMTP id d14mr3625693ljl.16.1597162686722;
        Tue, 11 Aug 2020 09:18:06 -0700 (PDT)
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com. [209.85.208.177])
        by smtp.gmail.com with ESMTPSA id o1sm10152144ljc.3.2020.08.11.09.18.05
        for <linux-security-module@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Aug 2020 09:18:06 -0700 (PDT)
Received: by mail-lj1-f177.google.com with SMTP id w25so14157010ljo.12
        for <linux-security-module@vger.kernel.org>; Tue, 11 Aug 2020 09:18:05 -0700 (PDT)
X-Received: by 2002:a2e:7615:: with SMTP id r21mr3191279ljc.371.1597162192777;
 Tue, 11 Aug 2020 09:09:52 -0700 (PDT)
MIME-Version: 1.0
References: <1842689.1596468469@warthog.procyon.org.uk> <1845353.1596469795@warthog.procyon.org.uk>
 <CAJfpegunY3fuxh486x9ysKtXbhTE0745ZCVHcaqs9Gww9RV2CQ@mail.gmail.com>
 <ac1f5e3406abc0af4cd08d818fe920a202a67586.camel@themaw.net>
 <CAJfpegu8omNZ613tLgUY7ukLV131tt7owR+JJ346Kombt79N0A@mail.gmail.com>
 <CAJfpegtNP8rQSS4Z14Ja4x-TOnejdhDRTsmmDD-Cccy2pkfVVw@mail.gmail.com>
 <20200811135419.GA1263716@miu.piliscsaba.redhat.com> <CAHk-=wjzLmMRf=QG-n+1HnxWCx4KTQn9+OhVvUSJ=ZCQd6Y1WA@mail.gmail.com>
 <20200811160534.GL1236603@ZenIV.linux.org.uk>
In-Reply-To: <20200811160534.GL1236603@ZenIV.linux.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 11 Aug 2020 09:09:36 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgHZig-+dXQeW4pPEjdYsrq=3bgc+vUhwiT2Ox4ipLHwg@mail.gmail.com>
Message-ID: <CAHk-=wgHZig-+dXQeW4pPEjdYsrq=3bgc+vUhwiT2Ox4ipLHwg@mail.gmail.com>
Subject: Re: file metadata via fs API (was: [GIT PULL] Filesystem Information)
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Miklos Szeredi <miklos@szeredi.hu>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        David Howells <dhowells@redhat.com>,
        Karel Zak <kzak@redhat.com>, Jeff Layton <jlayton@redhat.com>,
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

On Tue, Aug 11, 2020 at 9:05 AM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> Except that you suddenly see non-directory dentries get children.
> And a lot of dcache-related logics needs to be changed if that
> becomes possible.

Yeah, I think you'd basically need to associate a (dynamic)
mount-point to that path when you start doing O_ALT. Or something.

And it might not be reasonably implementable. I just think that as
_interface_ it's unambiguous and fairly clean, and if Miklos can
implement something like that, I think it would be maintainable.

No?

                Linus
