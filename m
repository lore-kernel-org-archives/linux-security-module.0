Received: from sonic314-27.consmr.mail.ne1.yahoo.com (sonic314-27.consmr.mail.ne1.yahoo.com [66.163.189.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D6DD1803A
	for <linux-security-module@vger.kernel.org>; Sun, 25 Aug 2024 19:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.189.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724613069; cv=none; b=i6khLUPhsPt8IRjlsjlcAfmxdWUjmnYB1BL55FzKZoKg2OoKp/vme0POe1CQ6SlhT8qUoOBUiD8AxFzp2mz5Dr/MfrWdwCuW10yMua+7MH0AGcUK+b/yXRo8toKfToU4wrtsK9v2YnIBaqXB3GGLiEFcclaDgQg6bPr7grmthrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724613069; c=relaxed/simple;
	bh=0zxDquNpcXYMX0VzwwYvvIHYhYqJ2dLHjSTsBAJadMw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=togsK3FVTbY8j4YozBdixxHs5Rujo5LSKx0IFpATPj+lOVd67rQcNJpdQmp2U3rekNkOg13Wthjkoh/zu/P7yZWF1ykKmLiqCRPktaECZnvwQNdsLlh+N644SkPYLyLq+G7gIszIYprDALQ1bpeAurv+BF59MUGTyxm0d1tlDEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com; spf=none smtp.mailfrom=schaufler-ca.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=cU2Zu+DU; arc=none smtp.client-ip=66.163.189.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="cU2Zu+DU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1724613066; bh=K8ngif8BbH+uQhs46NfpiBquT6dHItO3b9MLzJbd82s=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=cU2Zu+DUVTfLCM2bP72FC56B2wIu48W1j2YBSGQsZil24bL5juaXeIzo7DLeUh7hiIkWn6r/GoiagjDlPyUo30Wc4F9vV8Qao3hP8CJj99xogu8oIwTxBzw6qg+WIiMsJTZTSa4+QqnednJlxvqtPT20qXhlUOsO0HW5MWIc+TItuZpGGwoJ6G80Vwztnt85rFRdKbwB6uTEgw1akyEg/tjQJ4ed7xigrfQj6rpZEoZ+cWRFJojQHInB8Xsl4Ogvt+gqG+IoPU90fkXc6k5uOLf4XEBQKaL8oW8Jxp7TdKJCcE8rPyOuzDZ1vJqMwDdbuLmInx8nI7QCIVVI1d6F9w==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1724613066; bh=X+TZkBkmkToe4x5WsAhcQFP3biMC/QJ18juOIAdFOHO=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=ZHSB+V7y1xxbTrEVBiHd1edlrPVuOiRUwDx1HNv3ddf1ICh1YZf7f4Knbky0U6en7CjTmwgRw804kVasTQcetNTBiBz9a75K8E4yX9/+GbPlhn8da2xAc1s5x+e9GPl7aooBdizd/KDI8IoRHScjdLpEvn5YPfydkqXA6rg/M5j7kE5/UZTddIDBFG4Z60/pQgG769RJ4jiRrT2b5/9/uXGsPKMkt1MhAvdP9O7z2MMA+TvECnjdASns3IJKsL9O5VgFvWQqJLrLrAFYynLOnwMCzueUSunnVeekZHzk27Qx5xdsl7AD/61C9d4hozdT/LZjoumGyl6HDunzfasuUw==
X-YMail-OSG: 5zCNsycVM1nq4nY.1QbbNZKWAHg5Z.8KzQzhjAfQ3jRj1RPmSRV7mpcxVw4aQ1r
 _BLE1NF6mp2rlWh.vs6w_C9tEQj5pqNTP.qCkN3p7F3AK7xcXidxM888pH2aNUjJjKek731rBv9q
 YaKzqvcQ7M4rFk5aqenJ8mL40e8JOValLrTLtPEjC8BkhiCNFNIoqEZNOJx6YQb0KfBShiqxVIEn
 H2D.77NMBy.WajvAD93wIidlg.Nel_BB3Yo.sP2lMdZ05t5fYCjECdBK_axG_vKLIo9yjEoVAXZe
 HXqNlEViu5AbHQPSw2ujaGlAsr4_pbAdy2xRz7O5oDzJ1Qb6JhfL3kZrZ_LrNJ7IVPcCZOrKrQGb
 r1GXkZ4nwVtUmfokF1WfLCsAIJ56qYJ5AA7g2_1Ohwe1Z9LgDWzux9B2EwYLaPtY3aVIrmjTWI.1
 RIwwJGGxYX3KYX0VAXeDMLIFCOYURrUs7clhUN5PCcf.5qvwW87DPsMAP3LOFNumsnXTkHYhU5Yd
 LwjV9kNpGDd8IrWwuw28FyriJ3Ww7wUkVI5ZZClBvCIrGcBhP9dZ9D_3w_QWb9BBPpq_8PiEAmVk
 8qQotRJay8etN2PBoM_5NV5AdM5.LH5ZkT6LqB.3ZRQ1knuyrt0SonoWEoetjGR7rcOJafAKyX1u
 IVj5dGDCBKtVyI9jKr64_0QzZXSrRxLIUhQuVRTfZF8Sja60_Os0FtyTsTAkjPECs3SHgOFQ8W81
 KMVbZ4qRDcCAejkDPqND5Ycj2D7f_rf4unr94mqopRXy6mqMcpCb3lN0dAL9hnnwMVTf05IE1VKR
 vE12.LJ8knzJFWESGXDrZplBMm00jTDE2F07Rqb5liwChhr0UXdtFw8jyF9FffGnODCPzeXGeGW.
 jz1WC0sQQ0kdZPKYXBzT5Ynufj5.G2qwwFt7PCU4NOwG9Aez2xQCTputgZcNFeBe_vQ3D0czVYA.
 VIxGcGj.pHbcw3CUEqlbF93BucItv16_ken7FsDZMB_8WjhMfT5r2VOg7OLXSHztPHSRhOm3uEQV
 2blUnEbXDNnaIByZ_bdnWSZTKoJ4kwzJS6QQSXvAxCzjR4PtpCl2awgQWTrDYiWMNWqxfBfN55HR
 JVtLSzvD_zXc3kzpeVRA0MPQ__qSaGnzrRrIzP3DoV1HByNAjLDiA.r437A1pwVv5SgHQmefDXAq
 mHg7FRpqMPlfWXfL067OUXgvhh54NewyA1o6.aaVifslvRwZZOxRWWlQLzkXwUFwTzxwVEAQxlRX
 sAgSLOzeKn2TpF0Exk.f37qShtBv0tTfqxphpaaLpXF0MX6e2oz6P3_1mNLqoCya6uWXgbqE0pTD
 ThvbOvzA3r9ZIK3T..piwDOlu_OE7szIJ.i9fYMqWYS8HW8kmGAoo1OTkLlwZEfm0WSIhOXo6mEw
 dx7S3SV0iibVOE_hkf7Og2MMdw9t51nHoeLXtiHKOsCv3dkQMb0q6PtKcwkDsQv4bdoK8Q6ZojQw
 9bOFPiC5ANojAwe.QHQIlxB7bOTJTQQ9AO8gXsY1vRm5F2SR4m3QY9h35U9efXbQrzltXwUUkHER
 JCTlgL_h3E04wYWJ_SlBeJsjuA1Go_D0hbEN83XOzSy83UYEjmBZOFiFmMNRdCPTFLnlWQnTz1AY
 DWoj23yFCQed3FVL25Up8rfvdif95kQm88bVk8smgzTmBqBJN9mNYd0w2t4W5pxBZ79XqibHeeY3
 SZe9ddab.suep5GIAG0x.h8vhaMfDwlzR9TZw699r97E2E04ABAv4_GLxtJIkCK04td6me0xCz9F
 x2vrvOHrHwR9MIZ8jfalwQpJ2NRd6Xysuv05zuZuYfKf2XWehp7dgFmWWIly04wr2G6Woawjq4Jw
 WC_0qX6JzOqu5hBV3veVwPootiPelD4eEBKmCuldfa1FLgRhmiUIGFlO3LTsxZys22veVCjVd__8
 QG2oIeGIpZsmcuwOoASE6KDWPX_UvvP7ogpqzToSqqCA60dXDr_PlGDdza7uNBDlGm6I627x79Tv
 q2Ej33SknoOotY0_RhKMn6r4_DCyaEXN9TzDcuZ7XH6gEBGjWxGRJaVFwEOCKROMBdYaTGVFeZiL
 19fDcJFgSF0mRZP14c8xTz3dhBW0UZkNr3DBzZhgfIK0LC53BbRFoy853Ed21CeGsQOcphkD4lwa
 NVQ2fSIRcPY63.O1tE3fPcyX6sADtHTIfrxNLORNizQc6Fh4PqNz29C_ltVhNpHD6_KyxO_g7sCk
 lFU5gRrS4r15gcgrUHENZ_QOOpGadjtsS939N7rGDAhpcys5_O93guHEAqNolt.yD12ot.3GhnHj
 vYqhK6XHPg_xo6Sgvlsfgg7z8CqYGufFHHA--
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 75c47b77-9dc4-449b-a3dd-0f89cbb378f9
Received: from sonic.gate.mail.ne1.yahoo.com by sonic314.consmr.mail.ne1.yahoo.com with HTTP; Sun, 25 Aug 2024 19:11:06 +0000
Received: by hermes--production-gq1-5d95dc458-rvnnh (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 6fc1ee0505485e3267054d717b5fc74f;
          Sun, 25 Aug 2024 19:00:56 +0000 (UTC)
From: Casey Schaufler <casey@schaufler-ca.com>
To: casey@schaufler-ca.com,
	paul@paul-moore.com,
	linux-security-module@vger.kernel.org
Cc: jmorris@namei.org,
	serge@hallyn.com,
	keescook@chromium.org,
	john.johansen@canonical.com,
	penguin-kernel@i-love.sakura.ne.jp,
	stephen.smalley.work@gmail.com,
	linux-kernel@vger.kernel.org,
	mic@digikod.net
Subject: [PATCH 01/13] LSM: Add the lsmblob data structure.
Date: Sun, 25 Aug 2024 12:00:36 -0700
Message-ID: <20240825190048.13289-2-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240825190048.13289-1-casey@schaufler-ca.com>
References: <20240825190048.13289-1-casey@schaufler-ca.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When more than one security module is exporting data to audit and
networking sub-systems a single 32 bit integer is no longer
sufficient to represent the data. Add a structure to be used instead.

The lsmblob structure definition is intended to keep the LSM
specific information private to the individual security modules.
The module specific information is included in a new set of
header files under include/lsm. Each security module is allowed
to define the information included for its use in the lsmblob.
SELinux includes a u32 secid. Smack includes a pointer into its
global label list. The conditional compilation based on feature
inclusion is contained in the include/lsm files.

Suggested-by: Paul Moore <paul@paul-moore.com>
Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 include/linux/lsm/apparmor.h | 17 +++++++++++++++++
 include/linux/lsm/bpf.h      | 16 ++++++++++++++++
 include/linux/lsm/selinux.h  | 16 ++++++++++++++++
 include/linux/lsm/smack.h    | 17 +++++++++++++++++
 include/linux/security.h     | 20 ++++++++++++++++++++
 5 files changed, 86 insertions(+)
 create mode 100644 include/linux/lsm/apparmor.h
 create mode 100644 include/linux/lsm/bpf.h
 create mode 100644 include/linux/lsm/selinux.h
 create mode 100644 include/linux/lsm/smack.h

diff --git a/include/linux/lsm/apparmor.h b/include/linux/lsm/apparmor.h
new file mode 100644
index 000000000000..8ff1cd899a20
--- /dev/null
+++ b/include/linux/lsm/apparmor.h
@@ -0,0 +1,17 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Linux Security Module interface to other subsystems.
+ * AppArmor presents a single u32 value which is known as a secid.
+ */
+#ifndef __LINUX_LSM_APPARMOR_H
+#define __LINUX_LSM_APPARMOR_H
+
+struct aa_label;
+
+struct lsmblob_apparmor {
+#ifdef CONFIG_SECURITY_APPARMOR
+	struct aa_label *label;
+#endif
+};
+
+#endif /* ! __LINUX_LSM_APPARMOR_H */
diff --git a/include/linux/lsm/bpf.h b/include/linux/lsm/bpf.h
new file mode 100644
index 000000000000..48abdcd82ded
--- /dev/null
+++ b/include/linux/lsm/bpf.h
@@ -0,0 +1,16 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Linux Security Module interface to other subsystems.
+ * BPF may present a single u32 value.
+ */
+#ifndef __LINUX_LSM_BPF_H
+#define __LINUX_LSM_BPF_H
+#include <linux/types.h>
+
+struct lsmblob_bpf {
+#ifdef CONFIG_BPF_LSM
+	u32 secid;
+#endif
+};
+
+#endif /* ! __LINUX_LSM_BPF_H */
diff --git a/include/linux/lsm/selinux.h b/include/linux/lsm/selinux.h
new file mode 100644
index 000000000000..fd16456b36ac
--- /dev/null
+++ b/include/linux/lsm/selinux.h
@@ -0,0 +1,16 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Linux Security Module interface to other subsystems.
+ * SELinux presents a single u32 value which is known as a secid.
+ */
+#ifndef __LINUX_LSM_SELINUX_H
+#define __LINUX_LSM_SELINUX_H
+#include <linux/types.h>
+
+struct lsmblob_selinux {
+#ifdef CONFIG_SECURITY_SELINUX
+	u32 secid;
+#endif
+};
+
+#endif /* ! __LINUX_LSM_SELINUX_H */
diff --git a/include/linux/lsm/smack.h b/include/linux/lsm/smack.h
new file mode 100644
index 000000000000..2018f288302f
--- /dev/null
+++ b/include/linux/lsm/smack.h
@@ -0,0 +1,17 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Linux Security Module interface to other subsystems.
+ * Smack presents a pointer into the global Smack label list.
+ */
+#ifndef __LINUX_LSM_SMACK_H
+#define __LINUX_LSM_SMACK_H
+
+struct smack_known;
+
+struct lsmblob_smack {
+#ifdef CONFIG_SECURITY_SMACK
+	struct smack_known *skp;
+#endif
+};
+
+#endif /* ! __LINUX_LSM_SMACK_H */
diff --git a/include/linux/security.h b/include/linux/security.h
index 1390f1efb4f0..0057a22137e8 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -34,6 +34,10 @@
 #include <linux/sockptr.h>
 #include <linux/bpf.h>
 #include <uapi/linux/lsm.h>
+#include <linux/lsm/selinux.h>
+#include <linux/lsm/smack.h>
+#include <linux/lsm/apparmor.h>
+#include <linux/lsm/bpf.h>
 
 struct linux_binprm;
 struct cred;
@@ -140,6 +144,22 @@ enum lockdown_reason {
 	LOCKDOWN_CONFIDENTIALITY_MAX,
 };
 
+/* scaffolding */
+struct lsmblob_scaffold {
+	u32 secid;
+};
+
+/*
+ * Data exported by the security modules
+ */
+struct lsmblob {
+	struct lsmblob_selinux selinux;
+	struct lsmblob_smack smack;
+	struct lsmblob_apparmor apparmor;
+	struct lsmblob_bpf bpf;
+	struct lsmblob_scaffold scaffold;
+};
+
 extern const char *const lockdown_reasons[LOCKDOWN_CONFIDENTIALITY_MAX+1];
 extern u32 lsm_active_cnt;
 extern const struct lsm_id *lsm_idlist[];
-- 
2.41.0

