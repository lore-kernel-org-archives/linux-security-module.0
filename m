Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FAF5C636D3
	for <linux-security-module@archiver.kernel.org>; Sat,  4 Feb 2023 05:32:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233319AbjBDFco (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Sat, 4 Feb 2023 00:32:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232601AbjBDFcn (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Sat, 4 Feb 2023 00:32:43 -0500
Received: from blizzard.enjellic.com (wind.enjellic.com [76.10.64.91])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B191A93AEC
        for <linux-security-module@vger.kernel.org>; Fri,  3 Feb 2023 21:32:42 -0800 (PST)
Received: from blizzard.enjellic.com (localhost [127.0.0.1])
        by blizzard.enjellic.com (8.15.2/8.15.2) with ESMTP id 3145A6Iq011686;
        Fri, 3 Feb 2023 23:10:06 -0600
Received: (from greg@localhost)
        by blizzard.enjellic.com (8.15.2/8.15.2/Submit) id 3145A6I5011684;
        Fri, 3 Feb 2023 23:10:06 -0600
X-Authentication-Warning: blizzard.enjellic.com: greg set sender to greg@enjellic.com using -f
From:   "Dr. Greg" <greg@enjellic.com>
To:     linux-security-module@vger.kernel.org
Subject: [PATCH 14/14] Activate the configuration and build of the TSEM LSM.
Date:   Fri,  3 Feb 2023 23:09:54 -0600
Message-Id: <20230204050954.11583-15-greg@enjellic.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230204050954.11583-1-greg@enjellic.com>
References: <20230204050954.11583-1-greg@enjellic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Complete the implementation by integrating the LSM into the
configuration and kernel build infrastructure.

Signed-off-by: Greg Wettstein <greg@enjellic.com>
---
 security/Kconfig       | 11 ++++++-----
 security/Makefile      |  1 +
 security/tsem/Kconfig  | 22 ++++++++++++++++++++++
 security/tsem/Makefile |  2 ++
 4 files changed, 31 insertions(+), 5 deletions(-)
 create mode 100644 security/tsem/Kconfig
 create mode 100644 security/tsem/Makefile

diff --git a/security/Kconfig b/security/Kconfig
index e6db09a779b7..98c538ad6790 100644
--- a/security/Kconfig
+++ b/security/Kconfig
@@ -207,6 +207,7 @@ source "security/yama/Kconfig"
 source "security/safesetid/Kconfig"
 source "security/lockdown/Kconfig"
 source "security/landlock/Kconfig"
+source "security/tsem/Kconfig"
 
 source "security/integrity/Kconfig"
 
@@ -246,11 +247,11 @@ endchoice
 
 config LSM
 	string "Ordered list of enabled LSMs"
-	default "landlock,lockdown,yama,loadpin,safesetid,integrity,smack,selinux,tomoyo,apparmor,bpf" if DEFAULT_SECURITY_SMACK
-	default "landlock,lockdown,yama,loadpin,safesetid,integrity,apparmor,selinux,smack,tomoyo,bpf" if DEFAULT_SECURITY_APPARMOR
-	default "landlock,lockdown,yama,loadpin,safesetid,integrity,tomoyo,bpf" if DEFAULT_SECURITY_TOMOYO
-	default "landlock,lockdown,yama,loadpin,safesetid,integrity,bpf" if DEFAULT_SECURITY_DAC
-	default "landlock,lockdown,yama,loadpin,safesetid,integrity,selinux,smack,tomoyo,apparmor,bpf"
+	default "landlock,lockdown,yama,loadpin,safesetid,integrity,smack,selinux,tomoyo,apparmor,bpf,tsem" if DEFAULT_SECURITY_SMACK
+	default "landlock,lockdown,yama,loadpin,safesetid,integrity,apparmor,selinux,smack,tomoyo,bpf,tsem" if DEFAULT_SECURITY_APPARMOR
+	default "landlock,lockdown,yama,loadpin,safesetid,integrity,tomoyo,bpf,tsem" if DEFAULT_SECURITY_TOMOYO
+	default "landlock,lockdown,yama,loadpin,safesetid,integrity,bpf,tsem" if DEFAULT_SECURITY_DAC
+	default "landlock,lockdown,yama,loadpin,safesetid,integrity,selinux,smack,tomoyo,apparmor,bpf,tsem"
 	help
 	  A comma-separated list of LSMs, in initialization order.
 	  Any LSMs left off this list will be ignored. This can be
diff --git a/security/Makefile b/security/Makefile
index 18121f8f85cd..11d93885c806 100644
--- a/security/Makefile
+++ b/security/Makefile
@@ -24,6 +24,7 @@ obj-$(CONFIG_SECURITY_LOCKDOWN_LSM)	+= lockdown/
 obj-$(CONFIG_CGROUPS)			+= device_cgroup.o
 obj-$(CONFIG_BPF_LSM)			+= bpf/
 obj-$(CONFIG_SECURITY_LANDLOCK)		+= landlock/
+obj-$(CONFIG_SECURITY_TSEM)		+= tsem/
 
 # Object integrity file lists
 obj-$(CONFIG_INTEGRITY)			+= integrity/
diff --git a/security/tsem/Kconfig b/security/tsem/Kconfig
new file mode 100644
index 000000000000..f9199686844a
--- /dev/null
+++ b/security/tsem/Kconfig
@@ -0,0 +1,22 @@
+config SECURITY_TSEM
+	bool "Trusted Security Event Modeling"
+	depends on SECURITY
+	depends on NET && INET
+	select SECURITY_NETWORK
+	select SECURITYFS
+	select CRYPTO
+	select CRYPTO_SHA256
+	select CRYPTO_HASH_INFO
+	select TCG_TPM if HAS_IOMEM && !UML
+	select TCG_TIS if TCG_TPM && X86
+	select TCG_CRB if TCG_TPM && ACPI
+	default n
+	help
+	  This option selects support for Trusted Security Event
+	  Modeling (TSEM).  TSEM implements the ability to model
+	  the security state of either the system at large or in a
+	  restricted namespace on the basis of the LSM security
+	  events and attributes that occur in the scope of the model.
+	  The model may be implemented either in the kernel proper
+	  or exported to an external Trusted Modeling Agent (TMA).
+	  If you are unsure how to answer this question, answer N.
diff --git a/security/tsem/Makefile b/security/tsem/Makefile
new file mode 100644
index 000000000000..d43cf2ae2142
--- /dev/null
+++ b/security/tsem/Makefile
@@ -0,0 +1,2 @@
+obj-$(CONFIG_SECURITY_TSEM) := tsem.o model.o namespace.o map.o event.o fs.o \
+	export.o trust.o
-- 
2.39.1

