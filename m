Return-Path: <SRS0=ekpI=AH=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CF20C433E0
	for <linux-security-module@archiver.kernel.org>; Fri, 26 Jun 2020 01:42:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 783DA2070A
	for <linux-security-module@archiver.kernel.org>; Fri, 26 Jun 2020 01:42:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593135759;
	bh=ZcjKlzC9pTr1KWbXb9k9N/aQuHEz3Utm8JPHFrnBfcg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=SZz7tVI4eXcb4IMvAn6K+hHS9C6iXszFnmOP9WEJZsLGVGECf6k029obOkdiIEdqz
	 PFPPDwQrvTJa0e1QAQkINTA3OHJZ6lppy4DeEQuYCWvbvt4EvEz1tICi2JCZGchWKF
	 4mSLaV9h8lYov4tpH8rnDsM72NpxShWdl9rFq/C8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727898AbgFZBmi (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 25 Jun 2020 21:42:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727876AbgFZBmi (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 25 Jun 2020 21:42:38 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30432C08C5C1
        for <linux-security-module@vger.kernel.org>; Thu, 25 Jun 2020 18:42:38 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id mb16so7830002ejb.4
        for <linux-security-module@vger.kernel.org>; Thu, 25 Jun 2020 18:42:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iBlssWGvZOAUnwbFE+tTOZwoNXNhC7FxvKiwWZijAmg=;
        b=Qby8f0yox/HTyimDKy8WH3QjOnsg/2FljFlSp/oNDI3KhHpuZAxj1N6Z18mesHmIms
         NOZMN7rYftj4wIT3wsgRxLsZf9lBCRiKDlD1XlyYLBOunfkrsxx012pA879ViQA3++T/
         co+GFPa4HCJ+SssCzgmGMtkAllEXMS8wzS4JM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iBlssWGvZOAUnwbFE+tTOZwoNXNhC7FxvKiwWZijAmg=;
        b=HGVRrZ0tgo6EumrtBoYubAf7HJeb8mx2oahh3EwFaGEDlP+DH8kCR1kynITvYbl7ia
         3pbnqQVCS/8IMn2tkyMezr/AIVd0zTzp0zWMRCX58qruHv/y/MhwMm5KrEbspIXfybxr
         2oYTLrFVGAQWYctDBQOCBeZsT85zgWAccpZPRDRo8A1KNkcDmKfC+S2G+OfuNJiwDG1k
         22mAizAbH3VcxqqDwdY45UidkuVjmKQRMxW5gDVSNQD2B1PXbV3x1dgcJYugRRp1kNCR
         PxP2v+gS4YPwsbAkyZgad5XhoxFcLXxVhrmkwAfo7mC7xxUBY/1Fz9AizTl9tn7IoFei
         gAXw==
X-Gm-Message-State: AOAM531DyUqCpjQLzy7EQQVhfi2nDPt/CzXa9+9nfv4DRCHXV6leK2cK
        85Snhcpv940Gh/MbiccFxqRbvsnKRu8=
X-Google-Smtp-Source: ABdhPJzT/XWHoKGhYRFkXBC1VWVPoL9HhInKUe06jxx0kEIfdjUwE4ZM98wXfLzVhAsKxKiM8gvX0A==
X-Received: by 2002:a17:906:35cd:: with SMTP id p13mr554550ejb.172.1593135755484;
        Thu, 25 Jun 2020 18:42:35 -0700 (PDT)
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com. [209.85.208.50])
        by smtp.gmail.com with ESMTPSA id l16sm18118325ejx.19.2020.06.25.18.42.35
        for <linux-security-module@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Jun 2020 18:42:35 -0700 (PDT)
Received: by mail-ed1-f50.google.com with SMTP id dg28so5716873edb.3
        for <linux-security-module@vger.kernel.org>; Thu, 25 Jun 2020 18:42:35 -0700 (PDT)
X-Received: by 2002:a2e:b5d7:: with SMTP id g23mr215388ljn.70.1593135410467;
 Thu, 25 Jun 2020 18:36:50 -0700 (PDT)
MIME-Version: 1.0
References: <20200625095725.GA3303921@kroah.com> <778297d2-512a-8361-cf05-42d9379e6977@i-love.sakura.ne.jp>
 <20200625120725.GA3493334@kroah.com> <20200625.123437.2219826613137938086.davem@davemloft.net>
In-Reply-To: <20200625.123437.2219826613137938086.davem@davemloft.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 25 Jun 2020 18:36:34 -0700
X-Gmail-Original-Message-ID: <CAHk-=whuTwGHEPjvtbBvneHHXeqJC=q5S09mbPnqb=Q+MSPMag@mail.gmail.com>
Message-ID: <CAHk-=whuTwGHEPjvtbBvneHHXeqJC=q5S09mbPnqb=Q+MSPMag@mail.gmail.com>
Subject: Re: [RFC][PATCH] net/bpfilter: Remove this broken and apparently unmantained
To:     David Miller <davem@davemloft.net>
Cc:     Greg Kroah-Hartman <greg@kroah.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>, bpf <bpf@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Gary Lin <GLin@suse.com>, Bruno Meneguele <bmeneg@redhat.com>,
        LSM List <linux-security-module@vger.kernel.org>,
        Casey Schaufler <casey@schaufler-ca.com>
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Thu, Jun 25, 2020 at 12:34 PM David Miller <davem@davemloft.net> wrote:
>
> It's kernel code executing in userspace.  If you don't trust the
> signed code you don't trust the signed code.
>
> Nothing is magic about a piece of code executing in userspace.

Well, there's one real issue: the most likely thing that code is going
to do is execute llvm to generate more code.

And that's I think the real security issue here: the context in which
the code executes. It may be triggered in one namespace, but what
namespaces and what rules should the thing actually then execute in.

So no, trying to dismiss this as "there are no security issues" is
bogus. There very much are security issues.

It's just that the current code that is just a dummy wrapper around
something that doesn't actually do anything doesn't happen to _show_
those issues, because it does nothing.

I've stayed away from this discussion because I wanted to see if it
went anywhere, but it doesn't seem to.

My personally strongest argument for remoiving this kernel code is
that it's been there for a couple of years now, and it has never
actually done anything useful, and there's no actual sign that it ever
will, or that there is a solid plan in place for it.

So to me, it really looks like it was an interesting idea, but one
that hasn't proven itself, and most certainly not one that has shown
itself to be the _right_ idea.

We can dance around the "what about security modules", but that
fundamental problem of "this code hasn't done anything useful for two
years and we don't even know if it's the right thing to do or what the
real security issues _will_ be" is I think the real issue here.

Hmm?

             Linus
