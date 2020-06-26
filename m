Return-Path: <SRS0=ekpI=AH=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C589BC433DF
	for <linux-security-module@archiver.kernel.org>; Fri, 26 Jun 2020 13:04:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A94FF20775
	for <linux-security-module@archiver.kernel.org>; Fri, 26 Jun 2020 13:04:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727802AbgFZNE1 (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 26 Jun 2020 09:04:27 -0400
Received: from out03.mta.xmission.com ([166.70.13.233]:41312 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725940AbgFZNE0 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 26 Jun 2020 09:04:26 -0400
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out03.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.90_1)
        (envelope-from <ebiederm@xmission.com>)
        id 1joo1p-0001xN-H9; Fri, 26 Jun 2020 07:04:25 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in02.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1joo1o-0002IL-Hn; Fri, 26 Jun 2020 07:04:25 -0600
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
Date:   Fri, 26 Jun 2020 07:59:57 -0500
In-Reply-To: <87pn9mgfc2.fsf_-_@x220.int.ebiederm.org> (Eric W. Biederman's
        message of "Fri, 26 Jun 2020 07:51:41 -0500")
Message-ID: <87bll6dlte.fsf_-_@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1joo1o-0002IL-Hn;;;mid=<87bll6dlte.fsf_-_@x220.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1/ktlOV/iIh/MDWj4PBehdloeChZvIKhmU=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: [PATCH 14/14] umd: Remove exit_umh
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>


The bffilter code no longer uses the umd_info.cleanup callback.  This
callback is what exit_umh exists to call.  So remove exit_umh and all
of it's associated booking.

Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 include/linux/sched.h |  9 ---------
 include/linux/umd.h   |  2 --
 kernel/exit.c         |  2 --
 kernel/umd.c          | 28 ----------------------------
 4 files changed, 41 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index b62e6aaf28f0..edb2020875ad 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1511,7 +1511,6 @@ extern struct pid *cad_pid;
 #define PF_KTHREAD		0x00200000	/* I am a kernel thread */
 #define PF_RANDOMIZE		0x00400000	/* Randomize virtual address space */
 #define PF_SWAPWRITE		0x00800000	/* Allowed to write to swap */
-#define PF_UMH			0x02000000	/* I'm an Usermodehelper process */
 #define PF_NO_SETAFFINITY	0x04000000	/* Userland is not allowed to meddle with cpus_mask */
 #define PF_MCE_EARLY		0x08000000      /* Early kill for mce process policy */
 #define PF_MEMALLOC_NOCMA	0x10000000	/* All allocation request will have _GFP_MOVABLE cleared */
@@ -2020,14 +2019,6 @@ static inline void rseq_execve(struct task_struct *t)
 
 #endif
 
-void __exit_umh(struct task_struct *tsk);
-
-static inline void exit_umh(struct task_struct *tsk)
-{
-	if (unlikely(tsk->flags & PF_UMH))
-		__exit_umh(tsk);
-}
-
 #ifdef CONFIG_DEBUG_RSEQ
 
 void rseq_syscall(struct pt_regs *regs);
diff --git a/include/linux/umd.h b/include/linux/umd.h
index 1c4579d79bce..71d8f4a41ad7 100644
--- a/include/linux/umd.h
+++ b/include/linux/umd.h
@@ -8,8 +8,6 @@ struct umd_info {
 	const char *driver_name;
 	struct file *pipe_to_umh;
 	struct file *pipe_from_umh;
-	struct list_head list;
-	void (*cleanup)(struct umd_info *info);
 	struct path wd;
 	struct pid *tgid;
 };
diff --git a/kernel/exit.c b/kernel/exit.c
index 671d5066b399..42f079eb71e5 100644
--- a/kernel/exit.c
+++ b/kernel/exit.c
@@ -804,8 +804,6 @@ void __noreturn do_exit(long code)
 	exit_task_namespaces(tsk);
 	exit_task_work(tsk);
 	exit_thread(tsk);
-	if (group_dead)
-		exit_umh(tsk);
 
 	/*
 	 * Flush inherited counters to the parent - before the parent
diff --git a/kernel/umd.c b/kernel/umd.c
index 0db9ce3f56c9..de2f542191e5 100644
--- a/kernel/umd.c
+++ b/kernel/umd.c
@@ -8,9 +8,6 @@
 #include <linux/fs_struct.h>
 #include <linux/umd.h>
 
-static LIST_HEAD(umh_list);
-static DEFINE_MUTEX(umh_list_lock);
-
 static struct vfsmount *blob_to_mnt(const void *data, size_t len, const char *name)
 {
 	struct file_system_type *type;
@@ -129,7 +126,6 @@ static int umd_setup(struct subprocess_info *info, struct cred *new)
 	umd_info->pipe_to_umh = to_umh[1];
 	umd_info->pipe_from_umh = from_umh[0];
 	umd_info->tgid = get_pid(task_tgid(current));
-	current->flags |= PF_UMH;
 	return 0;
 }
 
@@ -177,11 +173,6 @@ int fork_usermode_driver(struct umd_info *info)
 		goto out;
 
 	err = call_usermodehelper_exec(sub_info, UMH_WAIT_EXEC);
-	if (!err) {
-		mutex_lock(&umh_list_lock);
-		list_add(&info->list, &umh_list);
-		mutex_unlock(&umh_list_lock);
-	}
 out:
 	if (argv)
 		argv_free(argv);
@@ -189,23 +180,4 @@ int fork_usermode_driver(struct umd_info *info)
 }
 EXPORT_SYMBOL_GPL(fork_usermode_driver);
 
-void __exit_umh(struct task_struct *tsk)
-{
-	struct umd_info *info;
-	struct pid *tgid = task_tgid(tsk);
-
-	mutex_lock(&umh_list_lock);
-	list_for_each_entry(info, &umh_list, list) {
-		if (info->tgid == tgid) {
-			list_del(&info->list);
-			mutex_unlock(&umh_list_lock);
-			goto out;
-		}
-	}
-	mutex_unlock(&umh_list_lock);
-	return;
-out:
-	if (info->cleanup)
-		info->cleanup(info);
-}
 
-- 
2.25.0

