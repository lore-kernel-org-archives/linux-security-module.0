Return-Path: <SRS0=N8uA=4E=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5A48C7619B
	for <linux-security-module@archiver.kernel.org>; Sun, 16 Feb 2020 07:09:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E6C72086A
	for <linux-security-module@archiver.kernel.org>; Sun, 16 Feb 2020 07:09:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="EHFwYTsT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725993AbgBPHJF (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Sun, 16 Feb 2020 02:09:05 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:55988 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725866AbgBPHJF (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Sun, 16 Feb 2020 02:09:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:Date:Message-ID:Cc:Subject:From:To:Sender:Reply-To:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=UqdYWoj1RW3ouISgmmvW3Gaa0hBFuEf6FqRqIIFofEU=; b=EHFwYTsTyQgHw9E4GTs9wl6pTb
        toslSL3+z6+RcG8CY1oYonbvVMr+bxX9qjB7g0GNiIV1a+7/7w93t+RL67g0+2WOdR1Ff0/t4hV9x
        fs1ADQfxx8QIxo5wx81vfYqh/vHgEMk82Kf/C7m43bJ0+eLaLLI143HHuH1aDnoSHNg3LhV0j/9IW
        N6zoFbwtoGBmf17bA8l550tkuD0RHJ1KG7tT/axzHiRZ/S7i0t5XIcL7NK7MDL+CqmaYXDR+4FDqU
        hor1QgfZ9TImPwMRDnVq5cZj0MHLonN2MSGhn8QBbY/JhWoPeMetozcX935BaleWc6pDAyI5IPFIY
        BeksFSqA==;
Received: from [2601:1c0:6280:3f0::19c2]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j3E2i-0006eB-NA; Sun, 16 Feb 2020 07:08:40 +0000
To:     LKML <linux-kernel@vger.kernel.org>,
        linux-security-module <linux-security-module@vger.kernel.org>
From:   Randy Dunlap <rdunlap@infradead.org>
Subject: [RFC PATCH] security: <linux/lsm_hooks.h>: fix all kernel-doc
 warnings
Cc:     John Johansen <john.johansen@canonical.com>,
        Kees Cook <keescook@chromium.org>,
        Micah Morton <mortonm@chromium.org>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Eric Paris <eparis@parisplace.org>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Kentaro Takeda <takedakn@nttdata.co.jp>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Message-ID: <fb2c98bd-b579-6ad0-721a-56a4f81f0d6e@infradead.org>
Date:   Sat, 15 Feb 2020 23:08:38 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

From: Randy Dunlap <rdunlap@infradead.org>

Fix all kernel-doc warnings in <linux/lsm_hooks.h>.
Fixes the following warnings:

../include/linux/lsm_hooks.h:1830: warning: Function parameter or member 'quotactl' not described in 'security_list_options'
../include/linux/lsm_hooks.h:1830: warning: Function parameter or member 'quota_on' not described in 'security_list_options'
../include/linux/lsm_hooks.h:1830: warning: Function parameter or member 'sb_free_mnt_opts' not described in 'security_list_options'
../include/linux/lsm_hooks.h:1830: warning: Function parameter or member 'sb_eat_lsm_opts' not described in 'security_list_options'
../include/linux/lsm_hooks.h:1830: warning: Function parameter or member 'sb_kern_mount' not described in 'security_list_options'
../include/linux/lsm_hooks.h:1830: warning: Function parameter or member 'sb_show_options' not described in 'security_list_options'
../include/linux/lsm_hooks.h:1830: warning: Function parameter or member 'sb_add_mnt_opt' not described in 'security_list_options'
../include/linux/lsm_hooks.h:1830: warning: Function parameter or member 'd_instantiate' not described in 'security_list_options'
../include/linux/lsm_hooks.h:1830: warning: Function parameter or member 'getprocattr' not described in 'security_list_options'
../include/linux/lsm_hooks.h:1830: warning: Function parameter or member 'setprocattr' not described in 'security_list_options'
../include/linux/lsm_hooks.h:1830: warning: Function parameter or member 'locked_down' not described in 'security_list_options'
../include/linux/lsm_hooks.h:1830: warning: Function parameter or member 'perf_event_open' not described in 'security_list_options'
../include/linux/lsm_hooks.h:1830: warning: Function parameter or member 'perf_event_alloc' not described in 'security_list_options'
../include/linux/lsm_hooks.h:1830: warning: Function parameter or member 'perf_event_free' not described in 'security_list_options'
../include/linux/lsm_hooks.h:1830: warning: Function parameter or member 'perf_event_read' not described in 'security_list_options'
../include/linux/lsm_hooks.h:1830: warning: Function parameter or member 'perf_event_write' not described in 'security_list_options'

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: John Johansen <john.johansen@canonical.com>
Cc: Kees Cook <keescook@chromium.org>
Cc: Micah Morton <mortonm@chromium.org>
Cc: James Morris <jmorris@namei.org>
Cc: "Serge E. Hallyn" <serge@hallyn.com>
Cc: linux-security-module@vger.kernel.org
Cc: Paul Moore <paul@paul-moore.com>
Cc: Stephen Smalley <sds@tycho.nsa.gov>
Cc: Eric Paris <eparis@parisplace.org>
Cc: Casey Schaufler <casey@schaufler-ca.com>
Cc: Kentaro Takeda <takedakn@nttdata.co.jp>
Cc: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
---
Notes:
a. The location for some of these might need to be modified.
b. 'locked_down' was just missing a final ':'.
c. Added a new section: Security hooks for perf events.

 include/linux/lsm_hooks.h |   36 +++++++++++++++++++++++++++++++++++-
 1 file changed, 35 insertions(+), 1 deletion(-)

