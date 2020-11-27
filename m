Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04EE9C63798
	for <linux-security-module@archiver.kernel.org>; Fri, 27 Nov 2020 13:10:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8A40322248
	for <linux-security-module@archiver.kernel.org>; Fri, 27 Nov 2020 13:10:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="EYRtiIpZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730270AbgK0NJs (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 27 Nov 2020 08:09:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729580AbgK0NJr (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 27 Nov 2020 08:09:47 -0500
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3998C0617A7
        for <linux-security-module@vger.kernel.org>; Fri, 27 Nov 2020 05:09:46 -0800 (PST)
Received: by mail-lj1-x242.google.com with SMTP id s9so5838165ljo.11
        for <linux-security-module@vger.kernel.org>; Fri, 27 Nov 2020 05:09:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RViarWIqyoq/ayFT+noWEVBCT5Qp7dKKwNqyH4mKwAI=;
        b=EYRtiIpZ9RlOHG2risep3WX76M0vCjzPqwbDOaLXliSRyvVurBBUKydX+E3fhjKq9c
         j1QAhakUQFaTmyK/CiU1WA01SLocE+BW/S6qwAqHzrZbWFTwpTjwyrNOuSInwBxCxBhl
         hpMCIwrrBn+2RToDeN2ieT4fW/PG4IXtHOruA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RViarWIqyoq/ayFT+noWEVBCT5Qp7dKKwNqyH4mKwAI=;
        b=EmALEp8bD9DHcuLZ2lgOoKukvdTFGmN4Gjl27Dv14Sos0Lw9jpcBaMt7jFPvNJy99+
         3st0ecFwjMYbGN1JWu7KVxrrykgEfY+a549YxhAXDECJ0h7xqXGfRaA+mLeIfopQ3WbD
         iLyWSioLvZQplgF2CrgMzGRm57/I54At7i4YvnumItAZEHgIrojm/XMCbuCGlYKM99lb
         RU3ba5f1GENWXXrszBtKnEAh5clP3aIeOGtU+4Lv7XjDXhdyS0HUTI4j0NPkrTVgJkJf
         d1ISgRl2YyqIirIUc6p8vt0kUOmfKyIGdHiZENMh4Aesf9BLIoQJ5LnMwSTYKaMpY0fJ
         CS8Q==
X-Gm-Message-State: AOAM532xXvBtz8rtmAsjvgb2QBkPFZJsftgpaE14v7ZHQ9TRifb6woVH
        TBb5ccAoAqV/MAenGyT4PMqL0Cob1aOiAjdA4orTOw==
X-Google-Smtp-Source: ABdhPJwey4p3rPhSFKkHCs0zkk0IHDRamVnPb59Oe2QyeTvSdl8qmH0dC49E5IZf42YNnT8dfB2dGPtXrBsyV2KqeVo=
X-Received: by 2002:a2e:8e3b:: with SMTP id r27mr3451519ljk.466.1606482583760;
 Fri, 27 Nov 2020 05:09:43 -0800 (PST)
MIME-Version: 1.0
References: <20201124151210.1081188-1-kpsingh@chromium.org>
 <20201124151210.1081188-4-kpsingh@chromium.org> <CAEf4BzbDKX8+AaueNngEeGnWQLfN0Fy+jgcxrwbeLeVfVh0E9Q@mail.gmail.com>
In-Reply-To: <CAEf4BzbDKX8+AaueNngEeGnWQLfN0Fy+jgcxrwbeLeVfVh0E9Q@mail.gmail.com>
From:   KP Singh <kpsingh@chromium.org>
Date:   Fri, 27 Nov 2020 14:09:33 +0100
Message-ID: <CACYkzJ5t3McRMmCDQwRXD2n=1QLsgWWOFfJ_iXGGYP5yqorsEQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 3/3] bpf: Add a selftest for bpf_ima_inode_hash
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     James Morris <jmorris@namei.org>,
        open list <linux-kernel@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>,
        Linux Security Module list 
        <linux-security-module@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Florent Revest <revest@chromium.org>,
        Brendan Jackman <jackmanb@chromium.org>,
        Mimi Zohar <zohar@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Fri, Nov 27, 2020 at 5:29 AM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Tue, Nov 24, 2020 at 7:16 AM KP Singh <kpsingh@chromium.org> wrote:
> >
> > From: KP Singh <kpsingh@google.com>
> >

[...]

>
> > +cleanup() {
> > +        local tmp_dir="$1"
> > +        local mount_img="${tmp_dir}/test.img"
> > +        local mount_dir="${tmp_dir}/mnt"
> > +
> > +        local loop_devices=$(losetup -j ${mount_img} -O NAME --noheadings)
>
> libbpf and kernel-patches CIs are using BusyBox environment which has
> losetup that doesn't support -j option. Is there some way to work
> around that? What we have is this:
>
> BusyBox v1.31.1 () multi-call binary.
>
> Usage: losetup [-rP] [-o OFS] {-f|LOOPDEV} FILE: associate loop devices
>
>     losetup -c LOOPDEV: reread file size
>
>     losetup -d LOOPDEV: disassociate
>
>     losetup -a: show status

I can try to grep and parse the status output as a fallback. Will send another
fix.

- KP

>
>     losetup -f: show next free loop device
>
>     -o OFS    Start OFS bytes into FILE
>
>     -P    Scan for partitions
>
>     -r    Read-only
>
>     -f    Show/use next free loop device
>
>
> > +        for loop_dev in "${loop_devices}"; do

[...]
