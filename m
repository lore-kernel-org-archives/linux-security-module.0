Received: from mail.nightmared.fr (mail.nightmared.fr [51.158.148.24])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2061414EC60;
	Wed, 21 May 2025 14:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.158.148.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747836117; cv=none; b=M7a7eKDayKucyurbbv+NuPK+Nt+33UVog/m9EVMDffiWBJcqlqlTcNeB8qkHguPag6n/+BC6FTTUXh43LawhrQjEP1v219b/eV3uCr/YzTsN1sn9zNWAanuP3niFmPae+H1rLJJJ4dghMSrA+7PLMnI4N0VHdRr6cCEaQUUZ3qc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747836117; c=relaxed/simple;
	bh=XtYrGgiDZ+0a42wraAQXQkN8sOogaew2kdts3+UGHV4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R86tpOItYxnoQLwEeSsk8PJSIPk7a5nsTHcIkL3q4uZS97P7jWZNeZ3fjaSkZDQKfKTJJENXXt05B3on+tyZFXUH0BPnPvhyUSNYswtAQnJvIykQ74sgfES1ICQ1iC1DyN5AoM3XGRtQe53E93Nync4effjoJ8/yL3ktSDQLSf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nightmared.fr; spf=pass smtp.mailfrom=nightmared.fr; dkim=pass (2048-bit key) header.d=nightmared.fr header.i=@nightmared.fr header.b=AnCVvZp9; arc=none smtp.client-ip=51.158.148.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nightmared.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nightmared.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nightmared.fr header.i=@nightmared.fr header.b="AnCVvZp9"
Received: from localhost.localdomain (atoulon-651-1-170-218.w83-113.abo.wanadoo.fr [83.113.65.218])
	by mail.nightmared.fr (Postfix) with ESMTPSA id 5397B1087A4F;
	Wed, 21 May 2025 14:01:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nightmared.fr;
	s=docker; t=1747836109;
	bh=XtYrGgiDZ+0a42wraAQXQkN8sOogaew2kdts3+UGHV4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=AnCVvZp9VYo2wdSBjWdsbNMg5okNXcZ88fn2uixjSxbqfO0MsXdncNlzxifVlXOB6
	 iEd9SRRpQgCSedu9vL5bmV1qn7gUHKQCACporqkbpvGnxgjTatuk/XKsGptUUPAVOx
	 GDtHnHLQlS9+LcIHLSjZ8WEXAwzZUxmjk/3IhQSGb83tKqq95SSCg35KTwg7+i9Drv
	 eeVtIV8+rqcXq/WEicQi/6FNVs75CSV/9PUViTeLAkxbOAUJ7O/iIvw8HfZxHdgSW2
	 T6p5/SPM4vrr35Ck+rXux1ApyRJqXWkD0uYC6CSCgsz9YGPyf6h5HxpITPmi85dd2y
	 WjkKHyChHnigQ==
From: Simon THOBY <git@nightmared.fr>
To: linux-security-module@vger.kernel.org
Cc: Simon THOBY <git@nightmared.fr>,
	linux-integrity@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: [RFC PATCH 9/9] Loadpol LSM: add a minimal documentation
Date: Wed, 21 May 2025 16:01:13 +0200
Message-ID: <20250521140121.591482-10-git@nightmared.fr>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250521140121.591482-1-git@nightmared.fr>
References: <20250521140121.591482-1-git@nightmared.fr>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce a minimal documentation for Loadpol, presenting the policy
format and the two user interfaces: the securityfs policy file and the
sysctl.

Signed-off-by: Simon THOBY <git@nightmared.fr>
---
 Documentation/admin-guide/LSM/Loadpol.rst | 81 +++++++++++++++++++++++
 Documentation/admin-guide/LSM/index.rst   |  1 +
 2 files changed, 82 insertions(+)
 create mode 100644 Documentation/admin-guide/LSM/Loadpol.rst

diff --git a/Documentation/admin-guide/LSM/Loadpol.rst b/Documentation/admin-guide/LSM/Loadpol.rst
new file mode 100644
index 000000000000..0aa24a8d393c
--- /dev/null
+++ b/Documentation/admin-guide/LSM/Loadpol.rst
@@ -0,0 +1,81 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+=======
+Loadpol
+=======
+
+Loadpol is a Linux Security Module that enforces a user-provided policy
+when decided whether a dynamic module can be loaded or not.
+
+The policy can be read and rewritten at ``/sys/kernel/security/loadpol/policy``.
+
+A default policy is created that contains the current list of blacklisted modules,
+and a catch-all entry that allow loading any module.
+
+Policy format
+=============
+
+The policy is defined as a set of line-separated entries.
+Each entry define the conditions for a match (the origin of the load request and
+the name of the kernel module), and the action to take when the load request
+matches the entry.
+
+
+Entry syntax: ``[origin=(userspace|kernel|kernel,userspace)] [module=<module_name>] action=(allow|deny)``
+
+There are two matching conditions:
+
+``origin``:
+    Load Requests can come from two origins:
+
+    * ``userspace`` (ie. a program in userspace called modprobe/insmod)
+    * ``kernel`` (the kernel requested the module directly by calling
+      ``request_module(...)``, e.g. loading a filesystem when performing a
+      ``-o loop`` mount).
+
+    When unspecified, the condition defaults to ``kernel,userspace`` (which means
+    that both origins match).
+
+``module``:
+    Name of the kernel module being matched. The name can contain wilcards.
+    Beware, module aliases do not work!
+
+There are two possible actions:
+
+* ``allow``: permit the load of the kernel module.
+* ``deny``: reject the load of the kernel module and emit an audit log.
+
+The policy is not greedy: as soon as a match is found, the evaluation terminates
+with the result of that match. So be very careful with the order of your entries.
+
+The main use cases of the policy will probably be to define an allowlist
+(here, we allow ``module_a`` and any module starting with ``module_b`` loaded
+by the user)::
+
+	module==module_a action=allow
+	origin==user module==module_b* action=deny
+	action=deny
+
+But other mechanisms are possible, like a denylist
+(here we block ``module_a``, ``module_b`` if it is loaded by the kernel and
+any module starting with ``module_c`` loaded by the user)::
+
+	module==module_a action=deny
+	origin==kernel module==module_b action=deny
+	origin==user module==module_c* action=deny
+	action=allow
+
+Policy lock
+===========
+
+In order to protect the policy from tampering, a sysctl is provided to
+lock-in-place the currently-loaded policy.
+
+The ``security.loadpol.locked`` can take 2 values:
+
+0 - default:
+    the policy can be reloaded at runtime by any administrator.
+
+1 - locked:
+    the policy cannot be updated or modified, and loadpol cannot be disabled
+    without rebooting.
diff --git a/Documentation/admin-guide/LSM/index.rst b/Documentation/admin-guide/LSM/index.rst
index b44ef68f6e4d..01d36670d8ad 100644
--- a/Documentation/admin-guide/LSM/index.rst
+++ b/Documentation/admin-guide/LSM/index.rst
@@ -42,6 +42,7 @@ subdirectories.
 
    apparmor
    LoadPin
+   Loadpol
    SELinux
    Smack
    tomoyo
-- 
2.49.0

