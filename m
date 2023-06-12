Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0ED7CC7EE23
	for <linux-security-module@archiver.kernel.org>; Mon, 12 Jun 2023 12:46:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229635AbjFLMqC (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 12 Jun 2023 08:46:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229604AbjFLMp7 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 12 Jun 2023 08:45:59 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79E47E47
        for <linux-security-module@vger.kernel.org>; Mon, 12 Jun 2023 05:45:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686573911;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hyQ3S9+kYkQ7HHeHqSJCVtbsTtOI1/AI5ZDtFaJXJdE=;
        b=QOKjE1hYbA9HZQ9llceemU0vwX5ccKHNciqM12tLVAXqmcw6bV2LZ/j5cI9pNWSC0RS8ds
        Mf0f8wTQUgMBk7H/eUY2lxfxzrl6saMD/JM1VhKOxIq6RGKKAjCmeXhIts6rtLx+KvWmGg
        hSfPLfgKSWgiysle6jPV776tLLJXrbs=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-136-0mp_tAepORCeZApc8MXMGg-1; Mon, 12 Jun 2023 08:45:10 -0400
X-MC-Unique: 0mp_tAepORCeZApc8MXMGg-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-3f7eb415010so19279835e9.0
        for <linux-security-module@vger.kernel.org>; Mon, 12 Jun 2023 05:45:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686573909; x=1689165909;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+SIWyC+aF76wvMejpvThzs+ZM4CQHXLAvJcGXWvF/kU=;
        b=QVxnL7cmEsP+21g+PaIjZS/6vc+WOClrLqfYImgVN+umxVTgMrBn5nNzVUZnbBdZCg
         YbGLc73TF4esqg9GIiauCfswV9LRoIuBd41eH5hE6nlbxFvZ4S0EInYwaCqMoIXY/crt
         rZsKQZrACTKZQaM/BkKOnCMjN4wTOnNWkknEaxljQd0y6mAhiN48NWg+uujkrkJ2IN6+
         zGShTWlsqk83d3nTjCSbpgyeIQv5J0OxU+lMoQhO6/JyjkdSW4b0zbbuc13SJZnB1hf+
         ZuIYmtt+/R8p6x7nhA6xVMMrazESXclVcqyGqdd3TWZydnZaOR189Hgg6jYCVhLhOGqe
         FAXw==
X-Gm-Message-State: AC+VfDwciFfH/4LjjpXwxJGEUp+ekW7AzuGR7ExzQNTeG/0s6jNhbn+P
        LV5jAAGccZSFhhaJHC7Z12UQCNgjIylfkmHlSX+GvjSZGlMUw5VPVG5ZnGJzOr8XEdQ99q4fMeO
        Gi9Bmy3fT32Gg7F7Pxp+1LhlOPLOjx39AHDEI
X-Received: by 2002:a05:600c:518d:b0:3f8:643:182d with SMTP id fa13-20020a05600c518d00b003f80643182dmr7520353wmb.16.1686573909148;
        Mon, 12 Jun 2023 05:45:09 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7tN4dRJgxRFdeWVK+dxUk5I6WH19i/EuFTxgVW5PcPju33s4dWfWgtJe2iaslHtSz1NuSs0Q==
X-Received: by 2002:a05:600c:518d:b0:3f8:643:182d with SMTP id fa13-20020a05600c518d00b003f80643182dmr7520319wmb.16.1686573908756;
        Mon, 12 Jun 2023 05:45:08 -0700 (PDT)
Received: from smtpclient.apple (dtucker87.plus.com. [80.229.11.228])
        by smtp.gmail.com with ESMTPSA id o11-20020a05600c058b00b003f8146ac7f7sm6080467wmd.28.2023.06.12.05.45.08
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 12 Jun 2023 05:45:08 -0700 (PDT)
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3731.600.7\))
Subject: Re: [PATCH v2 bpf-next 00/18] BPF token
From:   Dave Tucker <datucker@redhat.com>
In-Reply-To: <20230607235352.1723243-1-andrii@kernel.org>
Date:   Mon, 12 Jun 2023 13:44:57 +0100
Cc:     bpf@vger.kernel.org, linux-security-module@vger.kernel.org,
        keescook@chromium.org, brauner@kernel.org, lennart@poettering.net,
        cyphar@cyphar.com, luto@kernel.org, kernel-team@meta.com
