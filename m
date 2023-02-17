Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5C58C64ED6
	for <linux-security-module@archiver.kernel.org>; Fri, 17 Feb 2023 03:27:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229620AbjBQD1n (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 16 Feb 2023 22:27:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230260AbjBQD1D (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 16 Feb 2023 22:27:03 -0500
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBC024FC84
        for <linux-security-module@vger.kernel.org>; Thu, 16 Feb 2023 19:26:58 -0800 (PST)
Received: by mail-qt1-x82a.google.com with SMTP id 5so4269990qtp.9
        for <linux-security-module@vger.kernel.org>; Thu, 16 Feb 2023 19:26:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=L8fGGD5vUlN4EKfOE3nQqzT8piertkUkXLziMS3T+f4=;
        b=fVnnZcpnTham7QlSNPLacAaUQ8cAD0tTaeJwqxhVz/ygkpWfFodmP5MiW4BKsv5VKE
         CMl4bwsqNtR4axvGvaf5zNtSAgOgxueY27cMdfGtjyvWczXKXJ4WpVBSlp7++3P2O20t
         7P9f11kG107KzMr/VfV9Rzrq3IAE1OeMQFdzwBrHPUyUtmjE3cy6PZYo8SfZ4qew/nTs
         ar2ukp6HSMoWI6f+kOC5a/swE8nrT1yBmHUSzP7CSBV3jMERThS686KY2w5VE0OkbfJq
         mHZTX87an8pI+YPc5Tq5Bwwm3yS6DMEo98yeKwwY9vNGVL5cxZGsA1+U0a06KGrrpppB
         UxLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L8fGGD5vUlN4EKfOE3nQqzT8piertkUkXLziMS3T+f4=;
        b=hL4B6SQACj97TrDNg33OcCOCxZN8XS4F6td9X5QJ6xB/1DOzwSIuho/emMcGjDY8tm
         wtCKVCAXP8HKDxdf2OXnoPIOY8XSL1XKJrFYEcbDTuzG3l0ZR86nCkborLATi4KMojBm
         EvSFWS4UcuDZYZjH2SNCsDTEMKTnIxRbx7R2fXKXVexdlffRVi1IV4bgOl3AE42buY2Y
         wy125FYSweBpj3EIvsfTcUuLvJRFAA+HchxVq9apZExMC7GaFd5DxRMf3lrky6KdZVij
         XbTSgq4QXU9HhuN+17/1vF74fzBMFfTzjFdUg7c/CL7Nopp4hJjf2u7MwdKMN0rsqdE3
         n23Q==
X-Gm-Message-State: AO0yUKV9fR0JB+H99ST3KY5lTkt1ALaH1GNxXLaRWQUWFmO26zu+p9D8
        6UXYP42nBh6chi60M/8fdjEuAHvfyicfqfM=
X-Google-Smtp-Source: AK7set9jOO4NIzEa2dtibf66zbsb2xVTX6j6YYcIUrflXppisPNyD67uIXGVfi52oGI+dc70inHH3g==
X-Received: by 2002:ac8:594a:0:b0:3bd:a75:1cb with SMTP id 10-20020ac8594a000000b003bd0a7501cbmr7449643qtz.53.1676604416702;
        Thu, 16 Feb 2023 19:26:56 -0800 (PST)
Received: from localhost (pool-108-26-161-203.bstnma.fios.verizon.net. [108.26.161.203])
        by smtp.gmail.com with ESMTPSA id t189-20020a372dc6000000b006fa4ac86bfbsm2429377qkh.55.2023.02.16.19.26.55
        for <linux-security-module@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Feb 2023 19:26:56 -0800 (PST)
From:   Paul Moore <paul@paul-moore.com>
To:     linux-security-module@vger.kernel.org
Subject: [PATCH 21/22] lsm: move the remaining LSM hook comments to security/security.c
Date:   Thu, 16 Feb 2023 22:26:24 -0500
Message-Id: <20230217032625.678457-22-paul@paul-moore.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230217032625.678457-1-paul@paul-moore.com>
References: <20230217032625.678457-1-paul@paul-moore.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

This patch relocates the LSM hook function comments to the function
definitions, in keeping with the current kernel conventions.  This
should make the hook descriptions more easily discoverable and easier
to maintain.

While formatting changes have been done to better fit the kernel-doc
style, content changes have been kept to a minimum and limited to
text which was obviously incorrect and/or outdated.  It is expected
the future patches will improve the quality of the function header
comments.

Signed-off-by: Paul Moore <paul@paul-moore.com>
---
 include/linux/lsm_hooks.h | 168 ---------------------------
 security/security.c       | 231 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 231 insertions(+), 168 deletions(-)

diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index 8e006df1db56..ddbbe89a7a48 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -29,174 +29,6 @@
 #include <linux/init.h>
 #include <linux/rculist.h>
 
-/**
- * union security_list_options - Linux Security Module hook function list
- *
- * @ptrace_access_check:
- *	Check permission before allowing the current process to trace the
- *	@child process.
- *	Security modules may also want to perform a process tracing check
- *	during an execve in the set_security or apply_creds hooks of
- *	tracing check during an execve in the bprm_set_creds hook of
- *	binprm_security_ops if the process is being traced and its security
- *	attributes would be changed by the execve.
- *	@child contains the task_struct structure for the target process.
- *	@mode contains the PTRACE_MODE flags indicating the form of access.
- *	Return 0 if permission is granted.
- * @ptrace_traceme:
- *	Check that the @parent process has sufficient permission to trace the
- *	current process before allowing the current process to present itself
- *	to the @parent process for tracing.
- *	@parent contains the task_struct structure for debugger process.
- *	Return 0 if permission is granted.
- * @capget:
- *	Get the @effective, @inheritable, and @permitted capability sets for
- *	the @target process.  The hook may also perform permission checking to
- *	determine if the current process is allowed to see the capability sets
- *	of the @target process.
- *	@target contains the task_struct structure for target process.
- *	@effective contains the effective capability set.
- *	@inheritable contains the inheritable capability set.
- *	@permitted contains the permitted capability set.
- *	Return 0 if the capability sets were successfully obtained.
- * @capset:
- *	Set the @effective, @inheritable, and @permitted capability sets for
- *	the current process.
- *	@new contains the new credentials structure for target process.
- *	@old contains the current credentials structure for target process.
- *	@effective contains the effective capability set.
- *	@inheritable contains the inheritable capability set.
- *	@permitted contains the permitted capability set.
- *	Return 0 and update @new if permission is granted.
- * @capable:
- *	Check whether the @tsk process has the @cap capability in the indicated
- *	credentials.
- *	@cred contains the credentials to use.
- *	@ns contains the user namespace we want the capability in.
- *	@cap contains the capability <include/linux/capability.h>.
- *	@opts contains options for the capable check <include/linux/security.h>.
- *	Return 0 if the capability is granted for @tsk.
- * @quotactl:
- *	Check whether the quotactl syscall is allowed for this @sb.
- *	Return 0 if permission is granted.
- * @quota_on:
- *	Check whether QUOTAON is allowed for this @dentry.
- *	Return 0 if permission is granted.
- * @syslog:
- *	Check permission before accessing the kernel message ring or changing
- *	logging to the console.
- *	See the syslog(2) manual page for an explanation of the @type values.
- *	@type contains the SYSLOG_ACTION_* constant from
- *	<include/linux/syslog.h>.
- *	Return 0 if permission is granted.
- * @settime:
- *	Check permission to change the system time.
- *	struct timespec64 is defined in <include/linux/time64.h> and timezone
- *	is defined in <include/linux/time.h>
- *	@ts contains new time.
- *	@tz contains new timezone.
- *	Return 0 if permission is granted.
- * @vm_enough_memory:
- *	Check permissions for allocating a new virtual mapping.
- *	@mm contains the mm struct it is being added to.
- *	@pages contains the number of pages.
- *	Return 0 if permission is granted by the LSM infrastructure to the
- *	caller. If all LSMs return a positive value, __vm_enough_memory() will
- *	be called with cap_sys_admin set. If at least one LSM returns 0 or
- *	negative, __vm_enough_memory() will be called with cap_sys_admin
- *	cleared.
- *
- * @ismaclabel:
- *	Check if the extended attribute specified by @name
- *	represents a MAC label. Returns 1 if name is a MAC
- *	attribute otherwise returns 0.
- *	@name full extended attribute name to check against
- *	LSM as a MAC label.
- *
- * @secid_to_secctx:
- *	Convert secid to security context.  If secdata is NULL the length of
- *	the result will be returned in seclen, but no secdata will be returned.
- *	This does mean that the length could change between calls to check the
- *	length and the next call which actually allocates and returns the
- *	secdata.
- *	@secid contains the security ID.
- *	@secdata contains the pointer that stores the converted security
- *	context.
- *	@seclen pointer which contains the length of the data.
- *	Return 0 on success, error on failure.
- * @secctx_to_secid:
- *	Convert security context to secid.
- *	@secid contains the pointer to the generated security ID.
- *	@secdata contains the security context.
- *	Return 0 on success, error on failure.
- *
- * @release_secctx:
- *	Release the security context.
- *	@secdata contains the security context.
- *	@seclen contains the length of the security context.
- *
- * @inode_invalidate_secctx:
- *	Notify the security module that it must revalidate the security context
- *	of an inode.
- *
- * @inode_notifysecctx:
- *	Notify the security module of what the security context of an inode
- *	should be.  Initializes the incore security context managed by the
- *	security module for this inode.  Example usage:  NFS client invokes
- *	this hook to initialize the security context in its incore inode to the
- *	value provided by the server for the file when the server returned the
- *	file's attributes to the client.
- *	Must be called with inode->i_mutex locked.
- *	@inode we wish to set the security context of.
- *	@ctx contains the string which we wish to set in the inode.
- *	@ctxlen contains the length of @ctx.
- *	Return 0 on success, error on failure.
- *
- * @inode_setsecctx:
- *	Change the security context of an inode.  Updates the
- *	incore security context managed by the security module and invokes the
- *	fs code as needed (via __vfs_setxattr_noperm) to update any backing
- *	xattrs that represent the context.  Example usage:  NFS server invokes
- *	this hook to change the security context in its incore inode and on the
- *	backing filesystem to a value provided by the client on a SETATTR
- *	operation.
- *	Must be called with inode->i_mutex locked.
- *	@dentry contains the inode we wish to set the security context of.
- *	@ctx contains the string which we wish to set in the inode.
- *	@ctxlen contains the length of @ctx.
- *	Return 0 on success, error on failure.
- *
- * @inode_getsecctx:
- *	On success, returns 0 and fills out @ctx and @ctxlen with the security
- *	context for the given @inode.
- *	@inode we wish to get the security context of.
- *	@ctx is a pointer in which to place the allocated security context.
- *	@ctxlen points to the place to put the length of @ctx.
- *	Return 0 on success, error on failure.
- *
- * Security hooks for the general notification queue:
- *
- * @post_notification:
- *	Check to see if a watch notification can be posted to a particular
- *	queue.
- *	@w_cred: The credentials of the whoever set the watch.
- *	@cred: The event-triggerer's credentials.
- *	@n: The notification being posted.
- *	Return 0 if permission is granted.
- *
- * @watch_key:
- *	Check to see if a process is allowed to watch for event notifications
- *	from a key or keyring.
- *	@key: The key to watch.
- *	Return 0 if permission is granted.
- *
- * @locked_down:
- *	Determine whether a kernel feature that potentially enables arbitrary
- *	code execution in kernel space should be permitted.
- *	@what: kernel feature being accessed.
- *	Return 0 if permission is granted.
- *
- */
 union security_list_options {
 	#define LSM_HOOK(RET, DEFAULT, NAME, ...) RET (*NAME)(__VA_ARGS__);
 	#include "lsm_hook_defs.h"
diff --git a/security/security.c b/security/security.c
index f4b093673ca6..4362d9b9140f 100644
--- a/security/security.c
+++ b/security/security.c
@@ -838,16 +838,54 @@ int security_binder_transfer_file(const struct cred *from,
 	return call_int_hook(binder_transfer_file, 0, from, to, file);
 }
 
+/**
+ * security_ptrace_access_check() - Check if tracing is allowed
+ * @child: target process
+ * @mode: PTRACE_MODE flags
+ *
+ * Check permission before allowing the current process to trace the @child
+ * process.  Security modules may also want to perform a process tracing check
+ * during an execve in the set_security or apply_creds hooks of tracing check
+ * during an execve in the bprm_set_creds hook of binprm_security_ops if the
+ * process is being traced and its security attributes would be changed by the
+ * execve.
+ *
+ * Return: Returns 0 if permission is granted.
+ */
 int security_ptrace_access_check(struct task_struct *child, unsigned int mode)
 {
 	return call_int_hook(ptrace_access_check, 0, child, mode);
 }
 
+/**
+ * security_ptrace_traceme() - Check if tracing is allowed
+ * @parent: tracing process
+ *
+ * Check that the @parent process has sufficient permission to trace the
+ * current process before allowing the current process to present itself to the
+ * @parent process for tracing.
+ *
+ * Return: Returns 0 if permission is granted.
+ */
 int security_ptrace_traceme(struct task_struct *parent)
 {
 	return call_int_hook(ptrace_traceme, 0, parent);
 }
 
+/**
+ * security_capget() - Get the capability sets for a process
+ * @target: target process
+ * @effective: effective capability set
+ * @inheritable: inheritable capability set
+ * @permitted: permitted capability set
+ *
+ * Get the @effective, @inheritable, and @permitted capability sets for the
+ * @target process.  The hook may also perform permission checking to determine
+ * if the current process is allowed to see the capability sets of the @target
+ * process.
+ *
+ * Return: Returns 0 if the capability sets were successfully obtained.
+ */
 int security_capget(struct task_struct *target,
 		     kernel_cap_t *effective,
 		     kernel_cap_t *inheritable,
@@ -857,6 +895,19 @@ int security_capget(struct task_struct *target,
 				effective, inheritable, permitted);
 }
 
+/**
+ * security_capset() - Set the capability sets for a process
+ * @new: new credentials for the target process
+ * @old: current credentials of the target process
+ * @effective: effective capability set
+ * @inheritable: inheritable capability set
+ * @permitted: permitted capability set
+ *
+ * Set the @effective, @inheritable, and @permitted capability sets for the
+ * current process.
+ *
+ * Return: Returns 0 and update @new if permission is granted.
+ */
 int security_capset(struct cred *new, const struct cred *old,
 		    const kernel_cap_t *effective,
 		    const kernel_cap_t *inheritable,
@@ -866,6 +917,19 @@ int security_capset(struct cred *new, const struct cred *old,
 				effective, inheritable, permitted);
 }
 
+/**
+ * security_capable() - Check if a process has the necessary capability
+ * @cred: credentials to examine
+ * @ns: user namespace
+ * @cap: capability requested
+ * @opts: capability check options
+ *
+ * Check whether the @tsk process has the @cap capability in the indicated
+ * credentials.  @cap contains the capability <include/linux/capability.h>.
+ * @opts contains options for the capable check <include/linux/security.h>.
+ *
+ * Return: Returns 0 if the capability is granted.
+ */
 int security_capable(const struct cred *cred,
 		     struct user_namespace *ns,
 		     int cap,
@@ -874,26 +938,78 @@ int security_capable(const struct cred *cred,
 	return call_int_hook(capable, 0, cred, ns, cap, opts);
 }
 
+/**
+ * security_quotactl() - Check if a quotactl() syscall is allowed for this fs
+ * @cmds: commands
+ * @type: type
+ * @id: id
+ * @sb: filesystem
+ *
+ * Check whether the quotactl syscall is allowed for this @sb.
+ *
+ * Return: Returns 0 if permission is granted.
+ */
 int security_quotactl(int cmds, int type, int id, struct super_block *sb)
 {
 	return call_int_hook(quotactl, 0, cmds, type, id, sb);
 }
 
+/**
+ * security_quota_on() - Check if QUOTAON is allowed for a dentry
+ * @dentry: dentry
+ *
+ * Check whether QUOTAON is allowed for @dentry.
+ *
+ * Return: Returns 0 if permission is granted.
+ */
 int security_quota_on(struct dentry *dentry)
 {
 	return call_int_hook(quota_on, 0, dentry);
 }
 
+/**
+ * security_syslog() - Check if accessing the kernel message ring is allowed
+ * @type: SYSLOG_ACTION_* type
+ *
+ * Check permission before accessing the kernel message ring or changing
+ * logging to the console.  See the syslog(2) manual page for an explanation of
+ * the @type values.
+ *
+ * Return: Return 0 if permission is granted.
+ */
 int security_syslog(int type)
 {
 	return call_int_hook(syslog, 0, type);
 }
 
+/**
+ * security_settime64() - Check if changing the system time is allowed
+ * @ts: new time
+ * @tz: timezone
+ *
+ * Check permission to change the system time, struct timespec64 is defined in
+ * <include/linux/time64.h> and timezone is defined in <include/linux/time.h>.
+ *
+ * Return: Returns 0 if permission is granted.
+ */
 int security_settime64(const struct timespec64 *ts, const struct timezone *tz)
 {
 	return call_int_hook(settime, 0, ts, tz);
 }
 
+/**
+ * security_vm_enough_memory_mm() - Check if allocating a new mem map is allowed
+ * @mm: mm struct
+ * @pages: number of pages
+ *
+ * Check permissions for allocating a new virtual mapping.  If all LSMs return
+ * a positive value, __vm_enough_memory() will be called with cap_sys_admin
+ * set. If at least one LSM returns 0 or negative, __vm_enough_memory() will be
+ * called with cap_sys_admin cleared.
+ *
+ * Return: Returns 0 if permission is granted by the LSM infrastructure to the
+ *         caller.
+ */
 int security_vm_enough_memory_mm(struct mm_struct *mm, long pages)
 {
 	struct security_hook_list *hp;
@@ -3702,12 +3818,33 @@ int security_netlink_send(struct sock *sk, struct sk_buff *skb)
 	return call_int_hook(netlink_send, 0, sk, skb);
 }
 
+/**
+ * security_ismaclabel() - Check is the named attribute is a MAC label
+ * @name: full extended attribute name
+ *
+ * Check if the extended attribute specified by @name represents a MAC label.
+ *
+ * Return: Returns 1 if name is a MAC attribute otherwise returns 0.
+ */
 int security_ismaclabel(const char *name)
 {
 	return call_int_hook(ismaclabel, 0, name);
 }
 EXPORT_SYMBOL(security_ismaclabel);
 
+/**
+ * security_secid_to_secctx() - Convert a secid to a secctx
+ * @secid: secid
+ * @secdata: secctx
+ * @seclen: secctx length
+ *
+ * Convert secid to security context.  If @secdata is NULL the length of the
+ * result will be returned in @seclen, but no @secdata will be returned.  This
+ * does mean that the length could change between calls to check the length and
+ * the next call which actually allocates and returns the @secdata.
+ *
+ * Return: Return 0 on success, error on failure.
+ */
 int security_secid_to_secctx(u32 secid, char **secdata, u32 *seclen)
 {
 	struct security_hook_list *hp;
@@ -3727,6 +3864,16 @@ int security_secid_to_secctx(u32 secid, char **secdata, u32 *seclen)
 }
 EXPORT_SYMBOL(security_secid_to_secctx);
 
+/**
+ * security_secctx_to_secid() - Convert a secctx to a secid
+ * @secdata: secctx
+ * @seclen: length of secctx
+ * @secid: secid
+ *
+ * Convert security context to secid.
+ *
+ * Return: Returns 0 on success, error on failure.
+ */
 int security_secctx_to_secid(const char *secdata, u32 seclen, u32 *secid)
 {
 	*secid = 0;
@@ -3734,30 +3881,86 @@ int security_secctx_to_secid(const char *secdata, u32 seclen, u32 *secid)
 }
 EXPORT_SYMBOL(security_secctx_to_secid);
 
+/**
+ * security_release_secctx() - Free a secctx buffer
+ * @secdata: secctx
+ * @seclen: length of secctx
+ *
+ * Release the security context.
+ */
 void security_release_secctx(char *secdata, u32 seclen)
 {
 	call_void_hook(release_secctx, secdata, seclen);
 }
 EXPORT_SYMBOL(security_release_secctx);
 
+/**
+ * security_inode_invalidate_secctx() - Invalidate an inode's security label
+ * @inode: inode
+ *
+ * Notify the security module that it must revalidate the security context of
+ * an inode.
+ */
 void security_inode_invalidate_secctx(struct inode *inode)
 {
 	call_void_hook(inode_invalidate_secctx, inode);
 }
 EXPORT_SYMBOL(security_inode_invalidate_secctx);
 
+/**
+ * security_inode_notifysecctx() - Nofify the LSM of an inode's security label
+ * @inode: inode
+ * @ctx: secctx
+ * @ctxlen: length of secctx
+ *
+ * Notify the security module of what the security context of an inode should
+ * be.  Initializes the incore security context managed by the security module
+ * for this inode.  Example usage: NFS client invokes this hook to initialize
+ * the security context in its incore inode to the value provided by the server
+ * for the file when the server returned the file's attributes to the client.
+ * Must be called with inode->i_mutex locked.
+ *
+ * Return: Returns 0 on success, error on failure.
+ */
 int security_inode_notifysecctx(struct inode *inode, void *ctx, u32 ctxlen)
 {
 	return call_int_hook(inode_notifysecctx, 0, inode, ctx, ctxlen);
 }
 EXPORT_SYMBOL(security_inode_notifysecctx);
 
+/**
+ * security_inode_setsecctx() - Change the security label of an inode
+ * @dentry: inode
+ * @ctx: secctx
+ * @ctxlen: length of secctx
+ *
+ * Change the security context of an inode.  Updates the incore security
+ * context managed by the security module and invokes the fs code as needed
+ * (via __vfs_setxattr_noperm) to update any backing xattrs that represent the
+ * context.  Example usage: NFS server invokes this hook to change the security
+ * context in its incore inode and on the backing filesystem to a value
+ * provided by the client on a SETATTR operation.  Must be called with
+ * inode->i_mutex locked.
+ *
+ * Return: Returns 0 on success, error on failure.
+ */
 int security_inode_setsecctx(struct dentry *dentry, void *ctx, u32 ctxlen)
 {
 	return call_int_hook(inode_setsecctx, 0, dentry, ctx, ctxlen);
 }
 EXPORT_SYMBOL(security_inode_setsecctx);
 
+/**
+ * security_inode_getsecctx() - Get the security label of an inode
+ * @inode: inode
+ * @ctx: secctx
+ * @ctxlen: length of secctx
+ *
+ * On success, returns 0 and fills out @ctx and @ctxlen with the security
+ * context for the given @inode.
+ *
+ * Return: Returns 0 on success, error on failure.
+ */
 int security_inode_getsecctx(struct inode *inode, void **ctx, u32 *ctxlen)
 {
 	return call_int_hook(inode_getsecctx, -EOPNOTSUPP, inode, ctx, ctxlen);
@@ -3765,6 +3968,16 @@ int security_inode_getsecctx(struct inode *inode, void **ctx, u32 *ctxlen)
 EXPORT_SYMBOL(security_inode_getsecctx);
 
 #ifdef CONFIG_WATCH_QUEUE
+/**
+ * security_post_notification() - Check if a watch notification can be posted
+ * @w_cred: credentials of the task that set the watch
+ * @cred: credentials of the task which triggered the watch
+ * @n: the notification
+ *
+ * Check to see if a watch notification can be posted to a particular queue.
+ *
+ * Return: Returns 0 if permission is granted.
+ */
 int security_post_notification(const struct cred *w_cred,
 			       const struct cred *cred,
 			       struct watch_notification *n)
@@ -3774,6 +3987,15 @@ int security_post_notification(const struct cred *w_cred,
 #endif /* CONFIG_WATCH_QUEUE */
 
 #ifdef CONFIG_KEY_NOTIFICATIONS
+/**
+ * security_watch_key() - Check if a task is allowed to watch for key events
+ * @key: the key to watch
+ *
+ * Check to see if a process is allowed to watch for event notifications from
+ * a key or keyring.
+ *
+ * Return: Returns 0 if permission is granted.
+ */
 int security_watch_key(struct key *key)
 {
 	return call_int_hook(watch_key, 0, key);
@@ -4919,6 +5141,15 @@ void security_bpf_prog_free(struct bpf_prog_aux *aux)
 }
 #endif /* CONFIG_BPF_SYSCALL */
 
+/**
+ * security_locked_down() - Check if a kernel feature is allowed
+ * @what: requested kernel feature
+ *
+ * Determine whether a kernel feature that potentially enables arbitrary code
+ * execution in kernel space should be permitted.
+ *
+ * Return: Returns 0 if permission is granted.
+ */
 int security_locked_down(enum lockdown_reason what)
 {
 	return call_int_hook(locked_down, 0, what);
-- 
2.39.2

