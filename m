Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32EA2C433FE
	for <linux-security-module@archiver.kernel.org>; Wed,  2 Nov 2022 17:12:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230006AbiKBRMU (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 2 Nov 2022 13:12:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231636AbiKBRLn (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 2 Nov 2022 13:11:43 -0400
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43E6D1A068
        for <linux-security-module@vger.kernel.org>; Wed,  2 Nov 2022 10:11:41 -0700 (PDT)
Received: from fsav119.sakura.ne.jp (fsav119.sakura.ne.jp [27.133.134.246])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 2A2HAt4H021875;
        Thu, 3 Nov 2022 02:10:55 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav119.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav119.sakura.ne.jp);
 Thu, 03 Nov 2022 02:10:55 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav119.sakura.ne.jp)
Received: from localhost.localdomain (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 2A2HAnkF021849
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 3 Nov 2022 02:10:55 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
To:     linux-security-module@vger.kernel.org,
        Casey Schaufler <casey@schaufler-ca.com>,
        Paul Moore <paul@paul-moore.com>,
        John Johansen <john.johansen@canonical.com>,
        Kees Cook <kees@kernel.org>
Cc:     Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Subject: [PATCH 04/10] CaitSith: Add header file.
Date:   Thu,  3 Nov 2022 02:10:19 +0900
Message-Id: <20221102171025.126961-4-penguin-kernel@I-love.SAKURA.ne.jp>
X-Mailer: git-send-email 2.18.4
In-Reply-To: <20221102171025.126961-1-penguin-kernel@I-love.SAKURA.ne.jp>
References: <20221102171025.126961-1-penguin-kernel@I-love.SAKURA.ne.jp>
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

The main point of this submission is to demonstrate how an LSM module
which can be loaded using /sbin/insmod can work, and to provide
consideration points for making changes for LSM stacking in a way that
will not lock out LSM modules which can be loaded using /sbin/insmod .

CaitSith was developed as next version of TOMOYO. But since it became
too different to call as TOMOYO (this was a fundamental change as if
SELinux stops using filesystem's extended attributes), I gave this module
a new name. Background of developing this module is explained in
https://I-love.SAKURA.ne.jp/tomoyo/CaitSith-en.pdf .

This file defines constants, structures, and inline functions used by
CaitSith. Please ignore redundancy, for this submission is just an output
 from repository which supports 2.6.27+ kernels with LINUX_VERSION_CODE
removed.

Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
---
 security/caitsith/caitsith.h | 919 +++++++++++++++++++++++++++++++++++
 1 file changed, 919 insertions(+)
 create mode 100644 security/caitsith/caitsith.h

diff --git a/security/caitsith/caitsith.h b/security/caitsith/caitsith.h
new file mode 100644
index 000000000000..b85050d2d5e3
--- /dev/null
+++ b/security/caitsith/caitsith.h
@@ -0,0 +1,919 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * caitsith.h
+ *
+ * Copyright (C) 2005-2012  NTT DATA CORPORATION
+ *
+ * Version: 0.2.10   2021/06/06
+ */
+
+#ifndef _SECURITY_CAITSITH_INTERNAL_H
+#define _SECURITY_CAITSITH_INTERNAL_H
+
+#include <linux/types.h>
+#include <linux/kernel.h>
+#include <linux/string.h>
+#include <linux/mm.h>
+#include <linux/utime.h>
+#include <linux/file.h>
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/slab.h>
+#include <linux/highmem.h>
+#include <linux/poll.h>
+#include <linux/binfmts.h>
+#include <linux/delay.h>
+#include <linux/sched.h>
+#include <linux/dcache.h>
+#include <linux/mount.h>
+#include <linux/net.h>
+#include <linux/inet.h>
+#include <linux/in.h>
+#include <linux/in6.h>
+#include <linux/un.h>
+#include <linux/namei.h>
+#include <linux/fs_struct.h>
+#include <linux/hash.h>
+#include <linux/kthread.h>
+#include <linux/magic.h>
+#include <linux/uaccess.h>
+#include <linux/sched/signal.h>
+#include <net/sock.h>
+#include <net/af_unix.h>
+#include <net/ip.h>
+#include <net/ipv6.h>
+#include <net/udp.h>
+#include <linux/ctype.h>
+#include <linux/magic.h>
+#include <uapi/linux/mount.h>
+#include <linux/uidgid.h>
+
+/* Index numbers for Capability Controls. */
+enum cs_capability_acl_index {
+	/* socket(PF_ROUTE, *, *)                                      */
+	CS_USE_ROUTE_SOCKET,
+	/* socket(PF_PACKET, *, *)                                     */
+	CS_USE_PACKET_SOCKET,
+	CS_MAX_CAPABILITY_INDEX
+};
+
+/* Enumeration definition for internal use. */
+
+/* Index numbers for "struct cs_condition". */
+enum cs_conditions_index {
+	CS_INVALID_CONDITION,
+	CS_SELF_UID,             /* current_uid()   */
+	CS_SELF_EUID,            /* current_euid()  */
+	CS_SELF_SUID,            /* current_suid()  */
+	CS_SELF_FSUID,           /* current_fsuid() */
+	CS_SELF_GID,             /* current_gid()   */
+	CS_SELF_EGID,            /* current_egid()  */
+	CS_SELF_SGID,            /* current_sgid()  */
+	CS_SELF_FSGID,           /* current_fsgid() */
+	CS_SELF_PID,             /* sys_getpid()   */
+	CS_SELF_PPID,            /* sys_getppid()  */
+	CS_SELF_DOMAIN,
+	CS_SELF_EXE,
+	CS_EXEC_ARGC,            /* "struct linux_binprm *"->argc */
+	CS_EXEC_ENVC,            /* "struct linux_binprm *"->envc */
+	CS_OBJ_IS_SOCKET,        /* S_IFSOCK */
+	CS_OBJ_IS_SYMLINK,       /* S_IFLNK */
+	CS_OBJ_IS_FILE,          /* S_IFREG */
+	CS_OBJ_IS_BLOCK_DEV,     /* S_IFBLK */
+	CS_OBJ_IS_DIRECTORY,     /* S_IFDIR */
+	CS_OBJ_IS_CHAR_DEV,      /* S_IFCHR */
+	CS_OBJ_IS_FIFO,          /* S_IFIFO */
+	CS_MODE_SETUID,          /* S_ISUID */
+	CS_MODE_SETGID,          /* S_ISGID */
+	CS_MODE_STICKY,          /* S_ISVTX */
+	CS_MODE_OWNER_READ,      /* S_IRUSR */
+	CS_MODE_OWNER_WRITE,     /* S_IWUSR */
+	CS_MODE_OWNER_EXECUTE,   /* S_IXUSR */
+	CS_MODE_GROUP_READ,      /* S_IRGRP */
+	CS_MODE_GROUP_WRITE,     /* S_IWGRP */
+	CS_MODE_GROUP_EXECUTE,   /* S_IXGRP */
+	CS_MODE_OTHERS_READ,     /* S_IROTH */
+	CS_MODE_OTHERS_WRITE,    /* S_IWOTH */
+	CS_MODE_OTHERS_EXECUTE,  /* S_IXOTH */
+	CS_TRANSIT_DOMAIN,
+	CS_COND_SARG0,
+	CS_COND_SARG1,
+	CS_COND_SARG2,
+	CS_COND_SARG3,
+	CS_COND_NARG0,
+	CS_COND_NARG1,
+	CS_COND_NARG2,
+	CS_COND_IPARG,
+	CS_COND_DOMAIN,
+	CS_IMM_GROUP,
+	CS_IMM_NAME_ENTRY,
+	CS_IMM_NUMBER_ENTRY1,
+	CS_IMM_NUMBER_ENTRY2,
+#ifdef CONFIG_SECURITY_CAITSITH_NETWORK
+	CS_IMM_IPV4ADDR_ENTRY1,
+	CS_IMM_IPV4ADDR_ENTRY2,
+	CS_IMM_IPV6ADDR_ENTRY1,
+	CS_IMM_IPV6ADDR_ENTRY2,
+#endif
+	CS_ARGV_ENTRY,
+	CS_ENVP_ENTRY,
+	CS_PATH_ATTRIBUTE_START = 192,
+	CS_PATH_ATTRIBUTE_END = 255
+} __packed;
+
+enum cs_path_attribute_index {
+	CS_PATH_ATTRIBUTE_UID,
+	CS_PATH_ATTRIBUTE_GID,
+	CS_PATH_ATTRIBUTE_INO,
+	CS_PATH_ATTRIBUTE_TYPE,
+	CS_PATH_ATTRIBUTE_MAJOR,
+	CS_PATH_ATTRIBUTE_MINOR,
+	CS_PATH_ATTRIBUTE_PERM,
+	CS_PATH_ATTRIBUTE_DEV_MAJOR,
+	CS_PATH_ATTRIBUTE_DEV_MINOR,
+	CS_PATH_ATTRIBUTE_FSMAGIC,
+	CS_MAX_PATH_ATTRIBUTE
+} __packed;
+
+/* Index numbers for group entries. */
+enum cs_group_id {
+	CS_STRING_GROUP,
+	CS_NUMBER_GROUP,
+#ifdef CONFIG_SECURITY_CAITSITH_NETWORK
+	CS_IP_GROUP,
+#endif
+	CS_MAX_GROUP
+} __packed;
+
+/* Index numbers for functionality. */
+enum cs_mac_index {
+	CS_MAC_EXECUTE,
+	CS_MAC_READ,
+	CS_MAC_WRITE,
+	CS_MAC_APPEND,
+	CS_MAC_CREATE,
+	CS_MAC_UNLINK,
+#ifdef CONFIG_SECURITY_CAITSITH_GETATTR
+	CS_MAC_GETATTR,
+#endif
+	CS_MAC_MKDIR,
+	CS_MAC_RMDIR,
+	CS_MAC_MKFIFO,
+	CS_MAC_MKSOCK,
+	CS_MAC_TRUNCATE,
+	CS_MAC_SYMLINK,
+	CS_MAC_MKBLOCK,
+	CS_MAC_MKCHAR,
+	CS_MAC_LINK,
+	CS_MAC_RENAME,
+	CS_MAC_CHMOD,
+	CS_MAC_CHOWN,
+	CS_MAC_CHGRP,
+	CS_MAC_IOCTL,
+	CS_MAC_CHROOT,
+	CS_MAC_MOUNT,
+	CS_MAC_UMOUNT,
+	CS_MAC_PIVOT_ROOT,
+#ifdef CONFIG_SECURITY_CAITSITH_NETWORK
+	CS_MAC_INET_STREAM_BIND,
+	CS_MAC_INET_STREAM_LISTEN,
+	CS_MAC_INET_STREAM_CONNECT,
+	CS_MAC_INET_STREAM_ACCEPT,
+	CS_MAC_INET_DGRAM_BIND,
+	CS_MAC_INET_DGRAM_SEND,
+	CS_MAC_INET_RAW_BIND,
+	CS_MAC_INET_RAW_SEND,
+	CS_MAC_UNIX_STREAM_BIND,
+	CS_MAC_UNIX_STREAM_LISTEN,
+	CS_MAC_UNIX_STREAM_CONNECT,
+	CS_MAC_UNIX_STREAM_ACCEPT,
+	CS_MAC_UNIX_DGRAM_BIND,
+	CS_MAC_UNIX_DGRAM_SEND,
+	CS_MAC_UNIX_SEQPACKET_BIND,
+	CS_MAC_UNIX_SEQPACKET_LISTEN,
+	CS_MAC_UNIX_SEQPACKET_CONNECT,
+	CS_MAC_UNIX_SEQPACKET_ACCEPT,
+#endif
+#ifdef CONFIG_SECURITY_CAITSITH_ENVIRON
+	CS_MAC_ENVIRON,
+#endif
+	CS_MAC_MODIFY_POLICY,
+#ifdef CONFIG_SECURITY_CAITSITH_CAPABILITY
+	CS_MAC_USE_NETLINK_SOCKET,
+	CS_MAC_USE_PACKET_SOCKET,
+#endif
+#ifdef CONFIG_SECURITY_CAITSITH_AUTO_DOMAIN_TRANSITION
+	CS_MAC_AUTO_DOMAIN_TRANSITION,
+#endif
+#ifdef CONFIG_SECURITY_CAITSITH_MANUAL_DOMAIN_TRANSITION
+	CS_MAC_MANUAL_DOMAIN_TRANSITION,
+#endif
+	CS_MAX_MAC_INDEX,
+	/* Map undefined functions to CS_MAX_MAC_INDEX */
+#ifndef CONFIG_SECURITY_CAITSITH_GETATTR
+	CS_MAC_GETATTR = CS_MAX_MAC_INDEX,
+#endif
+#ifndef CONFIG_SECURITY_CAITSITH_NETWORK
+	CS_MAC_INET_STREAM_BIND = CS_MAX_MAC_INDEX,
+	CS_MAC_INET_STREAM_LISTEN = CS_MAX_MAC_INDEX,
+	CS_MAC_INET_STREAM_CONNECT = CS_MAX_MAC_INDEX,
+	CS_MAC_INET_STREAM_ACCEPT = CS_MAX_MAC_INDEX,
+	CS_MAC_INET_DGRAM_BIND = CS_MAX_MAC_INDEX,
+	CS_MAC_INET_DGRAM_SEND = CS_MAX_MAC_INDEX,
+	CS_MAC_INET_RAW_BIND = CS_MAX_MAC_INDEX,
+	CS_MAC_INET_RAW_SEND = CS_MAX_MAC_INDEX,
+	CS_MAC_UNIX_STREAM_BIND = CS_MAX_MAC_INDEX,
+	CS_MAC_UNIX_STREAM_LISTEN = CS_MAX_MAC_INDEX,
+	CS_MAC_UNIX_STREAM_CONNECT = CS_MAX_MAC_INDEX,
+	CS_MAC_UNIX_STREAM_ACCEPT = CS_MAX_MAC_INDEX,
+	CS_MAC_UNIX_DGRAM_BIND = CS_MAX_MAC_INDEX,
+	CS_MAC_UNIX_DGRAM_SEND = CS_MAX_MAC_INDEX,
+	CS_MAC_UNIX_SEQPACKET_BIND = CS_MAX_MAC_INDEX,
+	CS_MAC_UNIX_SEQPACKET_LISTEN = CS_MAX_MAC_INDEX,
+	CS_MAC_UNIX_SEQPACKET_CONNECT = CS_MAX_MAC_INDEX,
+	CS_MAC_UNIX_SEQPACKET_ACCEPT = CS_MAX_MAC_INDEX,
+#endif
+#ifndef CONFIG_SECURITY_CAITSITH_ENVIRON
+	CS_MAC_ENVIRON = CS_MAX_MAC_INDEX,
+#endif
+#ifndef CONFIG_SECURITY_CAITSITH_CAPABILITY
+	CS_MAC_USE_NETLINK_SOCKET = CS_MAX_MAC_INDEX,
+	CS_MAC_USE_PACKET_SOCKET = CS_MAX_MAC_INDEX,
+#endif
+#ifndef CONFIG_SECURITY_CAITSITH_AUTO_DOMAIN_TRANSITION
+	CS_MAC_AUTO_DOMAIN_TRANSITION = CS_MAX_MAC_INDEX,
+#endif
+#ifndef CONFIG_SECURITY_CAITSITH_MANUAL_DOMAIN_TRANSITION
+	CS_MAC_MANUAL_DOMAIN_TRANSITION = CS_MAX_MAC_INDEX,
+#endif
+} __packed;
+
+/* Index numbers for statistic information. */
+enum cs_memory_stat_type {
+	CS_MEMORY_POLICY,
+	CS_MEMORY_AUDIT,
+	CS_MEMORY_QUERY,
+	CS_MAX_MEMORY_STAT
+} __packed;
+
+enum cs_matching_result {
+	CS_MATCHING_UNMATCHED,
+	CS_MATCHING_ALLOWED,
+	CS_MATCHING_DENIED,
+	CS_MAX_MATCHING
+} __packed;
+
+/* Index numbers for stat(). */
+enum cs_path_stat_index {
+	/* Do not change this order. */
+	CS_PATH1,
+	CS_PATH1_PARENT,
+	CS_PATH2,
+	CS_PATH2_PARENT,
+	CS_MAX_PATH_STAT
+} __packed;
+
+/* Index numbers for entry type. */
+enum cs_policy_id {
+	CS_ID_GROUP,
+#ifdef CONFIG_SECURITY_CAITSITH_NETWORK
+	CS_ID_IP_GROUP,
+#endif
+	CS_ID_STRING_GROUP,
+	CS_ID_NUMBER_GROUP,
+	CS_ID_CONDITION,
+	CS_ID_NAME,
+	CS_ID_ACL,
+	CS_ID_DOMAIN,
+	CS_MAX_POLICY
+} __packed;
+
+/* Index numbers for statistic information. */
+enum cs_policy_stat_type {
+	CS_STAT_POLICY_UPDATES,
+	CS_STAT_REQUEST_DENIED,
+	CS_MAX_POLICY_STAT
+} __packed;
+
+/* Index numbers for /sys/kernel/security/caitsith/ interfaces. */
+enum cs_securityfs_interface_index {
+	CS_POLICY,
+	CS_PROCESS_STATUS,
+	CS_AUDIT,
+	CS_VERSION,
+	CS_QUERY,
+} __packed;
+
+/* Index numbers for special mount operations. */
+enum cs_special_mount {
+	CS_MOUNT_BIND,            /* mount --bind /source /dest   */
+	CS_MOUNT_MOVE,            /* mount --move /old /new       */
+	CS_MOUNT_REMOUNT,         /* mount -o remount /dir        */
+	CS_MOUNT_MAKE_UNBINDABLE, /* mount --make-unbindable /dir */
+	CS_MOUNT_MAKE_PRIVATE,    /* mount --make-private /dir    */
+	CS_MOUNT_MAKE_SLAVE,      /* mount --make-slave /dir      */
+	CS_MOUNT_MAKE_SHARED,     /* mount --make-shared /dir     */
+	CS_MAX_SPECIAL_MOUNT
+} __packed;
+
+/* Index numbers for type of numeric values. */
+enum cs_value_type {
+	CS_VALUE_TYPE_INVALID,
+	CS_VALUE_TYPE_DECIMAL,
+	CS_VALUE_TYPE_OCTAL,
+	CS_VALUE_TYPE_HEXADECIMAL,
+} __packed;
+
+/* Constants definition for internal use. */
+
+/*
+ * CaitSith uses this hash only when appending a string into the string table.
+ * Frequency of appending strings is very low. So we don't need large (e.g.
+ * 64k) hash size. 256 will be sufficient.
+ */
+#define CS_HASH_BITS 8
+#define CS_MAX_HASH (1u << CS_HASH_BITS)
+
+/*
+ * CaitSith checks only SOCK_STREAM, SOCK_DGRAM, SOCK_RAW, SOCK_SEQPACKET.
+ * Therefore, we don't need SOCK_MAX.
+ */
+#define CS_SOCK_MAX 6
+
+/* Size of temporary buffer for execve() operation. */
+#define CS_EXEC_TMPSIZE     4096
+
+/* Patterns for auditing logs quota. */
+#define CS_MAX_LOG_QUOTA 256
+
+/* Garbage collector is trying to kfree() this element. */
+#define CS_GC_IN_PROGRESS -1
+
+/* Current thread is doing open(3) ? */
+#define CS_OPEN_FOR_IOCTL_ONLY           2
+/* Current thread is doing do_execve() ? */
+#define CS_TASK_IS_IN_EXECVE             4
+/*
+ * Current thread is allowed to modify policy via
+ * /sys/kernel/security/caitsith/ interface?
+ */
+#define CS_TASK_IS_MANAGER               8
+
+/*
+ * Retry this request. Returned by cs_supervisor() if policy violation has
+ * occurred in enforcing mode and the userspace daemon decided to retry.
+ *
+ * We must choose a positive value in order to distinguish "granted" (which is
+ * 0) and "rejected" (which is a negative value) and "retry".
+ */
+#define CS_RETRY_REQUEST 1
+
+/* Size of read buffer for /sys/kernel/security/caitsith/ interface. */
+#define CS_MAX_IO_READ_QUEUE 64
+
+/* Structure definition for internal use. */
+
+/* Common header for holding ACL entries. */
+struct cs_acl_head {
+	struct list_head list;
+	s8 is_deleted; /* true or false or CS_GC_IN_PROGRESS */
+} __packed;
+
+/* Common header for shared entries. */
+struct cs_shared_acl_head {
+	struct list_head list;
+	atomic_t users;
+} __packed;
+
+/* Common header for individual entries. */
+struct cs_acl_info {
+	struct list_head list;
+	struct list_head acl_info_list;
+	struct cs_condition *cond; /* Maybe NULL. */
+	bool is_deleted;
+	bool is_deny;
+	u16 priority;
+	u8 audit;
+};
+
+/* Structure for "string_group"/"number_group"/"ip_group" directive. */
+struct cs_group {
+	struct cs_shared_acl_head head;
+	/* Name of group (without leading "@"). */
+	const struct cs_path_info *group_name;
+	/*
+	 * List of "struct cs_string_group" or "struct cs_number_group" or
+	 * "struct cs_ip_group".
+	 */
+	struct list_head member_list;
+};
+
+/* Structure for "string_group" directive. */
+struct cs_string_group {
+	struct cs_acl_head head;
+	const struct cs_path_info *member_name;
+};
+
+/* Structure for "number_group" directive. */
+struct cs_number_group {
+	struct cs_acl_head head;
+	u8 radix;
+	unsigned long value[2];
+};
+
+/* Structure for "ip_group" directive. */
+struct cs_ip_group {
+	struct cs_acl_head head;
+	bool is_ipv6;
+	/* Structure for holding an IP address. */
+	struct in6_addr ip[2]; /* Big endian. */
+};
+
+/* Subset of "struct stat". Used by conditional ACL and audit logs. */
+struct cs_mini_stat {
+	kuid_t uid;
+	kgid_t gid;
+	ino_t ino;
+	umode_t mode;
+	dev_t dev;
+	dev_t rdev;
+	unsigned long fsmagic;
+};
+
+/* Structure for dumping argv[] and envp[] of "struct linux_binprm". */
+struct cs_page_dump {
+	struct page *page;    /* Previously dumped page. */
+	char *data;           /* Contents of "page". Size is PAGE_SIZE. */
+};
+
+/* Structure for entries which follows "struct cs_condition". */
+union cs_condition_element {
+	struct {
+		enum cs_conditions_index left;
+		enum cs_conditions_index right;
+		bool is_not;
+		u8 radix;
+	};
+	struct cs_group *group;
+	const struct cs_path_info *path;
+	u32 ip; /* Repeat 4 times if IPv6 address. */
+	unsigned long value;
+};
+
+/* Structure for optional arguments. */
+struct cs_condition {
+	struct cs_shared_acl_head head;
+	u32 size; /* Memory size allocated for this entry. */
+	/* union cs_condition_element condition[]; */
+};
+
+/* Structure for holding a token. */
+struct cs_path_info {
+	const char *name;
+	u32 hash;          /* = full_name_hash(name, strlen(name)) */
+	u32 total_len;     /* = strlen(name)                       */
+	u32 const_len;     /* = cs_const_part_length(name)        */
+};
+
+/* Structure for request info. */
+struct cs_request_info {
+	/* For holding parameters. */
+	struct cs_request_param {
+		const struct cs_path_info *s[4];
+		unsigned long i[3];
+#ifdef CONFIG_SECURITY_CAITSITH_NETWORK
+		const u8 *ip; /* Big endian. */
+		bool is_ipv6;
+#endif
+	} param;
+	/* For holding pathnames and attributes. */
+	struct {
+		/*
+		 * True if cs_get_attributes() was already called, false
+		 * otherwise.
+		 */
+		bool validate_done;
+		/* True if @stat[] is valid. */
+		bool stat_valid[CS_MAX_PATH_STAT];
+		/* Pointer to file objects. */
+		struct path path[2];
+		/*
+		 * Information on @path[0], @path[0]'s parent directory,
+		 * @path[1] and @path[1]'s parent directory.
+		 */
+		struct cs_mini_stat stat[CS_MAX_PATH_STAT];
+		/*
+		 * Name of @path[0] and @path[1].
+		 * Cleared by cs_clear_request_info().
+		 */
+		struct cs_path_info pathname[2];
+	} obj;
+	struct {
+		struct linux_binprm *bprm;
+		struct cs_domain_info *previous_domain;
+		/* For dumping argv[] and envp[]. */
+		struct cs_page_dump dump;
+		/* For temporary use. Size is CS_EXEC_TMPSIZE bytes. */
+		char *tmp;
+	};
+	/*
+	 * Name of current thread's executable.
+	 * Cleared by cs_clear_request_info().
+	 */
+	struct cs_path_info exename;
+	/*
+	 * Matching "struct cs_acl_info" is copied. Used for caitsith-queryd.
+	 * Valid until cs_read_unlock().
+	 */
+	struct cs_acl_info *matched_acl;
+	/*
+	 * Matching domain transition is copied.
+	 * Valid until cs_read_unlock().
+	 */
+	const struct cs_path_info *transition;
+	const struct cs_path_info *transition_candidate;
+	/*
+	 * For holding operation index used for this request.
+	 * One of values in "enum cs_mac_index".
+	 */
+	enum cs_mac_index type;
+	/* For holding matching result. */
+	enum cs_matching_result result;
+	/*
+	 * For counting number of retries made for this request.
+	 * This counter is incremented whenever cs_supervisor() returned
+	 * CS_RETRY_REQUEST.
+	 */
+	u8 retry;
+	/* For holding max audit log count for this matching entry. */
+	u8 audit;
+	/*
+	 * Set to true if condition could not be checked due to out of memory.
+	 * This flag is used for returning out of memory flag back to
+	 * cs_check_acl_list(). Thus, this flag will not be set if out of
+	 * memory occurred before cs_check_acl_list() is called.
+	 */
+	bool failed_by_oom;
+};
+
+/* Structure for domain information. */
+struct cs_domain_info {
+	struct list_head list;
+	/* Name of this domain. Never NULL. */
+	const struct cs_path_info *domainname;
+};
+
+/* Structure for holding string data. */
+struct cs_name {
+	struct cs_shared_acl_head head;
+	int size; /* Memory size allocated for this entry. */
+	struct cs_path_info entry;
+};
+
+/*
+ * Structure for reading/writing policy via /sys/kernel/security/caitsith/
+ * interfaces.
+ */
+struct cs_io_buffer {
+	/* Exclusive lock for this structure.   */
+	struct mutex io_sem;
+	char __user *read_user_buf;
+	size_t read_user_buf_avail;
+	struct {
+		struct list_head *group;
+		struct list_head *acl;
+		struct list_head *subacl;
+		const union cs_condition_element *cond;
+		size_t avail;
+		unsigned int step;
+		unsigned int query_index;
+		u16 index;
+		u8 cond_step;
+		u8 w_pos;
+		enum cs_mac_index acl_index;
+		bool eof;
+		bool print_this_acl_only;
+		bool version_done;
+		bool stat_done;
+		bool quota_done;
+		bool group_done;
+		const char *w[CS_MAX_IO_READ_QUEUE];
+	} r;
+	struct {
+		char *data;
+		struct cs_acl_info *acl;
+		size_t avail;
+		enum cs_mac_index acl_index;
+		bool is_delete;
+		bool is_deny;
+		u16 priority;
+	} w;
+	/* Buffer for reading.                  */
+	char *read_buf;
+	/* Size of read buffer.                 */
+	size_t readbuf_size;
+	/* Buffer for writing.                  */
+	char *write_buf;
+	/* Size of write buffer.                */
+	size_t writebuf_size;
+	/* Type of interface. */
+	enum cs_securityfs_interface_index type;
+	/* Users counter protected by cs_io_buffer_list_lock. */
+	u8 users;
+	/* List for telling GC not to kfree() elements. */
+	struct list_head list;
+};
+
+/* Structure for representing YYYY/MM/DD hh/mm/ss. */
+struct cs_time {
+	u16 year;
+	u8 month;
+	u8 day;
+	u8 hour;
+	u8 min;
+	u8 sec;
+};
+
+/* Prototype definition for internal use. */
+
+int __init cs_init_module(void);
+void cs_check_profile(void);
+bool cs_dump_page(struct linux_binprm *bprm, unsigned long pos,
+		  struct cs_page_dump *dump);
+bool cs_get_exename(struct cs_path_info *buf);
+bool cs_manager(void);
+bool cs_transit_domain(const char *domainname);
+char *cs_encode(const char *str);
+char *cs_encode2(const char *str, int str_len);
+char *cs_realpath(const struct path *path);
+char *cs_get_exe(void);
+int cs_audit_log(struct cs_request_info *r);
+int cs_check_acl(struct cs_request_info *r, const bool clear);
+void cs_del_condition(struct list_head *element);
+void cs_fill_path_info(struct cs_path_info *ptr);
+void cs_get_attributes(struct cs_request_info *r);
+void cs_notify_gc(struct cs_io_buffer *head, const bool is_register);
+void cs_populate_patharg(struct cs_request_info *r, const bool first);
+void cs_transition_failed(const char *domainname);
+void cs_warn_oom(const char *function);
+int cs_chroot_permission(const struct path *path);
+int cs_chmod_permission(const struct path *path, mode_t mode);
+int cs_chown_permission(const struct path *path, kuid_t user, kgid_t group);
+int cs_fcntl_permission(struct file *file, unsigned int cmd,
+			unsigned long arg);
+int cs_ioctl_permission(struct file *filp, unsigned int cmd,
+			unsigned long arg);
+int cs_link_permission(const struct path *old, const struct path *new);
+int cs_mkdir_permission(const struct path *path, unsigned int mode);
+int cs_mknod_permission(const struct path *path, const unsigned int mode,
+			unsigned int dev);
+int cs_mount_permission(const char *dev_name, const struct path *path,
+			const char *type, unsigned long flags,
+			void *data_page);
+int cs_move_mount_permission(const struct path *from_path,
+			     const struct path *to_path);
+int cs_pivot_root_permission(const struct path *old_path,
+			     const struct path *new_path);
+int cs_rename_permission(const struct path *old, const struct path *new);
+int cs_symlink_permission(const struct path *path, const char *from);
+int cs_truncate_permission(const struct path *path);
+int cs_umount_permission(const struct path *path, int flags);
+int cs_unlink_permission(const struct path *path);
+int cs_socket_create_permission(int family, int type, int protocol);
+int cs_socket_bind_permission(struct socket *sock, struct sockaddr *addr,
+			      int addr_len);
+int cs_socket_connect_permission(struct socket *sock, struct sockaddr *addr,
+				 int addr_len);
+int cs_socket_listen_permission(struct socket *sock);
+int cs_socket_post_accept_permission(struct socket *sock,
+				     struct socket *newsock);
+int cs_socket_sendmsg_permission(struct socket *sock,
+				 struct msghdr *msg, int size);
+int cs_rmdir_permission(const struct path *path);
+int cs_getattr_permission(const struct path *path);
+bool cs_capable(const u8 operation);
+int cs_open_permission(const struct path *path, const int flag);
+
+/* Variable definition for internal use. */
+
+extern bool cs_policy_loaded;
+extern struct cs_domain_info cs_kernel_domain;
+extern struct cs_path_info cs_null_name;
+extern struct list_head cs_acl_list[CS_MAX_MAC_INDEX];
+extern struct list_head cs_condition_list;
+extern struct list_head cs_domain_list;
+extern struct list_head cs_group_list[CS_MAX_GROUP];
+extern struct list_head cs_name_list[CS_MAX_HASH];
+extern struct mutex cs_policy_lock;
+extern struct srcu_struct cs_ss;
+extern unsigned int cs_memory_used[CS_MAX_MEMORY_STAT];
+
+/* Inlined functions for internal use. */
+
+/**
+ * cs_pathcmp - strcmp() for "struct cs_path_info" structure.
+ *
+ * @a: Pointer to "struct cs_path_info".
+ * @b: Pointer to "struct cs_path_info".
+ *
+ * Returns true if @a != @b, false otherwise.
+ */
+static inline bool cs_pathcmp(const struct cs_path_info *a,
+			      const struct cs_path_info *b)
+{
+	return a->hash != b->hash || strcmp(a->name, b->name);
+}
+
+/**
+ * cs_read_lock - Take lock for protecting policy.
+ *
+ * Returns index number for cs_read_unlock().
+ */
+static inline int cs_read_lock(void)
+{
+	return srcu_read_lock(&cs_ss);
+}
+
+/**
+ * cs_read_unlock - Release lock for protecting policy.
+ *
+ * @idx: Index number returned by cs_read_lock().
+ *
+ * Returns nothing.
+ */
+static inline void cs_read_unlock(const int idx)
+{
+	srcu_read_unlock(&cs_ss, idx);
+}
+
+/**
+ * cs_sys_getppid - Copy of getppid().
+ *
+ * Returns parent process's PID.
+ *
+ * Alpha does not have getppid() defined. To be able to build this module on
+ * Alpha, I have to copy getppid() from kernel/timer.c.
+ */
+static inline pid_t cs_sys_getppid(void)
+{
+	pid_t pid;
+
+	rcu_read_lock();
+	pid = task_tgid_vnr(rcu_dereference(current->real_parent));
+	rcu_read_unlock();
+	return pid;
+}
+
+/**
+ * cs_sys_getpid - Copy of getpid().
+ *
+ * Returns current thread's PID.
+ *
+ * Alpha does not have getpid() defined. To be able to build this module on
+ * Alpha, I have to copy getpid() from kernel/timer.c.
+ */
+static inline pid_t cs_sys_getpid(void)
+{
+	return task_tgid_vnr(current);
+}
+
+/**
+ * cs_put_condition - Drop reference on "struct cs_condition".
+ *
+ * @cond: Pointer to "struct cs_condition". Maybe NULL.
+ *
+ * Returns nothing.
+ */
+static inline void cs_put_condition(struct cs_condition *cond)
+{
+	if (cond)
+		atomic_dec(&cond->head.users);
+}
+
+/**
+ * cs_put_group - Drop reference on "struct cs_group".
+ *
+ * @group: Pointer to "struct cs_group". Maybe NULL.
+ *
+ * Returns nothing.
+ */
+static inline void cs_put_group(struct cs_group *group)
+{
+	if (group)
+		atomic_dec(&group->head.users);
+}
+
+/**
+ * cs_put_name - Drop reference on "struct cs_name".
+ *
+ * @name: Pointer to "struct cs_path_info". Maybe NULL.
+ *
+ * Returns nothing.
+ */
+static inline void cs_put_name(const struct cs_path_info *name)
+{
+	if (name)
+		atomic_dec(&container_of(name, struct cs_name, entry)->
+			   head.users);
+}
+
+/*
+ * Structure for holding "struct cs_domain_info *" and "u32 cs_flags" for
+ * each "struct task_struct".
+ *
+ * "struct cs_domain_info *" and "u32 cs_flags" for each "struct task_struct"
+ * are maintained outside that "struct task_struct". Therefore, cs_security
+ * != task_struct . This keeps KABI for distributor's prebuilt kernels but
+ * entails slow access.
+ *
+ * Memory for this structure is allocated when current thread tries to access
+ * it. Therefore, if memory allocation failed, current thread will be killed by
+ * SIGKILL. Note that if current->pid == 1, sending SIGKILL won't work.
+ */
+struct cs_security {
+	struct list_head list;
+	const struct task_struct *task;
+	struct cs_domain_info *cs_domain_info;
+	u32 cs_flags;
+	struct cs_request_info *r; /* Maybe NULL. */
+	struct rcu_head rcu;
+};
+
+void __init cs_main_init(void);
+bool cs_used_by_cred(const struct cs_domain_info *domain);
+int cs_start_execve(struct linux_binprm *bprm, struct cs_request_info **rp);
+void cs_finish_execve(int retval, struct cs_request_info *r);
+int cs_sysctl_permission(enum cs_mac_index type,
+			 const struct cs_path_info *filename);
+
+#define CS_TASK_SECURITY_HASH_BITS 12
+#define CS_MAX_TASK_SECURITY_HASH (1u << CS_TASK_SECURITY_HASH_BITS)
+extern struct list_head cs_task_security_list[CS_MAX_TASK_SECURITY_HASH];
+
+struct cs_security *cs_find_task_security(const struct task_struct *task);
+
+/**
+ * cs_current_security - Get "struct cs_security" for current thread.
+ *
+ * Returns pointer to "struct cs_security" for current thread.
+ */
+static inline struct cs_security *cs_current_security(void)
+{
+	return cs_find_task_security(current);
+}
+
+/**
+ * cs_task_domain - Get "struct cs_domain_info" for specified thread.
+ *
+ * @task: Pointer to "struct task_struct".
+ *
+ * Returns pointer to "struct cs_security" for specified thread.
+ */
+static inline struct cs_domain_info *cs_task_domain(struct task_struct *task)
+{
+	struct cs_domain_info *domain;
+
+	rcu_read_lock();
+	domain = cs_find_task_security(task)->cs_domain_info;
+	rcu_read_unlock();
+	return domain;
+}
+
+/**
+ * cs_current_domain - Get "struct cs_domain_info" for current thread.
+ *
+ * Returns pointer to "struct cs_domain_info" for current thread.
+ */
+static inline struct cs_domain_info *cs_current_domain(void)
+{
+	return cs_find_task_security(current)->cs_domain_info;
+}
+
+/**
+ * cs_task_flags - Get flags for specified thread.
+ *
+ * @task: Pointer to "struct task_struct".
+ *
+ * Returns flags for specified thread.
+ */
+static inline u32 cs_task_flags(struct task_struct *task)
+{
+	u32 cs_flags;
+
+	rcu_read_lock();
+	cs_flags = cs_find_task_security(task)->cs_flags;
+	rcu_read_unlock();
+	return cs_flags;
+}
+
+/**
+ * cs_current_flags - Get flags for current thread.
+ *
+ * Returns flags for current thread.
+ */
+static inline u32 cs_current_flags(void)
+{
+	return cs_find_task_security(current)->cs_flags;
+}
+
+#endif
-- 
2.18.4

