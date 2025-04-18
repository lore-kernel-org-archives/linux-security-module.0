Received: from mail-m155101.qiye.163.com (mail-m155101.qiye.163.com [101.71.155.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACFC9209663;
	Fri, 18 Apr 2025 05:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=101.71.155.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744954114; cv=none; b=pehsnWgHXYN5a7UhKcrJXFEZZ6YuwoZesIVPBuVzKxnyVnWM7XJnCAxMkjAeD0qzYA+yr5kDkQC9PbtJ0EffKc2wWKJNgMqVeo6AN50Gz6g4Qn7ZDxp5zwNffnk8QrDwJUcqH/SRCZv5BKcAHx+Vm0thlGpP3tvNZeutyiHBrQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744954114; c=relaxed/simple;
	bh=MNZ25Q/4fQMmVJuKM1fLKIKZprsLyPpb9M59DqD34S8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ffilGfLiROvLDU2d+SBZTdxOUmj2q0KvS4FdR+1WZ6sTmr0ecInsgkorq1bQsMNpCo195tgV25xhiVnb1mU4ONAn4HMuWg82e2RdxBIeAi9PMwx+h6zjWZFldUihpSPeUaUyOOS0YtrIl+2d6ZUlo2jVWRf/VAVkbFAoFd2Y2EQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn; spf=pass smtp.mailfrom=seu.edu.cn; dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b=GyfOtVQn; arc=none smtp.client-ip=101.71.155.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b="GyfOtVQn"
Received: from localhost.localdomain (unknown [202.119.23.198])
	by smtp.qiye.163.com (Hmail) with ESMTP id 124f66a39;
	Fri, 18 Apr 2025 12:52:52 +0800 (GMT+08:00)
From: Zilin Guan <zilin@seu.edu.cn>
To: john.johansen@canonical.com
Cc: paul@paul-moore.com,
	jmorris@namei.org,
	serge@hallyn.com,
	apparmor@lists.ubuntu.com,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	jianhao.xu@seu.edu.cn,
	Zilin Guan <zilin@seu.edu.cn>
Subject: [RFC PATCH] security/apparmor: use kfree_sensitive() in unpack_secmark()
Date: Fri, 18 Apr 2025 04:52:50 +0000
Message-Id: <20250418045250.1262935-1-zilin@seu.edu.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVlCS0xJVhoYHxoYTE5KSR4ZQ1YeHw5VEwETFhoSFy
	QUDg9ZV1kYEgtZQVlJS0lVSkpCVUlIVUpCQ1lXWRYaDxIVHRRZQVlPS0hVSktISk9ITFVKS0tVSk
	JLS1kG
X-HM-Tid: 0a96473e140f03a1kunm124f66a39
X-HM-MType: 10
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6NTo6SRw*ODJPChQSCCIsHywQ
	GDoaCyxVSlVKTE9PQk5KQkxIQ0pPVTMWGhIXVQESFxIVOwgeDlUeHw5VGBVFWVdZEgtZQVlJS0lV
	SkpCVUlIVUpCQ1lXWQgBWUFKQk5JNwY+
DKIM-Signature:a=rsa-sha256;
	b=GyfOtVQne3DUUeU18T3d7HQCJHsDd5tHjwB5aOStAB/XPwVbYtWfkPeQX6C34FzznNp2iY5bgWDjzbD+NKlokhLWFax7zGtgaPRaGZzTXLGJ6C2mankeIABkvQS6awqPeT/bQHCP5XqIulHapNoc0qeFks/0Uq0BjxbrrBLQdYk=; c=relaxed/relaxed; s=default; d=seu.edu.cn; v=1;
	bh=Ox0qlUxWZtfCEfUosiIdxscw6OFJSR3qu90o9wjTNPQ=;
	h=date:mime-version:subject:message-id:from;

The unpack_secmark() function currently uses kfree() to release memory
allocated for secmark structures and their labels. However, if a failure
occurs after partially parsing secmark, sensitive data may remain in
memory, posing a security risk.

To mitigate this, replace kfree() with kfree_sensitive() for freeing
secmark structures and their labels, aligning with the approach used
in free_ruleset().

I am submitting this as an RFC to seek freedback on whether this change
is appropriate and aligns with the subsystem's expectations. If
confirmed to be helpful, I will send a formal patch.

Signed-off-by: Zilin Guan <zilin@seu.edu.cn>
---
 security/apparmor/policy_unpack.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/security/apparmor/policy_unpack.c b/security/apparmor/policy_unpack.c
index 992b74c50..610e09c76 100644
--- a/security/apparmor/policy_unpack.c
+++ b/security/apparmor/policy_unpack.c
@@ -598,8 +598,8 @@ static bool unpack_secmark(struct aa_ext *e, struct aa_ruleset *rules)
 fail:
 	if (rules->secmark) {
 		for (i = 0; i < size; i++)
-			kfree(rules->secmark[i].label);
-		kfree(rules->secmark);
+			kfree_sensitive(rules->secmark[i].label);
+		kfree_sensitive(rules->secmark);
 		rules->secmark_count = 0;
 		rules->secmark = NULL;
 	}
-- 
2.34.1

