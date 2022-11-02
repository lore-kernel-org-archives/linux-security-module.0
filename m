Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D6B5C4332F
	for <linux-security-module@archiver.kernel.org>; Wed,  2 Nov 2022 17:29:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231590AbiKBR36 (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 2 Nov 2022 13:29:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231588AbiKBR3t (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 2 Nov 2022 13:29:49 -0400
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 402F25FDD
        for <linux-security-module@vger.kernel.org>; Wed,  2 Nov 2022 10:29:45 -0700 (PDT)
Received: from fsav312.sakura.ne.jp (fsav312.sakura.ne.jp [153.120.85.143])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 2A2HTUQh025066;
        Thu, 3 Nov 2022 02:29:30 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav312.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav312.sakura.ne.jp);
 Thu, 03 Nov 2022 02:29:30 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav312.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 2A2HTTuN025062
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 3 Nov 2022 02:29:30 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <5ab69bca-866e-c389-b46b-795f7308db35@I-love.SAKURA.ne.jp>
Date:   Thu, 3 Nov 2022 02:29:28 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: [PATCH 6a/10] CaitSith: Add policy management functions.
Content-Language: en-US
To:     linux-security-module@vger.kernel.org,
        Casey Schaufler <casey@schaufler-ca.com>,
        Paul Moore <paul@paul-moore.com>,
        John Johansen <john.johansen@canonical.com>,
        Kees Cook <kees@kernel.org>
References: <20221102171025.126961-1-penguin-kernel@I-love.SAKURA.ne.jp>
 <20221102171025.126961-6-penguin-kernel@I-love.SAKURA.ne.jp>
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <20221102171025.126961-6-penguin-kernel@I-love.SAKURA.ne.jp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

This file implements similar functions provided by security/tomoyo/common.c
and security/tomoyo/securityfs_if.c files.

Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
---
Reposting "[PATCH 06/10] CaitSith: Add policy management functions." as two patches due to
"BOUNCE linux-security-module@vger.kernel.org: Message too long (>100000 chars)" failure.
This is the former part.

 security/caitsith/policy_io.c | 1901 +++++++++++++++++++++++++++++++++
 1 file changed, 1901 insertions(+)
 create mode 100644 security/caitsith/policy_io.c

diff --git a/security/caitsith/policy_io.c b/security/caitsith/policy_io.c
new file mode 100644
index 000000000000..27e2ec57f3b8
--- /dev/null
+++ b/security/caitsith/policy_io.c
@@ -0,0 +1,1901 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * policy_io.c
+ *
+ * Copyright (C) 2005-2012  NTT DATA CORPORATION
+ *
+ * Version: 0.2.10   2021/06/06
+ */
+
+#include "caitsith.h"
+
+/***** SECTION1: Constants definition *****/
+
+/* Define this to enable debug mode. */
+/* #define DEBUG_CONDITION */
+
+#ifdef DEBUG_CONDITION
+#define dprintk printk
+#else
+#define dprintk(...) do { } while (0)
+#endif
+
+/* String table for operation. */
+static const char * const cs_mac_keywords[CS_MAX_MAC_INDEX] = {
+	[CS_MAC_EXECUTE]    = "execute",
+	[CS_MAC_READ]       = "read",
+	[CS_MAC_WRITE]      = "write",
+	[CS_MAC_APPEND]     = "append",
+	[CS_MAC_CREATE]     = "create",
+	[CS_MAC_UNLINK]     = "unlink",
+#ifdef CONFIG_SECURITY_CAITSITH_GETATTR
+	[CS_MAC_GETATTR]    = "getattr",
+#endif
+	[CS_MAC_MKDIR]      = "mkdir",
+	[CS_MAC_RMDIR]      = "rmdir",
+	[CS_MAC_MKFIFO]     = "mkfifo",
+	[CS_MAC_MKSOCK]     = "mksock",
+	[CS_MAC_TRUNCATE]   = "truncate",
+	[CS_MAC_SYMLINK]    = "symlink",
+	[CS_MAC_MKBLOCK]    = "mkblock",
+	[CS_MAC_MKCHAR]     = "mkchar",
+	[CS_MAC_LINK]       = "link",
+	[CS_MAC_RENAME]     = "rename",
+	[CS_MAC_CHMOD]      = "chmod",
+	[CS_MAC_CHOWN]      = "chown",
+	[CS_MAC_CHGRP]      = "chgrp",
+	[CS_MAC_IOCTL]      = "ioctl",
+	[CS_MAC_CHROOT]     = "chroot",
+	[CS_MAC_MOUNT]      = "mount",
+	[CS_MAC_UMOUNT]     = "unmount",
+	[CS_MAC_PIVOT_ROOT] = "pivot_root",
+#ifdef CONFIG_SECURITY_CAITSITH_NETWORK
+	[CS_MAC_INET_STREAM_BIND]       = "inet_stream_bind",
+	[CS_MAC_INET_STREAM_LISTEN]     = "inet_stream_listen",
+	[CS_MAC_INET_STREAM_CONNECT]    = "inet_stream_connect",
+	[CS_MAC_INET_STREAM_ACCEPT]     = "inet_stream_accept",
+	[CS_MAC_INET_DGRAM_BIND]        = "inet_dgram_bind",
+	[CS_MAC_INET_DGRAM_SEND]        = "inet_dgram_send",
+	[CS_MAC_INET_RAW_BIND]          = "inet_raw_bind",
+	[CS_MAC_INET_RAW_SEND]          = "inet_raw_send",
+	[CS_MAC_UNIX_STREAM_BIND]       = "unix_stream_bind",
+	[CS_MAC_UNIX_STREAM_LISTEN]     = "unix_stream_listen",
+	[CS_MAC_UNIX_STREAM_CONNECT]    = "unix_stream_connect",
+	[CS_MAC_UNIX_STREAM_ACCEPT]     = "unix_stream_accept",
+	[CS_MAC_UNIX_DGRAM_BIND]        = "unix_dgram_bind",
+	[CS_MAC_UNIX_DGRAM_SEND]        = "unix_dgram_send",
+	[CS_MAC_UNIX_SEQPACKET_BIND]    = "unix_seqpacket_bind",
+	[CS_MAC_UNIX_SEQPACKET_LISTEN]  = "unix_seqpacket_listen",
+	[CS_MAC_UNIX_SEQPACKET_CONNECT] = "unix_seqpacket_connect",
+	[CS_MAC_UNIX_SEQPACKET_ACCEPT]  = "unix_seqpacket_accept",
+#endif
+#ifdef CONFIG_SECURITY_CAITSITH_ENVIRON
+	[CS_MAC_ENVIRON] = "environ",
+#endif
+	[CS_MAC_MODIFY_POLICY]      = "modify_policy",
+#ifdef CONFIG_SECURITY_CAITSITH_CAPABILITY
+	[CS_MAC_USE_NETLINK_SOCKET] = "use_netlink_socket",
+	[CS_MAC_USE_PACKET_SOCKET]  = "use_packet_socket",
+#endif
+#ifdef CONFIG_SECURITY_CAITSITH_AUTO_DOMAIN_TRANSITION
+	[CS_MAC_AUTO_DOMAIN_TRANSITION]   = "auto_domain_transition",
+#endif
+#ifdef CONFIG_SECURITY_CAITSITH_MANUAL_DOMAIN_TRANSITION
+	[CS_MAC_MANUAL_DOMAIN_TRANSITION] = "manual_domain_transition",
+#endif
+};
+
+/* String table for grouping keywords. */
+static const char * const cs_group_name[CS_MAX_GROUP] = {
+	[CS_STRING_GROUP] = "string_group",
+	[CS_NUMBER_GROUP] = "number_group",
+#ifdef CONFIG_SECURITY_CAITSITH_NETWORK
+	[CS_IP_GROUP]     = "ip_group",
+#endif
+};
+
+/* String table for stat info. */
+static const char * const cs_memory_headers[CS_MAX_MEMORY_STAT] = {
+	[CS_MEMORY_POLICY] = "policy",
+	[CS_MEMORY_AUDIT]  = "audit",
+	[CS_MEMORY_QUERY]  = "query",
+};
+
+#define F(bit) (1ULL << bit)
+
+#define CS_ALL_OK				\
+	(F(CS_MAC_EXECUTE) |			\
+	 F(CS_MAC_READ) |			\
+	 F(CS_MAC_WRITE) |			\
+	 F(CS_MAC_APPEND) |			\
+	 F(CS_MAC_CREATE) |			\
+	 F(CS_MAC_UNLINK) |			\
+	 F(CS_MAC_GETATTR) |			\
+	 F(CS_MAC_MKDIR) |			\
+	 F(CS_MAC_RMDIR) |			\
+	 F(CS_MAC_MKFIFO) |			\
+	 F(CS_MAC_MKSOCK) |			\
+	 F(CS_MAC_TRUNCATE) |			\
+	 F(CS_MAC_SYMLINK) |			\
+	 F(CS_MAC_MKBLOCK) |			\
+	 F(CS_MAC_MKCHAR) |			\
+	 F(CS_MAC_LINK) |			\
+	 F(CS_MAC_RENAME) |			\
+	 F(CS_MAC_CHMOD) |			\
+	 F(CS_MAC_CHOWN) |			\
+	 F(CS_MAC_CHGRP) |			\
+	 F(CS_MAC_IOCTL) |			\
+	 F(CS_MAC_CHROOT) |			\
+	 F(CS_MAC_MOUNT) |			\
+	 F(CS_MAC_UMOUNT) |			\
+	 F(CS_MAC_PIVOT_ROOT) |			\
+	 F(CS_MAC_INET_STREAM_BIND) |		\
+	 F(CS_MAC_INET_STREAM_LISTEN) |		\
+	 F(CS_MAC_INET_STREAM_CONNECT) |	\
+	 F(CS_MAC_INET_STREAM_ACCEPT) |		\
+	 F(CS_MAC_INET_DGRAM_BIND) |		\
+	 F(CS_MAC_INET_DGRAM_SEND) |		\
+	 F(CS_MAC_INET_RAW_BIND) |		\
+	 F(CS_MAC_INET_RAW_SEND) |		\
+	 F(CS_MAC_UNIX_STREAM_BIND) |		\
+	 F(CS_MAC_UNIX_STREAM_LISTEN) |		\
+	 F(CS_MAC_UNIX_STREAM_CONNECT) |	\
+	 F(CS_MAC_UNIX_STREAM_ACCEPT) |		\
+	 F(CS_MAC_UNIX_DGRAM_BIND) |		\
+	 F(CS_MAC_UNIX_DGRAM_SEND) |		\
+	 F(CS_MAC_UNIX_SEQPACKET_BIND) |	\
+	 F(CS_MAC_UNIX_SEQPACKET_LISTEN) |	\
+	 F(CS_MAC_UNIX_SEQPACKET_CONNECT) |	\
+	 F(CS_MAC_UNIX_SEQPACKET_ACCEPT) |	\
+	 F(CS_MAC_ENVIRON) |			\
+	 F(CS_MAC_MODIFY_POLICY) |		\
+	 F(CS_MAC_USE_NETLINK_SOCKET) |		\
+	 F(CS_MAC_USE_PACKET_SOCKET) |		\
+	 F(CS_MAC_AUTO_DOMAIN_TRANSITION) |	\
+	 F(CS_MAC_MANUAL_DOMAIN_TRANSITION))
+
+#define CS_PATH_SELF_OK				\
+	(F(CS_MAC_EXECUTE) |			\
+	 F(CS_MAC_READ) |			\
+	 F(CS_MAC_WRITE) |			\
+	 F(CS_MAC_APPEND) |			\
+	 F(CS_MAC_UNLINK) |			\
+	 F(CS_MAC_GETATTR) |			\
+	 F(CS_MAC_RMDIR) |			\
+	 F(CS_MAC_TRUNCATE) |			\
+	 F(CS_MAC_CHMOD) |			\
+	 F(CS_MAC_CHOWN) |			\
+	 F(CS_MAC_CHGRP) |			\
+	 F(CS_MAC_IOCTL) |			\
+	 F(CS_MAC_CHROOT) |			\
+	 F(CS_MAC_UMOUNT) |			\
+	 F(CS_MAC_ENVIRON))
+
+#define CS_PATH_PARENT_OK			\
+	(F(CS_MAC_CREATE) |			\
+	 F(CS_MAC_MKDIR) |			\
+	 F(CS_MAC_MKFIFO) |			\
+	 F(CS_MAC_MKSOCK) |			\
+	 F(CS_MAC_SYMLINK) |			\
+	 F(CS_MAC_MKBLOCK) |			\
+	 F(CS_MAC_MKCHAR))
+
+#define CS_PATH_OK (CS_PATH_SELF_OK | CS_PATH_PARENT_OK)
+
+#define CS_RENAME_OR_LINK_OK (F(CS_MAC_LINK) | F(CS_MAC_RENAME))
+
+#define CS_EXECUTE_OR_ENVIRON_OK (F(CS_MAC_EXECUTE) | F(CS_MAC_ENVIRON))
+
+#define CS_MKDEV_OK (F(CS_MAC_MKBLOCK) | F(CS_MAC_MKCHAR))
+
+#define CS_PATH_PERM_OK				\
+	(F(CS_MAC_MKDIR) |			\
+	 F(CS_MAC_MKBLOCK) |			\
+	 F(CS_MAC_MKCHAR) |			\
+	 F(CS_MAC_MKFIFO) |			\
+	 F(CS_MAC_MKSOCK) |			\
+	 F(CS_MAC_CREATE) |			\
+	 F(CS_MAC_CHMOD))
+
+#define CS_IP_SOCKET_OK				\
+	(F(CS_MAC_INET_STREAM_BIND) |		\
+	 F(CS_MAC_INET_STREAM_LISTEN) |		\
+	 F(CS_MAC_INET_STREAM_CONNECT) |	\
+	 F(CS_MAC_INET_STREAM_ACCEPT) |		\
+	 F(CS_MAC_INET_DGRAM_BIND) |		\
+	 F(CS_MAC_INET_DGRAM_SEND))
+
+#define CS_RAW_SOCKET_OK			\
+	(F(CS_MAC_INET_RAW_BIND) |		\
+	 F(CS_MAC_INET_RAW_SEND))
+
+#define CS_INET_SOCKET_OK (CS_IP_SOCKET_OK | CS_RAW_SOCKET_OK)
+
+#define CS_UNIX_SOCKET_OK			\
+	(F(CS_MAC_UNIX_STREAM_BIND) |		\
+	 F(CS_MAC_UNIX_STREAM_LISTEN) |		\
+	 F(CS_MAC_UNIX_STREAM_CONNECT) |	\
+	 F(CS_MAC_UNIX_STREAM_ACCEPT) |		\
+	 F(CS_MAC_UNIX_DGRAM_BIND) |		\
+	 F(CS_MAC_UNIX_DGRAM_SEND) |		\
+	 F(CS_MAC_UNIX_SEQPACKET_BIND) |	\
+	 F(CS_MAC_UNIX_SEQPACKET_LISTEN) |	\
+	 F(CS_MAC_UNIX_SEQPACKET_CONNECT) |	\
+	 F(CS_MAC_UNIX_SEQPACKET_ACCEPT))
+
+enum cs_var_type {
+	CS_TYPE_INVALID,
+	CS_TYPE_NUMBER,
+	CS_TYPE_STRING,
+	CS_TYPE_IPADDR,
+	CS_TYPE_FILEPERM,
+	CS_TYPE_FILETYPE,
+	CS_TYPE_ASSIGN,
+} __packed;
+
+/* String table for conditions. */
+static const struct {
+	const char * const keyword;
+	const enum cs_var_type left_type;
+	const enum cs_var_type right_type;
+	const enum cs_conditions_index cmd;
+	const u64 available;
+} cs_conditions[] = {
+	{ "addr",                    CS_TYPE_STRING,   CS_TYPE_STRING,
+	  CS_COND_SARG0,            CS_UNIX_SOCKET_OK },
+	{ "argc",                    CS_TYPE_NUMBER,   CS_TYPE_NUMBER,
+	  CS_EXEC_ARGC,             CS_EXECUTE_OR_ENVIRON_OK },
+	{ "block",                   CS_TYPE_INVALID,  CS_TYPE_FILETYPE,
+	  CS_OBJ_IS_BLOCK_DEV,      CS_ALL_OK },
+	{ "char",                    CS_TYPE_INVALID,  CS_TYPE_FILETYPE,
+	  CS_OBJ_IS_CHAR_DEV,       CS_ALL_OK },
+	{ "cmd",                     CS_TYPE_NUMBER,   CS_TYPE_NUMBER,
+	  CS_COND_NARG0,            F(CS_MAC_IOCTL) },
+	{ "data",                    CS_TYPE_STRING,   CS_TYPE_STRING,
+	  CS_COND_SARG3,            F(CS_MAC_MOUNT) },
+	{ "dev_major",               CS_TYPE_NUMBER,   CS_TYPE_NUMBER,
+	  CS_COND_NARG1,            CS_MKDEV_OK },
+	{ "dev_minor",               CS_TYPE_NUMBER,   CS_TYPE_NUMBER,
+	  CS_COND_NARG2,            CS_MKDEV_OK },
+	{ "directory",               CS_TYPE_INVALID,  CS_TYPE_FILETYPE,
+	  CS_OBJ_IS_DIRECTORY,      CS_ALL_OK },
+	{ "domain",                  CS_TYPE_STRING,   CS_TYPE_STRING,
+	  CS_COND_SARG0,            F(CS_MAC_MANUAL_DOMAIN_TRANSITION) },
+	{ "envc",                    CS_TYPE_NUMBER,   CS_TYPE_NUMBER,
+	  CS_EXEC_ENVC,             CS_EXECUTE_OR_ENVIRON_OK },
+	{ "exec",                    CS_TYPE_STRING,   CS_TYPE_STRING,
+	  CS_COND_SARG1,            CS_EXECUTE_OR_ENVIRON_OK },
+	{ "exec.fsmagic",            CS_TYPE_NUMBER,   CS_TYPE_NUMBER,
+	  CS_PATH_ATTRIBUTE_START + 32 + CS_PATH_ATTRIBUTE_FSMAGIC,
+	  CS_EXECUTE_OR_ENVIRON_OK },
+	{ "exec.gid",                CS_TYPE_NUMBER,   CS_TYPE_NUMBER,
+	  CS_PATH_ATTRIBUTE_START + 32 + CS_PATH_ATTRIBUTE_GID,
+	  CS_EXECUTE_OR_ENVIRON_OK },
+	{ "exec.ino",                CS_TYPE_NUMBER,   CS_TYPE_NUMBER,
+	  CS_PATH_ATTRIBUTE_START + 32 + CS_PATH_ATTRIBUTE_INO,
+	  CS_EXECUTE_OR_ENVIRON_OK },
+	{ "exec.major",              CS_TYPE_NUMBER,   CS_TYPE_NUMBER,
+	  CS_PATH_ATTRIBUTE_START + 32 + CS_PATH_ATTRIBUTE_MAJOR,
+	  CS_EXECUTE_OR_ENVIRON_OK },
+	{ "exec.minor",              CS_TYPE_NUMBER,   CS_TYPE_NUMBER,
+	  CS_PATH_ATTRIBUTE_START + 32 + CS_PATH_ATTRIBUTE_MINOR,
+	  CS_EXECUTE_OR_ENVIRON_OK },
+	{ "exec.parent.fsmagic",     CS_TYPE_NUMBER,   CS_TYPE_NUMBER,
+	  CS_PATH_ATTRIBUTE_START + 48 + CS_PATH_ATTRIBUTE_FSMAGIC,
+	  CS_EXECUTE_OR_ENVIRON_OK },
+	{ "exec.parent.gid",         CS_TYPE_NUMBER,   CS_TYPE_NUMBER,
+	  CS_PATH_ATTRIBUTE_START + 48 + CS_PATH_ATTRIBUTE_GID,
+	  CS_EXECUTE_OR_ENVIRON_OK },
+	{ "exec.parent.ino",         CS_TYPE_NUMBER,   CS_TYPE_NUMBER,
+	  CS_PATH_ATTRIBUTE_START + 48 + CS_PATH_ATTRIBUTE_INO,
+	  CS_EXECUTE_OR_ENVIRON_OK },
+	{ "exec.parent.major",       CS_TYPE_NUMBER,   CS_TYPE_NUMBER,
+	  CS_PATH_ATTRIBUTE_START + 48 + CS_PATH_ATTRIBUTE_MAJOR,
+	  CS_EXECUTE_OR_ENVIRON_OK },
+	{ "exec.parent.minor",       CS_TYPE_NUMBER,   CS_TYPE_NUMBER,
+	  CS_PATH_ATTRIBUTE_START + 48 + CS_PATH_ATTRIBUTE_MINOR,
+	  CS_EXECUTE_OR_ENVIRON_OK },
+	{ "exec.parent.perm",        CS_TYPE_FILEPERM, CS_TYPE_FILEPERM,
+	  CS_PATH_ATTRIBUTE_START + 48 + CS_PATH_ATTRIBUTE_PERM,
+	  CS_EXECUTE_OR_ENVIRON_OK },
+	{ "exec.parent.uid",         CS_TYPE_NUMBER,   CS_TYPE_NUMBER,
+	  CS_PATH_ATTRIBUTE_START + 48 + CS_PATH_ATTRIBUTE_UID,
+	  CS_EXECUTE_OR_ENVIRON_OK },
+	{ "exec.perm",               CS_TYPE_FILEPERM, CS_TYPE_FILEPERM,
+	  CS_PATH_ATTRIBUTE_START + 32 + CS_PATH_ATTRIBUTE_PERM,
+	  CS_EXECUTE_OR_ENVIRON_OK },
+	{ "exec.type",               CS_TYPE_FILETYPE, CS_TYPE_FILETYPE,
+	  CS_PATH_ATTRIBUTE_START + 32 + CS_PATH_ATTRIBUTE_TYPE,
+	  CS_EXECUTE_OR_ENVIRON_OK },
+	{ "exec.uid",                CS_TYPE_NUMBER,   CS_TYPE_NUMBER,
+	  CS_PATH_ATTRIBUTE_START + 32 + CS_PATH_ATTRIBUTE_UID,
+	  CS_EXECUTE_OR_ENVIRON_OK },
+	{ "fifo",                    CS_TYPE_INVALID,  CS_TYPE_FILETYPE,
+	  CS_OBJ_IS_FIFO,           CS_ALL_OK },
+	{ "file",                    CS_TYPE_INVALID,  CS_TYPE_FILETYPE,
+	  CS_OBJ_IS_FILE,           CS_ALL_OK },
+	{ "flags",                   CS_TYPE_NUMBER,   CS_TYPE_NUMBER,
+	  CS_COND_NARG0,            F(CS_MAC_MOUNT) | F(CS_MAC_UMOUNT) },
+	{ "fstype",                  CS_TYPE_STRING,   CS_TYPE_STRING,
+	  CS_COND_SARG2,            F(CS_MAC_MOUNT) },
+	{ "gid",                     CS_TYPE_NUMBER,   CS_TYPE_NUMBER,
+	  CS_COND_NARG0,            F(CS_MAC_CHGRP) },
+	{ "group_execute",           CS_TYPE_INVALID,  CS_TYPE_FILEPERM,
+	  CS_MODE_GROUP_EXECUTE,    CS_ALL_OK },
+	{ "group_read",              CS_TYPE_INVALID,  CS_TYPE_FILEPERM,
+	  CS_MODE_GROUP_READ,       CS_ALL_OK },
+	{ "group_write",             CS_TYPE_INVALID,  CS_TYPE_FILEPERM,
+	  CS_MODE_GROUP_WRITE,      CS_ALL_OK },
+	{ "ip",                      CS_TYPE_IPADDR,   CS_TYPE_INVALID,
+	  CS_COND_IPARG,            CS_INET_SOCKET_OK },
+	{ "name",                    CS_TYPE_STRING,   CS_TYPE_STRING,
+	  CS_COND_SARG2,            F(CS_MAC_ENVIRON) },
+	{ "new_path",                CS_TYPE_STRING,   CS_TYPE_STRING,
+	  CS_COND_SARG1,            CS_RENAME_OR_LINK_OK },
+	{ "new_path.dev_major",      CS_TYPE_NUMBER,   CS_TYPE_NUMBER,
+	  CS_PATH_ATTRIBUTE_START + 32 + CS_PATH_ATTRIBUTE_DEV_MAJOR,
+	  F(CS_MAC_RENAME) },
+	{ "new_path.dev_minor",      CS_TYPE_NUMBER,   CS_TYPE_NUMBER,
+	  CS_PATH_ATTRIBUTE_START + 32 + CS_PATH_ATTRIBUTE_DEV_MINOR,
+	  F(CS_MAC_RENAME) },
+	{ "new_path.fsmagic",        CS_TYPE_NUMBER,   CS_TYPE_NUMBER,
+	  CS_PATH_ATTRIBUTE_START + 32 + CS_PATH_ATTRIBUTE_FSMAGIC,
+	  F(CS_MAC_RENAME) },
+	{ "new_path.gid",            CS_TYPE_NUMBER,   CS_TYPE_NUMBER,
+	  CS_PATH_ATTRIBUTE_START + 32 + CS_PATH_ATTRIBUTE_GID,
+	  F(CS_MAC_RENAME) },
+	{ "new_path.ino",            CS_TYPE_NUMBER,   CS_TYPE_NUMBER,
+	  CS_PATH_ATTRIBUTE_START + 32 + CS_PATH_ATTRIBUTE_INO,
+	  F(CS_MAC_RENAME) },
+	{ "new_path.major",          CS_TYPE_NUMBER,   CS_TYPE_NUMBER,
+	  CS_PATH_ATTRIBUTE_START + 32 + CS_PATH_ATTRIBUTE_MAJOR,
+	  F(CS_MAC_RENAME) },
+	{ "new_path.minor",          CS_TYPE_NUMBER,   CS_TYPE_NUMBER,
+	  CS_PATH_ATTRIBUTE_START + 32 + CS_PATH_ATTRIBUTE_MINOR,
+	  F(CS_MAC_RENAME) },
+	{ "new_path.parent.fsmagic", CS_TYPE_NUMBER,   CS_TYPE_NUMBER,
+	  CS_PATH_ATTRIBUTE_START + 48 + CS_PATH_ATTRIBUTE_FSMAGIC,
+	  CS_RENAME_OR_LINK_OK },
+	{ "new_path.parent.gid",     CS_TYPE_NUMBER,   CS_TYPE_NUMBER,
+	  CS_PATH_ATTRIBUTE_START + 48 + CS_PATH_ATTRIBUTE_GID,
+	  CS_RENAME_OR_LINK_OK },
+	{ "new_path.parent.ino",     CS_TYPE_NUMBER,   CS_TYPE_NUMBER,
+	  CS_PATH_ATTRIBUTE_START + 48 + CS_PATH_ATTRIBUTE_INO,
+	  CS_RENAME_OR_LINK_OK },
+	{ "new_path.parent.major",   CS_TYPE_NUMBER,   CS_TYPE_NUMBER,
+	  CS_PATH_ATTRIBUTE_START + 48 + CS_PATH_ATTRIBUTE_MAJOR,
+	  CS_RENAME_OR_LINK_OK },
+	{ "new_path.parent.minor",   CS_TYPE_NUMBER,   CS_TYPE_NUMBER,
+	  CS_PATH_ATTRIBUTE_START + 48 + CS_PATH_ATTRIBUTE_MINOR,
+	  CS_RENAME_OR_LINK_OK },
+	{ "new_path.parent.perm",    CS_TYPE_FILEPERM, CS_TYPE_FILEPERM,
+	  CS_PATH_ATTRIBUTE_START + 48 + CS_PATH_ATTRIBUTE_PERM,
+	  CS_RENAME_OR_LINK_OK },
+	{ "new_path.parent.uid",     CS_TYPE_NUMBER,   CS_TYPE_NUMBER,
+	  CS_PATH_ATTRIBUTE_START + 48 + CS_PATH_ATTRIBUTE_UID,
+	  CS_RENAME_OR_LINK_OK },
+	{ "new_path.perm",           CS_TYPE_FILEPERM, CS_TYPE_FILEPERM,
+	  CS_PATH_ATTRIBUTE_START + 32 + CS_PATH_ATTRIBUTE_PERM,
+	  F(CS_MAC_RENAME) },
+	{ "new_path.type",           CS_TYPE_FILETYPE, CS_TYPE_FILETYPE,
+	  CS_PATH_ATTRIBUTE_START + 32 + CS_PATH_ATTRIBUTE_TYPE,
+	  F(CS_MAC_RENAME) },
+	{ "new_path.uid",            CS_TYPE_NUMBER,   CS_TYPE_NUMBER,
+	  CS_PATH_ATTRIBUTE_START + 32 + CS_PATH_ATTRIBUTE_UID,
+	  F(CS_MAC_RENAME) },
+	{ "new_root",                CS_TYPE_STRING,   CS_TYPE_STRING,
+	  CS_COND_SARG0,            F(CS_MAC_PIVOT_ROOT) },
+	{ "new_root.dev_major",      CS_TYPE_NUMBER,   CS_TYPE_NUMBER,
+	  CS_PATH_ATTRIBUTE_START + CS_PATH_ATTRIBUTE_DEV_MAJOR,
+	  F(CS_MAC_PIVOT_ROOT) },
+	{ "new_root.dev_minor",      CS_TYPE_NUMBER,   CS_TYPE_NUMBER,
+	  CS_PATH_ATTRIBUTE_START + CS_PATH_ATTRIBUTE_DEV_MINOR,
+	  F(CS_MAC_PIVOT_ROOT) },
+	{ "new_root.fsmagic",        CS_TYPE_NUMBER,   CS_TYPE_NUMBER,
+	  CS_PATH_ATTRIBUTE_START + CS_PATH_ATTRIBUTE_FSMAGIC,
+	  F(CS_MAC_PIVOT_ROOT) },
+	{ "new_root.gid",            CS_TYPE_NUMBER,   CS_TYPE_NUMBER,
+	  CS_PATH_ATTRIBUTE_START + CS_PATH_ATTRIBUTE_GID,
+	  F(CS_MAC_PIVOT_ROOT) },
+	{ "new_root.ino",            CS_TYPE_NUMBER,   CS_TYPE_NUMBER,
+	  CS_PATH_ATTRIBUTE_START + CS_PATH_ATTRIBUTE_INO,
+	  F(CS_MAC_PIVOT_ROOT) },
+	{ "new_root.major",          CS_TYPE_NUMBER,   CS_TYPE_NUMBER,
+	  CS_PATH_ATTRIBUTE_START + CS_PATH_ATTRIBUTE_MAJOR,
+	  F(CS_MAC_PIVOT_ROOT) },
+	{ "new_root.minor",          CS_TYPE_NUMBER,   CS_TYPE_NUMBER,
+	  CS_PATH_ATTRIBUTE_START + CS_PATH_ATTRIBUTE_MINOR,
+	  F(CS_MAC_PIVOT_ROOT) },
+	{ "new_root.parent.fsmagic", CS_TYPE_NUMBER,   CS_TYPE_NUMBER,
+	  CS_PATH_ATTRIBUTE_START + 16 + CS_PATH_ATTRIBUTE_FSMAGIC,
+	  F(CS_MAC_PIVOT_ROOT) },
+	{ "new_root.parent.gid",     CS_TYPE_NUMBER,   CS_TYPE_NUMBER,
+	  CS_PATH_ATTRIBUTE_START + 16 + CS_PATH_ATTRIBUTE_GID,
+	  F(CS_MAC_PIVOT_ROOT) },
+	{ "new_root.parent.ino",     CS_TYPE_NUMBER,   CS_TYPE_NUMBER,
+	  CS_PATH_ATTRIBUTE_START + 16 + CS_PATH_ATTRIBUTE_INO,
+	  F(CS_MAC_PIVOT_ROOT) },
+	{ "new_root.parent.major",   CS_TYPE_NUMBER,   CS_TYPE_NUMBER,
+	  CS_PATH_ATTRIBUTE_START + 16 + CS_PATH_ATTRIBUTE_MAJOR,
+	  F(CS_MAC_PIVOT_ROOT) },
+	{ "new_root.parent.minor",   CS_TYPE_NUMBER,   CS_TYPE_NUMBER,
+	  CS_PATH_ATTRIBUTE_START + 16 + CS_PATH_ATTRIBUTE_MINOR,
+	  F(CS_MAC_PIVOT_ROOT) },
+	{ "new_root.parent.perm",    CS_TYPE_FILEPERM, CS_TYPE_FILEPERM,
+	  CS_PATH_ATTRIBUTE_START + 16 + CS_PATH_ATTRIBUTE_PERM,
+	  F(CS_MAC_PIVOT_ROOT) },
+	{ "new_root.parent.uid",     CS_TYPE_NUMBER,   CS_TYPE_NUMBER,
+	  CS_PATH_ATTRIBUTE_START + 16 + CS_PATH_ATTRIBUTE_UID,
+	  F(CS_MAC_PIVOT_ROOT) },
+	{ "new_root.perm",           CS_TYPE_FILEPERM, CS_TYPE_FILEPERM,
+	  CS_PATH_ATTRIBUTE_START + CS_PATH_ATTRIBUTE_PERM,
+	  F(CS_MAC_PIVOT_ROOT) },
+	{ "new_root.type",           CS_TYPE_FILETYPE, CS_TYPE_FILETYPE,
+	  CS_PATH_ATTRIBUTE_START + CS_PATH_ATTRIBUTE_TYPE,
+	  F(CS_MAC_PIVOT_ROOT) },
+	{ "new_root.uid",            CS_TYPE_NUMBER,   CS_TYPE_NUMBER,
+	  CS_PATH_ATTRIBUTE_START + CS_PATH_ATTRIBUTE_UID,
+	  F(CS_MAC_PIVOT_ROOT) },
+	{ "old_path",                CS_TYPE_STRING,    CS_TYPE_STRING,
+	  CS_COND_SARG0,            CS_RENAME_OR_LINK_OK },
+	{ "old_path.dev_major",      CS_TYPE_NUMBER,   CS_TYPE_NUMBER,
+	  CS_PATH_ATTRIBUTE_START + CS_PATH_ATTRIBUTE_DEV_MAJOR,
+	  CS_RENAME_OR_LINK_OK },
+	{ "old_path.dev_minor",      CS_TYPE_NUMBER,   CS_TYPE_NUMBER,
+	  CS_PATH_ATTRIBUTE_START + CS_PATH_ATTRIBUTE_DEV_MINOR,
+	  CS_RENAME_OR_LINK_OK },
+	{ "old_path.fsmagic",        CS_TYPE_NUMBER,   CS_TYPE_NUMBER,
+	  CS_PATH_ATTRIBUTE_START + CS_PATH_ATTRIBUTE_FSMAGIC,
+	  CS_RENAME_OR_LINK_OK },
+	{ "old_path.gid",            CS_TYPE_NUMBER,   CS_TYPE_NUMBER,
+	  CS_PATH_ATTRIBUTE_START + CS_PATH_ATTRIBUTE_GID,
+	  CS_RENAME_OR_LINK_OK },
+	{ "old_path.ino",            CS_TYPE_NUMBER,   CS_TYPE_NUMBER,
+	  CS_PATH_ATTRIBUTE_START + CS_PATH_ATTRIBUTE_INO,
+	  CS_RENAME_OR_LINK_OK },
+	{ "old_path.major",          CS_TYPE_NUMBER,   CS_TYPE_NUMBER,
+	  CS_PATH_ATTRIBUTE_START + CS_PATH_ATTRIBUTE_MAJOR,
+	  CS_RENAME_OR_LINK_OK },
+	{ "old_path.minor",          CS_TYPE_NUMBER,   CS_TYPE_NUMBER,
+	  CS_PATH_ATTRIBUTE_START + CS_PATH_ATTRIBUTE_MINOR,
+	  CS_RENAME_OR_LINK_OK },
+	{ "old_path.parent.fsmagic", CS_TYPE_NUMBER,   CS_TYPE_NUMBER,
+	  CS_PATH_ATTRIBUTE_START + 16 + CS_PATH_ATTRIBUTE_FSMAGIC,
+	  CS_RENAME_OR_LINK_OK },
+	{ "old_path.parent.gid",     CS_TYPE_NUMBER,   CS_TYPE_NUMBER,
+	  CS_PATH_ATTRIBUTE_START + 16 + CS_PATH_ATTRIBUTE_GID,
+	  CS_RENAME_OR_LINK_OK },
+	{ "old_path.parent.ino",     CS_TYPE_NUMBER,   CS_TYPE_NUMBER,
+	  CS_PATH_ATTRIBUTE_START + 16 + CS_PATH_ATTRIBUTE_INO,
+	  CS_RENAME_OR_LINK_OK },
+	{ "old_path.parent.major",   CS_TYPE_NUMBER,   CS_TYPE_NUMBER,
+	  CS_PATH_ATTRIBUTE_START + 16 + CS_PATH_ATTRIBUTE_MAJOR,
+	  CS_RENAME_OR_LINK_OK },
+	{ "old_path.parent.minor",   CS_TYPE_NUMBER,   CS_TYPE_NUMBER,
+	  CS_PATH_ATTRIBUTE_START + 16 + CS_PATH_ATTRIBUTE_MINOR,
+	  CS_RENAME_OR_LINK_OK },
+	{ "old_path.parent.perm",    CS_TYPE_FILEPERM, CS_TYPE_FILEPERM,
+	  CS_PATH_ATTRIBUTE_START + 16 + CS_PATH_ATTRIBUTE_PERM,
+	  CS_RENAME_OR_LINK_OK },
+	{ "old_path.parent.uid",     CS_TYPE_NUMBER,   CS_TYPE_NUMBER,
+	  CS_PATH_ATTRIBUTE_START + 16 + CS_PATH_ATTRIBUTE_UID,
+	  CS_RENAME_OR_LINK_OK },
+	{ "old_path.perm",           CS_TYPE_FILEPERM, CS_TYPE_FILEPERM,
+	  CS_PATH_ATTRIBUTE_START + CS_PATH_ATTRIBUTE_PERM,
+	  CS_RENAME_OR_LINK_OK },
+	{ "old_path.type",           CS_TYPE_FILETYPE, CS_TYPE_FILETYPE,
+	  CS_PATH_ATTRIBUTE_START + CS_PATH_ATTRIBUTE_TYPE,
+	  CS_RENAME_OR_LINK_OK },
+	{ "old_path.uid",            CS_TYPE_NUMBER,   CS_TYPE_NUMBER,
+	  CS_PATH_ATTRIBUTE_START + CS_PATH_ATTRIBUTE_UID,
+	  CS_RENAME_OR_LINK_OK },
+	{ "others_execute",          CS_TYPE_INVALID,  CS_TYPE_FILEPERM,
+	  CS_MODE_OTHERS_EXECUTE,   CS_ALL_OK },
+	{ "others_read",             CS_TYPE_INVALID,  CS_TYPE_FILEPERM,
+	  CS_MODE_OTHERS_READ,      CS_ALL_OK },
+	{ "others_write",            CS_TYPE_INVALID,  CS_TYPE_FILEPERM,
+	  CS_MODE_OTHERS_WRITE,     CS_ALL_OK },
+	{ "owner_execute",           CS_TYPE_INVALID,  CS_TYPE_FILEPERM,
+	  CS_MODE_OWNER_EXECUTE,    CS_ALL_OK },
+	{ "owner_read",              CS_TYPE_INVALID,  CS_TYPE_FILEPERM,
+	  CS_MODE_OWNER_READ,       CS_ALL_OK },
+	{ "owner_write",             CS_TYPE_INVALID,  CS_TYPE_FILEPERM,
+	  CS_MODE_OWNER_WRITE,      CS_ALL_OK },
+	{ "path",                    CS_TYPE_STRING,   CS_TYPE_STRING,
+	  CS_COND_SARG0,            CS_PATH_OK },
+	{ "path.dev_major",          CS_TYPE_NUMBER,   CS_TYPE_NUMBER,
+	  CS_PATH_ATTRIBUTE_START + CS_PATH_ATTRIBUTE_DEV_MAJOR,
+	  CS_PATH_SELF_OK },
+	{ "path.dev_minor",          CS_TYPE_NUMBER,   CS_TYPE_NUMBER,
+	  CS_PATH_ATTRIBUTE_START + CS_PATH_ATTRIBUTE_DEV_MINOR,
+	  CS_PATH_SELF_OK },
+	{ "path.fsmagic",            CS_TYPE_NUMBER,   CS_TYPE_NUMBER,
+	  CS_PATH_ATTRIBUTE_START + CS_PATH_ATTRIBUTE_FSMAGIC,
+	  CS_PATH_SELF_OK },
+	{ "path.gid",                CS_TYPE_NUMBER,   CS_TYPE_NUMBER,
+	  CS_PATH_ATTRIBUTE_START + CS_PATH_ATTRIBUTE_GID,
+	  CS_PATH_SELF_OK },
+	{ "path.ino",                CS_TYPE_NUMBER,   CS_TYPE_NUMBER,
+	  CS_PATH_ATTRIBUTE_START + CS_PATH_ATTRIBUTE_INO,
+	  CS_PATH_SELF_OK },
+	{ "path.major",              CS_TYPE_NUMBER,   CS_TYPE_NUMBER,
+	  CS_PATH_ATTRIBUTE_START + CS_PATH_ATTRIBUTE_MAJOR,
+	  CS_PATH_SELF_OK },
+	{ "path.minor",              CS_TYPE_NUMBER,   CS_TYPE_NUMBER,
+	  CS_PATH_ATTRIBUTE_START + CS_PATH_ATTRIBUTE_MINOR,
+	  CS_PATH_SELF_OK },
+	{ "path.parent.fsmagic",     CS_TYPE_NUMBER,   CS_TYPE_NUMBER,
+	  CS_PATH_ATTRIBUTE_START + 16 + CS_PATH_ATTRIBUTE_FSMAGIC,
+	  CS_PATH_OK },
+	{ "path.parent.gid",         CS_TYPE_NUMBER,   CS_TYPE_NUMBER,
+	  CS_PATH_ATTRIBUTE_START + 16 + CS_PATH_ATTRIBUTE_GID,
+	  CS_PATH_OK },
+	{ "path.parent.ino",         CS_TYPE_NUMBER,   CS_TYPE_NUMBER,
+	  CS_PATH_ATTRIBUTE_START + 16 + CS_PATH_ATTRIBUTE_INO,
+	  CS_PATH_OK },
+	{ "path.parent.major",       CS_TYPE_NUMBER,   CS_TYPE_NUMBER,
+	  CS_PATH_ATTRIBUTE_START + 16 + CS_PATH_ATTRIBUTE_MAJOR,
+	  CS_PATH_OK },
+	{ "path.parent.minor",       CS_TYPE_NUMBER,   CS_TYPE_NUMBER,
+	  CS_PATH_ATTRIBUTE_START + 16 + CS_PATH_ATTRIBUTE_MINOR,
+	  CS_PATH_OK },
+	{ "path.parent.perm",        CS_TYPE_FILEPERM, CS_TYPE_FILEPERM,
+	  CS_PATH_ATTRIBUTE_START + 16 + CS_PATH_ATTRIBUTE_PERM,
+	  CS_PATH_OK },
+	{ "path.parent.uid",         CS_TYPE_NUMBER,   CS_TYPE_NUMBER,
+	  CS_PATH_ATTRIBUTE_START + 16 + CS_PATH_ATTRIBUTE_UID,
+	  CS_PATH_OK },
+	{ "path.perm",               CS_TYPE_FILEPERM, CS_TYPE_FILEPERM,
+	  CS_PATH_ATTRIBUTE_START + CS_PATH_ATTRIBUTE_PERM,
+	  CS_PATH_SELF_OK },
+	{ "path.type",               CS_TYPE_FILETYPE, CS_TYPE_FILETYPE,
+	  CS_PATH_ATTRIBUTE_START + CS_PATH_ATTRIBUTE_TYPE,
+	  CS_PATH_SELF_OK },
+	{ "path.uid",                CS_TYPE_NUMBER,   CS_TYPE_NUMBER,
+	  CS_PATH_ATTRIBUTE_START + CS_PATH_ATTRIBUTE_UID,
+	  CS_PATH_SELF_OK },
+	{ "perm",                    CS_TYPE_FILEPERM, CS_TYPE_FILEPERM,
+	  CS_COND_NARG0,            CS_PATH_PERM_OK },
+	{ "port",                    CS_TYPE_NUMBER,   CS_TYPE_NUMBER,
+	  CS_COND_NARG0,            CS_IP_SOCKET_OK },
+	{ "proto",                   CS_TYPE_NUMBER,   CS_TYPE_NUMBER,
+	  CS_COND_NARG0,            CS_RAW_SOCKET_OK },
+	{ "put_old",                 CS_TYPE_STRING,   CS_TYPE_STRING,
+	  CS_COND_SARG1,            F(CS_MAC_PIVOT_ROOT) },
+	{ "put_old.dev_major",       CS_TYPE_NUMBER,   CS_TYPE_NUMBER,
+	  CS_PATH_ATTRIBUTE_START + 32 + CS_PATH_ATTRIBUTE_DEV_MAJOR,
+	  F(CS_MAC_PIVOT_ROOT) },
+	{ "put_old.dev_minor",       CS_TYPE_NUMBER,   CS_TYPE_NUMBER,
+	  CS_PATH_ATTRIBUTE_START + 32 + CS_PATH_ATTRIBUTE_DEV_MINOR,
+	  F(CS_MAC_PIVOT_ROOT) },
+	{ "put_old.fsmagic",         CS_TYPE_NUMBER,   CS_TYPE_NUMBER,
+	  CS_PATH_ATTRIBUTE_START + 32 + CS_PATH_ATTRIBUTE_FSMAGIC,
+	  F(CS_MAC_PIVOT_ROOT) },
+	{ "put_old.gid",             CS_TYPE_NUMBER,   CS_TYPE_NUMBER,
+	  CS_PATH_ATTRIBUTE_START + 32 + CS_PATH_ATTRIBUTE_GID,
+	  F(CS_MAC_PIVOT_ROOT) },
+	{ "put_old.ino",             CS_TYPE_NUMBER,   CS_TYPE_NUMBER,
+	  CS_PATH_ATTRIBUTE_START + 32 + CS_PATH_ATTRIBUTE_INO,
+	  F(CS_MAC_PIVOT_ROOT) },
+	{ "put_old.major",           CS_TYPE_NUMBER,   CS_TYPE_NUMBER,
+	  CS_PATH_ATTRIBUTE_START + 32 + CS_PATH_ATTRIBUTE_MAJOR,
+	  F(CS_MAC_PIVOT_ROOT) },
+	{ "put_old.minor",           CS_TYPE_NUMBER,   CS_TYPE_NUMBER,
+	  CS_PATH_ATTRIBUTE_START + 32 + CS_PATH_ATTRIBUTE_MINOR,
+	  F(CS_MAC_PIVOT_ROOT) },
+	{ "put_old.parent.fsmagic",  CS_TYPE_NUMBER,   CS_TYPE_NUMBER,
+	  CS_PATH_ATTRIBUTE_START + 48 + CS_PATH_ATTRIBUTE_FSMAGIC,
+	  F(CS_MAC_PIVOT_ROOT) },
+	{ "put_old.parent.gid",      CS_TYPE_NUMBER,   CS_TYPE_NUMBER,
+	  CS_PATH_ATTRIBUTE_START + 48 + CS_PATH_ATTRIBUTE_GID,
+	  F(CS_MAC_PIVOT_ROOT) },
+	{ "put_old.parent.ino",      CS_TYPE_NUMBER,   CS_TYPE_NUMBER,
+	  CS_PATH_ATTRIBUTE_START + 48 + CS_PATH_ATTRIBUTE_INO,
+	  F(CS_MAC_PIVOT_ROOT) },
+	{ "put_old.parent.major",    CS_TYPE_NUMBER,   CS_TYPE_NUMBER,
+	  CS_PATH_ATTRIBUTE_START + 48 + CS_PATH_ATTRIBUTE_MAJOR,
+	  F(CS_MAC_PIVOT_ROOT) },
+	{ "put_old.parent.minor",    CS_TYPE_NUMBER,   CS_TYPE_NUMBER,
+	  CS_PATH_ATTRIBUTE_START + 48 + CS_PATH_ATTRIBUTE_MINOR,
+	  F(CS_MAC_PIVOT_ROOT) },
+	{ "put_old.parent.perm",     CS_TYPE_FILEPERM, CS_TYPE_FILEPERM,
+	  CS_PATH_ATTRIBUTE_START + 48 + CS_PATH_ATTRIBUTE_PERM,
+	  F(CS_MAC_PIVOT_ROOT) },
+	{ "put_old.parent.uid",      CS_TYPE_NUMBER,   CS_TYPE_NUMBER,
+	  CS_PATH_ATTRIBUTE_START + 48 + CS_PATH_ATTRIBUTE_UID,
+	  F(CS_MAC_PIVOT_ROOT) },
+	{ "put_old.perm",            CS_TYPE_FILEPERM, CS_TYPE_FILEPERM,
+	  CS_PATH_ATTRIBUTE_START + 32 + CS_PATH_ATTRIBUTE_PERM,
+	  F(CS_MAC_PIVOT_ROOT) },
+	{ "put_old.type",            CS_TYPE_FILETYPE, CS_TYPE_FILETYPE,
+	  CS_PATH_ATTRIBUTE_START + 32 + CS_PATH_ATTRIBUTE_TYPE,
+	  F(CS_MAC_PIVOT_ROOT) },
+	{ "put_old.uid",             CS_TYPE_NUMBER,   CS_TYPE_NUMBER,
+	  CS_PATH_ATTRIBUTE_START + 32 + CS_PATH_ATTRIBUTE_UID,
+	  F(CS_MAC_PIVOT_ROOT) },
+	{ "setgid",                  CS_TYPE_INVALID,  CS_TYPE_FILEPERM,
+	  CS_MODE_SETGID,           CS_ALL_OK },
+	{ "setuid",                  CS_TYPE_INVALID,  CS_TYPE_FILEPERM,
+	  CS_MODE_SETUID,           CS_ALL_OK },
+	{ "socket",                  CS_TYPE_INVALID,  CS_TYPE_FILETYPE,
+	  CS_OBJ_IS_SOCKET,         CS_ALL_OK },
+	{ "source",                  CS_TYPE_STRING,   CS_TYPE_STRING,
+	  CS_COND_SARG0,            F(CS_MAC_MOUNT) },
+	{ "source.dev_major",        CS_TYPE_NUMBER,   CS_TYPE_NUMBER,
+	  CS_PATH_ATTRIBUTE_START + CS_PATH_ATTRIBUTE_DEV_MAJOR,
+	  F(CS_MAC_MOUNT) },
+	{ "source.dev_minor",        CS_TYPE_NUMBER,   CS_TYPE_NUMBER,
+	  CS_PATH_ATTRIBUTE_START + CS_PATH_ATTRIBUTE_DEV_MINOR,
+	  F(CS_MAC_MOUNT) },
+	{ "source.fsmagic",          CS_TYPE_NUMBER,   CS_TYPE_NUMBER,
+	  CS_PATH_ATTRIBUTE_START + CS_PATH_ATTRIBUTE_FSMAGIC,
+	  F(CS_MAC_MOUNT) },
+	{ "source.gid",              CS_TYPE_NUMBER,   CS_TYPE_NUMBER,
+	  CS_PATH_ATTRIBUTE_START + CS_PATH_ATTRIBUTE_GID,
+	  F(CS_MAC_MOUNT) },
+	{ "source.ino",              CS_TYPE_NUMBER,   CS_TYPE_NUMBER,
+	  CS_PATH_ATTRIBUTE_START + CS_PATH_ATTRIBUTE_INO,
+	  F(CS_MAC_MOUNT) },
+	{ "source.major",            CS_TYPE_NUMBER,   CS_TYPE_NUMBER,
+	  CS_PATH_ATTRIBUTE_START + CS_PATH_ATTRIBUTE_MAJOR,
+	  F(CS_MAC_MOUNT) },
+	{ "source.minor",            CS_TYPE_NUMBER,   CS_TYPE_NUMBER,
+	  CS_PATH_ATTRIBUTE_START + CS_PATH_ATTRIBUTE_MINOR,
+	  F(CS_MAC_MOUNT) },
+	{ "source.parent.fsmagic",   CS_TYPE_NUMBER,   CS_TYPE_NUMBER,
+	  CS_PATH_ATTRIBUTE_START + 16 + CS_PATH_ATTRIBUTE_FSMAGIC,
+	  F(CS_MAC_MOUNT) },
+	{ "source.parent.gid",       CS_TYPE_NUMBER,   CS_TYPE_NUMBER,
+	  CS_PATH_ATTRIBUTE_START + 16 + CS_PATH_ATTRIBUTE_GID,
+	  F(CS_MAC_MOUNT) },
+	{ "source.parent.ino",       CS_TYPE_NUMBER,   CS_TYPE_NUMBER,
+	  CS_PATH_ATTRIBUTE_START + 16 + CS_PATH_ATTRIBUTE_INO,
+	  F(CS_MAC_MOUNT) },
+	{ "source.parent.major",     CS_TYPE_NUMBER,   CS_TYPE_NUMBER,
+	  CS_PATH_ATTRIBUTE_START + 16 + CS_PATH_ATTRIBUTE_MAJOR,
+	  F(CS_MAC_MOUNT) },
+	{ "source.parent.minor",     CS_TYPE_NUMBER,   CS_TYPE_NUMBER,
+	  CS_PATH_ATTRIBUTE_START + 16 + CS_PATH_ATTRIBUTE_MINOR,
+	  F(CS_MAC_MOUNT) },
+	{ "source.parent.perm",      CS_TYPE_FILEPERM, CS_TYPE_FILEPERM,
+	  CS_PATH_ATTRIBUTE_START + 16 + CS_PATH_ATTRIBUTE_PERM,
+	  F(CS_MAC_MOUNT) },
+	{ "source.parent.uid",       CS_TYPE_NUMBER,   CS_TYPE_NUMBER,
+	  CS_PATH_ATTRIBUTE_START + 16 + CS_PATH_ATTRIBUTE_UID,
+	  F(CS_MAC_MOUNT) },
+	{ "source.perm",             CS_TYPE_FILEPERM, CS_TYPE_FILEPERM,
+	  CS_PATH_ATTRIBUTE_START + CS_PATH_ATTRIBUTE_PERM,
+	  F(CS_MAC_MOUNT) },
+	{ "source.type",             CS_TYPE_FILETYPE, CS_TYPE_FILETYPE,
+	  CS_PATH_ATTRIBUTE_START + CS_PATH_ATTRIBUTE_TYPE,
+	  F(CS_MAC_MOUNT) },
+	{ "source.uid",              CS_TYPE_NUMBER,   CS_TYPE_NUMBER,
+	  CS_PATH_ATTRIBUTE_START + CS_PATH_ATTRIBUTE_UID,
+	  F(CS_MAC_MOUNT) },
+	{ "sticky",                  CS_TYPE_INVALID,  CS_TYPE_FILEPERM,
+	  CS_MODE_STICKY,           CS_ALL_OK },
+	{ "symlink",                 CS_TYPE_INVALID,  CS_TYPE_FILETYPE,
+	  CS_OBJ_IS_SYMLINK,        CS_ALL_OK },
+	{ "target",                  CS_TYPE_STRING,   CS_TYPE_STRING,
+	  CS_COND_SARG1,            F(CS_MAC_MOUNT) | F(CS_MAC_SYMLINK) },
+	{ "target.dev_major",        CS_TYPE_NUMBER,   CS_TYPE_NUMBER,
+	  CS_PATH_ATTRIBUTE_START + 32 + CS_PATH_ATTRIBUTE_DEV_MAJOR,
+	  F(CS_MAC_MOUNT) },
+	{ "target.dev_minor",        CS_TYPE_NUMBER,   CS_TYPE_NUMBER,
+	  CS_PATH_ATTRIBUTE_START + 32 + CS_PATH_ATTRIBUTE_DEV_MINOR,
+	  F(CS_MAC_MOUNT) },
+	{ "target.fsmagic",          CS_TYPE_NUMBER,   CS_TYPE_NUMBER,
+	  CS_PATH_ATTRIBUTE_START + 32 + CS_PATH_ATTRIBUTE_FSMAGIC,
+	  F(CS_MAC_MOUNT) },
+	{ "target.gid",              CS_TYPE_NUMBER,   CS_TYPE_NUMBER,
+	  CS_PATH_ATTRIBUTE_START + 32 + CS_PATH_ATTRIBUTE_GID,
+	  F(CS_MAC_MOUNT) },
+	{ "target.ino",              CS_TYPE_NUMBER,   CS_TYPE_NUMBER,
+	  CS_PATH_ATTRIBUTE_START + 32 + CS_PATH_ATTRIBUTE_INO,
+	  F(CS_MAC_MOUNT) },
+	{ "target.major",            CS_TYPE_NUMBER,   CS_TYPE_NUMBER,
+	  CS_PATH_ATTRIBUTE_START + 32 + CS_PATH_ATTRIBUTE_MAJOR,
+	  F(CS_MAC_MOUNT) },
+	{ "target.minor",            CS_TYPE_NUMBER,   CS_TYPE_NUMBER,
+	  CS_PATH_ATTRIBUTE_START + 32 + CS_PATH_ATTRIBUTE_MINOR,
+	  F(CS_MAC_MOUNT) },
+	{ "target.parent.fsmagic",   CS_TYPE_NUMBER,   CS_TYPE_NUMBER,
+	  CS_PATH_ATTRIBUTE_START + 48 + CS_PATH_ATTRIBUTE_FSMAGIC,
+	  F(CS_MAC_MOUNT) },
+	{ "target.parent.gid",       CS_TYPE_NUMBER,   CS_TYPE_NUMBER,
+	  CS_PATH_ATTRIBUTE_START + 48 + CS_PATH_ATTRIBUTE_GID,
+	  F(CS_MAC_MOUNT) },
+	{ "target.parent.ino",       CS_TYPE_NUMBER,   CS_TYPE_NUMBER,
+	  CS_PATH_ATTRIBUTE_START + 48 + CS_PATH_ATTRIBUTE_INO,
+	  F(CS_MAC_MOUNT) },
+	{ "target.parent.major",     CS_TYPE_NUMBER,   CS_TYPE_NUMBER,
+	  CS_PATH_ATTRIBUTE_START + 48 + CS_PATH_ATTRIBUTE_MAJOR,
+	  F(CS_MAC_MOUNT) },
+	{ "target.parent.minor",     CS_TYPE_NUMBER,   CS_TYPE_NUMBER,
+	  CS_PATH_ATTRIBUTE_START + 48 + CS_PATH_ATTRIBUTE_MINOR,
+	  F(CS_MAC_MOUNT) },
+	{ "target.parent.perm",      CS_TYPE_FILEPERM, CS_TYPE_FILEPERM,
+	  CS_PATH_ATTRIBUTE_START + 48 + CS_PATH_ATTRIBUTE_PERM,
+	  F(CS_MAC_MOUNT) },
+	{ "target.parent.uid",       CS_TYPE_NUMBER,   CS_TYPE_NUMBER,
+	  CS_PATH_ATTRIBUTE_START + 48 + CS_PATH_ATTRIBUTE_UID,
+	  F(CS_MAC_MOUNT) },
+	{ "target.perm",             CS_TYPE_FILEPERM, CS_TYPE_FILEPERM,
+	  CS_PATH_ATTRIBUTE_START + 32 + CS_PATH_ATTRIBUTE_PERM,
+	  F(CS_MAC_MOUNT) },
+	{ "target.type",             CS_TYPE_FILETYPE, CS_TYPE_FILETYPE,
+	  CS_PATH_ATTRIBUTE_START + 32 + CS_PATH_ATTRIBUTE_TYPE,
+	  F(CS_MAC_MOUNT) },
+	{ "target.uid",              CS_TYPE_NUMBER,   CS_TYPE_NUMBER,
+	  CS_PATH_ATTRIBUTE_START + 32 + CS_PATH_ATTRIBUTE_UID,
+	  F(CS_MAC_MOUNT) },
+	{ "task.domain",             CS_TYPE_STRING,   CS_TYPE_STRING,
+	  CS_SELF_DOMAIN,           CS_ALL_OK },
+	{ "task.egid",               CS_TYPE_NUMBER,   CS_TYPE_NUMBER,
+	  CS_SELF_EGID,             CS_ALL_OK },
+	{ "task.euid",               CS_TYPE_NUMBER,   CS_TYPE_NUMBER,
+	  CS_SELF_EUID,             CS_ALL_OK },
+	{ "task.exe",                CS_TYPE_STRING,   CS_TYPE_STRING,
+	  CS_SELF_EXE,              CS_ALL_OK },
+	{ "task.fsgid",              CS_TYPE_NUMBER,   CS_TYPE_NUMBER,
+	  CS_SELF_FSGID,            CS_ALL_OK },
+	{ "task.fsuid",              CS_TYPE_NUMBER,   CS_TYPE_NUMBER,
+	  CS_SELF_FSUID,            CS_ALL_OK },
+	{ "task.gid",                CS_TYPE_NUMBER,   CS_TYPE_NUMBER,
+	  CS_SELF_GID,              CS_ALL_OK },
+	{ "task.pid",                CS_TYPE_NUMBER,   CS_TYPE_NUMBER,
+	  CS_SELF_PID,              CS_ALL_OK },
+	{ "task.ppid",               CS_TYPE_NUMBER,   CS_TYPE_NUMBER,
+	  CS_SELF_PPID,             CS_ALL_OK },
+	{ "task.sgid",               CS_TYPE_NUMBER,   CS_TYPE_NUMBER,
+	  CS_SELF_SGID,             CS_ALL_OK },
+	{ "task.suid",               CS_TYPE_NUMBER,   CS_TYPE_NUMBER,
+	  CS_SELF_SUID,             CS_ALL_OK },
+	{ "task.uid",                CS_TYPE_NUMBER,   CS_TYPE_NUMBER,
+	  CS_SELF_UID,              CS_ALL_OK },
+	{ "transition",              CS_TYPE_ASSIGN,   CS_TYPE_INVALID,
+	  CS_TRANSIT_DOMAIN,
+	  F(CS_MAC_EXECUTE) | F(CS_MAC_AUTO_DOMAIN_TRANSITION) |
+	  CS_INET_SOCKET_OK | CS_UNIX_SOCKET_OK },
+	{ "uid",                     CS_TYPE_NUMBER,   CS_TYPE_NUMBER,
+	  CS_COND_NARG0,            F(CS_MAC_CHOWN) },
+	{ "value",                   CS_TYPE_STRING,   CS_TYPE_STRING,
+	  CS_COND_SARG3,            F(CS_MAC_ENVIRON) },
+};
+
+/***** SECTION2: Structure definition *****/
+
+struct iattr;
+
+/* Structure for query. */
+struct cs_query {
+	struct list_head list;
+	struct cs_acl_info *acl;
+	char *query;
+	size_t query_len;
+	unsigned int serial;
+	u8 timer;
+	u8 answer;
+	u8 retry;
+	enum cs_mac_index acl_type;
+};
+
+/* Structure for audit log. */
+struct cs_log {
+	struct list_head list;
+	char *log;
+	int size;
+	enum cs_matching_result result;
+};
+
+/* Structure for holding single condition component. */
+struct cs_cond_tmp {
+	enum cs_conditions_index left;
+	enum cs_conditions_index right;
+	bool is_not;
+	u8 radix;
+	enum cs_var_type type;
+	struct cs_group *group;
+	const struct cs_path_info *path;
+	struct in6_addr ipv6[2];
+	unsigned long value[2];
+	unsigned long argv;
+	const struct cs_path_info *envp;
+};
+
+/***** SECTION3: Prototype definition section *****/
+
+static bool cs_correct_domain(const unsigned char *domainname);
+static bool cs_correct_word(const char *string);
+static bool cs_flush(struct cs_io_buffer *head);
+static bool cs_print_condition(struct cs_io_buffer *head,
+			       const struct cs_condition *cond);
+static bool cs_memory_ok(const void *ptr);
+static bool cs_read_acl(struct cs_io_buffer *head,
+			const struct cs_acl_info *acl);
+static bool cs_read_group(struct cs_io_buffer *head);
+static bool cs_select_acl(struct cs_io_buffer *head, const char *data);
+static bool cs_set_lf(struct cs_io_buffer *head);
+static bool cs_str_starts(char **src, const char *find);
+static char *cs_init_log(struct cs_request_info *r);
+static char *cs_print_bprm(struct linux_binprm *bprm,
+			   struct cs_page_dump *dump);
+static char *cs_print_trailer(struct cs_request_info *r);
+static char *cs_read_token(struct cs_io_buffer *head);
+static const char *cs_yesno(const unsigned int value);
+static const struct cs_path_info *cs_get_dqword(char *start);
+static const struct cs_path_info *cs_get_name(const char *name);
+static int cs_open(struct inode *inode, struct file *file);
+static int cs_parse_policy(struct cs_io_buffer *head, char *line);
+static int cs_release(struct inode *inode, struct file *file);
+static int cs_supervisor(struct cs_request_info *r);
+static int cs_update_group(struct cs_io_buffer *head,
+			   const enum cs_group_id type);
+static int cs_write_answer(struct cs_io_buffer *head);
+static int cs_write_audit_quota(char *data);
+static int cs_write_memory_quota(char *data);
+static int cs_write_pid(struct cs_io_buffer *head);
+static int cs_write_policy(struct cs_io_buffer *head);
+static ssize_t cs_read(struct file *file, char __user *buf, size_t count,
+		       loff_t *ppos);
+static ssize_t cs_read_self(struct file *file, char __user *buf, size_t count,
+			    loff_t *ppos);
+static ssize_t cs_write(struct file *file, const char __user *buf,
+			size_t count, loff_t *ppos);
+static struct cs_condition *cs_get_condition(struct cs_io_buffer *head);
+static struct cs_domain_info *cs_find_domain(const char *domainname);
+static struct cs_acl_info *cs_find_acl_by_qid(unsigned int serial,
+					      enum cs_mac_index *type);
+static struct cs_group *cs_get_group(struct cs_io_buffer *head,
+				     const enum cs_group_id idx);
+static enum cs_value_type cs_parse_ulong(unsigned long *result, char **str);
+static unsigned int cs_poll(struct file *file, poll_table *wait);
+static void __init cs_create_entry(const char *name, const umode_t mode,
+				   struct dentry *parent, const u8 key);
+static void __init cs_load_builtin_policy(void);
+static void __init cs_securityfs_init(void);
+static void cs_convert_time(time64_t time, struct cs_time *stamp);
+static void cs_io_printf(struct cs_io_buffer *head, const char *fmt, ...)
+	__printf(2, 3);
+static void cs_normalize_line(unsigned char *buffer);
+static void cs_read_log(struct cs_io_buffer *head);
+static void cs_read_pid(struct cs_io_buffer *head);
+static void cs_read_policy(struct cs_io_buffer *head);
+static void cs_read_query(struct cs_io_buffer *head);
+static void *cs_commit_ok(void *data, const unsigned int size);
+static bool cs_read_quota(struct cs_io_buffer *head);
+static void cs_read_stat(struct cs_io_buffer *head);
+static void cs_read_version(struct cs_io_buffer *head);
+static void cs_set_space(struct cs_io_buffer *head);
+static void cs_set_string(struct cs_io_buffer *head, const char *string);
+static void cs_update_stat(const u8 index);
+static void cs_write_log(struct cs_request_info *r);
+
+#ifdef CONFIG_SECURITY_CAITSITH_NETWORK
+static enum cs_conditions_index cs_parse_ipaddr(char *address,
+						struct in6_addr ipv6[2]);
+static void cs_print_ipv4(struct cs_io_buffer *head, const u32 *ip);
+static void cs_print_ipv6(struct cs_io_buffer *head,
+			  const struct in6_addr *ip);
+static void cs_print_ip(struct cs_io_buffer *head,
+			struct cs_ip_group *member);
+#endif
+
+#ifdef CONFIG_SECURITY_CAITSITH_MANUAL_DOMAIN_TRANSITION
+static ssize_t cs_write_self(struct file *file, const char __user *buf,
+			     size_t count, loff_t *ppos);
+#endif
+
+/***** SECTION4: Standalone functions section *****/
+
+/**
+ * cs_convert_time - Convert time_t to YYYY/MM/DD hh/mm/ss.
+ *
+ * @time:  Seconds since 1970/01/01 00:00:00.
+ * @stamp: Pointer to "struct cs_time".
+ *
+ * Returns nothing.
+ */
+static void cs_convert_time(time64_t time, struct cs_time *stamp)
+{
+	struct tm tm;
+
+	time64_to_tm(time, 0, &tm);
+	stamp->sec = tm.tm_sec;
+	stamp->min = tm.tm_min;
+	stamp->hour = tm.tm_hour;
+	stamp->day = tm.tm_mday;
+	stamp->month = tm.tm_mon + 1;
+	stamp->year = tm.tm_year + 1900;
+}
+
+#ifdef CONFIG_SECURITY_CAITSITH_NETWORK
+
+/**
+ * cs_print_ipv4 - Print an IPv4 address.
+ *
+ * @head: Pointer to "struct cs_io_buffer".
+ * @ip:   Pointer to "u32" in network byte order.
+ *
+ * Returns nothing.
+ */
+static void cs_print_ipv4(struct cs_io_buffer *head, const u32 *ip)
+{
+	cs_io_printf(head, "%pI4", ip);
+}
+
+/**
+ * cs_print_ipv6 - Print an IPv6 address.
+ *
+ * @head: Pointer to "struct cs_io_buffer".
+ * @ip:   Pointer to "struct in6_addr".
+ *
+ * Returns nothing.
+ */
+static void cs_print_ipv6(struct cs_io_buffer *head,
+			  const struct in6_addr *ip)
+{
+	cs_io_printf(head, "%pI6c", ip);
+}
+
+/**
+ * cs_print_ip - Print an IP address.
+ *
+ * @head:   Pointer to "struct cs_io_buffer".
+ * @member: Pointer to "struct cs_ip_group".
+ *
+ * Returns nothing.
+ */
+static void cs_print_ip(struct cs_io_buffer *head,
+			struct cs_ip_group *member)
+{
+	u8 i;
+
+	for (i = 0; i < 2; i++) {
+		if (member->is_ipv6)
+			cs_print_ipv6(head, &member->ip[i]);
+		else
+			cs_print_ipv4(head, (const u32 *) &member->ip[i]);
+		if (i)
+			break;
+		if (!memcmp(&member->ip[0], &member->ip[1], 16))
+			break;
+		cs_set_string(head, "-");
+	}
+}
+
+#endif
+
+/***** SECTION5: Variables definition section *****/
+
+/* Lock for protecting policy. */
+DEFINE_MUTEX(cs_policy_lock);
+
+/* Has /sbin/init started? */
+bool cs_policy_loaded;
+
+/* List of "struct cs_group". */
+struct list_head cs_group_list[CS_MAX_GROUP];
+/* Policy version. Currently only 20120401 is defined. */
+static unsigned int cs_policy_version;
+
+/* List of "struct cs_condition". */
+LIST_HEAD(cs_condition_list);
+
+/* Wait queue for kernel -> userspace notification. */
+static DECLARE_WAIT_QUEUE_HEAD(cs_query_wait);
+/* Wait queue for userspace -> kernel notification. */
+static DECLARE_WAIT_QUEUE_HEAD(cs_answer_wait);
+
+/* The list for "struct cs_query". */
+static LIST_HEAD(cs_query_list);
+
+/* Lock for manipulating cs_query_list. */
+static DEFINE_SPINLOCK(cs_query_list_lock);
+
+/*
+ * Number of "struct file" referring /sys/kernel/security/caitsith/query
+ * interface.
+ */
+static atomic_t cs_query_observers = ATOMIC_INIT(0);
+
+/* Wait queue for /sys/kernel/security/caitsith/audit interface. */
+static DECLARE_WAIT_QUEUE_HEAD(cs_log_wait);
+
+/* The list for "struct cs_log". */
+static LIST_HEAD(cs_log);
+
+/* Lock for "struct list_head cs_log". */
+static DEFINE_SPINLOCK(cs_log_lock);
+
+/* Length of "struct list_head cs_log". */
+static unsigned int cs_log_count[CS_MAX_MATCHING];
+/* Quota for audit logs. */
+static unsigned int cs_log_quota[CS_MAX_LOG_QUOTA][CS_MAX_MATCHING];
+
+/* Memoy currently used by policy/audit log/query. */
+unsigned int cs_memory_used[CS_MAX_MEMORY_STAT];
+
+/* Memory quota for "policy"/"audit log"/"query". */
+static unsigned int cs_memory_quota[CS_MAX_MEMORY_STAT];
+
+/* The list for "struct cs_name". */
+struct list_head cs_name_list[CS_MAX_HASH];
+
+/* Counter for number of updates. */
+static atomic_t cs_stat_updated[CS_MAX_POLICY_STAT];
+
+/* Timestamp counter for last updated. */
+static time64_t cs_stat_modified[CS_MAX_POLICY_STAT];
+
+/* Operations for /sys/kernel/security/caitsith/self_domain interface. */
+static const struct file_operations cs_self_operations = {
+#ifdef CONFIG_SECURITY_CAITSITH_MANUAL_DOMAIN_TRANSITION
+	.write = cs_write_self,
+#endif
+	.read  = cs_read_self,
+};
+
+/* Operations for /sys/kernel/security/caitsith/ interface. */
+static const struct file_operations cs_operations = {
+	.open    = cs_open,
+	.release = cs_release,
+	.poll    = cs_poll,
+	.read    = cs_read,
+	.write   = cs_write,
+};
+
+/***** SECTION6: Dependent functions section *****/
+
+/**
+ * list_for_each_cookie - iterate over a list with cookie.
+ *
+ * @pos:  Pointer to "struct list_head".
+ * @head: Pointer to "struct list_head".
+ */
+#define list_for_each_cookie(pos, head)					\
+	for (pos = pos ? pos : srcu_dereference((head)->next, &cs_ss);	\
+	     pos != (head); pos = srcu_dereference(pos->next, &cs_ss))
+
+/**
+ * cs_warn_oom - Print out of memory warning message.
+ *
+ * @function: Function's name.
+ *
+ * Returns nothing.
+ */
+void cs_warn_oom(const char *function)
+{
+	/* Reduce error messages. */
+	static pid_t cs_last_pid;
+	const pid_t pid = current->pid;
+
+	if (cs_last_pid != pid) {
+		pr_warn("ERROR: Out of memory at %s.\n", function);
+		cs_last_pid = pid;
+	}
+	if (!cs_policy_loaded)
+		panic("MAC Initialization failed.\n");
+}
+
+/**
+ * cs_memory_ok - Check memory quota.
+ *
+ * @ptr:  Pointer to allocated memory. Maybe NULL.
+ *
+ * Returns true if @ptr is not NULL and quota not exceeded, false otherwise.
+ *
+ * Caller holds cs_policy_lock mutex.
+ */
+static bool cs_memory_ok(const void *ptr)
+{
+	if (ptr) {
+		const size_t s = ksize(ptr);
+
+		cs_memory_used[CS_MEMORY_POLICY] += s;
+		if (!cs_memory_quota[CS_MEMORY_POLICY] ||
+		    cs_memory_used[CS_MEMORY_POLICY] <=
+		    cs_memory_quota[CS_MEMORY_POLICY])
+			return true;
+		cs_memory_used[CS_MEMORY_POLICY] -= s;
+	}
+	cs_warn_oom(__func__);
+	return false;
+}
+
+/**
+ * cs_get_name - Allocate memory for string data.
+ *
+ * @name: The string to store into the permernent memory. Maybe NULL.
+ *
+ * Returns pointer to "struct cs_path_info" on success, NULL otherwise.
+ */
+static const struct cs_path_info *cs_get_name(const char *name)
+{
+	struct cs_name *ptr;
+	unsigned int hash;
+	int len;
+	int allocated_len;
+	struct list_head *head;
+
+	if (!name)
+		return NULL;
+	len = strlen(name) + 1;
+	hash = full_name_hash(NULL, name, len - 1);
+	head = &cs_name_list[hash_long(hash, CS_HASH_BITS)];
+	if (mutex_lock_killable(&cs_policy_lock))
+		return NULL;
+	list_for_each_entry(ptr, head, head.list) {
+		if (hash != ptr->entry.hash || strcmp(name, ptr->entry.name) ||
+		    atomic_read(&ptr->head.users) == CS_GC_IN_PROGRESS)
+			continue;
+		atomic_inc(&ptr->head.users);
+		goto out;
+	}
+	allocated_len = sizeof(*ptr) + len;
+	ptr = kzalloc(allocated_len, GFP_NOFS);
+	if (cs_memory_ok(ptr)) {
+		ptr->entry.name = ((char *) ptr) + sizeof(*ptr);
+		memmove((char *) ptr->entry.name, name, len);
+		atomic_set(&ptr->head.users, 1);
+		cs_fill_path_info(&ptr->entry);
+		ptr->size = allocated_len;
+		list_add_tail(&ptr->head.list, head);
+	} else {
+		kfree(ptr);
+		ptr = NULL;
+	}
+out:
+	mutex_unlock(&cs_policy_lock);
+	return ptr ? &ptr->entry : NULL;
+}
+
+/**
+ * cs_read_token - Read a word from a line.
+ *
+ * @head: Pointer to "struct cs_io_buffer".
+ *
+ * Returns a word on success, "" otherwise.
+ *
+ * To allow the caller to skip NULL check, this function returns "" rather than
+ * NULL if there is no more words to read.
+ */
+static char *cs_read_token(struct cs_io_buffer *head)
+{
+	char *pos = head->w.data;
+	char *del = strchr(pos, ' ');
+
+	if (del)
+		*del++ = '\0';
+	else
+		del = pos + strlen(pos);
+	head->w.data = del;
+	return pos;
+}
+
+/**
+ * cs_correct_word - Check whether the given string follows the naming rules.
+ *
+ * @string: The string to check.
+ *
+ * Returns true if @string follows the naming rules, false otherwise.
+ */
+static bool cs_correct_word(const char *string)
+{
+	u8 recursion = 20;
+	const char *const start = string;
+	u8 in_repetition = 0;
+
+	if (!*string)
+		goto out;
+	while (*string) {
+		unsigned char c = *string++;
+
+		if (in_repetition && c == '/')
+			goto out;
+		if (c <= ' ' || c >= 127)
+			goto out;
+		if (c != '\\')
+			continue;
+		c = *string++;
+		if (c >= '0' && c <= '3') {
+			unsigned char d;
+			unsigned char e;
+
+			d = *string++;
+			if (d < '0' || d > '7')
+				goto out;
+			e = *string++;
+			if (e < '0' || e > '7')
+				goto out;
+			c = ((c - '0') << 6) + ((d - '0') << 3) + (e - '0');
+			if (c <= ' ' || c >= 127 || c == '\\')
+				continue;
+			goto out;
+		}
+		switch (c) {
+		case '+':   /* "\+" */
+		case '?':   /* "\?" */
+		case 'x':   /* "\x" */
+		case 'a':   /* "\a" */
+		case '-':   /* "\-" */
+			continue;
+		}
+		/* Reject too deep wildcard that consumes too much stack. */
+		if (!recursion--)
+			goto out;
+		switch (c) {
+		case '*':   /* "\*" */
+		case '@':   /* "\@" */
+		case '$':   /* "\$" */
+		case 'X':   /* "\X" */
+		case 'A':   /* "\A" */
+			continue;
+		case '{':   /* "/\{" */
+			if (string - 3 < start || *(string - 3) != '/')
+				goto out;
+			in_repetition = 1;
+			continue;
+		case '}':   /* "\}/" */
+			if (in_repetition != 1 || *string++ != '/')
+				goto out;
+			in_repetition = 0;
+			continue;
+		case '(':   /* "/\(" */
+			if (string - 3 < start || *(string - 3) != '/')
+				goto out;
+			in_repetition = 2;
+			continue;
+		case ')':   /* "\)/" */
+			if (in_repetition != 2 || *string++ != '/')
+				goto out;
+			in_repetition = 0;
+			continue;
+		}
+		goto out;
+	}
+	if (in_repetition)
+		goto out;
+	return true;
+out:
+	return false;
+}
+
+/**
+ * cs_commit_ok - Allocate memory and check memory quota.
+ *
+ * @data: Data to copy from.
+ * @size: Size in byte.
+ *
+ * Returns pointer to allocated memory on success, NULL otherwise.
+ * @data is zero-cleared on success.
+ *
+ * Caller holds cs_policy_lock mutex.
+ */
+static void *cs_commit_ok(void *data, const unsigned int size)
+{
+	void *ptr = kmalloc(size, GFP_NOFS);
+
+	if (cs_memory_ok(ptr)) {
+		memmove(ptr, data, size);
+		memset(data, 0, size);
+		return ptr;
+	}
+	kfree(ptr);
+	return NULL;
+}
+
+/**
+ * cs_get_group - Allocate memory for "struct cs_string_group"/"struct cs_number_group"/"struct cs_ip_group".
+ *
+ * @head: Pointer to "struct cs_io_buffer".
+ * @idx:  Index number.
+ *
+ * Returns pointer to "struct cs_group" on success, NULL otherwise.
+ */
+static struct cs_group *cs_get_group(struct cs_io_buffer *head,
+				     const enum cs_group_id idx)
+{
+	struct cs_group e = { };
+	struct cs_group *group = NULL;
+	struct list_head *list;
+	const char *group_name = cs_read_token(head);
+	bool found = false;
+
+	if (!cs_correct_word(group_name) || idx >= CS_MAX_GROUP)
+		return NULL;
+	e.group_name = cs_get_name(group_name);
+	if (!e.group_name)
+		return NULL;
+	if (mutex_lock_killable(&cs_policy_lock))
+		goto out;
+	list = &cs_group_list[idx];
+	list_for_each_entry(group, list, head.list) {
+		if (e.group_name != group->group_name ||
+		    atomic_read(&group->head.users) == CS_GC_IN_PROGRESS)
+			continue;
+		atomic_inc(&group->head.users);
+		found = true;
+		break;
+	}
+	if (!found) {
+		struct cs_group *entry = cs_commit_ok(&e, sizeof(e));
+
+		if (entry) {
+			INIT_LIST_HEAD(&entry->member_list);
+			atomic_set(&entry->head.users, 1);
+			list_add_tail_rcu(&entry->head.list, list);
+			group = entry;
+			found = true;
+		}
+	}
+	mutex_unlock(&cs_policy_lock);
+out:
+	cs_put_name(e.group_name);
+	return found ? group : NULL;
+}
+
+/**
+ * cs_parse_ulong - Parse an "unsigned long" value.
+ *
+ * @result: Pointer to "unsigned long".
+ * @str:    Pointer to string to parse.
+ *
+ * Returns one of values in "enum cs_value_type".
+ *
+ * The @src is updated to point the first character after the value
+ * on success.
+ */
+static enum cs_value_type cs_parse_ulong(unsigned long *result, char **str)
+{
+	const char *cp = *str;
+	char *ep;
+	int base = 10;
+
+	if (*cp == '0') {
+		char c = *(cp + 1);
+
+		if (c == 'x' || c == 'X') {
+			base = 16;
+			cp += 2;
+		} else if (c >= '0' && c <= '7') {
+			base = 8;
+			cp++;
+		}
+	}
+	*result = simple_strtoul(cp, &ep, base);
+	if (cp == ep)
+		return CS_VALUE_TYPE_INVALID;
+	*str = ep;
+	switch (base) {
+	case 16:
+		return CS_VALUE_TYPE_HEXADECIMAL;
+	case 8:
+		return CS_VALUE_TYPE_OCTAL;
+	default:
+		return CS_VALUE_TYPE_DECIMAL;
+	}
+}
+
+/**
+ * cs_get_dqword - cs_get_name() for a quoted string.
+ *
+ * @start: String to parse.
+ *
+ * Returns pointer to "struct cs_path_info" on success, NULL otherwise.
+ */
+static const struct cs_path_info *cs_get_dqword(char *start)
+{
+	char *cp = start + strlen(start) - 1;
+
+	if (cp == start || *start++ != '"' || *cp != '"')
+		return NULL;
+	*cp = '\0';
+	if (*start && !cs_correct_word(start))
+		return NULL;
+	return cs_get_name(start);
+}
+
+/**
+ * cs_same_condition - Check for duplicated "struct cs_condition" entry.
+ *
+ * @a: Pointer to "struct cs_condition".
+ * @b: Pointer to "struct cs_condition".
+ *
+ * Returns true if @a == @b, false otherwise.
+ */
+static inline bool cs_same_condition(const struct cs_condition *a,
+				     const struct cs_condition *b)
+{
+	return a->size == b->size &&
+		!memcmp(a + 1, b + 1, a->size - sizeof(*a));
+}
+
+/**
+ * cs_commit_condition - Commit "struct cs_condition".
+ *
+ * @entry: Pointer to "struct cs_condition".
+ *
+ * Returns pointer to "struct cs_condition" on success, NULL otherwise.
+ *
+ * This function merges duplicated entries. This function returns NULL if
+ * @entry is not duplicated but memory quota for policy has exceeded.
+ */
+static struct cs_condition *cs_commit_condition(struct cs_condition *entry)
+{
+	struct cs_condition *ptr = kmemdup(entry, entry->size, GFP_NOFS);
+	bool found = false;
+
+	if (ptr) {
+		kfree(entry);
+		entry = ptr;
+	}
+	if (mutex_lock_killable(&cs_policy_lock)) {
+		dprintk(KERN_WARNING "%u: %s failed\n", __LINE__, __func__);
+		ptr = NULL;
+		found = true;
+		goto out;
+	}
+	list_for_each_entry(ptr, &cs_condition_list, head.list) {
+		if (!cs_same_condition(ptr, entry) ||
+		    atomic_read(&ptr->head.users) == CS_GC_IN_PROGRESS)
+			continue;
+		/* Same entry found. Share this entry. */
+		atomic_inc(&ptr->head.users);
+		found = true;
+		break;
+	}
+	if (!found) {
+		if (cs_memory_ok(entry)) {
+			atomic_set(&entry->head.users, 1);
+			list_add(&entry->head.list, &cs_condition_list);
+		} else {
+			found = true;
+			ptr = NULL;
+		}
+	}
+	mutex_unlock(&cs_policy_lock);
+out:
+	if (found) {
+		cs_del_condition(&entry->head.list);
+		kfree(entry);
+		entry = ptr;
+	}
+	return entry;
+}
+
+/**
+ * cs_correct_domain - Check whether the given domainname follows the naming rules.
+ *
+ * @domainname: The domainname to check.
+ *
+ * Returns true if @domainname follows the naming rules, false otherwise.
+ */
+static bool cs_correct_domain(const unsigned char *domainname)
+{
+	if (!cs_correct_word(domainname))
+		return false;
+	while (*domainname) {
+		if (*domainname++ != '\\')
+			continue;
+		if (*domainname < '0' || *domainname++ > '3')
+			return false;
+	}
+	return true;
+}
+
+/**
+ * cs_normalize_line - Format string.
+ *
+ * @buffer: The line to normalize.
+ *
+ * Returns nothing.
+ *
+ * Leading and trailing whitespaces are removed.
+ * Multiple whitespaces are packed into single space.
+ */
+static void cs_normalize_line(unsigned char *buffer)
+{
+	unsigned char *sp = buffer;
+	unsigned char *dp = buffer;
+	bool first = true;
+
+	while (*sp && (*sp <= ' ' || *sp >= 127))
+		sp++;
+	while (*sp) {
+		if (!first)
+			*dp++ = ' ';
+		first = false;
+		while (*sp > ' ' && *sp < 127)
+			*dp++ = *sp++;
+		while (*sp && (*sp <= ' ' || *sp >= 127))
+			sp++;
+	}
+	*dp = '\0';
+}
+
+/**
+ * cs_parse_values - Parse an numeric argument.
+ *
+ * @value: Values to parse.
+ * @v:     Pointer to "unsigned long".
+ *
+ * Returns "enum cs_value_type" if @value is a single value, bitwise-OR-ed
+ * value if @value is value range.
+ */
+static u8 cs_parse_values(char *value, unsigned long v[2])
+{
+	enum cs_value_type radix1 = cs_parse_ulong(&v[0], &value);
+	enum cs_value_type radix2;
+
+	if (radix1 == CS_VALUE_TYPE_INVALID)
+		return CS_VALUE_TYPE_INVALID;
+	if (!*value) {
+		v[1] = v[0];
+		return radix1;
+	}
+	if (*value++ != '-')
+		return CS_VALUE_TYPE_INVALID;
+	radix2 = cs_parse_ulong(&v[1], &value);
+	if (radix2 == CS_VALUE_TYPE_INVALID || *value || v[0] > v[1])
+		return CS_VALUE_TYPE_INVALID;
+	return radix1 | (radix2 << 2);
+}
+
+#ifdef CONFIG_SECURITY_CAITSITH_NETWORK
+
+/**
+ * cs_parse_ipaddr - Parse an IP address.
+ *
+ * @address: Address to parse.
+ * @ipv6:    Pointer to "struct in6_addr".
+ *
+ * Returns one of values in "enum cs_conditions_index".
+ */
+static enum cs_conditions_index cs_parse_ipaddr(char *address,
+						struct in6_addr ipv6[2])
+{
+	const char *end;
+
+	if (!strchr(address, ':') &&
+	    in4_pton(address, -1, ipv6[0].s6_addr, '-', &end) > 0) {
+		if (!*end) {
+			ipv6[0].s6_addr32[0] = ipv6[0].s6_addr32[0];
+			ipv6[1].s6_addr32[0] = ipv6[0].s6_addr32[0];
+			return CS_IMM_IPV4ADDR_ENTRY1;
+		}
+		if (*end++ != '-' ||
+		    in4_pton(end, -1, ipv6[1].s6_addr, '\0', &end) <= 0 ||
+		    *end || memcmp(&ipv6[0], &ipv6[1], 4) >= 0)
+			return CS_INVALID_CONDITION;
+		return CS_IMM_IPV4ADDR_ENTRY2;
+	}
+	if (in6_pton(address, -1, ipv6[0].s6_addr, '-', &end) > 0) {
+		if (!*end) {
+			ipv6[1] = ipv6[0];
+			return CS_IMM_IPV6ADDR_ENTRY1;
+		}
+		if (*end++ != '-' ||
+		    in6_pton(end, -1, ipv6[1].s6_addr, '\0', &end) <= 0 ||
+		    *end || memcmp(&ipv6[0], &ipv6[1], 16) >= 0)
+			return CS_INVALID_CONDITION;
+		return CS_IMM_IPV6ADDR_ENTRY2;
+	}
+	return CS_INVALID_CONDITION;
+}
+
+#endif
+
+/**
+ * cs_parse_lefthand - Parse special lefthand conditions.
+ *
+ * @word: Keyword to search.
+ * @mac:  One of values in "enum cs_mac_index".
+ * @tmp:  Pointer to "struct cs_cond_tmp".
+ *
+ * Returns one of values in "enum cs_conditions_index".
+ */
+static enum cs_conditions_index cs_parse_lefthand
+(char *word, const enum cs_mac_index mac, struct cs_cond_tmp *tmp)
+{
+	if (mac == CS_MAC_EXECUTE || mac == CS_MAC_ENVIRON) {
+		tmp->type = CS_TYPE_STRING;
+		if (!strncmp(word, "argv[", 5)) {
+			word += 5;
+			if (cs_parse_ulong(&tmp->argv, &word) ==
+			    CS_VALUE_TYPE_DECIMAL && !strcmp(word, "]"))
+				return CS_ARGV_ENTRY;
+		} else if (!strncmp(word, "envp[\"", 6)) {
+			char *end = word + strlen(word) - 2;
+
+			if (!strcmp(end, "\"]")) {
+				*end = '\0';
+				tmp->envp = cs_get_name(word + 6);
+				if (tmp->envp)
+					return CS_ENVP_ENTRY;
+			}
+		}
+	}
+	return CS_INVALID_CONDITION;
+}
+
+/**
+ * cs_parse_righthand - Parse special righthand conditions.
+ *
+ * @word: Keyword to search.
+ * @head: Pointer to "struct cs_io_buffer".
+ * @tmp:  Pointer to "struct cs_cond_tmp".
+ *
+ * Returns one of values in "enum cs_conditions_index".
+ */
+static enum cs_conditions_index cs_parse_righthand
+(char *word, struct cs_io_buffer *head, struct cs_cond_tmp *tmp)
+{
+	const enum cs_var_type type = tmp->type;
+
+	dprintk(KERN_WARNING "%u: tmp->left=%u type=%u\n",
+		__LINE__, tmp->left, type);
+	if (type == CS_TYPE_ASSIGN) {
+		if (tmp->is_not)
+			goto out;
+		if (!strcmp(word, "NULL"))
+			goto null_word;
+		tmp->path = cs_get_dqword(word);
+		if (tmp->path && tmp->path->const_len == tmp->path->total_len)
+			return CS_IMM_NAME_ENTRY;
+		goto out;
+	}
+	if (word[0] == '@' && word[1]) {
+		enum cs_group_id g;
+
+		if (type == CS_TYPE_NUMBER || type == CS_TYPE_FILEPERM)
+			g = CS_NUMBER_GROUP;
+		else if (type == CS_TYPE_STRING)
+			g = CS_STRING_GROUP;
+#ifdef CONFIG_SECURITY_CAITSITH_NETWORK
+		else if (type == CS_TYPE_IPADDR)
+			g = CS_IP_GROUP;
+#endif
+		else
+			goto out;
+		head->w.data = word + 1;
+		tmp->group = cs_get_group(head, g);
+		if (tmp->group)
+			return CS_IMM_GROUP;
+		goto out;
+	}
+	if (type == CS_TYPE_NUMBER || type == CS_TYPE_FILEPERM) {
+		tmp->radix = cs_parse_values(word, tmp->value);
+		if (tmp->radix == CS_VALUE_TYPE_INVALID)
+			goto out;
+		if (tmp->radix >> 2)
+			return CS_IMM_NUMBER_ENTRY2;
+		else
+			return CS_IMM_NUMBER_ENTRY1;
+	}
+	if (type == CS_TYPE_STRING) {
+		dprintk(KERN_WARNING "%u: word='%s'\n", __LINE__, word);
+		if (!strcmp(word, "NULL"))
+			goto null_word;
+		tmp->path = cs_get_dqword(word);
+		dprintk(KERN_WARNING "%u: tmp->path=%p\n", __LINE__,
+			tmp->path);
+		if (tmp->path)
+			return CS_IMM_NAME_ENTRY;
+		goto out;
+	}
+#ifdef CONFIG_SECURITY_CAITSITH_NETWORK
+	if (type == CS_TYPE_IPADDR)
+		return cs_parse_ipaddr(word, tmp->ipv6);
+#endif
+out:
+	dprintk(KERN_WARNING "%u: righthand failed\n", __LINE__);
+	return CS_INVALID_CONDITION;
+null_word:
+	tmp->path = &cs_null_name;
+	return CS_IMM_NAME_ENTRY;
+}
+
+/**
+ * cs_condindex - Get condition's index.
+ *
+ * @word: Name of condition.
+ * @mac:  One of values in "enum cs_mac_index".
+ * @tmp:  Pointer to "struct cs_cond_tmp".
+ * @left: True if lefthand part, false otherwise.
+ *
+ * Returns one of values in "enum cs_condition_index".
+ */
+static enum cs_conditions_index cs_condindex(const char *word,
+					     const enum cs_mac_index mac,
+					     struct cs_cond_tmp *tmp,
+					     const bool lefthand)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(cs_conditions); i++) {
+		if (!(cs_conditions[i].available & F(mac)) ||
+		    strcmp(cs_conditions[i].keyword, word))
+			continue;
+		tmp->type = lefthand ? cs_conditions[i].left_type :
+			cs_conditions[i].right_type;
+		if (tmp->type != CS_TYPE_INVALID)
+			return cs_conditions[i].cmd;
+		break;
+	}
+	return CS_INVALID_CONDITION;
+}
+
+/**
+ * cs_parse_cond - Parse single condition.
+ *
+ * @tmp:  Pointer to "struct cs_cond_tmp".
+ * @head: Pointer to "struct cs_io_buffer".
+ *
+ * Returns true on success, false otherwise.
+ */
+static bool cs_parse_cond(struct cs_cond_tmp *tmp,
+			  struct cs_io_buffer *head)
+{
+	char *left = head->w.data;
+	char *right;
+	const enum cs_mac_index mac = head->w.acl_index;
+	enum cs_var_type type = CS_TYPE_STRING;
+
+	dprintk(KERN_WARNING "%u: type=%u word='%s'\n",
+		__LINE__, mac, left);
+	right = strchr(left, '=');
+	if (!right || right == left)
+		return false;
+	*right++ = '\0';
+	tmp->is_not = (*(right - 2) == '!');
+	if (tmp->is_not)
+		*(right - 2) = '\0';
+	if (!*left || !*right)
+		return false;
+	tmp->left = cs_condindex(left, mac, tmp, true);
+	dprintk(KERN_WARNING "%u: tmp->left=%u\n", __LINE__, tmp->left);
+	if (tmp->left == CS_INVALID_CONDITION) {
+		tmp->left = cs_parse_lefthand(left, mac, tmp);
+		dprintk(KERN_WARNING "%u: tmp->left=%u\n", __LINE__,
+			tmp->left);
+		if (tmp->left == CS_INVALID_CONDITION)
+			return false;
+	} else {
+		type = tmp->type;
+	}
+	dprintk(KERN_WARNING "%u: tmp->type=%u\n", __LINE__, tmp->type);
+	tmp->right = cs_condindex(right, mac, tmp, false);
+	dprintk(KERN_WARNING "%u: tmp->right=%u tmp->type=%u\n",
+		__LINE__, tmp->right, tmp->type);
+	if (tmp->right != CS_INVALID_CONDITION && type != tmp->type &&
+	    !(type == CS_TYPE_FILEPERM && tmp->type == CS_TYPE_NUMBER))
+		return false;
+	if (tmp->right == CS_INVALID_CONDITION)
+		tmp->right = cs_parse_righthand(right, head, tmp);
+	dprintk(KERN_WARNING "%u: tmp->right=%u tmp->type=%u\n",
+		__LINE__, tmp->right, tmp->type);
+	return tmp->right != CS_INVALID_CONDITION;
+}
+
+/**
+ * cs_get_condition - Parse condition part.
+ *
+ * @head: Pointer to "struct cs_io_buffer".
+ *
+ * Returns pointer to "struct cs_condition" on success, NULL otherwise.
+ */
+static struct cs_condition *cs_get_condition(struct cs_io_buffer *head)
+{
+	struct cs_condition *entry = kzalloc(PAGE_SIZE, GFP_NOFS);
+	union cs_condition_element *condp;
+	struct cs_cond_tmp tmp;
+	const enum cs_mac_index type = head->w.acl_index;
+	bool transit_domain_done = head->w.is_deny ||
+		!(F(type) &
+		  (F(CS_MAC_EXECUTE) | F(CS_MAC_AUTO_DOMAIN_TRANSITION) |
+		   CS_INET_SOCKET_OK | CS_UNIX_SOCKET_OK));
+	char *pos = head->w.data;
+
+	if (!entry)
+		return NULL;
+	condp = (union cs_condition_element *) (entry + 1);
+	while (1) {
+		memset(&tmp, 0, sizeof(tmp));
+		/*
+		 * tmp.left = CS_INVALID_CONDITION;
+		 * tmp.right = CS_INVALID_CONDITION;
+		 */
+		while (*pos == ' ')
+			pos++;
+		if (!*pos)
+			break;
+		if ((u8 *) condp >= ((u8 *) entry) + PAGE_SIZE
+		    - (sizeof(*condp) + sizeof(struct in6_addr) * 2))
+			goto out;
+		{
+			char *next = strchr(pos, ' ');
+
+			if (next)
+				*next++ = '\0';
+			else
+				next = "";
+			head->w.data = pos;
+			pos = next;
+		}
+		if (!cs_parse_cond(&tmp, head))
+			goto out;
+		if (tmp.left == CS_TRANSIT_DOMAIN) {
+			if (transit_domain_done)
+				goto out;
+			transit_domain_done = true;
+		}
+		condp->is_not = tmp.is_not;
+		condp->left = tmp.left;
+		condp->right = tmp.right;
+		condp->radix = tmp.radix;
+		condp++;
+		if (tmp.left == CS_ARGV_ENTRY) {
+			condp->value = tmp.argv;
+			condp++;
+		} else if (tmp.left == CS_ENVP_ENTRY) {
+			condp->path = tmp.envp;
+			condp++;
+		}
+		if (tmp.right == CS_IMM_GROUP) {
+			condp->group = tmp.group;
+			condp++;
+		} else if (tmp.right == CS_IMM_NAME_ENTRY) {
+			condp->path = tmp.path;
+			condp++;
+		} else if (tmp.right == CS_IMM_NUMBER_ENTRY1 ||
+			   tmp.right == CS_IMM_NUMBER_ENTRY2) {
+			condp->value = tmp.value[0];
+			condp++;
+			if (tmp.right == CS_IMM_NUMBER_ENTRY2) {
+				condp->value = tmp.value[1];
+				condp++;
+			}
+#ifdef CONFIG_SECURITY_CAITSITH_NETWORK
+		} else if (tmp.right == CS_IMM_IPV4ADDR_ENTRY1 ||
+			   tmp.right == CS_IMM_IPV4ADDR_ENTRY2) {
+			condp->ip = *(u32 *) &tmp.ipv6[0];
+			condp++;
+			if (tmp.right == CS_IMM_IPV4ADDR_ENTRY2) {
+				condp->ip = *(u32 *) &tmp.ipv6[1];
+				condp++;
+			}
+		} else if (tmp.right == CS_IMM_IPV6ADDR_ENTRY1 ||
+			   tmp.right == CS_IMM_IPV6ADDR_ENTRY2) {
+			*(struct in6_addr *) condp = tmp.ipv6[0];
+			condp = (void *) (((u8 *) condp) +
+					  sizeof(struct in6_addr));
+			if (tmp.right == CS_IMM_IPV6ADDR_ENTRY2) {
+				*(struct in6_addr *) condp = tmp.ipv6[1];
+				condp = (void *) (((u8 *) condp) +
+						  sizeof(struct in6_addr));
+			}
+#endif
+		}
+	}
+#ifdef CONFIG_SECURITY_CAITSITH_AUTO_DOMAIN_TRANSITION
+	if (!transit_domain_done && type == CS_MAC_AUTO_DOMAIN_TRANSITION)
+		goto out;
+#endif
+	entry->size = (void *) condp - (void *) entry;
+	return cs_commit_condition(entry);
+out:
+	dprintk(KERN_WARNING
+		"%u: bad condition: type=%u env='%s' path='%s' group='%s'\n",
+		__LINE__, type, tmp.envp ? tmp.envp->name : "",
+		tmp.path ? tmp.path->name : "",
+		tmp.group ? tmp.group->group_name->name : "");
+	cs_put_name(tmp.envp);
+	if (tmp.path != &cs_null_name)
+		cs_put_name(tmp.path);
+	cs_put_group(tmp.group);
+	entry->size = (void *) condp - (void *) entry;
+	cs_del_condition(&entry->head.list);
+	kfree(entry);
+	return NULL;
+}
-- 
2.18.4

