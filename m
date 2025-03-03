Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBB8E78F3A;
	Mon,  3 Mar 2025 21:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741038581; cv=none; b=L9DSuynpf8PnJd79brHHtCT5cakiGRKLS5rRtZE8Xj2QHvNiu39H3FFgaiT1IEZjY11PGXfsIYoNkVGrKPeLFMv47QzodjgHuYyh4QW6M5iBD4/7nJSMONnrPByLepW7W0SS8HBXNFfyB5A9XMMcYrVUU/i8iwGijUIpILABwfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741038581; c=relaxed/simple;
	bh=gNKh6z+V0XfWDMmfeQlgbVycioc4zKytg64P1clkbJ8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=bTzYxd05HirpPni0RtUyn1zrfFJGY739r6VuZ22h++tmZ62G7Fp2lEfFDFEK26FJ4OktdBb0tNv4g6v0w5guXEBILAnmODg0AqGxeq7VtWdarB307aoMyY2SkCqysEQzj2DINBC/sYhhm5/jFt7qXtYK4Bpy65Kdix0iZWBL00M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nRvVNibq; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nRvVNibq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37EE5C4CED6;
	Mon,  3 Mar 2025 21:49:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741038581;
	bh=gNKh6z+V0XfWDMmfeQlgbVycioc4zKytg64P1clkbJ8=;
	h=From:To:Cc:Subject:Date:From;
	b=nRvVNibqDskIMcUP6QRGlSo6ndaTnORk+V1rY4h6zFMWlt+59QCiXREcFsXN+aB05
	 vgv3/ZnhDP4Q1Xzjy71YstxX7cZCbzyEIG9pkZBu/jMrxJXG30K4bysukDerGNW7Kt
	 f6Si+DgQN67zDt7M5Skds95RBKHoJ4JGnQGpifCvgCKQcACYNuIQMow8wc7DVxlPa2
	 iC1JPxrTrNGruGPh9RSA3HhM4y7HGCyKa9fHYJlIeRY21Qj3vSyy7q/4aWYDARjlO/
	 icxYKrOnldxclpTLzb3BhZ0qBpGMqn4ev1HxE0ejb6xR8hdPc3E4kip1g9eBsCXGyX
	 lvXgGKzSHGdAA==
From: Kees Cook <kees@kernel.org>
To: Nathan Chancellor <nathan@kernel.org>
Cc: Kees Cook <kees@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	llvm@lists.linux.dev,
	linux-hardening@vger.kernel.org,
	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org
Subject: [PATCH] hardening: Enable i386 FORTIFY_SOURCE on Clang 16+
Date: Mon,  3 Mar 2025 13:49:37 -0800
Message-Id: <20250303214929.work.499-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1258; i=kees@kernel.org; h=from:subject:message-id; bh=gNKh6z+V0XfWDMmfeQlgbVycioc4zKytg64P1clkbJ8=; b=owGbwMvMwCVmps19z/KJym7G02pJDOnHlD8Y9LldbrLIfRttGnPjptzaosvZxZ7bORW9ThsG2 K9/f7q+o5SFQYyLQVZMkSXIzj3OxeNte7j7XEWYOaxMIEMYuDgFYCJK4Qx/OJS0Ms7W364rUzf4 xXTvwdz2dd2//jI8Ey+VvsOQb6yny8gw+4Rll1LAT/3ofXXir5ytGi7vfLT6Y8qk9P5/69QOpB5 kBQA=
X-Developer-Key: i=kees@kernel.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

The i386 regparm bug exposed with FORTIFY_SOURCE with Clang was fixed
in Clang 16[1].

Link: https://github.com/llvm/llvm-project/commit/c167c0a4dcdb998affb2756ce76903a12f7d8ca5 [1]
Signed-off-by: Kees Cook <kees@kernel.org>
---
Cc: Nathan Chancellor <nathan@kernel.org>
Cc: Nick Desaulniers <ndesaulniers@google.com>
Cc: Bill Wendling <morbo@google.com>
Cc: Justin Stitt <justinstitt@google.com>
Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: llvm@lists.linux.dev
Cc: linux-hardening@vger.kernel.org
---
 security/Kconfig.hardening | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/security/Kconfig.hardening b/security/Kconfig.hardening
index 23ffb0d7c845..c17366ce8224 100644
--- a/security/Kconfig.hardening
+++ b/security/Kconfig.hardening
@@ -286,7 +286,7 @@ config FORTIFY_SOURCE
 	bool "Harden common str/mem functions against buffer overflows"
 	depends on ARCH_HAS_FORTIFY_SOURCE
 	# https://github.com/llvm/llvm-project/issues/53645
-	depends on !CC_IS_CLANG || !X86_32
+	depends on !X86_32 || !CC_IS_CLANG || CLANG_VERSION >= 160000
 	help
 	  Detect overflows of buffers in common string and memory functions
 	  where the compiler can determine and validate the buffer sizes.
-- 
2.34.1

