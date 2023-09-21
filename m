Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B88DE7D0AF
	for <linux-security-module@archiver.kernel.org>; Thu, 21 Sep 2023 21:13:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229743AbjIUVNJ (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 21 Sep 2023 17:13:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229682AbjIUVMw (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 21 Sep 2023 17:12:52 -0400
Received: from smtp-bc08.mail.infomaniak.ch (smtp-bc08.mail.infomaniak.ch [IPv6:2001:1600:4:17::bc08])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F316FFAA
        for <linux-security-module@vger.kernel.org>; Thu, 21 Sep 2023 10:07:29 -0700 (PDT)
Received: from smtp-2-0000.mail.infomaniak.ch (unknown [10.5.36.107])
        by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4RrlY82PP8zMqBR2;
        Thu, 21 Sep 2023 06:17:00 +0000 (UTC)
Received: from unknown by smtp-2-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4RrlY768ddzMpnPp;
        Thu, 21 Sep 2023 08:16:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
        s=20191114; t=1695277020;
        bh=BDXkAyV7VKfAr64LJDe20wdFO/sHv02Ha0JAcCm1Kgc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZplcROJUNZdIJvCz4sSUz6FTBiWpRTWGj5Dcbx+AlXmx1S6SfeuH/IO1a1UKUXuyR
         +Mi6L3c5RMDFY+YvpvI3UOZvfobOhrV447a7CxqcEJ4GYcKrQZ2qBSSmKhMeK3Csqr
         bnC6CekX5RKbp3Jv0Mt4+c8z0svoYwb6EWtu5YRQ=
From:   =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To:     Eric Paris <eparis@redhat.com>, James Morris <jmorris@namei.org>,
        Paul Moore <paul@paul-moore.com>,
        "Serge E . Hallyn" <serge@hallyn.com>
Cc:     =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
        Ben Scarlato <akhna@google.com>,
        =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
        Jeff Xu <jeffxu@google.com>,
        Jorge Lucangeli Obes <jorgelo@google.com>,
        Konstantin Meskhidze <konstantin.meskhidze@huawei.com>,
        Shervin Oloumi <enlightened@google.com>, audit@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
Subject: [RFC PATCH v1 2/7] landlock: Factor out check_access_path()
Date:   Thu, 21 Sep 2023 08:16:36 +0200
Message-ID: <20230921061641.273654-3-mic@digikod.net>
In-Reply-To: <20230921061641.273654-1-mic@digikod.net>
References: <20230921061641.273654-1-mic@digikod.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Merge check_access_path() into current_check_access_path() and make
hook_path_mknod() use it. Remove explicit inlining that can be handled
by the compiler.

Signed-off-by: Mickaël Salaün <mic@digikod.net>
---
 security/landlock/fs.c | 33 +++++++++++----------------------
 1 file changed, 11 insertions(+), 22 deletions(-)

diff --git a/security/landlock/fs.c b/security/landlock/fs.c
index 1c0c198f6fdb..978e325d8708 100644
--- a/security/landlock/fs.c
+++ b/security/landlock/fs.c
@@ -635,28 +635,22 @@ static bool is_access_to_paths_allowed(
 	return allowed_parent1 && allowed_parent2;
 }
 
-static inline int check_access_path(const struct landlock_ruleset *const domain,
-				    const struct path *const path,
-				    access_mask_t access_request)
-{
-	layer_mask_t layer_masks[LANDLOCK_NUM_ACCESS_FS] = {};
-
-	access_request = init_layer_masks(domain, access_request, &layer_masks);
-	if (is_access_to_paths_allowed(domain, path, access_request,
-				       &layer_masks, NULL, 0, NULL, NULL))
-		return 0;
-	return -EACCES;
-}
-
-static inline int current_check_access_path(const struct path *const path,
-					    const access_mask_t access_request)
+static int current_check_access_path(const struct path *const path,
+				     access_mask_t access_request)
 {
 	const struct landlock_ruleset *const dom =
 		landlock_get_current_domain();
+	layer_mask_t layer_masks[LANDLOCK_NUM_ACCESS_FS] = {};
 
 	if (!dom)
 		return 0;
-	return check_access_path(dom, path, access_request);
+
+	access_request = init_layer_masks(dom, access_request, &layer_masks);
+	if (is_access_to_paths_allowed(dom, path, access_request, &layer_masks,
+				       NULL, 0, NULL, NULL))
+		return 0;
+
+	return -EACCES;
 }
 
 static inline access_mask_t get_mode_access(const umode_t mode)
@@ -1128,12 +1122,7 @@ static int hook_path_mknod(const struct path *const dir,
 			   struct dentry *const dentry, const umode_t mode,
 			   const unsigned int dev)
 {
-	const struct landlock_ruleset *const dom =
-		landlock_get_current_domain();
-
-	if (!dom)
-		return 0;
-	return check_access_path(dom, dir, get_mode_access(mode));
+	return current_check_access_path(dir, get_mode_access(mode));
 }
 
 static int hook_path_symlink(const struct path *const dir,
-- 
2.42.0

