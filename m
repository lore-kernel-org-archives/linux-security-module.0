Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793628032;
	b=fTCG6qu4o8NL8jJuDb4ohWd7B9oqBAeGe98pDO9efNLdBVfSdajt9VKYrlgLtoe4hhku
	 lNnk+tOH4MynMBtqNlNi8+/uEi4iEe4B7OX7oxUIiqjwMeY1Fjp0eWyqE0rvZxBcvSCbh
	 Rmd8QdYkCNh7qIcNrvzF89DZY3bYIaAWvczdwwj0ITl8wCzhx/jjKrm4fWlBNFueaDy4Q
	 +UJbGRxxrMhHHMev5f5DWLCm+9wsjdZzmuvKqg4Vtmm4ezbrcN3yl8HsVRUxVDd0IZIf4
	 qM/GBGpizGaOM25zAlU6hs0xGp3Sbw1bk8BaRGzUWviZqmWfhoMdT8cXFXxESA8lgTQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793628032;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer;
	bh=oYwhC4L2VlkW9t3srn9FHiQv9I+/AirtFZE3Wipxt0s=;
	b=fqwITfMsXwBNOZaFeRxjWOSTwzDwAIjZHfAPfVZ9EPdMlqffHwSctUpSBSg8vLQovroc
	 KH/OYBe4adPF0/7I6Xh1jIqkpIkjDHQt6dhCqKJ1lSV+voJljYHGuRUBTxDS+AVvN6LqO
	 Un44of2nry3ayNXclLaVUP+O3dJOQABJ4Y2VWXUoCWjX6hIRRAl1K2dK/qOPLnyv96F5Q
	 M4CTGHdCxhIH5qXHNsUq+qB2PJmj9cJcniTVNAxBBI7K8IouPy8LiJ5kYVe4eObWQ0Jdm
	 NlwMNaQYlJrJ0FBULmkGv6iL64o2zTc7/OSwdTiAABFs5ndmKhiZm54/80hLsLTKUGw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=G4ZfUDDd;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE5D860A2636;
	Mon,  2 Nov 2026 14:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=G4ZfUDDd
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC98C1F00A1A;
	Mon,  2 Nov 2026 14:00:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793628031;
	bh=oYwhC4L2VlkW9t3srn9FHiQv9I+/AirtFZE3Wipxt0s=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=G4ZfUDDdwIBVKoEFgSVFYtza9E9SK4027vrfL+AovTJ5tCGfp9oSl7ZnTIiCqJl9Y
	 xIl/nqzLDM7p+1GpmI15ChOeLvU4eIzo3F+IvSR7jTDp9u8SeMFiCAsE8Ljt2BLLdp
	 I5rSMjMygkL3ABqLGZm7fjP8CypERxaKUeJNAC5edVirJT2SQjIVYon4sSDfdhWeXs
	 uwai46A0keDZ9SgMw+E0YIvNbar/I+P4+pCJC1TaC7aTZswAy4DjcFTgOkjs724tVF
	 xmeD0q4es57HFLQzxb8Tj79TzazbhH27MrLfPF0joTGPjLsHNlR6G4qCLnju/34iQ/
	 0uDPQqgUbS5vQ==
From: "Mario Limonciello (AMD)" <superm1@kernel.org>
Date: Mon, 02 Nov 2026 08:00:25 -0600
Subject: [PATCH 1/2] iommu: Add iommu_is_available() API
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261102-lockdown-iommu-v1-1-00f3c2be4c9f@kernel.org>
References: <20261102-lockdown-iommu-v1-0-00f3c2be4c9f@kernel.org>
In-Reply-To: <20261102-lockdown-iommu-v1-0-00f3c2be4c9f@kernel.org>
To: "Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
 Robin Murphy <robin.murphy@arm.com>, 
 Nicolas Bouchinet <nicolas.bouchinet@oss.cyber.gouv.fr>, 
 Xiu Jianfeng <xiujianfeng@huawei.com>, Paul Moore <paul@paul-moore.com>, 
 James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org, 
 linux-security-module@vger.kernel.org, 
 "Mario Limonciello (AMD)" <superm1@kernel.org>
X-Mailer: b4 0.16.0

