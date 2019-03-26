Return-Path: <SRS0=+HMg=R5=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8879C10F06
	for <linux-security-module@archiver.kernel.org>; Tue, 26 Mar 2019 18:28:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B4C020866
	for <linux-security-module@archiver.kernel.org>; Tue, 26 Mar 2019 18:28:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Yz7oOrcD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732682AbfCZS2W (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 26 Mar 2019 14:28:22 -0400
Received: from mail-ua1-f73.google.com ([209.85.222.73]:33791 "EHLO
        mail-ua1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732681AbfCZS2V (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 26 Mar 2019 14:28:21 -0400
Received: by mail-ua1-f73.google.com with SMTP id h6so1622915uab.0
        for <linux-security-module@vger.kernel.org>; Tue, 26 Mar 2019 11:28:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=m5EpQp8h0Y4rOl6Y1bbFAZQnIUUjTzjUqWwPJEltX0Y=;
        b=Yz7oOrcDdKUM0oYpsGth5oCv8+Sc+iqvbZ8HKnhPKCnBF9rUHCL9szQCMAPU1PE8KZ
         V5oNz+OBCLawb6XGwCVNO/3W7ZIGW6CJqa38iNh+smM0l3Mf3WI096uUxVztD+vMlcy8
         withllnQOAKuH6gF0+c6jcTe8VCipjbIFvdZQ3SG7qlyXzoR+Tduukj9v5gmr817WjTN
         9qDDUFYKJxhZTZ6Uwfhk7qeYMwY0kNDGpr/Xub4PUqKY1bIS3otzcyj76HMmWPO1Cupi
         V7GyBI5YYjxdJUAmUSXaa8vzKtz1GNVChjlfHcl09ljj04vfopWnPSjdHPO8UC5ktyD4
         6Vaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=m5EpQp8h0Y4rOl6Y1bbFAZQnIUUjTzjUqWwPJEltX0Y=;
        b=ET1cmGu5LmL2GQdYA0trgNBgSaYQdGqFkLxCg/zxENkBI6Qy7Lvsv7L3tFE7lrGjP0
         2WlZCHsIdboDxEiiuer6gqH7KvTiROIzJKnWSyHBLnHa9Lt1IsWIqsxSH9c4YIx86+Ad
         hXpN8qMs1qvog35B/8GEBaduXK8V1MqG59c3EnIIjpy3N/AOo4Kih7+c86RdfGdKExRp
         ZAiIRMnFVze/VvlgcwLKI0TMF73UKUIMgqpYc680fi4nDLRk6Td/qVF9CnAisoOFXlYs
         hLr4rJmf9imErYEnqtCHkBjFZFdZQnbaNJlkFtZEtA71bHLGSe9TFFRT/wlxF2+CsoLd
         30pw==
X-Gm-Message-State: APjAAAVNKkWqjddcak0TJxgkwvRaW4369AoD4zxHe6cE0vh9tr5LTlWY
        lif2pp9era8ChYnLoz9KoCFXGycMp2BakTYZKY64Lw==
X-Google-Smtp-Source: APXvYqxJT/ULfLCwvV7wSB2GAtE6Vz8ph2N7xnq6Ot24PIma7JsvCCcrM8TBMNJZ/wPOc6HUu0fWwieS5ffY5o8z3DZmWA==
X-Received: by 2002:a1f:a4d:: with SMTP id 74mr14878315vkk.13.1553624900606;
 Tue, 26 Mar 2019 11:28:20 -0700 (PDT)
Date:   Tue, 26 Mar 2019 11:27:26 -0700
In-Reply-To: <20190326182742.16950-1-matthewgarrett@google.com>
Message-Id: <20190326182742.16950-11-matthewgarrett@google.com>
Mime-Version: 1.0
References: <20190326182742.16950-1-matthewgarrett@google.com>
X-Mailer: git-send-email 2.21.0.392.gf8f6787159e-goog
Subject: [PATCH V31 10/25] PCI: Lock down BAR access when the kernel is locked down
From:   Matthew Garrett <matthewgarrett@google.com>
To:     jmorris@namei.org
Cc:     linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, dhowells@redhat.com,
        linux-api@vger.kernel.org, luto@kernel.org,
        Matthew Garrett <mjg59@srcf.ucam.org>,
        Matthew Garrett <mjg59@google.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
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
cc: linux-pci@vger.kernel.org
---
 drivers/pci/pci-sysfs.c | 9 +++++++++
 drivers/pci/proc.c      | 9 ++++++++-
 drivers/pci/syscall.c   | 3 ++-
 3 files changed, 19 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
index 9ecfe13157c0..59d02088945e 100644
--- a/drivers/pci/pci-sysfs.c
+++ b/drivers/pci/pci-sysfs.c
@@ -905,6 +905,9 @@ static ssize_t pci_write_config(struct file *filp, struct kobject *kobj,
 	loff_t init_off = off;
 	u8 *data = (u8 *) buf;
 
+	if (kernel_is_locked_down("Direct PCI access", LOCKDOWN_INTEGRITY))
+		return -EPERM;
+
 	if (off > dev->cfg_size)
 		return 0;
 	if (off + count > dev->cfg_size) {
@@ -1167,6 +1170,9 @@ static int pci_mmap_resource(struct kobject *kobj, struct bin_attribute *attr,
 	enum pci_mmap_state mmap_type;
 	struct resource *res = &pdev->resource[bar];
 
+	if (kernel_is_locked_down("Direct PCI access", LOCKDOWN_INTEGRITY))
+		return -EPERM;
+
 	if (res->flags & IORESOURCE_MEM && iomem_is_exclusive(res->start))
 		return -EINVAL;
 
@@ -1242,6 +1248,9 @@ static ssize_t pci_write_resource_io(struct file *filp, struct kobject *kobj,
 				     struct bin_attribute *attr, char *buf,
 				     loff_t off, size_t count)
 {
+	if (kernel_is_locked_down("Direct PCI access", LOCKDOWN_INTEGRITY))
+		return -EPERM;
+
 	return pci_resource_io(filp, kobj, attr, buf, off, count, true);
 }
 
diff --git a/drivers/pci/proc.c b/drivers/pci/proc.c
index 6fa1627ce08d..85769f222b6d 100644
--- a/drivers/pci/proc.c
+++ b/drivers/pci/proc.c
@@ -117,6 +117,9 @@ static ssize_t proc_bus_pci_write(struct file *file, const char __user *buf,
 	int size = dev->cfg_size;
 	int cnt;
 
+	if (kernel_is_locked_down("Direct PCI access", LOCKDOWN_INTEGRITY))
+		return -EPERM;
+
 	if (pos >= size)
 		return 0;
 	if (nbytes >= size)
@@ -196,6 +199,9 @@ static long proc_bus_pci_ioctl(struct file *file, unsigned int cmd,
 #endif /* HAVE_PCI_MMAP */
 	int ret = 0;
 
+	if (kernel_is_locked_down("Direct PCI access", LOCKDOWN_INTEGRITY))
+		return -EPERM;
+
 	switch (cmd) {
 	case PCIIOC_CONTROLLER:
 		ret = pci_domain_nr(dev->bus);
@@ -237,7 +243,8 @@ static int proc_bus_pci_mmap(struct file *file, struct vm_area_struct *vma)
 	struct pci_filp_private *fpriv = file->private_data;
 	int i, ret, write_combine = 0, res_bit = IORESOURCE_MEM;
 
-	if (!capable(CAP_SYS_RAWIO))
+	if (!capable(CAP_SYS_RAWIO) ||
+	    kernel_is_locked_down("Direct PCI access", LOCKDOWN_INTEGRITY))
 		return -EPERM;
 
 	if (fpriv->mmap_state == pci_mmap_io) {
diff --git a/drivers/pci/syscall.c b/drivers/pci/syscall.c
index d96626c614f5..0669cb09e792 100644
--- a/drivers/pci/syscall.c
+++ b/drivers/pci/syscall.c
@@ -90,7 +90,8 @@ SYSCALL_DEFINE5(pciconfig_write, unsigned long, bus, unsigned long, dfn,
 	u32 dword;
 	int err = 0;
 
-	if (!capable(CAP_SYS_ADMIN))
+	if (!capable(CAP_SYS_ADMIN) ||
+	    kernel_is_locked_down("Direct PCI access", LOCKDOWN_INTEGRITY))
 		return -EPERM;
 
 	dev = pci_get_domain_bus_and_slot(0, bus, dfn);
-- 
2.21.0.392.gf8f6787159e-goog

