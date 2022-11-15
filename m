Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C3B9C4321E
	for <linux-security-module@archiver.kernel.org>; Tue, 15 Nov 2022 03:12:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232129AbiKODMW (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 14 Nov 2022 22:12:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236858AbiKODMB (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 14 Nov 2022 22:12:01 -0500
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8096263D
        for <linux-security-module@vger.kernel.org>; Mon, 14 Nov 2022 19:12:00 -0800 (PST)
Received: by mail-ot1-x32a.google.com with SMTP id db10-20020a0568306b0a00b0066d43e80118so7688950otb.1
        for <linux-security-module@vger.kernel.org>; Mon, 14 Nov 2022 19:12:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=dAAmI/mpX34X1iM1ddDtHCn4cxjCzzyc5sEgoPbFM7U=;
        b=RZDpoliVXSMBH72Dy/aKisKzQP+pUECejEj8wA1REQJjXEMbEluU4dKASvB1WxIyZy
         5/+nd4J72ANzeCvhmfCaCckqLrQeUF1QMqf/uz4+Pyf7Q3DgbHIE+r7fFdzRyblFFDE4
         Qtua/qHhblsQKLsL96tNMkXpi9XN51eeBxRaQVx19MDhaz5OB64SbNVWL/nt/oCiCos9
         OP+3HAHdFGRqAbhv9KKp9meCf3xUWDDP1x7IbyshwwceyuANuB8y5k1ZSU9M0M98O5+3
         PBNrUrqdMzj089EsIvRBFDe/0CcKU31S1YYUg6JXgfFXiYSVHXXSphzXt3fpKLehUE2R
         gRdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dAAmI/mpX34X1iM1ddDtHCn4cxjCzzyc5sEgoPbFM7U=;
        b=3xZmcqtMC3YsxhGBf64KpWknR44GpJvuM/IYcCD4+F4wwd/qLNUKUR7tQkxuVv5p32
         QfxlzQbzM8BDn5xUeqrYJRHWX9uu3gu8a7123m+8P4TxB8Vs+XPeziGmhFhPvccNEdhR
         9mmwgIGtBv+OhwierejVlIWXeiWMcq1SIhrXuYeyctnc+a3bvyj5PLbbgKXniYiE4CCa
         5Q5xzYthX+hFcqOTQk1BiCAGztdi5HYex17wfTSqK6LfWvI/L84vj6kiQkjdaL8UarRm
         WtSh0rBzEMKqQQGWUjZ1gdexMpeZKIq8RnFkAAgV7/SRkbtXpTQSitl7jn2DOd3X5hi2
         YV9Q==
X-Gm-Message-State: ANoB5plIjOM+hAjniNpFu3Vl/TdBeEWkk6uo70Wz73RxHnhf9yt0PsKM
        q333IWB5MqUmaK7hPzNQONjuXG1lTxTr2SFjLdEtsA==
X-Google-Smtp-Source: AA0mqf6LeU70wR6Wvto3d88rRH+RsUpIaI4o5uD9hVQwEGfKA8+TFMDOcwSnRW8I6QNmT7Zdt/BHglnrSMBwSOUdFsc=
X-Received: by 2002:a9d:685a:0:b0:66c:dd29:813d with SMTP id
 c26-20020a9d685a000000b0066cdd29813dmr8037560oto.312.1668481919811; Mon, 14
 Nov 2022 19:11:59 -0800 (PST)
MIME-Version: 1.0
References: <1668482980-16163-1-git-send-email-wangyufen@huawei.com>
In-Reply-To: <1668482980-16163-1-git-send-email-wangyufen@huawei.com>
From:   Stanislav Fomichev <sdf@google.com>
Date:   Mon, 14 Nov 2022 19:11:48 -0800
Message-ID: <CAKH8qBurjSs+nvXVsOPqpPGhODj=Ja2Zwt7mPYxJ20LWbj2FRg@mail.gmail.com>
Subject: Re: [PATCH bpf v2] selftests/bpf: fix memory leak of lsm_cgroup
To:     Wang Yufen <wangyufen@huawei.com>
Cc:     linux-security-module@vger.kernel.org, bpf@vger.kernel.org,
        martin.lau@linux.dev, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, paul@paul-moore.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Mon, Nov 14, 2022 at 7:09 PM Wang Yufen <wangyufen@huawei.com> wrote:
>
> kmemleak reports this issue:
>
> unreferenced object 0xffff88810b7835c0 (size 32):
>   comm "test_progs", pid 270, jiffies 4294969007 (age 1621.315s)
>   hex dump (first 32 bytes):
>     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>     03 00 00 00 03 00 00 00 0f 00 00 00 00 00 00 00  ................
>   backtrace:
>     [<00000000376cdeab>] kmalloc_trace+0x27/0x110
>     [<000000003bcdb3b6>] selinux_sk_alloc_security+0x66/0x110
>     [<000000003959008f>] security_sk_alloc+0x47/0x80
>     [<00000000e7bc6668>] sk_prot_alloc+0xbd/0x1a0
>     [<0000000002d6343a>] sk_alloc+0x3b/0x940
>     [<000000009812a46d>] unix_create1+0x8f/0x3d0
>     [<000000005ed0976b>] unix_create+0xa1/0x150
>     [<0000000086a1d27f>] __sock_create+0x233/0x4a0
>     [<00000000cffe3a73>] __sys_socket_create.part.0+0xaa/0x110
>     [<0000000007c63f20>] __sys_socket+0x49/0xf0
>     [<00000000b08753c8>] __x64_sys_socket+0x42/0x50
>     [<00000000b56e26b3>] do_syscall_64+0x3b/0x90
>     [<000000009b4871b8>] entry_SYSCALL_64_after_hwframe+0x63/0xcd
>
> The issue occurs in the following scenarios:
>
> unix_create1()
>   sk_alloc()
>     sk_prot_alloc()
>       security_sk_alloc()
>         call_int_hook()
>           hlist_for_each_entry()
>             entry1->hook.sk_alloc_security
>             <-- selinux_sk_alloc_security() succeeded,
>             <-- sk->security alloced here.
>             entry2->hook.sk_alloc_security
>             <-- bpf_lsm_sk_alloc_security() failed
>       goto out_free;
>         ...    <-- the sk->security not freed, memleak
>
> The core problem is that the LSM is not yet fully stacked (work is
> actively going on in this space) which means that some LSM hooks do
> not support multiple LSMs at the same time. To fix, skip the
> "EPERM" test when it runs in the environments that already have
> non-bpf lsms installed
>
> Fixes: dca85aac8895 ("selftests/bpf: lsm_cgroup functional test")
> Signed-off-by: Wang Yufen <wangyufen@huawei.com>
> Cc: Stanislav Fomichev <sdf@google.com>

Acked-by: Stanislav Fomichev <sdf@google.com>

Thank you!

> ---
>  tools/testing/selftests/bpf/prog_tests/lsm_cgroup.c | 17 +++++++++++++----
>  tools/testing/selftests/bpf/progs/lsm_cgroup.c      |  8 ++++++++
>  2 files changed, 21 insertions(+), 4 deletions(-)
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/lsm_cgroup.c b/tools/testing/selftests/bpf/prog_tests/lsm_cgroup.c
> index 1102e4f..f117bfe 100644
> --- a/tools/testing/selftests/bpf/prog_tests/lsm_cgroup.c
> +++ b/tools/testing/selftests/bpf/prog_tests/lsm_cgroup.c
> @@ -173,10 +173,12 @@ static void test_lsm_cgroup_functional(void)
>         ASSERT_EQ(query_prog_cnt(cgroup_fd, NULL), 4, "total prog count");
>         ASSERT_EQ(query_prog_cnt(cgroup_fd2, NULL), 1, "total prog count");
>
> -       /* AF_UNIX is prohibited. */
> -
>         fd = socket(AF_UNIX, SOCK_STREAM, 0);
> -       ASSERT_LT(fd, 0, "socket(AF_UNIX)");
> +       if (!(skel->kconfig->CONFIG_SECURITY_APPARMOR
> +           || skel->kconfig->CONFIG_SECURITY_SELINUX
> +           || skel->kconfig->CONFIG_SECURITY_SMACK))
> +               /* AF_UNIX is prohibited. */
> +               ASSERT_LT(fd, 0, "socket(AF_UNIX)");
>         close(fd);
>
>         /* AF_INET6 gets default policy (sk_priority). */
> @@ -233,11 +235,18 @@ static void test_lsm_cgroup_functional(void)
>
>         /* AF_INET6+SOCK_STREAM
>          * AF_PACKET+SOCK_RAW
> +        * AF_UNIX+SOCK_RAW if already have non-bpf lsms installed
>          * listen_fd
>          * client_fd
>          * accepted_fd
>          */
> -       ASSERT_EQ(skel->bss->called_socket_post_create2, 5, "called_create2");
> +       if (skel->kconfig->CONFIG_SECURITY_APPARMOR
> +           || skel->kconfig->CONFIG_SECURITY_SELINUX
> +           || skel->kconfig->CONFIG_SECURITY_SMACK)
> +               /* AF_UNIX+SOCK_RAW if already have non-bpf lsms installed */
> +               ASSERT_EQ(skel->bss->called_socket_post_create2, 6, "called_create2");
> +       else
> +               ASSERT_EQ(skel->bss->called_socket_post_create2, 5, "called_create2");
>
>         /* start_server
>          * bind(ETH_P_ALL)
> diff --git a/tools/testing/selftests/bpf/progs/lsm_cgroup.c b/tools/testing/selftests/bpf/progs/lsm_cgroup.c
> index 4f2d60b..02c11d1 100644
> --- a/tools/testing/selftests/bpf/progs/lsm_cgroup.c
> +++ b/tools/testing/selftests/bpf/progs/lsm_cgroup.c
> @@ -7,6 +7,10 @@
>
>  char _license[] SEC("license") = "GPL";
>
> +extern bool CONFIG_SECURITY_SELINUX __kconfig __weak;
> +extern bool CONFIG_SECURITY_SMACK __kconfig __weak;
> +extern bool CONFIG_SECURITY_APPARMOR __kconfig __weak;
> +
>  #ifndef AF_PACKET
>  #define AF_PACKET 17
>  #endif
> @@ -140,6 +144,10 @@ int BPF_PROG(socket_bind2, struct socket *sock, struct sockaddr *address,
>  int BPF_PROG(socket_alloc, struct sock *sk, int family, gfp_t priority)
>  {
>         called_socket_alloc++;
> +       /* if already have non-bpf lsms installed, EPERM will cause memory leak of non-bpf lsms */
> +       if (CONFIG_SECURITY_SELINUX || CONFIG_SECURITY_SMACK || CONFIG_SECURITY_APPARMOR)
> +               return 1;
> +
>         if (family == AF_UNIX)
>                 return 0; /* EPERM */
>
> --
> 1.8.3.1
>
