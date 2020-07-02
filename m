Return-Path: <SRS0=SqoC=AN=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BF75C433DF
	for <linux-security-module@archiver.kernel.org>; Thu,  2 Jul 2020 16:47:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7179720720
	for <linux-security-module@archiver.kernel.org>; Thu,  2 Jul 2020 16:47:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727051AbgGBQr5 (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 2 Jul 2020 12:47:57 -0400
Received: from out01.mta.xmission.com ([166.70.13.231]:49492 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727008AbgGBQrz (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 2 Jul 2020 12:47:55 -0400
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out01.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.90_1)
        (envelope-from <ebiederm@xmission.com>)
        id 1jr2NO-0005mw-EU; Thu, 02 Jul 2020 10:47:54 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.int.ebiederm.org)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1jr2NN-0007up-CI; Thu, 02 Jul 2020 10:47:54 -0600
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
Date:   Thu,  2 Jul 2020 11:41:31 -0500
Message-Id: <20200702164140.4468-7-ebiederm@xmission.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <87y2o1swee.fsf_-_@x220.int.ebiederm.org>
References: <87y2o1swee.fsf_-_@x220.int.ebiederm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-XM-SPF: eid=1jr2NN-0007up-CI;;;mid=<20200702164140.4468-7-ebiederm@xmission.com>;;;hst=in01.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX19BYxbgM2/WpYLmhX4Zn7rTUKzvDV+Q0BI=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: [PATCH v3 07/16] umd: Rename umd_info.cmdline umd_info.driver_name
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

The only thing supplied in the cmdline today is the driver name so
rename the field to clarify the code.

As this value is always supplied stop trying to handle the case of
a NULL cmdline.

Additionally since we now have a name we can count on use the
driver_name any place where the code is looking for a name
of the binary.

v1: https://lkml.kernel.org/r/87imfef0k3.fsf_-_@x220.int.ebiederm.org
v2: https://lkml.kernel.org/r/87366d63os.fsf_-_@x220.int.ebiederm.org
Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 include/linux/usermode_driver.h |  2 +-
 kernel/usermode_driver.c        | 11 ++++-------
 net/ipv4/bpfilter/sockopt.c     |  2 +-
 3 files changed, 6 insertions(+), 9 deletions(-)

diff --git a/include/linux/usermode_driver.h b/include/linux/usermode_driver.h
index 7131ea611bab..48cf25e3145d 100644
--- a/include/linux/usermode_driver.h
+++ b/include/linux/usermode_driver.h
@@ -18,7 +18,7 @@ static inline void exit_umh(struct task_struct *tsk)
 #endif
 
 struct umd_info {
-	const char *cmdline;
+	const char *driver_name;
 	struct file *pipe_to_umh;
 	struct file *pipe_from_umh;
 	struct list_head list;
diff --git a/kernel/usermode_driver.c b/kernel/usermode_driver.c
index e73550e946d6..46d60d855e93 100644
--- a/kernel/usermode_driver.c
+++ b/kernel/usermode_driver.c
@@ -67,9 +67,6 @@ static void umd_cleanup(struct subprocess_info *info)
  * @len: length of the blob
  * @info: information about usermode process (shouldn't be NULL)
  *
- * If info->cmdline is set it will be used as command line for the
- * user process, else "usermodehelper" is used.
- *
  * Returns either negative error or zero which indicates success
  * in executing a blob of bytes as a usermode process. In such
  * case 'struct umd_info *info' is populated with two pipes
@@ -79,7 +76,6 @@ static void umd_cleanup(struct subprocess_info *info)
  */
 int fork_usermode_blob(void *data, size_t len, struct umd_info *info)
 {
-	const char *cmdline = (info->cmdline) ? info->cmdline : "usermodehelper";
 	struct subprocess_info *sub_info;
 	char **argv = NULL;
 	struct file *file;
@@ -87,7 +83,7 @@ int fork_usermode_blob(void *data, size_t len, struct umd_info *info)
 	loff_t pos = 0;
 	int err;
 
-	file = shmem_kernel_file_setup("", len, 0);
+	file = shmem_kernel_file_setup(info->driver_name, len, 0);
 	if (IS_ERR(file))
 		return PTR_ERR(file);
 
@@ -100,11 +96,12 @@ int fork_usermode_blob(void *data, size_t len, struct umd_info *info)
 	}
 
 	err = -ENOMEM;
-	argv = argv_split(GFP_KERNEL, cmdline, NULL);
+	argv = argv_split(GFP_KERNEL, info->driver_name, NULL);
 	if (!argv)
 		goto out;
 
-	sub_info = call_usermodehelper_setup("none", argv, NULL, GFP_KERNEL,
+	sub_info = call_usermodehelper_setup(info->driver_name, argv, NULL,
+					     GFP_KERNEL,
 					     umd_setup, umd_cleanup, info);
 	if (!sub_info)
 		goto out;
diff --git a/net/ipv4/bpfilter/sockopt.c b/net/ipv4/bpfilter/sockopt.c
index c0dbcc86fcdb..5050de28333d 100644
--- a/net/ipv4/bpfilter/sockopt.c
+++ b/net/ipv4/bpfilter/sockopt.c
@@ -70,7 +70,7 @@ static int __init bpfilter_sockopt_init(void)
 {
 	mutex_init(&bpfilter_ops.lock);
 	bpfilter_ops.stop = true;
-	bpfilter_ops.info.cmdline = "bpfilter_umh";
+	bpfilter_ops.info.driver_name = "bpfilter_umh";
 	bpfilter_ops.info.cleanup = &bpfilter_umh_cleanup;
 
 	return 0;
-- 
2.25.0

