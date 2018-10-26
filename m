Return-Path: <SRS0=VgA4=NG=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAD47ECDE44
	for <linux-security-module@archiver.kernel.org>; Fri, 26 Oct 2018 10:46:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8721320856
	for <linux-security-module@archiver.kernel.org>; Fri, 26 Oct 2018 10:46:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Fiwx4b64"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8721320856
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-security-module-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726796AbeJZTXJ (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 26 Oct 2018 15:23:09 -0400
Received: from mail-yb1-f196.google.com ([209.85.219.196]:35468 "EHLO
        mail-yb1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726128AbeJZTXI (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 26 Oct 2018 15:23:08 -0400
Received: by mail-yb1-f196.google.com with SMTP id k132-v6so273871ybc.2
        for <linux-security-module@vger.kernel.org>; Fri, 26 Oct 2018 03:46:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=c/WqbMWHMcD/8iKow4AF4NNyb4XgPQah5Hm7QPT62b4=;
        b=Fiwx4b64jA9UIjAnt67rUn29Okv8mTMVOXlacT/zJC0Fyc31MoUNJOmWONxOshbuXb
         f3wd3Rz2GsP+FCCCkRCA7Dz+krUmhdZ+CuiwtprfAFKcxKl6capY3iQ/TZcOSg5pHpGa
         hGLe1qRsPKYDAuDncrv5cScHAY3lJBmr8Id2I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=c/WqbMWHMcD/8iKow4AF4NNyb4XgPQah5Hm7QPT62b4=;
        b=Kr3ia7ksHM1TKPSphuJXe95h0sxGGxX5jRWvCliYy7u3OyZZiFOuLz4mF6ugnBLmzX
         NujVkx7YCNWMkl1GgAAFB/89X3SvoUw5VSHa8UL4MTh7xQD8z2p95JRXU/SNr4FVoVuA
         fV7/vnv7Sj/QtX6vOaME8+vvszeRk/obVsqEPVqjmTriF6edM+LMWioI8OZ5k4Vwdr66
         msN4aO/U3CzRuL4iH+2y7MARlxxt4d9f/NnpKHRzwK4NSwmBgX6YPmYT2UIsesB9hwxc
         dJzbL5W/FNn7gm65ZrilXmCscIveoQC4u1FZTEG7rf2JGI6QJfUPGSqNRfYMJ6Zjho+I
         CF2g==
X-Gm-Message-State: AGRZ1gL8LDkhdAe7KAV3zITI6D44lqXvj52gmfqBiwKhWEQpFSVH0Ie9
        TK7QD5zeo6cxwr6VwSvDo0S7sWcMp5DFFw==
X-Google-Smtp-Source: AJdET5d2td0pOLC0UyhwWk35MzA4btIXtKRrI07yP31T6ZX/6HouwtkhmVx/j1H/oai5FeyJpVgCaA==
X-Received: by 2002:a25:6ad6:: with SMTP id f205-v6mr2838004ybc.278.1540550792451;
        Fri, 26 Oct 2018 03:46:32 -0700 (PDT)
Received: from mail-yw1-f46.google.com (mail-yw1-f46.google.com. [209.85.161.46])
        by smtp.gmail.com with ESMTPSA id 207-v6sm2897191yww.21.2018.10.26.03.46.30
        for <linux-security-module@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Oct 2018 03:46:31 -0700 (PDT)
Received: by mail-yw1-f46.google.com with SMTP id c126-v6so255228ywd.8
        for <linux-security-module@vger.kernel.org>; Fri, 26 Oct 2018 03:46:30 -0700 (PDT)
X-Received: by 2002:a81:9b83:: with SMTP id s125-v6mr2804635ywg.47.1540550790136;
 Fri, 26 Oct 2018 03:46:30 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:3990:0:0:0:0:0 with HTTP; Fri, 26 Oct 2018 03:46:28
 -0700 (PDT)
In-Reply-To: <20181026092609.GB3159@worktop.c.hoisthospitality.com>
References: <20181023213504.28905-1-igor.stoppa@huawei.com>
 <20181023213504.28905-11-igor.stoppa@huawei.com> <20181026092609.GB3159@worktop.c.hoisthospitality.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Fri, 26 Oct 2018 11:46:28 +0100
X-Gmail-Original-Message-ID: <CAGXu5jKCs01jvtvpEFS7R8qCR-5iRqK11kJxLJY99NicGWc4aQ@mail.gmail.com>
Message-ID: <CAGXu5jKCs01jvtvpEFS7R8qCR-5iRqK11kJxLJY99NicGWc4aQ@mail.gmail.com>
Subject: Re: [PATCH 10/17] prmem: documentation
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Igor Stoppa <igor.stoppa@gmail.com>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Matthew Wilcox <willy@infradead.org>,
        Dave Chinner <david@fromorbit.com>,
        James Morris <jmorris@namei.org>,
        Michal Hocko <mhocko@kernel.org>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        Igor Stoppa <igor.stoppa@huawei.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Laura Abbott <labbott@redhat.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Fri, Oct 26, 2018 at 10:26 AM, Peter Zijlstra <peterz@infradead.org> wrote:
> I still don't really understand the whole write-rare thing; how does it
> really help? If we can write in kernel memory, we can write to
> page-tables too.

I can speak to the general goal. The specific implementation here may
not fit all the needs, but it's a good starting point for discussion.

One aspect of hardening the kernel against attack is reducing the
internal attack surface. Not all flaws are created equal, so there is
variation in what limitations an attacker may have when exploiting
flaws (not many flaws end up being a fully controlled "write anything,
anywhere, at any time"). By making the more sensitive data structures
of the kernel read-only, we reduce the risk of an attacker finding a
path to manipulating the kernel's behavior in a significant way.

Examples of typical sensitive targets are function pointers, security
policy, and page tables. Having these "read only at rest" makes them
much harder to control by an attacker using memory integrity flaws. We
already have the .rodata section for "const" things. Those are
trivially read-only. For example there is a long history of making
sure that function pointer tables are marked "const". However, some
things need to stay writable. Some of those in .data aren't changed
after __init, so we added the __ro_after_init which made them
read-only for the life of the system after __init. However, we're
still left with a lot of sensitive structures either in .data or
dynamically allocated, that need a way to be made read-only for most
of the time, but get written to during very specific times.

The "write rarely" name itself may not sufficiently describe what is
wanted either (I'll take the blame for the inaccurate name), so I'm
open to new ideas there. The implementation requirements for the
"sensitive data read-only at rest" feature are rather tricky:

- allow writes only from specific places in the kernel
- keep those locations inline to avoid making them trivial ROP targets
- keep the writeability window open only to a single uninterruptable CPU
- fast enough to deal with page table updates

The proposal I made a while back only covered .data things (and used
x86-specific features). Igor's proposal builds on this by including a
way to do this with dynamic allocation too, which greatly expands the
scope of structures that can be protected. Given that the x86-only
method of write-window creation was firmly rejected, this is a new
proposal for how to do it (vmap window). Using switch_mm() has also
been suggested, etc.

We need to find a good way to do the write-windowing that works well
for static and dynamic structures _and_ for the page tables... this
continues to be tricky.

Making it resilient against ROP-style targets makes it difficult to
deal with certain data structures (like list manipulation). In my
earlier RFC, I tried to provide enough examples of where this could
get used to let people see some of the complexity[1]. Igor's series
expands this to even more examples using dynamic allocation.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git/log/?h=kspp/write-rarely

-- 
Kees Cook
