Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32649C433E0
	for <linux-security-module@archiver.kernel.org>; Mon, 15 Feb 2021 12:28:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EA7A464DEC
	for <linux-security-module@archiver.kernel.org>; Mon, 15 Feb 2021 12:28:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229816AbhBOM2N (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 15 Feb 2021 07:28:13 -0500
Received: from smtp-bc09.mail.infomaniak.ch ([45.157.188.9]:56097 "EHLO
        smtp-bc09.mail.infomaniak.ch" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230384AbhBOM1h (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 15 Feb 2021 07:27:37 -0500
Received: from smtp-3-0001.mail.infomaniak.ch (unknown [10.4.36.108])
        by smtp-2-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4DfNd11gQnzMqC30;
        Mon, 15 Feb 2021 13:26:29 +0100 (CET)
Received: from localhost (unknown [23.97.221.149])
        by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4DfNd03z7nzlh8TQ;
        Mon, 15 Feb 2021 13:26:27 +0100 (CET)
From:   =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To:     James Morris <jmorris@namei.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        "Serge E . Hallyn" <serge@hallyn.com>
Cc:     =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Nicolas Iooss <nicolas.iooss@m4x.org>,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@linux.microsoft.com>
Subject: [PATCH v1 3/3] security: Add LSMs dependencies to CONFIG_LSM
Date:   Mon, 15 Feb 2021 13:25:13 +0100
Message-Id: <20210215122513.1773897-4-mic@digikod.net>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210215122513.1773897-1-mic@digikod.net>
References: <20210215122513.1773897-1-mic@digikod.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

From: Mickaël Salaün <mic@linux.microsoft.com>

Thanks to the previous commit, this gives the opportunity to users, when
running make oldconfig, to update the list of enabled LSMs at boot time
if an LSM has just been enabled or disabled in the build.  Moreover,
this list only makes sense if at least one LSM is enabled.

Cc: Casey Schaufler <casey@schaufler-ca.com>
Cc: James Morris <jmorris@namei.org>
Cc: Masahiro Yamada <masahiroy@kernel.org>
Cc: Serge E. Hallyn <serge@hallyn.com>
Signed-off-by: Mickaël Salaün <mic@linux.microsoft.com>
Link: https://lore.kernel.org/r/20210215122513.1773897-4-mic@digikod.net
---
 security/Kconfig | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/security/Kconfig b/security/Kconfig
index 7561f6f99f1d..2bc9ff351176 100644
--- a/security/Kconfig
+++ b/security/Kconfig
@@ -277,6 +277,10 @@ endchoice
 
 config LSM
 	string "Ordered list of enabled LSMs"
+	depends on SECURITY_LOCKDOWN_LSM || SECURITY_YAMA || SECURITY_LOADPIN || \
+		SECURITY_SAFESETID || INTEGRITY || SECURITY_SELINUX || \
+		SECURITY_SMACK || SECURITY_TOMOYO || SECURITY_APPARMOR || \
+		BPF_LSM
 	default "lockdown,yama,loadpin,safesetid,integrity,smack,selinux,tomoyo,apparmor,bpf" if DEFAULT_SECURITY_SMACK
 	default "lockdown,yama,loadpin,safesetid,integrity,apparmor,selinux,smack,tomoyo,bpf" if DEFAULT_SECURITY_APPARMOR
 	default "lockdown,yama,loadpin,safesetid,integrity,tomoyo,bpf" if DEFAULT_SECURITY_TOMOYO
-- 
2.30.0

