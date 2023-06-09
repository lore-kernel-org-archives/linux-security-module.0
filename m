Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CCD5C7EE29
	for <linux-security-module@archiver.kernel.org>; Fri,  9 Jun 2023 22:30:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229748AbjFIWaN (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 9 Jun 2023 18:30:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229733AbjFIWaL (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 9 Jun 2023 18:30:11 -0400
Received: from mail-ua1-x92f.google.com (mail-ua1-x92f.google.com [IPv6:2607:f8b0:4864:20::92f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98A75359D;
        Fri,  9 Jun 2023 15:30:10 -0700 (PDT)
Received: by mail-ua1-x92f.google.com with SMTP id a1e0cc1a2514c-786e09ce8c4so1915353241.0;
        Fri, 09 Jun 2023 15:30:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686349809; x=1688941809;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aecev+39GS4lgnVRWKrB28e2POzxz7KOG1cR4xPZO3Q=;
        b=enniWRBiQ4xe7rehaVKaEIBfTcbXbvnbV6e46PBKhL/+wx5qVi03Vi+CBtbx3RN9xG
         sQNN43ziHZWoEQAAu0ZeW3El31NumQATU7wMqw26tjSiyskSd8qUGw/0SIR1GVx5oRVI
         tUNNzthIam2a7jtq40UC+7kRhIOBCIA3VfvesUEY6EvH/GeCp0jqNtq9cgOYJeXKAapw
         UqQKzdgAas0MVz5S4tHPXNdd3YNjaRQuLAN8EPHHIHUEIMVNNk+TWQc7gmEO1MznReA1
         uTDp2/wSrbC9xXCEyc91mJsXek8JtaCA3RW3TQGH+PKPH7cfi6vKNJOUm7ezlP0XLf3x
         YtzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686349809; x=1688941809;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aecev+39GS4lgnVRWKrB28e2POzxz7KOG1cR4xPZO3Q=;
        b=N/S6LQAQnJtJ91ttdh7nip6PkQ8qefShQcaVS5okORPScjfrIsI5n+g6GbYsfTnMrU
         2cEzsZvadroLm2W6UdZt5qzmLwB/IMQfSvbW72WwyyGxgDfkIK+l+bgkVgnIEDXqyqm5
         aN2wa0KFsFZSNg+sVsgHrkLM7Y/VqUunteYHE4pe5QvLpPuCMJbChWHHLqptMPt8xd0T
         fnci9O4zF9ULbqA84KNrAmk2uVLWXd1f1isHvBTmVpTKC2/Fah7h10aP3iCAXJbS78NX
         fz8B1K07lk1MXM3yKdE9iIFva8u3UauFOH/BjxvqS+4uMvxrS/5S9bFWlb4nTX1jcoGm
         k9kQ==
X-Gm-Message-State: AC+VfDwTJORPgOfj2fGuGfvupiBlYGfv1Vn//bEN+nVPtQvgHe0jRFJr
        /CcLJhcv22MLWs19+hFVmmpMuxAKSu8TE+coyQhT5Mt7
X-Google-Smtp-Source: ACHHUZ4BkZGDh2f4Rot6L5r6FZBZgTXe3Q+BX11qSLNhb74MvQQFcdz7HUApelVU/IEnnnzzJA6ejnZ1Rcvj3KzN/YA=
X-Received: by 2002:a05:6102:1606:b0:434:c512:99d2 with SMTP id
 cu6-20020a056102160600b00434c51299d2mr2986323vsb.4.1686349809636; Fri, 09 Jun
 2023 15:30:09 -0700 (PDT)
MIME-Version: 1.0
References: <20230607235352.1723243-1-andrii@kernel.org>
In-Reply-To: <20230607235352.1723243-1-andrii@kernel.org>
From:   Djalal Harouni <tixxdz@gmail.com>
Date:   Sat, 10 Jun 2023 00:29:43 +0200
Message-ID: <CAEiveUdNrHfVXzF_6ogChifKyje3kA07pd8mpP+s24AEbKD7Cg@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 00/18] BPF token
To:     Andrii Nakryiko <andrii@kernel.org>
Cc:     bpf@vger.kernel.org, linux-security-module@vger.kernel.org,
        keescook@chromium.org, brauner@kernel.org, lennart@poettering.net,
        cyphar@cyphar.com, luto@kernel.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Hi Andrii,

On Thu, Jun 8, 2023 at 1:54=E2=80=AFAM Andrii Nakryiko <andrii@kernel.org> =
wrote:
>
> This patch set introduces new BPF object, BPF token, which allows to dele=
gate
> a subset of BPF functionality from privileged system-wide daemon (e.g.,
> systemd or any other container manager) to a *trusted* unprivileged
> application. Trust is the key here. This functionality is not about allow=
ing
> unconditional unprivileged BPF usage. Establishing trust, though, is
> completely up to the discretion of respective privileged application that
> would create a BPF token.
>
> The main motivation for BPF token is a desire to enable containerized
> BPF applications to be used together with user namespaces. This is curren=
tly
> impossible, as CAP_BPF, required for BPF subsystem usage, cannot be names=
paced
> or sandboxed, as a general rule. E.g., tracing BPF programs, thanks to BP=
F
> helpers like bpf_probe_read_kernel() and bpf_probe_read_user() can safely=
 read
> arbitrary memory, and it's impossible to ensure that they only read memor=
y of
> processes belonging to any given namespace. This means that it's impossib=
le to
> have namespace-aware CAP_BPF capability, and as such another mechanism to
> allow safe usage of BPF functionality is necessary. BPF token and delegat=
ion
> of it to a trusted unprivileged applications is such mechanism. Kernel ma=
kes
> no assumption about what "trusted" constitutes in any particular case, an=
d
> it's up to specific privileged applications and their surrounding
> infrastructure to decide that. What kernel provides is a set of APIs to c=
reate
> and tune BPF token, and pass it around to privileged BPF commands that ar=
e
> creating new BPF objects like BPF programs, BPF maps, etc.

Is there a reason for coupling this only with the userns?
The "trusted unprivileged" assumed by systemd can be in init userns?


> Previous attempt at addressing this very same problem ([0]) attempted to
> utilize authoritative LSM approach, but was conclusively rejected by upst=
ream
> LSM maintainers. BPF token concept is not changing anything about LSM
> approach, but can be combined with LSM hooks for very fine-grained securi=
ty
> policy. Some ideas about making BPF token more convenient to use with LSM=
 (in
> particular custom BPF LSM programs) was briefly described in recent LSF/M=
M/BPF
> 2023 presentation ([1]). E.g., an ability to specify user-provided data
> (context), which in combination with BPF LSM would allow implementing a v=
ery
> dynamic and fine-granular custom security policies on top of BPF token. I=
n the
> interest of minimizing API surface area discussions this is going to be
> added in follow up patches, as it's not essential to the fundamental conc=
ept
> of delegatable BPF token.
>
> It should be noted that BPF token is conceptually quite similar to the id=
ea of
> /dev/bpf device file, proposed by Song a while ago ([2]). The biggest
> difference is the idea of using virtual anon_inode file to hold BPF token=
 and
> allowing multiple independent instances of them, each with its own set of
> restrictions. BPF pinning solves the problem of exposing such BPF token
> through file system (BPF FS, in this case) for cases where transferring F=
Ds
> over Unix domain sockets is not convenient. And also, crucially, BPF toke=
n
> approach is not using any special stateful task-scoped flags. Instead, bp=
f()

What's the use case for transfering over unix domain sockets?

Will BPF token translation happen if you cross the different namespaces?

If the token is pinned into different bpffs, will the token share the
same context?
