Received: from mail-m121152.qiye.163.com (mail-m121152.qiye.163.com [115.236.121.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5C491C69D;
	Thu, 19 Dec 2024 07:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.236.121.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734591977; cv=none; b=eZTbv6G04GWbinjmfBK+n6tzKWhXmqwmv3Z4hML9o83Uvg1hnkMtILgZyXL8p9dFGz0bXpb0lgKU3kSCFS1stAddCb0ZTr6oMdhIR8+I0FyqL02caXQnNQAN/WtS1YAAWeAvFeb5wt40bHYY73aJhAcrvU/a5FUulP4eorgdRVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734591977; c=relaxed/simple;
	bh=SHh+SmkzkTDh8iJlQH8ojD2q5s0ywuJ1jWJfiQMGwmk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=i1ma8fdWJZ2Ypj782IHbP0tHWC9KDQTVhGjjatPlaOpnqw2WgGVbOGXtgRYMtqo5LWudEkrnd6KWO+M+av6RV7oQ2cQPRBQQ5cADOqQVh3cqim3wxfVArOk0/nKi/y+R8VXYa16vJyjmqqrTe8pwKNrEBoaE4+Kq2KWC0KIDP2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cqsoftware.com.cn; spf=pass smtp.mailfrom=cqsoftware.com.cn; dkim=pass (1024-bit key) header.d=cqsoftware.com.cn header.i=@cqsoftware.com.cn header.b=VUh9gHNQ; arc=none smtp.client-ip=115.236.121.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cqsoftware.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cqsoftware.com.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cqsoftware.com.cn header.i=@cqsoftware.com.cn header.b="VUh9gHNQ"
Received: from localhost.localdomain (unknown [123.149.2.140])
	by smtp.qiye.163.com (Hmail) with ESMTP id 63054545;
	Thu, 19 Dec 2024 14:30:45 +0800 (GMT+08:00)
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
Subject: [PATCH v2 0/2] Add security index Chinese translation and add security lsm Chinese translation
Date: Thu, 19 Dec 2024 14:30:33 +0800
Message-ID: <cover.1734575890.git.zhaoyuehui@cqsoftware.com.cn>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVlCTxlKVhkZTRlMS0NNT0weQ1YVFAkWGhdVEwETFh
	oSFyQUDg9ZV1kYEgtZQVlKSUhVSk9CVUlVSk9LWVdZFhoPEhUdFFlBWU9LSFVKS0hKTkxOVUpLS1
	VKQktLWQY+
X-HM-Tid: 0a93dd9c8ec203a3kunm63054545
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6MEk6HAw5CzIVGBU1PwkWLhkX
	PR4wCSNVSlVKTEhPTkNCQ09NSklCVTMWGhIXVQETGhQCDh4TDhI7GAoIFB0PDBoJHlUYFBZVGBVF
	WVdZEgtZQVlKSUhVSk9CVUlVSk9LWVdZCAFZQU1JSjcG
DKIM-Signature:a=rsa-sha256;
	b=VUh9gHNQs6/vE6oMPbanGBXQlMsPTF704ZIiQQV0iVfQsTsu2qMikvfoZPUz0DnQlsCzZRl3cuLv4MyV9kjdEwTgtRlWREt1eqZtyOEPjeGrfP/rpOWqVfc+x87z4y2zMnVdrnbfiMipFbz3BbpDaXo+nrjBJFwm0gckGUgd814=; c=relaxed/relaxed; s=default; d=cqsoftware.com.cn; v=1;
	bh=pznUJ/RuH0bdUuNa4H4r1ca1cilgUh9Yi5jwnc3VUKE=;
	h=date:mime-version:subject:message-id:from;

Add some blank lines and modify some translations in security 
lsm Chinese translation.

Yuehui Zhao (2):
  docs/zh_CN: Add security index Chinese translation
  docs/zh_CN: Add security lsm Chinese translation

 .../translations/zh_CN/security/index.rst     | 34 +++++++
 .../translations/zh_CN/security/lsm.rst       | 95 +++++++++++++++++++
 .../translations/zh_CN/subsystem-apis.rst     |  2 +-
 3 files changed, 130 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/translations/zh_CN/security/index.rst
 create mode 100644 Documentation/translations/zh_CN/security/lsm.rst

-- 
2.43.5

