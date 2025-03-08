Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AD88176242;
	Sat,  8 Mar 2025 04:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741408174; cv=none; b=Tby4mnFJYLhlPeI5f5gqVUoI2QMii8+/8QcONEX9Z8tcVoX2f9t/cEIQnjZu4K7QvUBGUB4AtFSnCicFrqdzdA0R4IbDWJfnD6YWtBbjHZL/pl3kCCNix65KvafwwxKfG7ghOUiKsBcUCIvLVIkBCKgwrq6vZnwaN3WkLhlp2bc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741408174; c=relaxed/simple;
	bh=50xuBK936/wlpPFLBa/DZAV+OQctfO5sy1dUe1kY/nY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=mlb63N4OnxnVbqaHm+Xfdxj1Kw59H1ouTk+c9gmx4w2uRDY1rVIgj7J7JpFnf3rUoxTNhahqrzk6xVWdKHnaTkYgQF5kDX68kqNmS72BxKFG49Ni3gnKT6J97WLPXB8ZCYIHQ3xrQvrw9r0p7ruoE4ILcQ411ZooZBCCm0raQ7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HJvja/Tc; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HJvja/Tc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CB07C4CEE4;
	Sat,  8 Mar 2025 04:29:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741408173;
	bh=50xuBK936/wlpPFLBa/DZAV+OQctfO5sy1dUe1kY/nY=;
	h=From:To:Cc:Subject:Date:From;
	b=HJvja/TcQtSS/G0OcBcsF/crh/AsJZYRWkHIXyRCcDesGcWcKKpg2J78Fe8McjthK
	 f1umCp4/ZDAUnjIsx+WW7/7K8stI4pmNaKjLuCUN9+q0xzvvrC7Z7/TnonP245NA5B
	 XmEhRECzElWBE+dRhTfP1EbczYC16juHp291f34b4yhmDQd5jBuPhLI4/I/0KatNyT
	 nvcZ6KkurpyBIvkISh8Eht1yI5bXU5nmRizqmj8ElcNpfb8TuBL2IDYTOvqL/yceBo
	 oMO3XI8czMvjOve+ttb+UvP/YlphliKJw+7B0apUb7as8La4q4f8ZVVBg4osGi74ed
	 wwh7wtu8b/4qQ==
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
Subject: [PATCH v2 0/2] hardening: Enable i386 FORTIFY_SOURCE on Clang 16+
Date: Fri,  7 Mar 2025 20:29:24 -0800
Message-Id: <20250308041950.it.402-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=737; i=kees@kernel.org; h=from:subject:message-id; bh=50xuBK936/wlpPFLBa/DZAV+OQctfO5sy1dUe1kY/nY=; b=owGbwMvMwCVmps19z/KJym7G02pJDOmnjy/9+GdOclH6d8efvedLtjkUsamJFFTMf/31j6gf3 /9jyxy0O0pZGMS4GGTFFFmC7NzjXDzetoe7z1WEmcPKBDKEgYtTACaSMIfhf/mia/OOpOuF+jLG 8Wsd9r1xJfJo5iQ+m8kvuvnW3pb/UcLwz3bSDubq42oTrt5V8LdTi2T1d+5LOSI4/faRK2ck207 sZQAA
X-Developer-Key: i=kees@kernel.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

Hi,

This drops -ffreestanding for i386 unconditionally for GCC, and on
Clang version 16 and later. FORTIFY_SOURCE depends on the libcall
optimizations made without -ffreestanding on Clang. On GCC, there is no
expected differences. With that done, it's possible to gain Clang
FORTIFY_SOURCE coverage on i386 again, though only for Clang 16+.

-Kees


 v1: https://lore.kernel.org/lkml/20250303214929.work.499-kees@kernel.org/
 v2: drop -ffreestanding (Nathan)

Kees Cook (2):
  x86/build: Remove -ffreestanding on i386 with GCC
  hardening: Enable i386 FORTIFY_SOURCE on Clang 16+

 arch/x86/Makefile          | 2 ++
 security/Kconfig.hardening | 2 +-
 2 files changed, 3 insertions(+), 1 deletion(-)

-- 
2.34.1

