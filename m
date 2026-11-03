Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=113.46.200.226
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793692292;
	b=hClMRlcZqUjYJdj5c4ug6dV0kX1rxwXsi74wYLrqtAqHC2k5cZLfouzeYWc2bVjYKAjA
	 KtJrSmFM9fry66jjeTOWolkH7gRKHL/Hj3YzeWcBJOMVW+WYxZMxDpzJjbjYOYs9q0brl
	 5ALYsVdEGDOEwgCXfEZoueQsyuUy9y3iY9qeF+75sAE8lilk37chVRXIeesD7NExHSVd/
	 AI2Pg9JzBoWMunttq6HlZeG8eJatftw4HvEeuqUw6gwn912uZACM21S+cpVVMHJn2y/wt
	 tLZocUW4nSAMhtq70EWqz1WnCtyVxYQlM8e0E9aHEW8gNsZQlMp9mC0fASNzNTwO0Zw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793692292;
	h=DMARC-Filter:dkim-signature:Received:Received:Received:From:To:CC:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:X-Originating-IP:X-ClientProxiedBy;
	bh=aPmmJIERDU4D073/iHVqD1v1MGVY4FMLbagpNep/JLQ=;
	b=VjHB0hrMkdxLcRkYS+jpc8dsVsioCO30/9dcskcJeT81kP3T+qbi5u6/Yka5+B4CUYHv
	 QE1FPMG/6Avn/wWPgAKkkY8n5R9RgiXBl9SHXORo5mnER4n5gYtGYp3QbOkN89UPgfhf9
	 ++ypECumETZA6UkB+CuRMNXuz/EtpIMOGTiUlYJTwst8peRsZDrL3fI0NoiujPN7Jmq9r
	 duzYnJ9sg7ZmFXavFkZW2oyJOx/MJTopn+A18iky91zB04nx+htjdOSvZqHckAseafjwb
	 +QeN0E20Eozg15hVKwQ/WtJVuWXTfxBbFKtoiNIGR+0ypv+gYn/TnJqTniZ3yt3r7FQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=huawei.com;
	spf=pass smtp.mailfrom=huawei.com;
	dkim=pass header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=oAA4NcFf;
	arc=none smtp.remote-ip=113.46.200.226
Received: from canpmsgout11.his.huawei.com (canpmsgout11.his.huawei.com [113.46.200.226])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 207E4606A330;
	Tue,  3 Nov 2026 07:51:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 207E4606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=oAA4NcFf
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=aPmmJIERDU4D073/iHVqD1v1MGVY4FMLbagpNep/JLQ=;
	b=oAA4NcFfR54jZqUaK6lxIkeb+iDf4mW76ZTo/6oIPyPzcCePMxt03T/mqRXSMiXAz/dBpAoW9
	lSj9j48KRkyMRATWE23z87h0RAIrUZO2XO0H9j5fhqee6vmNHpa3l5dR+GVc4Y0SODuTkhDXT1Y
	3IavGRbmpFqmv9xIf+epYks=
Received: from mail.maildlp.com (unknown [172.19.163.163])
	by canpmsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4jJgkH3D0lzKmVZ;
	Tue,  3 Nov 2026 15:51:19 +0800 (CST)
Received: from whupemk100010.china.huawei.com (unknown [7.152.184.41])
	by mail.maildlp.com (Postfix) with ESMTPS id 67AC24057A;
	Tue,  3 Nov 2026 15:51:24 +0800 (CST)
