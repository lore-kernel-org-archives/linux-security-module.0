Return-Path: <SRS0=SqoC=AN=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E20BC433DF
	for <linux-security-module@archiver.kernel.org>; Thu,  2 Jul 2020 16:48:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6AA7D2084C
	for <linux-security-module@archiver.kernel.org>; Thu,  2 Jul 2020 16:48:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727083AbgGBQsJ (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 2 Jul 2020 12:48:09 -0400
Received: from out02.mta.xmission.com ([166.70.13.232]:35030 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727079AbgGBQsD (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 2 Jul 2020 12:48:03 -0400
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out02.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.90_1)
        (envelope-from <ebiederm@xmission.com>)
        id 1jr2NW-0007aH-G7; Thu, 02 Jul 2020 10:48:02 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.int.ebiederm.org)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1jr2NV-0007up-Hq; Thu, 02 Jul 2020 10:48:02 -0600
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
Date:   Thu,  2 Jul 2020 11:41:33 -0500
Message-Id: <20200702164140.4468-9-ebiederm@xmission.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <87y2o1swee.fsf_-_@x220.int.ebiederm.org>
References: <87y2o1swee.fsf_-_@x220.int.ebiederm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-XM-SPF: eid=1jr2NV-0007up-Hq;;;mid=<20200702164140.4468-9-ebiederm@xmission.com>;;;hst=in01.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+qCe/uJWiysTAvzGD8HMu4YhLe3N90a7c=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: [PATCH v3 09/16] umh: Stop calling do_execve_file
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

With the user mode driver code changed to not set subprocess_info.file
there are no more users of subproces_info.file.  Remove this field
from struct subprocess_info and remove the only user in
call_usermodehelper_exec_async that would call do_execve_file instead
of do_execve if file was set.

v1: https://lkml.kernel.org/r/877dvuf0i7.fsf_-_@x220.int.ebiederm.org
v2: https://lkml.kernel.org/r/87r1tx4p2a.fsf_-_@x220.int.ebiederm.org
Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 include/linux/umh.h |  1 -
 kernel/umh.c        | 10 +++-------
 2 files changed, 3 insertions(+), 8 deletions(-)

diff --git a/include/linux/umh.h b/include/linux/umh.h
index 73173c4a07e5..244aff638220 100644
--- a/include/linux/umh.h
+++ b/include/linux/umh.h
@@ -22,7 +22,6 @@ struct subprocess_info {
 	const char *path;
 	char **argv;
 	char **envp;
-	struct file *file;
 	int wait;
 	int retval;
 	int (*init)(struct subprocess_info *info, struct cred *new);
diff --git a/kernel/umh.c b/kernel/umh.c
index 3e4e453d45c8..6ca2096298b9 100644
--- a/kernel/umh.c
+++ b/kernel/umh.c
@@ -98,13 +98,9 @@ static int call_usermodehelper_exec_async(void *data)
 
 	commit_creds(new);
 
-	if (sub_info->file)
-		retval = do_execve_file(sub_info->file,
-					sub_info->argv, sub_info->envp);
-	else
-		retval = do_execve(getname_kernel(sub_info->path),
-				   (const char __user *const __user *)sub_info->argv,
-				   (const char __user *const __user *)sub_info->envp);
+	retval = do_execve(getname_kernel(sub_info->path),
+			   (const char __user *const __user *)sub_info->argv,
+			   (const char __user *const __user *)sub_info->envp);
 out:
 	sub_info->retval = retval;
 	/*
-- 
2.25.0

