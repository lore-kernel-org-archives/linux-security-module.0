Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9852C433EF
	for <linux-security-module@archiver.kernel.org>; Tue, 22 Feb 2022 21:45:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235835AbiBVVqD (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 22 Feb 2022 16:46:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235858AbiBVVqD (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 22 Feb 2022 16:46:03 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE952139136
        for <linux-security-module@vger.kernel.org>; Tue, 22 Feb 2022 13:45:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=GF9f4DjgwOy9P1QnRIKuLCYNmEVSx5c0MWJ4s4ZyhSk=; b=dh8/O+piCrAuj+S3QA2v9iDdlX
        J0c8GOLm2W8Lh+vquyTl9PmqlGoM2Ngqx1SYnAIe680HV3/nc7mRB57sm1opF0Ri4RBRSvdeOeIUQ
        Y1r6gjRTeTGLWUd6vXKLMraEcc2XUKFN2Ru3NX6Y4Nh7OinsYwhRBNw+tZk1Nx/Py8Ey7KfvOuMPW
        0ZotSrWYs2NCdmTPoVPWlvj4TsQkvkZXXnM3oOOW/uv2QcNTeJHT4fUwJOciR9GLjmB8qLJWMQ2FI
        sz411wiahbLOl5FgT85jB9t8TgZzwF7Nacp/PFNqKbP55xp6JnW0y9+iedHVpIc3OvhGvma4LE7dG
        HUF+KQjw==;
Received: from [2601:1c0:6280:3f0::aa0b] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nMcyT-00BhRT-QR; Tue, 22 Feb 2022 21:45:33 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-security-module@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Igor Zhbanov <i.zhbanov@omprussia.ru>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        James Morris <jmorris@namei.org>,
        Kentaro Takeda <takedakn@nttdata.co.jp>,
        tomoyo-dev-en@lists.osdn.me, "Serge E. Hallyn" <serge@hallyn.com>
Subject: [PATCH] TOMOYO: fix __setup handlers return values
Date:   Tue, 22 Feb 2022 13:45:33 -0800
Message-Id: <20220222214533.10135-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

__setup() handlers should return 1 if the parameter is handled.
Returning 0 causes the entire string to be added to init's
environment strings (limited to 32 strings), unnecessarily polluting it.

Using the documented strings "TOMOYO_loader=string1" and
"TOMOYO_trigger=string2" causes an Unknown parameter message:
  Unknown kernel command line parameters
    "BOOT_IMAGE=/boot/bzImage-517rc5 TOMOYO_loader=string1 \
     TOMOYO_trigger=string2", will be passed to user space.

and these strings are added to init's environment string space:
  Run /sbin/init as init process
    with arguments:
     /sbin/init
    with environment:
     HOME=/
     TERM=linux
     BOOT_IMAGE=/boot/bzImage-517rc5
     TOMOYO_loader=string1
     TOMOYO_trigger=string2

With this change, these __setup handlers act as expected,
and init's environment is not polluted with these strings.

Fixes: 0e4ae0e0dec63 ("TOMOYO: Make several options configurable.")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Reported-by: Igor Zhbanov <i.zhbanov@omprussia.ru>
Link: lore.kernel.org/r/64644a2f-4a20-bab3-1e15-3b2cdd0defe3@omprussia.ru
Cc: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Cc: James Morris <jmorris@namei.org>
Cc: Kentaro Takeda <takedakn@nttdata.co.jp>
Cc: tomoyo-dev-en@lists.osdn.me
Cc: "Serge E. Hallyn" <serge@hallyn.com>
---
 security/tomoyo/load_policy.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- lnx-517-rc5.orig/security/tomoyo/load_policy.c
+++ lnx-517-rc5/security/tomoyo/load_policy.c
@@ -24,7 +24,7 @@ static const char *tomoyo_loader;
 static int __init tomoyo_loader_setup(char *str)
 {
 	tomoyo_loader = str;
-	return 0;
+	return 1;
 }
 
 __setup("TOMOYO_loader=", tomoyo_loader_setup);
@@ -64,7 +64,7 @@ static const char *tomoyo_trigger;
 static int __init tomoyo_trigger_setup(char *str)
 {
 	tomoyo_trigger = str;
-	return 0;
+	return 1;
 }
 
 __setup("TOMOYO_trigger=", tomoyo_trigger_setup);
