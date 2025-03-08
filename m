Received: from smtp-190f.mail.infomaniak.ch (smtp-190f.mail.infomaniak.ch [185.125.25.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E00C21ADCE
	for <linux-security-module@vger.kernel.org>; Sat,  8 Mar 2025 18:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.25.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741459518; cv=none; b=nV6rYiIUUX4X7Ag7JHwabF24Q5rfUm4o4V1jjmiDp13TFNVYZMXph1y7bCz0k7qG5ihdSpIGyZz5ALpgTsWVP1Ob3fBwTrVHM8y5IAGdZzK/lqjCIkBqJZuJjlS1vhnyD+3rCfofMvoIEN9BZVmPMF0EWX9a091ezjQCaWSNQGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741459518; c=relaxed/simple;
	bh=065DKDG4l8GjBe6nTlgibA+hgQmFugtxUREoPraYyEQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rXzyqFYbuHEtaqFZmLrPEwASBpq/gv7jZWkFX+ppSgJ403QoKOAYomLZZ7INzRO5+JQ1YddOUlreWAPZHuc65C7pD54W6CpYuTRdj+HPw4oCEUzfQf+fPUstuXFNXM5y+mhQNkUGSf9/MTKqcXaryw3x46gsFbk6zR2lp5b8mNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=dNbCiEVA; arc=none smtp.client-ip=185.125.25.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="dNbCiEVA"
Received: from smtp-4-0000.mail.infomaniak.ch (unknown [IPv6:2001:1600:7:10:40ca:feff:fe05:0])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4Z9Bt067zlzQ9D;
	Sat,  8 Mar 2025 19:45:12 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1741459512;
	bh=rbxAVM0frrhyQfoNxBqPXz6ATnPq5nEhIbUQovrqcuo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dNbCiEVANvyiw/MbQa7PWF8ylPOv8niePSHUQKhR7vhSidXWcHXvrZoUPPe6aFl/A
	 lZOimP9LOe7B6UEKhJRX6SV09AYk2s+KuH/CUHvA7ADhz1w3l/+pGanXUvhxCnWMuE
	 vugBlE56oY+7fI0GKRb3iKhIVspqxf++CELlzjlI=
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4Z9Bsz6K8SzHMx;
	Sat,  8 Mar 2025 19:45:11 +0100 (CET)
From: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To: Eric Paris <eparis@redhat.com>,
	Paul Moore <paul@paul-moore.com>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	"Serge E . Hallyn" <serge@hallyn.com>
Cc: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	Ben Scarlato <akhna@google.com>,
	Casey Schaufler <casey@schaufler-ca.com>,
	Charles Zaffery <czaffery@roblox.com>,
	Daniel Burgener <dburgener@linux.microsoft.com>,
	Francis Laniel <flaniel@linux.microsoft.com>,
	James Morris <jmorris@namei.org>,
	Jann Horn <jannh@google.com>,
	Jeff Xu <jeffxu@google.com>,
	Jorge Lucangeli Obes <jorgelo@google.com>,
	Kees Cook <kees@kernel.org>,
	Konstantin Meskhidze <konstantin.meskhidze@huawei.com>,
	Matt Bobrowski <mattbobrowski@google.com>,
	Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>,
	Phil Sutter <phil@nwl.cc>,
	Praveen K Paladugu <prapal@linux.microsoft.com>,
	Robert Salvet <robert.salvet@roblox.com>,
	Shervin Oloumi <enlightened@google.com>,
	Song Liu <song@kernel.org>,
	Tahera Fahimi <fahimitahera@gmail.com>,
	Tingmao Wang <m@maowtm.org>,
	Tyler Hicks <code@tyhicks.com>,
	audit@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org
Subject: [PATCH v6 26/26] landlock: Add audit documentation
Date: Sat,  8 Mar 2025 19:44:22 +0100
Message-ID: <20250308184422.2159360-27-mic@digikod.net>
In-Reply-To: <20250308184422.2159360-1-mic@digikod.net>
References: <20250308184422.2159360-1-mic@digikod.net>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha

Because audit is dedicated to the system administrator, create a new
entry in Documentation/admin-guide/LSM .

Extend other Landlock documentation's pages with this new one.

Extend the guiding principles with logs.

Cc: Günther Noack <gnoack@google.com>
Cc: Paul Moore <paul@paul-moore.com>
Signed-off-by: Mickaël Salaün <mic@digikod.net>
Link: https://lore.kernel.org/r/20250308184422.2159360-27-mic@digikod.net
---

Changes since v5:
- Extend the guiding principles with logs.

Changes since v4:
- New patch.
---
 Documentation/admin-guide/LSM/index.rst    |   1 +
 Documentation/admin-guide/LSM/landlock.rst | 158 +++++++++++++++++++++
 Documentation/security/landlock.rst        |  13 +-
 Documentation/userspace-api/landlock.rst   |   9 +-
 MAINTAINERS                                |   1 +
 5 files changed, 180 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/admin-guide/LSM/landlock.rst

diff --git a/Documentation/admin-guide/LSM/index.rst b/Documentation/admin-guide/LSM/index.rst
index ce63be6d64ad..b44ef68f6e4d 100644
--- a/Documentation/admin-guide/LSM/index.rst
+++ b/Documentation/admin-guide/LSM/index.rst
@@ -48,3 +48,4 @@ subdirectories.
    Yama
    SafeSetID
    ipe
+   landlock
diff --git a/Documentation/admin-guide/LSM/landlock.rst b/Documentation/admin-guide/LSM/landlock.rst
new file mode 100644
index 000000000000..9e61607def08
--- /dev/null
+++ b/Documentation/admin-guide/LSM/landlock.rst
@@ -0,0 +1,158 @@
+.. SPDX-License-Identifier: GPL-2.0
+.. Copyright © 2025 Microsoft Corporation
+
+================================
+Landlock: system-wide management
+================================
+
+:Author: Mickaël Salaün
+:Date: March 2025
+
+Landlock can leverage the audit framework to log events.
+
+User space documentation can be found here:
+Documentation/userspace-api/landlock.rst.
+
+Audit
+=====
+
+Denied access requests are logged by default for a sandboxed program if `audit`
+is enabled.  This default behavior can be changed with the
+sys_landlock_restrict_self() flags (cf.
+Documentation/userspace-api/landlock.rst).  Landlock logs can also be masked
+thanks to audit rules.  Landlock can generate 2 audit record types.
+
+Record types
+------------
+
+AUDIT_LANDLOCK_ACCESS
+    This record type identifies a denied access request to a kernel resource.
+    The ``domain`` field indicates the ID of the domain that blocked the
+    request.  The ``blockers`` field indicates the cause(s) of this denial
+    (separated by a comma), and the following fields identify the kernel object
+    (similar to SELinux).  There may be more than one of this record type per
+    audit event.
+
+    Example with a file link request generating two records in the same event::
+
+        domain=195ba459b blockers=fs.refer path="/usr/bin" dev="vda2" ino=351
+        domain=195ba459b blockers=fs.make_reg,fs.refer path="/usr/local" dev="vda2" ino=365
+
+AUDIT_LANDLOCK_DOMAIN
+    This record type describes the status of a Landlock domain.  The ``status``
+    field can be either ``allocated`` or ``deallocated``.
+
+    The ``allocated`` status is part of the same audit event and follows
+    the first logged ``AUDIT_LANDLOCK_ACCESS`` record of a domain.  It identifies
+    Landlock domain information at the time of the sys_landlock_restrict_self()
+    call with the following fields:
+
+    - the ``domain`` ID
+    - the enforcement ``mode``
+    - the domain creator's ``pid``
+    - the domain creator's ``uid``
+    - the domain creator's executable path (``exe``)
+    - the domain creator's command line (``comm``)
+
+    Example::
+
+        domain=195ba459b status=allocated mode=enforcing pid=300 uid=0 exe="/root/sandboxer" comm="sandboxer"
+
+    The ``deallocated`` status is an event on its own and it identifies a
+    Landlock domain release.  After such event, it is guarantee that the
+    related domain ID will never be reused during the lifetime of the system.
+    The ``domain`` field indicates the ID of the domain which is released, and
+    the ``denials`` field indicates the total number of denied access request,
+    which might not have been logged according to the audit rules and
+    sys_landlock_restrict_self()'s flags.
+
+    Example::
+
+        domain=195ba459b status=deallocated denials=3
+
+
+Event samples
+--------------
+
+Here are two examples of log events (see serial numbers).
+
+In this example a sandboxed program (``kill``) tries to send a signal to the
+init process, which is denied because of the signal scoping restriction
+(``LL_SCOPED=s``)::
+
+  $ LL_FS_RO=/ LL_FS_RW=/ LL_SCOPED=s LL_FORCE_LOG=1 ./sandboxer kill 1
+
+This command generates two events, each identified with a unique serial
+number following a timestamp (``msg=audit(1729738800.268:30)``).  The first
+event (serial ``30``) contains 4 records.  The first record
+(``type=LANDLOCK_ACCESS``) shows an access denied by the domain `1a6fdc66f`.
+The cause of this denial is signal scopping restriction
+(``blockers=scope.signal``).  The process that would have receive this signal
+is the init process (``opid=1 ocomm="systemd"``).
+
+The second record (``type=LANDLOCK_DOMAIN``) describes (``status=allocated``)
+domain `1a6fdc66f`.  This domain was created by process ``286`` executing the
+``/root/sandboxer`` program launched by the root user.
+
+The third record (``type=SYSCALL``) describes the syscall, its provided
+arguments, its result (``success=no exit=-1``), and the process that called it.
+
+The fourth record (``type=PROCTITLE``) shows the command's name as an
+hexadecimal value.  This can be translated with ``python -c
+'print(bytes.fromhex("6B696C6C0031"))'``.
+
+Finally, the last record (``type=LANDLOCK_DOMAIN``) is also the only one from
+the second event (serial ``31``).  It is not tied to a direct user space action
+but an asynchronous one to free resources tied to a Landlock domain
+(``status=deallocated``).  This can be useful to know that the following logs
+will not concern the domain ``1a6fdc66f`` anymore.  This record also summarize
+the number of requests this domain denied (``denials=1``), whether they were
+logged or not.
+
+.. code-block::
+
+  type=LANDLOCK_ACCESS msg=audit(1729738800.268:30): domain=1a6fdc66f blockers=scope.signal opid=1 ocomm="systemd"
+  type=LANDLOCK_DOMAIN msg=audit(1729738800.268:30): domain=1a6fdc66f status=allocated mode=enforcing pid=286 uid=0 exe="/root/sandboxer" comm="sandboxer"
+  type=SYSCALL msg=audit(1729738800.268:30): arch=c000003e syscall=62 success=no exit=-1 [..] ppid=272 pid=286 auid=0 uid=0 gid=0 [...] comm="kill" [...]
+  type=PROCTITLE msg=audit(1729738800.268:30): proctitle=6B696C6C0031
+  type=LANDLOCK_DOMAIN msg=audit(1729738800.324:31): domain=1a6fdc66f status=deallocated denials=1
+
+Here is another example showcasing filesystem access control::
+
+  $ LL_FS_RO=/ LL_FS_RW=/tmp LL_FORCE_LOG=1 ./sandboxer sh -c "echo > /etc/passwd"
+
+The related audit logs contains 8 records from 3 different events (serials 33,
+34 and 35) created by the same domain `1a6fdc679`::
+
+  type=LANDLOCK_ACCESS msg=audit(1729738800.221:33): domain=1a6fdc679 blockers=fs.write_file path="/dev/tty" dev="devtmpfs" ino=9
+  type=LANDLOCK_DOMAIN msg=audit(1729738800.221:33): domain=1a6fdc679 status=allocated mode=enforcing pid=289 uid=0 exe="/root/sandboxer" comm="sandboxer"
+  type=SYSCALL msg=audit(1729738800.221:33): arch=c000003e syscall=257 success=no exit=-13 [...] ppid=272 pid=289 auid=0 uid=0 gid=0 [...] comm="sh" [...]
+  type=PROCTITLE msg=audit(1729738800.221:33): proctitle=7368002D63006563686F203E202F6574632F706173737764
+  type=LANDLOCK_ACCESS msg=audit(1729738800.221:34): domain=1a6fdc679 blockers=fs.write_file path="/etc/passwd" dev="vda2" ino=143821
+  type=SYSCALL msg=audit(1729738800.221:34): arch=c000003e syscall=257 success=no exit=-13 [...] ppid=272 pid=289 auid=0 uid=0 gid=0 [...] comm="sh" [...]
+  type=PROCTITLE msg=audit(1729738800.221:34): proctitle=7368002D63006563686F203E202F6574632F706173737764
+  type=LANDLOCK_DOMAIN msg=audit(1729738800.261:35): domain=1a6fdc679 status=deallocated denials=2
+
+
+Event filtering
+---------------
+
+If you get spammed with audit logs related to Landlock, this is either an
+attack attempt or a bug in the security policy.  We can put in place some
+filters to limit noise with two complementary ways:
+
+- with sys_landlock_restrict_self()'s flags if we can fix the sandboxed
+  programs,
+- or with audit rules (see :manpage:`auditctl(8)`).
+
+Additional documentation
+========================
+
+* `Linux Audit Documentation`_
+* Documentation/userspace-api/landlock.rst
+* Documentation/security/landlock.rst
+* https://landlock.io
+
+.. Links
+.. _Linux Audit Documentation:
+   https://github.com/linux-audit/audit-documentation/wiki
diff --git a/Documentation/security/landlock.rst b/Documentation/security/landlock.rst
index 59ecdb1c0d4d..e0fc54aff09e 100644
--- a/Documentation/security/landlock.rst
+++ b/Documentation/security/landlock.rst
@@ -7,7 +7,7 @@ Landlock LSM: kernel documentation
 ==================================
 
 :Author: Mickaël Salaün
-:Date: December 2022
+:Date: March 2025
 
 Landlock's goal is to create scoped access-control (i.e. sandboxing).  To
 harden a whole system, this feature should be available to any process,
@@ -45,6 +45,10 @@ Guiding principles for safe access controls
   sandboxed process shall retain their scoped accesses (at the time of resource
   acquisition) whatever process uses them.
   Cf. `File descriptor access rights`_.
+* Access denials shall be logged according to system and Landlock domain
+  configurations.  Log entries must contain information about the cause of the
+  denial and the owner of the related security policy.  Such log generation
+  should have a negligible performance and memory impact on allowed requests.
 
 Design choices
 ==============
@@ -124,6 +128,13 @@ makes the reasoning much easier and helps avoid pitfalls.
 .. kernel-doc:: security/landlock/ruleset.h
     :identifiers:
 
+Additional documentation
+========================
+
+* Documentation/userspace-api/landlock.rst
+* Documentation/admin-guide/LSM/landlock.rst
+* https://landlock.io
+
 .. Links
 .. _tools/testing/selftests/landlock/:
    https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/tree/tools/testing/selftests/landlock/
diff --git a/Documentation/userspace-api/landlock.rst b/Documentation/userspace-api/landlock.rst
index ad587f53fe41..2a9843116202 100644
--- a/Documentation/userspace-api/landlock.rst
+++ b/Documentation/userspace-api/landlock.rst
@@ -8,7 +8,7 @@ Landlock: unprivileged access control
 =====================================
 
 :Author: Mickaël Salaün
-:Date: January 2025
+:Date: March 2025
 
 The goal of Landlock is to enable restriction of ambient rights (e.g. global
 filesystem or network access) for a set of processes.  Because Landlock
@@ -683,9 +683,16 @@ fine-grained restrictions).  Moreover, their complexity can lead to security
 issues, especially when untrusted processes can manipulate them (cf.
 `Controlling access to user namespaces <https://lwn.net/Articles/673597/>`_).
 
+How to disable Landlock audit records?
+--------------------------------------
+
+You might want to put in place filters as explained here:
+Documentation/admin-guide/LSM/landlock.rst
+
 Additional documentation
 ========================
 
+* Documentation/admin-guide/LSM/landlock.rst
 * Documentation/security/landlock.rst
 * https://landlock.io
 
diff --git a/MAINTAINERS b/MAINTAINERS
index 8e0736dc2ee0..a3aa52e47401 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -13075,6 +13075,7 @@ L:	linux-security-module@vger.kernel.org
 S:	Supported
 W:	https://landlock.io
 T:	git https://git.kernel.org/pub/scm/linux/kernel/git/mic/linux.git
+F:	Documentation/admin-guide/LSM/landlock.rst
 F:	Documentation/security/landlock.rst
 F:	Documentation/userspace-api/landlock.rst
 F:	fs/ioctl.c
-- 
2.48.1

