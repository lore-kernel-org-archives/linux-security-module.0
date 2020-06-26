Return-Path: <SRS0=ekpI=AH=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3361BC433DF
	for <linux-security-module@archiver.kernel.org>; Fri, 26 Jun 2020 12:57:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 11F552076E
	for <linux-security-module@archiver.kernel.org>; Fri, 26 Jun 2020 12:57:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726653AbgFZM5o (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 26 Jun 2020 08:57:44 -0400
Received: from out02.mta.xmission.com ([166.70.13.232]:53108 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725283AbgFZM5n (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 26 Jun 2020 08:57:43 -0400
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out02.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.90_1)
        (envelope-from <ebiederm@xmission.com>)
        id 1jonvK-0005QT-Q7; Fri, 26 Jun 2020 06:57:42 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in02.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1jonvI-0000uA-N6; Fri, 26 Jun 2020 06:57:42 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Linus Torvalds <torvalds@linux-foundation.org>
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
        Casey Schaufler <casey@schaufler-ca.com>
References: <20200625095725.GA3303921@kroah.com>
        <778297d2-512a-8361-cf05-42d9379e6977@i-love.sakura.ne.jp>
        <20200625120725.GA3493334@kroah.com>
        <20200625.123437.2219826613137938086.davem@davemloft.net>
        <CAHk-=whuTwGHEPjvtbBvneHHXeqJC=q5S09mbPnqb=Q+MSPMag@mail.gmail.com>
        <87pn9mgfc2.fsf_-_@x220.int.ebiederm.org>
Date:   Fri, 26 Jun 2020 07:53:13 -0500
In-Reply-To: <87pn9mgfc2.fsf_-_@x220.int.ebiederm.org> (Eric W. Biederman's
        message of "Fri, 26 Jun 2020 07:51:41 -0500")
Message-ID: <87h7uygf9i.fsf_-_@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1jonvI-0000uA-N6;;;mid=<87h7uygf9i.fsf_-_@x220.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX19SUUWxyqnwUtgTAxvRWgD8/3YyIFZ7M1g=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: [PATCH 01/14] umh: Capture the pid in umh_pipe_setup
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>


The pid in struct subprocess_info is only used by umh_clean_and_save_pid to
write the pid into umh_info.

Instead always capture the pid on struct umh_info in umh_pipe_setup, removing
code that is specific to user mode drivers from the common user path of
user mode helpers.

Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 include/linux/umh.h | 1 -
 kernel/umh.c        | 5 ++---
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/include/linux/umh.h b/include/linux/umh.h
index 0c08de356d0d..aae16a0ebd0f 100644
--- a/include/linux/umh.h
+++ b/include/linux/umh.h
@@ -25,7 +25,6 @@ struct subprocess_info {
 	struct file *file;
 	int wait;
 	int retval;
-	pid_t pid;
 	int (*init)(struct subprocess_info *info, struct cred *new);
 	void (*cleanup)(struct subprocess_info *info);
 	void *data;
diff --git a/kernel/umh.c b/kernel/umh.c
index 79f139a7ca03..c2a582b3a2bf 100644
--- a/kernel/umh.c
+++ b/kernel/umh.c
@@ -102,7 +102,6 @@ static int call_usermodehelper_exec_async(void *data)
 
 	commit_creds(new);
 
-	sub_info->pid = task_pid_nr(current);
 	if (sub_info->file) {
 		retval = do_execve_file(sub_info->file,
 					sub_info->argv, sub_info->envp);
@@ -468,6 +467,7 @@ static int umh_pipe_setup(struct subprocess_info *info, struct cred *new)
 
 	umh_info->pipe_to_umh = to_umh[1];
 	umh_info->pipe_from_umh = from_umh[0];
+	umh_info->pid = task_pid_nr(current);
 	return 0;
 }
 
@@ -476,13 +476,12 @@ static void umh_clean_and_save_pid(struct subprocess_info *info)
 	struct umh_info *umh_info = info->data;
 
 	/* cleanup if umh_pipe_setup() was successful but exec failed */
-	if (info->pid && info->retval) {
+	if (info->retval) {
 		fput(umh_info->pipe_to_umh);
 		fput(umh_info->pipe_from_umh);
 	}
 
 	argv_free(info->argv);
-	umh_info->pid = info->pid;
 }
 
 /**
-- 
2.25.0
