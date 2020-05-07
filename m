Return-Path: <SRS0=9z6D=6V=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.2 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DA0BC35280
	for <linux-security-module@archiver.kernel.org>; Thu,  7 May 2020 23:45:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EE292208E4
	for <linux-security-module@archiver.kernel.org>; Thu,  7 May 2020 23:45:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726480AbgEGXpR (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 7 May 2020 19:45:17 -0400
Received: from namei.org ([65.99.196.166]:57630 "EHLO namei.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726476AbgEGXpR (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 7 May 2020 19:45:17 -0400
Received: from localhost (localhost [127.0.0.1])
        by namei.org (8.14.4/8.14.4) with ESMTP id 047NjBCx016267;
        Thu, 7 May 2020 23:45:11 GMT
Date:   Fri, 8 May 2020 09:45:11 +1000 (AEST)
From:   James Morris <jmorris@namei.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
cc:     linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, KP Singh <kpsingh@google.com>
Subject: [GIT PULL] security: Fix the default value of fs_context_parse_param
 hook
Message-ID: <alpine.LRH.2.21.2005080942390.15191@namei.org>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Please pull this fix from KP Singh (several folks are reporting issues 
around this):

The following changes since commit c45e8bccecaf633480d378daff11e122dfd5e96d:

  Merge tag 'for-5.7/dm-fixes-2' of git://git.kernel.org/pub/scm/linux/kernel/git/device-mapper/linux-dm (2020-04-30 16:45:08 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jmorris/linux-security.git for-v5.7

for you to fetch changes up to 54261af473be4c5481f6196064445d2945f2bdab:

  security: Fix the default value of fs_context_parse_param hook (2020-04-30 20:29:34 -0700)

----------------------------------------------------------------
KP Singh (1):
      security: Fix the default value of fs_context_parse_param hook

 include/linux/lsm_hook_defs.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

---

commit 54261af473be4c5481f6196064445d2945f2bdab
Author: KP Singh <kpsingh@google.com>
Date:   Thu Apr 30 17:52:40 2020 +0200

    security: Fix the default value of fs_context_parse_param hook
    
    security_fs_context_parse_param is called by vfs_parse_fs_param and
    a succussful return value (i.e 0) implies that a parameter will be
    consumed by the LSM framework. This stops all further parsing of the
    parmeter by VFS. Furthermore, if an LSM hook returns a success, the
    remaining LSM hooks are not invoked for the parameter.
    
    The current default behavior of returning success means that all the
    parameters are expected to be parsed by the LSM hook and none of them
    end up being populated by vfs in fs_context
    
    This was noticed when lsm=bpf is supplied on the command line before any
    other LSM. As the bpf lsm uses this default value to implement a default
    hook, this resulted in a failure to parse any fs_context parameters and
    a failure to mount the root filesystem.
    
    Fixes: 98e828a0650f ("security: Refactor declaration of LSM hooks")
    Reported-by: Mikko Ylinen <mikko.ylinen@linux.intel.com>
    Signed-off-by: KP Singh <kpsingh@google.com>
    Signed-off-by: James Morris <jmorris@namei.org>

diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.h
index 9cd4455528e5..1bdd027766d4 100644
--- a/include/linux/lsm_hook_defs.h
+++ b/include/linux/lsm_hook_defs.h
@@ -55,7 +55,7 @@ LSM_HOOK(void, LSM_RET_VOID, bprm_committing_creds, struct linux_binprm *bprm)
 LSM_HOOK(void, LSM_RET_VOID, bprm_committed_creds, struct linux_binprm *bprm)
 LSM_HOOK(int, 0, fs_context_dup, struct fs_context *fc,
 	 struct fs_context *src_sc)
-LSM_HOOK(int, 0, fs_context_parse_param, struct fs_context *fc,
+LSM_HOOK(int, -ENOPARAM, fs_context_parse_param, struct fs_context *fc,
 	 struct fs_parameter *param)
 LSM_HOOK(int, 0, sb_alloc_security, struct super_block *sb)
 LSM_HOOK(void, LSM_RET_VOID, sb_free_security, struct super_block *sb)
