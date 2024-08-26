Received: from blizzard.enjellic.com (wind.enjellic.com [76.10.64.91])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D1F8152160;
	Mon, 26 Aug 2024 10:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=76.10.64.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724669406; cv=none; b=Sn5CJbjHGQiviMmRdWPGxFANZX4D4mqljz2GAYGHZXba+E52M5cAGtnx6dPmuICtKue4T7CDOBEOQQ7IyzQgLNv9gSzKzGFhQnNOpZfhWWUQ6WVAj31gHz+iY7O98qHro5KH0ZMu7i7QBrn1Fv0RqNZik6qx7I1iNar67/5CtgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724669406; c=relaxed/simple;
	bh=tsijDg1QpHf/XW2pCyQGKWUItm4MMvjUNdWU+pyh3k8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=E0TjKxM6pdpomHFVFOOSDvZu/cmonOS2KnbB3bcULBnMTNf3FarFFGRPyaerxDuxFTvYwNHanofPXO1nvtVEEgLcXNnkvDPwIkZQT6Jg/QymSDn7ZWEbtFx614mhmGc0MZgt06PvCVubz0BM/lixxUmX6nBVJF9uOovW9tMZoHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=enjellic.com; spf=pass smtp.mailfrom=enjellic.com; arc=none smtp.client-ip=76.10.64.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=enjellic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=enjellic.com
Received: from blizzard.enjellic.com (localhost [127.0.0.1])
	by blizzard.enjellic.com (8.15.2/8.15.2) with ESMTP id 47QAbWmR003457;
	Mon, 26 Aug 2024 05:37:32 -0500
Received: (from greg@localhost)
	by blizzard.enjellic.com (8.15.2/8.15.2/Submit) id 47QAbW6d003456;
	Mon, 26 Aug 2024 05:37:32 -0500
X-Authentication-Warning: blizzard.enjellic.com: greg set sender to greg@enjellic.com using -f
From: Greg Wettstein <greg@enjellic.com>
To: linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: jmorris@namei.org
Subject: [PATCH v4 14/14] Activate the configuration and build of the TSEM LSM.
Date: Mon, 26 Aug 2024 05:37:28 -0500
Message-Id: <20240826103728.3378-15-greg@enjellic.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20240826103728.3378-1-greg@enjellic.com>
References: <20240826103728.3378-1-greg@enjellic.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Complete the implementation by integrating TSEM into the
configuration and kernel build infrastructure.  This includes
registration of TSEM with the LSM infrastructure and the
assignment of an LSM identifier number.
---
 include/uapi/linux/lsm.h |  1 +
 security/Kconfig         | 11 ++++++-----
 security/Makefile        |  1 +
 security/security.c      |  3 ++-
 security/tsem/Kconfig    | 36 ++++++++++++++++++++++++++++++++++++
 security/tsem/Makefile   |  6 ++++++
 6 files changed, 52 insertions(+), 6 deletions(-)
 create mode 100644 security/tsem/Kconfig
 create mode 100644 security/tsem/Makefile

