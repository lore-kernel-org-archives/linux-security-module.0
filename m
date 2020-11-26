Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FF45C63798
	for <linux-security-module@archiver.kernel.org>; Thu, 26 Nov 2020 15:18:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 485A6221F1
	for <linux-security-module@archiver.kernel.org>; Thu, 26 Nov 2020 15:18:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="GY6QZ9aj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390224AbgKZPS3 (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 26 Nov 2020 10:18:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389743AbgKZPS3 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 26 Nov 2020 10:18:29 -0500
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6898C0617A7
        for <linux-security-module@vger.kernel.org>; Thu, 26 Nov 2020 07:18:28 -0800 (PST)
Received: by mail-lj1-x243.google.com with SMTP id r18so2745010ljc.2
        for <linux-security-module@vger.kernel.org>; Thu, 26 Nov 2020 07:18:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GPXg0sqGSLG0UcV+BOdF/ev2TrBOmf0+tzuWK+lzNxY=;
        b=GY6QZ9ajA72zJW7zsjgD0Z3DcuNaA/I15KO9ANEh9fNsKzrQqN0ACEnT7F535wLYWW
         zkMDm//21gdgEsJzCyx9c1XFXVbvqfnwDMRXWa642OlDGGTCV9nXeoSEhDd1eOxKA+6p
         a8BZXq44VHbsKqR9EWry1iuV1sp9X8B+5+exI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GPXg0sqGSLG0UcV+BOdF/ev2TrBOmf0+tzuWK+lzNxY=;
        b=q57RogEFk1CWm2PsvxFoy8JtO9fAjs9c4FeTf8N0up4tjQfm64YAn2iAAZHgbRv0XC
         ClyINasxMx1HkAM18osYB4pZ1BPODX/c6xd4FkV9y/1BdBFfYo5wlPoqShevTSvmRD/Y
         qPLMrWgQSs5/ywaQkiUwcX4ZhPPcpnfIqBiqYzlbOU/xXdmLePze0AVktH2lKlenRNz+
         o811hhaZIgd209Qd3nsyyjnPD3s8jqhLpIsobqPoqHZsvARp7iXfIhpO5agQreXFcfKs
         ZVUGQgLGb8LG2azGEd88pYPdnoEkBA0Ug3o+6rzaaCgsj7yDi7pO5R4nknsBgx+B7OOz
         FysQ==
X-Gm-Message-State: AOAM53036Eo/2Jtw8vDaP3Ov1QzfJOxXqupeHmKoRr/xibSru6VGv6zv
        8cYN+WsNIWMO523vGxMnNI35Z2AyLmNPjJuMU1Jxsw==
X-Google-Smtp-Source: ABdhPJzEGWhyk6/I8i+D+5kzxLmAaJHtLCJpQ4SDw/4GTv4UmjS7Uwll/lhR7TWTTecVg3Y4Xf+4RYEET16LXcbK9xA=
X-Received: by 2002:a2e:984e:: with SMTP id e14mr1593226ljj.110.1606403907228;
 Thu, 26 Nov 2020 07:18:27 -0800 (PST)
MIME-Version: 1.0
References: <20201124151210.1081188-1-kpsingh@chromium.org>
 <20201124151210.1081188-4-kpsingh@chromium.org> <a5c2244f-c733-ef78-7347-ac0a2a6bb77f@fb.com>
In-Reply-To: <a5c2244f-c733-ef78-7347-ac0a2a6bb77f@fb.com>
From:   KP Singh <kpsingh@chromium.org>
Date:   Thu, 26 Nov 2020 16:18:16 +0100
Message-ID: <CACYkzJ4w8RzJPqRZ9hZ=EdoX1qMr3UvA+V3nyse+NSvPAJem9g@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 3/3] bpf: Add a selftest for bpf_ima_inode_hash
To:     Yonghong Song <yhs@fb.com>
Cc:     James Morris <jmorris@namei.org>,
        open list <linux-kernel@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>,
        Linux Security Module list 
        <linux-security-module@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Florent Revest <revest@chromium.org>,
        Brendan Jackman <jackmanb@chromium.org>,
        Mimi Zohar <zohar@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

[...]

> > +             exit(errno);
>
> Running test_progs-no-alu32, the test failed as:
>
> root@arch-fb-vm1:~/net-next/net-next/tools/testing/selftests/bpf
> ./test_progs-no_alu32 -t test_ima

Note to self: Also start testing test_progs-no_alu32

>
> sh: ./ima_setup.sh: No such file or directory
>
> sh: ./ima_setup.sh: No such file or directory
>
> test_test_ima:PASS:skel_load 0 nsec
>
> test_test_ima:PASS:attach 0 nsec
>
> test_test_ima:PASS:mkdtemp 0 nsec
>
> test_test_ima:FAIL:56
>
> test_test_ima:FAIL:71
>
> #114 test_ima:FAIL
>
> Summary: 0/0 PASSED, 0 SKIPPED, 1 FAILED
>
> Although the file is indeed in this directory:
> root@arch-fb-vm1:~/net-next/net-next/tools/testing/selftests/bpf ls
> ima_setup.sh
> ima_setup.sh
>
> I think the execution actually tries to get file from
> no_alu32 directory to avoid reusing the same files in
> .../testing/selftests/bpf for -mcpu=v3 purpose.
>
> The following change, which copies ima_setup.sh to
> no_alu32 directory, seems fixing the issue:

Thanks!

>
> TRUNNER_EXTRA_SOURCES := test_progs.c cgroup_helpers.c trace_helpers.c
>      \
>                           network_helpers.c testing_helpers.c            \
>                           btf_helpers.c  flow_dissector_load.h
>   TRUNNER_EXTRA_FILES := $(OUTPUT)/urandom_read                          \
> +                      ima_setup.sh                                     \
>                         $(wildcard progs/btf_dump_test_case_*.c)
>   TRUNNER_BPF_BUILD_RULE := CLANG_BPF_BUILD_RULE
>   TRUNNER_BPF_CFLAGS := $(BPF_CFLAGS) $(CLANG_CFLAGS)
>
> Could you do a followup on this?

Yes, I will send out a fix today.

- KP
