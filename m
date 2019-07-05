Return-Path: <SRS0=D23n=VC=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F937C0650E
	for <linux-security-module@archiver.kernel.org>; Fri,  5 Jul 2019 02:35:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F2DD21850
	for <linux-security-module@archiver.kernel.org>; Fri,  5 Jul 2019 02:35:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727305AbfGECfh (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 4 Jul 2019 22:35:37 -0400
Received: from out30-44.freemail.mail.aliyun.com ([115.124.30.44]:40107 "EHLO
        out30-44.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726404AbfGECfh (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 4 Jul 2019 22:35:37 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R211e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04395;MF=zhangliguang@linux.alibaba.com;NM=1;PH=DS;RN=2;SR=0;TI=SMTPD_---0TW3gsEG_1562294121;
Received: from localhost(mailfrom:zhangliguang@linux.alibaba.com fp:SMTPD_---0TW3gsEG_1562294121)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 05 Jul 2019 10:35:32 +0800
From:   luanshi <zhangliguang@linux.alibaba.com>
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     linux-security-module@vger.kernel.org
Subject: [PATCH] smack: fix some kernel-doc notations
Date:   Fri,  5 Jul 2019 10:35:20 +0800
Message-Id: <1562294120-68221-1-git-send-email-zhangliguang@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Fix/add kernel-doc notation and fix typos in security/smack/.

Signed-off-by: Liguang Zhang <zhangliguang@linux.alibaba.com>
---
 security/smack/smack_lsm.c | 33 +++++++++++++++------------------
 1 file changed, 15 insertions(+), 18 deletions(-)

diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index 4c5e5a4..51960f2 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -307,7 +307,7 @@ static struct smack_known *smk_fetch(const char *name, struct inode *ip,
 
 /**
  * init_inode_smack - initialize an inode security blob
- * @isp: the blob to initialize
+ * @inode: inode to extract the info from
  * @skp: a pointer to the Smack label entry to use in the blob
  *
  */
@@ -509,7 +509,7 @@ static int smack_ptrace_traceme(struct task_struct *ptp)
 
 /**
  * smack_syslog - Smack approval on syslog
- * @type: message type
+ * @typefrom_file: unused
  *
  * Returns 0 on success, error code otherwise.
  */
@@ -765,7 +765,7 @@ static int smack_sb_eat_lsm_opts(char *options, void **mnt_opts)
 /**
  * smack_set_mnt_opts - set Smack specific mount options
  * @sb: the file system superblock
- * @opts: Smack mount options
+ * @mnt_opts: Smack mount options
  * @kern_flags: mount option from kernel space or user space
  * @set_kern_flags: where to store converted mount opts
  *
@@ -958,7 +958,7 @@ static int smack_bprm_set_creds(struct linux_binprm *bprm)
  * smack_inode_alloc_security - allocate an inode blob
  * @inode: the inode in need of a blob
  *
- * Returns 0 if it gets a blob, -ENOMEM otherwise
+ * Returns 0
  */
 static int smack_inode_alloc_security(struct inode *inode)
 {
@@ -1164,7 +1164,7 @@ static int smack_inode_rename(struct inode *old_inode,
  *
  * This is the important Smack hook.
  *
- * Returns 0 if access is permitted, -EACCES otherwise
+ * Returns 0 if access is permitted, an error code otherwise
  */
 static int smack_inode_permission(struct inode *inode, int mask)
 {
@@ -1222,8 +1222,7 @@ static int smack_inode_setattr(struct dentry *dentry, struct iattr *iattr)
 
 /**
  * smack_inode_getattr - Smack check for getting attributes
- * @mnt: vfsmount of the object
- * @dentry: the object
+ * @path: path to extract the info from
  *
  * Returns 0 if access is permitted, an error code otherwise
  */
@@ -1870,14 +1869,13 @@ static int smack_file_receive(struct file *file)
 /**
  * smack_file_open - Smack dentry open processing
  * @file: the object
- * @cred: task credential
  *
  * Set the security blob in the file structure.
  * Allow the open only if the task has read access. There are
  * many read operations (e.g. fstat) that you can do with an
  * fd even if you have the file open write-only.
  *
- * Returns 0
+ * Returns 0 if current has access, error code otherwise
  */
 static int smack_file_open(struct file *file)
 {
@@ -1900,7 +1898,7 @@ static int smack_file_open(struct file *file)
 
 /**
  * smack_cred_alloc_blank - "allocate" blank task-level security credentials
- * @new: the new credentials
+ * @cred: the new credentials
  * @gfp: the atomicity of any memory allocations
  *
  * Prepare a blank set of credentials for modification.  This must allocate all
@@ -1983,7 +1981,7 @@ static void smack_cred_transfer(struct cred *new, const struct cred *old)
 
 /**
  * smack_cred_getsecid - get the secid corresponding to a creds structure
- * @c: the object creds
+ * @cred: the object creds
  * @secid: where to put the result
  *
  * Sets the secid to contain a u32 version of the smack label.
@@ -2140,8 +2138,6 @@ static int smack_task_getioprio(struct task_struct *p)
 /**
  * smack_task_setscheduler - Smack check on setting scheduler
  * @p: the task object
- * @policy: unused
- * @lp: unused
  *
  * Return 0 if read access is permitted
  */
@@ -2611,8 +2607,9 @@ static void smk_ipv6_port_label(struct socket *sock, struct sockaddr *address)
 
 /**
  * smk_ipv6_port_check - check Smack port access
- * @sock: socket
+ * @sk: socket
  * @address: address
+ * @act: the action being taken
  *
  * Create or update the port list entry
  */
@@ -2782,7 +2779,7 @@ static int smack_socket_post_create(struct socket *sock, int family,
  *
  * Cross reference the peer labels for SO_PEERSEC
  *
- * Returns 0 on success, and error code otherwise
+ * Returns 0
  */
 static int smack_socket_socketpair(struct socket *socka,
 		                   struct socket *sockb)
@@ -3014,13 +3011,13 @@ static int smack_shm_shmctl(struct kern_ipc_perm *isp, int cmd)
  *
  * Returns 0 if current has the requested access, error code otherwise
  */
-static int smack_shm_shmat(struct kern_ipc_perm *ipc, char __user *shmaddr,
+static int smack_shm_shmat(struct kern_ipc_perm *isp, char __user *shmaddr,
 			   int shmflg)
 {
 	int may;
 
 	may = smack_flags_to_may(shmflg);
-	return smk_curacc_shm(ipc, may);
+	return smk_curacc_shm(isp, may);
 }
 
 /**
@@ -4762,7 +4759,7 @@ static __init void init_smack_known_list(void)
 /**
  * smack_init - initialize the smack system
  *
- * Returns 0
+ * Returns 0 on success, -ENOMEM is there's no memory
  */
 static __init int smack_init(void)
 {
-- 
1.8.3.1

