Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B035137BE81
	for <linux-security-module@vger.kernel.org>; Thu, 23 Jul 2026 16:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784825535; cv=none; b=uipvn5GDVvypUaIn7eDDTDv4G/yb4YCl/1wG9ToqkatfTXII7np7MVs1chpqPMH0S1OwZTO6xDsi34qs3u/vYfkBaLRn9x1U7UiV1Z/I/hO0u4YJzHwFqDGKXIEYBVPzZjULVQJl5M5fsAD0h1tG2ruDPpiuMxYtRruwpAGAgt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784825535; c=relaxed/simple;
	bh=CNBqQ5i3USeINUZTevXgS3UHmdPeBZ7+m559Ksy6TY4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bt7oMEYslHvNiUtsNhQ9dR9q+m1+MFc8SRnqtt0JFd+vcR62VWtDsPIIornDr8yPPSsod2KGoFCpwl6wxBhzL5VqVwK1e4dz07xxvcSuXeC/iQOQEHXjLTMNmm+qULzojybm9jSL20BNSciQef4FOOF1a2AoAUTWfduMvR/15MY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=JjgvYKiJ; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="JjgvYKiJ"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=y/1wrY/biGMtqyto4+rSf0hY/JbsudHNFQON5x7hgkU=; b=JjgvYKiJLZrEb9BzpMNcpMVK/v
	Z4AECBoYi2FX+zHX3XmEbE3ed6XnMAyTCS3usG39PBiThaCUhLLmtgdVNEAo8SzZGS7n1Di7PMDHq
	2z/sAaR3QrMJkCMA20bCR0Tzm5ucvA9ir7RxHjLIq/TQ5YlSVhyKfyBVolEOzRD/4XKOrdmBWIdns
	w3O2HcuMWhKUgyays754D6+eZOa+L5TXc04qLcFRQKcHaWabat+P2srU1sOS72URCtML2JXbn8jYP
	dm57NzCMaEOQ0RgWY9xYcddoW8cYvWyVpXdrLmqBvULoKVcOtxnVgm5ick3qVGVgwX/2y7nG4AnZ+
	6Vvi6Btw==;
Received: from [50.53.43.113] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wmweY-0000000Ekas-0flS;
	Thu, 23 Jul 2026 16:52:10 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-security-module@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>,
	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>
Subject: [PATCH] capability: remove non-kernel-doc comments
Date: Thu, 23 Jul 2026 09:52:09 -0700
Message-ID: <20260723165209.226050-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert 2 "/**" comments to use plain C "/*" comment style to avoid
kernel-doc warnings:

Warning: include/uapi/linux/capability.h:114 expecting prototype for
 POSIX(). Prototype was for CAP_CHOWN() instead
Warning: include/uapi/linux/capability.h:175 expecting prototype for
 Linux(). Prototype was for CAP_SETPCAP() instead

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
---
Cc: Paul Moore <paul@paul-moore.com>
Cc: James Morris <jmorris@namei.org>
Cc: "Serge E. Hallyn" <serge@hallyn.com>

 include/uapi/linux/capability.h |   12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

--- linux-next-20260722.orig/include/uapi/linux/capability.h
+++ linux-next-20260722/include/uapi/linux/capability.h
@@ -104,9 +104,9 @@ struct vfs_ns_cap_data {
 #endif
 
 
-/**
- ** POSIX-draft defined capabilities.
- **/
+/*
+ * POSIX-draft defined capabilities.
+ */
 
 /* In a system with the [_POSIX_CHOWN_RESTRICTED] option defined, this
    overrides the restriction of changing file ownership and group
@@ -159,9 +159,9 @@ struct vfs_ns_cap_data {
 #define CAP_SETUID           7
 
 
-/**
- ** Linux-specific capabilities
- **/
+/*
+ * Linux-specific capabilities
+ */
 
 /* Without VFS support for capabilities:
  *   Transfer any capability in your permitted set to any pid,
