Return-Path: <SRS0=SqoC=AN=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B852AC433DF
	for <linux-security-module@archiver.kernel.org>; Thu,  2 Jul 2020 16:49:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A1EAC212CC
	for <linux-security-module@archiver.kernel.org>; Thu,  2 Jul 2020 16:49:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727771AbgGBQsi (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 2 Jul 2020 12:48:38 -0400
Received: from out02.mta.xmission.com ([166.70.13.232]:35290 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726721AbgGBQsh (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 2 Jul 2020 12:48:37 -0400
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out02.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.90_1)
        (envelope-from <ebiederm@xmission.com>)
        id 1jr2O4-0007e6-OQ; Thu, 02 Jul 2020 10:48:36 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.int.ebiederm.org)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1jr2Nx-0007up-Jp; Thu, 02 Jul 2020 10:48:30 -0600
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
        "Eric W. Biederman" <ebiederm@xmission.com>
Date:   Thu,  2 Jul 2020 11:41:40 -0500
Message-Id: <20200702164140.4468-16-ebiederm@xmission.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <87y2o1swee.fsf_-_@x220.int.ebiederm.org>
References: <87y2o1swee.fsf_-_@x220.int.ebiederm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-XM-SPF: eid=1jr2Nx-0007up-Jp;;;mid=<20200702164140.4468-16-ebiederm@xmission.com>;;;hst=in01.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX18OB1SGxTOeo4/dzJbPeWbHPytle+s5LkM=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: [PATCH v3 16/16] umd: Stop using split_argv
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

There is exactly one argument so there is nothing to split.  All
split_argv does now is cause confusion and avoid the need for a cast
when passing a "const char *" string to call_usermodehelper_setup.

So avoid confusion and the possibility of an odd driver name causing
problems by just using a fixed argv array with a cast in the call to
call_usermodehelper_setup.

v1: https://lkml.kernel.org/r/87sged3a9n.fsf_-_@x220.int.ebiederm.org
Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 kernel/usermode_driver.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/kernel/usermode_driver.c b/kernel/usermode_driver.c
index cd136f86f799..0b35212ffc3d 100644
--- a/kernel/usermode_driver.c
+++ b/kernel/usermode_driver.c
@@ -160,27 +160,21 @@ static void umd_cleanup(struct subprocess_info *info)
 int fork_usermode_driver(struct umd_info *info)
 {
 	struct subprocess_info *sub_info;
-	char **argv = NULL;
+	const char *argv[] = { info->driver_name, NULL };
 	int err;
 
 	if (WARN_ON_ONCE(info->tgid))
 		return -EBUSY;
 
 	err = -ENOMEM;
-	argv = argv_split(GFP_KERNEL, info->driver_name, NULL);
-	if (!argv)
-		goto out;
-
-	sub_info = call_usermodehelper_setup(info->driver_name, argv, NULL,
-					     GFP_KERNEL,
+	sub_info = call_usermodehelper_setup(info->driver_name,
+					     (char **)argv, NULL, GFP_KERNEL,
 					     umd_setup, umd_cleanup, info);
 	if (!sub_info)
 		goto out;
 
 	err = call_usermodehelper_exec(sub_info, UMH_WAIT_EXEC);
 out:
-	if (argv)
-		argv_free(argv);
 	return err;
 }
 EXPORT_SYMBOL_GPL(fork_usermode_driver);
-- 
2.25.0

