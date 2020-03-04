Return-Path: <SRS0=IE2G=4V=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DF22C3F2D1
	for <linux-security-module@archiver.kernel.org>; Wed,  4 Mar 2020 05:15:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 044C1215A4
	for <linux-security-module@archiver.kernel.org>; Wed,  4 Mar 2020 05:15:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KPNpz7cv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725774AbgCDFPC (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 4 Mar 2020 00:15:02 -0500
Received: from mail-qv1-f67.google.com ([209.85.219.67]:35603 "EHLO
        mail-qv1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725271AbgCDFPC (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 4 Mar 2020 00:15:02 -0500
Received: by mail-qv1-f67.google.com with SMTP id u10so266473qvi.2;
        Tue, 03 Mar 2020 21:15:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AW1It91eB41MJO8tcBMXkpdl3fk8Ujf8yzHplhBGqgE=;
        b=KPNpz7cvO23TdqYA/PVi4Bl5I351QFJV4eyXzQmEmMtC/AyQ+OduXCd3sHguKmPKKU
         LxYp/fPEB5OTW3c31Hb4u2BI3vLUSIIGgspwGCnXB3EfLHZxqGG79XUVBhKgc8zo40Wa
         IrjyPFvv8rGzOluGbd+tD+J6PRXXX+Ylg+VfJ64PPif0ZiA8IkMQfzxwDHMzsSDlh98F
         v0w5IN66vUtdYAKFR9LOfEwiksV8tnFxiTg+du+/5Fq3F+iQBHzM8BwEMjiLWZ3wfkgn
         fbrl4uzw2W+/ohzZsvqv1cESwFa3Z4VMVRxOycGn0eoaPxFReAqrVo7/SSNvV02CSswS
         H8iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AW1It91eB41MJO8tcBMXkpdl3fk8Ujf8yzHplhBGqgE=;
        b=Vc2ADQdVoGJf0HIpglOmMS6+G6SyAgJhdibxWv5ld5h1wMbGbWBzLbPX5kjONNFqW+
         ZBSNfwHxUX5Vb6vUwz/VXGhJu4E9EVIUvzx5fc6rKCn9EKV8vSVaVSoO07okCEhA3Gxg
         1dcgcAmLR5RO1uQluN4qsx+tIj9PEL0gKJL5SYusjy3fVCHk3kb2n6zRGQn6+W/UlGuh
         wL2spZzM5PRg2Lg/OT0lcwtbPVxdNqgYrKTo5PGciEhmmf7HzrRMJmqBMgu5nWruUYLl
         w5hevchcRsVdTaH8bY0w9Mn4QnhCSuwx7JAz0nC/z5RLakvSoKy7aalXRFLOUZ7jkBW7
         WoIQ==
X-Gm-Message-State: ANhLgQ14hBGovBcT5bJWr24gOUVRHlQ2OJpf7wi/cjo+HFJQNtvP9aad
        Xpw9OuRWSl3n7VNjG4g1OXshQmeh+cx0MOuINLo=
X-Google-Smtp-Source: ADFU+vvcesLjPCKTVi0KVX1E1u9L/QZwr7MaTk66Ir/3c0pEeCN2wK4si//1F9ccw4rlIxoqa9prYeUJTg4o2+mt9Ek=
X-Received: by 2002:a05:6214:8cb:: with SMTP id da11mr733937qvb.228.1583298901139;
 Tue, 03 Mar 2020 21:15:01 -0800 (PST)
MIME-Version: 1.0
References: <20200304015528.29661-1-kpsingh@chromium.org> <20200304015528.29661-7-kpsingh@chromium.org>
In-Reply-To: <20200304015528.29661-7-kpsingh@chromium.org>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 3 Mar 2020 21:14:50 -0800
Message-ID: <CAEf4Bzbg8TZVfctYQCe+d9kkUaJPU-Vnso-BWeOu=VecnikPJQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 6/7] bpf: Add test ops for BPF_PROG_TYPE_TRACING
To:     KP Singh <kpsingh@chromium.org>
Cc:     linux-security-module@vger.kernel.org,
        open list <linux-kernel@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Paul Turner <pjt@google.com>, Jann Horn <jannh@google.com>,
        Florent Revest <revest@chromium.org>,
        Brendan Jackman <jackmanb@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Tue, Mar 3, 2020 at 5:56 PM KP Singh <kpsingh@chromium.org> wrote:
>
> From: KP Singh <kpsingh@google.com>
>
> The current fexit and fentry tests rely on a different program to
> exercise the functions they attach to. Instead of doing this, implement
> the test operations for tracing which will also be used for
> BPF_MODIFY_RETURN in a subsequent patch.
>
> Also, clean up the fexit test to use the generated skeleton.
>
> Signed-off-by: KP Singh <kpsingh@google.com>
> ---

Acked-by: Andrii Nakryiko <andriin@fb.com>

>  include/linux/bpf.h                           | 10 +++
>  kernel/trace/bpf_trace.c                      |  1 +
>  net/bpf/test_run.c                            | 37 +++++++---
>  .../selftests/bpf/prog_tests/fentry_fexit.c   | 12 +---
>  .../selftests/bpf/prog_tests/fentry_test.c    | 14 ++--
>  .../selftests/bpf/prog_tests/fexit_test.c     | 69 ++++++-------------
>  6 files changed, 67 insertions(+), 76 deletions(-)
>

[...]
