Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB10CC433F5
	for <linux-security-module@archiver.kernel.org>; Tue,  5 Apr 2022 10:34:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241894AbiDEKgB (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 5 Apr 2022 06:36:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242682AbiDEJhz (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 5 Apr 2022 05:37:55 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F1B3A1445;
        Tue,  5 Apr 2022 02:24:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6BE45B81C69;
        Tue,  5 Apr 2022 09:24:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEE4DC385A2;
        Tue,  5 Apr 2022 09:24:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1649150665;
        bh=S9aXtfEKDGdBQZkVkd+a1yTaeGJtvtEgjUrZ0wayzj4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tyujKVS8wKWcbVSzxWWYCeqlh6QKdMbI4yElPpuvcBq/pPWnSLtA8MdzlknEUyeI6
         NjKgO5697yIz7GyxDpWwBk27jQsWDCjdBrlJ+9R6GBfzz4/LpHsRoLSFC+ECnQCtY4
         gZsxQFMA26pYKJiuZ3VYOMedt5ThgEd5lHIEC/h8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, linux-security-module@vger.kernel.org,
        Christian Brauner <christian.brauner@ubuntu.com>,
        =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@linux.microsoft.com>
Subject: [PATCH 5.15 137/913] landlock: Use square brackets around "landlock-ruleset"
Date:   Tue,  5 Apr 2022 09:19:59 +0200
Message-Id: <20220405070343.938274918@linuxfoundation.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220405070339.801210740@linuxfoundation.org>
References: <20220405070339.801210740@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

From: Christian Brauner <christian.brauner@ubuntu.com>

commit aea0b9f2486da8497f35c7114b764bf55e17c7ea upstream.

Make the name of the anon inode fd "[landlock-ruleset]" instead of
"landlock-ruleset". This is minor but most anon inode fds already
carry square brackets around their name:

    [eventfd]
    [eventpoll]
    [fanotify]
    [fscontext]
    [io_uring]
    [pidfd]
    [signalfd]
    [timerfd]
    [userfaultfd]

For the sake of consistency lets do the same for the landlock-ruleset anon
inode fd that comes with landlock. We did the same in
1cdc415f1083 ("uapi, fsopen: use square brackets around "fscontext" [ver #2]")
for the new mount api.

Cc: linux-security-module@vger.kernel.org
Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
Link: https://lore.kernel.org/r/20211011133704.1704369-1-brauner@kernel.org
Cc: stable@vger.kernel.org
Signed-off-by: Mickaël Salaün <mic@linux.microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 security/landlock/syscalls.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/security/landlock/syscalls.c
+++ b/security/landlock/syscalls.c
@@ -192,7 +192,7 @@ SYSCALL_DEFINE3(landlock_create_ruleset,
 		return PTR_ERR(ruleset);
 
 	/* Creates anonymous FD referring to the ruleset. */
-	ruleset_fd = anon_inode_getfd("landlock-ruleset", &ruleset_fops,
+	ruleset_fd = anon_inode_getfd("[landlock-ruleset]", &ruleset_fops,
 			ruleset, O_RDWR | O_CLOEXEC);
 	if (ruleset_fd < 0)
 		landlock_put_ruleset(ruleset);


