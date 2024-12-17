Received: from mail-m15593.qiye.163.com (mail-m15593.qiye.163.com [101.71.155.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E8BC143C63;
	Tue, 17 Dec 2024 07:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=101.71.155.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734418935; cv=none; b=C2AolaahsU2mwASzyvWtJY+TP6x4KOAB9pKBNMiMXuvMcBfsFUWwf02TNX2sVqq/+L65gN/0Kx1Y3eeYNXZAnZqh3A4/vuzztrvVgaVl98Eh7Xm/u8fiEJjc7YpOZNaEd5pFLrDNUZtQcY0Wbn4r0cfVMI4bskYEA1GDC1/qK4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734418935; c=relaxed/simple;
	bh=urukd7flTp0fniDsip8fle/4fDrCpBLnlQrNX9MoZZk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oFJhXlxpJGu8vHt+bQ/obD2KESsOm57/Lg44HrHHvelJ/8Y6N99159FHthkV83dVVXcPLv6J6s3l+HlRdpuVqikrZFntx1M6cLo2nVK1iWwk2jglgxHnVrygxGBpMn0EbiWe6TtYEDDXpBltnc6i76RMhXxn/GNZuO+qT6JIBks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cqsoftware.com.cn; spf=pass smtp.mailfrom=cqsoftware.com.cn; dkim=pass (1024-bit key) header.d=cqsoftware.com.cn header.i=@cqsoftware.com.cn header.b=N3EnvHxe; arc=none smtp.client-ip=101.71.155.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cqsoftware.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cqsoftware.com.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cqsoftware.com.cn header.i=@cqsoftware.com.cn header.b="N3EnvHxe"
Received: from localhost.localdomain (unknown [123.53.36.163])
	by smtp.qiye.163.com (Hmail) with ESMTP id 5f3aea56;
	Tue, 17 Dec 2024 14:46:52 +0800 (GMT+08:00)
From: Yuehui Zhao <zhaoyuehui@cqsoftware.com.cn>
To: alexs@kernel.org,
	si.yanteng@linux.dev,
	corbet@lwn.net
Cc: dzm91@hust.edu.cn,
	mic@digikod.net,
	gnoack@google.com,
	linux-doc@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	Yuehui Zhao <zhaoyuehui@cqsoftware.com.cn>
Subject: [PATCH 1/2] docs/zh_CN: Add security index Chinese translation
Date: Tue, 17 Dec 2024 14:46:24 +0800
Message-ID: <89ad67b4b4e12a52581cfa0f87f194e1aee3e526.1734414723.git.zhaoyuehui@cqsoftware.com.cn>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <cover.1734414723.git.zhaoyuehui@cqsoftware.com.cn>
References: <cover.1734414723.git.zhaoyuehui@cqsoftware.com.cn>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVkZTRgdVhpMGUwZTUxCThkdHlYVFAkWGhdVEwETFh
	oSFyQUDg9ZV1kYEgtZQVlKSUhVTkhVSE1VSk1IWVdZFhoPEhUdFFlBWUtVS1VLVUtZBg++
X-HM-Tid: 0a93d35e97db03a3kunm5f3aea56
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6NjY6Nyo6HTIQLh4OCxlWCSg8
	PTkwCx9VSlVKTEhPT0pDS0pISkpNVTMWGhIXVQETGhQCDh4TDhI7GAoIFB0PDBoJHlUYFBZVGBVF
	WVdZEgtZQVlKSUhVTkhVSE1VSk1IWVdZCAFZQUpMSkI3Bg++
DKIM-Signature:a=rsa-sha256;
	b=N3EnvHxe7EhnSX/tOGA239r2RfptViBGCYy8+PtMOipUCCl+HWpAvw0w0f8vI5fJ92vkRscZKyYS//Ro3Hs0ibKzjBgUcvkjeo1BykPBFoDIS6hSl3gUp3L9cWRIKgZsiWt3fQM/SEyI6rTynH9q55uvND+9LReN0m7VXUEHahk=; c=relaxed/relaxed; s=default; d=cqsoftware.com.cn; v=1;
	bh=GxKkNy14PlU3GWJZzbRZFzozsqD17noWMNXC/7rqExo=;
	h=date:mime-version:subject:message-id:from;

Translate .../security/index.rst into Chinese.

Signed-off-by: Yuehui Zhao <zhaoyuehui@cqsoftware.com.cn>
---
 .../translations/zh_CN/security/index.rst     | 33 +++++++++++++++++++
 .../translations/zh_CN/subsystem-apis.rst     |  2 +-
 2 files changed, 34 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/translations/zh_CN/security/index.rst

diff --git a/Documentation/translations/zh_CN/security/index.rst b/Documentation/translations/zh_CN/security/index.rst
new file mode 100644
index 000000000000..6b56b4f87315
--- /dev/null
+++ b/Documentation/translations/zh_CN/security/index.rst
@@ -0,0 +1,33 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+.. include:: ../disclaimer-zh_CN.rst
+
+:Original: Documentation/security/index.rst
+
+:翻译:
+
+ 赵岳辉 Yuehui Zhao <zhaoyuehui@cqsoftware.com.cn>
+
+========
+安全文档
+========
+
+.. toctree::
+   :maxdepth: 1
+
+TODOLIST:
+* credentials
+* snp-tdx-threat-model
+* IMA-templates
+* keys/index
+* lsm
+* lsm-development
+* sak
+* SCTP
+* self-protection
+* siphash
+* tpm/index
+* digsig
+* landlock
+* secrets/index
+* ipe
diff --git a/Documentation/translations/zh_CN/subsystem-apis.rst b/Documentation/translations/zh_CN/subsystem-apis.rst
index 47780bb0772f..8b646c1010be 100644
--- a/Documentation/translations/zh_CN/subsystem-apis.rst
+++ b/Documentation/translations/zh_CN/subsystem-apis.rst
@@ -88,6 +88,7 @@ TODOList:
    cpu-freq/index
    iio/index
    virt/index
+   security/index
    PCI/index
    peci/index
 
@@ -102,7 +103,6 @@ TODOList:
 * watchdog/index
 * hwmon/index
 * accel/index
-* security/index
 * crypto/index
 * bpf/index
 * usb/index
-- 
2.43.5

