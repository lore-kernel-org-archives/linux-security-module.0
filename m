Return-Path: <SRS0=RoHj=BD=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07BAAC433E5
	for <linux-security-module@archiver.kernel.org>; Fri, 24 Jul 2020 20:26:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D716B2070B
	for <linux-security-module@archiver.kernel.org>; Fri, 24 Jul 2020 20:26:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595622371;
	bh=MGH5EUfFft7693c26Z+gHhy71zVD137Eni3+iyD7VXM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=JVlKIZ08SfkxSBrrpJhBiKXN5k5aGlPOpIgOubP6FFBwvzrYzhQUU0PCV/7s0M7ng
	 /dyb4/c3r7p6AO0AFUY2ZEBuuTopf8BgFVq7xPzZ/XvLtlwAffUsqE8MDC1nuzPLP0
	 YP1B6St2IV02g5Jn1rlGxiPMoEu77Sr7EQTjDEFE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726731AbgGXU0L (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 24 Jul 2020 16:26:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726455AbgGXU0L (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 24 Jul 2020 16:26:11 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8ECEFC0619D3
        for <linux-security-module@vger.kernel.org>; Fri, 24 Jul 2020 13:26:10 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id h22so11235135lji.9
        for <linux-security-module@vger.kernel.org>; Fri, 24 Jul 2020 13:26:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xkXygjf+m2gKsI4Lztqfnb3auT7BfwLJDotOPSg45zA=;
        b=KtKcrijfok2OM2Bs9fSARpIOCqZAORRhOEAWEspyefuuQiv0/hudjwYFxvdZYP8RIE
         x/etcayReiFZfOvZz4a+h99awZFUCnk+gEVf5LIz5qer03CSy6o0FgWPmB4n2oXPdXJB
         lJgwEQlLR1A9JtB7EMnPQ4yBFe/eY6IWqSZng=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xkXygjf+m2gKsI4Lztqfnb3auT7BfwLJDotOPSg45zA=;
        b=gFRagZuyvr0IgogVnfA1rU5XxvdTvHCEb3m135z+EUjfTAcZWwdmnBZX0JMInCxtBF
         a+bumShisLrcXT+kkscDLfkfhaaN+4kFeFcv9I+lgSA35quR+fJZdVribqqBj/IBVhDL
         8P0c5w8mcxgoG3LC5CaVhPX2ouToNIHzwFL6im24X+7hJ5yIdYbcm3OlMl9JU8sPgw3e
         Nww9ApKcIKowuOpsDk88yN8gTRVmErBUF2B/lg2S5lvk/0kULqT4uch9Ijow+8R1jKG6
         8ei5mmowufy9VVH1cEs+/s6wzreAKL7cLSQGjYHvdwWDHvNHb9qiammnQN+DvhIrW6A3
         YwIg==
X-Gm-Message-State: AOAM533RGHSKhGBdIeu+mTEbbDilBCi/az57QERlyu2f/iwYLrLROP+I
        iceQQ5wv0RzWJDfJ2cxWYYlwH0q0OuI=
X-Google-Smtp-Source: ABdhPJzanKcbyAkU8L2j0CXQORG9Qvp89OUpmFz5YHph7h5CutED1gbVlKHM5Oo6kab/raAHr7PkrQ==
X-Received: by 2002:a2e:161a:: with SMTP id w26mr5249429ljd.369.1595622368169;
        Fri, 24 Jul 2020 13:26:08 -0700 (PDT)
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com. [209.85.208.174])
        by smtp.gmail.com with ESMTPSA id w5sm474038lji.49.2020.07.24.13.26.06
        for <linux-security-module@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Jul 2020 13:26:07 -0700 (PDT)
Received: by mail-lj1-f174.google.com with SMTP id q4so11264522lji.2
        for <linux-security-module@vger.kernel.org>; Fri, 24 Jul 2020 13:26:06 -0700 (PDT)
X-Received: by 2002:a2e:9b42:: with SMTP id o2mr4879223ljj.102.1595622366366;
 Fri, 24 Jul 2020 13:26:06 -0700 (PDT)
MIME-Version: 1.0
References: <159559628247.2141315.2107013106060144287.stgit@warthog.procyon.org.uk>
 <159559630912.2141315.16186899692832741137.stgit@warthog.procyon.org.uk>
 <CAHk-=wjnQArU_BewVKQgYHy2mQD6LNKC5kkKXOm7GpNkJCapQg@mail.gmail.com> <2189056.1595620785@warthog.procyon.org.uk>
In-Reply-To: <2189056.1595620785@warthog.procyon.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 24 Jul 2020 13:25:50 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgWNpzCuHyyFwhR2fq49yxB9tKiH2t2y-O-8V6Gh0TFdw@mail.gmail.com>
Message-ID: <CAHk-=wgWNpzCuHyyFwhR2fq49yxB9tKiH2t2y-O-8V6Gh0TFdw@mail.gmail.com>
Subject: Re: [PATCH 3/4] watch_queue: Implement mount topology and attribute
 change notifications
To:     David Howells <dhowells@redhat.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Nicolas Dichtel <nicolas.dichtel@6wind.com>,
        Ian Kent <raven@themaw.net>,
        Christian Brauner <christian@brauner.io>,
        Jeff Layton <jlayton@redhat.com>, Karel Zak <kzak@redhat.com>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Linux API <linux-api@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Fri, Jul 24, 2020 at 12:59 PM David Howells <dhowells@redhat.com> wrote:
>
> That's a good point.  Any suggestions on how to do it?  An additional RLIMIT?
>
> Or should I do it like I did with keyrings and separately manage a quota for
> each user?

I'd count them per user, and maybe start out saying "you can have as
many watches as you can have files" and just re-use RLIMIT_NOFILE as
the limit for them.

And if that causes problems, let's re-visit. How does that sound?

                Linus
