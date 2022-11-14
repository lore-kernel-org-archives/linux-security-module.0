Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03147C4332F
	for <linux-security-module@archiver.kernel.org>; Mon, 14 Nov 2022 17:34:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236375AbiKNRe2 (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 14 Nov 2022 12:34:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237582AbiKNRe0 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 14 Nov 2022 12:34:26 -0500
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 008B01571B
        for <linux-security-module@vger.kernel.org>; Mon, 14 Nov 2022 09:34:24 -0800 (PST)
Received: by mail-pf1-x44a.google.com with SMTP id s11-20020a056a00178b00b0056cb4545c3fso6372841pfg.5
        for <linux-security-module@vger.kernel.org>; Mon, 14 Nov 2022 09:34:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=msz3ozvlPLroWfT8x2NNZs//GvUccXdOW5UK6ZYn4c0=;
        b=BIqlyBz0MDGXETR7a6p1Ndp0XeFZ6GGFRhqNB/OHBLLLurkUXexaaVCWU2W0zoExCG
         hJDRgc9RH9+rdVs8DbClI1j/9ySqOZ1+hJCz/fWIWlg4bnyTmOrbSOiLsXQ2fc9UiSo/
         fhC88erSxjutvBDvF3mcu7xOFyb/UTlWpeOc+GDQOjAoZz7MPzLqmqr8VaydCnWoFJG0
         iFSMqZHw600P8s6hksBteTHJPdRP6hkETdfVtZhRCYsrksBGrYTHL0YsQI2a9/zoXAnD
         ouj6y4Z3c0RmqRxNc1oUsa852ZsLbLpFS8bVnGbFvlqoY8CfR7U6YUvdGndmoaAJ6bbu
         1NmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=msz3ozvlPLroWfT8x2NNZs//GvUccXdOW5UK6ZYn4c0=;
        b=SSXxTT056ubvozHg4bpbqEPN1teapuh4MxgGwNW7x3is/lin4cCnMPA3EaX/2QWz0O
         clr7+fsXwgfd97jp7ahvkdhImF2uJnm8k2qcZ4u6fSad2+eJzO06MOAqMPquS7QgDKzK
         1wTkar0H8OwUo5/Ws3dIoe5X6d4a+FfV5JSIgdM+n45Zc49bpUEMgdHXpl8GK+3zwKpb
         VgnhZWiRmcs2BA1lsn/hpAOZzSZqtpqcCIs5aSmZHNhnzvTMNyLHT68RgUfLXrqe90cs
         vfeUKnHjuTpAAWznCO7YrAlk6LUorqQYpKd+3ICCNM0HmuB9BEWAme8HNPfndXbSTUhy
         aSww==
X-Gm-Message-State: ANoB5pn3THWopLhr/51a4ZYI4nTYpJFxGr5Im6xC0Kb40v9LYlRZCD23
        eFKDIMlW01dNS9XhR5PF29+0Bj0=
X-Google-Smtp-Source: AA0mqf6oV5jBgwVrMG+lgn68FDlvRNY25mg6ElHE/ciQImgwloJgW/4/A2kf7qgGHApYKmXPRJumPnY=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a17:902:a586:b0:188:5681:4dc7 with SMTP id
 az6-20020a170902a58600b0018856814dc7mr291394plb.97.1668447264478; Mon, 14 Nov
 2022 09:34:24 -0800 (PST)
Date:   Mon, 14 Nov 2022 09:34:23 -0800
In-Reply-To: <1668401942-6309-1-git-send-email-wangyufen@huawei.com>
Mime-Version: 1.0
References: <1668401942-6309-1-git-send-email-wangyufen@huawei.com>
Message-ID: <Y3J8HyIfhm7rgpvI@google.com>
Subject: Re: [PATCH bpf] selftests/bpf: fix memory leak of lsm_cgroup
From:   sdf@google.com
To:     Wang Yufen <wangyufen@huawei.com>
Cc:     linux-security-module@vger.kernel.org, bpf@vger.kernel.org,
        martin.lau@linux.dev, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, paul@paul-moore.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On 11/14, Wang Yufen wrote:
> kmemleak reports this issue:

> unreferenced object 0xffff88810b7835c0 (size 32):
>    comm "test_progs", pid 270, jiffies 4294969007 (age 1621.315s)
>    hex dump (first 32 bytes):
>      00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>      03 00 00 00 03 00 00 00 0f 00 00 00 00 00 00 00  ................
>    backtrace:
>      [<00000000376cdeab>] kmalloc_trace+0x27/0x110
>      [<000000003bcdb3b6>] selinux_sk_alloc_security+0x66/0x110
>      [<000000003959008f>] security_sk_alloc+0x47/0x80
>      [<00000000e7bc6668>] sk_prot_alloc+0xbd/0x1a0
>      [<0000000002d6343a>] sk_alloc+0x3b/0x940
>      [<000000009812a46d>] unix_create1+0x8f/0x3d0
>      [<000000005ed0976b>] unix_create+0xa1/0x150
>      [<0000000086a1d27f>] __sock_create+0x233/0x4a0
>      [<00000000cffe3a73>] __sys_socket_create.part.0+0xaa/0x110
>      [<0000000007c63f20>] __sys_socket+0x49/0xf0
>      [<00000000b08753c8>] __x64_sys_socket+0x42/0x50
>      [<00000000b56e26b3>] do_syscall_64+0x3b/0x90
>      [<000000009b4871b8>] entry_SYSCALL_64_after_hwframe+0x63/0xcd

> The issue occurs in the following scenarios:

> unix_create1()
>    sk_alloc()
>      sk_prot_alloc()
>        security_sk_alloc()
>          call_int_hook()
>            hlist_for_each_entry()
>              entry1->hook.sk_alloc_security
>              <-- selinux_sk_alloc_security() succeeded,
>              <-- sk->security alloced here.
>              entry2->hook.sk_alloc_security
>              <-- bpf_lsm_sk_alloc_security() failed
>        goto out_free;
>          ...    <-- the sk->security not freed, memleak

> The core problem is that the LSM is not yet fully stacked (work is
> actively going on in this space) which means that some LSM hooks do
> not support multiple LSMs at the same time. To fix, skip the
> "EPERM" test when it runs in the environments that already have
> non-bpf lsms installed

> Fixes: dca85aac8895 ("selftests/bpf: lsm_cgroup functional test")
> Signed-off-by: Wang Yufen <wangyufen@huawei.com>
> Cc: Stanislav Fomichev <sdf@google.com>
> ---
>   tools/testing/selftests/bpf/prog_tests/lsm_cgroup.c | 19  
> +++++++++++++++----
>   tools/testing/selftests/bpf/progs/lsm_cgroup.c      |  8 ++++++++
>   2 files changed, 23 insertions(+), 4 deletions(-)

> diff --git a/tools/testing/selftests/bpf/prog_tests/lsm_cgroup.c  
> b/tools/testing/selftests/bpf/prog_tests/lsm_cgroup.c
> index 1102e4f..a927ade 100644
> --- a/tools/testing/selftests/bpf/prog_tests/lsm_cgroup.c
> +++ b/tools/testing/selftests/bpf/prog_tests/lsm_cgroup.c
> @@ -173,10 +173,14 @@ static void test_lsm_cgroup_functional(void)
>   	ASSERT_EQ(query_prog_cnt(cgroup_fd, NULL), 4, "total prog count");
>   	ASSERT_EQ(query_prog_cnt(cgroup_fd2, NULL), 1, "total prog count");

> -	/* AF_UNIX is prohibited. */
> -
>   	fd = socket(AF_UNIX, SOCK_STREAM, 0);
> -	ASSERT_LT(fd, 0, "socket(AF_UNIX)");
> +	if (skel->kconfig->CONFIG_SECURITY_APPARMOR
> +	    || skel->kconfig->CONFIG_SECURITY_SELINUX
> +	    || skel->kconfig->CONFIG_SECURITY_SMACK)

[..]

> +		ASSERT_GE(fd, 0, "socket(AF_UNIX)");

nit: maybe skip this completely instead of having ASSERT_GE+close?

	if (!(skel->kconfig->CONFIG_SECURITY_APPARMOR || _SELINUX || _SMACK)
		/* AF_UNIX is prohibited. */
		ASSERT_LT(fd, 0, "socket(AF_UNIX)");


> +	else
> +		/* AF_UNIX is prohibited. */
> +		ASSERT_LT(fd, 0, "socket(AF_UNIX)");
>   	close(fd);

>   	/* AF_INET6 gets default policy (sk_priority). */
> @@ -233,11 +237,18 @@ static void test_lsm_cgroup_functional(void)

>   	/* AF_INET6+SOCK_STREAM
>   	 * AF_PACKET+SOCK_RAW
> +	 * AF_UNIX+SOCK_RAW if already have non-bpf lsms installed
>   	 * listen_fd
>   	 * client_fd
>   	 * accepted_fd
>   	 */
> -	ASSERT_EQ(skel->bss->called_socket_post_create2, 5, "called_create2");
> +	if (skel->kconfig->CONFIG_SECURITY_APPARMOR
> +	    || skel->kconfig->CONFIG_SECURITY_SELINUX
> +	    || skel->kconfig->CONFIG_SECURITY_SMACK)
> +		/* AF_UNIX+SOCK_RAW if already have non-bpf lsms installed */
> +		ASSERT_EQ(skel->bss->called_socket_post_create2, 6, "called_create2");
> +	else
> +		ASSERT_EQ(skel->bss->called_socket_post_create2, 5, "called_create2");

>   	/* start_server
>   	 * bind(ETH_P_ALL)
> diff --git a/tools/testing/selftests/bpf/progs/lsm_cgroup.c  
> b/tools/testing/selftests/bpf/progs/lsm_cgroup.c
> index 4f2d60b..02c11d1 100644
> --- a/tools/testing/selftests/bpf/progs/lsm_cgroup.c
> +++ b/tools/testing/selftests/bpf/progs/lsm_cgroup.c
> @@ -7,6 +7,10 @@

>   char _license[] SEC("license") = "GPL";

> +extern bool CONFIG_SECURITY_SELINUX __kconfig __weak;
> +extern bool CONFIG_SECURITY_SMACK __kconfig __weak;
> +extern bool CONFIG_SECURITY_APPARMOR __kconfig __weak;
> +
>   #ifndef AF_PACKET
>   #define AF_PACKET 17
>   #endif
> @@ -140,6 +144,10 @@ int BPF_PROG(socket_bind2, struct socket *sock,  
> struct sockaddr *address,
>   int BPF_PROG(socket_alloc, struct sock *sk, int family, gfp_t priority)
>   {
>   	called_socket_alloc++;
> +	/* if already have non-bpf lsms installed, EPERM will cause memory leak  
> of non-bpf lsms */
> +	if (CONFIG_SECURITY_SELINUX || CONFIG_SECURITY_SMACK ||  
> CONFIG_SECURITY_APPARMOR)
> +		return 1;
> +
>   	if (family == AF_UNIX)
>   		return 0; /* EPERM */

> --
> 1.8.3.1

