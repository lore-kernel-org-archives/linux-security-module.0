Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1DED370ACE;
	Tue,  9 Jun 2026 23:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781048437; cv=none; b=NePIdc0MdxMw343bAj+Y4AIG9RBmG845L1EYdNQ9Jtp8UKYQeK5XkYqOIoadUbi5lHytupleCBBcK8P/gwt/PJjazs33/l2ap2OFl3vxjGb5fkt6lbf7pENA3kmC3/Qc4X4v8FUAmwTmCMkfa6GdWg1kS2PJySsklFRXzCU/54Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781048437; c=relaxed/simple;
	bh=cUPl6GbgtHpFAbSkmB2tZ0f6uqr9N/6A5bxVPT1xDF4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=u3zNgUr72HnmdkhuXa2wnfsG4Dc5VA4d+0Jt8EsgUBPY3wwGtrY5H4xRcTP8DGyxm+BJICIJOINbXvSJwV4/Gya+/7dTLVffbkDk30N5dJ9YIiRhgqFTGvJFLTglAcpQhDobMYAdrMyE2h3w5vSbN5dUk5rCZSVaDbbQvEoC3T0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jo25DLt8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jo25DLt8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FF901F00893;
	Tue,  9 Jun 2026 23:40:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781048436;
	bh=zWbtTasqHYZ22NTZEvHP2JSPQq6kl25q5C50kDsT+E4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=Jo25DLt8y/eYZGx0wVxq7hpF3pDLq+GnWrC0/AO0oUfdJjL9ndIfdKOcT4FBZx/5P
	 Z2tWoUIJPdOyfiKe2Kg9bTRRL6aK7ryLKnaJ69A4M6216UkUP7pvN7lvgDUq50MRYg
	 /1rzeVP2M62oMtjXZsIH7cm+nmEUuuULWhh4AZTGg/0csLMisbFoowh0pI2hVqexIp
	 jGwKY11YAMv8chHr6RmC/+12KP6fKFd3HoyD7Uweg9aQ7z/OzimqiStVy4QfII5CYq
	 6sDd/+XD1sjXTmpeaGzC33yqbz35gRFaIsn2o12RwX3kaQInYNdLtUevamI2Mhtb4B
	 oaOF3cMYwPJpg==
From: Nathan Chancellor <nathan@kernel.org>
To: Nicolas Schier <nsc@kernel.org>, Bill Wendling <morbo@google.com>, 
 Justin Stitt <justinstitt@google.com>, 
 Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, 
 Nathan Chancellor <nathan@kernel.org>
Cc: linux-kernel@vger.kernel.org, llvm@lists.linux.dev, 
 linux-kbuild@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <skhan@linuxfoundation.org>, linux-doc@vger.kernel.org, 
 Kees Cook <kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>, 
 linux-hardening@vger.kernel.org, linux-security-module@vger.kernel.org, 
 Rong Xu <xur@google.com>, Han Shen <shenhan@google.com>, 
 Russell King <linux@armlinux.org.uk>, Arnd Bergmann <arnd@arndb.de>, 
 linux-arm-kernel@lists.infradead.org, Paul Walmsley <pjw@kernel.org>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Alexandre Ghiti <alex@ghiti.fr>, linux-riscv@lists.infradead.org, 
 Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, 
 Ard Biesheuvel <ardb@kernel.org>, Peter Zijlstra <peterz@infradead.org>
In-Reply-To: <20260517-bump-minimum-supported-llvm-version-to-17-v2-0-b3b8cda46bdd@kernel.org>
References: <20260517-bump-minimum-supported-llvm-version-to-17-v2-0-b3b8cda46bdd@kernel.org>
Subject: Re: [PATCH v2 00/16] Bump minimum version of LLVM for building the
 kernel to 17.0.1
Message-Id: <178104773630.2704789.17858317658280322569.b4-ty@b4>
Date: Tue, 09 Jun 2026 16:28:56 -0700
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=3318; i=nathan@kernel.org;
 h=from:subject:message-id; bh=cUPl6GbgtHpFAbSkmB2tZ0f6uqr9N/6A5bxVPT1xDF4=;
 b=owGbwMvMwCUmm602sfCA1DTG02pJDFkaS3IPsivujN14IlVvd5DxTcUlU/e9+jdRk8kvq+dbf
 cHdx/90O0pZGMS4GGTFFFmqH6seNzScc5bxxqlJMHNYmUCGMHBxCsBEdr5mZNiTt59J7VTM/K2v
 O/fyv5M5fzHhZbORdoB/UO3ffVtuSXszMvwzu30mYUfBRMtKrwu9x/rrlisuX/pr+9lt+mEBEj8
 MOVkB