--- lnx-56-rc1.orig/include/linux/lsm_hooks.h
+++ lnx-56-rc1/include/linux/lsm_hooks.h
@@ -103,6 +103,10 @@
  * @sb_free_security:
  *	Deallocate and clear the sb->s_security field.
  *	@sb contains the super_block structure to be modified.
+ * @sb_free_mnt_opts:
+ * 	Free memory associated with @mnt_ops.
+ * @sb_eat_lsm_opts:
+ * 	Eat (scan @orig options) and save them in @mnt_opts.
  * @sb_statfs:
  *	Check permission before obtaining filesystem statistics for the @mnt
  *	mountpoint.
@@ -136,6 +140,10 @@
  *	@sb superblock being remounted
  *	@data contains the filesystem-specific data.
  *	Return 0 if permission is granted.
+ * @sb_kern_mount:
+ * 	Mount this @sb if allowed by permissions.
+ * @sb_show_options:
+ * 	Show (print on @m) mount options for this @sb.
  * @sb_umount:
  *	Check permission before the @mnt file system is unmounted.
  *	@mnt contains the mounted file system.
@@ -155,6 +163,8 @@
  *	Copy all security options from a given superblock to another
  *	@oldsb old superblock which contain information to clone
  *	@newsb new superblock which needs filled in
+ * @sb_add_mnt_opt:
+ * 	Add one mount @option to @mnt_opts.
  * @sb_parse_opts_str:
  *	Parse a string of security data filling in the opts structure
  *	@options string containing all mount options known by the LSM
@@ -451,6 +461,12 @@
  *	security module does not know about attribute or a negative error code
  *	to abort the copy up. Note that the caller is responsible for reading
  *	and writing the xattrs as this hook is merely a filter.
+ * @d_instantiate:
+ * 	Fill in @inode security information for a @dentry if allowed.
+ * @getprocattr:
+ * 	Read attribute @name for process @p and store it into @value if allowed.
+ * @setprocattr:
+ * 	Write (set) attribute @name to @value, size @size if allowed.
  *
  * Security hooks for kernfs node operations
  *
@@ -1113,6 +1129,7 @@
  *	In case of failure, @secid will be set to zero.
  *
  * Security hooks for individual messages held in System V IPC message queues
+ *
  * @msg_msg_alloc_security:
  *	Allocate and attach a security structure to the msg->security field.
  *	The security field is initialized to NULL when the structure is first
@@ -1302,6 +1319,10 @@
  *	@cap contains the capability <include/linux/capability.h>.
  *	@opts contains options for the capable check <include/linux/security.h>
  *	Return 0 if the capability is granted for @tsk.
+ * @quotactl:
+ * 	Check whether the quotactl syscall is allowed for this @sb.
+ * @quota_on:
+ * 	Check whether QUOTAON is allowed for this @dentry.
  * @syslog:
  *	Check permission before accessing the kernel message ring or changing
  *	logging to the console.
@@ -1449,11 +1470,24 @@
  * @bpf_prog_free_security:
  *	Clean up the security information stored inside bpf prog.
  *
- * @locked_down
+ * @locked_down:
  *     Determine whether a kernel feature that potentially enables arbitrary
  *     code execution in kernel space should be permitted.
  *
  *     @what: kernel feature being accessed
+ *
+ * Security hooks for perf events
+ *
+ * @perf_event_open:
+ * 	Check whether the @type of perf_event_open syscall is allowed.
+ * @perf_event_alloc:
+ * 	Allocate and save perf_event security info.
+ * @perf_event_free:
+ * 	Release (free) perf_event security info.
+ * @perf_event_read:
+ * 	Read perf_event security info if allowed.
+ * @perf_event_write:
+ * 	Write perf_event security info if allowed.
  */
 union security_list_options {
 	int (*binder_set_context_mgr)(struct task_struct *mgr);

