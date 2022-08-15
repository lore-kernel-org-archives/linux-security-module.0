Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF56DC25B0E
	for <linux-security-module@archiver.kernel.org>; Mon, 15 Aug 2022 16:20:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232417AbiHOQUs (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 15 Aug 2022 12:20:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232675AbiHOQUn (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 15 Aug 2022 12:20:43 -0400
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 236101DA47
        for <linux-security-module@vger.kernel.org>; Mon, 15 Aug 2022 09:20:39 -0700 (PDT)
Received: by mail-ot1-x32e.google.com with SMTP id l5-20020a05683004a500b0063707ff8244so5748065otd.12
        for <linux-security-module@vger.kernel.org>; Mon, 15 Aug 2022 09:20:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=MJrznwOS4iDI2OpucHPY/z4vNYitgwRbWuSlr+3wOv0=;
        b=x58yM22xkTNeiyCqG9ou9XMvzSvlhZ8QkCbKqqdIi6Y5OLHHn3dXB0vhofX7kY1wxk
         /Aj/rFeOrOZuEA7qcwZW9Kk/unT4g2j/6pvMojj0ncqsuof+qm+EMz5425ppDkeoBpVN
         MedvwhyTdPSPm50RlayssJ3m4WqnH/KJq6UUA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=MJrznwOS4iDI2OpucHPY/z4vNYitgwRbWuSlr+3wOv0=;
        b=ZKzf/gFidQhJneNHkyIOTR0Gn9kvtwra0EXGoHtxbuxNK/TTu2S7puQigGcg/2Qi+C
         +SEUWReT/gc7vmhJlSYrxQ6m7GR1BPjrie+QOCXbaoGLcYxbdUVo+S+JeYorES1rh+F9
         bMTDPMB2zqzX6S/vEoBr9DcgKn7CREWgbvVn/u3kqXCfSB+nuv4RMMKyy631f+ArBQRi
         LWDTGkttfM3T2dNkPnBnZUhyC0uiR1pG+xoo/OFb9t0jgniQjG2y0xO8pPR4VwNa4j5U
         khaM/xUqzmUG0w4PPQngQDAW9P7nnJ9CwAVb7CO1iZkY6iYGSktsG6HyVS90Trqfxnwo
         mlPQ==
X-Gm-Message-State: ACgBeo0G1wd9GtO+h333d7T9XhgBk5B9JKCoJf5arWVOM7b20sEt+tHf
        9pPLxZKhbtBpgJv+VqsNxHe+dA==
X-Google-Smtp-Source: AA6agR6g7xKSXJLfRY1lzp/6aAIs7KluhqFOW4lJXq/4FCo8B9qkAgTWY1rxcsZlrxFZ3LAM+8JUnA==
X-Received: by 2002:a9d:6294:0:b0:638:b817:7c87 with SMTP id x20-20020a9d6294000000b00638b8177c87mr1168939otk.378.1660580438743;
        Mon, 15 Aug 2022 09:20:38 -0700 (PDT)
Received: from localhost.localdomain ([184.4.90.121])
        by smtp.gmail.com with ESMTPSA id x91-20020a9d37e4000000b00636ee04e7aesm2163371otb.67.2022.08.15.09.20.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Aug 2022 09:20:38 -0700 (PDT)
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
        kernel-team@cloudflare.com, cgzones@googlemail.com,
        karl@bigbadwolfsecurity.com, tixxdz@gmail.com,
        Frederick Lawler <fred@cloudflare.com>
Subject: [PATCH v5 2/4] bpf-lsm: Make bpf_lsm_userns_create() sleepable
Date:   Mon, 15 Aug 2022 11:20:26 -0500
Message-Id: <20220815162028.926858-3-fred@cloudflare.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220815162028.926858-1-fred@cloudflare.com>
References: <20220815162028.926858-1-fred@cloudflare.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Users may want to audit calls to security_create_user_ns() and access
user space memory. Also create_user_ns() runs without
pagefault_disabled(). Therefore, make bpf_lsm_userns_create() sleepable
for mandatory access control policies.

Acked-by: Alexei Starovoitov <ast@kernel.org>
Acked-by: Christian Brauner (Microsoft) <brauner@kernel.org>
Acked-by: KP Singh <kpsingh@kernel.org>
Signed-off-by: Frederick Lawler <fred@cloudflare.com>

---
Changes since v4:
- None
Changes since v3:
- None
Changes since v2:
- Rename create_user_ns hook to userns_create
Changes since v1:
- None
---
 kernel/bpf/bpf_lsm.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/bpf/bpf_lsm.c b/kernel/bpf/bpf_lsm.c
index fa71d58b7ded..761998fda762 100644
--- a/kernel/bpf/bpf_lsm.c
+++ b/kernel/bpf/bpf_lsm.c
@@ -335,6 +335,7 @@ BTF_ID(func, bpf_lsm_task_getsecid_obj)
 BTF_ID(func, bpf_lsm_task_prctl)
 BTF_ID(func, bpf_lsm_task_setscheduler)
 BTF_ID(func, bpf_lsm_task_to_inode)
+BTF_ID(func, bpf_lsm_userns_create)
 BTF_SET_END(sleepable_lsm_hooks)
 
 bool bpf_lsm_is_sleepable_hook(u32 btf_id)
-- 
2.30.2

