Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793630859;
	b=XfUnBxI6uj4U2wTA/VBGlY0lwZEEg0LstPRzwSVmJabSk6eGlR3yhIxwInqniFsagcS1
	 2bsvfpbXV1chqu/d9W0HazPa9Gc0zpwwsSRfL3SADYWwPtDJUVlX0sw5j6aXzO+sdOZq2
	 Hw6NIeJwrIJS1fwnYXC4fMPdDoBm10IJb4YkC6baMcfe5fIFmAPk1PKE7OkZqiHoy5TqU
	 6RGfYdE5loXTG5MjSXnQewMAZTiyO1fi7F0p9cD5BqWbnDUuErHyXg8pjmBnosS1OSKnW
	 NZXMhpCDHg+22iHZSYY3rgS5mJ9Hp1lqRjta2u46LNwiuG3IOOM+XMNsHkM9yGiHZ0Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793630859;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=UcxteNFZtUT/mSyc74EhhVd8FjtKxQOP79DjmK0/UUE=;
	b=UvQgle8EXxZg3pZAPrA0+AfnyyLKRm8jvDv9PC+Oz6/otnCEutkzZRD5Wfp2cLYHEdSg
	 GXtincJbEkbxn7IXHFWSVPo4U3xamiDeuAWqRmDExlQraI2kgvjyZQvsh95TxTRynvWBs
	 d8cFFWEQxcGzxtVhK9pVVfWb8A+2cO47DnYyuLtUKCMilddMDOE1Go8peeY6SFnMl6gKH
	 x4TJP2+9DtCqG1isHB/76MYzrXJvw9BbAQ7TP6N4X/AJ3PBPnhRJ8Pw7Cn2kIBTdvXZwD
	 p6HlWdnbpWJY6dMyIxD8iDGw5HdMCs8R5cRfwNMBJrPw3VwJUfQqpcNxr3daGrdwQoQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=y6iaomxr;
	arc=none smtp.remote-ip=209.85.128.54
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5568D6083622
	for <linux-security-module@vger.kernel.org>; Mon,  2 Nov 2026 14:47:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5568D6083622
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=y6iaomxr
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-49d05d51553so19797455e9.2
        for <linux-security-module@vger.kernel.org>; Mon, 02 Nov 2026 06:47:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793630856; x=1794235656; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=UcxteNFZtUT/mSyc74EhhVd8FjtKxQOP79DjmK0/UUE=;
        b=y6iaomxrFr8PotiUor7KtZ6mrIxuIADAvoI+K+F20MJLbcVcw9c66vyc668ZLKEBWt
         MRjneflKFgJYQVk57UCCbUylr82ncMChR98uz8yopDYCT0fNJfWXIhRYJfNRJ5SPRr66
         BsMH6Jp1UhZBt4zckjctB9QCo4Yf4jZRnk6YjJ3eSWCwe+dl9OvqkGfZICL2C8QUWGRQ
         Bpi80iNpjB/9353tItfWt3VtL9q5ElysXk4Qko/ercTsLQm34h5IDbFH0EFziEpaeG/a
         w7B3d3Bv79UbOixp69hcU/XcCX7GUUA6qTvKqtKWRzE3iKxznL7/YdLccjfy52E8zUP6
         Q1ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793630856; x=1794235656;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=UcxteNFZtUT/mSyc74EhhVd8FjtKxQOP79DjmK0/UUE=;
        b=WH7qLq2GVqxd/wW2vBZdA2bpVWZNomzDFm7HbIrBawqqHTXJTXyDFwGri4D92mLlIF
         vUieJj+WcOMOakqni5e0W738cfZFLWPBIbCffR+WoXWPYK4OAJhvxKmrPRTE1jwpZqVj
         wEDSkO5TpcWMOJh5u9qwDY4lBrv5eekCSU+6aG3rSVgjKVErRBY4oATWn4UswasFjQgC
         jM6RobKeKmR91xfIemirTIW3/yNdFeAo7uaXE4iq9FLAtGfVBUnnc+2OpRC734CQ7Mdh
         fhN573du4JVvP1vgrQ50n8o1sf/c6BfzGag4cuG3FpDQd3GXe52I5vJeU0yw5xnq8m0X
         rfTA==
X-Gm-Message-State: AFq9FYKD+av0oe9vn/qHsvn5dzVZnz3+E5YF/edGP69wLztdnyUxyh0B
	GXO9bwMIEvl3ZOJ7WiPUMXSYTx1kYG6BMz03SqmTbeO5Q2os2W4QnOfK
X-Gm-Gg: AYBFou1FQqREogZO4h9h0Fs77TeUwhlZYdtdGkkD3nFCzyuNys/wc8kxzXdjCLlI9bE
	Ol/miM/CJBYTWWYa+vcWRiqfudRRSd264tRObYWYAmx/lyeEG459HADhNiO/qz5viukWb5GNfiU
	xhmhGpy7CClxFQXYxCLntgbVXf5L60nCJlcY7Tb9TrtHBQtQdajlnOw4S27mENg4pUy5mx5LFSf
	muvcepCW+kW69FIKNdi7R8Sgg/BmTvo8ifydpyL+G17oMzl920jLVf8MYDuNcSm3uQ8F9IpVenO
	4f3arnAWb5eIMI4Jpu8Yb7zxwVVwi2CCxqwV3I28SLRn6IZCZyvJ/YNNweYIOGKhlYjltldkWGo
	4r/4HLzukbJ2GsktEXRjFw/5WYtBCGehQG5oTz54hrQ876mT9N9AtUUjh5EHGMS6KcIUnEpnVQ+
	QI1tWwUJSds9a79zkTio9Mt+zFKwliwi5umyJ1JJn7r1/l0qx0aORagosiRcyi9DdavBrb8pIff
	TeEo1/6GfOrPIWTFiGBLWB/agoTSmHMyBpK3l2x5yI95FOw2NSCiKZCYvV+SeGh0IU//7uBB1qC
	UCrI4WoqNCNJrJs7acxRcE8+kamt+muRmTh4TahJ
X-Received: by 2002:a05:600c:a49:b0:4a1:dadf:9876 with SMTP id 5b1f17b1804b1-4ac180f1b83mr251717655e9.23.1793630855157;
        Mon, 02 Nov 2026 06:47:35 -0800 (PST)
Received: from penguin-ubuntu.lan ([2a00:23c6:6410:5d01:8464:9a6f:2d42:8827])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4abe7700c3bsm254289965e9.0.2026.11.02.06.47.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 06:47:34 -0800 (PST)
From: Oxana Kharitonova <webprosto@gmail.com>
To: mic@digikod.net,
	brauner@kernel.org,
	viro@zeniv.linux.org.uk,
	gnoack@google.com,
	utilityemal77@gmail.com
Cc: linux-security-module@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	webprosto@gmail.com,
	landlock@lists.linux.dev
Subject: [PATCH v2 3/4] Landlock: Add POSIX message queue scoping
Date: Mon,  2 Nov 2026 14:45:59 +0000
Message-ID: <20261102144708.920232-4-webprosto@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261102144708.920232-1-webprosto@gmail.com>
References: <20261102144708.920232-1-webprosto@gmail.com>
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Filesystem access rights control POSIX message queue creation and
opening, but do not distinguish queues by their creator's Landlock
domain. Sandboxes sharing access to the mqueue filesystem may therefore
open each other's queues when other access controls permit it.

Add LANDLOCK_SCOPE_POSIX_MSG_QUEUE to restrict opening queues to those
created within the domain enabling the scope or its descendants.
Associate queues with their creator's domain and check this boundary
before filesystem access checks when opening a queue.

Apply the scope to mq_open() and opens through a mounted mqueue
filesystem. Leave existing, inherited, and passed descriptors usable.
Do not restrict mq_unlink(), allowing applications to clean up stale
queues, subject to other access controls. Document the resulting
limitations around unlinking and queue name reuse.

Expose the scope through ABI 13, with audit logging, audit quieting,
and a dedicated denial trace event.

Add selftests covering domain relationships, queue lifetime, filesystem
permission interactions, path-based opens, descriptor inheritance and
passing, UAPI validation, and audit logging and quieting.

Signed-off-by: Oxana Kharitonova <webprosto@gmail.com>
---
 Documentation/trace/events-landlock.rst       |   1 +
 Documentation/userspace-api/landlock.rst      |  56 +-
 include/linux/landlock.h                      |   3 +-
 include/trace/events/landlock.h               |  46 +
 include/uapi/linux/landlock.h                 |   4 +
 security/landlock/audit.c                     |   5 +
 security/landlock/fs.c                        | 102 ++-
 security/landlock/fs.h                        |   6 +
 security/landlock/limits.h                    |   2 +-
 security/landlock/log.c                       |   4 +
 security/landlock/log.h                       |   1 +
 security/landlock/object.c                    |   2 +
 security/landlock/object.h                    |   7 +
 security/landlock/syscalls.c                  |   2 +-
 security/landlock/task.c                      |  66 ++
 security/landlock/task.h                      |   4 +
 security/landlock/trace.c                     |   7 +
 tools/testing/selftests/landlock/audit_test.c | 114 +++
 tools/testing/selftests/landlock/base_test.c  |  40 +-
 .../landlock/scoped_posix_msg_queue_test.c    | 846 ++++++++++++++++++
 .../testing/selftests/landlock/scoped_test.c  |   2 +-
 21 files changed, 1312 insertions(+), 8 deletions(-)
 create mode 100644 tools/testing/selftests/landlock/scoped_posix_msg_queue_test.c

diff --git a/Documentation/trace/events-landlock.rst b/Documentation/trace/events-landlock.rst
index 9ccf2769a2d5..1f55c67650ed 100644
--- a/Documentation/trace/events-landlock.rst
+++ b/Documentation/trace/events-landlock.rst
@@ -46,6 +46,7 @@ Landlock trace events are organized in four categories:
 - ``landlock_deny_scope_signal``: signal delivery denied
 - ``landlock_deny_scope_abstract_unix_socket``: abstract unix socket
   access denied
+- ``landlock_deny_scope_posix_msg_queue``: POSIX message queue open denied
 - ``landlock_deny_permission_namespace``: namespace use denied
 - ``landlock_deny_permission_capability``: capability use denied
 
diff --git a/Documentation/userspace-api/landlock.rst b/Documentation/userspace-api/landlock.rst
index 1fb91884cb8a..fa65fa4aad02 100644
--- a/Documentation/userspace-api/landlock.rst
+++ b/Documentation/userspace-api/landlock.rst
@@ -95,7 +95,8 @@ to be explicit about the denied-by-default access rights.
             LANDLOCK_ACCESS_NET_CONNECT_SEND_UDP,
         .scoped =
             LANDLOCK_SCOPE_ABSTRACT_UNIX_SOCKET |
