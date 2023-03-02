Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A4E5C6FA8E
	for <linux-security-module@archiver.kernel.org>; Thu,  2 Mar 2023 18:53:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229505AbjCBSxq (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 2 Mar 2023 13:53:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229579AbjCBSxc (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 2 Mar 2023 13:53:32 -0500
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24F2A13D75
        for <linux-security-module@vger.kernel.org>; Thu,  2 Mar 2023 10:53:31 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id y11so299476plg.1
        for <linux-security-module@vger.kernel.org>; Thu, 02 Mar 2023 10:53:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1677783210;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9jdvYZf78lZC9tZJePPFDF8pKZnry00n1BO70ycmPTU=;
        b=KrSU26IkmAXsBGLQT8lqs2uIOhnOlwlt8upL4rpUMCafv9uGmg7YU5jMz/abDLwPEx
         S8PjGRZ6d1OGXYI59wv/TGJtAM8LUsMLngBPidwNmUvENOxinnhiwbNUtvtsiUKe+YIN
         LSp0X5BnnMPAGJc+3ctXTueEs3nJw25I8TIiU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677783210;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9jdvYZf78lZC9tZJePPFDF8pKZnry00n1BO70ycmPTU=;
        b=kj6KhHy4uUTpyvrpwLr+15lSWx0OV+XJh/78v+fOCBPyqaCNLylTZjgn2MfeJezeMP
         quUR5srgWTK+S4y6OlUUKaexka5znjSD9NUcnS9G1sVYnyW1Vb3OihguKJ4yaT69bQax
         enKHtVLKb7hH3IZ66yRtcNf0+XHK3WvlSdapzdMprj393kA85lhaOFhWWJHiOuoTEaOs
         /FCgiRIDn7kJTlrJ6itDi0kFYCBLXthIm3c7obVIFgsmAt5HHWOLNqbIZbxQLEWYor/k
         QEEXnpn9sJfm6KJPh7UJiKPVcalvK/0U/Baby3lMePzqqHqO5rfeFUQTH3Nayw4PeEO0
         7D9g==
X-Gm-Message-State: AO0yUKXy7KqCdPF/VJg3R9+Zpolq3VtPg0bf1ZaHbXuTuhW84Qa6ysnH
        4w6Zu+ElsKpZUTlRDIbQj45nyg==
X-Google-Smtp-Source: AK7set8w1A5QyRATh+UEn4AwFU5lbnO/QJftdUDotgpDtA5CzThV6xi3EGL3IObzMEH3d6jEYfF27g==
X-Received: by 2002:a05:6a20:244d:b0:ce:c109:2d58 with SMTP id t13-20020a056a20244d00b000cec1092d58mr1384943pzc.10.1677783210662;
        Thu, 02 Mar 2023 10:53:30 -0800 (PST)
Received: from enlightened2.mtv.corp.google.com ([2620:15c:9d:6:9b33:9b92:f51d:bd4])
        by smtp.gmail.com with ESMTPSA id b4-20020aa78704000000b005a8c60ce93bsm26782pfo.149.2023.03.02.10.53.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Mar 2023 10:53:30 -0800 (PST)
From:   enlightened@chromium.org
To:     mic@digikod.net
Cc:     linux-security-module@vger.kernel.org, jorgelo@chromium.org,
        keescook@chromium.org, groeck@chromium.org, jeffxu@chromium.org,
        allenwebb@chromium.org, Shervin Oloumi <enlightened@chromium.org>
Subject: [PATCH 1/1] lsm: adds process attribute getter for Landlock
Date:   Thu,  2 Mar 2023 10:52:57 -0800
Message-Id: <20230302185257.850681-2-enlightened@chromium.org>
X-Mailer: git-send-email 2.40.0.rc0.216.gc4246ad0f0-goog
In-Reply-To: <20230302185257.850681-1-enlightened@chromium.org>
References: <20230302185257.850681-1-enlightened@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

From: Shervin Oloumi <enlightened@chromium.org>

Adds a new getprocattr hook function to the Landlock LSM, which tracks
the landlocked state of the process. This is invoked when user-space
reads /proc/[pid]/attr/current to determine whether a given process is
sand-boxed using Landlock.

Adds a new directory for landlock under the process attribute
filesystem, and defines "current" as a read-only process attribute entry
for landlock.

Signed-off-by: Shervin Oloumi <enlightened@chromium.org>
---
 fs/proc/base.c         | 11 +++++++++++
 security/landlock/fs.c | 33 +++++++++++++++++++++++++++++++++
 2 files changed, 44 insertions(+)

diff --git a/fs/proc/base.c b/fs/proc/base.c
index 9e479d7d202b..3ab29a965911 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -2851,6 +2851,13 @@ static const struct pid_entry apparmor_attr_dir_stuff[] = {
 LSM_DIR_OPS(apparmor);
 #endif
 
+#ifdef CONFIG_SECURITY_LANDLOCK
+static const struct pid_entry landlock_attr_dir_stuff[] = {
+       ATTR("landlock", "current", 0444),
+};
+LSM_DIR_OPS(landlock);
+#endif
+
 static const struct pid_entry attr_dir_stuff[] = {
 	ATTR(NULL, "current",		0666),
 	ATTR(NULL, "prev",		0444),
@@ -2866,6 +2873,10 @@ static const struct pid_entry attr_dir_stuff[] = {
 	DIR("apparmor",			0555,
 	    proc_apparmor_attr_dir_inode_ops, proc_apparmor_attr_dir_ops),
 #endif
+#ifdef CONFIG_SECURITY_LANDLOCK
+       DIR("landlock",                  0555,
+	    proc_landlock_attr_dir_inode_ops, proc_landlock_attr_dir_ops),
+#endif
 };
 
 static int proc_attr_dir_readdir(struct file *file, struct dir_context *ctx)
diff --git a/security/landlock/fs.c b/security/landlock/fs.c
index adcea0fe7e68..179ba22ce0fc 100644
--- a/security/landlock/fs.c
+++ b/security/landlock/fs.c
@@ -1280,6 +1280,37 @@ static int hook_file_truncate(struct file *const file)
 	return -EACCES;
 }
 
+/* process attribute interfaces */
+
+/**
+ * landlock_getprocattr - Landlock process attribute getter
+ * @p: the object task
+ * @name: the name of the attribute in /proc/.../attr
+ * @value: where to put the result
+ *
+ * Writes the status of landlock to value
+ *
+ * Returns the length of the result inside value
+ */
+static int landlock_getprocattr(struct task_struct *task, const char *name,
+				char **value)
+{
+	char *val;
+	int slen;
+
+	if (strcmp(name, "current") != 0)
+		return -EINVAL;
+
+	if (landlocked(task))
+		val = "landlocked:1";
+	else
+		val = "landlocked:0";
+
+	slen = strlen(val);
+	*value = val;
+	return slen;
+}
+
 static struct security_hook_list landlock_hooks[] __lsm_ro_after_init = {
 	LSM_HOOK_INIT(inode_free_security, hook_inode_free_security),
 
@@ -1302,6 +1333,8 @@ static struct security_hook_list landlock_hooks[] __lsm_ro_after_init = {
 	LSM_HOOK_INIT(file_alloc_security, hook_file_alloc_security),
 	LSM_HOOK_INIT(file_open, hook_file_open),
 	LSM_HOOK_INIT(file_truncate, hook_file_truncate),
+
+	LSM_HOOK_INIT(getprocattr, landlock_getprocattr),
 };
 
 __init void landlock_add_fs_hooks(void)
-- 
2.39.2.722.g9855ee24e9-goog