diff --git a/include/uapi/linux/lsm.h b/include/uapi/linux/lsm.h
index 33d8c9f4aa6b..6b63c158c1df 100644
--- a/include/uapi/linux/lsm.h
+++ b/include/uapi/linux/lsm.h
@@ -64,6 +64,7 @@ struct lsm_ctx {
 #define LSM_ID_LANDLOCK		110
 #define LSM_ID_IMA		111
 #define LSM_ID_EVM		112
+#define LSM_ID_TSEM		113
 
 /*
  * LSM_ATTR_XXX definitions identify different LSM attributes
diff --git a/security/Kconfig b/security/Kconfig
index 412e76f1575d..a7802eb29034 100644
--- a/security/Kconfig
+++ b/security/Kconfig
@@ -192,6 +192,7 @@ source "security/yama/Kconfig"
 source "security/safesetid/Kconfig"
 source "security/lockdown/Kconfig"
 source "security/landlock/Kconfig"
+source "security/tsem/Kconfig"
 
 source "security/integrity/Kconfig"
 
@@ -231,11 +232,11 @@ endchoice
 
 config LSM
 	string "Ordered list of enabled LSMs"
-	default "landlock,lockdown,yama,loadpin,safesetid,smack,selinux,tomoyo,apparmor,bpf" if DEFAULT_SECURITY_SMACK
-	default "landlock,lockdown,yama,loadpin,safesetid,apparmor,selinux,smack,tomoyo,bpf" if DEFAULT_SECURITY_APPARMOR
-	default "landlock,lockdown,yama,loadpin,safesetid,tomoyo,bpf" if DEFAULT_SECURITY_TOMOYO
-	default "landlock,lockdown,yama,loadpin,safesetid,bpf" if DEFAULT_SECURITY_DAC
-	default "landlock,lockdown,yama,loadpin,safesetid,selinux,smack,tomoyo,apparmor,bpf"
+	default "tsem,landlock,lockdown,yama,loadpin,safesetid,smack,selinux,tomoyo,apparmor,bpf" if DEFAULT_SECURITY_SMACK
+	default "tsem,landlock,lockdown,yama,loadpin,safesetid,apparmor,selinux,smack,tomoyo,bpf" if DEFAULT_SECURITY_APPARMOR
+	default "tsem,landlock,lockdown,yama,loadpin,safesetid,tomoyo,bpf" if DEFAULT_SECURITY_TOMOYO
+	default "tsem,landlock,lockdown,yama,loadpin,safesetid,bpf" if DEFAULT_SECURITY_DAC
+	default "tsem,landlock,lockdown,yama,loadpin,safesetid,selinux,smack,tomoyo,apparmor,bpf"
 	help
 	  A comma-separated list of LSMs, in initialization order.
 	  Any LSMs left off this list, except for those with order
diff --git a/security/Makefile b/security/Makefile
index 59f238490665..1d4e0a698a2d 100644
--- a/security/Makefile
+++ b/security/Makefile
@@ -25,6 +25,7 @@ obj-$(CONFIG_SECURITY_LOCKDOWN_LSM)	+= lockdown/
 obj-$(CONFIG_CGROUPS)			+= device_cgroup.o
 obj-$(CONFIG_BPF_LSM)			+= bpf/
 obj-$(CONFIG_SECURITY_LANDLOCK)		+= landlock/
+obj-$(CONFIG_SECURITY_TSEM)		+= tsem/
 
 # Object integrity file lists
 obj-$(CONFIG_INTEGRITY)			+= integrity/
diff --git a/security/security.c b/security/security.c
index e5ca08789f74..1dfd85293ad4 100644
--- a/security/security.c
+++ b/security/security.c
@@ -51,7 +51,8 @@
 	(IS_ENABLED(CONFIG_BPF_LSM) ? 1 : 0) + \
 	(IS_ENABLED(CONFIG_SECURITY_LANDLOCK) ? 1 : 0) + \
 	(IS_ENABLED(CONFIG_IMA) ? 1 : 0) + \
-	(IS_ENABLED(CONFIG_EVM) ? 1 : 0))
+	(IS_ENABLED(CONFIG_EVM) ? 1 : 0) + \
+	(IS_ENABLED(CONFIG_SECURITY_TSEM) ? 1 : 0))
 
 /*
  * These are descriptions of the reasons that can be passed to the
diff --git a/security/tsem/Kconfig b/security/tsem/Kconfig
new file mode 100644
index 000000000000..2e9d54eb3acc
--- /dev/null
+++ b/security/tsem/Kconfig
@@ -0,0 +1,36 @@
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
+
+config SECURITY_TSEM_ROOT_MODEL_PCR
+	int "TPM PCR index for root domain"
+	depends on SECURITY_TSEM
+	range 8 14
+	default 11
+	help
+	  This configuration variable determines the TPM Platform
+	  Configuration Register (PCR) that the coefficients of
+	  security events for the root modeling domain are extended
+	  into.  The default value is one register above the default
+	  value that IMA uses for its integrity measurements, in order
+	  to avoid a conflict between the two sub-systems.  If unsure,
+	  leave the value at its default value of 11.
diff --git a/security/tsem/Makefile b/security/tsem/Makefile
new file mode 100644
index 000000000000..5b26edbe02b0
--- /dev/null
+++ b/security/tsem/Makefile
@@ -0,0 +1,6 @@
+obj-$(CONFIG_SECURITY_TSEM) := tsem.o model.o namespace.o map.o event.o fs.o \
+	export.o trust.o model0.o
+
+ifdef CONFIG_MODULES
+obj-y += nsmgr.o
+endif
-- 
2.39.1

