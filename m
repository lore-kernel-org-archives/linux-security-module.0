Received: from mail-m19731110.qiye.163.com (mail-m19731110.qiye.163.com [220.197.31.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B78EA653;
	Tue, 17 Dec 2024 06:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734418327; cv=none; b=D0fhmD9PRA+e+JSM8fYO445hi51Ken4pdYPogyh6TTIJW/3x3doQB2FMY26k4nf7kMiu2Y2tx/8vf9Kgor/a/V4AaKGsApmF81A5MdcgJzl5RjE2H+AAW0yybt6I3ExqdmkmIgGThEm858DOd6OFdtBDB+zmDcAx5oRW3dLFw/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734418327; c=relaxed/simple;
	bh=y+LkwHNr1AqPqcJMcpE9SD+56gxA8YpfdzhCz8jdBq0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lIdNXyRzshtqUcIP35QwyO0qRXCkgh94kqpykusQ4GrNuDSMzL3io/rwl2OOVlwtrO2OTnmLCSzuQHrZf0J9SV9p28qyES8AFUEn+NYLmVY/KBL6y13ypb7Ycyu/q5A0rEVhb4VtxWPKDTSB+WuM1G4U/Xw9pj7gyKTJaorruKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cqsoftware.com.cn; spf=pass smtp.mailfrom=cqsoftware.com.cn; dkim=pass (1024-bit key) header.d=cqsoftware.com.cn header.i=@cqsoftware.com.cn header.b=RWpe01F/; arc=none smtp.client-ip=220.197.31.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cqsoftware.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cqsoftware.com.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cqsoftware.com.cn header.i=@cqsoftware.com.cn header.b="RWpe01F/"
Received: from localhost.localdomain (unknown [123.53.36.163])
	by smtp.qiye.163.com (Hmail) with ESMTP id 5f3aea52;
	Tue, 17 Dec 2024 14:46:50 +0800 (GMT+08:00)
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
Subject: [PATCH 0/2] Add security index Chinese translation and add security lsm Chinese translation
Date: Tue, 17 Dec 2024 14:46:23 +0800
Message-ID: <cover.1734414723.git.zhaoyuehui@cqsoftware.com.cn>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVkZTBkfVk9KQh8dT0IaQxpDGVYVFAkWGhdVEwETFh
	oSFyQUDg9ZV1kYEgtZQVlKSUhVTkhVSE1VSk1IWVdZFhoPEhUdFFlBWUtVS1VLVUtZBg++
X-HM-Tid: 0a93d35e936503a3kunm5f3aea52
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6NxA6TAw5NzITOh4fCxlNCSpW
	NygaFBBVSlVKTEhPT0pDS0pJS09KVTMWGhIXVQETGhQCDh4TDhI7GAoIFB0PDBoJHlUYFBZVGBVF
	WVdZEgtZQVlKSUhVTkhVSE1VSk1IWVdZCAFZQU1JQjcG
DKIM-Signature:a=rsa-sha256;
	b=RWpe01F/mX1qXxlqEVQhIECjhanEmvLD7nuG1OjUlA+bfMw5CYRp6BTpzGqzyJK1zJ7GxEOncTB3QFsQTM1W/CgRkrM0sJQfVvzimTPAhaJ9DpkNZyxcNaGflAHSyM0lKqpQ8HRBgb67Uxik4RHQkcr6wii2l4bCTVMVRIN5Efw=; c=relaxed/relaxed; s=default; d=cqsoftware.com.cn; v=1;
	bh=lyA9T13+92+Kc9Qt6dNjlXWBSaVzZXeYMFDzPxTuhok=;
	h=date:mime-version:subject:message-id:from;

Translate .../security/index.rst into Chinese and translate 
.../security/lsm.rst into Chinese.

Yuehui Zhao (2):
  docs/zh_CN: Add security index Chinese translation
  docs/zh_CN: Add security lsm Chinese translation

 .../translations/zh_CN/security/index.rst     | 34 +++++++
 .../translations/zh_CN/security/lsm.rst       | 92 +++++++++++++++++++
 .../translations/zh_CN/subsystem-apis.rst     |  2 +-
 3 files changed, 127 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/translations/zh_CN/security/index.rst
 create mode 100644 Documentation/translations/zh_CN/security/lsm.rst

-- 
2.43.5

