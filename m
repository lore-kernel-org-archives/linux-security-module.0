Return-Path: <SRS0=RtEY=BW=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FBEDC433E4
	for <linux-security-module@archiver.kernel.org>; Wed, 12 Aug 2020 19:50:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E10A620B1F
	for <linux-security-module@archiver.kernel.org>; Wed, 12 Aug 2020 19:50:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597261853;
	bh=zANYippBEM8vlz4ACqIlFjW9XcLrdF4n06DKDTjMecs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=Vj8BFANx0MLZbMaVEysRq1ym5J4yfiH/A0ST5++2Az9l2sqz18Hweukbtl8Ze/+ei
	 RzYnUYNhKfP81xSVInnVvdMahYcfjzHmnf4JK6mmF5ATN425JnM2O/jOt784Jnn9y8
	 0Lt1ySCNFQQeppPjBasPJr5ob+FvnZk0evMoNW1w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726642AbgHLTuv (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 12 Aug 2020 15:50:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726640AbgHLTut (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 12 Aug 2020 15:50:49 -0400
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64092C061383
        for <linux-security-module@vger.kernel.org>; Wed, 12 Aug 2020 12:50:49 -0700 (PDT)
Received: by mail-lf1-x141.google.com with SMTP id b30so1785040lfj.12
        for <linux-security-module@vger.kernel.org>; Wed, 12 Aug 2020 12:50:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=l0LPNTEWbU2mq6BgRpzsioeNr4RPYOF2TnDOgMD6NIs=;
        b=U1hdSpOUSLOjOrO72XqzG+q96d1pIF0cv/aZqt7kBp+fkvgL9591I+FRTAk0LrnIxR
         8JT4UZPZRO/zc5YAudhwHewQ4vDe1rgRhtOdIJf44K3wQIjkVGrwuKfqWiz5aOBB7xzw
         NmuJO1e6+UoXEurWxTmy0lrzQtpRHAgwv0Dgc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=l0LPNTEWbU2mq6BgRpzsioeNr4RPYOF2TnDOgMD6NIs=;
        b=sEcE0H2Oc+9fSzJ+c2Pj2sxwvdGvXzW/lQ9XN5PUg4/5fwcWS9NNuQmQOaUOWu/X41
         Ly22qWcYOClLn6m4//a23LGR3fNEHLx5BbCP4VhVd8FdIpp6Ddk7hZG8GUKo9vIrQMfa
         4dcOoKdfaF8g/98mJDt5uurgwNDIYszyJiAkg0QLTJByxdA99bD+vBT8KYPSb1P6bw7C
         h5CEdtz16gES8fzVzji5aRrU+oo9wRwcA7Q+xmjv/l7LskASvXtkeifdM8s5TKQWIQVq
         2GaMICR1eYAt5MreNU7BJFWqjhncSBgUIYduCzgcq8GkkTV2YdnJWdpblrOmjAkEoi/D
         0HVg==
X-Gm-Message-State: AOAM530QP+xILWSoRsNdimCZHKUWShuPTcNOfd2eaSmgI1J3Ncq4dYNx
        piDFV8GG1a5UvqFrWwOpXjvTaJTqamE=
X-Google-Smtp-Source: ABdhPJxAL+NLQmQiE8AXPIgjFqCnmTWLJD0rp4rQn4itGlOyW0rntQK+K8cxcBQCEtiGIdiNcP1xwA==
X-Received: by 2002:ac2:5f64:: with SMTP id c4mr502139lfc.170.1597261847230;
        Wed, 12 Aug 2020 12:50:47 -0700 (PDT)
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com. [209.85.167.50])
        by smtp.gmail.com with ESMTPSA id t13sm686774lfg.53.2020.08.12.12.50.46
        for <linux-security-module@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Aug 2020 12:50:46 -0700 (PDT)
Received: by mail-lf1-f50.google.com with SMTP id i80so1781641lfi.13
        for <linux-security-module@vger.kernel.org>; Wed, 12 Aug 2020 12:50:46 -0700 (PDT)
X-Received: by 2002:a05:6512:3b7:: with SMTP id v23mr500353lfp.10.1597261845653;
 Wed, 12 Aug 2020 12:50:45 -0700 (PDT)
MIME-Version: 1.0
References: <1842689.1596468469@warthog.procyon.org.uk> <1845353.1596469795@warthog.procyon.org.uk>
 <CAJfpegunY3fuxh486x9ysKtXbhTE0745ZCVHcaqs9Gww9RV2CQ@mail.gmail.com>
 <ac1f5e3406abc0af4cd08d818fe920a202a67586.camel@themaw.net>
 <CAJfpegu8omNZ613tLgUY7ukLV131tt7owR+JJ346Kombt79N0A@mail.gmail.com>
 <CAJfpegtNP8rQSS4Z14Ja4x-TOnejdhDRTsmmDD-Cccy2pkfVVw@mail.gmail.com>
 <20200811135419.GA1263716@miu.piliscsaba.redhat.com> <CAHk-=wjzLmMRf=QG-n+1HnxWCx4KTQn9+OhVvUSJ=ZCQd6Y1WA@mail.gmail.com>
 <52483.1597190733@warthog.procyon.org.uk> <CAHk-=wiPx0UJ6Q1X=azwz32xrSeKnTJcH8enySwuuwnGKkHoPA@mail.gmail.com>
 <066f9aaf-ee97-46db-022f-5d007f9e6edb@redhat.com>
In-Reply-To: <066f9aaf-ee97-46db-022f-5d007f9e6edb@redhat.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 12 Aug 2020 12:50:28 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgz5H-xYG4bOrHaEtY7rvFA1_6+mTSpjrgK8OsNbfF+Pw@mail.gmail.com>
Message-ID: <CAHk-=wgz5H-xYG4bOrHaEtY7rvFA1_6+mTSpjrgK8OsNbfF+Pw@mail.gmail.com>
Subject: Re: file metadata via fs API
To:     Steven Whitehouse <swhiteho@redhat.com>
Cc:     David Howells <dhowells@redhat.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
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

On Wed, Aug 12, 2020 at 12:34 PM Steven Whitehouse <swhiteho@redhat.com> wrote:
>
> The point of this is to give us the ability to monitor mounts from
> userspace.

We haven't had that before, I don't see why it's suddenly such a big deal.

The notification side I understand. Polling /proc files is not the answer.

But the whole "let's design this crazy subsystem for it" seems way
overkill. I don't see anybody caring that deeply.

It really smells like "do it because we can, not because we must".

Who the hell cares about monitoring mounts at a kHz frequencies? If
this is for MIS use, you want a nice GUI and not wasting CPU time
polling.

I'm starting to ignore the pull requests from David Howells, because
by now they have had the same pattern for a couple of years now:
esoteric new interfaces that seem overdesigned for corner-cases that
I'm not seeing people clamoring for.

I need (a) proof this is actualyl something real users care about and
(b) way more open discussion and implementation from multiple parties.

Because right now it looks like a small in-cabal of a couple of people
who have wild ideas but I'm not seeing the wider use of it.

Convince me otherwise. AGAIN. This is the exact same issue I had with
the notification queues that I really wanted actual use-cases for, and
feedback from actual outside users.

I really think this is engineering for its own sake, rather than
responding to actual user concerns.

               Linus
