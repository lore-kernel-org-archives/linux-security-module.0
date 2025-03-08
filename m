Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D77B415E5DC;
	Sat,  8 Mar 2025 04:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741408174; cv=none; b=eu3TepZ4+iwo9Sp2r3TPOUNcUgYjs8eM0NmyJOsUr69wZt+KFDWNM3AtIcfXvqkfJn7vt/OpzbXJVcUrrGjWgSquoHmO4rTfpqWWAcdQWuhlM46dKTASLVdwVAzfWdIJRGUI/BJm+ehRSTG7e7KtIXdGjtx8CqZ741HJ8j3JbmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741408174; c=relaxed/simple;
	bh=2rqH2K/hmkSvy+fVXnqW3mEp/SoP0RjzdMEFR3wRgbw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=D9cuHrgvWkWyx00drhknvrWTvgXRWGgfQ8XElPZCaRAfNChjZ4YEcdPxkUk2W+2HSyCXNg2mqKs0D04TfueBKKLhZjgccAZVFKU7i+iATY8yUCVdd3kzaCScyoWvEI90Fnf2QnE6PBdkSJxC+ikoYXG4sx+LWKeZ+Eu2Bc2/UQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PLH2a0tE; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PLH2a0tE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53F41C4CEE5;
	Sat,  8 Mar 2025 04:29:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741408173;
	bh=2rqH2K/hmkSvy+fVXnqW3mEp/SoP0RjzdMEFR3wRgbw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PLH2a0tEdc28zkjtOIxCWf3+GeirEF1iVaJ83u6VfTTzZuOM+a1n+VIQZCD5iV0y/
	 vkYY8QncAmR524V2J6km/6iG2QkXtMg7Oyil32TTr+FxrZDrcujJfqBfB6JkE+stQl
	 HPx5GDrssaFXRHOaBIfKPApnYDqu4l/5mc4AMeUHwhch+2QcCueiG377UTu2Qjp+3v
	 k4IFQaXLmJIfblfYmYwc9lGAExLwOtPjoOgDcFA7rM8/20pWXNXcGxtiEltEh22q1C
	 E1lJAKSZPWEr0cKUXmtxkRyOJMmr+yFl9lZ3mcVbAuJoFIXu7wLk4pOXOqfNYsLlfp
	 WR4CSuQhPC/2Q==
From: Kees Cook <kees@kernel.org>
To: Nathan Chancellor <nathan@kernel.org>
Cc: Kees Cook <kees@kernel.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	llvm@lists.linux.dev
Subject: [PATCH v2 1/2] x86/build: Remove -ffreestanding on i386 with GCC
Date: Fri,  7 Mar 2025 20:29:25 -0800
Message-Id: <20250308042929.1753543-1-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250308041950.it.402-kees@kernel.org>
References: <20250308041950.it.402-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1122; i=kees@kernel.org; h=from:subject; bh=2rqH2K/hmkSvy+fVXnqW3mEp/SoP0RjzdMEFR3wRgbw=; b=owGbwMvMwCVmps19z/KJym7G02pJDOmnjy+V5O47o2FU8XX65qqSrWU5SRdykvd/yFdnmdbFf GwFG592RykLgxgXg6yYIkuQnXuci8fb9nD3uYowc1iZQIYwcHEKwERKdRl+sy3v2lnLecugkE82 qPyDK6OU9BPvf2cPyhhmG76/mBx+juF/suCtqrPMHdr5lzuPSE2O2LOv4vrzgl0nDmhvsvDgDyp gAwA=
X-Developer-Key: i=kees@kernel.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

The use of -ffreestanding is a leftover that is only needed for certain
versions of Clang. Adjust this to be Clang-only. A later patch will make
this a versioned check.

Signed-off-by: Kees Cook <kees@kernel.org>
---
Cc: Nathan Chancellor <nathan@kernel.org>
Cc: Nick Desaulniers <nick.desaulniers+lkml@gmail.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: x86@kernel.org
Cc: "H. Peter Anvin" <hpa@zytor.com>
---
 arch/x86/Makefile | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/x86/Makefile b/arch/x86/Makefile
index 5b773b34768d..d25ed25fb7d9 100644
--- a/arch/x86/Makefile
+++ b/arch/x86/Makefile
@@ -137,8 +137,10 @@ ifeq ($(CONFIG_X86_32),y)
         include $(srctree)/arch/x86/Makefile_32.cpu
         KBUILD_CFLAGS += $(cflags-y)
 
+    ifeq ($(CONFIG_CC_IS_CLANG),y)
         # temporary until string.h is fixed
         KBUILD_CFLAGS += -ffreestanding
+    endif
 
     ifeq ($(CONFIG_STACKPROTECTOR),y)
         ifeq ($(CONFIG_SMP),y)
-- 
2.34.1

