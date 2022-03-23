Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DECAAC433FE
	for <linux-security-module@archiver.kernel.org>; Wed, 23 Mar 2022 13:25:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242592AbiCWN01 (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 23 Mar 2022 09:26:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236561AbiCWN00 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 23 Mar 2022 09:26:26 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 537D842A20
        for <linux-security-module@vger.kernel.org>; Wed, 23 Mar 2022 06:24:53 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id y10so1815177edv.7
        for <linux-security-module@vger.kernel.org>; Wed, 23 Mar 2022 06:24:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ofARB/tR+RVoABReGEuRsRQFB51fG8u0uAhot0zbmMw=;
        b=kiS6nqG1b2tpgSMlBhPduqhTR+uUp0NChTeF3Di3s0Gjmx4bKjIIt1C21Otat+l2Q0
         4riiJxQWeItg6q+1D7JmS8q2bknHa18aANAwBErwq0pxH33tw+zQsMdsN8+rKLqNK5mG
         DSpYL7ceqguq/vwomiRqGOlI+eqIUjjbEr7eU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ofARB/tR+RVoABReGEuRsRQFB51fG8u0uAhot0zbmMw=;
        b=4cvUJHkaLlT0ohvLth3HetKm12hKp/pvPx10nw1pd9hX41j7jV5Id+PHZJmfrAO9e0
         1kRxhzI9Q/Lu/hUObh0ozSfNQGlof0R501z6TbL1fUXDis0+ffT7uelrOr2Ubg/U79mg
         njbgTbb79aid/fZaou9dH69rVe5pFdGoOJT3VIEbFOzvL052IxV4pgl6naH6uMvStsMh
         JgBvy9zgzhmYml1lMlwrJzGD64m+W6aRCRgoG/kaVgH3KzzLWK+bdvCXXSH91XsOf20Z
         8PsYS4nIzNa9PgMPVWoCx+N0HeWtlaieE8LzOFtkdUtrnWJETywwHgf0pXo2zxZsTIN9
         2xcQ==
X-Gm-Message-State: AOAM531Rk91qfnvmEKivgKhr0P8GTy7AnbkZU3KI/m+OrX++MndWG9k9
        v1/pIZVKer8/3heNXrzfeFmP+KbzCGCbbCScwjHhug==
X-Google-Smtp-Source: ABdhPJyRgW2FVFPWTwmyfY3ygJgDF0P1WjrCCbHGjTDRam6d8g5Mn8TpLo/cwFgpJpNZHxGt28DfDlUbH73eq61XwZ8=
X-Received: by 2002:a05:6402:50cf:b0:418:ee57:ed9 with SMTP id
 h15-20020a05640250cf00b00418ee570ed9mr34726129edb.37.1648041891743; Wed, 23
 Mar 2022 06:24:51 -0700 (PDT)
MIME-Version: 1.0
References: <20220322192712.709170-1-mszeredi@redhat.com> <20220323114215.pfrxy2b6vsvqig6a@wittgenstein>
In-Reply-To: <20220323114215.pfrxy2b6vsvqig6a@wittgenstein>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Wed, 23 Mar 2022 14:24:40 +0100
Message-ID: <CAJfpegsCKEx41KA1S2QJ9gX9BEBG4_d8igA0DT66GFH2ZanspA@mail.gmail.com>
Subject: Re: [RFC PATCH] getvalues(2) prototype
To:     Christian Brauner <brauner@kernel.org>
Cc:     Miklos Szeredi <mszeredi@redhat.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Linux API <linux-api@vger.kernel.org>,
        linux-man <linux-man@vger.kernel.org>,
        LSM <linux-security-module@vger.kernel.org>,
        Karel Zak <kzak@redhat.com>, Ian Kent <raven@themaw.net>,
        David Howells <dhowells@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <christian@brauner.io>,
        Amir Goldstein <amir73il@gmail.com>,
        James Bottomley <James.Bottomley@hansenpartnership.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Wed, 23 Mar 2022 at 12:43, Christian Brauner <brauner@kernel.org> wrote:

> Yes, we really need a way to query for various fs information. I'm a bit
> torn about the details of this interface though. I would really like if
> we had interfaces that are really easy to use from userspace comparable
> to statx for example.

The reason I stated thinking about this is that Amir wanted a per-sb
iostat interface and dumped it into /proc/PID/mountstats.  And that is
definitely not the right way to go about this.

So we could add a statfsx() and start filling in new stuff, and that's
what Linus suggested.  But then we might need to add stuff that is not
representable in a flat structure (like for example the stuff that
nfs_show_stats does) and that again needs new infrastructure.

Another example is task info in /proc.  Utilities are doing a crazy
number of syscalls to get trivial information.  Why don't we have a
procx(2) syscall?  I guess because lots of that is difficult to
represent in a flat structure.  Just take the lsof example: tt's doing
hundreds of thousands of syscalls on a desktop computer with just a
few hundred processes.

So I'm trying to look beyond fsinfo and about how we could better
retrieve attributes, statistics, small bits and pieces within a
unified framework.

The ease of use argument does not really come into the picture here,
because (unlike stat and friends) most of this info is specialized and
will be either consumed by libraries, specialized utilities
(util-linux, procos) or with a generic utility application that can
query any information about anything that is exported through such an
interface.    That applies to plain stat(2) as well: most users will
not switch to statx() simply because that's too generic.  And that's
fine, for info as common as struct stat a syscall is warranted.  If
the info is more specialized, then I think a truly generic interface
is a much better choice.

>  I know having this generic as possible was the
> goal but I'm just a bit uneasy with such interfaces. They become
> cumbersome to use in userspace. I'm not sure if the data: part for
> example should be in this at all. That seems a bit out of place to me.

Good point, reduction of scope may help.

> Would it be really that bad if we added multiple syscalls for different
> types of info? For example, querying mount information could reasonably
> be a more focussed separate system call allowing to retrieve detailed
> mount propagation info, flags, idmappings and so on. Prior approaches to
> solve this in a completely generic way have gotten us not very far too
> so I'm a bit worried about this aspect too.

And I fear that this will just result in more and more ad-hoc
interfaces being added, because a new feature didn't quite fit the old
API.  You can see the history of this happening all over the place
with multiple new syscall versions being added as the old one turns
out to be not generic enough.

I think a new interface needs to

  - be uniform (a single utility can be used to retrieve various
attributes and statistics, contrast this with e.g. stat(1),
getfattr(1), lsattr(1) not to mention various fs specific tools).

 - have a hierarchical namespace (the unix path lookup is an example
of this that stood the test of time)

 - allow retrieving arbitrary text or binary data

And whatever form it takes, I'm sure it will be easier to use than the
mess we currently have in various interfaces like the mount or process
stats.

Thanks,
Miklos
