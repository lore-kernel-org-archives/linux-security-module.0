Return-Path: <SRS0=0cm5=RJ=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 101DBC43381
	for <linux-security-module@archiver.kernel.org>; Wed,  6 Mar 2019 23:59:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D027120663
	for <linux-security-module@archiver.kernel.org>; Wed,  6 Mar 2019 23:59:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fgEDghp9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726445AbfCFX75 (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 6 Mar 2019 18:59:57 -0500
Received: from mail-vk1-f201.google.com ([209.85.221.201]:49133 "EHLO
        mail-vk1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726487AbfCFX7z (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 6 Mar 2019 18:59:55 -0500
Received: by mail-vk1-f201.google.com with SMTP id j1so7389546vkj.15
        for <linux-security-module@vger.kernel.org>; Wed, 06 Mar 2019 15:59:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=ACqFRhtJUfbHBZBPOu5dDkAx0/TaxY9Rwhxh4VD+UBs=;
        b=fgEDghp9aUPPq5LIQbGaL6nEH0coUYCSyYuTyRdQ1gO7leMx3wv+kvJFbiZsfJbaov
         pklDS/Qt+yxsTTHks6MoVO6lWCuAdTGqQMzj/XCnPMZ5UPnexaPpwiiChv19uM9BCsLb
         n9YirvJwxBiFfS9eJUPeX1s7SaKQQ2dx44MkksoVzcAyWjumoAoWdn1t2PQ4sFbpQjQv
         v6PPsY0oLcsXMY6ctV6rr7aTkf2/sZpJgGo917exFXjIF4tDC6TPaOHRkVBab0nCoNQe
         KYu6vYBfWFa8zDnkCuY6BcGyBAU7/dXYU0DzBrLh18YqVlZ8UvtOrAE4Sd4uraIBBuDv
         8uQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=ACqFRhtJUfbHBZBPOu5dDkAx0/TaxY9Rwhxh4VD+UBs=;
        b=tRV0eiJ7E0YvXh11gaT5OMgRH+eIZiUUocpYd6mRX/glfTBkAkxqJy51zK1dFe+Y01
         bbTPQK8fDe6IPHgmK7E/SE/1EAgxiAqoHuQ8joaCXxUBtbAysY1jV85AnrmuLZa3wxzp
         7FWNDxg29b4xOui6ROTF8bJW6zEqAKyaxb8WqpbcKmHyK79lSy1C90xUqtHWPQLMT74T
         omt53MPJQczYL0LO5C4N9HF2uE5vDtZ4RxbvxQIMlAomfkvcu58CrdyqxuFU+o7HTIfn
         30z0jWcHruOL/hjgJ37QiKOTQsh3hf/uMWrffFY2xMEortZU5pgXjowsKge7+f6zIqCw
         QNGg==
X-Gm-Message-State: APjAAAVJIySdemTjjYgZbskQui5VhnK5n/VJK0wv4oYqfo9xLTO9O3sa
        Y8/bbQ3b/+ji/rRXcp8hWUsDmj5xGQHn3svv3bMEkA==
X-Google-Smtp-Source: APXvYqzUBqNd8/YUx2fDLnRpZCWhP0/NfK79PxMtzpWY5W8/fAB2exucG4GxQ+dIl9GStj1lAczoDSn+eRiRXxQ2c8jgmQ==
X-Received: by 2002:ab0:778d:: with SMTP id x13mr6862246uar.7.1551916794166;
 Wed, 06 Mar 2019 15:59:54 -0800 (PST)
Date:   Wed,  6 Mar 2019 15:58:57 -0800
In-Reply-To: <20190306235913.6631-1-matthewgarrett@google.com>
Message-Id: <20190306235913.6631-12-matthewgarrett@google.com>
Mime-Version: 1.0
References: <20190306235913.6631-1-matthewgarrett@google.com>
X-Mailer: git-send-email 2.21.0.352.gf09ad66450-goog
Subject: [PATCH 11/27] PCI: Lock down BAR access when the kernel is locked down
From:   Matthew Garrett <matthewgarrett@google.com>
To:     jmorris@namei.org
Cc:     linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, dhowells@redhat.com
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

Signed-off-by: Matthew Garrett <mjg59@srcf.ucam.org>
Signed-off-by: David Howells <dhowells@redhat.com>
Acked-by: Bjorn Helgaas <bhelgaas@google.com>
Reviewed-by: "Lee, Chun-Yi" <jlee@suse.com>
cc: linux-pci@vger.kernel.org
Signed-off-by: Matthew Garrett <matthewgarrett@google.com>
---
 drivers/pci/pci-sysfs.c | 9 +++++++++
 drivers/pci/proc.c      | 9 ++++++++-
 drivers/pci/syscall.c   | 3 ++-
 3 files changed, 19 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
index 9ecfe13157c0..40c14574fcf8 100644
--- a/drivers/pci/pci-sysfs.c
+++ b/drivers/pci/pci-sysfs.c
@@ -905,6 +905,9 @@ static ssize_t pci_write_config(struct file *filp, struct kobject *kobj,
 	loff_t init_off = off;
 	u8 *data = (u8 *) buf;
 
+	if (kernel_is_locked_down("Direct PCI access"))
+		return -EPERM;
+
 	if (off > dev->cfg_size)
 		return 0;
 	if (off + count > dev->cfg_size) {
@@ -1167,6 +1170,9 @@ static int pci_mmap_resource(struct kobject *kobj, struct bin_attribute *attr,
 	enum pci_mmap_state mmap_type;
 	struct resource *res = &pdev->resource[bar];
 
+	if (kernel_is_locked_down("Direct PCI access"))
+		return -EPERM;
+
 	if (res->flags & IORESOURCE_MEM && iomem_is_exclusive(res->start))
 		return -EINVAL;
 
@@ -1242,6 +1248,9 @@ static ssize_t pci_write_resource_io(struct file *filp, struct kobject *kobj,
 				     struct bin_attribute *attr, char *buf,
 				     loff_t off, size_t count)
 {
+	if (kernel_is_locked_down("Direct PCI access"))
+		return -EPERM;
+
 	return pci_resource_io(filp, kobj, attr, buf, off, count, true);
 }
 
diff --git a/drivers/pci/proc.c b/drivers/pci/proc.c
index 6fa1627ce08d..1549cdd0710e 100644
--- a/drivers/pci/proc.c
+++ b/drivers/pci/proc.c
@@ -117,6 +117,9 @@ static ssize_t proc_bus_pci_write(struct file *file, const char __user *buf,
 	int size = dev->cfg_size;
 	int cnt;
 
+	if (kernel_is_locked_down("Direct PCI access"))
+		return -EPERM;
+
 	if (pos >= size)
 		return 0;
 	if (nbytes >= size)
@@ -196,6 +199,9 @@ static long proc_bus_pci_ioctl(struct file *file, unsigned int cmd,
 #endif /* HAVE_PCI_MMAP */
 	int ret = 0;
 
+	if (kernel_is_locked_down("Direct PCI access"))
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
+	    kernel_is_locked_down("Direct PCI access"))
 		return -EPERM;
 
 	if (fpriv->mmap_state == pci_mmap_io) {
diff --git a/drivers/pci/syscall.c b/drivers/pci/syscall.c
index d96626c614f5..b8a08d3166a1 100644
--- a/drivers/pci/syscall.c
+++ b/drivers/pci/syscall.c
@@ -90,7 +90,8 @@ SYSCALL_DEFINE5(pciconfig_write, unsigned long, bus, unsigned long, dfn,
 	u32 dword;
 	int err = 0;
 
-	if (!capable(CAP_SYS_ADMIN))
+	if (!capable(CAP_SYS_ADMIN) ||
+	    kernel_is_locked_down("Direct PCI access"))
 		return -EPERM;
 
 	dev = pci_get_domain_bus_and_slot(0, bus, dfn);
-- 
2.21.0.352.gf09ad66450-goog

