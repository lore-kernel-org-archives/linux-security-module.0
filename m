Return-Path: <SRS0=UBGi=AL=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30822C433DF
	for <linux-security-module@archiver.kernel.org>; Tue, 30 Jun 2020 11:50:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0FC4820774
	for <linux-security-module@archiver.kernel.org>; Tue, 30 Jun 2020 11:50:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="EwcjwlqN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728419AbgF3Lup (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 30 Jun 2020 07:50:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729580AbgF3Luo (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 30 Jun 2020 07:50:44 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B1BDC061755
        for <linux-security-module@vger.kernel.org>; Tue, 30 Jun 2020 04:50:44 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id o8so18514292wmh.4
        for <linux-security-module@vger.kernel.org>; Tue, 30 Jun 2020 04:50:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=GWV+iQuRtCpfYYNtAK9+bSfnvyQdFNs1dv+1er5dsU8=;
        b=EwcjwlqNUbnEZ6IaVQ/ouTVjAi+5W0gXxwIwgJx5L2q5OidBLRmG3492wCWCmiVYiE
         IvHiU0kX/UxnCdXYxe4fRfAbp/JroR7rbdhyeu3GnuTSrLA3c7k1jft/XAiU03BUbZE0
         XXgcqG/Qhna6vb/sUq0KoiYVJf6DOkKbhRzHo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=GWV+iQuRtCpfYYNtAK9+bSfnvyQdFNs1dv+1er5dsU8=;
        b=ZOiJNPy9othp/IEZXN6t8vVxQz/AlbNTXppdXFdtZkx90/BF7vtN6/eA0lU9E7WGuE
         NWg5YtB3zsilbsAE2UMxjl2VUTzx4Ij9VrsIN7aQhjLcgq0pJCqdJnIlXyzr5cXBd3p4
         xjnx3OLDghUUsSMcqyzrXU3o4CQBcynF1XOwtq/Lo10YJjA7JbP4CJQ4/BXogc7MztHm
         ntvwjJn8YXfR8+8QI73n9siUHoK3UECvMybwHan/Upnd3hmFazgEOzI66waMddnXsu6S
         pSF4reODLgHexDeB0N/pirvYbkTEBptp0mVVnQoAbf211a13CYKviyQBygZBw6ToqUk2
         jWsw==
X-Gm-Message-State: AOAM530qk03yjrg+56GOPHuIR4zoZX+myMz3nQmGAUhsYu2NBB8S04Ws
        QmHemOOXbV/TaM2/KoZo53uhDA==
X-Google-Smtp-Source: ABdhPJxVsZfzjzet5KchM2IaO/5rCJy/Ok+q7SabeQRomMWOldOTToa7odVxlDAtJPgSuqKpO2M1Mw==
X-Received: by 2002:a05:600c:2154:: with SMTP id v20mr22983992wml.185.1593517843162;
        Tue, 30 Jun 2020 04:50:43 -0700 (PDT)
Received: from google.com ([81.6.44.51])
        by smtp.gmail.com with ESMTPSA id k11sm3730872wrd.23.2020.06.30.04.50.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2020 04:50:42 -0700 (PDT)
From:   KP Singh <kpsingh@chromium.org>
X-Google-Original-From: KP Singh <kpsingh>
Date:   Tue, 30 Jun 2020 13:50:41 +0200
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     KP Singh <kpsingh@chromium.org>, bpf <bpf@vger.kernel.org>,
        linux-security-module@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Paul Turner <pjt@google.com>, Jann Horn <jannh@google.com>
Subject: Re: [PATCH bpf-next v2 4/4] bpf: Add selftests for local_storage
Message-ID: <20200630115041.GB421824@google.com>
References: <20200617202941.3034-1-kpsingh@chromium.org>
 <20200617202941.3034-5-kpsingh@chromium.org>
 <CAEf4BzZdUWUSLzT1Y-o1Yvy3tTETkJEVU7RyZufZY_yEKzwOSg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEf4BzZdUWUSLzT1Y-o1Yvy3tTETkJEVU7RyZufZY_yEKzwOSg@mail.gmail.com>
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On 18-Jun 11:16, Andrii Nakryiko wrote:
> On Wed, Jun 17, 2020 at 1:31 PM KP Singh <kpsingh@chromium.org> wrote:
> >
> > From: KP Singh <kpsingh@google.com>
> >
> > inode_local_storage:
> >
> > * Hook to the file_open and inode_unlink LSM hooks.
> > * Create and unlink a temporary file.
> > * Store some information in the inode's bpf_local_storage during
> >   file_open.
> > * Verify that this information exists when the file is unlinked.
> >
> > sk_local_storage:
> >
> > * Hook to the socket_post_create and socket_bind LSM hooks.
> > * Open and bind a socket and set the sk_storage in the
> >   socket_post_create hook using the start_server helper.
> > * Verify if the information is set in the socket_bind hook.
> >
> > Signed-off-by: KP Singh <kpsingh@google.com>
> > ---
> >  .../bpf/prog_tests/test_local_storage.c       |  60 ++++++++
> >  .../selftests/bpf/progs/local_storage.c       | 137 ++++++++++++++++++
> >  2 files changed, 197 insertions(+)
> >  create mode 100644 tools/testing/selftests/bpf/prog_tests/test_local_storage.c
> >  create mode 100644 tools/testing/selftests/bpf/progs/local_storage.c
> >
> 
> [...]
> 
> > diff --git a/tools/testing/selftests/bpf/progs/local_storage.c b/tools/testing/selftests/bpf/progs/local_storage.c
> > new file mode 100644
> > index 000000000000..38954e6a1edc
> > --- /dev/null
> > +++ b/tools/testing/selftests/bpf/progs/local_storage.c
> > @@ -0,0 +1,137 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +
> > +/*
> > + * Copyright 2020 Google LLC.
> > + */
> > +
> > +#include <errno.h>
> > +#include <linux/bpf.h>
> > +#include <stdbool.h>
> > +#include <bpf/bpf_helpers.h>
> > +#include <bpf/bpf_tracing.h>
> > +
> > +char _license[] SEC("license") = "GPL";
> > +__u32 _version SEC("version") = 1;
> 
> version is anachronism, please drop it.

Removed.

> 
> Otherwise, LGTM.

Thanks

- KP

> 
> Acked-by: Andrii Nakryiko <andriin@fb.com>
> 
> [...]