-            LANDLOCK_SCOPE_SIGNAL,
+            LANDLOCK_SCOPE_SIGNAL |
+            LANDLOCK_SCOPE_POSIX_MSG_QUEUE,
         .handled_permissions =
             LANDLOCK_PERMISSION_NAMESPACE_USE |
             LANDLOCK_PERMISSION_CAPABILITY_USE,
@@ -159,6 +160,10 @@ version, and only use the available subset of access rights:
         ruleset_attr.handled_permissions &=
             ~(LANDLOCK_PERMISSION_NAMESPACE_USE |
               LANDLOCK_PERMISSION_CAPABILITY_USE);
+        __attribute__((fallthrough));
+    case 12:
+        /* Removes LANDLOCK_SCOPE_POSIX_MSG_QUEUE for ABI < 13 */
+        ruleset_attr.scoped &= ~LANDLOCK_SCOPE_POSIX_MSG_QUEUE;
     }
 
 This enables the creation of an inclusive ruleset that will contain our rules.
@@ -482,6 +487,13 @@ created queue remains even though :manpage:`mq_open(3)` fails.  In particular,
 handling only ``LANDLOCK_ACCESS_FS_READ_FILE`` or
 ``LANDLOCK_ACCESS_FS_WRITE_FILE`` does not prevent queue creation.
 
+Independently of these filesystem access rights,
+``LANDLOCK_SCOPE_POSIX_MSG_QUEUE`` can restrict opening queues according to
+their creator's Landlock domain, as described in `IPC scoping`_.  When both
+restrictions apply, opening a queue must satisfy both.  A queue-scope denial
+returns ``EPERM`` and is checked before Landlock's read or write access
+checks, which return ``EACCES`` on denial.
+
 Inheritance
 -----------
 
@@ -535,6 +547,40 @@ The operations which can be scoped are:
     A :manpage:`sendto(2)` on a socket which was previously connected will not
     be restricted.  This works for both datagram and stream sockets.
 
+``LANDLOCK_SCOPE_POSIX_MSG_QUEUE``
+    Since ABI 13, this limits opening POSIX message queues to those created
+    in the domain that enables this scope or one of its descendants.  Queues
+    created outside this boundary, including before entering the domain,
+    cannot be opened.  Descendants inherit this boundary; enabling the scope
+    again in a descendant establishes a narrower boundary.
+
+    The scope applies to both :manpage:`mq_open(3)` and :manpage:`open(2)`
+    through a mounted mqueue filesystem, including opening an existing queue
+    with ``O_CREAT``.
+
+    Newly created queues are associated with the creator's current Landlock
+    domain.  The scope does not grant permission to create or open a queue:
+    the filesystem restrictions described in `POSIX message queues`_ and
+    other access controls still apply.
+
+    The scope does not restrict use of descriptors opened before entering
+    the domain, inherited from another process, or received through
+    descriptor passing.
+
+    A queue's lifetime is independent of its creator.  While its IPC
+    namespace exists, the queue remains until its name is unlinked and all
+    open descriptors are closed.  This scope does not restrict
+    :manpage:`mq_unlink(3)`, so a process permitted by other access controls
+    may unlink a queue outside its scope.  Leaving unlink unrestricted
+    allows an application to clean up stale queues from earlier runs.
+
+    Queue names are unique within an IPC namespace.  After unlinking, the
+    same name can be reused for a new queue, including by a process in
+    another Landlock domain.  Existing descriptors still refer to the old
+    queue, while subsequent opens refer to the replacement and are subject
+    to its creator-domain scope check.  This scope therefore does not
+    guarantee the identity or availability of a queue identified by name.
+
 Scoping does not support exceptions via :manpage:`landlock_add_rule(2)`.  If an
 operation is scoped within a domain, no rules can be added to allow access to
 resources or processes outside of the scope.
@@ -1075,6 +1121,14 @@ fd-reference acquisition (:manpage:`open_tree(2)`, :manpage:`fsmount(2)`) with
 the new ``LANDLOCK_PERMISSION_NAMESPACE_USE`` permission flag and
 ``LANDLOCK_RULE_NAMESPACE`` rule type.
 
+POSIX message queue scoping (ABI < 13)
+-------------------------------------
+
+Starting with ABI version 13, ``LANDLOCK_SCOPE_POSIX_MSG_QUEUE`` can restrict
+opening POSIX message queues according to the creator's Landlock domain.
+This scope is independent of the filesystem access rights used to control
+queue creation and opening.
+
 .. _kernel_support:
 
 Kernel support
diff --git a/include/linux/landlock.h b/include/linux/landlock.h
index 0ee4880988ba..17501fd05b7a 100644
--- a/include/linux/landlock.h
+++ b/include/linux/landlock.h
@@ -53,7 +53,8 @@
 #define _LANDLOCK_SCOPE_NAMES \
 	_LANDLOCK_NAME_ENTRY(LANDLOCK_SCOPE_ABSTRACT_UNIX_SOCKET, \
 			     "abstract_unix_socket"), \
-	_LANDLOCK_NAME_ENTRY(LANDLOCK_SCOPE_SIGNAL, "signal")
+	_LANDLOCK_NAME_ENTRY(LANDLOCK_SCOPE_SIGNAL, "signal"), \
+	_LANDLOCK_NAME_ENTRY(LANDLOCK_SCOPE_POSIX_MSG_QUEUE, "posix_msg_queue")
 
 #define _LANDLOCK_PERMISSION_NAMESPACE_NAME "namespace"
 #define _LANDLOCK_PERMISSION_CAPABILITY_NAME "capability"
diff --git a/include/trace/events/landlock.h b/include/trace/events/landlock.h
index 4f19d1c04d74..1d02dea3fff1 100644
--- a/include/trace/events/landlock.h
+++ b/include/trace/events/landlock.h
@@ -1253,6 +1253,52 @@ TRACE_EVENT(landlock_deny_scope_abstract_unix_socket,
 					    __get_dynamic_array_len(sun_path) - 1))
 );
 
+/**
+ * landlock_deny_scope_posix_msg_queue - POSIX message queue access denied
+ *     by LANDLOCK_SCOPE_POSIX_MSG_QUEUE
+ *
+ * @hierarchy: Denying domain's hierarchy node (never NULL).
+ * @same_exec: Whether the current task entered the denying domain itself.
+ * @logged: The domain's audit-logging decision for this denial.
+ * @creator_domain_id: Queue creator's domain ID, or 0 if unsandboxed.
+ * @file: Queue file being opened (never NULL).
+ *
+ * Emitted when a Landlock domain denies opening a scoped-out queue.
+ * The device and inode identify the queue within its IPC namespace.
+ */
+TRACE_EVENT(landlock_deny_scope_posix_msg_queue,
+
+	TP_PROTO(const struct landlock_hierarchy *hierarchy, bool same_exec,
+		 bool logged, u64 creator_domain_id, const struct file *file),
+
+	TP_ARGS(hierarchy, same_exec, logged, creator_domain_id, file),
+
+	TP_STRUCT__entry(
+		__field(	__u64,		domain_id	)
+		__field(	bool,		same_exec	)
+		__field(	bool,		logged		)
+		__field(	__u64,		creator_domain_id)
+		__field(	dev_t,		dev		)
+		__field(	ino_t,		ino		)
+	),
+
+	TP_fast_assign(
+		const struct inode *inode = file_inode(file);
+
+		__entry->domain_id	= hierarchy->id;
+		__entry->same_exec	= same_exec;
+		__entry->logged		= logged;
+		__entry->creator_domain_id = creator_domain_id;
+		__entry->dev		= inode->i_sb->s_dev;
+		__entry->ino		= inode->i_ino;
+	),
+
+	TP_printk("domain=%llx same_exec=%d logged=%d creator_domain=%llx dev=%u:%u ino=%lu",
+		__entry->domain_id, __entry->same_exec, __entry->logged,
+		__entry->creator_domain_id,
+		MAJOR(__entry->dev), MINOR(__entry->dev), __entry->ino)
+);
+
 #undef _LANDLOCK_FS_BLOCKER_TYPE_NAMES
 #undef _LANDLOCK_NAME_ENTRY
 
