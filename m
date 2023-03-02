Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E1D3C7EE30
	for <linux-security-module@archiver.kernel.org>; Thu,  2 Mar 2023 20:29:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230102AbjCBU31 (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 2 Mar 2023 15:29:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229970AbjCBU3Q (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 2 Mar 2023 15:29:16 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4A4C2202D;
        Thu,  2 Mar 2023 12:29:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description;
        bh=+Hoy53VeqZDOL/t9ch2P6jt/ahEQQ6UBHYjZPmP5kVI=; b=Pc795+UC8GmLBrVgybdkFp55Y8
        315+vdPN8i3iM63aUS7f+Bs9nYk0siO1Smy4WXyTKX4WnXYTW317Ls+MdoHwjPtaJBBNrmkKmrRIZ
        KHYF0wDjJ9lM0uHA+Yoa5IWrsNzTN0F5G24GFM0fnpK94APmt7QI6hLGYvl6S5RM9LQx7qtZzAJ1a
        wo+xnJLrUNLJLtoY4EOjzj1p9mOCpV+GCulivVw8EcDbsAKVp7urur1hSh0wTy0UyyHkfajf7F0Yc
        u6Y+2ntmlAtdyf/PeyB09Rnt5PWHWHN3RIoFE1e6NjYSeBtRijn7YFOFzIRKFO2ougvtK7txbQ6y2
        piHryISw==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pXpXS-003FxL-Ca; Thu, 02 Mar 2023 20:28:30 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     ebiederm@xmission.com, keescook@chromium.org, yzaikin@google.com,
        john.johansen@canonical.com, paul@paul-moore.com,
        jmorris@namei.org, serge@hallyn.com, luto@amacapital.net,
        wad@chromium.org, dverkamp@chromium.org, paulmck@kernel.org,
        baihaowen@meizu.com, frederic@kernel.org, jeffxu@google.com,
        ebiggers@kernel.org, tytso@mit.edu, guoren@kernel.org
Cc:     j.granados@samsung.com, zhangpeng362@huawei.com,
        tangmeng@uniontech.com, willy@infradead.org, nixiaoming@huawei.com,
        sujiaxun@uniontech.com, patches@lists.linux.dev,
        linux-fsdevel@vger.kernel.org, apparmor@lists.ubuntu.com,
        linux-security-module@vger.kernel.org, linux-csky@vger.kernel.org,
        linux-kernel@vger.kernel.org, Luis Chamberlain <mcgrof@kernel.org>
Subject: [PATCH 07/11] seccomp: simplify sysctls with register_sysctl_init()
Date:   Thu,  2 Mar 2023 12:28:22 -0800
Message-Id: <20230302202826.776286-8-mcgrof@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230302202826.776286-1-mcgrof@kernel.org>
References: <20230302202826.776286-1-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Luis Chamberlain <mcgrof@infradead.org>
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

register_sysctl_paths() is only needed if you have childs (directories)
with entries. Just use register_sysctl_init() as it also does the
kmemleak check for you.

Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 kernel/seccomp.c | 15 +--------------
 1 file changed, 1 insertion(+), 14 deletions(-)

diff --git a/kernel/seccomp.c b/kernel/seccomp.c
index cebf26445f9e..d3e584065c7f 100644
--- a/kernel/seccomp.c
+++ b/kernel/seccomp.c
@@ -2368,12 +2368,6 @@ static int seccomp_actions_logged_handler(struct ctl_table *ro_table, int write,
 	return ret;
 }
 
-static struct ctl_path seccomp_sysctl_path[] = {
-	{ .procname = "kernel", },
-	{ .procname = "seccomp", },
-	{ }
-};
-
 static struct ctl_table seccomp_sysctl_table[] = {
 	{
 		.procname	= "actions_avail",
@@ -2392,14 +2386,7 @@ static struct ctl_table seccomp_sysctl_table[] = {
 
 static int __init seccomp_sysctl_init(void)
 {
-	struct ctl_table_header *hdr;
-
-	hdr = register_sysctl_paths(seccomp_sysctl_path, seccomp_sysctl_table);
-	if (!hdr)
-		pr_warn("sysctl registration failed\n");
-	else
-		kmemleak_not_leak(hdr);
-
+	register_sysctl_init("kernel/seccomp", seccomp_sysctl_table);
 	return 0;
 }
 
-- 
2.39.1

