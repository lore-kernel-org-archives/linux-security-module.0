Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DBBFC433DB
	for <linux-security-module@archiver.kernel.org>; Mon, 22 Mar 2021 07:54:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 19F6461937
	for <linux-security-module@archiver.kernel.org>; Mon, 22 Mar 2021 07:54:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229905AbhCVHyE (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 22 Mar 2021 03:54:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230012AbhCVHyA (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 22 Mar 2021 03:54:00 -0400
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7AB0C061574
        for <linux-security-module@vger.kernel.org>; Mon, 22 Mar 2021 00:53:59 -0700 (PDT)
Received: by mail-qk1-x733.google.com with SMTP id g15so9660425qkl.4
        for <linux-security-module@vger.kernel.org>; Mon, 22 Mar 2021 00:53:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gLRSZ9p0CZMIyqBziy7iz9HcUO6UY/LqAEu79X1+Jh0=;
        b=ErYo6sqKm+zFxbW5q5YWu4hy047L6uc7imUCqSKZUkOwdOpgwvjfAiuZWoDwOsH5r9
         ONBqE0Sw/v5XQxrZx95tFV1m9OxYu/VXB/ex3Hw4o4SWJZNX6qvenoL6ySpvoj/kr0ah
         4YRlAf5N59Mxv6+lIX5wj0dBE8Jj5rO9qZ1pAW3zAFookYmzUWYinCzsq1+Wo6spW40e
         5lAdxtOdD4GLQi2cliN6ic+XydNzOfabOxlfcAd7gyeAj7YTfCh/NPUtk3HGF7avpGfB
         VQRkmbqUDkNcegSHuKJ5g0oJDWaTpHsav/SGPbw/Xyd21jg8QJroGv5Tj9oC83et+Hn7
         Tq4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gLRSZ9p0CZMIyqBziy7iz9HcUO6UY/LqAEu79X1+Jh0=;
        b=tfriAS4fe1yWNyI/PSqy4TtYTo8fkHeeEqWPKeFg5WddpHIOWlvd8fUsOmE5nWqNGM
         HQe/hgzcIP8sZE9IncDqa/C4dVwtfis4x1LCbsF+K6jRIgruhxkncEAH/cIdipS8qopP
         0kHJwmT7jx25AY0d6F3pzOYrR8w3mrVk970Tk0WgwC+zUbY3QdVlwMd8JXJcumk/pI5L
         XhcUXwbi9IRwMgFpz/NA4xGJtj0iSWjJ9Ge2GrZ77hUFsGuH7OayBKAv6Qrt2Ifi8Tpx
         X7WoMQ904c2TU3L/3AnKsUWQgv4EbaESRCCt7bh+qIlRJw7GgRb/KYzxokOVhHYBVikp
         dXwA==
X-Gm-Message-State: AOAM5305tDQkPkkQ40TfwN5G5Dp/E+Eyv/311tqg7CH4DoM/jNeTqfK6
        wcv71BbSez7D6f8LjqM/yUsRArRE/KCvwo+/kkF1+w==
X-Google-Smtp-Source: ABdhPJzb2gkbOBjoz7XmTLXsLY5BljsCFIBrjT5ENjWHBxposoY6P0vTUMjZzc5xYuZEY8iPvha23YDFshc0x8QZXhU=
X-Received: by 2002:a05:620a:981:: with SMTP id x1mr9327233qkx.501.1616399638939;
 Mon, 22 Mar 2021 00:53:58 -0700 (PDT)
MIME-Version: 1.0
References: <20210319200358.22816-1-zohar@linux.ibm.com> <20210319200358.22816-2-zohar@linux.ibm.com>
 <8450c80a-104a-3f36-0963-0ae8fa69e0f2@i-love.sakura.ne.jp>
In-Reply-To: <8450c80a-104a-3f36-0963-0ae8fa69e0f2@i-love.sakura.ne.jp>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Mon, 22 Mar 2021 08:53:47 +0100
Message-ID: <CACT4Y+bvakfNhVs29QvbY6Z8Pw0zmAUKGWM-DD5DcPZW5ny90A@mail.gmail.com>
Subject: Re: [RFC PATCH 2/2] integrity: double check iint_cache was initialized
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Mimi Zohar <zohar@linux.ibm.com>, linux-integrity@vger.kernel.org,
        James Morris <jmorris@namei.org>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Eric Biggers <ebiggers@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Mon, Mar 22, 2021 at 8:11 AM Tetsuo Handa
<penguin-kernel@i-love.sakura.ne.jp> wrote:
>
> On 2021/03/20 5:03, Mimi Zohar wrote:
> > The integrity's "iint_cache" is initialized at security_init().  Only
> > after an IMA policy is loaded, which is initialized at late_initcall,
> > is a file's integrity status stored in the "iint_cache".
> >
> > All integrity_inode_get() callers first verify that the IMA policy has
> > been loaded, before calling it.  Yet for some reason, it is still being
> > called, causing a NULL pointer dereference.
> >
> > As reported by Dmitry Vyukov:
> > in qemu:
> > qemu-system-x86_64       -enable-kvm     -machine q35,nvdimm -cpu
> > max,migratable=off -smp 4       -m 4G,slots=4,maxmem=16G        -hda
> > wheezy.img      -kernel arch/x86/boot/bzImage   -nographic -vga std
> >  -soundhw all     -usb -usbdevice tablet  -bt hci -bt device:keyboard
> >    -net user,host=10.0.2.10,hostfwd=tcp::10022-:22 -net
> > nic,model=virtio-net-pci   -object
> > memory-backend-file,id=pmem1,share=off,mem-path=/dev/zero,size=64M
> >   -device nvdimm,id=nvdimm1,memdev=pmem1  -append "console=ttyS0
> > root=/dev/sda earlyprintk=serial rodata=n oops=panic panic_on_warn=1
> > panic=86400 lsm=smack numa=fake=2 nopcid dummy_hcd.num=8"   -pidfile
> > vm_pid -m 2G -cpu host
> >
>
> I tried similar command line (without "-enable-kvm" and without "-cpu host"
> as I'm running from VMware, without "-soundhw all", without "-machine q35,nvdimm"
> and "-device nvdimm,id=nvdimm1,memdev=pmem1" etc.) on 5.12-rc4. While I was finally
> able to hit similar crash when I used "-smp 1" instead of "-smp 4", I suspect
> this is not a integrity module's problem but a memory initialization/corruption
> problem, for I got various different crashes (INT3) at memory allocation when
> I was trimming command line options trying to reproduce the same crash.
>
> Dmitry, do you get different crashes by changing command line arguments?

No, I have not seen any other crashes, one the reported one.
