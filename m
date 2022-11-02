Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C843EC4332F
	for <linux-security-module@archiver.kernel.org>; Wed,  2 Nov 2022 17:16:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230311AbiKBRQu (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 2 Nov 2022 13:16:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231309AbiKBRQi (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 2 Nov 2022 13:16:38 -0400
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62B98248D2
        for <linux-security-module@vger.kernel.org>; Wed,  2 Nov 2022 10:16:34 -0700 (PDT)
Received: from fsav118.sakura.ne.jp (fsav118.sakura.ne.jp [27.133.134.245])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 2A2HG3eC023046;
        Thu, 3 Nov 2022 02:16:03 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav118.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav118.sakura.ne.jp);
 Thu, 03 Nov 2022 02:16:03 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav118.sakura.ne.jp)
Received: from localhost.localdomain (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 2A2HAnkL021849
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 3 Nov 2022 02:10:57 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
To:     linux-security-module@vger.kernel.org,
        Casey Schaufler <casey@schaufler-ca.com>,
        Paul Moore <paul@paul-moore.com>,
        John Johansen <john.johansen@canonical.com>,
        Kees Cook <kees@kernel.org>
Cc:     Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Subject: [PATCH 10/10] CaitSith: Add Kconfig and Makefile files.
Date:   Thu,  3 Nov 2022 02:10:25 +0900
Message-Id: <20221102171025.126961-10-penguin-kernel@I-love.SAKURA.ne.jp>
X-Mailer: git-send-email 2.18.4
In-Reply-To: <20221102171025.126961-1-penguin-kernel@I-love.SAKURA.ne.jp>
References: <20221102171025.126961-1-penguin-kernel@I-love.SAKURA.ne.jp>
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

The point of CaitSith is that you can choose CONFIG_SECURITY_CAITSITH=m .
But please don't choose CONFIG_SECURITY_CAITSITH_OMIT_USERSPACE_LOADER=y
unless you understood how to prepare built-in policy configuration.
If you choose CONFIG_SECURITY_CAITSITH_OMIT_USERSPACE_LOADER=y without
built-in policy configuration, the kernel will panic().

For more information, please follow instructions at "2.1.6. Install the
userspace tools" and afterwards in https://caitsith.osdn.jp/index.html .

Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
---
 security/Kconfig           |   1 +
 security/Makefile          |   1 +
 security/caitsith/Kconfig  | 112 +++++++++++++++++++++++++++++++++++++
 security/caitsith/Makefile |  11 ++++
 4 files changed, 125 insertions(+)
 create mode 100644 security/caitsith/Kconfig
 create mode 100644 security/caitsith/Makefile

diff --git a/security/Kconfig b/security/Kconfig
index e6db09a779b7..a2f3ba29d63b 100644
--- a/security/Kconfig
+++ b/security/Kconfig
@@ -209,6 +209,7 @@ source "security/lockdown/Kconfig"
 source "security/landlock/Kconfig"
 
 source "security/integrity/Kconfig"
+source "security/caitsith/Kconfig"
 
 choice
 	prompt "First legacy 'major LSM' to be initialized"
diff --git a/security/Makefile b/security/Makefile
index 18121f8f85cd..ef03c490e099 100644
--- a/security/Makefile
+++ b/security/Makefile
@@ -24,6 +24,7 @@ obj-$(CONFIG_SECURITY_LOCKDOWN_LSM)	+= lockdown/
 obj-$(CONFIG_CGROUPS)			+= device_cgroup.o
 obj-$(CONFIG_BPF_LSM)			+= bpf/
 obj-$(CONFIG_SECURITY_LANDLOCK)		+= landlock/
+obj-$(CONFIG_SECURITY_CAITSITH)		+= caitsith/
 
 # Object integrity file lists
 obj-$(CONFIG_INTEGRITY)			+= integrity/
diff --git a/security/caitsith/Kconfig b/security/caitsith/Kconfig
new file mode 100644
index 000000000000..0bae4f2d8b7f
--- /dev/null
+++ b/security/caitsith/Kconfig
@@ -0,0 +1,112 @@
+config SECURITY_CAITSITH
+	tristate "CaitSith support"
+	default n
+	help
+	  Say Y or M here to support CaitSith.
+	  https://caitsith.osdn.jp/
+
+config SECURITY_CAITSITH_OMIT_USERSPACE_LOADER
+	bool "Activate without calling userspace policy loader."
+	default n
+	depends on SECURITY_CAITSITH
+	help
+	  Say Y here if you want to activate access control as soon as built-in
+	  policy was loaded. This option will be useful for systems where
+	  operations which can lead to the hijacking of the boot sequence are
+	  needed before loading the policy. For example, you can activate
+	  immediately after loading the fixed part of policy which will allow
+	  only operations needed for mounting a partition which contains the
+	  variant part of policy and verifying (e.g. running GPG check) and
+	  loading the variant part of policy. Since you can start using
+	  enforcing mode from the beginning, you can reduce the possibility of
+	  hijacking the boot sequence.
+
+	  If you say Y to both "Compile as loadable kernel module" option and
+	  "Activate without calling userspace policy loader." option, be sure
+	  to excplicitly load the kernel module from the userspace, for
+	  the kernel will not call /sbin/caitsith-init when /sbin/init starts.
+
+config SECURITY_CAITSITH_POLICY_LOADER
+	string "Location of userspace policy loader"
+	default "/sbin/caitsith-init"
+	depends on SECURITY_CAITSITH
+	depends on !SECURITY_CAITSITH_OMIT_USERSPACE_LOADER
+	help
+	  This is the default pathname of policy loader which is called before
+	  activation. You can override this setting via CS_loader= kernel
+	  command line option.
+
+config SECURITY_CAITSITH_ACTIVATION_TRIGGER
+	string "Trigger for calling userspace policy loader"
+	default "/sbin/init"
+	depends on SECURITY_CAITSITH
+	depends on !SECURITY_CAITSITH_OMIT_USERSPACE_LOADER
+	help
+	  This is the default pathname of activation trigger.
+	  You can override this setting via CS_trigger= kernel command line
+	  option. For example, if you pass init=/bin/systemd option, you may
+	  want to also pass CS_trigger=/bin/systemd option.
+
+	  Say Y here if you want to enable only specific functionality in order
+	  to reduce object file size.
+
+config SECURITY_CAITSITH_READDIR
+	bool "Enable readdir operation restriction."
+	default y
+	depends on SECURITY_CAITSITH
+	help
+	  Say Y here if you want to enable restriction of opening directories
+	  for reading. Reading directory entries is a commonly requested
+	  operation and damage caused by not restricting it might be acceptable
+	  for you.
+
+config SECURITY_CAITSITH_GETATTR
+	bool "Enable getattr operation restriction."
+	default y
+	depends on SECURITY_CAITSITH
+	help
+	  Say Y here if you want to enable restriction of getting information
+	  of files. Getting file's information is a commonly requested
+	  operation and damage caused by not restricting it might be acceptable
+	  for you.
+
+config SECURITY_CAITSITH_NETWORK
+	bool "Enable socket operation restriction."
+	default y
+	depends on SECURITY_NETWORK
+	depends on SECURITY_CAITSITH
+	help
+	  Say Y here if you want to enable restriction of INET/INET6/UNIX
+	  socket's operations.
+
+config SECURITY_CAITSITH_CAPABILITY
+	bool "Enable non-POSIX capability operation restriction."
+	default y
+	depends on SECURITY_CAITSITH
+	help
+	  Say Y here if you want to enable restriction of non-POSIX
+	  capabilities.
+
+config SECURITY_CAITSITH_ENVIRON
+	bool "Enable environment variable names/values restriction."
+	default y
+	depends on SECURITY_CAITSITH
+	help
+	  Say Y here if you want to enable restriction of environment variable
+	  names/values passed upon program execution request.
+
+config SECURITY_CAITSITH_MANUAL_DOMAIN_TRANSITION
+	bool "Enable domain transition without program execution request."
+	default y
+	depends on SECURITY_CAITSITH
+	help
+	  Say Y here if you want to enable domain transition without involving
+	  program execution request.
+
+config SECURITY_CAITSITH_AUTO_DOMAIN_TRANSITION
+	bool "Enable automatic domain transition."
+	default y
+	depends on SECURITY_CAITSITH
+	help
+	  Say Y here if you want to enable automatic domain transition when
+	  conditions are met.
diff --git a/security/caitsith/Makefile b/security/caitsith/Makefile
new file mode 100644
index 000000000000..4fb86ed45df0
--- /dev/null
+++ b/security/caitsith/Makefile
@@ -0,0 +1,11 @@
+caitsith-objs := permission.o gc.o policy_io.o realpath.o lsm.o
+obj-$(CONFIG_SECURITY_CAITSITH) += caitsith.o
+
+targets += builtin-policy.h
+quiet_cmd_policy = Generating built-in policy for CaitSith 0.2.
+cmd_policy = ( echo "static char cs_builtin_policy[] __initdata ="; sed -e 's/\\/\\134/g' -e 's/"/\\"/g' -e 's/\(.*\)/"\1\\n"/'; echo "\"\";" ) < $< > $@
+
+$(obj)/builtin-policy.h: $(wildcard $(obj)/policy.conf $(srctree)/$(src)/policy.conf) /dev/null FORCE
+	$(call if_changed,policy)
+
+$(obj)/policy_io.o: $(obj)/builtin-policy.h
-- 
2.18.4

