Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A42F2C3255;
	Thu,  5 Feb 2026 23:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770335943; cv=none; b=b5irRqomWbpCEsxV/dYtnS0TVME+XyUZdTHKwy/FUx7o5X0fMUH5kmTN2h2X65D/diMY6WuPd5BLu/G2ak3CD1H/ExbNQGfl89pwZ9iQfKl6pA3/xFajqppAAkMwmGGuu7LJ9RBzljnmbG4Luoji2ghe9kvD701xvPjftf2avSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770335943; c=relaxed/simple;
	bh=YUD3J5MXuMneut3LxQPJj/RLUponcb/JRKdfZQYKlhs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IRcCoR81VEiv0iM8ptQsuzq5tA3N4WbcOfAvy5Y6Fu5kgdYI64AXYm1DE+vU4n1em78Vk7dYZTGPVaEhbybR6THjHAEQFiUGXC2DhxlczbS1lpJ8/b7mFtRUGO5ga7cgdJIIVYuAAfIBeQ6tWDv0pwbVeJMQjg3EYyRdpVaIG0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=CmHQ7JAZ; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="CmHQ7JAZ"
Received: from chenste-Virtual-Machine.mshome.net (unknown [131.107.1.186])
	by linux.microsoft.com (Postfix) with ESMTPSA id 2582A20B7168;
	Thu,  5 Feb 2026 15:59:02 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 2582A20B7168
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1770335942;
	bh=yWletEREOJw5mTRt5nZsCm5HLIu3eUuKfdetxO9j5xc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CmHQ7JAZf3UQSHfqLgWTiqhLCo8328uYpwPcxRaPTnKZjiHzdRe/ODTWE/Lk/MUrZ
	 chWCq4gQAxwP8tvie/mj9KymORuOi9FZnhy5qcaNns/DNTGMH9eIeP9jtKSVVqCxi+
	 SgqulhbJKW+QYugx8XnzUo4OR4bqj78jIEWGdI6w=
From: steven chen <chenste@linux.microsoft.com>
To: linux-integrity@vger.kernel.org
Cc: zohar@linux.ibm.com,
	roberto.sassu@huawei.com,
	dmitry.kasatkin@gmail.com,
	eric.snowberg@oracle.com,
	corbet@lwn.net,
	serge@hallyn.com,
	paul@paul-moore.com,
	jmorris@namei.org,
	linux-security-module@vger.kernel.org,
	anirudhve@linux.microsoft.com,
	chenste@linux.microsoft.com,
	gregorylumen@linux.microsoft.com,
	nramas@linux.microsoft.com,
	sushring@linux.microsoft.com,
	linux-doc@vger.kernel.org
Subject: [PATCH v4 1/3] ima: make ima event log trimming configurable
Date: Thu,  5 Feb 2026 15:58:46 -0800
Message-ID: <20260205235849.7086-2-chenste@linux.microsoft.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260205235849.7086-1-chenste@linux.microsoft.com>
References: <20260205235849.7086-1-chenste@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Make ima event log trimming function configurable.

Signed-off-by: steven chen <chenste@linux.microsoft.com>
---
 security/integrity/ima/Kconfig | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/security/integrity/ima/Kconfig b/security/integrity/ima/Kconfig
index 976e75f9b9ba..322964ae4772 100644
--- a/security/integrity/ima/Kconfig
+++ b/security/integrity/ima/Kconfig
@@ -332,4 +332,16 @@ config IMA_KEXEC_EXTRA_MEMORY_KB
 	  If set to the default value of 0, an extra half page of memory for those
 	  additional measurements will be allocated.
 
+config IMA_LOG_TRIMMING
+	bool "IMA Event Log Trimming"
+	default n
+	help
+	  Say Y here if you want support for IMA Event Log Trimming.
+		This creates the file /sys/kernel/security/integrity/ima/ima_trim_log.
+		Userspace
+		  - writes to this file to trigger IMA event log trimming
+		  - reads this file to get number of entried trimming last time
+
+	  If unsure, say N.
+
 endif
-- 
2.43.0

