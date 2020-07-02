Return-Path: <SRS0=SqoC=AN=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE812C433DF
	for <linux-security-module@archiver.kernel.org>; Thu,  2 Jul 2020 16:48:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C95542084C
	for <linux-security-module@archiver.kernel.org>; Thu,  2 Jul 2020 16:48:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726912AbgGBQrp (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 2 Jul 2020 12:47:45 -0400
Received: from out01.mta.xmission.com ([166.70.13.231]:49366 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726300AbgGBQrn (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 2 Jul 2020 12:47:43 -0400
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out01.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.90_1)
        (envelope-from <ebiederm@xmission.com>)
        id 1jr2NC-0005l7-40; Thu, 02 Jul 2020 10:47:42 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.int.ebiederm.org)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1jr2NA-0007up-7M; Thu, 02 Jul 2020 10:47:41 -0600
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     linux-kernel@vger.kernel.org
Cc:     David Miller <davem@davemloft.net>,
        Greg Kroah-Hartman <greg@kroah.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>, bpf <bpf@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Gary Lin <GLin@suse.com>, Bruno Meneguele <bmeneg@redhat.com>,
        LSM List <linux-security-module@vger.kernel.org>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Date:   Thu,  2 Jul 2020 11:41:28 -0500
Message-Id: <20200702164140.4468-4-ebiederm@xmission.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <87y2o1swee.fsf_-_@x220.int.ebiederm.org>
References: <87y2o1swee.fsf_-_@x220.int.ebiederm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-XM-SPF: eid=1jr2NA-0007up-7M;;;mid=<20200702164140.4468-4-ebiederm@xmission.com>;;;hst=in01.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX190FRxZC1QZ22Yzv20TUWK9kLEah8pnQK0=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: [PATCH v3 04/16] umh: Remove call_usermodehelper_setup_file.
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

The only caller of call_usermodehelper_setup_file is fork_usermode_blob.
In fork_usermode_blob replace call_usermodehelper_setup_file with
call_usermodehelper_setup and delete fork_usermodehelper_setup_file.

For this to work the argv_free is moved from umh_clean_and_save_pid
to fork_usermode_blob.

v1: https://lkml.kernel.org/r/87zh8qf0mp.fsf_-_@x220.int.ebiederm.org
v2: https://lkml.kernel.org/r/87o8p163u1.fsf_-_@x220.int.ebiederm.org
Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 include/linux/umh.h |  3 ---
 kernel/umh.c        | 42 +++++++++++-------------------------------
 2 files changed, 11 insertions(+), 34 deletions(-)

diff --git a/include/linux/umh.h b/include/linux/umh.h
index aae16a0ebd0f..de08af00c68a 100644
--- a/include/linux/umh.h
+++ b/include/linux/umh.h
@@ -39,9 +39,6 @@ call_usermodehelper_setup(const char *path, char **argv, char **envp,
 			  int (*init)(struct subprocess_info *info, struct cred *new),
 			  void (*cleanup)(struct subprocess_info *), void *data);
 
-struct subprocess_info *call_usermodehelper_setup_file(struct file *file,
-			  int (*init)(struct subprocess_info *info, struct cred *new),
-			  void (*cleanup)(struct subprocess_info *), void *data);
 struct umh_info {
 	const char *cmdline;
 	struct file *pipe_to_umh;
diff --git a/kernel/umh.c b/kernel/umh.c
index 26c3d493f168..b8fa9b99b366 100644
--- a/kernel/umh.c
+++ b/kernel/umh.c
@@ -402,33 +402,6 @@ struct subprocess_info *call_usermodehelper_setup(const char *path, char **argv,
 }
 EXPORT_SYMBOL(call_usermodehelper_setup);
 
-struct subprocess_info *call_usermodehelper_setup_file(struct file *file,
-		int (*init)(struct subprocess_info *info, struct cred *new),
-		void (*cleanup)(struct subprocess_info *info), void *data)
-{
-	struct subprocess_info *sub_info;
-	struct umh_info *info = data;
-	const char *cmdline = (info->cmdline) ? info->cmdline : "usermodehelper";
-
-	sub_info = kzalloc(sizeof(struct subprocess_info), GFP_KERNEL);
-	if (!sub_info)
-		return NULL;
-
-	sub_info->argv = argv_split(GFP_KERNEL, cmdline, NULL);
-	if (!sub_info->argv) {
-		kfree(sub_info);
-		return NULL;
-	}
-
-	INIT_WORK(&sub_info->work, call_usermodehelper_exec_work);
-	sub_info->path = "none";
-	sub_info->file = file;
-	sub_info->init = init;
-	sub_info->cleanup = cleanup;
-	sub_info->data = data;
-	return sub_info;
-}
-
 static int umd_setup(struct subprocess_info *info, struct cred *new)
 {
 	struct umh_info *umh_info = info->data;
@@ -479,8 +452,6 @@ static void umd_cleanup(struct subprocess_info *info)
 		fput(umh_info->pipe_to_umh);
 		fput(umh_info->pipe_from_umh);
 	}
-
-	argv_free(info->argv);
 }
 
 /**
@@ -501,7 +472,9 @@ static void umd_cleanup(struct subprocess_info *info)
  */
 int fork_usermode_blob(void *data, size_t len, struct umh_info *info)
 {
+	const char *cmdline = (info->cmdline) ? info->cmdline : "usermodehelper";
 	struct subprocess_info *sub_info;
+	char **argv = NULL;
 	struct file *file;
 	ssize_t written;
 	loff_t pos = 0;
@@ -520,11 +493,16 @@ int fork_usermode_blob(void *data, size_t len, struct umh_info *info)
 	}
 
 	err = -ENOMEM;
-	sub_info = call_usermodehelper_setup_file(file, umd_setup, umd_cleanup,
-						  info);
+	argv = argv_split(GFP_KERNEL, cmdline, NULL);
+	if (!argv)
+		goto out;
+
+	sub_info = call_usermodehelper_setup("none", argv, NULL, GFP_KERNEL,
+					     umd_setup, umd_cleanup, info);
 	if (!sub_info)
 		goto out;
 
+	sub_info->file = file;
 	err = call_usermodehelper_exec(sub_info, UMH_WAIT_EXEC);
 	if (!err) {
 		mutex_lock(&umh_list_lock);
@@ -532,6 +510,8 @@ int fork_usermode_blob(void *data, size_t len, struct umh_info *info)
 		mutex_unlock(&umh_list_lock);
 	}
 out:
+	if (argv)
+		argv_free(argv);
 	fput(file);
 	return err;
 }
-- 
2.25.0

