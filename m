Return-Path: <SRS0=g/MA=77=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CE0BC433DF
	for <linux-security-module@archiver.kernel.org>; Thu, 18 Jun 2020 18:16:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6FC392083B
	for <linux-security-module@archiver.kernel.org>; Thu, 18 Jun 2020 18:16:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dVOBRYhz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727982AbgFRSQu (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 18 Jun 2020 14:16:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727113AbgFRSQt (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 18 Jun 2020 14:16:49 -0400
Received: from mail-qv1-xf44.google.com (mail-qv1-xf44.google.com [IPv6:2607:f8b0:4864:20::f44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76E49C06174E;
        Thu, 18 Jun 2020 11:16:49 -0700 (PDT)
Received: by mail-qv1-xf44.google.com with SMTP id e2so3218314qvw.7;
        Thu, 18 Jun 2020 11:16:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7Cqqi1amKLy2OTdpP21O0ph08WqGmQlHafsLB9AH7TU=;
        b=dVOBRYhzBc/Av52mQvqLNdGX8J+6P5cUFLepiyoAcIEKUCLB8ti4cN1cML94pEJUCj
         jFMvvi99tIz1kWYTWnOcP5nC5+hMu+llgFqraSvXkCgoN03ey6fe0xrxmjQ1IDi20u3J
         VODmU8QQLlsepjPIS1j28bp09Sqr2l4afC5jjvPxMB8dqzSXjcw0MCkHrLcr/NTVncCk
         jPHnLkofCgrNsphhIFnEuRQ/D8R4u2UqIZ443SJrfQXuAz8vJCeO7b/GGTRL62wXSY2F
         op/7l/S8EC9b176/pp5q0R9aa14+nO8N7QmLT1kjhbOTKccFgDrAeYZNVHI3+jJSe9VU
         8cPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7Cqqi1amKLy2OTdpP21O0ph08WqGmQlHafsLB9AH7TU=;
        b=V1kMUFfIxggzwVatHeazieg5cOXgJdzEwsz6gzGVIOxjnPdI4S3LkS0fdwx86v36lb
         RJntV5zE+VbQUM5PniFZ7kzCCZvRjEzWUHUMgaigf/2Qtj9DLKIzcOjUSZgg7l78FKRk
         msd1n/7yXi40LAKcyBL+hN8GypJxIaCb0soKJyaqPCjabn8tBlVwVAcmPQX4evX9ql0l
         aZkly/W16Ec2Srhl94fBr14i7oa5TR+Rq8nZebde7K2KK6vqB/EVlPuBKXCYk8UcK1NX
         vWZLC0NA/NCadmFbzk0ipig9FpYtrzPBCVDk93Y6z1X0CdaJW4hPYZIH0tZoOEM9doPa
         tqGg==
X-Gm-Message-State: AOAM531qsjLDuBR47qdd0kbquDRwT0yz0e1P4X8YESxhhQsdtHePJRWi
        bVdWjWePRpgq2esf+n1a9FvbT1EphrOHldmAne4=
X-Google-Smtp-Source: ABdhPJwP/W6SdAsiTZuY2vxGEViLghk/udbPKQS3RiIPY8c1tcqtDG1UYbYhYTKe6LpINccnK4KYFVM6QEKJf3/bzqM=
X-Received: by 2002:a0c:f388:: with SMTP id i8mr4991577qvk.224.1592504208678;
 Thu, 18 Jun 2020 11:16:48 -0700 (PDT)
MIME-Version: 1.0
References: <20200617202941.3034-1-kpsingh@chromium.org> <20200617202941.3034-5-kpsingh@chromium.org>
In-Reply-To: <20200617202941.3034-5-kpsingh@chromium.org>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Thu, 18 Jun 2020 11:16:37 -0700
Message-ID: <CAEf4BzZdUWUSLzT1Y-o1Yvy3tTETkJEVU7RyZufZY_yEKzwOSg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 4/4] bpf: Add selftests for local_storage
To:     KP Singh <kpsingh@chromium.org>
Cc:     bpf <bpf@vger.kernel.org>, linux-security-module@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Paul Turner <pjt@google.com>, Jann Horn <jannh@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Wed, Jun 17, 2020 at 1:31 PM KP Singh <kpsingh@chromium.org> wrote:
>
> From: KP Singh <kpsingh@google.com>
>
> inode_local_storage:
>
> * Hook to the file_open and inode_unlink LSM hooks.
> * Create and unlink a temporary file.
> * Store some information in the inode's bpf_local_storage during
>   file_open.
> * Verify that this information exists when the file is unlinked.
>
> sk_local_storage:
>
> * Hook to the socket_post_create and socket_bind LSM hooks.
> * Open and bind a socket and set the sk_storage in the
>   socket_post_create hook using the start_server helper.
> * Verify if the information is set in the socket_bind hook.
>
> Signed-off-by: KP Singh <kpsingh@google.com>
> ---
>  .../bpf/prog_tests/test_local_storage.c       |  60 ++++++++
>  .../selftests/bpf/progs/local_storage.c       | 137 ++++++++++++++++++
>  2 files changed, 197 insertions(+)
>  create mode 100644 tools/testing/selftests/bpf/prog_tests/test_local_storage.c
>  create mode 100644 tools/testing/selftests/bpf/progs/local_storage.c
>

[...]

> diff --git a/tools/testing/selftests/bpf/progs/local_storage.c b/tools/testing/selftests/bpf/progs/local_storage.c
> new file mode 100644
> index 000000000000..38954e6a1edc
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/local_storage.c
> @@ -0,0 +1,137 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +/*
> + * Copyright 2020 Google LLC.
> + */
> +
> +#include <errno.h>
> +#include <linux/bpf.h>
> +#include <stdbool.h>
> +#include <bpf/bpf_helpers.h>
> +#include <bpf/bpf_tracing.h>
> +
> +char _license[] SEC("license") = "GPL";
> +__u32 _version SEC("version") = 1;

version is anachronism, please drop it.

Otherwise, LGTM.

Acked-by: Andrii Nakryiko <andriin@fb.com>

[...]