diff --git a/include/uapi/linux/landlock.h b/include/uapi/linux/landlock.h
index 04a18824c700..a011667dcfd1 100644
--- a/include/uapi/linux/landlock.h
+++ b/include/uapi/linux/landlock.h
@@ -588,10 +588,14 @@ struct landlock_capability_attr {
  *   related Landlock domain (e.g., a parent domain or a non-sandboxed process).
  * - %LANDLOCK_SCOPE_SIGNAL: Restrict a sandboxed process from sending a signal
  *   to another process outside the domain.
+ * - %LANDLOCK_SCOPE_POSIX_MSG_QUEUE: Restrict a sandboxed process from opening
+ *   a POSIX message queue outside the domain.  Support added in Landlock ABI
+ *   version 13.
  */
 /* clang-format off */
 #define LANDLOCK_SCOPE_ABSTRACT_UNIX_SOCKET		(1ULL << 0)
 #define LANDLOCK_SCOPE_SIGNAL		                (1ULL << 1)
+#define LANDLOCK_SCOPE_POSIX_MSG_QUEUE		        (1ULL << 2)
 /* clang-format on*/
 
 /**
diff --git a/security/landlock/audit.c b/security/landlock/audit.c
index be49ef47b4ea..df9104b2939d 100644
--- a/security/landlock/audit.c
+++ b/security/landlock/audit.c
@@ -80,6 +80,10 @@ get_blocker(const enum landlock_request_type type,
 		WARN_ON_ONCE(access_bit != -1);
 		return scope_strings[BIT_INDEX(LANDLOCK_SCOPE_SIGNAL)];
 
+	case LANDLOCK_REQUEST_SCOPE_POSIX_MSG_QUEUE:
+		WARN_ON_ONCE(access_bit != -1);
+		return scope_strings[BIT_INDEX(LANDLOCK_SCOPE_POSIX_MSG_QUEUE)];
+
 	case LANDLOCK_REQUEST_NAMESPACE:
 	case LANDLOCK_REQUEST_CAPABILITY:
 		if (WARN_ON_ONCE(access_bit >= ARRAY_SIZE(permission_strings)))
@@ -113,6 +117,7 @@ blocker_prefix(const enum landlock_request_type type)
 
 	case LANDLOCK_REQUEST_SCOPE_ABSTRACT_UNIX_SOCKET:
 	case LANDLOCK_REQUEST_SCOPE_SIGNAL:
+	case LANDLOCK_REQUEST_SCOPE_POSIX_MSG_QUEUE:
 		return "scope.";
 
 	case LANDLOCK_REQUEST_NAMESPACE:
diff --git a/security/landlock/fs.c b/security/landlock/fs.c
index d5dcb19d5eb1..e9c52332dfcd 100644
--- a/security/landlock/fs.c
+++ b/security/landlock/fs.c
@@ -53,6 +53,7 @@
 #include "object.h"
 #include "ruleset.h"
 #include "setup.h"
+#include "task.h"
 
 #include <trace/events/landlock.h>
 
@@ -1374,6 +1375,80 @@ static void hook_inode_free_security_rcu(void *inode_security)
 	WARN_ON_ONCE(inode_sec->object);
 }
 
+/*
+ * Tag a newly created POSIX message queue with its creator's domain.
+ *
+ * This is the earliest reachable point with both the creator's context and a
+ * fully initialized inode.
+ */
+static void hook_d_instantiate(struct dentry *const dentry,
+			       struct inode *const inode)
+{
+	struct landlock_domain *dom;
+	struct landlock_object *object;
+
+	if (!landlock_is_posix_mqueue_inode(inode))
+		return;
+
+	dom = landlock_get_current_domain();
+	if (!dom)
+		return;
+
+	object = get_inode_object(inode);
+	if (IS_ERR(object))
+		return;
+
+	spin_lock(&object->lock);
+	if (WARN_ON_ONCE(object->domain)) {
+		spin_unlock(&object->lock);
+		landlock_put_object(object);
+		return;
+	}
+
+	landlock_get_domain(dom);
+	object->domain = dom;
+	spin_unlock(&object->lock);
+}
+
+/*
+ * Drop the reference retained by hook_d_instantiate() for a POSIX message
+ * queue once its sole name is unlinked.
+ */
+static int hook_inode_unlink(struct inode *const dir,
+			     struct dentry *const dentry)
+{
+	const struct inode *const inode = d_backing_inode(dentry);
+	struct landlock_domain *domain;
+	struct landlock_object *object;
+
+	if (!landlock_is_posix_mqueue_inode(inode))
+		return 0;
+
+	rcu_read_lock();
+	object = rcu_dereference(landlock_inode(inode)->object);
+	/* The temporary reference protects against concurrent object release. */
+	if (!object || !refcount_inc_not_zero(&object->usage)) {
+		rcu_read_unlock();
+		return 0;
+	}
+	rcu_read_unlock();
+
+	spin_lock(&object->lock);
+	domain = object->domain;
+	object->domain = NULL;
+	spin_unlock(&object->lock);
+
+	/* Drop the temporary reference acquired by refcount_inc_not_zero(). */
+	landlock_put_object(object);
+	if (domain) {
+		landlock_put_domain_deferred(domain);
+		/* Drops the reference retained by hook_d_instantiate(). */
+		landlock_put_object(object);
+	}
+
+	return 0;
+}
+
 /* Super-block hooks */
 
 /*
@@ -1390,6 +1465,7 @@ static void hook_sb_delete(struct super_block *const sb)
 
 	spin_lock(&sb->s_inode_list_lock);
 	list_for_each_entry(inode, &sb->s_inodes, i_sb_list) {
+		struct landlock_domain *domain = NULL;
 		struct landlock_object *object;
 
 		/* Only handles referenced inodes. */
@@ -1432,6 +1508,13 @@ static void hook_sb_delete(struct super_block *const sb)
 		 */
 		spin_lock(&object->lock);
 		if (object->underobj == inode) {
+			/*
+			 * Claim the domain and retained object references.  Unlink
+			 * uses the same NULL transition, so only one teardown path
+			 * can release them.
+			 */
+			domain = object->domain;
+			object->domain = NULL;
 			object->underobj = NULL;
 			spin_unlock(&object->lock);
 			rcu_read_unlock();
@@ -1457,7 +1540,7 @@ static void hook_sb_delete(struct super_block *const sb)
 			rcu_read_unlock();
 		}
 
-		if (prev_inode) {
+		if (prev_inode || domain) {
 			/*
 			 * At this point, we still own the __iget() reference
 			 * that we just set in this loop walk.  Therefore we
@@ -1469,7 +1552,12 @@ static void hook_sb_delete(struct super_block *const sb)
 			 * We can now actually put the inode reference from the
 			 * previous loop walk, which is not needed anymore.
 			 */
-			iput(prev_inode);
+			if (prev_inode)
+				iput(prev_inode);
+			if (domain) {
+				landlock_put_domain_deferred(domain);
+				landlock_put_object(object);
+			}
 			cond_resched();
 			spin_lock(&sb->s_inode_list_lock);
 		}
@@ -1891,6 +1979,14 @@ static int hook_file_open(struct file *const file)
 	const struct landlock_cred_security *const subject =
 		landlock_get_applicable_subject(file->f_cred, any_fs, NULL);
 	struct landlock_request request = {};
+	int err;
+
+	/*
+	 * Check queue creator-domain scoping before filesystem access rights.
+	 */
+	err = landlock_check_posix_mqueue_open(file);
+	if (err)
+		return err;
 
 	if (!subject)
 		return 0;
@@ -2115,6 +2211,8 @@ static void hook_file_free_security(struct file *file)
 static struct security_hook_list landlock_hooks[] __ro_after_init = {
 	LSM_HOOK_INIT(inode_free_security_rcu, hook_inode_free_security_rcu),
 	LSM_HOOK_INIT(inode_create, hook_inode_create),
+	LSM_HOOK_INIT(d_instantiate, hook_d_instantiate),
+	LSM_HOOK_INIT(inode_unlink, hook_inode_unlink),
 
 	LSM_HOOK_INIT(sb_delete, hook_sb_delete),
 	LSM_HOOK_INIT(sb_mount, hook_sb_mount),
diff --git a/security/landlock/fs.h b/security/landlock/fs.h
index 05e36ef1acf7..85025030659c 100644
--- a/security/landlock/fs.h
+++ b/security/landlock/fs.h
@@ -150,6 +150,12 @@ static inline bool landlock_is_posix_mqueue_fs(const struct inode *const inode)
 	return inode->i_sb->s_magic == MQUEUE_MAGIC;
 }
 
+static inline bool
+landlock_is_posix_mqueue_inode(const struct inode *const inode)
+{
+	return S_ISREG(inode->i_mode) && landlock_is_posix_mqueue_fs(inode);
+}
+
 static inline struct landlock_superblock_security *
 landlock_superblock(const struct super_block *const superblock)
 {
diff --git a/security/landlock/limits.h b/security/landlock/limits.h
index ddd300e10689..469ddcb4a65f 100644
--- a/security/landlock/limits.h
+++ b/security/landlock/limits.h
@@ -29,7 +29,7 @@
 #define LANDLOCK_MASK_ACCESS_NET	((LANDLOCK_LAST_ACCESS_NET << 1) - 1)
 #define LANDLOCK_NUM_ACCESS_NET		__const_hweight64(LANDLOCK_MASK_ACCESS_NET)
 
-#define LANDLOCK_LAST_SCOPE		LANDLOCK_SCOPE_SIGNAL
+#define LANDLOCK_LAST_SCOPE		LANDLOCK_SCOPE_POSIX_MSG_QUEUE
 #define LANDLOCK_MASK_SCOPE		((LANDLOCK_LAST_SCOPE << 1) - 1)
 #define LANDLOCK_NUM_SCOPE		__const_hweight64(LANDLOCK_MASK_SCOPE)
 
diff --git a/security/landlock/log.c b/security/landlock/log.c
index 43efbb95725c..d2e0b5de3ce3 100644
--- a/security/landlock/log.c
+++ b/security/landlock/log.c
@@ -406,6 +406,7 @@ static bool is_valid_request(const struct landlock_request *const request)
 	case LANDLOCK_REQUEST_NET_ACCESS:
 	case LANDLOCK_REQUEST_SCOPE_ABSTRACT_UNIX_SOCKET:
 	case LANDLOCK_REQUEST_SCOPE_SIGNAL:
+	case LANDLOCK_REQUEST_SCOPE_POSIX_MSG_QUEUE:
 		if (WARN_ON_ONCE(request->permission))
 			return false;
 		break;
@@ -485,6 +486,9 @@ is_denial_quieted(const struct landlock_request *const request,
 	case LANDLOCK_REQUEST_SCOPE_ABSTRACT_UNIX_SOCKET:
 		return !!(youngest_denied->quiet_access.scope &
 			  LANDLOCK_SCOPE_ABSTRACT_UNIX_SOCKET);
+	case LANDLOCK_REQUEST_SCOPE_POSIX_MSG_QUEUE:
+		return !!(youngest_denied->quiet_access.scope &
+			  LANDLOCK_SCOPE_POSIX_MSG_QUEUE);
 	case LANDLOCK_REQUEST_NAMESPACE:
 		return !!(youngest_denied->quiet_permission.ns_types &
 			  landlock_ns_type_to_bit(request->audit.u.ns.ns_type));
diff --git a/security/landlock/log.h b/security/landlock/log.h
index 596feeeb7aa6..8eec738d3ca4 100644
--- a/security/landlock/log.h
+++ b/security/landlock/log.h
@@ -25,6 +25,7 @@ enum landlock_request_type {
 	LANDLOCK_REQUEST_NET_ACCESS,
 	LANDLOCK_REQUEST_SCOPE_ABSTRACT_UNIX_SOCKET,
 	LANDLOCK_REQUEST_SCOPE_SIGNAL,
+	LANDLOCK_REQUEST_SCOPE_POSIX_MSG_QUEUE,
 	LANDLOCK_REQUEST_NAMESPACE,
 	LANDLOCK_REQUEST_CAPABILITY,
 };
diff --git a/security/landlock/object.c b/security/landlock/object.c
index 0d6e159ef8b5..bea45c855a91 100644
--- a/security/landlock/object.c
+++ b/security/landlock/object.c
@@ -15,6 +15,7 @@
 #include <linux/slab.h>
 #include <linux/spinlock.h>
 
+#include "domain.h"
 #include "object.h"
 
 struct landlock_object *
@@ -62,6 +63,7 @@ void landlock_put_object(struct landlock_object *const object)
 		 * @object->underobj to @object (if it still exists).
 		 */
 		object->underops->release(object);
+		landlock_put_domain_deferred(object->domain);
 		kfree_rcu(object, rcu_free);
 	}
 }
diff --git a/security/landlock/object.h b/security/landlock/object.h
index 5f28c35e8aa8..3518ee36ab71 100644
--- a/security/landlock/object.h
+++ b/security/landlock/object.h
@@ -14,6 +14,7 @@
 #include <linux/spinlock.h>
 
 struct landlock_object;
+struct landlock_domain;
 
 /**
  * struct landlock_object_underops - Operations on an underlying object
@@ -74,6 +75,12 @@ struct landlock_object {
 		 */
 		const struct landlock_object_underops *underops;
 	};
+	/**
+	 * @domain: Domain associated with a POSIX message queue object.  While
+	 * non-NULL, the object owns both a reference to this domain and the usage
+	 * reference retained when the queue was tagged.  Protected by @lock.
+	 */
+	struct landlock_domain *domain;
 };
 
 struct landlock_object *
