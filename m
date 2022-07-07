Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 716EDC433EF
	for <linux-security-module@archiver.kernel.org>; Thu,  7 Jul 2022 22:32:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236760AbiGGWci (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 7 Jul 2022 18:32:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236312AbiGGWch (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 7 Jul 2022 18:32:37 -0400
Received: from mail-oa1-x2c.google.com (mail-oa1-x2c.google.com [IPv6:2001:4860:4864:20::2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4A0A65D76
        for <linux-security-module@vger.kernel.org>; Thu,  7 Jul 2022 15:32:36 -0700 (PDT)
Received: by mail-oa1-x2c.google.com with SMTP id 586e51a60fabf-101b4f9e825so27163199fac.5
        for <linux-security-module@vger.kernel.org>; Thu, 07 Jul 2022 15:32:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=w5ngIuUcsL6V72N4sBi1nVKjzL39vm3/CQze7FH+2hA=;
        b=YnZCQafPM5prD6/n+Fb5qat9jQy+eMYSObcvtGYlOA7HZtw4hrgj5iKVvG/KF/lwid
         FW+SUFxTPlYJodi+C5GQdnzT/E2LyvPJ3qJ8JvDmW5gZ+cB+wDuXel/62IPfMynLw11d
         92w1iWcm9u4S7M9C6Bl/r9VYJOJTIygJlHTes=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=w5ngIuUcsL6V72N4sBi1nVKjzL39vm3/CQze7FH+2hA=;
        b=0a12MqEvIxdTDB22GYG2Lng9LyRZtkxzK346FDR5KNkUIVK7c3V92b784gtTUsKBtJ
         G5dowiX6OvNt8F0QE9L96lVx6vpnK9KEICgaf6Zb4xVyT1/WQ08VMO3tXlFXJnYpUzgi
         ZVCi9h36x0UL8PMiEeRhqDpT10w274271OoQpMiwKvzZ9J01N7UHOWkpicD7dzEIf1iz
         sg+jlesmyJy514yHUjtaqzaOIP58EWKz2iQ+1D0REzZGJzJOezsmF8KxsIUF0Z/0wuV4
         Nkiq9CGSop57w3zfqUSOtHgWTHjgQDcva7bNbgPHTOsQokurMpvqbmU+wMeMkUfFjZKp
         KQ2w==
X-Gm-Message-State: AJIora+WYurrxQ1Aq1Gm9jWOMhEquBuE20deF3b/3W4rdDA1hnjt+n1t
        9uXMLvXhEMSSxRW5SA8RB6iKOQ==
X-Google-Smtp-Source: AGRyM1vIqtnT6lw5R/fcEfoiZ5MwUbb7toc3P9udUrr7HIOVUFz0P7kJ2u/nLlL3mSC8VGz+3bVwpA==
X-Received: by 2002:a05:6870:2049:b0:101:1df6:8fc with SMTP id l9-20020a056870204900b001011df608fcmr111637oad.125.1657233156130;
        Thu, 07 Jul 2022 15:32:36 -0700 (PDT)
Received: from localhost.localdomain ([184.4.90.121])
        by smtp.gmail.com with ESMTPSA id i16-20020a05683033f000b00616b835f5e7sm16246222otu.43.2022.07.07.15.32.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Jul 2022 15:32:35 -0700 (PDT)
From:   Frederick Lawler <fred@cloudflare.com>
To:     kpsingh@kernel.org, revest@chromium.org, jackmanb@chromium.org,
        ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        john.fastabend@gmail.com, jmorris@namei.org, serge@hallyn.com,
        paul@paul-moore.com, stephen.smalley.work@gmail.com,
        eparis@parisplace.org, shuah@kernel.org, brauner@kernel.org,
        casey@schaufler-ca.com, ebiederm@xmission.com, bpf@vger.kernel.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        kernel-team@cloudflare.com, Frederick Lawler <fred@cloudflare.com>
Subject: [PATCH v2 0/4] Introduce security_create_user_ns()
Date:   Thu,  7 Jul 2022 17:32:24 -0500
Message-Id: <20220707223228.1940249-1-fred@cloudflare.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

While creating a LSM BPF MAC policy to block user namespace creation, we
used the LSM cred_prepare hook because that is the closest hook to prevent
a call to create_user_ns().

The calls look something like this:

    cred = prepare_creds()
        security_prepare_creds()
            call_int_hook(cred_prepare, ...
    if (cred)
        create_user_ns(cred)

We noticed that error codes were not propagated from this hook and
introduced a patch [1] to propagate those errors.

The discussion notes that security_prepare_creds()
is not appropriate for MAC policies, and instead the hook is
meant for LSM authors to prepare credentials for mutation. [2]

Ultimately, we concluded that a better course of action is to introduce
a new security hook for LSM authors. [3]

This patch set first introduces a new security_create_user_ns() function
and create_user_ns LSM hook, then marks the hook as sleepable in BPF.

Links:
1. https://lore.kernel.org/all/20220608150942.776446-1-fred@cloudflare.com/
2. https://lore.kernel.org/all/87y1xzyhub.fsf@email.froward.int.ebiederm.org/
3. https://lore.kernel.org/all/9fe9cd9f-1ded-a179-8ded-5fde8960a586@cloudflare.com/

Changes since v1:
- Add selftests/bpf: Add tests verifying bpf lsm create_user_ns hook patch
- Add selinux: Implement create_user_ns hook patch
- Change function signature of security_create_user_ns() to only take
  struct cred
- Move security_create_user_ns() call after id mapping check in
  create_user_ns()
- Update documentation to reflect changes

Frederick Lawler (4):
  security, lsm: Introduce security_create_user_ns()
  bpf-lsm: Make bpf_lsm_create_user_ns() sleepable
  selftests/bpf: Add tests verifying bpf lsm create_user_ns hook
  selinux: Implement create_user_ns hook

 include/linux/lsm_hook_defs.h                 |  1 +
 include/linux/lsm_hooks.h                     |  4 +
 include/linux/security.h                      |  6 ++
 kernel/bpf/bpf_lsm.c                          |  1 +
 kernel/user_namespace.c                       |  5 ++
 security/security.c                           |  5 ++
 security/selinux/hooks.c                      |  9 ++
 security/selinux/include/classmap.h           |  2 +
 .../selftests/bpf/prog_tests/deny_namespace.c | 88 +++++++++++++++++++
 .../selftests/bpf/progs/test_deny_namespace.c | 39 ++++++++
 10 files changed, 160 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/deny_namespace.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_deny_namespace.c

-- 
2.30.2

