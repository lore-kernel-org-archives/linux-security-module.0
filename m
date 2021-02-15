Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F452C433DB
	for <linux-security-module@archiver.kernel.org>; Mon, 15 Feb 2021 18:16:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 37AF164DFF
	for <linux-security-module@archiver.kernel.org>; Mon, 15 Feb 2021 18:16:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230425AbhBOSP5 (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 15 Feb 2021 13:15:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229991AbhBOSP4 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 15 Feb 2021 13:15:56 -0500
Received: from smtp-42ae.mail.infomaniak.ch (smtp-42ae.mail.infomaniak.ch [IPv6:2001:1600:4:17::42ae])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82A18C06178A
        for <linux-security-module@vger.kernel.org>; Mon, 15 Feb 2021 10:14:29 -0800 (PST)
Received: from smtp-3-0001.mail.infomaniak.ch (unknown [10.4.36.108])
        by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4DfXLX2PsSzMpnlP;
        Mon, 15 Feb 2021 19:14:28 +0100 (CET)
Received: from localhost (unknown [23.97.221.149])
        by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4DfXLX0Fd6zlh8TC;
        Mon, 15 Feb 2021 19:14:28 +0100 (CET)
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
Subject: [PATCH v2 3/3] security: Add LSMs dependencies to CONFIG_LSM
Date:   Mon, 15 Feb 2021 19:15:11 +0100
Message-Id: <20210215181511.2840674-4-mic@digikod.net>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210215181511.2840674-1-mic@digikod.net>
References: <20210215181511.2840674-1-mic@digikod.net>
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
Link: https://lore.kernel.org/r/20210215181511.2840674-4-mic@digikod.net
---

Changes since v1:
* Add CONFIG_SECURITY as a dependency of CONFIG_LSM.  This prevent an
  error when building without any LSMs.
---
 security/Kconfig | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/security/Kconfig b/security/Kconfig
index 7561f6f99f1d..addcc1c04701 100644
--- a/security/Kconfig
+++ b/security/Kconfig
@@ -277,6 +277,10 @@ endchoice
 
 config LSM
 	string "Ordered list of enabled LSMs"
+	depends on SECURITY || SECURITY_LOCKDOWN_LSM || SECURITY_YAMA || \
+		SECURITY_LOADPIN || SECURITY_SAFESETID || INTEGRITY || \
+		SECURITY_SELINUX || SECURITY_SMACK || SECURITY_TOMOYO || \
+		SECURITY_APPARMOR || BPF_LSM
 	default "lockdown,yama,loadpin,safesetid,integrity,smack,selinux,tomoyo,apparmor,bpf" if DEFAULT_SECURITY_SMACK
 	default "lockdown,yama,loadpin,safesetid,integrity,apparmor,selinux,smack,tomoyo,bpf" if DEFAULT_SECURITY_APPARMOR
 	default "lockdown,yama,loadpin,safesetid,integrity,tomoyo,bpf" if DEFAULT_SECURITY_TOMOYO
-- 
2.30.0