Add a generic API to query whether IOMMU subsystem is available on the
platform. This returns true if at least one IOMMU driver has been
registered and successfully probed, meaning hardware IOMMU support is
available on the platform.

The iommu_set_available() function is called from iommu_device_register()
when an IOMMU driver successfully registers, marking IOMMU as available.

This will be used by security subsystems (e.g. lockdown) that require
IOMMU isolation to provide meaningful security guarantees. Without IOMMU,
PCI/PCIe devices can perform DMA to arbitrary physical memory, bypassing
all software-level security protections.

Signed-off-by: Mario Limonciello (AMD) <superm1@kernel.org>
---
 drivers/iommu/iommu.c | 48 ++++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/iommu.h | 14 ++++++++++++++
 2 files changed, 62 insertions(+)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index b486b8bbd1fcd..d042944713ab4 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -309,6 +309,13 @@ int iommu_device_register(struct iommu_device *iommu,
 		iommu_device_unregister(iommu);
 	else
 		WRITE_ONCE(iommu->ready, true);
+	/*
+	 * Mark IOMMU as available if registration succeeded and bus probing
+	 * succeeded. This enables security checks (e.g. lockdown IOMMU check)
+	 * that depend on knowing whether hardware IOMMU isolation is present.
+	 */
+	if (!err)
+		iommu_set_available();
 	return err;
 }
 EXPORT_SYMBOL_GPL(iommu_device_register);
@@ -2961,6 +2968,47 @@ static int __init iommu_init(void)
 }
 core_initcall(iommu_init);
 
+static bool iommu_available __read_mostly;
+
+/**
+ * iommu_is_available() - Check if IOMMU subsystem is available
+ *
+ * Returns true if at least one IOMMU driver has been registered and
+ * successfully probed, meaning hardware IOMMU support is available on
+ * the platform. Returns false if no IOMMU driver is available.
+ *
+ * This function is intended for use by security subsystems that require
+ * IOMMU isolation to provide meaningful security guarantees (e.g. lockdown).
+ *
+ * Note: This function only reports on whether IOMMU drivers are present,
+ * not whether specific devices are covered. Use device_iommu_capable() or
+ * iommu_group_get() to check per-device IOMMU coverage.
+ *
+ * Context: Can be called at any time after module initialization has begun.
+ * Returns a snapshot of the IOMMU availability state.
+ *
+ * Return: True if IOMMU is available, false otherwise.
+ */
+bool iommu_is_available(void)
+{
+	return iommu_available;
+}
+EXPORT_SYMBOL_GPL(iommu_is_available);
+
+/**
+ * iommu_set_available() - Mark IOMMU as available
+ *
+ * Called by IOMMU drivers during probe to indicate that hardware IOMMU
+ * support is functional on this platform.
+ *
+ * Context: Called from driver probe paths.
+ */
+void iommu_set_available(void)
+{
+	iommu_available = true;
+}
+EXPORT_SYMBOL_GPL(iommu_set_available);
+
 int iommu_set_pgtable_quirks(struct iommu_domain *domain,
 		unsigned long quirk)
 {
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index ef5043752a365..d77237fc880ae 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -1222,6 +1222,13 @@ void iommu_detach_device_pasid(struct iommu_domain *domain,
 ioasid_t iommu_alloc_global_pasid(struct device *dev);
 void iommu_free_global_pasid(ioasid_t pasid);
 
+/*
+ * IOMMU availability API - for use by subsystems that require IOMMU
+ * isolation to provide security guarantees.
+ */
+bool iommu_is_available(void);
+void iommu_set_available(void);
+
 /* PCI device reset functions */
 int pci_dev_reset_iommu_prepare(struct pci_dev *pdev);
 void pci_dev_reset_iommu_done(struct pci_dev *pdev);
@@ -1557,6 +1564,13 @@ static inline int pci_dev_reset_iommu_prepare(struct pci_dev *pdev)
 static inline void pci_dev_reset_iommu_done(struct pci_dev *pdev)
 {
 }
+
+static inline bool iommu_is_available(void)
+{
+	return false;
+}
+static inline void iommu_set_available(void) {}
+
 #endif /* CONFIG_IOMMU_API */
 
 #ifdef CONFIG_IRQ_MSI_IOMMU

-- 
2.53.0

