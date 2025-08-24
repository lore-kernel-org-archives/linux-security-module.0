Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A18AF229B1F;
	Sun, 24 Aug 2025 22:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756074484; cv=none; b=CjAvttaV5wKdIpBak+rqgyG2kab5eftMdrlHszoOr23CoPs8Z5HOuX3DM8mql+Fcbecm5uf66jqAFQOhgPxhqTpql68kiJCxihS89j9hj2Ujyr49F4i4WbhzGlCijCkG7kkzFKrG73WBKKFgcPreyM1fITtD1fzOrOYBmImYopo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756074484; c=relaxed/simple;
	bh=hboeTUVdSKri0pfB3TiGjU2dEvtnkR92VvuxStJAqKQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UBz/GQJxbapK/KqGAtvENQ1bunqs8073b1wu3YahDXqoGK91g933hHdqFoMwxRLnlH3F5yrc+K/yj7uIKKWsPWktpRi+2veYgDJvNSPH9WoSlFJwhTIMFyChH7+4Vupxo/gvSWVujt6P7oMwjMwXXFZV9kutHpX/hKsltYL1Xs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=s32WxOfu; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="s32WxOfu"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=U5Ld+2W8L7/209hv9vfjUh++6t2/3qSF7IL3azrpmLM=; b=s32WxOfuyMMi8KuQxURoO7R1nL
	jrGhQBXv4wZwL9RF6hgv7V38IjpyWV7k3Db/NztHQjt3fAToPBM9tMT641pTAcc58avsRBYwqHa9q
	4I+SSU2fPNbSb1IrdTfI6BX+7RbBCyU41RacrUZsGPcQLlT6xQUTDFZw0YaCUhWJ/nZ8j9LK0yaru
	4yrGYlnT1XFH4bj6DrS7cjqhG62BitrVthahUJgvo8pP6Uf5dXGeDUYGFZqe9pGQ9VB+tgiHJ5baq
	sR5enQnvzR8EPmsBFVKHOsw6mfyGk2TRyvNe00EtWuuobJaR33i4Ti9aSNz99zfadMsoTtkqlIu+q
	lVfrvB0g==;
Received: from [50.53.25.54] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uqJBw-00000006b5y-2mn5;
	Sun, 24 Aug 2025 22:28:00 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-kernel@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>,
	Kees Cook <kees@kernel.org>,
	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	linux-security-module@vger.kernel.org
Subject: [PATCH] security: CONFIG_LSM: LSM can depend on SECURITY
Date: Sun, 24 Aug 2025 15:28:00 -0700
Message-ID: <20250824222800.92263-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When CONFIG_SECURITY is not set, CONFIG_LSM (builtin_lsm_order) does
not need to be visible and settable since builtin_lsm_order is defined in
security.o, which is only built when CONFIG_SECURITY=y.

So make CONFIG_LSM depend on CONFIG_SECURITY.

Fixes: 13e735c0e953 ("LSM: Introduce CONFIG_LSM")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
---
Cc: Kees Cook <kees@kernel.org>
Cc: Paul Moore <paul@paul-moore.com>
Cc: James Morris <jmorris@namei.org>
Cc: "Serge E. Hallyn" <serge@hallyn.com>
Cc: linux-security-module@vger.kernel.org

 security/Kconfig |    1 +
 1 file changed, 1 insertion(+)

--- linux-next-20250819.orig/security/Kconfig
+++ linux-next-20250819/security/Kconfig
@@ -269,6 +269,7 @@ endchoice
 
 config LSM
 	string "Ordered list of enabled LSMs"
+	depends on SECURITY
 	default "landlock,lockdown,yama,loadpin,safesetid,smack,selinux,tomoyo,apparmor,ipe,bpf" if DEFAULT_SECURITY_SMACK
 	default "landlock,lockdown,yama,loadpin,safesetid,apparmor,selinux,smack,tomoyo,ipe,bpf" if DEFAULT_SECURITY_APPARMOR
 	default "landlock,lockdown,yama,loadpin,safesetid,tomoyo,ipe,bpf" if DEFAULT_SECURITY_TOMOYO