diff --git a/security/landlock/syscalls.c b/security/landlock/syscalls.c
index fb5af318b69b..11d3a2abcec1 100644
--- a/security/landlock/syscalls.c
+++ b/security/landlock/syscalls.c
@@ -191,7 +191,7 @@ static const struct file_operations ruleset_fops = {
  * If the change involves a fix that requires userspace awareness, also update
  * the errata documentation in Documentation/userspace-api/landlock.rst .
  */
-const int landlock_abi_version = 12;
+const int landlock_abi_version = 13;
 
 /**
  * sys_landlock_create_ruleset - Create a new ruleset
diff --git a/security/landlock/task.c b/security/landlock/task.c
index d9eae86fc552..0daa7edff2d7 100644
--- a/security/landlock/task.c
+++ b/security/landlock/task.c
@@ -522,6 +522,72 @@ static int hook_file_send_sigiotask(struct task_struct *tsk,
 	return -EPERM;
 }
 
+static const struct access_masks posix_mqueue_scope = {
+	.scope = LANDLOCK_SCOPE_POSIX_MSG_QUEUE,
+};
+
+/**
+ * landlock_check_posix_mqueue_open - Deny opening a POSIX message queue
+ * created by a task from a different (non-ancestor) domain
+ *
+ * @file: The mqueuefs file being opened.
+ *
+ * Return: -EPERM if the open must be denied, 0 otherwise.
+ */
+int landlock_check_posix_mqueue_open(struct file *const file)
+{
+	const struct inode *const inode = file_inode(file);
+	const struct landlock_cred_security *subject;
+	struct landlock_object *object;
+	struct landlock_domain *creator_domain = NULL;
+	bool is_scoped;
+	size_t handle_layer;
+
+	if (!landlock_is_posix_mqueue_inode(inode))
+		return 0;
+
+	subject = landlock_get_applicable_subject(
+		file->f_cred, posix_mqueue_scope, &handle_layer);
+	if (!subject)
+		return 0;
+
+	rcu_read_lock();
+	object = rcu_dereference(landlock_inode(inode)->object);
+	/* The temporary reference protects against concurrent object release. */
+	if (object && !refcount_inc_not_zero(&object->usage))
+		object = NULL;
+	rcu_read_unlock();
+
+	if (object) {
+		spin_lock(&object->lock);
+		creator_domain = object->domain;
+		landlock_get_domain(creator_domain);
+		spin_unlock(&object->lock);
+	}
+
+	/* Untagged queues were created outside any Landlock domain. */
+	is_scoped = domain_is_scoped(subject->domain, creator_domain,
+				     LANDLOCK_SCOPE_POSIX_MSG_QUEUE);
+	if (!is_scoped) {
+		landlock_put_domain_deferred(creator_domain);
+		landlock_put_object(object);
+		return 0;
+	}
+
+	landlock_log_denial(subject, &(struct landlock_request) {
+		.type = LANDLOCK_REQUEST_SCOPE_POSIX_MSG_QUEUE,
+		.other_domain_id = creator_domain ? creator_domain->hierarchy->id : 0,
+		.audit = {
+			.type = LSM_AUDIT_DATA_FILE,
+			.u.file = file,
+		},
+		.layer_plus_one = handle_layer + 1,
+	});
+	landlock_put_domain_deferred(creator_domain);
+	landlock_put_object(object);
+	return -EPERM;
+}
+
 static struct security_hook_list landlock_hooks[] __ro_after_init = {
 	LSM_HOOK_INIT(ptrace_access_check, hook_ptrace_access_check),
 	LSM_HOOK_INIT(ptrace_traceme, hook_ptrace_traceme),
diff --git a/security/landlock/task.h b/security/landlock/task.h
index 7c00360219a2..0b031dc17bbf 100644
--- a/security/landlock/task.h
+++ b/security/landlock/task.h
@@ -9,6 +9,10 @@
 #ifndef _SECURITY_LANDLOCK_TASK_H
 #define _SECURITY_LANDLOCK_TASK_H
 
+#include <linux/fs.h>
+
 __init void landlock_add_task_hooks(void);
 
+int landlock_check_posix_mqueue_open(struct file *const file);
+
 #endif /* _SECURITY_LANDLOCK_TASK_H */
diff --git a/security/landlock/trace.c b/security/landlock/trace.c
index 995c6b948e16..1d2bb0c3175b 100644
--- a/security/landlock/trace.c
+++ b/security/landlock/trace.c
@@ -246,6 +246,13 @@ void landlock_trace_denial(
 				request->other_domain_id,
 				request->audit.u.net->sk);
 		break;
+	case LANDLOCK_REQUEST_SCOPE_POSIX_MSG_QUEUE:
+		if (trace_landlock_deny_scope_posix_msg_queue_enabled())
+			trace_landlock_deny_scope_posix_msg_queue(
+				youngest_denied, same_exec, logged,
+				request->other_domain_id,
+				request->audit.u.file);
+		break;
 	default:
 		WARN_ONCE(1, "Unhandled Landlock request type %d",
 			  request->type);
diff --git a/tools/testing/selftests/landlock/audit_test.c b/tools/testing/selftests/landlock/audit_test.c
index 4bea8c880a4d..a15c1e5d277f 100644
--- a/tools/testing/selftests/landlock/audit_test.c
+++ b/tools/testing/selftests/landlock/audit_test.c
@@ -10,6 +10,7 @@
 #include <fcntl.h>
 #include <limits.h>
 #include <linux/landlock.h>
+#include <mqueue.h>
 #include <pthread.h>
 #include <stdlib.h>
 #include <sys/mount.h>
@@ -997,4 +998,117 @@ TEST_F(audit_exec, signal_and_open)
 	EXPECT_EQ(0, records.access);
 }
 
+FIXTURE(posix_mqueue_audit)
+{
+	struct audit_filter audit_filter;
+	int audit_fd;
+};
+
+FIXTURE_VARIANT(posix_mqueue_audit)
+{
+	const __u64 quiet_scoped;
+};
+
+/* clang-format off */
+FIXTURE_VARIANT_ADD(posix_mqueue_audit, logged) {
+	/* clang-format on */
+	.quiet_scoped = 0,
+};
+
+/* clang-format off */
+FIXTURE_VARIANT_ADD(posix_mqueue_audit, quiet) {
+	/* clang-format on */
+	.quiet_scoped = LANDLOCK_SCOPE_POSIX_MSG_QUEUE,
+};
+
+FIXTURE_SETUP(posix_mqueue_audit)
+{
+	disable_caps(_metadata);
+	set_cap(_metadata, CAP_AUDIT_CONTROL);
+	self->audit_fd = audit_init_with_exe_filter(&self->audit_filter);
+	EXPECT_LE(0, self->audit_fd);
+	drop_caps(_metadata);
+}
+
+FIXTURE_TEARDOWN_PARENT(posix_mqueue_audit)
+{
+	EXPECT_EQ(0, audit_cleanup(-1, NULL));
+}
+
+/* Checks audit logging and quieting of a denied POSIX message queue open. */
+TEST_F(posix_mqueue_audit, open)
+{
+	const struct landlock_ruleset_attr ruleset_attr = {
+		.scoped = LANDLOCK_SCOPE_POSIX_MSG_QUEUE,
+		.quiet_scoped = variant->quiet_scoped,
+	};
+	char mq_name[NAME_MAX], log_match[PATH_MAX];
+	int pipe_parent[2], pipe_child[2], ruleset_fd, status;
+	struct audit_records records;
+	char buf;
+	pid_t child;
+	mqd_t mq;
+
+	ASSERT_LT(0,
+		  snprintf(mq_name, sizeof(mq_name),
+			   "/selftests-landlock-audit-mq-tid%d", sys_gettid()));
+	mq_unlink(mq_name);
+	ASSERT_EQ(0, pipe2(pipe_parent, O_CLOEXEC));
+	ASSERT_EQ(0, pipe2(pipe_child, O_CLOEXEC));
+
+	child = fork();
+	ASSERT_LE(0, child);
+	if (child == 0) {
+		EXPECT_EQ(0, close(pipe_parent[1]));
+		EXPECT_EQ(0, close(pipe_child[0]));
+
+		mq = mq_open(mq_name, O_CREAT | O_EXCL | O_RDWR, 0600, NULL);
+		ASSERT_LE(0, mq);
+		ASSERT_EQ(1, write(pipe_child[1], ".", 1));
+		ASSERT_EQ(1, read(pipe_parent[0], &buf, 1));
+
+		EXPECT_EQ(0, mq_close(mq));
+		EXPECT_EQ(0, mq_unlink(mq_name));
+		_exit(_metadata->exit_code);
+		return;
+	}
+	EXPECT_EQ(0, close(pipe_parent[0]));
+	EXPECT_EQ(0, close(pipe_child[1]));
+
+	ruleset_fd =
+		landlock_create_ruleset(&ruleset_attr, sizeof(ruleset_attr), 0);
+	ASSERT_LE(0, ruleset_fd);
+	enforce_ruleset(_metadata, ruleset_fd);
+	EXPECT_EQ(0, close(ruleset_fd));
+	ASSERT_EQ(1, read(pipe_child[0], &buf, 1));
+
+	EXPECT_EQ(-1, mq_open(mq_name, O_RDWR));
+	EXPECT_EQ(EPERM, errno);
+
+	if (variant->quiet_scoped) {
+		EXPECT_EQ(0, audit_count_records(self->audit_fd, &records));
+		EXPECT_EQ(0, records.access);
+		EXPECT_EQ(0, records.domain);
+	} else {
+		ASSERT_LT(
+			0,
+			snprintf(
+				log_match, sizeof(log_match),
+				REGEX_LANDLOCK_PREFIX
+				" blockers=scope\\.posix_msg_queue path=\\\"%s\\\" dev=\\\"[^\\\"]\\+\\\" ino=[0-9]\\+$",
+				mq_name));
+		EXPECT_EQ(0, audit_match_record(self->audit_fd,
+						AUDIT_LANDLOCK_ACCESS,
+						log_match, NULL));
+		EXPECT_EQ(0, audit_count_records(self->audit_fd, &records));
+		EXPECT_EQ(0, records.access);
+	}
+
+	ASSERT_EQ(1, write(pipe_parent[1], ".", 1));
+	ASSERT_EQ(child, waitpid(child, &status, 0));
+	if (WIFSIGNALED(status) || !WIFEXITED(status) ||
+	    WEXITSTATUS(status) != EXIT_SUCCESS)
+		_metadata->exit_code = KSFT_FAIL;
+}
+
 TEST_HARNESS_MAIN
diff --git a/tools/testing/selftests/landlock/base_test.c b/tools/testing/selftests/landlock/base_test.c
index 89c0d96607de..1f361c6fe3ee 100644
--- a/tools/testing/selftests/landlock/base_test.c
+++ b/tools/testing/selftests/landlock/base_test.c
@@ -76,7 +76,7 @@ TEST(abi_version)
 	const struct landlock_ruleset_attr ruleset_attr = {
 		.handled_access_fs = LANDLOCK_ACCESS_FS_READ_FILE,
 	};
-	ASSERT_EQ(12, landlock_create_ruleset(NULL, 0,
+	ASSERT_EQ(13, landlock_create_ruleset(NULL, 0,
 					      LANDLOCK_CREATE_RULESET_VERSION));
 
 	ASSERT_EQ(-1, landlock_create_ruleset(&ruleset_attr, 0,
@@ -755,4 +755,42 @@ TEST(invalid_quiet_bits_2)
 	ASSERT_EQ(EINVAL, errno);
 }
 
+/* Checks the UAPI validation of LANDLOCK_SCOPE_POSIX_MSG_QUEUE. */
+TEST(posix_mqueue_scope_uapi)
+{
+	const struct landlock_ruleset_attr scoped = {
+		.scoped = LANDLOCK_SCOPE_POSIX_MSG_QUEUE,
+	};
+	const struct landlock_ruleset_attr quiet = {
+		.scoped = LANDLOCK_SCOPE_POSIX_MSG_QUEUE,
+		.quiet_scoped = LANDLOCK_SCOPE_POSIX_MSG_QUEUE,
+	};
+	const struct landlock_ruleset_attr quiet_without_scope = {
+		.scoped = LANDLOCK_SCOPE_SIGNAL,
+		.quiet_scoped = LANDLOCK_SCOPE_POSIX_MSG_QUEUE,
+	};
+	const struct landlock_ruleset_attr unknown_scope = {
+		.scoped = LANDLOCK_SCOPE_POSIX_MSG_QUEUE << 1,
+	};
+	int ruleset_fd;
+
+	drop_caps(_metadata);
+
+	ruleset_fd = landlock_create_ruleset(&scoped, sizeof(scoped), 0);
+	ASSERT_LE(0, ruleset_fd);
+	EXPECT_EQ(0, close(ruleset_fd));
+
+	ruleset_fd = landlock_create_ruleset(&quiet, sizeof(quiet), 0);
+	ASSERT_LE(0, ruleset_fd);
+	EXPECT_EQ(0, close(ruleset_fd));
+
+	EXPECT_EQ(-1, landlock_create_ruleset(&quiet_without_scope,
+					      sizeof(quiet_without_scope), 0));
+	EXPECT_EQ(EINVAL, errno);
+
+	EXPECT_EQ(-1, landlock_create_ruleset(&unknown_scope,
+					      sizeof(unknown_scope), 0));
+	EXPECT_EQ(EINVAL, errno);
+}
+
 TEST_HARNESS_MAIN
diff --git a/tools/testing/selftests/landlock/scoped_posix_msg_queue_test.c b/tools/testing/selftests/landlock/scoped_posix_msg_queue_test.c
new file mode 100644
index 000000000000..4475746081bc
--- /dev/null
+++ b/tools/testing/selftests/landlock/scoped_posix_msg_queue_test.c
@@ -0,0 +1,846 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Landlock tests - POSIX message queue scoping
+ *
+ */
+
+#define _GNU_SOURCE
+#include <errno.h>
+#include <fcntl.h>
+#include <limits.h>
+#include <linux/landlock.h>
+#include <mqueue.h>
+#include <sched.h>
+#include <stddef.h>
+#include <string.h>
+#include <sys/prctl.h>
+#include <sys/socket.h>
+#include <sys/stat.h>
+#include <sys/types.h>
+#include <sys/wait.h>
+#include <unistd.h>
+
+#include "common.h"
+#include "scoped_common.h"
+
+static void set_mq_name(char *const name, const size_t size)
+{
+	snprintf(name, size, "/selftests-landlock-mq-tid%d", sys_gettid());
+}
+
+FIXTURE(scoped_domains)
+{
+	char mq_name[NAME_MAX];
+};
+
+#include "scoped_base_variants.h"
+
+FIXTURE_SETUP(scoped_domains)
+{
+	drop_caps(_metadata);
+
+	set_mq_name(self->mq_name, sizeof(self->mq_name));
+	/* Removes a possibly stale queue from a previous run. */
+	mq_unlink(self->mq_name);
+}
+
+FIXTURE_TEARDOWN(scoped_domains)
+{
+}
+
+/*
+ * The parent creates the message queue, then the child tries
+ * to open it, with scoped domain(s) or no domain at all.
+ */
+TEST_F(scoped_domains, open_parent_queue)
+{
+	pid_t child;
+	int status;
+	int pipe_parent[2], pipe_child[2];
+	char buf;
+	mqd_t mq;
+
+	ASSERT_EQ(0, pipe2(pipe_parent, O_CLOEXEC));
+	ASSERT_EQ(0, pipe2(pipe_child, O_CLOEXEC));
+
+	if (variant->domain_both)
+		create_scoped_domain(_metadata, LANDLOCK_SCOPE_POSIX_MSG_QUEUE);
+
+	child = fork();
+	ASSERT_LE(0, child);
+	if (child == 0) {
+		mqd_t mq_child;
+
+		EXPECT_EQ(0, close(pipe_parent[1]));
+		EXPECT_EQ(0, close(pipe_child[0]));
+
+		if (variant->domain_child)
+			create_scoped_domain(_metadata,
+					     LANDLOCK_SCOPE_POSIX_MSG_QUEUE);
+
+		/* Waits for the parent to create the queue. */
+		ASSERT_EQ(1, read(pipe_parent[0], &buf, 1));
+
+		mq_child = mq_open(self->mq_name, O_RDWR);
+		if (!variant->domain_child) {
+			EXPECT_LE(0, mq_child);
+			if (mq_child >= 0)
+				EXPECT_EQ(0, mq_close(mq_child));
+		} else {
+			EXPECT_EQ(-1, mq_child);
+			EXPECT_EQ(EPERM, errno);
+		}
+
+		ASSERT_EQ(1, write(pipe_child[1], ".", 1));
+		_exit(_metadata->exit_code);
+		return;
+	}
+	EXPECT_EQ(0, close(pipe_parent[0]));
+	EXPECT_EQ(0, close(pipe_child[1]));
+
+	if (variant->domain_parent)
+		create_scoped_domain(_metadata, LANDLOCK_SCOPE_POSIX_MSG_QUEUE);
+
+	mq = mq_open(self->mq_name, O_CREAT | O_RDWR, 0600, NULL);
+	ASSERT_LE(0, mq);
+
+	ASSERT_EQ(1, write(pipe_parent[1], ".", 1));
+	ASSERT_EQ(1, read(pipe_child[0], &buf, 1));
+
+	ASSERT_EQ(child, waitpid(child, &status, 0));
+	EXPECT_EQ(0, mq_close(mq));
+	EXPECT_EQ(0, mq_unlink(self->mq_name));
+
+	if (WIFSIGNALED(status) || !WIFEXITED(status) ||
+	    WEXITSTATUS(status) != EXIT_SUCCESS)
+		_metadata->exit_code = KSFT_FAIL;
+}
+
+/*
+ * The child creates the message queue, then the parent tries
+ * to open it, with scoped domain(s) or no domain at all.
+ */
+TEST_F(scoped_domains, open_child_queue)
+{
+	pid_t child;
+	bool can_open_child_queue;
+	int status;
+	int pipe_parent[2], pipe_child[2];
+	char buf;
+	mqd_t mq;
+
+	can_open_child_queue = !variant->domain_parent;
+
+	ASSERT_EQ(0, pipe2(pipe_parent, O_CLOEXEC));
+	ASSERT_EQ(0, pipe2(pipe_child, O_CLOEXEC));
+
+	if (variant->domain_both)
+		create_scoped_domain(_metadata, LANDLOCK_SCOPE_POSIX_MSG_QUEUE);
+
+	child = fork();
+	ASSERT_LE(0, child);
+	if (child == 0) {
+		mqd_t mq_child;
+
+		EXPECT_EQ(0, close(pipe_parent[1]));
+		EXPECT_EQ(0, close(pipe_child[0]));
+
+		if (variant->domain_child)
+			create_scoped_domain(_metadata,
+					     LANDLOCK_SCOPE_POSIX_MSG_QUEUE);
+
+		/* Waits for the parent to be in a domain, if any. */
+		ASSERT_EQ(1, read(pipe_parent[0], &buf, 1));
+
+		mq_child = mq_open(self->mq_name, O_CREAT | O_RDWR, 0600, NULL);
+		ASSERT_LE(0, mq_child);
+
+		ASSERT_EQ(1, write(pipe_child[1], ".", 1));
+
+		ASSERT_EQ(1, read(pipe_parent[0], &buf, 1));
+		EXPECT_EQ(0, mq_close(mq_child));
+		EXPECT_EQ(0, mq_unlink(self->mq_name));
+		_exit(_metadata->exit_code);
+		return;
+	}
+	EXPECT_EQ(0, close(pipe_parent[0]));
+	EXPECT_EQ(0, close(pipe_child[1]));
+
+	if (variant->domain_parent)
+		create_scoped_domain(_metadata, LANDLOCK_SCOPE_POSIX_MSG_QUEUE);
+
+	/* Signals that the parent is in a domain, if any. */
+	ASSERT_EQ(1, write(pipe_parent[1], ".", 1));
+
+	/* Waits for the child to create the queue. */
+	ASSERT_EQ(1, read(pipe_child[0], &buf, 1));
+
+	mq = mq_open(self->mq_name, O_RDWR);
+	if (can_open_child_queue) {
+		EXPECT_LE(0, mq);
+		if (mq >= 0)
+			EXPECT_EQ(0, mq_close(mq));
+	} else {
+		EXPECT_EQ(-1, mq);
+		EXPECT_EQ(EPERM, errno);
+	}
+
+	/* Signals to the child that the open attempt is done. */
+	ASSERT_EQ(1, write(pipe_parent[1], ".", 1));
+
+	ASSERT_EQ(child, waitpid(child, &status, 0));
+	if (WIFSIGNALED(status) || !WIFEXITED(status) ||
+	    WEXITSTATUS(status) != EXIT_SUCCESS)
+		_metadata->exit_code = KSFT_FAIL;
+}
+
+/*
+ * O_CREAT must not bypass message queue scoping when the named queue already
+ * exists.  In this case mq_open() opens the existing object instead of
+ * creating a new one.
+ */
+TEST(open_existing_queue_with_create)
+{
+	char mq_name[NAME_MAX];
+	int pipe_parent[2], status;
+	pid_t child;
+	mqd_t mq;
+
+	drop_caps(_metadata);
+	set_mq_name(mq_name, sizeof(mq_name));
+	mq_unlink(mq_name);
+	ASSERT_EQ(0, pipe2(pipe_parent, O_CLOEXEC));
+
+	child = fork();
+	ASSERT_LE(0, child);
+	if (child == 0) {
+		char buf;
+
+		EXPECT_EQ(0, close(pipe_parent[1]));
+		create_scoped_domain(_metadata, LANDLOCK_SCOPE_POSIX_MSG_QUEUE);
+		ASSERT_EQ(1, read(pipe_parent[0], &buf, 1));
+
+		mq = mq_open(mq_name, O_CREAT | O_RDWR, 0600, NULL);
+		EXPECT_EQ(-1, mq);
+		EXPECT_EQ(EPERM, errno);
+
+		_exit(_metadata->exit_code);
+		return;
+	}
+	EXPECT_EQ(0, close(pipe_parent[0]));
+
+	mq = mq_open(mq_name, O_CREAT | O_EXCL | O_RDWR, 0600, NULL);
+	ASSERT_LE(0, mq);
+	ASSERT_EQ(1, write(pipe_parent[1], ".", 1));
+	EXPECT_EQ(0, close(pipe_parent[1]));
+
+	ASSERT_EQ(child, waitpid(child, &status, 0));
+	EXPECT_EQ(0, mq_close(mq));
+	EXPECT_EQ(0, mq_unlink(mq_name));
+	if (WIFSIGNALED(status) || !WIFEXITED(status) ||
+	    WEXITSTATUS(status) != EXIT_SUCCESS)
+		_metadata->exit_code = KSFT_FAIL;
+}
+
+/*
+ * Unlinking a queue while it is still open must detach its creator domain.
+ * Reusing the same name for a queue created in a sibling domain must associate
+ * the new queue with the new creator without affecting the unlinked object.
+ */
+TEST(unlink_and_recreate_in_sibling_domain)
+{
+	char mq_name[NAME_MAX], buf;
+	int pipe_parent[2], pipe_child[2], status;
+	struct mq_attr attr;
+	pid_t child;
+	mqd_t old_mq, new_mq;
+
+	drop_caps(_metadata);
+	set_mq_name(mq_name, sizeof(mq_name));
+	mq_unlink(mq_name);
+	ASSERT_EQ(0, pipe2(pipe_parent, O_CLOEXEC));
+	ASSERT_EQ(0, pipe2(pipe_child, O_CLOEXEC));
+
+	/* Both processes inherit this common parent domain. */
+	create_scoped_domain(_metadata, LANDLOCK_SCOPE_POSIX_MSG_QUEUE);
+	child = fork();
+	ASSERT_LE(0, child);
+	if (child == 0) {
+		EXPECT_EQ(0, close(pipe_parent[1]));
+		EXPECT_EQ(0, close(pipe_child[0]));
+		create_scoped_domain(_metadata, LANDLOCK_SCOPE_POSIX_MSG_QUEUE);
+
+		/* Waits until the old queue has been unlinked. */
+		ASSERT_EQ(1, read(pipe_parent[0], &buf, 1));
+		new_mq =
+			mq_open(mq_name, O_CREAT | O_EXCL | O_RDWR, 0600, NULL);
+		ASSERT_LE(0, new_mq);
+		ASSERT_EQ(1, write(pipe_child[1], ".", 1));
+
+		/* Keeps the new queue alive until the parent checks its scope. */
+		ASSERT_EQ(1, read(pipe_parent[0], &buf, 1));
+		EXPECT_EQ(0, mq_close(new_mq));
+		EXPECT_EQ(0, mq_unlink(mq_name));
+		_exit(_metadata->exit_code);
+		return;
+	}
+	EXPECT_EQ(0, close(pipe_parent[0]));
+	EXPECT_EQ(0, close(pipe_child[1]));
+	create_scoped_domain(_metadata, LANDLOCK_SCOPE_POSIX_MSG_QUEUE);
+
+	old_mq = mq_open(mq_name, O_CREAT | O_EXCL | O_RDWR, 0600, NULL);
+	ASSERT_LE(0, old_mq);
+	ASSERT_EQ(0, mq_unlink(mq_name));
+	ASSERT_EQ(1, write(pipe_parent[1], ".", 1));
+	ASSERT_EQ(1, read(pipe_child[0], &buf, 1));
+
+	new_mq = mq_open(mq_name, O_RDWR);
+	EXPECT_EQ(-1, new_mq);
+	EXPECT_EQ(EPERM, errno);
+	/* The descriptor for the unlinked queue must remain usable. */
+	EXPECT_EQ(0, mq_getattr(old_mq, &attr));
+
+	ASSERT_EQ(1, write(pipe_parent[1], ".", 1));
+	ASSERT_EQ(child, waitpid(child, &status, 0));
+	EXPECT_EQ(0, mq_close(old_mq));
+	if (WIFSIGNALED(status) || !WIFEXITED(status) ||
+	    WEXITSTATUS(status) != EXIT_SUCCESS)
+		_metadata->exit_code = KSFT_FAIL;
+}
+
+/*
+ * A queue must retain its creator domain after the creator exits.  A process
+ * in the parent domain and an unsandboxed process may open the stale queue,
+ * whereas a process in a new sibling domain must not.
+ */
+TEST(open_queue_after_creator_exits)
+{
+	char mq_name[NAME_MAX], buf;
+	int pipe_unscoped[2], status;
+	pid_t creator, sibling, unscoped;
+	mqd_t mq;
+
+	drop_caps(_metadata);
+	set_mq_name(mq_name, sizeof(mq_name));
+	mq_unlink(mq_name);
+	ASSERT_EQ(0, pipe2(pipe_unscoped, O_CLOEXEC));
+
+	/* Forks before entering a domain to retain an unsandboxed process. */
+	unscoped = fork();
+	ASSERT_LE(0, unscoped);
+	if (unscoped == 0) {
+		EXPECT_EQ(0, close(pipe_unscoped[1]));
+		ASSERT_EQ(1, read(pipe_unscoped[0], &buf, 1));
+		mq = mq_open(mq_name, O_RDWR);
+		EXPECT_LE(0, mq);
+		if (mq >= 0)
+			EXPECT_EQ(0, mq_close(mq));
+		_exit(_metadata->exit_code);
+		return;
+	}
+	EXPECT_EQ(0, close(pipe_unscoped[0]));
+
+	/* This domain is the parent of the creator and sibling domains. */
+	create_scoped_domain(_metadata, LANDLOCK_SCOPE_POSIX_MSG_QUEUE);
+	creator = fork();
+	ASSERT_LE(0, creator);
+	if (creator == 0) {
+		create_scoped_domain(_metadata, LANDLOCK_SCOPE_POSIX_MSG_QUEUE);
+		mq = mq_open(mq_name, O_CREAT | O_EXCL | O_RDWR, 0600, NULL);
+		ASSERT_LE(0, mq);
+		EXPECT_EQ(0, mq_close(mq));
+		_exit(_metadata->exit_code);
+		return;
+	}
+	ASSERT_EQ(creator, waitpid(creator, &status, 0));
+	ASSERT_EQ(1, WIFEXITED(status));
+	ASSERT_EQ(EXIT_SUCCESS, WEXITSTATUS(status));
+
+	/* The parent domain may access a queue created in its subdomain. */
+	mq = mq_open(mq_name, O_RDWR);
+	ASSERT_LE(0, mq);
+	EXPECT_EQ(0, mq_close(mq));
+
+	sibling = fork();
+	ASSERT_LE(0, sibling);
+	if (sibling == 0) {
+		create_scoped_domain(_metadata, LANDLOCK_SCOPE_POSIX_MSG_QUEUE);
+		mq = mq_open(mq_name, O_RDWR);
+		EXPECT_EQ(-1, mq);
+		EXPECT_EQ(EPERM, errno);
+		_exit(_metadata->exit_code);
+		return;
+	}
+	ASSERT_EQ(sibling, waitpid(sibling, &status, 0));
+	ASSERT_EQ(1, WIFEXITED(status));
+	EXPECT_EQ(EXIT_SUCCESS, WEXITSTATUS(status));
+
+	/* A process without a Landlock domain is not restricted by the scope. */
+	ASSERT_EQ(1, write(pipe_unscoped[1], ".", 1));
+	EXPECT_EQ(0, close(pipe_unscoped[1]));
+	ASSERT_EQ(unscoped, waitpid(unscoped, &status, 0));
+	ASSERT_EQ(1, WIFEXITED(status));
+	EXPECT_EQ(EXIT_SUCCESS, WEXITSTATUS(status));
+	EXPECT_EQ(0, mq_unlink(mq_name));
+}
+
+/*
+ * A child domain must not open a queue created by its parent domain, including
+ * after the process that created the queue has exited.
+ */
+TEST(open_queue_from_child_after_creator_exits)
+{
+	char mq_name[NAME_MAX], buf, result;
+	int pipe_ready[2], pipe_access[2], pipe_result[2], status;
+	pid_t creator;
+
+	drop_caps(_metadata);
+	set_mq_name(mq_name, sizeof(mq_name));
+	mq_unlink(mq_name);
+	ASSERT_EQ(0, pipe2(pipe_ready, O_CLOEXEC));
+	ASSERT_EQ(0, pipe2(pipe_access, O_CLOEXEC));
+	ASSERT_EQ(0, pipe2(pipe_result, O_CLOEXEC));
+
+	creator = fork();
+	ASSERT_LE(0, creator);
+	if (creator == 0) {
+		pid_t manager;
+		mqd_t mq;
+
+		EXPECT_EQ(0, close(pipe_ready[1]));
+		EXPECT_EQ(0, close(pipe_access[1]));
+		EXPECT_EQ(0, close(pipe_result[0]));
+		create_scoped_domain(_metadata, LANDLOCK_SCOPE_POSIX_MSG_QUEUE);
+		mq = mq_open(mq_name, O_CREAT | O_EXCL | O_RDWR, 0600, NULL);
+		ASSERT_LE(0, mq);
+		EXPECT_EQ(0, mq_close(mq));
+
+		manager = fork();
+		ASSERT_LE(0, manager);
+		if (manager == 0) {
+			int child_status;
+			pid_t child;
+
+			/* Retains the creator domain until a child can be created. */
+			ASSERT_EQ(1, write(pipe_result[1], ".", 1));
+			ASSERT_EQ(1, read(pipe_access[0], &buf, 1));
+
+			child = fork();
+			ASSERT_LE(0, child);
+			if (child == 0) {
+				create_scoped_domain(
+					_metadata,
+					LANDLOCK_SCOPE_POSIX_MSG_QUEUE);
+				mq = mq_open(mq_name, O_RDWR);
+				if (mq == -1 && errno == EPERM)
+					result = KSFT_PASS;
+				else
+					result = KSFT_FAIL;
+				if (mq >= 0)
+					EXPECT_EQ(0, mq_close(mq));
+				_exit(result);
+				return;
+			}
+			ASSERT_EQ(child, waitpid(child, &child_status, 0));
+			if (WIFEXITED(child_status))
+				result = WEXITSTATUS(child_status);
+			else
+				result = KSFT_FAIL;
+			ASSERT_EQ(1, write(pipe_result[1], &result, 1));
+			_exit(_metadata->exit_code);
+			return;
+		}
+
+		/* Exits once the same-domain manager is ready. */
+		ASSERT_EQ(1, read(pipe_ready[0], &buf, 1));
+		_exit(_metadata->exit_code);
+		return;
+	}
+	EXPECT_EQ(0, close(pipe_ready[0]));
+	EXPECT_EQ(0, close(pipe_access[0]));
+	EXPECT_EQ(0, close(pipe_result[1]));
+
+	/* Relays the manager's ready notification to the creator. */
+	ASSERT_EQ(1, read(pipe_result[0], &buf, 1));
+	ASSERT_EQ(1, write(pipe_ready[1], ".", 1));
+	ASSERT_EQ(creator, waitpid(creator, &status, 0));
+	ASSERT_EQ(1, WIFEXITED(status));
+	ASSERT_EQ(EXIT_SUCCESS, WEXITSTATUS(status));
+
+	ASSERT_EQ(1, write(pipe_access[1], ".", 1));
+	ASSERT_EQ(1, read(pipe_result[0], &result, 1));
+	EXPECT_EQ(KSFT_PASS, result);
+	EXPECT_EQ(0, mq_unlink(mq_name));
+}
+
+/*
+ * Destroying an IPC namespace containing a queue tagged with a Landlock domain
+ * must release both the queue object and its retained domain reference.
+ */
+TEST(posix_mqueue_ipc_namespace_lifetime)
+{
+	int status;
+	pid_t child;
+
+	child = fork();
+	ASSERT_LE(0, child);
+	if (child == 0) {
+		char mq_name[NAME_MAX];
+		mqd_t mq;
+
+		if (unshare(CLONE_NEWIPC)) {
+			if (errno == EPERM || errno == EINVAL)
+				_exit(KSFT_SKIP);
+			TH_LOG("Failed to create an IPC namespace: %s",
+			       strerror(errno));
+			_exit(KSFT_FAIL);
+		}
+		drop_caps(_metadata);
+		create_scoped_domain(_metadata, LANDLOCK_SCOPE_POSIX_MSG_QUEUE);
+		set_mq_name(mq_name, sizeof(mq_name));
+		mq = mq_open(mq_name, O_CREAT | O_EXCL | O_RDWR, 0600, NULL);
+		ASSERT_LE(0, mq);
+		EXPECT_EQ(0, mq_close(mq));
+
+		/* Exiting destroys the IPC namespace with the queue still linked. */
+		_exit(_metadata->exit_code);
+		return;
+	}
+
+	ASSERT_EQ(child, waitpid(child, &status, 0));
+	ASSERT_EQ(1, WIFEXITED(status));
+	if (WEXITSTATUS(status) == KSFT_SKIP)
+		SKIP(return, "IPC namespaces are unavailable or not permitted");
+	EXPECT_EQ(EXIT_SUCCESS, WEXITSTATUS(status));
+}
+
+/*
+ * A process must always be able to open a queue it created within its own
+ * domain, whatever the enforced scope is.
+ */
+TEST(create_and_open_same_domain)
+{
+	char mq_name[NAME_MAX];
+	mqd_t mq_create, mq_open_again;
+
+	drop_caps(_metadata);
+	set_mq_name(mq_name, sizeof(mq_name));
+	mq_unlink(mq_name);
+
+	create_scoped_domain(_metadata, LANDLOCK_SCOPE_POSIX_MSG_QUEUE);
+
+	mq_create = mq_open(mq_name, O_CREAT | O_RDWR, 0600, NULL);
+	ASSERT_LE(0, mq_create);
+
+	mq_open_again = mq_open(mq_name, O_RDWR);
+	EXPECT_LE(0, mq_open_again);
+	if (mq_open_again >= 0)
+		EXPECT_EQ(0, mq_close(mq_open_again));
+
+	EXPECT_EQ(0, mq_close(mq_create));
+	EXPECT_EQ(0, mq_unlink(mq_name));
+}
+
+/*
+ * Queue scoping and filesystem access must both allow an open.  A same-domain
+ * queue is denied by READ_FILE, and an outside queue is denied by scoping.
+ */
+TEST(posix_mqueue_scope_with_read_file_denied)
+{
+	const struct landlock_ruleset_attr ruleset_attr = {
+		.handled_access_fs = LANDLOCK_ACCESS_FS_READ_FILE,
+		.scoped = LANDLOCK_SCOPE_POSIX_MSG_QUEUE,
+	};
+	char outside_name[NAME_MAX], inside_name[NAME_MAX];
+	char file_path[] = "/tmp/landlock-mq-read-XXXXXX";
+	mqd_t outside_mq, inside_mq, reopened_mq;
+	int fd;
+
+	drop_caps(_metadata);
+	set_mq_name(outside_name, sizeof(outside_name));
+	ASSERT_LT(0, snprintf(inside_name, sizeof(inside_name),
+			      "/selftests-landlock-mq-inside-tid%d",
+			      sys_gettid()));
+	mq_unlink(outside_name);
+	mq_unlink(inside_name);
+
+	outside_mq =
+		mq_open(outside_name, O_CREAT | O_EXCL | O_RDONLY, 0600, NULL);
+	if (outside_mq < 0 && errno == ENOSYS)
+		SKIP(return, "POSIX message queues are not supported");
+	ASSERT_LE(0, outside_mq);
+
+	fd = mkstemp(file_path);
+	ASSERT_LE(0, fd);
+	EXPECT_EQ(0, close(fd));
+	fd = open(file_path, O_RDONLY | O_CLOEXEC);
+	ASSERT_LE(0, fd);
+	EXPECT_EQ(0, close(fd));
+
+	drop_access_rights(_metadata, &ruleset_attr);
+
+	fd = open(file_path, O_RDONLY | O_CLOEXEC);
+	EXPECT_EQ(-1, fd);
+	EXPECT_EQ(EACCES, errno);
+	if (fd >= 0)
+		EXPECT_EQ(0, close(fd));
+	EXPECT_EQ(0, unlink(file_path));
+
+	/* Create without requesting the denied READ_FILE access. */
+	inside_mq =
+		mq_open(inside_name, O_CREAT | O_EXCL | O_WRONLY, 0600, NULL);
+	ASSERT_LE(0, inside_mq);
+	reopened_mq = mq_open(inside_name, O_RDONLY);
+	EXPECT_EQ(-1, reopened_mq);
+	EXPECT_EQ(EACCES, errno);
+	if (reopened_mq >= 0)
+		EXPECT_EQ(0, mq_close(reopened_mq));
+
+	reopened_mq = mq_open(outside_name, O_RDONLY);
+	EXPECT_EQ(-1, reopened_mq);
+	EXPECT_EQ(EPERM, errno);
+	if (reopened_mq >= 0)
+		EXPECT_EQ(0, mq_close(reopened_mq));
+
+	EXPECT_EQ(0, mq_close(inside_mq));
+	EXPECT_EQ(0, mq_close(outside_mq));
+	EXPECT_EQ(0, mq_unlink(inside_name));
+	EXPECT_EQ(0, mq_unlink(outside_name));
+}
+
+/* Granted filesystem access must still be subject to queue scoping. */
+TEST(posix_mqueue_scope_with_read_file_allowed)
+{
+	const struct landlock_ruleset_attr ruleset_attr = {
+		.handled_access_fs = LANDLOCK_ACCESS_FS_READ_FILE,
+		.scoped = LANDLOCK_SCOPE_POSIX_MSG_QUEUE,
+	};
+	struct landlock_path_beneath_attr path_beneath = {
+		.allowed_access = LANDLOCK_ACCESS_FS_READ_FILE,
+	};
+	char outside_name[NAME_MAX], inside_name[NAME_MAX], path[PATH_MAX];
+	struct stat queue_stat, path_stat;
+	mqd_t outside_mq, inside_mq, reopened_mq;
+	int ruleset_fd, fd;
+
+	drop_caps(_metadata);
+	set_mq_name(outside_name, sizeof(outside_name));
+	ASSERT_LT(0, snprintf(inside_name, sizeof(inside_name),
+			      "/selftests-landlock-mq-inside-tid%d",
+			      sys_gettid()));
+	ASSERT_LT(0,
+		  snprintf(path, sizeof(path), "/dev/mqueue%s", outside_name));
+	mq_unlink(outside_name);
+	mq_unlink(inside_name);
+	outside_mq =
+		mq_open(outside_name, O_CREAT | O_EXCL | O_RDONLY, 0600, NULL);
+	if (outside_mq < 0 && errno == ENOSYS)
+		SKIP(return, "POSIX message queues are not supported");
+	ASSERT_LE(0, outside_mq);
+	ASSERT_EQ(0, fstat(outside_mq, &queue_stat));
+	if (stat(path, &path_stat) || queue_stat.st_dev != path_stat.st_dev ||
+	    queue_stat.st_ino != path_stat.st_ino) {
+		EXPECT_EQ(0, mq_close(outside_mq));
+		EXPECT_EQ(0, mq_unlink(outside_name));
+		SKIP(return, "/dev/mqueue does not expose this IPC namespace");
+	}
+	fd = open(path, O_RDONLY | O_CLOEXEC);
+	ASSERT_LE(0, fd);
+	EXPECT_EQ(0, close(fd));
+
+	ruleset_fd =
+		landlock_create_ruleset(&ruleset_attr, sizeof(ruleset_attr), 0);
+	ASSERT_LE(0, ruleset_fd);
+	path_beneath.parent_fd = open("/dev/mqueue", O_PATH | O_CLOEXEC);
+	ASSERT_LE(0, path_beneath.parent_fd);
+	ASSERT_EQ(0, landlock_add_rule(ruleset_fd, LANDLOCK_RULE_PATH_BENEATH,
+				       &path_beneath, 0));
+	EXPECT_EQ(0, close(path_beneath.parent_fd));
+	enforce_ruleset(_metadata, ruleset_fd);
+	EXPECT_EQ(0, close(ruleset_fd));
+
+	inside_mq =
+		mq_open(inside_name, O_CREAT | O_EXCL | O_RDONLY, 0600, NULL);
+	ASSERT_LE(0, inside_mq);
+	reopened_mq = mq_open(inside_name, O_RDONLY);
+	EXPECT_LE(0, reopened_mq);
+	if (reopened_mq >= 0)
+		EXPECT_EQ(0, mq_close(reopened_mq));
+
+	reopened_mq = mq_open(outside_name, O_RDONLY);
+	EXPECT_EQ(-1, reopened_mq);
+	EXPECT_EQ(EPERM, errno);
+	if (reopened_mq >= 0)
+		EXPECT_EQ(0, mq_close(reopened_mq));
+
+	/* Filesystem permission does not override the outside queue's scope. */
+	fd = open(path, O_RDONLY | O_CLOEXEC);
+	EXPECT_EQ(-1, fd);
+	EXPECT_EQ(EPERM, errno);
+	if (fd >= 0)
+		EXPECT_EQ(0, close(fd));
+
+	ASSERT_LT(0,
+		  snprintf(path, sizeof(path), "/dev/mqueue%s", inside_name));
+	fd = open(path, O_RDONLY | O_CLOEXEC);
+	EXPECT_LE(0, fd);
+	if (fd >= 0)
+		EXPECT_EQ(0, close(fd));
+
+	EXPECT_EQ(0, mq_close(inside_mq));
+	EXPECT_EQ(0, mq_close(outside_mq));
+	EXPECT_EQ(0, mq_unlink(inside_name));
+	EXPECT_EQ(0, mq_unlink(outside_name));
+}
+
+/* Both mq_open() and ordinary path-based opens must enforce queue scoping. */
+TEST(posix_mqueue_path_open)
+{
+	char outside_name[NAME_MAX], inside_name[NAME_MAX];
+	char outside_path[PATH_MAX], inside_path[PATH_MAX];
+	struct stat queue_stat, path_stat;
+	mqd_t outside_mq, inside_mq;
+	int fd;
+
+	drop_caps(_metadata);
+	set_mq_name(outside_name, sizeof(outside_name));
+	ASSERT_LT(0,
+		  snprintf(inside_name, sizeof(inside_name),
+			   "/selftests-landlock-mq-path-tid%d", sys_gettid()));
+	ASSERT_LT(0, snprintf(outside_path, sizeof(outside_path),
+			      "/dev/mqueue%s", outside_name));
+	ASSERT_LT(0, snprintf(inside_path, sizeof(inside_path), "/dev/mqueue%s",
+			      inside_name));
+	mq_unlink(outside_name);
+	mq_unlink(inside_name);
+	outside_mq =
+		mq_open(outside_name, O_CREAT | O_EXCL | O_RDWR, 0600, NULL);
+	if (outside_mq < 0 && errno == ENOSYS)
+		SKIP(return, "POSIX message queues are not supported");
+	ASSERT_LE(0, outside_mq);
+	ASSERT_EQ(0, fstat(outside_mq, &queue_stat));
+	if (stat(outside_path, &path_stat) ||
+	    queue_stat.st_dev != path_stat.st_dev ||
+	    queue_stat.st_ino != path_stat.st_ino) {
+		EXPECT_EQ(0, mq_close(outside_mq));
+		EXPECT_EQ(0, mq_unlink(outside_name));
+		SKIP(return, "/dev/mqueue does not expose this IPC namespace");
+	}
+	fd = open(outside_path, O_RDWR | O_CLOEXEC);
+	ASSERT_LE(0, fd);
+	EXPECT_EQ(0, close(fd));
+
+	create_scoped_domain(_metadata, LANDLOCK_SCOPE_POSIX_MSG_QUEUE);
+	fd = open(outside_path, O_RDWR | O_CLOEXEC);
+	EXPECT_EQ(-1, fd);
+	EXPECT_EQ(EPERM, errno);
+	if (fd >= 0)
+		EXPECT_EQ(0, close(fd));
+
+	inside_mq = mq_open(inside_name, O_CREAT | O_EXCL | O_RDWR, 0600, NULL);
+	ASSERT_LE(0, inside_mq);
+	fd = open(inside_path, O_RDWR | O_CLOEXEC);
+	ASSERT_LE(0, fd);
+	EXPECT_EQ(0, close(fd));
+	EXPECT_EQ(0, mq_close(inside_mq));
+	EXPECT_EQ(0, mq_close(outside_mq));
+	EXPECT_EQ(0, mq_unlink(inside_name));
+	EXPECT_EQ(0, mq_unlink(outside_name));
+}
+
+FIXTURE(posix_mqueue_descriptor)
+{
+	char name[NAME_MAX];
+	mqd_t mq;
+};
+
+FIXTURE_VARIANT(posix_mqueue_descriptor)
+{
+	bool pass_fd;
+};
+
+/* clang-format off */
+FIXTURE_VARIANT_ADD(posix_mqueue_descriptor, inherited) {
+	/* clang-format on */
+	.pass_fd = false,
+};
+
+/* clang-format off */
+FIXTURE_VARIANT_ADD(posix_mqueue_descriptor, passed) {
+	/* clang-format on */
+	.pass_fd = true,
+};
+
+FIXTURE_SETUP(posix_mqueue_descriptor)
+{
+	const struct mq_attr attr = {
+		.mq_maxmsg = 1,
+		.mq_msgsize = 1,
+	};
+
+	drop_caps(_metadata);
+	set_mq_name(self->name, sizeof(self->name));
+	mq_unlink(self->name);
+	self->mq = mq_open(self->name, O_CREAT | O_EXCL | O_RDWR | O_NONBLOCK,
+			   0600, &attr);
+	if (self->mq < 0 && errno == ENOSYS)
+		SKIP(return, "POSIX message queues are not supported");
+	ASSERT_LE(0, self->mq);
+}
+
+FIXTURE_TEARDOWN(posix_mqueue_descriptor)
+{
+	EXPECT_EQ(0, mq_close(self->mq));
+	EXPECT_EQ(0, mq_unlink(self->name));
+}
+
+/* Existing descriptors remain usable even when reopening the queue is denied. */
+TEST_F(posix_mqueue_descriptor, use_outside_queue)
+{
+	int sockets[2], status;
+	char ready;
+	pid_t child;
+
+	ASSERT_EQ(0,
+		  socketpair(AF_UNIX, SOCK_STREAM | SOCK_CLOEXEC, 0, sockets));
+	child = fork();
+	ASSERT_LE(0, child);
+	if (child == 0) {
+		mqd_t mq = self->mq, reopened;
+		char message;
+
+		EXPECT_EQ(0, close(sockets[0]));
+		/* Ensure the passed variant cannot use an inherited queue FD. */
+		if (variant->pass_fd)
+			ASSERT_EQ(0, mq_close(mq));
+		create_scoped_domain(_metadata, LANDLOCK_SCOPE_POSIX_MSG_QUEUE);
+		reopened = mq_open(self->name, O_RDWR);
+		EXPECT_EQ(-1, reopened);
+		EXPECT_EQ(EPERM, errno);
+		if (reopened >= 0)
+			EXPECT_EQ(0, mq_close(reopened));
+
+		/* The parent sends the FD only after the child enters its scope. */
+		ASSERT_EQ(1, write(sockets[1], ".", 1));
+		if (variant->pass_fd) {
+			mq = recv_fd(sockets[1]);
+			ASSERT_LE(0, mq);
+		}
+		ASSERT_EQ(0, mq_send(mq, "q", 1, 0));
+		ASSERT_EQ(1, mq_receive(mq, &message, sizeof(message), NULL));
+		EXPECT_EQ('q', message);
+		EXPECT_EQ(0, mq_close(mq));
+		EXPECT_EQ(0, close(sockets[1]));
+		_exit(_metadata->exit_code);
+	}
+	EXPECT_EQ(0, close(sockets[1]));
+	ASSERT_EQ(1, read(sockets[0], &ready, 1));
+	if (variant->pass_fd)
+		ASSERT_EQ(0, send_fd(sockets[0], self->mq));
+	EXPECT_EQ(0, close(sockets[0]));
+	ASSERT_EQ(child, waitpid(child, &status, 0));
+	ASSERT_TRUE(WIFEXITED(status));
+	EXPECT_EQ(EXIT_SUCCESS, WEXITSTATUS(status));
+}
+
+TEST_HARNESS_MAIN
diff --git a/tools/testing/selftests/landlock/scoped_test.c b/tools/testing/selftests/landlock/scoped_test.c
index b90f76ed0d9c..c530baa50948 100644
--- a/tools/testing/selftests/landlock/scoped_test.c
+++ b/tools/testing/selftests/landlock/scoped_test.c
@@ -12,7 +12,7 @@
 
 #include "common.h"
 
-#define ACCESS_LAST LANDLOCK_SCOPE_SIGNAL
+#define ACCESS_LAST LANDLOCK_SCOPE_POSIX_MSG_QUEUE
 
 TEST(ruleset_with_unknown_scope)
 {
-- 
2.43.0

