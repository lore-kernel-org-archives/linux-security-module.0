Return-Path: <SRS0=SqoC=AN=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97C3AC433E2
	for <linux-security-module@archiver.kernel.org>; Thu,  2 Jul 2020 16:47:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 83A5220720
	for <linux-security-module@archiver.kernel.org>; Thu,  2 Jul 2020 16:47:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726852AbgGBQrk (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 2 Jul 2020 12:47:40 -0400
Received: from out03.mta.xmission.com ([166.70.13.233]:40524 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726300AbgGBQri (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 2 Jul 2020 12:47:38 -0400
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out03.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.90_1)
        (envelope-from <ebiederm@xmission.com>)
        id 1jr2N7-00020u-HP; Thu, 02 Jul 2020 10:47:37 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.int.ebiederm.org)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1jr2N6-0007up-De; Thu, 02 Jul 2020 10:47:37 -0600
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
Date:   Thu,  2 Jul 2020 11:41:27 -0500
Message-Id: <20200702164140.4468-3-ebiederm@xmission.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <87y2o1swee.fsf_-_@x220.int.ebiederm.org>
References: <87y2o1swee.fsf_-_@x220.int.ebiederm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-XM-SPF: eid=1jr2N6-0007up-De;;;mid=<20200702164140.4468-3-ebiederm@xmission.com>;;;hst=in01.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1/s0b3BYl1kTk80Mm/H1N4bnuhOkqxEowc=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: [PATCH v3 03/16] umh: Rename the user mode driver helpers for clarity
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Now that the functionality of umh_setup_pipe and
umh_clean_and_save_pid has changed their names are too specific and
don't make much sense.  Instead name them  umd_setup and umd_cleanup
for the functional role in setting up user mode drivers.

v1: https://lkml.kernel.org/r/875zbegf82.fsf_-_@x220.int.ebiederm.org
v2: https://lkml.kernel.org/r/87tuyt63x3.fsf_-_@x220.int.ebiederm.org
Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 kernel/umh.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/kernel/umh.c b/kernel/umh.c
index e6b9d6636850..26c3d493f168 100644
--- a/kernel/umh.c
+++ b/kernel/umh.c
@@ -429,7 +429,7 @@ struct subprocess_info *call_usermodehelper_setup_file(struct file *file,
 	return sub_info;
 }
 
-static int umh_pipe_setup(struct subprocess_info *info, struct cred *new)
+static int umd_setup(struct subprocess_info *info, struct cred *new)
 {
 	struct umh_info *umh_info = info->data;
 	struct file *from_umh[2];
@@ -470,11 +470,11 @@ static int umh_pipe_setup(struct subprocess_info *info, struct cred *new)
 	return 0;
 }
 
-static void umh_clean_and_save_pid(struct subprocess_info *info)
+static void umd_cleanup(struct subprocess_info *info)
 {
 	struct umh_info *umh_info = info->data;
 
-	/* cleanup if umh_pipe_setup() was successful but exec failed */
+	/* cleanup if umh_setup() was successful but exec failed */
 	if (info->retval) {
 		fput(umh_info->pipe_to_umh);
 		fput(umh_info->pipe_from_umh);
@@ -520,8 +520,8 @@ int fork_usermode_blob(void *data, size_t len, struct umh_info *info)
 	}
 
 	err = -ENOMEM;
-	sub_info = call_usermodehelper_setup_file(file, umh_pipe_setup,
-						  umh_clean_and_save_pid, info);
+	sub_info = call_usermodehelper_setup_file(file, umd_setup, umd_cleanup,
+						  info);
 	if (!sub_info)
 		goto out;
 
-- 
2.25.0