Received: from octopus.huawei.com (10.67.174.191) by
 whupemk100010.china.huawei.com (7.152.184.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Tue, 3 Nov 2026 15:51:23 +0800
From: Cai Xinchen <caixinchen1@huawei.com>
To: <nicolas.bouchinet@oss.cyber.gouv.fr>, <xiujianfeng@huawei.com>,
	<paul@paul-moore.com>, <jmorris@namei.org>, <serge@hallyn.com>,
	<shuah@kernel.org>, <caixinchen1@huawei.com>
CC: <linux-security-module@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>, <bpf@vger.kernel.org>,
	<lujialin4@huawei.com>
Subject: [PATCH -next 7/9] lockdown: move lockdown_reasons next to its only user
Date: Tue, 3 Nov 2026 16:24:19 +0800
Message-ID: <20261103082421.3033195-8-caixinchen1@huawei.com>
X-Mailer: git-send-email 2.18.0.huawei.25
In-Reply-To: <20261103082421.3033195-1-caixinchen1@huawei.com>
References: <20261103082421.3033195-1-caixinchen1@huawei.com>
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 whupemk100010.china.huawei.com (7.152.184.41)

lockdown_reasons[] is only used by the lockdown LSM after the audit
data was removed from lsm_audit. Move it into
security/lockdown/lockdown.c, make it static, drop the now stale extern
declaration, and point the enum comment at the new location.

No functional change.

Signed-off-by: Cai Xinchen <caixinchen1@huawei.com>
---
 include/linux/security.h     |  2 --
 security/lockdown/lockdown.c | 39 +++++++++++++++++++++++++++++++++++
 security/security.c          | 40 ------------------------------------
 3 files changed, 39 insertions(+), 42 deletions(-)

diff --git a/include/linux/security.h b/include/linux/security.h
index 40831fab5470..9d3a1eaa90ff 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -170,8 +170,6 @@ struct lsm_prop {
 	struct lsm_prop_bpf bpf;
 };
 
-extern const char *const lockdown_reasons[LOCKDOWN_CONFIDENTIALITY_MAX+1];
-
 /* These functions are in security/commoncap.c */
 extern int cap_capable(const struct cred *cred, struct user_namespace *ns,
 		       int cap, unsigned int opts);
diff --git a/security/lockdown/lockdown.c b/security/lockdown/lockdown.c
index 08a30cd471e0..8c6344399967 100644
--- a/security/lockdown/lockdown.c
+++ b/security/lockdown/lockdown.c
@@ -14,6 +14,45 @@
 #include <linux/lsm_hooks.h>
 #include <uapi/linux/lsm.h>
 
+/*
+ * These are descriptions of the reasons that can be passed to the
+ * security_locked_down() LSM hook, used for the denial message and the
+ * securityfs status file.
+ */
+static const char *const lockdown_reasons[LOCKDOWN_CONFIDENTIALITY_MAX + 1] = {
+	[LOCKDOWN_NONE] = "none",
+	[LOCKDOWN_MODULE_SIGNATURE] = "unsigned module loading",
+	[LOCKDOWN_DEV_MEM] = "/dev/mem,kmem,port",
+	[LOCKDOWN_EFI_TEST] = "/dev/efi_test access",
+	[LOCKDOWN_KEXEC] = "kexec of unsigned images",
+	[LOCKDOWN_HIBERNATION] = "hibernation",
+	[LOCKDOWN_PCI_ACCESS] = "direct PCI access",
+	[LOCKDOWN_IOPORT] = "raw io port access",
+	[LOCKDOWN_MSR] = "raw MSR access",
+	[LOCKDOWN_ACPI_TABLES] = "modifying ACPI tables",
+	[LOCKDOWN_DEVICE_TREE] = "modifying device tree contents",
+	[LOCKDOWN_PCMCIA_CIS] = "direct PCMCIA CIS storage",
+	[LOCKDOWN_TIOCSSERIAL] = "reconfiguration of serial port IO",
+	[LOCKDOWN_MODULE_PARAMETERS] = "unsafe module parameters",
+	[LOCKDOWN_MMIOTRACE] = "unsafe mmio",
+	[LOCKDOWN_DEBUGFS] = "debugfs access",
+	[LOCKDOWN_XMON_WR] = "xmon write access",
+	[LOCKDOWN_BPF_WRITE_USER] = "use of bpf to write user RAM",
+	[LOCKDOWN_DBG_WRITE_KERNEL] = "use of kgdb/kdb to write kernel RAM",
+	[LOCKDOWN_RTAS_ERROR_INJECTION] = "RTAS error injection",
+	[LOCKDOWN_XEN_USER_ACTIONS] = "Xen guest user action",
+	[LOCKDOWN_INTEGRITY_MAX] = "integrity",
+	[LOCKDOWN_KCORE] = "/proc/kcore access",
+	[LOCKDOWN_KPROBES] = "use of kprobes",
+	[LOCKDOWN_BPF_READ_KERNEL] = "use of bpf to read kernel RAM",
+	[LOCKDOWN_DBG_READ_KERNEL] = "use of kgdb/kdb to read kernel RAM",
+	[LOCKDOWN_PERF] = "unsafe use of perf",
+	[LOCKDOWN_TRACEFS] = "use of tracefs",
+	[LOCKDOWN_XMON_RW] = "xmon read and write access",
+	[LOCKDOWN_XFRM_SECRET] = "xfrm SA secret",
+	[LOCKDOWN_CONFIDENTIALITY_MAX] = "confidentiality",
+};
+
 static enum lockdown_reason kernel_locked_down;
 
 static const enum lockdown_reason lockdown_levels[] = {LOCKDOWN_NONE,
diff --git a/security/security.c b/security/security.c
index f6583d507395..71cc823881b8 100644
--- a/security/security.c
+++ b/security/security.c
@@ -35,46 +35,6 @@
 
 #include "lsm.h"
 
-/*
- * These are descriptions of the reasons that can be passed to the
- * security_locked_down() LSM hook. Placing this array here allows
- * all security modules to use the same descriptions for auditing
- * purposes.
- */
-const char *const lockdown_reasons[LOCKDOWN_CONFIDENTIALITY_MAX + 1] = {
-	[LOCKDOWN_NONE] = "none",
-	[LOCKDOWN_MODULE_SIGNATURE] = "unsigned module loading",
-	[LOCKDOWN_DEV_MEM] = "/dev/mem,kmem,port",
-	[LOCKDOWN_EFI_TEST] = "/dev/efi_test access",
-	[LOCKDOWN_KEXEC] = "kexec of unsigned images",
-	[LOCKDOWN_HIBERNATION] = "hibernation",
-	[LOCKDOWN_PCI_ACCESS] = "direct PCI access",
-	[LOCKDOWN_IOPORT] = "raw io port access",
-	[LOCKDOWN_MSR] = "raw MSR access",
-	[LOCKDOWN_ACPI_TABLES] = "modifying ACPI tables",
-	[LOCKDOWN_DEVICE_TREE] = "modifying device tree contents",
-	[LOCKDOWN_PCMCIA_CIS] = "direct PCMCIA CIS storage",
-	[LOCKDOWN_TIOCSSERIAL] = "reconfiguration of serial port IO",
-	[LOCKDOWN_MODULE_PARAMETERS] = "unsafe module parameters",
-	[LOCKDOWN_MMIOTRACE] = "unsafe mmio",
-	[LOCKDOWN_DEBUGFS] = "debugfs access",
-	[LOCKDOWN_XMON_WR] = "xmon write access",
-	[LOCKDOWN_BPF_WRITE_USER] = "use of bpf to write user RAM",
-	[LOCKDOWN_DBG_WRITE_KERNEL] = "use of kgdb/kdb to write kernel RAM",
-	[LOCKDOWN_RTAS_ERROR_INJECTION] = "RTAS error injection",
-	[LOCKDOWN_XEN_USER_ACTIONS] = "Xen guest user action",
-	[LOCKDOWN_INTEGRITY_MAX] = "integrity",
-	[LOCKDOWN_KCORE] = "/proc/kcore access",
-	[LOCKDOWN_KPROBES] = "use of kprobes",
-	[LOCKDOWN_BPF_READ_KERNEL] = "use of bpf to read kernel RAM",
-	[LOCKDOWN_DBG_READ_KERNEL] = "use of kgdb/kdb to read kernel RAM",
-	[LOCKDOWN_PERF] = "unsafe use of perf",
-	[LOCKDOWN_TRACEFS] = "use of tracefs",
-	[LOCKDOWN_XMON_RW] = "xmon read and write access",
-	[LOCKDOWN_XFRM_SECRET] = "xfrm SA secret",
-	[LOCKDOWN_CONFIDENTIALITY_MAX] = "confidentiality",
-};
-
 bool lsm_debug __ro_after_init;
 
 unsigned int lsm_active_cnt __ro_after_init;
-- 
2.18.0.huawei.25

