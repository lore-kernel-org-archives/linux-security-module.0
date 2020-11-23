Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78D8AC56202
	for <linux-security-module@archiver.kernel.org>; Mon, 23 Nov 2020 14:07:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1C9162080A
	for <linux-security-module@archiver.kernel.org>; Mon, 23 Nov 2020 14:07:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="g02va37M"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731249AbgKWOGV (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 23 Nov 2020 09:06:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729581AbgKWOGV (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 23 Nov 2020 09:06:21 -0500
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99F94C061A4E
        for <linux-security-module@vger.kernel.org>; Mon, 23 Nov 2020 06:06:19 -0800 (PST)
Received: by mail-lj1-x242.google.com with SMTP id y10so2644357ljc.7
        for <linux-security-module@vger.kernel.org>; Mon, 23 Nov 2020 06:06:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yOJoUUi3QECcvzuYDvZQKkbQooLbVapSba7D9AdKZgE=;
        b=g02va37MFIoFx3hvG/lPTuaAb9EGDa4OPTnhWnNErRVvR26TPzhwL/YSGl9XH06Ban
         GLaP6rOf9Le9Hv3XUSN6kkLGJxbUBB7YpdYIJQ9kpWc0PLeYry7oa2a0EAI+izCZgYrV
         gI8kssPprToX4CQ92C1Dnq6bNeRnBtN3HFCOg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yOJoUUi3QECcvzuYDvZQKkbQooLbVapSba7D9AdKZgE=;
        b=ag/4dEe8yGnurke/+B0xIa4xBSwNOJVd8MdLav+879bG63GumXPE7n4QmXE5lajGjd
         GFb2hs5d5sZWH0nZ/pbiSpGQhR86hW49aT9B9XAw6Dmp96LEbei0BRosCv2wPJPxhW6B
         usHX+8KQeRbmg83phrxBbPRv7psAg9bmO1gJ6bVYczSGy5nUXJOHL0yVKJa2yCNLRKn1
         xFzquzsXiR0FcfBlaTp9i8grssNlUEHFkED5gLTvnDHZ4omVXWz/nNszn8pJhQooUZT+
         55l3vtsmL1/P1x5N86fMtiEuAKs5HmJ+SFw7B5G3uUoucchS1onUEm/8KAbGpQTM+QGX
         vidw==
X-Gm-Message-State: AOAM530tYzWMfOhdtXBZqMjIFgVEThJ293BP+dSrHndlHBEjeSgfnkXl
        v6mEv24mtyo1X+T98Fy0mgleJQAre414jsVDp3KqnA==
X-Google-Smtp-Source: ABdhPJyIM1KLcez6Q4p3jPbCCe+oj5X9cN4ct/4A+vkNM4F2hoRVX6Cjl/82rapeZbwXjZxLFpjZllAbpV+QEQGaLHg=
X-Received: by 2002:a2e:8908:: with SMTP id d8mr1095267lji.309.1606140376535;
 Mon, 23 Nov 2020 06:06:16 -0800 (PST)
MIME-Version: 1.0
References: <20201121005054.3467947-1-kpsingh@chromium.org>
 <20201121005054.3467947-3-kpsingh@chromium.org> <05776c185bdc61a8d210107e5937c31e2e47b936.camel@linux.ibm.com>
In-Reply-To: <05776c185bdc61a8d210107e5937c31e2e47b936.camel@linux.ibm.com>
From:   KP Singh <kpsingh@chromium.org>
Date:   Mon, 23 Nov 2020 15:06:05 +0100
Message-ID: <CACYkzJ4VkwRV5WKe8WZjXgd1C1erXr_NtZhgKJL3ckTmS1M5VA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 3/3] bpf: Update LSM selftests for bpf_ima_inode_hash
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     James Morris <jmorris@namei.org>,
        open list <linux-kernel@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>,
        Linux Security Module list 
        <linux-security-module@vger.kernel.org>,
        Yonghong Song <yhs@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Florent Revest <revest@chromium.org>,
        Brendan Jackman <jackmanb@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Mon, Nov 23, 2020 at 2:24 PM Mimi Zohar <zohar@linux.ibm.com> wrote:
>
> On Sat, 2020-11-21 at 00:50 +0000, KP Singh wrote:
> > From: KP Singh <kpsingh@google.com>
> >
> > - Update the IMA policy before executing the test binary (this is not an
> >   override of the policy, just an append that ensures that hashes are
> >   calculated on executions).
>
> Assuming the builtin policy has been replaced with a custom policy and
> CONFIG_IMA_WRITE_POLICY is enabled, then yes the rule is appended.   If
> a custom policy has not yet been loaded, loading this rule becomes the
> defacto custom policy.
>
> Even if a custom policy has been loaded, potentially additional
> measurements unrelated to this test would be included the measurement
> list.  One way of limiting a rule to a specific test is by loopback
> mounting a file system and defining a policy rule based on the loopback
> mount unique uuid.

Thanks Mimi!

I wonder if we simply limit this to policy to /tmp and run an executable
from /tmp (like test_local_storage.c does).

The only side effect would be of extra hashes being calculated on
binaries run from /tmp which is not too bad I guess?

We could do the loop mount too, but I am guessing the most clean way
would be to shell out to mount from the test? Are there some other examples
of IMA we could look at?

- KP

>
> Mimi
>
