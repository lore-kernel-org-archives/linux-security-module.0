Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F219C636D7
	for <linux-security-module@archiver.kernel.org>; Fri, 17 Feb 2023 03:26:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229726AbjBQD0e (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 16 Feb 2023 22:26:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229538AbjBQD0d (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 16 Feb 2023 22:26:33 -0500
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A80264BEAA
        for <linux-security-module@vger.kernel.org>; Thu, 16 Feb 2023 19:26:31 -0800 (PST)
Received: by mail-qt1-x82c.google.com with SMTP id c2so4294288qtw.5
        for <linux-security-module@vger.kernel.org>; Thu, 16 Feb 2023 19:26:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dl8GIEMbBKkzS5rQAvz8tepJOPKmthy0Oi9cCtTLcnI=;
        b=TA+FWhTnffnD9BLyaJGz0QZ4/uwZPtTeKNtveoKA2D5C7QqIqPFW600PK7zu9tXwiI
         vHHCvm418SwWdvrRPSipdSanX1270g8LjNq5yPJQVRXLyJv6VVX6CVcZI02K3gRw9nlA
         6/hBbusHSKlzBaUyH37R/YLpjmULQLepgt+O91xpRCBVpKMz3KGmrJGywPNEiYPVxlXn
         LdLrJXHhooPCBG6UNqwHIwOQiU66VJujE11be8UxKqrUpx5H9p6e1zcjjf2VAyMfr0T4
         0uvptvmKwMUPGkP9fYjtMJ8lx624s+EX+kzeH8psxqp4ilE0qJoYQLYo/KvMsJ7uXuiL
         manQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dl8GIEMbBKkzS5rQAvz8tepJOPKmthy0Oi9cCtTLcnI=;
        b=7OXt2btL6UQRZi3W2QDI/gtou+wli0GCNfEqE/820Nj89LK5MVlqGdIB1nHqExhZXz
         3RgQIIbl6oTJ18agVJbdAJzLrhgNZNBsgqKR1BIweafQOMt876eDG3uXtvkXuhqIBmyQ
         3P7AFOUyG/NEUl3cxcRz7GTjim+UqepEyhoIyG7Tq06QhbWuAd5JNkaO8St9KTSu/C0O
         Pr2B+uo4DBImD27XNfXjgpy9hHWxLHKsfcuN++XscL3YMDb46cqL8gRbINFoK5XcLKVm
         Qr0YbIsLQ8izfKFouYk//ynmFvFG8IFjyXW9plsZyPdHi5Qf1u2HgUXpN/karVBXNJOe
         hSNQ==
X-Gm-Message-State: AO0yUKUgLpV+Tfigh1h1Rm+00+PQGe/AIvS1sOLvIzWaFSEpI70YyNz2
        opewyDNJ0mEwnMv9CAhsHabfpScxcMMtn6s=
X-Google-Smtp-Source: AK7set9R5djSIz2vXMUzAH159T8SRqjES1NwbhzrCEKr8XqebzW8Are5GBihdhPvdF7La15hnJguIQ==
X-Received: by 2002:a05:622a:ce:b0:3b8:49bb:16c3 with SMTP id p14-20020a05622a00ce00b003b849bb16c3mr14511651qtw.28.1676604390024;
        Thu, 16 Feb 2023 19:26:30 -0800 (PST)
Received: from localhost (pool-108-26-161-203.bstnma.fios.verizon.net. [108.26.161.203])
        by smtp.gmail.com with ESMTPSA id i65-20020a37b844000000b00705cef9b84asm2398295qkf.131.2023.02.16.19.26.29
        for <linux-security-module@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Feb 2023 19:26:29 -0800 (PST)
From:   Paul Moore <paul@paul-moore.com>
To:     linux-security-module@vger.kernel.org
Subject: [PATCH 01/22] lsm: move the program execution hook comments to security/security.c
Date:   Thu, 16 Feb 2023 22:26:04 -0500
Message-Id: <20230217032625.678457-2-paul@paul-moore.com>
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
 include/linux/lsm_hooks.h | 52 -----------------------------
 security/security.c       | 69 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 69 insertions(+), 52 deletions(-)

diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index 0a5ba81f7367..24c242713a44 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -32,58 +32,6 @@
 /**
  * union security_list_options - Linux Security Module hook function list
  *
- * Security hooks for program execution operations.
- *
- * @bprm_creds_for_exec:
- *	If the setup in prepare_exec_creds did not setup @bprm->cred->security
- *	properly for executing @bprm->file, update the LSM's portion of
- *	@bprm->cred->security to be what commit_creds needs to install for the
- *	new program.  This hook may also optionally check permissions
- *	(e.g. for transitions between security domains).
- *	The hook must set @bprm->secureexec to 1 if AT_SECURE should be set to
- *	request libc enable secure mode.
- *	@bprm contains the linux_binprm structure.
- *	Return 0 if the hook is successful and permission is granted.
- * @bprm_creds_from_file:
- *	If @file is setpcap, suid, sgid or otherwise marked to change
- *	privilege upon exec, update @bprm->cred to reflect that change.
- *	This is called after finding the binary that will be executed.
- *	without an interpreter.  This ensures that the credentials will not
- *	be derived from a script that the binary will need to reopen, which
- *	when reopend may end up being a completely different file.  This
- *	hook may also optionally check permissions (e.g. for transitions
- *	between security domains).
- *	The hook must set @bprm->secureexec to 1 if AT_SECURE should be set to
- *	request libc enable secure mode.
- *	The hook must add to @bprm->per_clear any personality flags that
- * 	should be cleared from current->personality.
- *	@bprm contains the linux_binprm structure.
- *	Return 0 if the hook is successful and permission is granted.
- * @bprm_check_security:
- *	This hook mediates the point when a search for a binary handler will
- *	begin.  It allows a check against the @bprm->cred->security value
- *	which was set in the preceding creds_for_exec call.  The argv list and
- *	envp list are reliably available in @bprm.  This hook may be called
- *	multiple times during a single execve.
- *	@bprm contains the linux_binprm structure.
- *	Return 0 if the hook is successful and permission is granted.
- * @bprm_committing_creds:
- *	Prepare to install the new security attributes of a process being
- *	transformed by an execve operation, based on the old credentials
- *	pointed to by @current->cred and the information set in @bprm->cred by
- *	the bprm_creds_for_exec hook.  @bprm points to the linux_binprm
- *	structure.  This hook is a good place to perform state changes on the
- *	process such as closing open file descriptors to which access will no
- *	longer be granted when the attributes are changed.  This is called
- *	immediately before commit_creds().
- * @bprm_committed_creds:
- *	Tidy up after the installation of the new security attributes of a
- *	process being transformed by an execve operation.  The new credentials
- *	have, by this point, been set to @current->cred.  @bprm points to the
- *	linux_binprm structure.  This hook is a good place to perform state
- *	changes on the process such as clearing out non-inheritable signal
- *	state.  This is called immediately after commit_creds().
- *
  * Security hooks for mount using fs_context.
  *	[See also Documentation/filesystems/mount_api.rst]
  *
diff --git a/security/security.c b/security/security.c
index d1571900a8c7..9e98f6703e18 100644
--- a/security/security.c
+++ b/security/security.c
@@ -6,6 +6,7 @@
  * Copyright (C) 2001-2002 Greg Kroah-Hartman <greg@kroah.com>
  * Copyright (C) 2001 Networks Associates Technology, Inc <ssmalley@nai.com>
  * Copyright (C) 2016 Mellanox Technologies
+ * Copyright (C) 2023 Microsoft Corporation <paul@paul-moore.com>
  */
 
 #define pr_fmt(fmt) "LSM: " fmt
@@ -880,16 +881,61 @@ int security_vm_enough_memory_mm(struct mm_struct *mm, long pages)
 	return __vm_enough_memory(mm, pages, cap_sys_admin);
 }
 
+/**
+ * security_bprm_creds_for_exec() - Prepare the credentials for exec()
+ * @bprm: binary program information
+ *
+ * If the setup in prepare_exec_creds did not setup @bprm->cred->security
+ * properly for executing @bprm->file, update the LSM's portion of
+ * @bprm->cred->security to be what commit_creds needs to install for the new
+ * program.  This hook may also optionally check permissions (e.g. for
+ * transitions between security domains).  The hook must set @bprm->secureexec
+ * to 1 if AT_SECURE should be set to request libc enable secure mode.  @bprm
+ * contains the linux_binprm structure.
+ *
+ * Return: Returns 0 if the hook is successful and permission is granted.
+ */
 int security_bprm_creds_for_exec(struct linux_binprm *bprm)
 {
 	return call_int_hook(bprm_creds_for_exec, 0, bprm);
 }
 
+/**
+ * security_bprm_creds_from_file() - Update linux_binprm creds based on file
+ * @bprm: binary program information
+ * @file: associated file
+ *
+ * If @file is setpcap, suid, sgid or otherwise marked to change privilege upon
+ * exec, update @bprm->cred to reflect that change. This is called after
+ * finding the binary that will be executed without an interpreter.  This
+ * ensures that the credentials will not be derived from a script that the
+ * binary will need to reopen, which when reopend may end up being a completely
+ * different file.  This hook may also optionally check permissions (e.g. for
+ * transitions between security domains).  The hook must set @bprm->secureexec
+ * to 1 if AT_SECURE should be set to request libc enable secure mode.  The
+ * hook must add to @bprm->per_clear any personality flags that should be
+ * cleared from current->personality.  @bprm contains the linux_binprm
+ * structure.
+ *
+ * Return: Returns 0 if the hook is successful and permission is granted.
+ */
 int security_bprm_creds_from_file(struct linux_binprm *bprm, struct file *file)
 {
 	return call_int_hook(bprm_creds_from_file, 0, bprm, file);
 }
 
+/**
+ * security_bprm_check() - Mediate binary handler search
+ * @bprm: binary program information
+ *
+ * This hook mediates the point when a search for a binary handler will begin.
+ * It allows a check against the @bprm->cred->security value which was set in
+ * the preceding creds_for_exec call.  The argv list and envp list are reliably
+ * available in @bprm.  This hook may be called multiple times during a single
+ * execve.  @bprm contains the linux_binprm structure.
+ *
+ * Return: Returns 0 if the hook is successful and permission is granted.
+ */
 int security_bprm_check(struct linux_binprm *bprm)
 {
 	int ret;
@@ -900,11 +946,34 @@ int security_bprm_check(struct linux_binprm *bprm)
 	return ima_bprm_check(bprm);
 }
 
+/**
+ * security_bprm_committing_creds() - Install creds for a process during exec()
+ * @bprm: binary program information
+ *
+ * Prepare to install the new security attributes of a process being
+ * transformed by an execve operation, based on the old credentials pointed to
+ * by @current->cred and the information set in @bprm->cred by the
+ * bprm_creds_for_exec hook.  @bprm points to the linux_binprm structure.  This
+ * hook is a good place to perform state changes on the process such as closing
+ * open file descriptors to which access will no longer be granted when the
+ * attributes are changed.  This is called immediately before commit_creds().
+ */
 void security_bprm_committing_creds(struct linux_binprm *bprm)
 {
 	call_void_hook(bprm_committing_creds, bprm);
 }
 
+/**
+ * security_bprm_committed_creds() - Tidy up after cred install during exec()
+ * @bprm: binary program information
+ *
+ * Tidy up after the installation of the new security attributes of a process
+ * being transformed by an execve operation.  The new credentials have, by this
+ * point, been set to @current->cred.  @bprm points to the linux_binprm
+ * structure.  This hook is a good place to perform state changes on the
+ * process such as clearing out non-inheritable signal state.  This is called
+ * immediately after commit_creds().
+ */
 void security_bprm_committed_creds(struct linux_binprm *bprm)
 {
 	call_void_hook(bprm_committed_creds, bprm);
-- 
2.39.2

