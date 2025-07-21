Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6303E1AA7BF;
	Mon, 21 Jul 2025 23:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753139445; cv=none; b=mzhvQmc7/LQQrtKoEnOJIBgA3wohyILxhtLZ2zpeXrxHR8BqmHBp7rpSJSABzrNt5hqn9TSFcYdf/5jZM4K927QODs742EHkn1C+8AhsP8mc/ImZAC8ugfNUawiwUgFijdUYnwB8p88IKWSbom90/GBdoPQ8IvmRhk+yJmGOkFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753139445; c=relaxed/simple;
	bh=kneTeTFYKo+CWcirlkXTb2Istnakau89H07ZQXWG0YQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=p9rVrivjlbZGWnyI1twF8KPpeCgyF1QU8nDwWGct2DNXAOtgGsUne7TfAuMrsDFv+bYGSnqnhO3PrEbPgDXT0GhjAhEfVuiwy3fXTgw/fMrXGsQgyBWfmzhanvePn0xoSyiwvgKHnCKT/1dJQaqSyOzuf+X/jPhlsLPxRHU71cg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D4dE5iGs; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D4dE5iGs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBE8CC4CEED;
	Mon, 21 Jul 2025 23:10:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753139444;
	bh=kneTeTFYKo+CWcirlkXTb2Istnakau89H07ZQXWG0YQ=;
	h=Date:From:To:Cc:Subject:From;
	b=D4dE5iGsJI42UvzHKkLkkxBvAZNq+9cbKlomQNr1FN6ETAWUoICBB7lETktTW47+L
	 U70Tl7/eLDKGXnRCS/RiGxiVIp9usvTElrMJNuJhBbXPV2Vx5ZTFnX0KHHuI00Zhp/
	 VAQ+NWDKqby6fSzfD/ms74eCfp9CRrzrb/MoiJRi3TazozHAU5wgpv1W9x13klM54g
	 t2fEbCfq15+RcLm8TDTbSPEXwN+mTcfxkYfqa0sAggnlj4yMUTVlryxckiqSxr03+/
	 6osNckHm3ZmwX5nmPDfsNFdfuyQq5G+dBWpjAJvyYRePf47YncRylWRGrg6kvgNlaP
	 Gu8A2mHpjBLYA==
Date: Mon, 21 Jul 2025 16:10:41 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: John Johansen <john.johansen@canonical.com>
Cc: apparmor@lists.ubuntu.com, linux-security-module@vger.kernel.org,
	llvm@lists.linux.dev
Subject: -Wformat-invalid-specifier after 88fec3526e84 in -next
Message-ID: <20250721231041.GA1015606@ax162>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi John,

After commit 88fec3526e84 ("apparmor: make sure unix socket labeling is
correctly updated.") in -next, I am seeing some warnings from clang when
building arm64 allmodconfig with LTO enabled. This can be more simply
reproduced on top of defconfig:

  $ make -skj"$(nproc)" ARCH=arm64 LLVM=1 mrproper defconfig

  $ scripts/config \
      -d LTO_NONE \
      -e LTO_CLANG_THIN \
      -e SECURITY_APPARMOR \
      -e SECURITY_APPARMOR_DEBUG

  $ make -skj"$(nproc)" ARCH=arm64 LLVM=1 olddefconfig security/apparmor/lsm.o
  security/apparmor/lsm.c:1206:2: warning: invalid conversion specifier '0' [-Wformat-invalid-specifier]
   1206 |         AA_BUG(rcu_access_pointer(new_ctx->label));
        |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  security/apparmor/include/lib.h:56:3: note: expanded from macro 'AA_BUG'
     56 |                 AA_BUG_FMT((X), "" args);                                   \
        |                 ^~~~~~~~~~~~~~~~~~~~~~~~
  security/apparmor/include/lib.h:61:34: note: expanded from macro 'AA_BUG_FMT'
     61 |         WARN((X), "AppArmor WARN %s: (" #X "): " fmt, __func__, ##args)
        |                                         ^~
  <scratch space>:2:1144: note: expanded from here
      2 | "(({ typeof(*(new_ctx->label)) *__UNIQUE_ID_rcu1155 = (typeof(*(new_ctx->label)) *)({ do { __attribute__((__noreturn__)) extern void __compiletime_assert_1156(void) __attribute__((__error__(\"Unsupported access size for {READ,WRITE}_ONCE().\"))); ..."
  ...
  include/asm-generic/bug.h:134:29: note: expanded from macro 'WARN'
    134 |                 __WARN_printf(TAINT_WARN, format);                      \
        |                                           ^~~~~~
  include/asm-generic/bug.h:106:17: note: expanded from macro '__WARN_printf'
    106 |                 __warn_printk(arg);                                     \
        |                               ^~~

Ultimately, rcu_access_pointer() expands to __READ_ONCE(), which arm64
specifically defines for CONFIG_LTO using some inline asm expressions,
see commit e35123d83ee3 ("arm64: lto: Strengthen READ_ONCE() to acquire
when CONFIG_LTO=y"). Within those asm literals are % characters for the
asm templates, which are ultimately interpreted as format specifiers
when they get expanded by the preprocessors, hence the warning.

There is nothing technically wrong here, although if this were to ever
trigger, it would probably look quite ugly in the kernel log because of
how long the string literal expansion of __READ_ONCE would be. It is
possible to shut this warning up in a similar manner to the existing GCC
pragma if necessary but I was unsure if that would be preferred off bat,
hence just the report at first.

Cheers,
Nathan

diff --git a/include/linux/compiler-clang.h b/include/linux/compiler-clang.h
index 2e7c2c282f3a..9dfbc6dc8859 100644
--- a/include/linux/compiler-clang.h
+++ b/include/linux/compiler-clang.h
@@ -114,10 +114,10 @@
 #define __diag_str(s)		__diag_str1(s)
 #define __diag(s)		_Pragma(__diag_str(clang diagnostic s))
 
-#define __diag_clang_13(s)	__diag(s)
+#define __diag_clang_all(s)	__diag(s)
 
 #define __diag_ignore_all(option, comment) \
-	__diag_clang(13, ignore, option)
+	__diag_clang(all, ignore, option)
 
 /*
  * clang has horrible behavior with "g" or "rm" constraints for asm
diff --git a/security/apparmor/include/lib.h b/security/apparmor/include/lib.h
index 444197075fd6..7f2c649dc7dd 100644
--- a/security/apparmor/include/lib.h
+++ b/security/apparmor/include/lib.h
@@ -53,7 +53,11 @@ do {									\
 #define AA_BUG(X, args...)						    \
 	do {								    \
 		_Pragma("GCC diagnostic ignored \"-Wformat-zero-length\""); \
+		__diag_push();						    \
+		__diag_ignore(clang, all, "-Wformat-invalid-specifier",	    \
+			      "May be called with asm that has %");	    \
 		AA_BUG_FMT((X), "" args);				    \
+		__diag_pop();						    \
 		_Pragma("GCC diagnostic warning \"-Wformat-zero-length\""); \
 	} while (0)
 #ifdef CONFIG_SECURITY_APPARMOR_DEBUG_ASSERTS
