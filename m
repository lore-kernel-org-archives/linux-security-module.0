Received: from xavier.telenet-ops.be (xavier.telenet-ops.be [195.130.132.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 863371DE4F6
	for <linux-security-module@vger.kernel.org>; Tue,  7 Jan 2025 08:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.130.132.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736239146; cv=none; b=gjhBRvd7V3CDOw6vnrjeNazJKw6fbZiqd5wLEHsF79e5LSwREsM9aFcB17tq5stS8MBRTZHFDGzQtz1eeqlwgjxcEO463EU70qoz3VXXjUcN1xftjrldL22SqQeoV1GteQxXbZz6cfDw3FQZ3h2whd6CzihRRsLES4jWAgCheJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736239146; c=relaxed/simple;
	bh=PGUV0MlskUFt+1qqeHdTyI9j0Ottx9A7j6NgCTzY2Co=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=L5e2brcoCxH4UOdLgPvAYZzbQD2GdmV/J+DOaDuqPD88dfEkUjPqijZmuPbJPhFUcIAGIImQTXub/ArhpZdpg2AjDsFuCQk0ZrU6QZN+zk92C28l3Z4+s0oiyX9kDZjukDHgv0kv4Q4ErZyTjTvHO7/0fbDTgo8tuyl08zb92eo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be; spf=none smtp.mailfrom=linux-m68k.org; arc=none smtp.client-ip=195.130.132.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed80:39d4:dc4e:b4ce:1377])
	by xavier.telenet-ops.be with cmsmtp
	id y8ez2D00P3AZZFy018ezgV; Tue, 07 Jan 2025 09:39:00 +0100
Received: from rox.of.borg ([192.168.97.57])
	by ramsan.of.borg with esmtp (Exim 4.97)
	(envelope-from <geert@linux-m68k.org>)
	id 1tV572-00000008ZaZ-0akl;
	Tue, 07 Jan 2025 09:38:59 +0100
Received: from geert by rox.of.borg with local (Exim 4.97)
	(envelope-from <geert@linux-m68k.org>)
	id 1tV575-00000004lNY-2meS;
	Tue, 07 Jan 2025 09:38:59 +0100
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: Kees Cook <kees@kernel.org>,
	"Gustavo A . R . Silva" <gustavoars@kernel.org>,
	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E . Hallyn" <serge@hallyn.com>
Cc: linux-hardening@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] hardening: Document INIT_STACK_ALL_PATTERN behavior with GCC
Date: Tue,  7 Jan 2025 09:38:57 +0100
Message-ID: <293d29d6a0d1823165be97285c1bc73e90ee9db8.1736239070.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The help text for INIT_STACK_ALL_PATTERN documents the patterns used by
Clang, but lacks documentation for GCC.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 security/Kconfig.hardening | 1 +
 1 file changed, 1 insertion(+)

diff --git a/security/Kconfig.hardening b/security/Kconfig.hardening
index c9d5ca3d8d08de23..b56e001e0c6a9533 100644
--- a/security/Kconfig.hardening
+++ b/security/Kconfig.hardening
@@ -127,6 +127,7 @@ choice
 		  repeating for all types and padding except float and double
 		  which use 0xFF repeating (-NaN). Clang on 32-bit uses 0xFF
 		  repeating for all types and padding.
+		  GCC uses 0xFE repeating for all types, and zero for padding.
 
 	config INIT_STACK_ALL_ZERO
 		bool "zero-init everything (strongest and safest)"
-- 
2.43.0

