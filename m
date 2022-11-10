Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92F2CC4332F
	for <linux-security-module@archiver.kernel.org>; Thu, 10 Nov 2022 21:05:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229595AbiKJVFG (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 10 Nov 2022 16:05:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231309AbiKJVFC (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 10 Nov 2022 16:05:02 -0500
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31E5C4E410
        for <linux-security-module@vger.kernel.org>; Thu, 10 Nov 2022 13:04:58 -0800 (PST)
Received: by mail-ot1-x330.google.com with SMTP id 46-20020a9d0631000000b00666823da25fso1849904otn.0
        for <linux-security-module@vger.kernel.org>; Thu, 10 Nov 2022 13:04:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=MIrljlA1dEtBNb/SQwVUbOm8b8PLiK9imBoRLMqAwOM=;
        b=5FoAs7dr/wOchaUTGl/b0nYwRXinDLnGoOv0h+fep/0JC0/sv1eoPL1n/efnv3SVsM
         7yQzWdA35UMFnrCREAr5KLtOCGLLQW4fpxty2Vjv0m0ioH8N5d1ZZrTOSUqBkKuVl3Qm
         FiUDd1g3SBIzV5cuMBl6MrqZ6pYJLnPWzHMlyG4uw4XzG5+AW+8vKGIDcpDvno1l1IaT
         0nloMmE5CdKCabKhnx3cU0I6exqxxfDw09UgP/wIuag8fa/Dp77+51STHkdLpkI8A3UD
         E4+pbPkOolbdSczwSEUjP0sTCi0FS/PmKtO53Fd0j9u0nDiYpwgcgPGCF4U6h7QbEJP5
         sY+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MIrljlA1dEtBNb/SQwVUbOm8b8PLiK9imBoRLMqAwOM=;
        b=7AjfeORXbTIsCgyDkUJ0GD9ZHr2HQ05Es5K64E5ikdIx8yqp3vfeB9lfoxRc7BHYWQ
         KPGkD512YPi38B6+7iDxT6vULlwqkT6zeLejBZR8M1MZX8ZfWfemJktJsDDat3jKqQ9G
         ciG8NwocQgeqY3z4rM2QjjgC+0V2Z9J0NuFYhHwEdbmFl/DS5KP7FJxqhYa6Rfz8P7CS
         zIqmlO5L8wuACHzb8xRHt7udPkctPYxnSIvAbeIX3ViJMwpRgSYwyPviAZ1os/W09sFI
         wtsGZPxTEkzfA8emQypF35kIoN4AeJNVA5Iud9MP24I9sk6NWgTgXghefHurzfukfEdY
         VqwQ==
X-Gm-Message-State: ACrzQf1CJrvIptjfrOMUEj3qXs2V1gIyhUfaBX+rf5r8oxh3fV1QrnjF
        ikxhuY5gF0y7H/oBbUm609d50C0QYgEk0Gve3FuU799JCRCN
X-Google-Smtp-Source: AMsMyM61pxTlWJ/CpIa/bZyF6jsToHWzHHVWCcQYEFS5vW6C2awDGiTfoblGb9FXRye+y2lGs2HToS5+l7V3lfn3fl8=
X-Received: by 2002:a9d:71cb:0:b0:66c:3703:f04e with SMTP id
 z11-20020a9d71cb000000b0066c3703f04emr2095693otj.287.1668114297404; Thu, 10
 Nov 2022 13:04:57 -0800 (PST)
MIME-Version: 1.0
References: <20221107205754.2635439-1-cukie@google.com> <CAHC9VhTLBWkw2XzqdFx1LFVKDtaAL2pEfsmm+LEmS0OWM1mZgA@mail.gmail.com>
 <CABXk95ChjusTneWJgj5a58CZceZv0Ay-P-FwBcH2o4rO0g2Ggw@mail.gmail.com>
In-Reply-To: <CABXk95ChjusTneWJgj5a58CZceZv0Ay-P-FwBcH2o4rO0g2Ggw@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 10 Nov 2022 16:04:46 -0500
Message-ID: <CAHC9VhRTWGuiMpJJiFrUpgsm7nQaNA-n1CYRMPS-24OLvzdA2A@mail.gmail.com>
Subject: Re: [PATCH v1 0/2] Add LSM access controls for io_uring_setup
To:     Jeffrey Vander Stoep <jeffv@google.com>
Cc:     Gil Cukierman <cukie@google.com>, Jens Axboe <axboe@kernel.dk>,
        Pavel Begunkov <asml.silence@gmail.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>, kernel-team@android.com,
        linux-kernel@vger.kernel.org, io-uring@vger.kernel.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Thu, Nov 10, 2022 at 12:54 PM Jeffrey Vander Stoep <jeffv@google.com> wrote:
> On Mon, Nov 7, 2022 at 10:17 PM Paul Moore <paul@paul-moore.com> wrote:
> >
> > On Mon, Nov 7, 2022 at 3:58 PM Gil Cukierman <cukie@google.com> wrote:
> > >
> > > This patchset provides the changes required for controlling access to
> > > the io_uring_setup system call by LSMs. It does this by adding a new
> > > hook to io_uring. It also provides the SELinux implementation for a new
> > > permission, io_uring { setup }, using the new hook.
> > >
> > > This is important because existing io_uring hooks only support limiting
> > > the sharing of credentials and access to the sensitive uring_cmd file
> > > op. Users of LSMs may also want the ability to tightly control which
> > > callers can retrieve an io_uring capable fd from the kernel, which is
> > > needed for all subsequent io_uring operations.
> >
> > It isn't immediately obvious to me why simply obtaining a io_uring fd
> > from io_uring_setup() would present a problem, as the security
> > relevant operations that are possible with that io_uring fd *should*
> > still be controlled by other LSM hooks.  Can you help me understand
> > what security issue you are trying to resolve with this control?
>
> I think there are a few reasons why we want this particular hook.
>
> 1.  It aligns well with how other resources are managed by selinux
> where access to the resource is the first control point (e.g. "create"
> for files, sockets, or bpf_maps, "prog_load" for bpf programs, and
> "open" for perf_event) and then additional functionality or
> capabilities require additional permissions.

[NOTE: there were two reply sections in your email, and while similar,
they were not identical; I've trimmed the other for the sake of
clarity]

The resources you mention are all objects which contain some type of
information (either user data, configuration, or program
instructions), with the resulting fd being a handle to those objects.
In the case of io_uring the fd is a handle to the io_uring
interface/rings, which by itself does not contain any information
which is not already controlled by other permissions.

I/O operations which transfer data between the io_uring buffers and
other system objects, e.g. IORING_OP_READV, are still subject to the
same file access controls as those done by the application using
syscalls.  Even the IORING_OP_OPENAT command goes through the standard
VFS code path which means it will trigger the same access control
checks as an open*() done by the application normally.

The 'interesting' scenarios are those where the io_uring operation
servicing credentials, aka personalities, differ from the task
controlling the io_uring.  However in those cases we have the new
io_uring controls to gate these delegated operations.  Passing an
io_uring fd is subject to the fd/use permission like any other fd.

Although perhaps the most relevant to your request is the fact that
the io_uring inode is created using the new(ish) secure anon inode
interface which ensures that the creating task has permission to
create an io_uring.  This io_uring inode label also comes into play
when a task attempts to mmap() the io_uring rings, a critical part of
the io_uring API.

If I'm missing something you believe to be important, please share the details.

> 2. It aligns well with how resources are managed on Android. We often
> do not grant direct access to resources (like memory buffers).

Accessing the io_uring buffers requires a task to mmap() the io_uring
fd which is controlled by the normal SELinux mmap() access controls.

> 3. Attack surface management. One of the primary uses of selinux on
> Android is to assess and limit attack surface (e.g.
> https://twitter.com/jeffvanderstoep/status/1422771606309335043) . As
> io_uring vulnerabilities have made their way through our vulnerability
> management system, it's become apparent that it's complicated to
> assess the impact. Is a use-after-free reachable? Creating
> proof-of-concept exploits takes a lot of time, and often functionality
> can be reached by multiple paths. How many of the known io_uring
> vulnerabilities would be gated by the existing checks? How many future
> ones will be gated by the existing checks? I don't know the answer to
> either of these questions and it's not obvious. This hook makes that
> initial assessment simple and effective.

It should be possible to deny access to io_uring via the anonymous
inode labels, the mmap() controls, and the fd/use permission.  If you
find a way to do meaningful work with an io_uring fd that can't be
controlled via an existing permission check please let me know.

--
paul-moore.com
