Return-Path: <SRS0=KC/c=AR=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DE53C433E0
	for <linux-security-module@archiver.kernel.org>; Mon,  6 Jul 2020 20:31:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5CAE320702
	for <linux-security-module@archiver.kernel.org>; Mon,  6 Jul 2020 20:31:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Ac/VoY7B"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727028AbgGFUbC (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 6 Jul 2020 16:31:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726634AbgGFUbB (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 6 Jul 2020 16:31:01 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47F86C08C5DF
        for <linux-security-module@vger.kernel.org>; Mon,  6 Jul 2020 13:31:01 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id q5so42615271wru.6
        for <linux-security-module@vger.kernel.org>; Mon, 06 Jul 2020 13:31:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=b00l0G+v45Z6tIxVmpU8zc8V+eHm6VMqCzw//xyzaXg=;
        b=Ac/VoY7BZFHgX6kKaPiIAhNAqsNuZHFvXEVjQHFhp+JipFaTKiLwOCsJichH8N/rmV
         fgxylTgGY1CHeSyVq4+h4/u1lbaRFBUMmVw7qS1zxFtuN9wZBumR9qzyWD4CPpANWweN
         uncBbqUzwecZP1Z4mjyC429r2imOn/w4Sj1Uc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=b00l0G+v45Z6tIxVmpU8zc8V+eHm6VMqCzw//xyzaXg=;
        b=AGulXI6Pq4c/5CaQVd60vbDCJmadIkxm8gfNZqnHjPZoq/ue90Jk+KTs7H9/lx/wsL
         uv74VtrSLW1echCPYUfvLRk4kuCqyK1n0IjJPU5iAbG28vDi7z74K+9ruZ4+M1aXVJhb
         ciEmetM6D8iUe0+3LKRTO4EQMR7SvFOQaebTXyTKM0/QUq5OG5/+ceEQHjEoeRKduQzL
         ZIlC3a3aNZTmocL1ChA1UAIAVGcsQWkZls5bf5prtHQsQbNhQibgS3pYWEJBGQFXmsGX
         OI7nqU8xRHfn0VkPg0MCeaPMutEH2bRGDWliWh9ZymxDqfHGe7K0OpdvkXPmEbDxSFOT
         wTMg==
X-Gm-Message-State: AOAM532IxFIZrpmD2NwP16wDPG1O+93vRuFBKS2iuKyZwHe8LzarSBJ3
        ZLo2ngC92X0NvvImg6eKILsjmQauniPdvmWAtjegjg==
X-Google-Smtp-Source: ABdhPJxzqxg7ODsjN+Zw2qrFp2pSD2AUwlJkUrE9/Usg4o1cF+hyARDxBZjq1GBWd1Rya+aGg5GqVYj4DfYfMvkxVWg=
X-Received: by 2002:a05:6000:86:: with SMTP id m6mr17934611wrx.173.1594067459857;
 Mon, 06 Jul 2020 13:30:59 -0700 (PDT)
MIME-Version: 1.0
References: <20200706165710.GA208695@gallifrey> <9268bd47-93db-1591-e224-8d3da333636e@iogearbox.net>
 <CACYkzJ78HOP8SZ3jU0DnH0b4f8580AuP4fdG5K3xgaHa8VYaZw@mail.gmail.com> <20200706200640.GA234619@gallifrey>
In-Reply-To: <20200706200640.GA234619@gallifrey>
From:   KP Singh <kpsingh@chromium.org>
Date:   Mon, 6 Jul 2020 22:30:49 +0200
Message-ID: <CACYkzJ7sT=9+z8Gvee-ewT86T-HN24Xri1zYeeiOQiumNsCRJQ@mail.gmail.com>
Subject: Re: [PATCH] bpf: lsm: Disable or enable BPF LSM at boot time
To:     Lorenzo Fontana <fontanalorenz@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        open list <linux-kernel@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>,
        Linux Security Module list 
        <linux-security-module@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andriin@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Mon, Jul 6, 2020 at 10:06 PM Lorenzo Fontana <fontanalorenz@gmail.com> wrote:
>
> On Mon, Jul 06, 2020 at 08:59:13PM +0200, KP Singh wrote:
> > On Mon, Jul 6, 2020 at 8:51 PM Daniel Borkmann <daniel@iogearbox.net> wrote:
> > >
> > > On 7/6/20 6:57 PM, Lorenzo Fontana wrote:
> > > > This option adds a kernel parameter 'bpf_lsm',
> > > > which allows the BPF LSM to be disabled at boot.
> > > > The purpose of this option is to allow a single kernel
> > > > image to be distributed with the BPF LSM built in,
> > > > but not necessarily enabled.
> > > >
> > > > Signed-off-by: Lorenzo Fontana <fontanalorenz@gmail.com>
> > >
> > > Well, this explains what the patch is doing but not *why* you need it exactly.
> > > Please explain your concrete use-case for this patch.
> >
> > Also, this patch is not really needed as it can already be done with the current
> > kernel parameters.
> >
> > LSMs can be enabled on the command line
> > with the lsm= parameter. So you can just pass lsm="selinux,capabilities" etc
> > and not pass "bpf" and it will disable the BPF_LSM.
> >
> > - KP
> >
> > >
> > > Thanks,
> > > Daniel
>
> Hi,
> Thanks Daniel and KP for looking into this, I really appreciate it!
>
> The *why* I need it is because I need to ship the kernel with BPF LSM
> disabled at boot time.
>
> The use case is exactly the same as the one described by KP, however
> for a personal preference I prefer to pass specifically bpf_lsm=1 or
> bpf_lsm=0 - It's easier to change programmatically in my scripts
> with a simple sprintf("bpf_lsm=%d", value). I do the same
> with "selinux=1" and "selinux=0" in my systems.
> From what I can see by reading the code and testing, the two ways
> bot act on 'lsm_info.enabled' defined in 'lsm_hooks.h'.
> So it's not just  a personal preference, I just want the same set
> of options available to me as I do with selinux.

The "selinux=" option existed before the "lsm=" parameter was added and it
now exists only for backward compatibility. I added Paul and Stephen to Cc
who might have more information about this.

- KP

>
> Thanks a lot,
> Lore
