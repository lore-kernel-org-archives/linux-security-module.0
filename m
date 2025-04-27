Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6991153363;
	Sun, 27 Apr 2025 01:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745717919; cv=none; b=nwYrlYOJttWsdQ8j6tuk8Vc9uIS3X5otLw2HQsIMFD68cpteq67NOeqYCf4SqeH+uTgxvAiWMzFc6uTOTeQJRyM0qy+qYRGFsWy6s9DApj05UgRmDurHxPqiiVgv/5mmQ25w6gEVIizxOCKZlG5LeE2Wd/hNK6IhN8zIfVjm0CQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745717919; c=relaxed/simple;
	bh=f2zuuETwF7/cSr/vgGubpYgjRdH4fdk81lTHWa9PGac=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lFsV2crDE3ubf032hqI7sB/+Yd6TmamLVFG1YbPwEJ+gSBOHu2NrmkFJnkeLIpFJEvAWjNpnDAjT42bJM0VNMRSbkhP7HdlpUkxju2pPpBGglb6AuWhILBL5IYNwB0Ch1yTsTS7rU+BD4ld+vOAVK05oCWa2wq4FiLFHTVFnHHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r2YkLjuI; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r2YkLjuI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB25FC4AF0B;
	Sun, 27 Apr 2025 01:38:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745717918;
	bh=f2zuuETwF7/cSr/vgGubpYgjRdH4fdk81lTHWa9PGac=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=r2YkLjuITyd6de/zH3yuC6ypo3JqNixXOosYgAMr1TkG5pTnLylekUp4+Gxc1eKyB
	 POn4R+bm9CN4WGaqwV+TwRhHd2+Cuz//gn2ZQ7rHrs8z81twvI8tixoBhcryPCeHyn
	 Wi4AVHSPGMBd7j6SD2Wa7Xla3YGogaB47AJY8ZLi6zLUv1uG7g/fgYFJBI3iUObNih
	 cGicOOYBhEVtd2hlFVj0ML886lIrkJKlF3eS92cKLh79z4twyyvTZSD918yWyLTEdF
	 tSQ6og5sFITOVtPu/5MYwa2MaQ1tc77V5tc0jEnCSGiqEzogX63WbkoRnryVvPHKAa
	 P7ARlB8C55ZiQ==
From: Kees Cook <kees@kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Kees Cook <kees@kernel.org>,
	"Dr. David Alan Gilbert" <linux@treblig.org>,
	Mark Brown <broonie@kernel.org>,
	WangYuli <wangyuli@uniontech.com>,
	=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	Bill Wendling <morbo@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Justin Stitt <justinstitt@google.com>,
	Petr Mladek <pmladek@suse.com>,
	David Gow <davidgow@google.com>,
	Rae Moar <rmoar@google.com>,
	Tamir Duberstein <tamird@gmail.com>,
	Diego Vieira <diego.daniel.professional@gmail.com>,
	Luis Chamberlain <mcgrof@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev,
	linux-hardening@vger.kernel.org,
	linux-security-module@vger.kernel.org
Subject: [PATCH 3/3] Revert "hardening: Disable GCC randstruct for COMPILE_TEST"
Date: Sat, 26 Apr 2025 18:38:35 -0700
Message-Id: <20250427013836.877214-3-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250427013604.work.926-kees@kernel.org>
References: <20250427013604.work.926-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=892; i=kees@kernel.org; h=from:subject; bh=f2zuuETwF7/cSr/vgGubpYgjRdH4fdk81lTHWa9PGac=; b=owGbwMvMwCVmps19z/KJym7G02pJDBm8XbP2LVzANPFs6/ZFZY9vFJg+FP9keCpueVL8zctHq 07Gs6rYd5SyMIhxMciKKbIE2bnHuXi8bQ93n6sIM4eVCWQIAxenAEwkz4+R4dQEX3lfE+dSZZd5 lnMnrtv06rbN1idaX6IllsafF7dmMGNkWPv5LtuGJTc6V/6y2ezncdBxcpNNFd+EQ2wdmZ1ZMWd iWQA=
X-Developer-Key: i=kees@kernel.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

This reverts commit f5c68a4e84f9feca3be578199ec648b676db2030.

It is again possible to build "allmodconfig" with the randstruct GCC
plugin, so enable it for COMPILE_TEST to catch future bugs.

Signed-off-by: Kees Cook <kees@kernel.org>
---
 security/Kconfig.hardening | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/security/Kconfig.hardening b/security/Kconfig.hardening
index 3fe9d7b945c4..c17366ce8224 100644
--- a/security/Kconfig.hardening
+++ b/security/Kconfig.hardening
@@ -344,7 +344,7 @@ config CC_HAS_RANDSTRUCT
 
 choice
 	prompt "Randomize layout of sensitive kernel structures"
-	default RANDSTRUCT_FULL if COMPILE_TEST && CC_HAS_RANDSTRUCT
+	default RANDSTRUCT_FULL if COMPILE_TEST && (GCC_PLUGINS || CC_HAS_RANDSTRUCT)
 	default RANDSTRUCT_NONE
 	help
 	  If you enable this, the layouts of structures that are entirely
-- 
2.34.1

