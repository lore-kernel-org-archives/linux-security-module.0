Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 234C7346AFC;
	Wed, 18 Mar 2026 10:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773830609; cv=none; b=jmutLa9l7t4KRSmK/Wddw5del4pO82cNI1bxonn0CJTN5Q4ip3q0yLFaPtP0ueCfUPubRcARS7msV5F+CQNcR54VTFgbY5VwCbs0zBdfKNE4mr0wgpK69ck6ELjX20DH8jhO/YIZ6m3kzU3es15TkWV4VjFg2ErEqedG835ftM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773830609; c=relaxed/simple;
	bh=YSWWS5/RcbLfkRSYSl3dyfcWydaBehiZvsfoJaPyKYM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=MVDog+ttNbqTvoQXaVftVLXpSZsCqoOt1bvClNS2sI+RHMr3Phv63GxMTrD5EIrrAx0wVitYWQ34HydtUOc9FTkaIaZ/Us7n66ihcXBwYysrGiPsCpig+XhOZoCkN8epjAGTzJjIoNhaBn9czYhDYwuRQzoxU+xudBUAJYFC7ZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bBGSK2+e; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bBGSK2+e"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62D0AC19421;
	Wed, 18 Mar 2026 10:43:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773830608;
	bh=YSWWS5/RcbLfkRSYSl3dyfcWydaBehiZvsfoJaPyKYM=;
	h=From:To:Cc:Subject:Date:From;
	b=bBGSK2+eUr4guK7mFf9E1PAp8ctjGlGmtPkFUbGzWkyMmZllFY5wemT8XABle0nI2
	 r0DcVCDLNxN/alP3vxavYYKJpcpCD6acqDDcDa5astlJnJ2oJmVy04gyVHRyicTekp
	 3xu4DkwnuZi4kDRKMNcZ1shK9UT+thmuYvBUDYHjfBpzgcBHmWqE/HdRhu3oxiMQ1e
	 l8Rovm42jRYMeySQTytIL7y5LzF4YihSJSe2sxZfqHoRFubeg9fZtLBQ37jgvAd+R+
	 iZ+Sm4+x5eNGxuMO3NdBsnbxZdb2L9SFxUZnz+4ayy6kg+z551EcRm224YK9E5d2fQ
	 MDNM1U4cTDIbw==
From: Arnd Bergmann <arnd@kernel.org>
To: Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	Amir Goldstein <amir73il@gmail.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Casey Schaufler <casey@schaufler-ca.com>,
	John Johansen <john.johhansen@canonical.com>,
	Christian Brauner <brauner@kernel.org>,
	Mimi Zohar <zohar@linux.ibm.com>,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] lsm: export security_mmap_backing_file
Date: Wed, 18 Mar 2026 11:42:54 +0100
Message-Id: <20260318104322.1643085-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

This symbol can now be used from a loadable erofs module, which causes
a build failure when it is not exported:

ERROR: modpost: "security_mmap_backing_file" [fs/erofs/erofs.ko] undefined!

Fixes: 0e2baaf8fed0 ("lsm: add the security_mmap_backing_file() hook")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 security/security.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/security/security.c b/security/security.c
index 8d10b184ce25..3e426a762864 100644
--- a/security/security.c
+++ b/security/security.c
@@ -2529,6 +2529,7 @@ int security_mmap_backing_file(struct vm_area_struct *vma,
 
 	return call_int_hook(mmap_backing_file, vma, backing_file, user_file);
 }
+EXPORT_SYMBOL_GPL(security_mmap_backing_file);
 
 /**
  * security_mmap_addr() - Check if mmap'ing an address is allowed
-- 
2.39.5