X-Developer-Key: i=nathan@kernel.org; a=openpgp;
 fpr=2437CB76E544CB6AB3D9DFD399739260CB6CB716

On Sun, 17 May 2026 13:05:03 -1000, Nathan Chancellor wrote:
> Bump minimum version of LLVM for building the kernel to 17.0.1
> 
> The current minimum version of LLVM for building the kernel is 15.0.0.
> However, there are two deficiencies compared to GCC that were fixed in
> LLVM 17 that are starting to become more noticeable.
> 
> The first was a bug in LLVM's scope checker [1], where all labels in a
> function were validated as potential targets of an asm goto statement,
> even if they were not listed in the asm goto statement as targets. This
> becomes particularly problematic when the cleanup attribute is used, as
> 
> [...]

Applied to

  https://git.kernel.org/pub/scm/linux/kernel/git/kbuild/linux.git kbuild-next

Thanks!

[01/16] kbuild: Bump minimum version of LLVM for building the kernel to 17.0.1
        https://git.kernel.org/kbuild/c/ce3267a39a92b
[02/16] security/Kconfig.hardening: Remove tautological condition from CC_HAS_ZERO_CALL_USED_REGS
        https://git.kernel.org/kbuild/c/813fe686e90b4
[03/16] security/Kconfig.hardening: Remove tautological condition from FORTIFY_SOURCE
        https://git.kernel.org/kbuild/c/8ad2017578c99
[04/16] security/Kconfig.hardening: Remove tautological condition from CC_HAS_RANDSTRUCT
        https://git.kernel.org/kbuild/c/9331258bc129a
[05/16] arch/Kconfig: Remove tautological conditions from HAS_LTO_CLANG
        https://git.kernel.org/kbuild/c/2189cb1a80f06
[06/16] arch/Kconfig: Remove tautological condition from AUTOFDO_CLANG
        https://git.kernel.org/kbuild/c/de0bf1e138fcd
[07/16] ARM: Drop tautological ld.lld conditions from ARCH_MULTI_V4{,T}
        https://git.kernel.org/kbuild/c/48d229b6a48ae
[08/16] riscv: Remove tautological condition from selection of ARCH_SUPPORTS_CFI
        https://git.kernel.org/kbuild/c/62c4af8689511
[09/16] riscv: Drop tautological condition from TOOLCHAIN_NEEDS_OLD_ISA_SPEC
        https://git.kernel.org/kbuild/c/7e279976cf2a2
[10/16] scripts/Makefile.warn: Drop -Wformat handling for clang < 16
        https://git.kernel.org/kbuild/c/2a35c63c6bc42
[11/16] x86/build: Drop unnecessary '-ffreestanding' addition to KBUILD_CFLAGS
        https://git.kernel.org/kbuild/c/7b3281fcb43c5
[12/16] x86/module: Revert "Deal with GOT based stack cookie load on Clang < 17"
        https://git.kernel.org/kbuild/c/12b7bf92bddd4
[13/16] x86/entry/vdso32: Remove conditional omission of '.cfi_offset eflags'
        https://git.kernel.org/kbuild/c/4e7af20d0d104
[14/16] kbuild: Remove check for broken scoping with clang < 17 in CC_HAS_ASM_GOTO_OUTPUT
        https://git.kernel.org/kbuild/c/f3de78cb19d12
[15/16] compiler-clang.h: Remove __cleanup -Wunused-variable workaround
        https://git.kernel.org/kbuild/c/c69eaa687667e
[16/16] compiler-clang.h: Drop explicit version number from "all" diagnostic macro
        https://git.kernel.org/kbuild/c/c919893eabb43

Please look out for regression or issue reports or other follow up
comments, as they may result in the patch/series getting dropped or
reverted. Patches applied to an "unstable" branch are accepted pending
wider testing in -next and any post-commit review; they will generally
be moved to the main branch in a week if no issues are found.

Best regards,
-- 
Cheers,
Nathan


