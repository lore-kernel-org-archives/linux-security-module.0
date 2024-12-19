Received: from mail-m49247.qiye.163.com (mail-m49247.qiye.163.com [45.254.49.247])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53EB22163A9;
	Thu, 19 Dec 2024 06:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.247
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734589860; cv=none; b=TBreNqYDXQ9dXV+lQMs6gWXw/cReX4ErBJuAVg9/H5lUEXBy2/NeqVrvbWloPk22hoI8h9hOWjqmTAL7+spCDLV/29Bv2YduI/d4PpXjyRsUmyy7kmlDHIXrEglLB2Rw7cPNhUBP+/ObeZ+sJdnRX0J7u7qvikCdLT0455xcsTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734589860; c=relaxed/simple;
	bh=FoSQg45insJJ80NfiIjr9+I1G07P7jS/gPwyzDj+91c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BknR4JWH3NuUcjSFBV3eyP+rBUoOKn2XjvInl80iOwwJ21dA6v1+I4LSkjNU3R+FRtSrRu6aaTFepGULrapBbSTTkr85zljpdUjSC3AD0lnGYiIKn2GZomzDC0fQ6zXXeXre9u2xOxjL6EwaPUE7MARr8ryTp1kiFuJSsa/5BrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cqsoftware.com.cn; spf=pass smtp.mailfrom=cqsoftware.com.cn; dkim=pass (1024-bit key) header.d=cqsoftware.com.cn header.i=@cqsoftware.com.cn header.b=F/T6idG0; arc=none smtp.client-ip=45.254.49.247
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cqsoftware.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cqsoftware.com.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cqsoftware.com.cn header.i=@cqsoftware.com.cn header.b="F/T6idG0"
Received: from localhost.localdomain (unknown [123.149.2.140])
	by smtp.qiye.163.com (Hmail) with ESMTP id 6305454e;
	Thu, 19 Dec 2024 14:30:46 +0800 (GMT+08:00)
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
Subject: [PATCH v2 1/2] docs/zh_CN: Add security index Chinese translation
Date: Thu, 19 Dec 2024 14:30:34 +0800
Message-ID: <89ad67b4b4e12a52581cfa0f87f194e1aee3e526.1734575890.git.zhaoyuehui@cqsoftware.com.cn>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <cover.1734575890.git.zhaoyuehui@cqsoftware.com.cn>
References: <cover.1734575890.git.zhaoyuehui@cqsoftware.com.cn>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVlCTU4aVkJCQx5LT0IfH09PSFYVFAkWGhdVEwETFh
	oSFyQUDg9ZV1kYEgtZQVlKSUhVSk9CVUlVSk9LWVdZFhoPEhUdFFlBWU9LSFVKS0hKTkxOVUpLS1
	VKQktLWQY+
X-HM-Tid: 0a93dd9c92bf03a3kunm6305454e
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6NTo6Vhw*LzIVLhUfEQsCLh4x
	GRAKCxhVSlVKTEhPTkNCQ09MSk9MVTMWGhIXVQETGhQCDh4TDhI7GAoIFB0PDBoJHlUYFBZVGBVF
	WVdZEgtZQVlKSUhVSk9CVUlVSk9LWVdZCAFZQUpMTUw3Bg++
DKIM-Signature:a=rsa-sha256;
	b=F/T6idG09itd12R6DBgvgCC3TLbzBYSgx00uRJdxJg5+yTW8CdxbuDe3Spd2m/y3T0lAFG0FyBwuyajJce3tjJ2kh7Fj+AZ+pfkP9lKgOkIWI5P4pl444THs++m59Argzop39gem0PWVc8rAYc3r47pRDmuR/CyZwq27yo+9fK4=; c=relaxed/relaxed; s=default; d=cqsoftware.com.cn; v=1;
	bh=5x2Kf2btonTG0p7Xy9NQjHTxoSsp/MdEk/Kq2bv8xTE=;
	h=date:mime-version:subject:message-id:from;

Translate .../security/index.rst into Chinese.

Reviewed-by: Yanteng Si <si.yanteng@linux.dev>
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

