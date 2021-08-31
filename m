Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D666CC43216
	for <linux-security-module@archiver.kernel.org>; Tue, 31 Aug 2021 16:43:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B08E661074
	for <linux-security-module@archiver.kernel.org>; Tue, 31 Aug 2021 16:43:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240207AbhHaQon (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 31 Aug 2021 12:44:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240361AbhHaQom (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 31 Aug 2021 12:44:42 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78E07C061764
        for <linux-security-module@vger.kernel.org>; Tue, 31 Aug 2021 09:43:47 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id ia27so10666ejc.10
        for <linux-security-module@vger.kernel.org>; Tue, 31 Aug 2021 09:43:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kjc7+55mnsbGiYgZPVI0RQMJKQPFbQbP/d5OYY/XwvI=;
        b=k2xijRaciRJ/LVEU6Y2PrH3+gCj/t5dYmM8sW0Hjm/dDb+2IHN3vec1BpUKQBZdidc
         uuaWzoHkQNFJH7kP7VD+pZkR9g/zK7H+84hLDdFOB+z94uHyU4Ct27ZGBiZl8NhnbRbR
         vmWV32dDkNHBAxJp7HXP7cdRAYbA3n87hvFPKxnN+SctXicbolXGPRl13X8+9qcKlKaB
         l5iRzVhtKjkH1SBybnKv/MhHhTEMk/FIu98DWdLMwG6g3P8NWT217zeEm3d0J3Kn30pb
         ksk4ej+e6Oah6bL8xWJVRJBSkCnQ0h7SqwcEn1xYmWfp3G8FQteZlKCiM8zbMXQBtFCU
         UwRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kjc7+55mnsbGiYgZPVI0RQMJKQPFbQbP/d5OYY/XwvI=;
        b=L2a1QuZPYypvVJ92kKTqeGQBp1w7nEFyIq7QQyAuHXoCrsAl0wzbUKow3mxy+VP0HY
         FvJkuYDqSUVR0gnIm0yfdycvq2TF0Pteh2z5BKCrfr6P0dIS2NUVIC0eGuLFnP08JDwq
         LGtopxntqNRGgLAjm+DOHYp6gTDoITwNGyhnZKNVvW8LVXjBWbNF8CkG4kkNqEYos2LJ
         d8fBGAEsosOQ2Rp0tuPEuNjRMqyaqcJz0GktElaPNIcWpJLd0KR4o0JQY09B/INBGcHP
         wAY1utp6ayvivc5GR7ecRa2fwRq9/eIhhxs7VLkUpIwq8/rjMVgZnPBXnFuM2pkq5cwu
         Aokw==
X-Gm-Message-State: AOAM530iSyHNhR2X11YN7HtskAl/eAZgaUCD7r8VAc+WFC27kWlP5i8I
        0StiOrLM+8QwnxknfjavoNRy7jbK+2Xexy2HoRh3
X-Google-Smtp-Source: ABdhPJyjj8Jl4/WszY5JhXeJncJuFRQJ7YX61g9AACQLWEreREH5VryAqB8mk0Sa5ueSDVzc0zlss5pkCj+sUCDsMBQ=
X-Received: by 2002:a17:906:1d59:: with SMTP id o25mr32116677ejh.431.1630428225946;
 Tue, 31 Aug 2021 09:43:45 -0700 (PDT)
MIME-Version: 1.0
References: <162871480969.63873.9434591871437326374.stgit@olly>
 <162871494794.63873.18299137802334845525.stgit@olly> <CAHC9VhSPW0R=AQGCaz9HNO5mXmCtscto-7O=9Af9B_EuCa5W=A@mail.gmail.com>
 <50ff8adf-d99c-e9a9-3d8b-cb9c2777455f@schaufler-ca.com>
In-Reply-To: <50ff8adf-d99c-e9a9-3d8b-cb9c2777455f@schaufler-ca.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 31 Aug 2021 12:43:35 -0400
Message-ID: <CAHC9VhRrmtt2+_3DmANwKFLP+Fvo74DLiToeyoHM=D=3r8EEOg@mail.gmail.com>
Subject: Re: [RFC PATCH v2 9/9] Smack: Brutalist io_uring support with debug
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        linux-audit@redhat.com, io-uring@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        Jens Axboe <axboe@kernel.dk>,
        Pavel Begunkov <asml.silence@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Tue, Aug 31, 2021 at 11:03 AM Casey Schaufler <casey@schaufler-ca.com> wrote:
> On 8/31/2021 7:44 AM, Paul Moore wrote:
> >
> > Casey, with the idea of posting a v3 towards the end of the merge
> > window next week, without the RFC tag and with the intention of
> > merging it into -next during the first/second week of the -rcX phase,
> > do you have any objections to me removing the debug code (#if 1 ...
> > #endif) from your patch?  Did you have any other changes?
>
> I have no other changes. And yes, the debug code should be stripped.
> Thank you.

Great, I'll remove that code for the v3 dump.

-- 
paul moore
www.paul-moore.com
