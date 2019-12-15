Return-Path: <SRS0=H1aQ=2F=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FAB8C43603
	for <linux-security-module@archiver.kernel.org>; Sun, 15 Dec 2019 19:17:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38BBD24679
	for <linux-security-module@archiver.kernel.org>; Sun, 15 Dec 2019 19:17:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PZ+sjTSe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726267AbfLOTRW (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Sun, 15 Dec 2019 14:17:22 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:40444 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726232AbfLOTRW (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Sun, 15 Dec 2019 14:17:22 -0500
Received: by mail-ed1-f68.google.com with SMTP id b8so610841edx.7
        for <linux-security-module@vger.kernel.org>; Sun, 15 Dec 2019 11:17:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=iFxzwYSKDciEg6Lg4C/IpHY81Hh2FwfcfONl0+wr+08=;
        b=PZ+sjTSekoEGVNlZatxHVgs/m3dMpxVIMwTeYE9ldWKc0G1BLkeHS36re4JX3hDPls
         WY1O5qq0sL6WsloRN6S21X4ktKK6/pDedyPr4q0wtRi3B+ClTx9BiSpUGxnvXjLdophj
         75j4KeisGItzfGoUTpvNSZMRHlPkAsD4wmY4UsRSrlaqbcw7gQ2elNSRifP8OrVr5q0Y
         x6sLDJd6lU+lpwZly7gb6sb0IMOdfYyJUnBLBh4tBNflQq1AoXzAsCHn7MAZPXUFsMwP
         zCtV1c4aRD7MPNmDSLdSngbCHc+FhuTrxiCNJiulMfixmHOZLOuULA1VBcsF+COZIxM5
         Z34w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=iFxzwYSKDciEg6Lg4C/IpHY81Hh2FwfcfONl0+wr+08=;
        b=tlTcxzrY2mb7JImX+SZ2F/Z6cxW6EqgUaNT7muH/0KRfYgagx3YVpKoX5+IHMh8Z+S
         Be6/Xckj0vKgHc1id9EMGLkdmthABawz0BoPqsP1uqTbkPgDkdIphCUGniJSm4FRwuT5
         25sDZMh6zNCB+tqjnY6J48iXCK7GEzEMpVGUn6BrjdIz5xLNkLADYT95A9N9wGFr/BGY
         +laQCEuvSZvFmLU3eSZ3mjZQlUc650NOB15HHIFl44+qXgvGPygadgkxrSDX3bU0LL4O
         KuORkhhnfprdODuHnLtxsp1OuG/Y2Fwhd+1lEoBakxb3qReVLGqqq1wX1C0hm0NxdwI1
         B10g==
X-Gm-Message-State: APjAAAWNk388CVqUXa4edclVsE7o1QN9tFdwHme6tuE4pK7HjP80OBct
        V9uEFQM5PtAXGGPVMDLdyewDCirGtBUvNf92tL7Y3A==
X-Google-Smtp-Source: APXvYqy9zmbXRbDBzMdj6JrZIJuP07r1JH7+Mb6WrQYAcNqaRwl/9nfdl19TNLKUJr9j8fR4Vab4JNTtruhKH+m1S78=
X-Received: by 2002:aa7:c883:: with SMTP id p3mr28093586eds.130.1576437440543;
 Sun, 15 Dec 2019 11:17:20 -0800 (PST)
MIME-Version: 1.0
References: <CAKgNAkiyAkZy=oLrpJvHYU9Tq1dunNJLOJdtr508_w3vrdPWcQ@mail.gmail.com>
 <CALQRfL7i5r1d1K3fOuwyJ0BtmrsVMC8zzdd0Z7=14n3X8QNw5g@mail.gmail.com>
In-Reply-To: <CALQRfL7i5r1d1K3fOuwyJ0BtmrsVMC8zzdd0Z7=14n3X8QNw5g@mail.gmail.com>
Reply-To: mtk.manpages@gmail.com
From:   "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Date:   Sun, 15 Dec 2019 20:17:09 +0100
Message-ID: <CAKgNAkjuFOumKV6Z+GDDEjLrVup7fJB_H86xguJ7asdUdfEBxQ@mail.gmail.com>
Subject: Re: Anomalous output from getpcaps(1) for process with all capabilities
To:     "Andrew G. Morgan" <morgan@kernel.org>
Cc:     "Serge E. Hallyn" <serge@hallyn.com>,
        Andy Lutomirski <luto@kernel.org>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        ksrot@redhat.com
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Hello Andrew,

On Sun, 15 Dec 2019 at 19:30, Andrew G. Morgan <morgan@kernel.org> wrote:
>
> This changed with this commit I think:
>
> https://git.kernel.org/pub/scm/libs/libcap/libcap.git/commit/libcap/cap_text.c?id=3fa808f5886d08c45866217cfe6e6e9def7de04e
>
> Prior to that, we had "=ep" mean the cap set was ~0 for
> all the bitmasks in e and p. When we started to clip the
>bounding set to only defined capabilities, it meant that the
> text output started to look like
> "=ep 33,34,35,36,37,38,39,40,41,42.....63-ep" which
> was quite terrible.

Was that really the change that caused this? That's a 2008 commit.
Certainly, I recall in 2014 or 2015 still being able to see =ep, and I
presume (but do not recall for sure) that I was using a system with a
libcap more recent than v2.11 (of which that commit was a part).

> So, this was seen as the least worst option.

But surely this is fixable? Or, to put it another was, I presume
there's something that makes this difficult to fix in getpcaps, but
what is that something?

Thanks,

Michael

-- 
Michael Kerrisk
Linux man-pages maintainer; http://www.kernel.org/doc/man-pages/
Linux/UNIX System Programming Training: http://man7.org/training/
