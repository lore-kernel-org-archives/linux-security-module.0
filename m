Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F169C64EC4
	for <linux-security-module@archiver.kernel.org>; Wed,  8 Mar 2023 18:28:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229456AbjCHS2K (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 8 Mar 2023 13:28:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230028AbjCHS2I (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 8 Mar 2023 13:28:08 -0500
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12CF710432
        for <linux-security-module@vger.kernel.org>; Wed,  8 Mar 2023 10:28:05 -0800 (PST)
Received: by mail-qt1-x82d.google.com with SMTP id c3so19079991qtc.8
        for <linux-security-module@vger.kernel.org>; Wed, 08 Mar 2023 10:28:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1678300084;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=nyMeMTN/k0IbBhzVgQibikni6EeLKP8gpYMu4eIGsJc=;
        b=KTX6mB2GIFXLkkmBA4jsYC3PBJF2FigeRJksiG+BYsELieWbuUVzburZQD3mSZ68ER
         /c9adWl5EzMCaVb3eWeFzN+Y4MCYyIB1QI0/h2yPFgV4WkIkFETnZQMPr0UoBg4Tqc8l
         rFJwgqOCW+ATpVYGmcZHszFu7k1d3r6b4+7uq4dwWNDX99LRYh1215WM1jPKQ3qUSPI2
         YasfLTGPhnojcyD3u8m/EZmN2ul7LgqZq3gJpNOEIll5IK/gvALa23oPKQIimMB9kgQd
         +U2NU8GFlJr5MiOOsZL1XRmFLZD1VAtFPAgTCkFby02QmoLgJ1wx++gfLgPj+eZpifOp
         kNpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678300084;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nyMeMTN/k0IbBhzVgQibikni6EeLKP8gpYMu4eIGsJc=;
        b=6gt2B7sN3JhmvOcMehE70/xKupZRYZfPHicuDoWKqTRp3dU+Ax4CUd5Ca0unrA90Z7
         6TCK1ZTD363Yg93llLCeslW3DMCU2GznvG6ZkkNXetSgljvK0An2NOliw5oqHVaWv1t3
         u7ymZLPq/OEq+BIDzpQ4ObiDBsQdUIG8w8MTniYVLJuVuZO9BDhuYGPcPeU1cVar5rsS
         H0OIOh6lrdLZNx9L6QVHuuxJ8RuOXmpUHCcSP31XJTUKtY2uwmsfvzJhC9nlJb3ZUYWf
         eOgBtd6v66Yq25wLTEw2umx6KaFLdHx3NSVrCXgQN3STBbWbiNkPHN57znSrDtH9+BJu
         6qlQ==
X-Gm-Message-State: AO0yUKX4Ky9q0DyPjC+yzOnSMgIsp0sjN1nizZBBYo5E5LUq/b1o1Vg9
        aWzZHWl2nyoxKmMnAgKMd9ZMshJWYD1KuR9lMQ==
X-Google-Smtp-Source: AK7set+6obqzrAXlR3y1cWDIPNfP3B5l7ena0cRan1OqL6nDhKJ3NCWPC9B+4IKV3aCUX5RIbFh8Lw==
X-Received: by 2002:ac8:5b95:0:b0:3b6:8b52:1359 with SMTP id a21-20020ac85b95000000b003b68b521359mr32696425qta.0.1678300083598;
        Wed, 08 Mar 2023 10:28:03 -0800 (PST)
Received: from localhost (pool-108-26-161-203.bstnma.fios.verizon.net. [108.26.161.203])
        by smtp.gmail.com with ESMTPSA id m18-20020ac866d2000000b003bfbfd9a4aesm11957138qtp.56.2023.03.08.10.28.02
        for <linux-security-module@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Mar 2023 10:28:02 -0800 (PST)
From:   Paul Moore <paul@paul-moore.com>
To:     linux-security-module@vger.kernel.org
Subject: [PATCH] lsm: fix doc warnings in the LSM hook comments
Date:   Wed,  8 Mar 2023 13:28:02 -0500
Message-Id: <20230308182802.195662-1-paul@paul-moore.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Signed-off-by: Paul Moore <paul@paul-moore.com>
---
 security/security.c | 33 +++++++++++++++++----------------
 1 file changed, 17 insertions(+), 16 deletions(-)

diff --git a/security/security.c b/security/security.c
index f6482fd7b4b9..4c39cfe313bf 100644
--- a/security/security.c
+++ b/security/security.c
@@ -1228,7 +1228,7 @@ void security_sb_free(struct super_block *sb)
 
 /**
  * security_free_mnt_opts() - Free memory associated with mount options
- * @mnt_ops: LSM processed mount options
+ * @mnt_opts: LSM processed mount options
  *
  * Free memory associated with @mnt_ops.
  */
@@ -1244,7 +1244,7 @@ EXPORT_SYMBOL(security_free_mnt_opts);
 /**
  * security_sb_eat_lsm_opts() - Consume LSM mount options
  * @options: mount options
- * @mnt_ops: LSM processed mount options
+ * @mnt_opts: LSM processed mount options
  *
  * Eat (scan @options) and save them in @mnt_opts.
  *
@@ -1407,8 +1407,8 @@ EXPORT_SYMBOL(security_sb_set_mnt_opts);
 
 /**
  * security_sb_clone_mnt_opts() - Duplicate superblock mount options
- * @olddb: source superblock
- * @newdb: destination superblock
+ * @oldsb: source superblock
+ * @newsb: destination superblock
  * @kern_flags: kernel flags (in)
  * @set_kern_flags: kernel flags (out)
  *
@@ -1916,7 +1916,7 @@ int security_inode_unlink(struct inode *dir, struct dentry *dentry)
 }
 
 /**
- * security_inode_symlink() Check if creating a symbolic link is allowed
+ * security_inode_symlink() - Check if creating a symbolic link is allowed
  * @dir: parent directory
  * @dentry: symbolic link
  * @old_name: existing filename
@@ -2125,6 +2125,7 @@ int security_inode_getattr(const struct path *path)
  * @dentry: file
  * @name: xattr name
  * @value: xattr value
+ * @size: size of xattr value
  * @flags: flags
  *
  * Check permission before setting the extended attributes.
@@ -2686,7 +2687,7 @@ int security_mmap_addr(unsigned long addr)
  * security_file_mprotect() - Check if changing memory protections is allowed
  * @vma: memory region
  * @reqprot: application requested protection
- * @prog: protection applied by the kernel
+ * @prot: protection applied by the kernel
  *
  * Check permissions before changing memory access permissions.
  *
@@ -3421,7 +3422,7 @@ int security_create_user_ns(const struct cred *cred)
 /**
  * security_ipc_permission() - Check if sysv ipc access is allowed
  * @ipcp: ipc permission structure
- * @flags: requested permissions
+ * @flag: requested permissions
  *
  * Check permissions for access to IPC.
  *
@@ -3718,7 +3719,7 @@ int security_sem_associate(struct kern_ipc_perm *sma, int semflg)
 }
 
 /**
- * security_sem_ctl() - Check if a sysv semaphore operation is allowed
+ * security_sem_semctl() - Check if a sysv semaphore operation is allowed
  * @sma: sysv ipc permission structure
  * @cmd: operation
  *
@@ -4088,7 +4089,7 @@ int security_socket_create(int family, int type, int protocol, int kern)
 }
 
 /**
- * security_socket_create() - Initialize a newly created socket
+ * security_socket_post_create() - Initialize a newly created socket
  * @sock: socket
  * @family: protocol family
  * @type: communications type
@@ -4364,7 +4365,7 @@ EXPORT_SYMBOL(security_socket_getpeersec_dgram);
  * security_sk_alloc() - Allocate and initialize a sock's LSM blob
  * @sk: sock
  * @family: protocol family
- * @priotity: gfp flags
+ * @priority: gfp flags
  *
  * Allocate and attach a security structure to the sk->sk_security field, which
  * is used to copy security attributes between local stream sockets.
@@ -4423,10 +4424,10 @@ EXPORT_SYMBOL(security_req_classify_flow);
 /**
  * security_sock_graft() - Reconcile LSM state when grafting a sock on a socket
  * @sk: sock being grafted
- * @sock: target socket
+ * @parent: target parent socket
  *
- * Sets @sock's inode secid to @sk's secid and update @sk with any necessary
- * LSM state from @sock.
+ * Sets @parent's inode secid to @sk's secid and update @sk with any necessary
+ * LSM state from @parent.
  */
 void security_sock_graft(struct sock *sk, struct socket *parent)
 {
@@ -4877,7 +4878,7 @@ int security_xfrm_policy_lookup(struct xfrm_sec_ctx *ctx, u32 fl_secid)
 /**
  * security_xfrm_state_pol_flow_match() - Check for a xfrm match
  * @x: xfrm state to match
- * @xp xfrm policy to check for a match
+ * @xp: xfrm policy to check for a match
  * @flic: flow to check for a match.
  *
  * Check @xp and @flic for a match with @x.
@@ -4980,13 +4981,13 @@ int security_key_permission(key_ref_t key_ref, const struct cred *cred,
 /**
  * security_key_getsecurity() - Get the key's security label
  * @key: key
- * @buffer: security label buffer
+ * @_buffer: security label buffer
  *
  * Get a textual representation of the security context attached to a key for
  * the purposes of honouring KEYCTL_GETSECURITY.  This function allocates the
  * storage for the NUL-terminated string and the caller should free it.
  *
- * Return: Returns the length of @buffer (including terminating NUL) or -ve if
+ * Return: Returns the length of @_buffer (including terminating NUL) or -ve if
  *         an error occurs.  May also return 0 (and a NULL buffer pointer) if
  *         there is no security label assigned to the key.
  */
-- 
2.39.2

