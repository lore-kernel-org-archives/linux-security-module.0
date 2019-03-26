Return-Path: <SRS0=+HMg=R5=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03F60C43381
	for <linux-security-module@archiver.kernel.org>; Tue, 26 Mar 2019 23:08:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AFAC72075D
	for <linux-security-module@archiver.kernel.org>; Tue, 26 Mar 2019 23:08:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gzzmnCFy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731912AbfCZXIw (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 26 Mar 2019 19:08:52 -0400
Received: from mail-vk1-f201.google.com ([209.85.221.201]:55884 "EHLO
        mail-vk1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730605AbfCZXIw (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 26 Mar 2019 19:08:52 -0400
Received: by mail-vk1-f201.google.com with SMTP id h131so6156018vke.22
        for <linux-security-module@vger.kernel.org>; Tue, 26 Mar 2019 16:08:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=GjNnKmgb5twpvjGPRAxP6CXCI5uXR+PbThdF1Mj1mrk=;
        b=gzzmnCFyIEQf9Hn5CLbkVbf7Twl9TIq24IKq6T6WRKeMBrsmZvdJTdm34HhzPPziSj
         sVQdD5TXw7LBsiHdQ6T3Nm8KxISfOa3gY13nI8CPM2O/i7by2ujLMyiRXpIqitRpKMC7
         +WL4nc1onihXqXXGXmEyGm/uQFbSYA3yNNu9yHvHoWspIprBj8kpTHoKSY/XaLIiryW8
         meZn8qLWBg7gt/lF9nYKes9Vu9/RrSm2cRMsCR6OFolCJtHYSiCBYuRdV/nkGwnqOOT6
         uc+Ze+JA9N9AjTiUNd6VMP4AlokOjZuh5mJmEdXtleytHpFiWNyKPIpslWYEYWGr3q8g
         RnSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=GjNnKmgb5twpvjGPRAxP6CXCI5uXR+PbThdF1Mj1mrk=;
        b=gw8/5cQTThm9G2qPgAa6RZOx2AypRQq6f8Y3Ki8OvDmkXFcHTNIYgPIeT1euc83kqo
         93HFQJC/IIVzegVPuC9GiWu5s6dZ1nTw0FdiiwishN1gXA/Cn64d1DWovygfJc/89Uo5
         QxUrUtxFyqQ/CjXth1nmCCewwqE+xJsVSr2iQfhB/ta82EU29OJrvWy6d9oZPAUbqIrp
         3oNvggfREN/DUvKiryxapQTetFWuzX6HgcblS2qKVsAU1ZriJ/fbUo3T7W3fTWRkECbT
         K5FbAur4+QjzXY4CBGKKWUo0XCDWaYnullRrhKWhvXKv/EM7QFsVJk4ITLpta0lptJhi
         xfuA==
X-Gm-Message-State: APjAAAUUmg1dqy5nWMgT+qViaUUvSUf1XCMb0FE6oYQBguPy9wU+GaeN
        seGYHt7RrP2DNINkHv7GuWCypWiKXQ==
X-Google-Smtp-Source: APXvYqzL9mJw/UGcf42MrCwWSbltjKBNitRR6qMZbpsiED6cPdSMisybpHTSZgzGF0htz59Ob1MX6C0Tng==
X-Received: by 2002:ab0:6819:: with SMTP id z25mr6954456uar.0.1553641731140;
 Tue, 26 Mar 2019 16:08:51 -0700 (PDT)
Date:   Wed, 27 Mar 2019 00:08:41 +0100
Message-Id: <20190326230841.87834-1-jannh@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.21.0.392.gf8f6787159e-goog
Subject: [PATCH] Yama: mark local symbols as static
From:   Jann Horn <jannh@google.com>
To:     Kees Cook <keescook@chromium.org>, jannh@google.com
Cc:     linux-kernel@vger.kernel.org, James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

sparse complains that Yama defines functions and a variable as non-static
even though they don't exist in any header. Fix it by making them static.

Signed-off-by: Jann Horn <jannh@google.com>
---
 security/yama/yama_lsm.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/security/yama/yama_lsm.c b/security/yama/yama_lsm.c
index 57cc60722dd3..06b14a57b0a4 100644
--- a/security/yama/yama_lsm.c
+++ b/security/yama/yama_lsm.c
@@ -206,7 +206,7 @@ static void yama_ptracer_del(struct task_struct *tracer,
  * yama_task_free - check for task_pid to remove from exception list
  * @task: task being removed
  */
-void yama_task_free(struct task_struct *task)
+static void yama_task_free(struct task_struct *task)
 {
 	yama_ptracer_del(task, task);
 }
@@ -401,7 +401,7 @@ static int yama_ptrace_access_check(struct task_struct *child,
  *
  * Returns 0 if following the ptrace is allowed, -ve on error.
  */
-int yama_ptrace_traceme(struct task_struct *parent)
+static int yama_ptrace_traceme(struct task_struct *parent)
 {
 	int rc = 0;
 
@@ -452,7 +452,7 @@ static int yama_dointvec_minmax(struct ctl_table *table, int write,
 static int zero;
 static int max_scope = YAMA_SCOPE_NO_ATTACH;
 
-struct ctl_path yama_sysctl_path[] = {
+static struct ctl_path yama_sysctl_path[] = {
 	{ .procname = "kernel", },
 	{ .procname = "yama", },
 	{ }
-- 
2.21.0.392.gf8f6787159e-goog

