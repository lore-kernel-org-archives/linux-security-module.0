Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFBECC19F2D
	for <linux-security-module@archiver.kernel.org>; Mon,  1 Aug 2022 18:02:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233783AbiHASCY (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 1 Aug 2022 14:02:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233874AbiHASCU (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 1 Aug 2022 14:02:20 -0400
Received: from mail-oo1-xc2d.google.com (mail-oo1-xc2d.google.com [IPv6:2607:f8b0:4864:20::c2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80FC527CE4
        for <linux-security-module@vger.kernel.org>; Mon,  1 Aug 2022 11:02:19 -0700 (PDT)
Received: by mail-oo1-xc2d.google.com with SMTP id c203-20020a4a4fd4000000b0043566a4e265so2153910oob.2
        for <linux-security-module@vger.kernel.org>; Mon, 01 Aug 2022 11:02:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=5eI4oBHRscjr08ZHNzQwOqsOD+3+F4rjZrnwT2lhjk8=;
        b=uLJivFt0JrijlTz4WiJCVuEF8oDRzf5Y7+H6eH45jC4nOYPshmi66MEhwrgCTE8YjQ
         yODopqvVSRyhcT85GJMk/fAiiPPldOdUR5F7OuR5KoOm4IRWjSJfjRi8lsTM6R3QM+QD
         UTvK9WXbkNelJtyCDqvAY/Rpe445Qz2Gi9NSI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=5eI4oBHRscjr08ZHNzQwOqsOD+3+F4rjZrnwT2lhjk8=;
        b=B8IdN+1pBX/yuVOun253k4SCNjYNBCfAtZaEYUvbKmKwazxLBEEkF4OPOcd/T66jkv
         SHQGgTv26I8J/ajza93cjxPzmpjzzkqB2olthWYlRTuxo6kYXICurm+7eWHNHi2SANUx
         B/EUyM/LaIe8gEXWJ9iEpy98U/+BrLGtYGUitcJIjoZweSWXOxwK8Ugw8FMen9S7fEOr
         nAK601NMT5LRZ7TKNU+sTMng+3AOYSCeDiwOsbdUvi7I8bXRBnaSHrWbtrQGozcyNH19
         fA2Sw3YnqMVLG8JbJfMM6Ua7oqqqPkQvSgatDqcJ8FjNJ4CC5rF42KgSylYDHyuuriLf
         d9bg==
X-Gm-Message-State: AJIora8DoJJYzj4+j04i1oghdXaaqaXN5/N9wkZ6JIO1uQQOCj1wXs36
        MPBxZKW/Dld0WjTu/yj/LZBQ9JF3hqHuWQ==
X-Google-Smtp-Source: AGRyM1vzfAiBBDDyxwIMaZa0k2G9WulhjNQ80UDh1E2ApA6+RCreR0vgWj58f08ozl+TDSXb29hD7w==
X-Received: by 2002:a4a:e7d8:0:b0:435:9a05:58b5 with SMTP id y24-20020a4ae7d8000000b004359a0558b5mr5600538oov.54.1659376938810;
        Mon, 01 Aug 2022 11:02:18 -0700 (PDT)
Received: from localhost.localdomain ([184.4.90.121])
        by smtp.gmail.com with ESMTPSA id n14-20020a9d64ce000000b00618fa37308csm2881348otl.35.2022.08.01.11.02.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Aug 2022 11:02:18 -0700 (PDT)
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
        karl@bigbadwolfsecurity.com, Frederick Lawler <fred@cloudflare.com>
Subject: [PATCH v4 2/4] bpf-lsm: Make bpf_lsm_userns_create() sleepable
Date:   Mon,  1 Aug 2022 13:01:44 -0500
Message-Id: <20220801180146.1157914-3-fred@cloudflare.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220801180146.1157914-1-fred@cloudflare.com>
References: <20220801180146.1157914-1-fred@cloudflare.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Users may want to audit calls to security_create_user_ns() and access
user space memory. Also create_user_ns() runs without
pagefault_disabled(). Therefore, make bpf_lsm_userns_create() sleepable
for mandatory access control policies.

Signed-off-by: Frederick Lawler <fred@cloudflare.com>
Acked-by: Christian Brauner (Microsoft) <brauner@kernel.org>

---
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
index c1351df9f7ee..4593437809cc 100644
--- a/kernel/bpf/bpf_lsm.c
+++ b/kernel/bpf/bpf_lsm.c
@@ -250,6 +250,7 @@ BTF_ID(func, bpf_lsm_task_getsecid_obj)
 BTF_ID(func, bpf_lsm_task_prctl)
 BTF_ID(func, bpf_lsm_task_setscheduler)
 BTF_ID(func, bpf_lsm_task_to_inode)
+BTF_ID(func, bpf_lsm_userns_create)
 BTF_SET_END(sleepable_lsm_hooks)
 
 bool bpf_lsm_is_sleepable_hook(u32 btf_id)
-- 
2.30.2