Message-Id: <1BEB36A1-9FE4-4552-B2FF-DE6DF74F3756@redhat.com>
References: <20230607235352.1723243-1-andrii@kernel.org>
To:     Andrii Nakryiko <andrii@kernel.org>
X-Mailer: Apple Mail (2.3731.600.7)
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain;
        charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>



> On 8 Jun 2023, at 00:53, Andrii Nakryiko <andrii@kernel.org> wrote:
>=20
> This patch set introduces new BPF object, BPF token, which allows to dele=
gate
> a subset of BPF functionality from privileged system-wide daemon (e.g.,
> systemd or any other container manager) to a *trusted* unprivileged
> application. Trust is the key here. This functionality is not about allow=
ing
> unconditional unprivileged BPF usage. Establishing trust, though, is
> completely up to the discretion of respective privileged application that
> would create a BPF token.


Hello! Author of a bpfd[1] here.

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

You could do that=E2=80=A6 but the problem is created due to the pattern of=
 having a
single binary that is responsible for:

- Loading and attaching the BPF program in question
- Interacting with maps

Let=E2=80=99s set aside some of the other fun concerns of eBPF in container=
s:
 - Requiring mounting of vmlinux, bpffs, traces etc=E2=80=A6
 - How fs permissions on host translate into permissions in containers

While your proposal lets you grant a subset of CAP_BPF to some other proces=
s,
which I imagine could also be done with SELinux, it doesn=E2=80=99t stop yo=
u from needing
other required permissions for attaching tracing programs in such an
environment.=20

For example, say container A wants to attach a uprobe to a process in conta=
iner B.
Container A needs to be able to nsenter into container B=E2=80=99s pidns in=
 order for attachment
to succeed=E2=80=A6 but then what I can do with CAP_BPF is the least of my =
concerns since
I=E2=80=99d wager I=E2=80=99d need to mount `/proc` from the host in contai=
ner A + have elevated privileges
much scarier than CAP_BPF in the first place.

If you move =E2=80=9CLoading and attaching=E2=80=9D away to somewhere else =
(i.e a daemon like bpfd)
then with recent kernels your container workload should be fine to run enti=
rely unprivileged,
or worst case with only CAP_BPF since all you need to do is read/write maps=
.

Policy control - which process can request to load programs that monitor wh=
ich other
processes - would happen within this system daemon and you wouldn=E2=80=99t=
 need tokens.

Since it=E2=80=99s easy enough to do this in userspace, I=E2=80=99d be stro=
ngly against adding more
complexity into BPF to support this usecase.

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
>=20
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
> syscall accepts token_fd parameters explicitly for each relevant BPF comm=
and.
> This addresses main concerns brought up during the /dev/bpf discussion, a=
nd
> fits better with overall BPF subsystem design.
>=20
> This patch set adds a basic minimum of functionality to make BPF token us=
eful
> and to discuss API and functionality. Currently only low-level libbpf API=
s
> support passing BPF token around, allowing to test kernel functionality, =
but
> for the most part is not sufficient for real-world applications, which
> typically use high-level libbpf APIs based on `struct bpf_object` type. T=
his
> was done with the intent to limit the size of patch set and concentrate o=
n
> mostly kernel-side changes. All the necessary plumbing for libbpf will be=
 sent
> as a separate follow up patch set kernel support makes it upstream.
>=20
> Another part that should happen once kernel-side BPF token is established=
, is
> a set of conventions between applications (e.g., systemd), tools (e.g.,
> bpftool), and libraries (e.g., libbpf) about sharing BPF tokens through B=
PF FS
> at well-defined locations to allow applications take advantage of this in
> automatic fashion without explicit code changes on BPF application's side=
.
> But I'd like to postpone this discussion to after BPF token concept lands=
.
>=20
>  [0] https://lore.kernel.org/bpf/20230412043300.360803-1-andrii@kernel.or=
g/
>  [1] http://vger.kernel.org/bpfconf2023_material/Trusted_unprivileged_BPF=
_LSFMM2023.pdf
>  [2] https://lore.kernel.org/bpf/20190627201923.2589391-2-songliubraving@=
fb.com/
>=20

- Dave

[1]: https://github.com/bpfd-dev/bpfd

