Return-Path: <SRS0=IE2G=4V=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5D18C3F2D1
	for <linux-security-module@archiver.kernel.org>; Wed,  4 Mar 2020 19:19:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98BAE21739
	for <linux-security-module@archiver.kernel.org>; Wed,  4 Mar 2020 19:19:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="T1MjlvlZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728648AbgCDTTB (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 4 Mar 2020 14:19:01 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:38248 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727543AbgCDTTB (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 4 Mar 2020 14:19:01 -0500
Received: by mail-wm1-f66.google.com with SMTP id u9so3068437wml.3
        for <linux-security-module@vger.kernel.org>; Wed, 04 Mar 2020 11:19:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8wo4NVBWq4hMV0Uyk0sJW7ITSlFnWQiPseL92jPD10I=;
        b=T1MjlvlZJkp7BQwF0NqAGtDa1xEEA66EvvDwwuAru6qg0ImWPjT1Veqc8fPi2XOaX4
         ReN/KGQwTarqQ3dErASoF5ZuVhNp4Q2NzMQiw4Y1oG/QSa1CIUWO4lajpmanrzPzMBM+
         8uPaSP7iL4ChOrCW5eA8yq2rgXJhFbLC+k/Lc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8wo4NVBWq4hMV0Uyk0sJW7ITSlFnWQiPseL92jPD10I=;
        b=q56qyKgYEKicrcrkmDyiyoNq14D07yIbaO7EGmfJJqNGdbA8/g1pm1c7P5q6bLErzN
         Y+13850+KYsa0u/YELC0Meu4b8Cz0jKY3BXnR/jwrhGj/jpWdgaeOKL3qYKNI/hOt6cI
         uaa2ZshwiqV2xf/gfnw+rt0ulTIE2eB33QCZTBxe+FOfeKBM2L1ZtazJciBRa6VBCi8D
         +4uqu/RAXOjEx+kKhlC6G4R302yrW/ZKZFSCT+kC3UXiS1x+RlOuHhPPvevT7k9x8JU4
         UqwyckZhaohhzaRYT92sVCuS4ZY1vWX//g45yO9ROivdfEv7OKgiYDrKQ1eTIF3RZK17
         FOVA==
X-Gm-Message-State: ANhLgQ3tCkje7kL7hsswOjkWSEGbUCjai2iBG5wj97SMQ2gnbkXIa02q
        52Lt6/9tkzjBr5uBFxZ4rTS/ZhojNgY=
X-Google-Smtp-Source: ADFU+vvT1/8NAHEldDDSRPgi/t2SkbJpqSAukdFZRM53YwDYRes8+Bvn1avs8UL6rd4OMtaK/upaIw==
X-Received: by 2002:a1c:49d5:: with SMTP id w204mr5210818wma.55.1583349538284;
        Wed, 04 Mar 2020 11:18:58 -0800 (PST)
Received: from kpsingh-kernel.localdomain (77-56-209-237.dclient.hispeed.ch. [77.56.209.237])
        by smtp.gmail.com with ESMTPSA id w9sm2018556wrn.35.2020.03.04.11.18.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2020 11:18:57 -0800 (PST)
From:   KP Singh <kpsingh@chromium.org>
To:     linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Paul Turner <pjt@google.com>, Jann Horn <jannh@google.com>,
        Florent Revest <revest@chromium.org>,
        Brendan Jackman <jackmanb@chromium.org>
Subject: [PATCH bpf-next v4 0/7] Introduce BPF_MODIFY_RET tracing progs
Date:   Wed,  4 Mar 2020 20:18:46 +0100
Message-Id: <20200304191853.1529-1-kpsingh@chromium.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

From: KP Singh <kpsingh@google.com>

v3 -> v4:

* Fix a memory leak noticed by Daniel.

v2 -> v3:

* bpf_trampoline_update_progs -> bpf_trampoline_get_progs + const
  qualification.
* Typos in commit messages.
* Added Andrii's Acks.

v1 -> v2:

* Adressed Andrii's feedback.
* Fixed a bug that Alexei noticed about nop generation.
* Rebase.

This was brought up in the KRSI v4 discussion and found to be useful
both for security and tracing programs.

  https://lore.kernel.org/bpf/20200225193108.GB22391@chromium.org/

The modify_return programs are allowed for security hooks (with an
extra CAP_MAC_ADMIN check) and functions whitelisted for error
injection (ALLOW_ERROR_INJECTION).

The "security_" check is expected to be cleaned up with the KRSI patch
series.

Here is an example of how a fmod_ret program behaves:

int func_to_be_attached(int a, int b)
{  <--- do_fentry

do_fmod_ret:
   <update ret by calling fmod_ret>
   if (ret != 0)
        goto do_fexit;

original_function:

    <side_effects_happen_here>

}  <--- do_fexit

ALLOW_ERROR_INJECTION(func_to_be_attached, ERRNO)

The fmod_ret program attached to this function can be defined as:

SEC("fmod_ret/func_to_be_attached")
int BPF_PROG(func_name, int a, int b, int ret)
{
        // This will skip the original function logic.
        return -1;
}


KP Singh (7):
  bpf: Refactor trampoline update code
  bpf: JIT helpers for fmod_ret progs
  bpf: Introduce BPF_MODIFY_RETURN
  bpf: Attachment verification for BPF_MODIFY_RETURN
  tools/libbpf: Add support for BPF_MODIFY_RETURN
  bpf: Add test ops for BPF_PROG_TYPE_TRACING
  bpf: Add selftests for BPF_MODIFY_RETURN

 arch/x86/net/bpf_jit_comp.c                   | 279 +++++++++++++-----
 include/linux/bpf.h                           |  24 +-
 include/uapi/linux/bpf.h                      |   1 +
 kernel/bpf/bpf_struct_ops.c                   |  10 +-
 kernel/bpf/btf.c                              |  27 +-
 kernel/bpf/syscall.c                          |   1 +
 kernel/bpf/trampoline.c                       |  65 ++--
 kernel/bpf/verifier.c                         |  32 ++
 kernel/trace/bpf_trace.c                      |   1 +
 net/bpf/test_run.c                            |  57 +++-
 tools/include/uapi/linux/bpf.h                |   1 +
 tools/lib/bpf/libbpf.c                        |   4 +
 .../selftests/bpf/prog_tests/fentry_fexit.c   |  12 +-
 .../selftests/bpf/prog_tests/fentry_test.c    |  14 +-
 .../selftests/bpf/prog_tests/fexit_test.c     |  69 ++---
 .../selftests/bpf/prog_tests/modify_return.c  |  65 ++++
 .../selftests/bpf/progs/modify_return.c       |  49 +++
 17 files changed, 524 insertions(+), 187 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/modify_return.c
 create mode 100644 tools/testing/selftests/bpf/progs/modify_return.c

-- 
2.20.1

