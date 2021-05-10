Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_RED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61804C433ED
	for <linux-security-module@archiver.kernel.org>; Mon, 10 May 2021 17:47:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4367F611F0
	for <linux-security-module@archiver.kernel.org>; Mon, 10 May 2021 17:47:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232984AbhEJRsm (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 10 May 2021 13:48:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:56800 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232942AbhEJRsl (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 10 May 2021 13:48:41 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 94B72614A7
        for <linux-security-module@vger.kernel.org>; Mon, 10 May 2021 17:47:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620668856;
        bh=LxXDkuPWjPQk4BmdoXaxIQ+fI40u1+HYDgg51chi/dQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=FzFrcSOFgyjvVtFkpiu6+C/STNJuhbAaHo/DOw/NYxZvNS6ZGgaVJAqpg9gIKT1Ms
         VB6gj6QPLcaVh+L7+RFNXnJpvK0m7zTEGGlAAsMytaqWncu1fp0C/IwWmFVxM1jZwA
         u2ysW4OjGP13tL/9yvCPdVvVH69beEDByCln/iG+oSgAVwfFuNe7HQyGv6itb/eohr
         Izh/oA20a9kgy4yRBfR24MMtOm7a3Di/007vrMj1ra9aKkxAU7BsuJ3frzzqGIzn0n
         9llxTT3hAepIrRV2U1TRLD0MnpxE8pPhEr1eazWVXg7SH1/dTar9ltIHgZwWqmwiFK
         JW73YP9Pr4W6A==
Received: by mail-ej1-f49.google.com with SMTP id s20so20291108ejr.9
        for <linux-security-module@vger.kernel.org>; Mon, 10 May 2021 10:47:36 -0700 (PDT)
X-Gm-Message-State: AOAM532rCAmJN6KSAnSqfLHnMb60uXveTWnl4JYgH7AJVQmRiTaGpoIJ
        LZYK3PM58X3osg5XaVkYRPhW4XyHGEt9cFJso3Gkcw==
X-Google-Smtp-Source: ABdhPJy2u4NRHO7LXCrZDzVo0MGiSrS4ukdNDyUpYt96TNfdTFbw5aaY0iqnaNSKOQ9xWZbpI6ahZnrIdR2D6q8tRLM=
X-Received: by 2002:a17:907:1629:: with SMTP id hb41mr27755324ejc.316.1620668855059;
 Mon, 10 May 2021 10:47:35 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1620499942.git.yifeifz2@illinois.edu>
In-Reply-To: <cover.1620499942.git.yifeifz2@illinois.edu>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Mon, 10 May 2021 10:47:22 -0700
X-Gmail-Original-Message-ID: <CALCETrUQBonh5BC4eomTLpEOFHVcQSz9SPcfOqNFTf2TPht4-Q@mail.gmail.com>
Message-ID: <CALCETrUQBonh5BC4eomTLpEOFHVcQSz9SPcfOqNFTf2TPht4-Q@mail.gmail.com>
Subject: Re: [RFC PATCH bpf-next seccomp 00/12] eBPF seccomp filters
To:     YiFei Zhu <zhuyifei1999@gmail.com>
Cc:     containers@lists.linux.dev, bpf <bpf@vger.kernel.org>,
        YiFei Zhu <yifeifz2@illinois.edu>,
        LSM List <linux-security-module@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Austin Kuo <hckuo2@illinois.edu>,
        Claudio Canella <claudio.canella@iaik.tugraz.at>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Daniel Gruss <daniel.gruss@iaik.tugraz.at>,
        Dimitrios Skarlatos <dskarlat@cs.cmu.edu>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        Hubertus Franke <frankeh@us.ibm.com>,
        Jann Horn <jannh@google.com>,
        Jinghao Jia <jinghao7@illinois.edu>,
        Josep Torrellas <torrella@illinois.edu>,
        Kees Cook <keescook@chromium.org>,
        Sargun Dhillon <sargun@sargun.me>,
        Tianyin Xu <tyxu@illinois.edu>,
        Tobin Feldman-Fitzthum <tobin@ibm.com>,
        Tom Hromatka <tom.hromatka@oracle.com>,
        Will Drewry <wad@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Mon, May 10, 2021 at 10:22 AM YiFei Zhu <zhuyifei1999@gmail.com> wrote:
>
> From: YiFei Zhu <yifeifz2@illinois.edu>
>
> Based on: https://lists.linux-foundation.org/pipermail/containers/2018-February/038571.html
>
> This patchset enables seccomp filters to be written in eBPF.
> Supporting eBPF filters has been proposed a few times in the past.
> The main concerns were (1) use cases and (2) security. We have
> identified many use cases that can benefit from advanced eBPF
> filters, such as:

I haven't reviewed this carefully, but I think we need to distinguish
a few things:

1. Using the eBPF *language*.

2. Allowing the use of stateful / non-pure eBPF features.

3. Allowing the eBPF programs to read the target process' memory.

I'm generally in favor of (1).  I'm not at all sure about (2), and I'm
even less convinced by (3).

>
>   * exec-only-once filter / apply filter after exec

This is (2).  I'm not sure it's a good idea.

>   * syscall logging (eg. via maps)

This is (2).  Probably useful, but doesn't obviously belong in
seccomp, or at least not as part of the same seccomp feature as
regular filtering.

>   * expressiveness & better tooling (no need for DSLs like easyseccomp)

(1).  Sounds good.

>   * contained syscall fault injection

(2)?  We can already do this with notifiers.

> For security, for an unprivileged caller, our implementation is as
> restrictive as user notifier + ptrace, in regards to capabilities.
> eBPF helpers follow the privilege model of original eBPF helpers.

eBPF doesn't really have a privilege model yet.  There was a long and
disappointing thread about this awhile back.

> Moreover, a mechanism for reading user memory is added. The same
> prototypes of bpf_probe_read_user{,str} from tracing are used. However,
> when the loader of bpf program does not have CAP_PTRACE, the helper
> will return -EPERM if the task under seccomp filter is non-dumpable.
> The reason for this is that if we perform reduction from seccomp-eBPF
> to user notifier + ptrace, ptrace requires CAP_PTRACE to read from
> a non-dumpable process. However, eBPF does not solve the TOCTOU problem
> of user notifier, so users should not use this to enforce a policy
> based on memory contents.

What is this for?
