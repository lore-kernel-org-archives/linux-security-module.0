Return-Path: <SRS0=ikEQ=WE=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 066D3C32756
	for <linux-security-module@archiver.kernel.org>; Thu,  8 Aug 2019 00:09:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C52D2217D7
	for <linux-security-module@archiver.kernel.org>; Thu,  8 Aug 2019 00:09:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dvTWxtC+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389581AbfHHAHy (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 7 Aug 2019 20:07:54 -0400
Received: from mail-qk1-f202.google.com ([209.85.222.202]:39649 "EHLO
        mail-qk1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389578AbfHHAHx (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 7 Aug 2019 20:07:53 -0400
Received: by mail-qk1-f202.google.com with SMTP id x1so80728468qkn.6
        for <linux-security-module@vger.kernel.org>; Wed, 07 Aug 2019 17:07:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=IqUClIssxa6D6MoIAE+ms+qpgX9OHdd3voCN/TpeHYo=;
        b=dvTWxtC+XmP29mXEKHzgd7oc0DtaDCI/IQTve+uHnDOnc/fS9aFi3DQJB1XBKaXVTS
         MrvbR7qvSyNd8roEdY1MLASnQlX6sRrF7psmphC50/Ens662JAYc16vT9K3leIbE15B+
         9B2McclD+lw5gjBrvhpYqChlRcXKSIvP6sLrT1YJ6ZQN00l66PmFEwe/Rd8ADIK3kKKO
         ugyG0f2b4LLwbxxKCgYxKILazJSTsbiZG5WmhylSPt6Qw0rpng5P9x2pCGIJ1IT1V7kx
         4O6YpXP5jBtlYY12lFTxqPWLnP5qqBpzIu2RuCvWPhMv4iu7GaOpdY2PgqyUZ/9TU1l8
         HSWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=IqUClIssxa6D6MoIAE+ms+qpgX9OHdd3voCN/TpeHYo=;
        b=ruImFVqNczxl+GXC45bMdpm6ZRF/F9VP84m+1gC76yjki0W3TK3xvI310/QT99PrhZ
         MsvWFy25m/mSM1IlgnNdxUmyvYl1X2WoqNRK87Fo08riheREiMLg+T9KBDiD+5SoHt3f
         Qp8x70Q6DpSysUq8CyLS/MvhJccFTe3E5dTLgqCjE38yfj6xVzaIL/Kk6r5K64hyvt/3
         q90wn3JsZCJO0/jllIp7cIGYtLXMmVA+V+npgwBBYSP/IFMoPChDrof7Cmxr829VWqiL
         +UippfeWlM/kh8FSgy+HPLmRhdJ/wiHgiU+UT71x2bCsp1/CicaRF99UqmqlEmJBhLC4
         EWYA==
X-Gm-Message-State: APjAAAVsZXPgMotRXFMe4ug/bKgf/lIZzoclprF4Zqekb2haeQWOqi+T
        HJ5mtcRFYHIONEWY78dCSVfQyH4gabzAbYL+gNZs1g==
X-Google-Smtp-Source: APXvYqx7OxYh/pP2s/xRJ1zCkpoOH7xQOniVOy105OLiF/Pwgi60FgUmTi0Sl3Huy1MZiiKW/EwR6sS5AWC9ALU/DqE+kg==
X-Received: by 2002:ac8:7251:: with SMTP id l17mr10749986qtp.277.1565222872565;
 Wed, 07 Aug 2019 17:07:52 -0700 (PDT)
Date:   Wed,  7 Aug 2019 17:07:03 -0700
In-Reply-To: <20190808000721.124691-1-matthewgarrett@google.com>
Message-Id: <20190808000721.124691-12-matthewgarrett@google.com>
Mime-Version: 1.0
References: <20190808000721.124691-1-matthewgarrett@google.com>
X-Mailer: git-send-email 2.22.0.770.g0f2c4a37fd-goog
Subject: [PATCH V38 11/29] PCI: Lock down BAR access when the kernel is locked down
From:   Matthew Garrett <matthewgarrett@google.com>
To:     jmorris@namei.org
Cc:     linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        Matthew Garrett <mjg59@srcf.ucam.org>,
        David Howells <dhowells@redhat.com>,
        Matthew Garrett <mjg59@google.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Kees Cook <keescook@chromium.org>, linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

From: Matthew Garrett <mjg59@srcf.ucam.org>

Any hardware that can potentially generate DMA has to be locked down in
order to avoid it being possible for an attacker to modify kernel code,
allowing them to circumvent disabled module loading or module signing.
Default to paranoid - in future we can potentially relax this for
sufficiently IOMMU-isolated devices.

Signed-off-by: David Howells <dhowells@redhat.com>
Signed-off-by: Matthew Garrett <mjg59@google.com>
Acked-by: Bjorn Helgaas <bhelgaas@google.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
cc: linux-pci@vger.kernel.org
---
 drivers/pci/pci-sysfs.c      | 16 ++++++++++++++++
 drivers/pci/proc.c           | 14 ++++++++++++--
 drivers/pci/syscall.c        |  4 +++-
 include/linux/security.h     |  1 +
 security/lockdown/lockdown.c |  1 +
 5 files changed, 33 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
index 965c72104150..396c1a90c0e1 100644
--- a/drivers/pci/pci-sysfs.c
+++ b/drivers/pci/pci-sysfs.c
@@ -906,6 +906,11 @@ static ssize_t pci_write_config(struct file *filp, struct kobject *kobj,
 	unsigned int size = count;
 	loff_t init_off = off;
 	u8 *data = (u8 *) buf;
+	int ret;
+
+	ret = security_locked_down(LOCKDOWN_PCI_ACCESS);
+	if (ret)
+		return ret;
 
 	if (off > dev->cfg_size)
 		return 0;
@@ -1167,6 +1172,11 @@ static int pci_mmap_resource(struct kobject *kobj, struct bin_attribute *attr,
 	int bar = (unsigned long)attr->private;
 	enum pci_mmap_state mmap_type;
 	struct resource *res = &pdev->resource[bar];
+	int ret;
+
+	ret = security_locked_down(LOCKDOWN_PCI_ACCESS);
+	if (ret)
+		return ret;
 
 	if (res->flags & IORESOURCE_MEM && iomem_is_exclusive(res->start))
 		return -EINVAL;
@@ -1243,6 +1253,12 @@ static ssize_t pci_write_resource_io(struct file *filp, struct kobject *kobj,
 				     struct bin_attribute *attr, char *buf,
 				     loff_t off, size_t count)
 {
+	int ret;
+
+	ret = security_locked_down(LOCKDOWN_PCI_ACCESS);
+	if (ret)
+		return ret;
+
 	return pci_resource_io(filp, kobj, attr, buf, off, count, true);
 }
 
diff --git a/drivers/pci/proc.c b/drivers/pci/proc.c
index fe7fe678965b..5495537c60c2 100644
--- a/drivers/pci/proc.c
+++ b/drivers/pci/proc.c
@@ -13,6 +13,7 @@
 #include <linux/seq_file.h>
 #include <linux/capability.h>
 #include <linux/uaccess.h>
+#include <linux/security.h>
 #include <asm/byteorder.h>
 #include "pci.h"
 
@@ -115,7 +116,11 @@ static ssize_t proc_bus_pci_write(struct file *file, const char __user *buf,
 	struct pci_dev *dev = PDE_DATA(ino);
 	int pos = *ppos;
 	int size = dev->cfg_size;
-	int cnt;
+	int cnt, ret;
+
+	ret = security_locked_down(LOCKDOWN_PCI_ACCESS);
+	if (ret)
+		return ret;
 
 	if (pos >= size)
 		return 0;
@@ -196,6 +201,10 @@ static long proc_bus_pci_ioctl(struct file *file, unsigned int cmd,
 #endif /* HAVE_PCI_MMAP */
 	int ret = 0;
 
+	ret = security_locked_down(LOCKDOWN_PCI_ACCESS);
+	if (ret)
+		return ret;
+
 	switch (cmd) {
 	case PCIIOC_CONTROLLER:
 		ret = pci_domain_nr(dev->bus);
@@ -238,7 +247,8 @@ static int proc_bus_pci_mmap(struct file *file, struct vm_area_struct *vma)
 	struct pci_filp_private *fpriv = file->private_data;
 	int i, ret, write_combine = 0, res_bit = IORESOURCE_MEM;
 
-	if (!capable(CAP_SYS_RAWIO))
+	if (!capable(CAP_SYS_RAWIO) ||
+	    security_locked_down(LOCKDOWN_PCI_ACCESS))
 		return -EPERM;
 
 	if (fpriv->mmap_state == pci_mmap_io) {
diff --git a/drivers/pci/syscall.c b/drivers/pci/syscall.c
index d96626c614f5..31e39558d49d 100644
--- a/drivers/pci/syscall.c
+++ b/drivers/pci/syscall.c
@@ -7,6 +7,7 @@
 
 #include <linux/errno.h>
 #include <linux/pci.h>
+#include <linux/security.h>
 #include <linux/syscalls.h>
 #include <linux/uaccess.h>
 #include "pci.h"
@@ -90,7 +91,8 @@ SYSCALL_DEFINE5(pciconfig_write, unsigned long, bus, unsigned long, dfn,
 	u32 dword;
 	int err = 0;
 
-	if (!capable(CAP_SYS_ADMIN))
+	if (!capable(CAP_SYS_ADMIN) ||
+	    security_locked_down(LOCKDOWN_PCI_ACCESS))
 		return -EPERM;
 
 	dev = pci_get_domain_bus_and_slot(0, bus, dfn);
diff --git a/include/linux/security.h b/include/linux/security.h
index 304a155a5628..8adbd62b7669 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -107,6 +107,7 @@ enum lockdown_reason {
 	LOCKDOWN_DEV_MEM,
 	LOCKDOWN_KEXEC,
 	LOCKDOWN_HIBERNATION,
+	LOCKDOWN_PCI_ACCESS,
 	LOCKDOWN_INTEGRITY_MAX,
 	LOCKDOWN_CONFIDENTIALITY_MAX,
 };
diff --git a/security/lockdown/lockdown.c b/security/lockdown/lockdown.c
index a0996f75629f..655fe388e615 100644
--- a/security/lockdown/lockdown.c
+++ b/security/lockdown/lockdown.c
@@ -22,6 +22,7 @@ static char *lockdown_reasons[LOCKDOWN_CONFIDENTIALITY_MAX+1] = {
 	[LOCKDOWN_DEV_MEM] = "/dev/mem,kmem,port",
 	[LOCKDOWN_KEXEC] = "kexec of unsigned images",
 	[LOCKDOWN_HIBERNATION] = "hibernation",
+	[LOCKDOWN_PCI_ACCESS] = "direct PCI access",
 	[LOCKDOWN_INTEGRITY_MAX] = "integrity",
 	[LOCKDOWN_CONFIDENTIALITY_MAX] = "confidentiality",
 };
-- 
2.22.0.770.g0f2c4a37fd-goog

