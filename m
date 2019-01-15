Return-Path: <SRS0=ihUA=PX=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF148C43387
	for <linux-security-module@archiver.kernel.org>; Tue, 15 Jan 2019 21:50:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F7CF2086D
	for <linux-security-module@archiver.kernel.org>; Tue, 15 Jan 2019 21:50:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="oNG+4LpC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730752AbfAOVu0 (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 15 Jan 2019 16:50:26 -0500
Received: from mail-pf1-f198.google.com ([209.85.210.198]:42064 "EHLO
        mail-pf1-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728421AbfAOVuZ (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 15 Jan 2019 16:50:25 -0500
Received: by mail-pf1-f198.google.com with SMTP id y88so2990735pfi.9
        for <linux-security-module@vger.kernel.org>; Tue, 15 Jan 2019 13:50:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc:content-transfer-encoding;
        bh=H61FtkCOeoj/XUa1XFjdscksQnEdKgQb1vhPYpNB5mg=;
        b=oNG+4LpCSX5m2Oq1yWJEKWg4cXvWpbU9Xlg21LHC1Nqk1DnCEKEsvNPOdRSMwuKY7T
         64QrNghyiMoN+DgJTTjBE1imh0iYIUNl9KXqDLj0/bBy0XCB5OaevIlc79C1Vlaas0wG
         KmW0gDSkTbZtlVb2tP4MQdWjbr3GkxtgrK3iE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc:content-transfer-encoding;
        bh=H61FtkCOeoj/XUa1XFjdscksQnEdKgQb1vhPYpNB5mg=;
        b=Z1YjQHnj3yJ0plm38r3rCWIArfOlhhRHIG3EwUqt75T1Ajh6NlcoflyUGIf9qCwuUk
         /2+77fTANo+q7zlqk0wfbCAXzlj1GGTI678OI1oR8vwt7kqd9nesfZiKs1qJ0uBB8GTc
         zbuslUvgDAqlT2+x5692OVoLIwlpSKx1JFVuInXzFRD/NCfxuy/hN/zPmLkaRE0JqBsG
         VrV5jBUcQuWbDjCTy8KbHQblRqalbdlWay2ubA0qT6RQvkY1UgSrRyksTJPtZkgEKpve
         I4iFZRRf5MdyZ6ai86xiQLgSHckULPX6+hIjNU30Cg3gaIN/T3K3qjsYgz0k+VB6tSRd
         qt1w==
X-Gm-Message-State: AJcUukeGwj/rPlywqsWX3hVplFRG5WVTqCmJQ0EXqhPY94YpWU6/UoTb
        GzzQPlzVLtkDh4mQmLA4QZO2e5/zBwBeqhvZ
X-Google-Smtp-Source: ALg8bN5ap7R1kCuU57SWpG2MVKITk3NsCLsaANPgA/e0gsZLeZos+opfP+CSsw2R2xNqHhaC9jjDweMv6QLjwAI+
X-Received: by 2002:a17:902:8e88:: with SMTP id bg8mr1786908plb.110.1547589024089;
 Tue, 15 Jan 2019 13:50:24 -0800 (PST)
Date:   Tue, 15 Jan 2019 13:50:20 -0800
In-Reply-To: <CAGXu5jJUb3V24Yqx4m=3u_-7qv2P0qKJqreusTmpw8BkAJWL0A@mail.gmail.com>
Message-Id: <20190115215020.234860-1-mortonm@chromium.org>
Mime-Version: 1.0
References: <CAGXu5jJUb3V24Yqx4m=3u_-7qv2P0qKJqreusTmpw8BkAJWL0A@mail.gmail.com>
X-Mailer: git-send-email 2.20.1.97.g81188d93c3-goog
Subject: [PATCH v4 2/2] LSM: add SafeSetID module that gates setid calls
From:   mortonm@chromium.org
To:     jmorris@namei.org, serge@hallyn.com, keescook@chromium.org,
        casey@schaufler-ca.com, sds@tycho.nsa.gov,
        linux-security-module@vger.kernel.org
Cc:     Micah Morton <mortonm@chromium.org>
Content-Type: text/plain; charset="y"
Content-Transfer-Encoding: quoted-printable
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

From: Micah Morton <mortonm@chromium.org>

SafeSetID gates the setid family of syscalls to restrict UID/GID
transitions from a given UID/GID to only those approved by a
system-wide whitelist. These restrictions also prohibit the given
UIDs/GIDs from obtaining auxiliary privileges associated with
CAP_SET{U/G}ID, such as allowing a user to set up user namespace UID
mappings. For now, only gating the set*uid family of syscalls is
supported, with support for set*gid coming in a future patch set.

Signed-off-by: Micah Morton <mortonm@chromium.org>
---
Changes since last patch set: More small mods suggested by Kees, also
changed the do_exit() operation in lsm.c to force_sig() instead.

 Documentation/admin-guide/LSM/SafeSetID.rst | 107 ++++++++
 Documentation/admin-guide/LSM/index.rst     |   1 +
 security/Kconfig                            |   1 +
 security/Makefile                           |   2 +
 security/safesetid/Kconfig                  |  12 +
 security/safesetid/Makefile                 |   7 +
 security/safesetid/lsm.c                    | 271 ++++++++++++++++++++
 security/safesetid/lsm.h                    |  30 +++
 security/safesetid/securityfs.c             | 190 ++++++++++++++
 9 files changed, 621 insertions(+)
 create mode 100644 Documentation/admin-guide/LSM/SafeSetID.rst
 create mode 100644 security/safesetid/Kconfig
 create mode 100644 security/safesetid/Makefile
 create mode 100644 security/safesetid/lsm.c
 create mode 100644 security/safesetid/lsm.h
 create mode 100644 security/safesetid/securityfs.c

diff --git a/Documentation/admin-guide/LSM/SafeSetID.rst b/Documentation/ad=
min-guide/LSM/SafeSetID.rst
new file mode 100644
index 000000000000..ffb64be67f7a
--- /dev/null
+++ b/Documentation/admin-guide/LSM/SafeSetID.rst
@@ -0,0 +1,107 @@
+=3D=3D=3D=3D=3D=3D=3D=3D=3D
+SafeSetID
+=3D=3D=3D=3D=3D=3D=3D=3D=3D
+SafeSetID is an LSM module that gates the setid family of syscalls to rest=
rict
+UID/GID transitions from a given UID/GID to only those approved by a
+system-wide whitelist. These restrictions also prohibit the given UIDs/GID=
s
+from obtaining auxiliary privileges associated with CAP_SET{U/G}ID, such a=
s
+allowing a user to set up user namespace UID mappings.
+
+
+Background
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+In absence of file capabilities, processes spawned on a Linux system that =
need
+to switch to a different user must be spawned with CAP_SETUID privileges.
+CAP_SETUID is granted to programs running as root or those running as a no=
n-root
+user that have been explicitly given the CAP_SETUID runtime capability. It=
 is
+often preferable to use Linux runtime capabilities rather than file
+capabilities, since using file capabilities to run a program with elevated
+privileges opens up possible security holes since any user with access to =
the
+file can exec() that program to gain the elevated privileges.
+
+While it is possible to implement a tree of processes by giving full
+CAP_SET{U/G}ID capabilities, this is often at odds with the goals of runni=
ng a
+tree of processes under non-root user(s) in the first place. Specifically,
+since CAP_SETUID allows changing to any user on the system, including the =
root
+user, it is an overpowered capability for what is needed in this scenario,
+especially since programs often only call setuid() to drop privileges to a
+lesser-privileged user -- not elevate privileges. Unfortunately, there is =
no
+generally feasible way in Linux to restrict the potential UIDs that a user=
 can
+switch to through setuid() beyond allowing a switch to any user on the sys=
tem.
+This SafeSetID LSM seeks to provide a solution for restricting setid
+capabilities in such a way.
+
+The main use case for this LSM is to allow a non-root program to transitio=
n to
+other untrusted uids without full blown CAP_SETUID capabilities. The non-r=
oot
+program would still need CAP_SETUID to do any kind of transition, but the
+additional restrictions imposed by this LSM would mean it is a "safer" ver=
sion
+of CAP_SETUID since the non-root program cannot take advantage of CAP_SETU=
ID to
+do any unapproved actions (e.g. setuid to uid 0 or create/enter new user
+namespace). The higher level goal is to allow for uid-based sandboxing of =
system
+services without having to give out CAP_SETUID all over the place just so =
that
+non-root programs can drop to even-lesser-privileged uids. This is especia=
lly
+relevant when one non-root daemon on the system should be allowed to spawn=
 other
+processes as different uids, but its undesirable to give the daemon a
+basically-root-equivalent CAP_SETUID.
+
+
+Other Approaches Considered
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
+
+Solve this problem in userspace
+-------------------------------
+For candidate applications that would like to have restricted setid capabi=
lities
+as implemented in this LSM, an alternative option would be to simply take =
away
+setid capabilities from the application completely and refactor the proces=
s
+spawning semantics in the application (e.g. by using a privileged helper p=
rogram
+to do process spawning and UID/GID transitions). Unfortunately, there are =
a
+number of semantics around process spawning that would be affected by this=
, such
+as fork() calls where the program doesn=E2=80=99t immediately call exec() =
after the
+fork(), parent processes specifying custom environment variables or comman=
d line
+args for spawned child processes, or inheritance of file handles across a
+fork()/exec(). Because of this, as solution that uses a privileged helper =
in
+userspace would likely be less appealing to incorporate into existing proj=
ects
+that rely on certain process-spawning semantics in Linux.
+
+Use user namespaces
+-------------------
+Another possible approach would be to run a given process tree in its own =
user
+namespace and give programs in the tree setid capabilities. In this way,
+programs in the tree could change to any desired UID/GID in the context of=
 their
+own user namespace, and only approved UIDs/GIDs could be mapped back to th=
e
+initial system user namespace, affectively preventing privilege escalation=
.
+Unfortunately, it is not generally feasible to use user namespaces in isol=
ation,
+without pairing them with other namespace types, which is not always an op=
tion.
+Linux checks for capabilities based off of the user namespace that =E2=80=
=9Cowns=E2=80=9D some
+entity. For example, Linux has the notion that network namespaces are owne=
d by
+the user namespace in which they were created. A consequence of this is th=
at
+capability checks for access to a given network namespace are done by chec=
king
+whether a task has the given capability in the context of the user namespa=
ce
+that owns the network namespace -- not necessarily the user namespace unde=
r
+which the given task runs. Therefore spawning a process in a new user name=
space
+effectively prevents it from accessing the network namespace owned by the
+initial namespace. This is a deal-breaker for any application that expects=
 to
+retain the CAP_NET_ADMIN capability for the purpose of adjusting network
+configurations. Using user namespaces in isolation causes problems regardi=
ng
+other system interactions, including use of pid namespaces and device crea=
tion.
+
+Use an existing LSM
+-------------------
+None of the other in-tree LSMs have the capability to gate setid transitio=
ns, or
+even employ the security_task_fix_setuid hook at all. SELinux says of that=
 hook:
+"Since setuid only affects the current process, and since the SELinux cont=
rols
+are not based on the Linux identity attributes, SELinux does not need to c=
ontrol
+this operation."
+
+
+Directions for use
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+This LSM hooks the setid syscalls to make sure transitions are allowed if =
an
+applicable restriction policy is in place. Policies are configured through
+securityfs by writing to the safesetid/add_whitelist_policy and
+safesetid/flush_whitelist_policies files at the location where securityfs =
is
+mounted. The format for adding a policy is '<UID>:<UID>', using literal
+numbers, such as '123:456'. To flush the policies, any write to the file i=
s
+sufficient. Again, configuring a policy for a UID will prevent that UID fr=
om
+obtaining auxiliary setid privileges, such as allowing a user to set up us=
er
+namespace UID mappings.
diff --git a/Documentation/admin-guide/LSM/index.rst b/Documentation/admin-=
guide/LSM/index.rst
index 9842e21afd4a..a6ba95fbaa9f 100644
--- a/Documentation/admin-guide/LSM/index.rst
+++ b/Documentation/admin-guide/LSM/index.rst
@@ -46,3 +46,4 @@ subdirectories.
    Smack
    tomoyo
    Yama
+   SafeSetID
diff --git a/security/Kconfig b/security/Kconfig
index 78dc12b7eeb3..9efc7a5e3280 100644
--- a/security/Kconfig
+++ b/security/Kconfig
@@ -236,6 +236,7 @@ source "security/tomoyo/Kconfig"
 source "security/apparmor/Kconfig"
 source "security/loadpin/Kconfig"
 source "security/yama/Kconfig"
+source "security/safesetid/Kconfig"
=20
 source "security/integrity/Kconfig"
=20
diff --git a/security/Makefile b/security/Makefile
index 4d2d3782ddef..c598b904938f 100644
--- a/security/Makefile
+++ b/security/Makefile
@@ -10,6 +10,7 @@ subdir-$(CONFIG_SECURITY_TOMOYO)        +=3D tomoyo
 subdir-$(CONFIG_SECURITY_APPARMOR)	+=3D apparmor
 subdir-$(CONFIG_SECURITY_YAMA)		+=3D yama
 subdir-$(CONFIG_SECURITY_LOADPIN)	+=3D loadpin
+subdir-$(CONFIG_SECURITY_SAFESETID)    +=3D safesetid
=20
 # always enable default capabilities
 obj-y					+=3D commoncap.o
@@ -25,6 +26,7 @@ obj-$(CONFIG_SECURITY_TOMOYO)		+=3D tomoyo/
 obj-$(CONFIG_SECURITY_APPARMOR)		+=3D apparmor/
 obj-$(CONFIG_SECURITY_YAMA)		+=3D yama/
 obj-$(CONFIG_SECURITY_LOADPIN)		+=3D loadpin/
+obj-$(CONFIG_SECURITY_SAFESETID)       +=3D safesetid/
 obj-$(CONFIG_CGROUP_DEVICE)		+=3D device_cgroup.o
=20
 # Object integrity file lists
diff --git a/security/safesetid/Kconfig b/security/safesetid/Kconfig
new file mode 100644
index 000000000000..bf89a47ffcc8
--- /dev/null
+++ b/security/safesetid/Kconfig
@@ -0,0 +1,12 @@
+config SECURITY_SAFESETID
+        bool "Gate setid transitions to limit CAP_SET{U/G}ID capabilities"
+        default n
+        help
+          SafeSetID is an LSM module that gates the setid family of syscal=
ls to
+          restrict UID/GID transitions from a given UID/GID to only those
+          approved by a system-wide whitelist. These restrictions also pro=
hibit
+          the given UIDs/GIDs from obtaining auxiliary privileges associat=
ed
+          with CAP_SET{U/G}ID, such as allowing a user to set up user name=
space
+          UID mappings.
+
+          If you are unsure how to answer this question, answer N.
diff --git a/security/safesetid/Makefile b/security/safesetid/Makefile
new file mode 100644
index 000000000000..6b0660321164
--- /dev/null
+++ b/security/safesetid/Makefile
@@ -0,0 +1,7 @@
+# SPDX-License-Identifier: GPL-2.0
+#
+# Makefile for the safesetid LSM.
+#
+
+obj-$(CONFIG_SECURITY_SAFESETID) :=3D safesetid.o
+safesetid-y :=3D lsm.o securityfs.o
diff --git a/security/safesetid/lsm.c b/security/safesetid/lsm.c
new file mode 100644
index 000000000000..c38cab263362
--- /dev/null
+++ b/security/safesetid/lsm.c
@@ -0,0 +1,271 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * SafeSetID Linux Security Module
+ *
+ * Author: Micah Morton <mortonm@chromium.org>
+ *
+ * Copyright (C) 2018 The Chromium OS Authors.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2, as
+ * published by the Free Software Foundation.
+ *
+ */
+
+#define pr_fmt(fmt) "SafeSetID: " fmt
+
+#include <asm/syscall.h>
+#include <linux/hashtable.h>
+#include <linux/lsm_hooks.h>
+#include <linux/module.h>
+#include <linux/ptrace.h>
+#include <linux/sched/task_stack.h>
+#include <linux/security.h>
+
+#define NUM_BITS 8 /* 128 buckets in hash table */
+
+static DEFINE_HASHTABLE(safesetid_whitelist_hashtable, NUM_BITS);
+
+/*
+ * Hash table entry to store safesetid policy signifying that 'parent' use=
r
+ * can setid to 'child' user.
+ */
+struct entry {
+	struct hlist_node next;
+	struct hlist_node dlist; /* for deletion cleanup */
+	uint64_t parent_kuid;
+	uint64_t child_kuid;
+};
+
+static DEFINE_SPINLOCK(safesetid_whitelist_hashtable_spinlock);
+
+static bool check_setuid_policy_hashtable_key(kuid_t parent)
+{
+	struct entry *entry;
+
+	rcu_read_lock();
+	hash_for_each_possible_rcu(safesetid_whitelist_hashtable,
+				   entry, next, __kuid_val(parent)) {
+		if (entry->parent_kuid =3D=3D __kuid_val(parent)) {
+			rcu_read_unlock();
+			return true;
+		}
+	}
+	rcu_read_unlock();
+
+	return false;
+}
+
+static bool check_setuid_policy_hashtable_key_value(kuid_t parent,
+						    kuid_t child)
+{
+	struct entry *entry;
+
+	rcu_read_lock();
+	hash_for_each_possible_rcu(safesetid_whitelist_hashtable,
+				   entry, next, __kuid_val(parent)) {
+		if (entry->parent_kuid =3D=3D __kuid_val(parent) &&
+		    entry->child_kuid =3D=3D __kuid_val(child)) {
+			rcu_read_unlock();
+			return true;
+		}
+	}
+	rcu_read_unlock();
+
+	return false;
+}
+
+static int safesetid_security_capable(const struct cred *cred,
+				      struct user_namespace *ns,
+				      int cap,
+				      unsigned int opts)
+{
+	if (cap =3D=3D CAP_SETUID &&
+	    check_setuid_policy_hashtable_key(cred->uid)) {
+		if (!(opts & CAP_OPT_INSETID)) {
+			/*
+			 * Deny if we're not in a set*uid() syscall to avoid
+			 * giving powers gated by CAP_SETUID that are related
+			 * to functionality other than calling set*uid() (e.g.
+			 * allowing user to set up userns uid mappings).
+			 */
+			pr_warn("Operation requires CAP_SETUID, which is not available to UID %=
u for operations besides approved set*uid transitions",
+				__kuid_val(cred->uid));
+			return -1;
+		}
+	}
+	return 0;
+}
+
+static int check_uid_transition(kuid_t parent, kuid_t child)
+{
+	if (check_setuid_policy_hashtable_key_value(parent, child))
+		return 0;
+	pr_warn("UID transition (%d -> %d) blocked",
+		__kuid_val(parent),
+		__kuid_val(child));
+	/*
+	 * Kill this process to avoid potential security vulnerabilities
+	 * that could arise from a missing whitelist entry preventing a
+	 * privileged process from dropping to a lesser-privileged one.
+	 */
+	force_sig(SIGKILL, current);
+	return -EACCES;
+}
+
+/*
+ * Check whether there is either an exception for user under old cred stru=
ct to
+ * set*uid to user under new cred struct, or the UID transition is allowed=
 (by
+ * Linux set*uid rules) even without CAP_SETUID.
+ */
+static int safesetid_task_fix_setuid(struct cred *new,
+				     const struct cred *old,
+				     int flags)
+{
+
+	/* Do nothing if there are no setuid restrictions for this UID. */
+	if (!check_setuid_policy_hashtable_key(old->uid))
+		return 0;
+
+	switch (flags) {
+	case LSM_SETID_RE:
+		/*
+		 * Users for which setuid restrictions exist can only set the
+		 * real UID to the real UID or the effective UID, unless an
+		 * explicit whitelist policy allows the transition.
+		 */
+		if (!uid_eq(old->uid, new->uid) &&
+			!uid_eq(old->euid, new->uid)) {
+			return check_uid_transition(old->uid, new->uid);
+		}
+		/*
+		 * Users for which setuid restrictions exist can only set the
+		 * effective UID to the real UID, the effective UID, or the
+		 * saved set-UID, unless an explicit whitelist policy allows
+		 * the transition.
+		 */
+		if (!uid_eq(old->uid, new->euid) &&
+			!uid_eq(old->euid, new->euid) &&
+			!uid_eq(old->suid, new->euid)) {
+			return check_uid_transition(old->euid, new->euid);
+		}
+		break;
+	case LSM_SETID_ID:
+		/*
+		 * Users for which setuid restrictions exist cannot change the
+		 * real UID or saved set-UID unless an explicit whitelist
+		 * policy allows the transition.
+		 */
+		if (!uid_eq(old->uid, new->uid))
+			return check_uid_transition(old->uid, new->uid);
+		if (!uid_eq(old->suid, new->suid))
+			return check_uid_transition(old->suid, new->suid);
+		break;
+	case LSM_SETID_RES:
+		/*
+		 * Users for which setuid restrictions exist cannot change the
+		 * real UID, effective UID, or saved set-UID to anything but
+		 * one of: the current real UID, the current effective UID or
+		 * the current saved set-user-ID unless an explicit whitelist
+		 * policy allows the transition.
+		 */
+		if (!uid_eq(new->uid, old->uid) &&
+			!uid_eq(new->uid, old->euid) &&
+			!uid_eq(new->uid, old->suid)) {
+			return check_uid_transition(old->uid, new->uid);
+		}
+		if (!uid_eq(new->euid, old->uid) &&
+			!uid_eq(new->euid, old->euid) &&
+			!uid_eq(new->euid, old->suid)) {
+			return check_uid_transition(old->euid, new->euid);
+		}
+		if (!uid_eq(new->suid, old->uid) &&
+			!uid_eq(new->suid, old->euid) &&
+			!uid_eq(new->suid, old->suid)) {
+			return check_uid_transition(old->suid, new->suid);
+		}
+		break;
+	case LSM_SETID_FS:
+		/*
+		 * Users for which setuid restrictions exist cannot change the
+		 * filesystem UID to anything but one of: the current real UID,
+		 * the current effective UID or the current saved set-UID
+		 * unless an explicit whitelist policy allows the transition.
+		 */
+		if (!uid_eq(new->fsuid, old->uid)  &&
+			!uid_eq(new->fsuid, old->euid)  &&
+			!uid_eq(new->fsuid, old->suid) &&
+			!uid_eq(new->fsuid, old->fsuid)) {
+			return check_uid_transition(old->fsuid, new->fsuid);
+		}
+		break;
+	default:
+		WARN_ON_ONCE("Unknown setid state %d\n", flags);
+		force_sig(SIGKILL, current);
+		return -EINVAL;
+	}
+	return 0;
+}
+
+int add_safesetid_whitelist_entry(kuid_t parent, kuid_t child)
+{
+	struct entry *new;
+
+	/* Return if entry already exists */
+	if (check_setuid_policy_hashtable_key_value(parent, child))
+		return 0;
+
+	new =3D kzalloc(sizeof(struct entry), GFP_KERNEL);
+	if (!new)
+		return -ENOMEM;
+	new->parent_kuid =3D __kuid_val(parent);
+	new->child_kuid =3D __kuid_val(child);
+	spin_lock(&safesetid_whitelist_hashtable_spinlock);
+	hash_add_rcu(safesetid_whitelist_hashtable,
+		     &new->next,
+		     __kuid_val(parent));
+	spin_unlock(&safesetid_whitelist_hashtable_spinlock);
+	return 0;
+}
+
+void flush_safesetid_whitelist_entries(void)
+{
+	struct entry *entry;
+	struct hlist_node *hlist_node;
+	unsigned int bkt_loop_cursor;
+	HLIST_HEAD(free_list);
+
+	/*
+	 * Could probably use hash_for_each_rcu here instead, but this should
+	 * be fine as well.
+	 */
+	spin_lock(&safesetid_whitelist_hashtable_spinlock);
+	hash_for_each_safe(safesetid_whitelist_hashtable, bkt_loop_cursor,
+			   hlist_node, entry, next) {
+		hash_del_rcu(&entry->next);
+		hlist_add_head(&entry->dlist, &free_list);
+	}
+	spin_unlock(&safesetid_whitelist_hashtable_spinlock);
+	synchronize_rcu();
+	hlist_for_each_entry_safe(entry, hlist_node, &free_list, dlist) {
+		hlist_del(&entry->dlist);
+		kfree(entry);
+	}
+}
+
+static struct security_hook_list safesetid_security_hooks[] =3D {
+	LSM_HOOK_INIT(task_fix_setuid, safesetid_task_fix_setuid),
+	LSM_HOOK_INIT(capable, safesetid_security_capable)
+};
+
+static int __init safesetid_security_init(void)
+{
+	security_add_hooks(safesetid_security_hooks,
+			   ARRAY_SIZE(safesetid_security_hooks), "safesetid");
+
+	return 0;
+}
+
+DEFINE_LSM(safesetid_security_init) =3D {
+	.init =3D safesetid_security_init,
+};
diff --git a/security/safesetid/lsm.h b/security/safesetid/lsm.h
new file mode 100644
index 000000000000..bf78af9bf314
--- /dev/null
+++ b/security/safesetid/lsm.h
@@ -0,0 +1,30 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * SafeSetID Linux Security Module
+ *
+ * Author: Micah Morton <mortonm@chromium.org>
+ *
+ * Copyright (C) 2018 The Chromium OS Authors.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2, as
+ * published by the Free Software Foundation.
+ *
+ */
+#ifndef _SAFESETID_H
+#define _SAFESETID_H
+
+#include <linux/types.h>
+
+/* Function type. */
+enum safesetid_whitelist_file_write_type {
+	SAFESETID_WHITELIST_ADD, /* Add whitelist policy. */
+	SAFESETID_WHITELIST_FLUSH, /* Flush whitelist policies. */
+};
+
+/* Add entry to safesetid whitelist to allow 'parent' to setid to 'child'.=
 */
+int add_safesetid_whitelist_entry(kuid_t parent, kuid_t child);
+
+void flush_safesetid_whitelist_entries(void);
+
+#endif /* _SAFESETID_H */
diff --git a/security/safesetid/securityfs.c b/security/safesetid/securityf=
s.c
new file mode 100644
index 000000000000..6c502f6d4fb0
--- /dev/null
+++ b/security/safesetid/securityfs.c
@@ -0,0 +1,190 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * SafeSetID Linux Security Module
+ *
+ * Author: Micah Morton <mortonm@chromium.org>
+ *
+ * Copyright (C) 2018 The Chromium OS Authors.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2, as
+ * published by the Free Software Foundation.
+ *
+ */
+#include <linux/security.h>
+#include <linux/cred.h>
+
+#include "lsm.h"
+
+static struct dentry *safesetid_policy_dir;
+
+struct safesetid_file_entry {
+	const char *name;
+	enum safesetid_whitelist_file_write_type type;
+	struct dentry *dentry;
+};
+
+static struct safesetid_file_entry safesetid_files[] =3D {
+	{.name =3D "add_whitelist_policy",
+	 .type =3D SAFESETID_WHITELIST_ADD},
+	{.name =3D "flush_whitelist_policies",
+	 .type =3D SAFESETID_WHITELIST_FLUSH},
+};
+
+/*
+ * In the case the input buffer contains one or more invalid UIDs, the kui=
d_t
+ * variables pointed to by 'parent' and 'child' will get updated but this
+ * function will return an error.
+ */
+static int parse_safesetid_whitelist_policy(const char __user *buf,
+					    size_t len,
+					    kuid_t *parent,
+					    kuid_t *child)
+{
+	char *kern_buf;
+	char *parent_buf;
+	char *child_buf;
+	const char separator[] =3D ":";
+	int ret;
+	size_t first_substring_length;
+	long parsed_parent;
+	long parsed_child;
+
+	/* Duplicate string from user memory and NULL-terminate */
+	kern_buf =3D memdup_user_nul(buf, len);
+	if (IS_ERR(kern_buf))
+		return PTR_ERR(kern_buf);
+
+	/*
+	 * Format of |buf| string should be <UID>:<UID>.
+	 * Find location of ":" in kern_buf (copied from |buf|).
+	 */
+	first_substring_length =3D strcspn(kern_buf, separator);
+	if (first_substring_length =3D=3D 0 || first_substring_length =3D=3D len)=
 {
+		ret =3D -EINVAL;
+		goto free_kern;
+	}
+
+	parent_buf =3D kmemdup_nul(kern_buf, first_substring_length, GFP_KERNEL);
+	if (!parent_buf) {
+		ret =3D -ENOMEM;
+		goto free_kern;
+	}
+
+	ret =3D kstrtol(parent_buf, 0, &parsed_parent);
+	if (ret)
+		goto free_both;
+
+	child_buf =3D kern_buf + first_substring_length + 1;
+	ret =3D kstrtol(child_buf, 0, &parsed_child);
+	if (ret)
+		goto free_both;
+
+	*parent =3D make_kuid(current_user_ns(), parsed_parent);
+	if (!uid_valid(*parent)) {
+		ret =3D -EINVAL;
+		goto free_both;
+	}
+
+	*child =3D make_kuid(current_user_ns(), parsed_child);
+	if (!uid_valid(*child)) {
+		ret =3D -EINVAL;
+		goto free_both;
+	}
+
+free_both:
+	kfree(parent_buf);
+free_kern:
+	kfree(kern_buf);
+	return ret;
+}
+
+static ssize_t safesetid_file_write(struct file *file,
+				    const char __user *buf,
+				    size_t len,
+				    loff_t *ppos)
+{
+	struct safesetid_file_entry *file_entry =3D
+		file->f_inode->i_private;
+	kuid_t parent;
+	kuid_t child;
+	int ret;
+
+	if (!ns_capable(current_user_ns(), CAP_MAC_ADMIN))
+		return -EPERM;
+
+	if (*ppos !=3D 0)
+		return -EINVAL;
+
+	switch (file_entry->type) {
+	case SAFESETID_WHITELIST_FLUSH:
+		flush_safesetid_whitelist_entries();
+		break;
+	case SAFESETID_WHITELIST_ADD:
+		ret =3D parse_safesetid_whitelist_policy(buf, len, &parent,
+								 &child);
+		if (ret)
+			return ret;
+
+		ret =3D add_safesetid_whitelist_entry(parent, child);
+		if (ret)
+			return ret;
+		break;
+	default:
+		WARN_ON_ONCE("Unknown securityfs file %d\n", file_entry->type);
+		break;
+	}
+
+	/* Return len on success so caller won't keep trying to write */
+	return len;
+}
+
+static const struct file_operations safesetid_file_fops =3D {
+	.write =3D safesetid_file_write,
+};
+
+static void safesetid_shutdown_securityfs(void)
+{
+	int i;
+
+	for (i =3D 0; i < ARRAY_SIZE(safesetid_files); ++i) {
+		struct safesetid_file_entry *entry =3D
+			&safesetid_files[i];
+		securityfs_remove(entry->dentry);
+		entry->dentry =3D NULL;
+	}
+
+	securityfs_remove(safesetid_policy_dir);
+	safesetid_policy_dir =3D NULL;
+}
+
+static int __init safesetid_init_securityfs(void)
+{
+	int i;
+	int ret;
+
+	safesetid_policy_dir =3D securityfs_create_dir("safesetid", NULL);
+	if (!safesetid_policy_dir) {
+		ret =3D PTR_ERR(safesetid_policy_dir);
+		goto error;
+	}
+
+	for (i =3D 0; i < ARRAY_SIZE(safesetid_files); ++i) {
+		struct safesetid_file_entry *entry =3D
+			&safesetid_files[i];
+		entry->dentry =3D securityfs_create_file(
+			entry->name, 0200, safesetid_policy_dir,
+			entry, &safesetid_file_fops);
+		if (IS_ERR(entry->dentry)) {
+			ret =3D PTR_ERR(entry->dentry);
+			goto error;
+		}
+	}
+
+	return 0;
+
+error:
+	safesetid_shutdown_securityfs();
+	return ret;
+}
+fs_initcall(safesetid_init_securityfs);
--=20
2.20.1.97.g81188d93c3-goog

