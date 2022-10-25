Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D0B6C38A2D
	for <linux-security-module@archiver.kernel.org>; Tue, 25 Oct 2022 03:59:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230292AbiJYD7i (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 24 Oct 2022 23:59:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbiJYD7g (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 24 Oct 2022 23:59:36 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4D197FFAE
        for <linux-security-module@vger.kernel.org>; Mon, 24 Oct 2022 20:59:33 -0700 (PDT)
Received: from kwepemi500012.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4MxJ935fJdzHvD3;
        Tue, 25 Oct 2022 11:59:19 +0800 (CST)
Received: from cgs.huawei.com (10.244.148.83) by
 kwepemi500012.china.huawei.com (7.221.188.12) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 25 Oct 2022 11:59:31 +0800
From:   Gaosheng Cui <cuigaosheng1@huawei.com>
To:     <john.johansen@canonical.com>, <paul@paul-moore.com>,
        <jmorris@namei.org>, <serge@hallyn.com>, <cuigaosheng1@huawei.com>
CC:     <apparmor@lists.ubuntu.com>,
        <linux-security-module@vger.kernel.org>
Subject: [PATCH -next] apparmor: fix a memleak in free_ruleset()
Date:   Tue, 25 Oct 2022 11:59:30 +0800
Message-ID: <20221025035930.2151976-1-cuigaosheng1@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.244.148.83]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemi500012.china.huawei.com (7.221.188.12)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

When the aa_profile is released, we will call free_ruleset to
release aa_ruleset, but we don't free the memory of aa_ruleset,
so there will be memleak, fix it.

unreferenced object 0xffff8881475df800 (size 1024):
  comm "apparmor_parser", pid 883, jiffies 4294899650 (age 9114.088s)
  hex dump (first 32 bytes):
    00 f8 5d 47 81 88 ff ff 00 f8 5d 47 81 88 ff ff  ..]G......]G....
    00 00 00 00 00 00 00 00 00 dc 65 47 81 88 ff ff  ..........eG....
  backtrace:
    [<00000000370e658e>] __kmem_cache_alloc_node+0x182/0x700
    [<00000000f2f5a6d2>] kmalloc_trace+0x2c/0x130
    [<00000000c5c905b3>] aa_alloc_profile+0x1bc/0x5c0
    [<00000000bc4fa72b>] unpack_profile+0x319/0x30c0
    [<00000000eab791e9>] aa_unpack+0x307/0x1450
    [<000000002c3a6ee1>] aa_replace_profiles+0x1b8/0x3790
    [<00000000d0c3fd54>] policy_update+0x35a/0x890
    [<00000000d04fed90>] profile_replace+0x1d1/0x260
    [<00000000cba0c0a7>] vfs_write+0x283/0xd10
    [<000000006bae64a5>] ksys_write+0x134/0x260
    [<00000000b2fd8f31>] __x64_sys_write+0x78/0xb0
    [<00000000f3c8a015>] do_syscall_64+0x5c/0x90
    [<00000000a242b1db>] entry_SYSCALL_64_after_hwframe+0x63/0xcd

Fixes: 217af7e2f4de ("apparmor: refactor profile rules and attachments")
Signed-off-by: Gaosheng Cui <cuigaosheng1@huawei.com>
---
 security/apparmor/policy.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/security/apparmor/policy.c b/security/apparmor/policy.c
index 6f4cc8bfe03d..ebb99a12929b 100644
--- a/security/apparmor/policy.c
+++ b/security/apparmor/policy.c
@@ -215,6 +215,7 @@ static void free_ruleset(struct aa_ruleset *rules)
 	for (i = 0; i < rules->secmark_count; i++)
 		kfree_sensitive(rules->secmark[i].label);
 	kfree_sensitive(rules->secmark);
+	kfree_sensitive(rules);
 }
 
 struct aa_ruleset *aa_alloc_ruleset(gfp_t gfp)
-- 
2.25.1

