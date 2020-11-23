Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31249C63697
	for <linux-security-module@archiver.kernel.org>; Mon, 23 Nov 2020 18:28:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CC4DB206A1
	for <linux-security-module@archiver.kernel.org>; Mon, 23 Nov 2020 18:27:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ANbUWVwu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729461AbgKWS14 (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 23 Nov 2020 13:27:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728785AbgKWS14 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 23 Nov 2020 13:27:56 -0500
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1980AC0613CF
        for <linux-security-module@vger.kernel.org>; Mon, 23 Nov 2020 10:27:56 -0800 (PST)
Received: by mail-lj1-x242.google.com with SMTP id r18so4323531ljc.2
        for <linux-security-module@vger.kernel.org>; Mon, 23 Nov 2020 10:27:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JgU9p94kvA07oQrdAsYiX/LIRMr6ln5r4nCdzUpy7o4=;
        b=ANbUWVwuYddoy3gY/bocFyh5hQNt+h3KoI3AHjcaYTZ0evyDqwLXLEvh5IHaIDYDPb
         ijvo4CAg9ebzTa4ARSGN499RtHon9GqnfrJYuy06yyb/lbQFc4e1U2t0r7waRnZQb4/f
         yAMxbAR5foJyFqxS0PsPj0FXOMJW+JBdUykTk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JgU9p94kvA07oQrdAsYiX/LIRMr6ln5r4nCdzUpy7o4=;
        b=BjHHqg0iUMN1AH8g+1BSRu3i3Jzk8Zg4fhnJbbD4XMkNPZMFjyo/wKs/fQMxYRpUXU
         FgFhdFJFqrwASemzE35SgKaV48iFz1FjKkZ1XmWCO9yMDpvJhc2/5UOq5ZsBHKqSaJyL
         cUnxu5yDVDVP4/4xtJTopMU3+rO6ST/pL5U7WifI4w829mh/teXbVHuhI+vTfbHJki2H
         trouPCMWStYs5fVayTw3XPQTHCT7CsMWn0+Q4dGywVD2nUT8X5W19hUWp6i+sN4bXg92
         GMrK75oblz28etnHOIn6OZrH69cQcL7yEy5EuvobmgpWwTw99mpDo1lufehASa/yFb/e
         nR+g==
X-Gm-Message-State: AOAM5339ARZMkR3ev7TqXd0a6b+d8Gg2LZsYmI66OPM15WRoozma4fTp
        y6qXURS5gwJImX0rmJiCbN7adRc71hmfC8jp87BuTQ==
X-Google-Smtp-Source: ABdhPJwkrFSNlfqwKOFD9vRpU4Bd/UVNbWjZfjxZomwpoP6hhcrhsrMTmb08rhFJdH7XN2M+FVxvNtHTO5cjG1ItJKo=
X-Received: by 2002:a05:651c:285:: with SMTP id b5mr303035ljo.82.1606156074562;
 Mon, 23 Nov 2020 10:27:54 -0800 (PST)
MIME-Version: 1.0
References: <20201121005054.3467947-1-kpsingh@chromium.org>
 <20201121005054.3467947-3-kpsingh@chromium.org> <05776c185bdc61a8d210107e5937c31e2e47b936.camel@linux.ibm.com>
 <CACYkzJ4VkwRV5WKe8WZjXgd1C1erXr_NtZhgKJL3ckTmS1M5VA@mail.gmail.com> <0f54c1636b390689031ac48e32b238a83777e09c.camel@linux.ibm.com>
In-Reply-To: <0f54c1636b390689031ac48e32b238a83777e09c.camel@linux.ibm.com>
From:   KP Singh <kpsingh@chromium.org>
Date:   Mon, 23 Nov 2020 19:27:43 +0100
Message-ID: <CACYkzJ6VEKBJnJZ+CBvpF6C=Kft5A2O5f=Uu4rTMtUiRKN5S-g@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 3/3] bpf: Update LSM selftests for bpf_ima_inode_hash
To:     Mimi Zohar <zohar@linux.ibm.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     James Morris <jmorris@namei.org>,
        open list <linux-kernel@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>,
        Linux Security Module list 
        <linux-security-module@vger.kernel.org>,
        Yonghong Song <yhs@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Florent Revest <revest@chromium.org>,
        Brendan Jackman <jackmanb@chromium.org>,
        Petr Vorel <pvorel@suse.cz>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

[...]

> > >
> > > Even if a custom policy has been loaded, potentially additional
> > > measurements unrelated to this test would be included the measurement
> > > list.  One way of limiting a rule to a specific test is by loopback
> > > mounting a file system and defining a policy rule based on the loopback
> > > mount unique uuid.
> >
> > Thanks Mimi!
> >
> > I wonder if we simply limit this to policy to /tmp and run an executable
> > from /tmp (like test_local_storage.c does).
> >
> > The only side effect would be of extra hashes being calculated on
> > binaries run from /tmp which is not too bad I guess?
>
> The builtin measurement policy (ima_policy=tcb") explicitly defines a
> rule to not measure /tmp files.  Measuring /tmp results in a lot of
> measurements.
>
> {.action = DONT_MEASURE, .fsmagic = TMPFS_MAGIC, .flags = IMA_FSMAGIC},
>
> >
> > We could do the loop mount too, but I am guessing the most clean way
> > would be to shell out to mount from the test? Are there some other examples
> > of IMA we could look at?
>
> LTP loopback mounts a filesystem, since /tmp is not being measured with
> the builtin "tcb" policy.  Defining new policy rules should be limited
> to the loopback mount.  This would pave the way for defining IMA-
> appraisal signature verification policy rules, without impacting the
> running system.

+Andrii

Do you think we can split the IMA test out,
have a little shell script that does the loopback mount, gets the
FS UUID, updates the IMA policy and then runs a C program?

This would also allow "test_progs" to be independent of CONFIG_IMA.

I am guessing the structure would be something similar
to test_xdp_redirect.sh

- KP

>
> Mimi
>
