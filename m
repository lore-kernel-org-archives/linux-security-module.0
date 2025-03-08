Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7769157E6B;
	Sat,  8 Mar 2025 04:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741408174; cv=none; b=E/L1ZzlURiYCIenQyU0WPnm1q1Ne+h7zyUeg8UlJsQPvkty9R2sEBAZH2MB2lz0d+Q5xHrPnE6ELmn2au/WT+vSrk7PT3p4q2lYXo1PuHME7aGt5w+VRDAf6UbcDwirxGQQF115WddIf3/nafmzPAMDwo5Z1lfosYHX5BFdRiX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741408174; c=relaxed/simple;
	bh=1j0h8OtnNFUQUxMM67AhFj6DZDQadLIty5DwtZAN0gA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RwWXHiBxrf26yJQeEKESpGRVHxUmGBUjzy7HByBbwdICZ7iFL+UH6R9+OAbjqxiI60iuivLy6CeMl5E69gpu/IPzVkLnyg05D4axtLOt/qBE2zNdKtT7tHaguoUle6+IFJC5N5ubI6kh+f7OwUDgbrFx5Qb9dybWP+eUne3B+fw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aCoXdW56; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aCoXdW56"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F857C4CEE0;
	Sat,  8 Mar 2025 04:29:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741408173;
	bh=1j0h8OtnNFUQUxMM67AhFj6DZDQadLIty5DwtZAN0gA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aCoXdW56Waja8rloem07n/T3Z7He8K+oR7T1mJD4URQe3svc+xvFjmXeygCCIN4RR
	 NtXp46sMWm5cF0wtlYVV4PeQfWfqfSeJJ9iXzaeNtcg2vSScVL/83h9fRGTmV5qoLu
	 O27qNhKKg/Rvw63W35dINW/lbJqhSUoxYV03aAUQ/ndCjBY/O5vmov7yGwi0Au59ev
	 RyTZ/rgjKuw6Za/lwfjyD6ymSzeyd2gjOKfvLe7nVsH6+K/x+UdGt9kPeYvEWdRzgI
	 xBSVWnOc+iBNyCjp5IxYUMd/gzvWVAFv6B0t6My7v9dybY/HhiBM1Ld20XDeaHPHPj
	 UvkdhkzTx+u6g==
From: Kees Cook <kees@kernel.org>
To: Nathan Chancellor <nathan@kernel.org>
Cc: Kees Cook <kees@kernel.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	linux-kernel@vger.kernel.org,
	x86@kernel.org,
	linux-hardening@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	llvm@lists.linux.dev
Subject: [PATCH v2 2/2] hardening: Enable i386 FORTIFY_SOURCE on Clang 16+
Date: Fri,  7 Mar 2025 20:29:26 -0800
Message-Id: <20250308042929.1753543-2-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250308041950.it.402-kees@kernel.org>
References: <20250308041950.it.402-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1479; i=kees@kernel.org; h=from:subject; bh=1j0h8OtnNFUQUxMM67AhFj6DZDQadLIty5DwtZAN0gA=; b=owGbwMvMwCVmps19z/KJym7G02pJDOmnjy9tfzHvTKpM+hK2b+J5vOv2PAw7sqQl3eIp82zzy swUOcc5HaUsDGJcDLJiiixBdu5xLh5v28Pd5yrCzGFlAhnCwMUpABPxX8nIsLFw08RJ9znbA7MM p5wqX/ps1mqPYMG3P0KZ5jUFC/2K0WP4Z/lqcRG/xMFPd68G1ujb3eS+cibMd+VsK8kCFb9/Bke msgAA
X-Developer-Key: i=kees@kernel.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

The i386 regparm bug exposed with FORTIFY_SOURCE with Clang was fixed
in Clang 16[1].

Link: https://github.com/llvm/llvm-project/commit/c167c0a4dcdb998affb2756ce76903a12f7d8ca5 [1]
Signed-off-by: Kees Cook <kees@kernel.org>
---
 arch/x86/Makefile          | 2 +-
 security/Kconfig.hardening | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/Makefile b/arch/x86/Makefile
index d25ed25fb7d9..917459d1ad40 100644
--- a/arch/x86/Makefile
+++ b/arch/x86/Makefile
@@ -137,7 +137,7 @@ ifeq ($(CONFIG_X86_32),y)
         include $(srctree)/arch/x86/Makefile_32.cpu
         KBUILD_CFLAGS += $(cflags-y)
 
-    ifeq ($(CONFIG_CC_IS_CLANG),y)
+    ifneq ($(call clang-min-version, 160000),y)
         # temporary until string.h is fixed
         KBUILD_CFLAGS += -ffreestanding
     endif
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

