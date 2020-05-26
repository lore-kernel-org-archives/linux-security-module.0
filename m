Return-Path: <SRS0=6tJK=7I=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04D4CC433E0
	for <linux-security-module@archiver.kernel.org>; Tue, 26 May 2020 16:33:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D1E1120776
	for <linux-security-module@archiver.kernel.org>; Tue, 26 May 2020 16:33:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="S1vl8LNQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728686AbgEZQdl (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 26 May 2020 12:33:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728350AbgEZQdk (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 26 May 2020 12:33:40 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37359C03E96F
        for <linux-security-module@vger.kernel.org>; Tue, 26 May 2020 09:33:40 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id x14so15672695wrp.2
        for <linux-security-module@vger.kernel.org>; Tue, 26 May 2020 09:33:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3d51jgWtfOexQMR16pUfp1Ft+cFFsdNIgNCbJ0oO6z8=;
        b=S1vl8LNQNGh9Z9oQEIaEr3gX4dBzKdAj9yZBl9C8Z9eB9PxSDAHYk+yztCPZT/cc5o
         EiTXiXfHkY+NQVCYy4gS0Vd+ufYrK/Nqn88WnMiNYw8VNbr//5v5JAfanWXjVaa4UPa/
         IXmxKiSMm+hlWLN126CkuJ2x4CDQDobvrDzb8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3d51jgWtfOexQMR16pUfp1Ft+cFFsdNIgNCbJ0oO6z8=;
        b=b2msHo0MUWoK8eXUNRxKxvE8Ddmr+F7Z0yJ1bKeEsCefnDCuPXoAsEWv+pChUI3VlA
         /2jc2S+g/oNZWMpv4E/iM+XIqMcdHyP/nYVnP0rkpZlFBhNqFPvEsxiBTXoMHbqq8zvd
         GDF72d4XzUTOWCiu6x5A4l86xD91WnqGXFifV1gLnFEMFmsw+Ra/lT9KF26G8awcJbKn
         pr1xL9FGJf3XYF55RMCtBv7oiJOkdUBaE03sENOZurGiJNyBC4ISw7xQ1uLNUxxEo8NK
         2B+N6Eg1GZlOBlLdSZUzOXAV0/jfh2saqo6nCwBK4NXcy80JmfkTpkquenzhNF2G61I1
         kB4g==
X-Gm-Message-State: AOAM5311OMgtUlxb+A3yd5GfNfayfOI9IoWgtBaVzRtRY1U7TjOxgwWx
        +1LypDS7WCq4nMVLK20uIx2CNJ1Ihps=
X-Google-Smtp-Source: ABdhPJySwURRYLxVZfz9zYM60ZLeI2UfSrRa2z7iq8zE9ysrRYMQUfSNRCioM6c/ISpeYj/hrPKyAw==
X-Received: by 2002:a05:6000:110b:: with SMTP id z11mr22098919wrw.16.1590510818551;
        Tue, 26 May 2020 09:33:38 -0700 (PDT)
Received: from kpsingh.zrh.corp.google.com ([81.6.44.51])
        by smtp.gmail.com with ESMTPSA id k17sm48654wmj.15.2020.05.26.09.33.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2020 09:33:37 -0700 (PDT)
From:   KP Singh <kpsingh@chromium.org>
To:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        bpf@vger.kernel.org, linux-security-module@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        James Morris <jmorris@namei.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Martin KaFai Lau <kafai@fb.com>,
        Florent Revest <revest@chromium.org>
Subject: [PATCH bpf-next 0/4] Generalizing bpf_local_storage
Date:   Tue, 26 May 2020 18:33:32 +0200
Message-Id: <20200526163336.63653-1-kpsingh@chromium.org>
X-Mailer: git-send-email 2.27.0.rc0.183.gde8f92d652-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

From: KP Singh <kpsingh@google.com>

bpf_sk_storage can already be used by some BPF program types to annotate
socket objects. These annotations are managed with the life-cycle of the
object (i.e. freed when the object is freed) which makes BPF programs
much simpler and less prone to errors and leaks.

This patch series:

* Generalizes the bpf_sk_storage infrastructure to allow easy
  implementation of local storage for other objects
* Implements local storage for inodes
* Makes both bpf_{sk, inode}_storage available to LSM programs.

Local storage is safe to use in LSM programs as the attachment sites are
limited and the owning object won't be freed, however, this is not the
case for tracing. Usage in tracing is expected to follow a white-list
based approach similar to the d_path helper
(https://lore.kernel.org/bpf/20200506132946.2164578-1-jolsa@kernel.org).

Access to local storage would allow LSM programs to implement stateful
detections like detecting the unlink of a running executable from the
examples shared as a part of the KRSI series
https://lore.kernel.org/bpf/20200329004356.27286-1-kpsingh@chromium.org/
and
https://github.com/sinkap/linux-krsi/blob/patch/v1/examples/samples/bpf/lsm_detect_exec_unlink.c


*** BLURB HERE ***

KP Singh (4):
  bpf: Generalize bpf_sk_storage
  bpf: Implement bpf_local_storage for inodes
  bpf: Allow local storage to be used from LSM programs
  bpf: Add selftests for local_storage

 fs/inode.c                                    |    3 +
 .../bpf_local_storage.h}                      |   14 +-
 include/linux/bpf_types.h                     |    1 +
 include/linux/fs.h                            |    5 +
 include/net/sock.h                            |    4 +-
 include/uapi/linux/bpf.h                      |   54 +-
 kernel/bpf/Makefile                           |    4 +
 kernel/bpf/bpf_local_storage.c                | 1595 +++++++++++++++++
 kernel/bpf/bpf_lsm.c                          |   20 +-
 kernel/bpf/cgroup.c                           |    2 +-
 kernel/bpf/syscall.c                          |    3 +-
 kernel/bpf/verifier.c                         |   10 +
 net/bpf/test_run.c                            |    2 +-
 net/core/Makefile                             |    1 -
 net/core/bpf_sk_storage.c                     | 1183 ------------
 net/core/filter.c                             |    2 +-
 net/core/sock.c                               |    2 +-
 net/ipv4/bpf_tcp_ca.c                         |    2 +-
 net/ipv4/inet_diag.c                          |    2 +-
 tools/bpf/bpftool/map.c                       |    1 +
 tools/include/uapi/linux/bpf.h                |   54 +-
 tools/lib/bpf/libbpf_probes.c                 |    5 +-
 .../bpf/prog_tests/test_local_storage.c       |   60 +
 .../selftests/bpf/progs/local_storage.c       |  139 ++
 24 files changed, 1959 insertions(+), 1209 deletions(-)
 rename include/{net/bpf_sk_storage.h => linux/bpf_local_storage.h} (72%)
 create mode 100644 kernel/bpf/bpf_local_storage.c
 delete mode 100644 net/core/bpf_sk_storage.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/test_local_storage.c
 create mode 100644 tools/testing/selftests/bpf/progs/local_storage.c

-- 
2.27.0.rc0.183.gde8f92d652-goog

