Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72FB31BE86E;
	Wed, 22 Jan 2025 06:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737529125; cv=none; b=o2PKkGRFOP69MuLxzfXLn5/mm6XT8+rc5QFMLSdKXwHhODW3igJD6y/8gP57n+4z+E38zaeYDeJecasIVgQhQkRTdjennFAEHynFQoJQqPRc1Q4oK03rv06V4ClA/13P0Jzx0AXWcPIFTLHi4PzVfY8HcLt/3guhma8m3sS/L+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737529125; c=relaxed/simple;
	bh=/BWg482/32yLa/F2GOFeA45trmAOSvMuE+6pliElF9g=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Z/xz+Z8ssffHZE+T7xCR7BouSDUuYjEw9Ol0+hsIsd4wzeWtsleC8tI95xTmGHbJ+B6dZaXnbHBq5QTyTTL1XCDRwnmwu1pdnAEpHO7d7hWtZVYVgLOis5YKqJareWivxjhXv9hov7YQwGv3SIR6fFeLsd4diN7Nr8rK9YJphp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tyhicks.com; spf=pass smtp.mailfrom=tyhicks.com; dkim=pass (2048-bit key) header.d=tyhicks.com header.i=@tyhicks.com header.b=XEmY7bGT; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=DH6osBHc; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tyhicks.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tyhicks.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tyhicks.com header.i=@tyhicks.com header.b="XEmY7bGT";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="DH6osBHc"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfout.stl.internal (Postfix) with ESMTP id 1167C114021C;
	Wed, 22 Jan 2025 01:58:42 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Wed, 22 Jan 2025 01:58:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tyhicks.com; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to; s=fm2; t=1737529121; x=1737615521; bh=wW4cEW5NMALaBB/A7MfuM
	9uCqP53wA6vJejF/8GwCaE=; b=XEmY7bGTS9yFTfA67s6UwgJg7UkOd3w2737z2
	d2ymweH693n6o0BQdACSX70OCts/4sLvNJqFH2IX/OxxVX94rCUYnARlpCVoi6x8
	ss5bQNglUsr1e2R1rA2rGN8/0L+GFIFckq8JLkrFeXuwf9wqek/CvwXs0WyIUMP+
	RDXp8V3QNZikfdo6I92q0Kr7Fq/HkVs/+J5jKc2acR4Fp+2ceb5/T/ok66/d+3KM
	bV8SmjELGPozDPzG3tHZ0/gXhKvwlDn2Nmjvn98112AXsgjpKkSBEI168Yekwi/2
	9+HfeBX0New8Ya3o2VpdnxL+ik16qaytvjvwr2gFRnDqbtLOQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1737529121; x=1737615521; bh=wW4cEW5NMALaBB/A7MfuM9uCqP53wA6vJej
	F/8GwCaE=; b=DH6osBHcXNcbi6tet5ZfE8ala2LqrQLJX2gb5Q6LMsxtaSw7cZR
	8rbRvog0GWiBfYFnyHtTD95AB+8blsUW9bfEfy48GR0ymSikqpKv8gW/0GTbH2IV
	uE9LKNcpwRCcYzyHYwgNm0FDK32VBlaEfzZhxnwN3IG2orx7+G5D90x15t16wS7q
	4PP/u2tCmGNdiczzlCQEiykv3xblOiBI3QmhPpQqzpRBsRnJ3rss5LfR73GEhnKd
	qNPUeFxyQ8RvQd4q37386mBzSCs7V0HfSnP+k86CZsghGomaaQ5qkjce1wPhdhQ+
	e6uJBS7g8xTorbAG+JZFtEmL3gAzRxQCqtw==
X-ME-Sender: <xms:IJeQZxfwzsM8mjdIdhbdGnN6wOQkn7S_CPhZuZIQQsMbV-tExsC9EA>
    <xme:IJeQZ_P_-tkmQNSUc_8XbQMx8LVVRy44rZ-J14MWLeIRnwe43NJYVudXpO9Y6EtDw
    a0t0ooPBYhV2DPUpHo>
X-ME-Received: <xmr:IJeQZ6ikN_eo6oMb-i8fzpfPfvs-6D4C41n9M2JRDx5I-G7rXrHfzsYNV2JBWGafpnjOKt0q-__tDg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudejfedguddttdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufffkffoggfgsedtkeertdertddtnecu
    hfhrohhmpefvhihlvghrucfjihgtkhhsuceotghouggvsehthihhihgtkhhsrdgtohhmqe
    enucggtffrrghtthgvrhhnpeejteetjedvfeelkedutdfgleegjedufeeigeefkeejheet
    vdeggfefffdvgedukeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrih
    hlfhhrohhmpegtohguvgesthihhhhitghkshdrtghomhdpnhgspghrtghpthhtohepledp
    mhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepfihufhgrnheskhgvrhhnvghlrdhorh
    hgpdhrtghpthhtohepphgruhhlsehprghulhdqmhhoohhrvgdrtghomhdprhgtphhtthho
    pehjmhhorhhrihhssehnrghmvghirdhorhhgpdhrtghpthhtohepshgvrhhgvgeshhgrlh
    hlhihnrdgtohhmpdhrtghpthhtohepuggvvhgvnhdruggvshgriheslhhinhhugidrmhhi
    tghrohhsohhfthdrtghomhdprhgtphhtthhopehshhihrghmshgrihhniheslhhinhhugi
    drmhhitghrohhsohhfthdrtghomhdprhgtphhtthhopehlihhnuhigqdhsvggtuhhrihht
    hidqmhhoughulhgvsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinh
    hugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheptgho
    uggvsehthihhihgtkhhsrdgtohhm
X-ME-Proxy: <xmx:IJeQZ693YwBRtr8k2uqOCx5T0vrAhxRIkDocV6qJWxnNaQwiCrgPZA>
    <xmx:IJeQZ9vzeNu746irNQZ-1ZEfLxhF1-vx2YB6wHDF_THr5bQp2AXPUA>
    <xmx:IJeQZ5EyYVa9LgmkFFG0ZlCSJFS7c_Z8T-c-QBA96xcI0IA9CRPVGQ>
    <xmx:IJeQZ0NfGunCDz5ejnuQNbJMGfpGhPk1D8zVPJ5aXQ5Q4P9EZb19oQ>
    <xmx:IZeQZzLikdiD2HxbsLZfpZf7snNBNcdQI6xNi208J9zrV3mPVqKgkXlf>
Feedback-ID: i78e14604:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 22 Jan 2025 01:58:39 -0500 (EST)
From: Tyler Hicks <code@tyhicks.com>
To: Fan Wu <wufan@kernel.org>
Cc: Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	Deven Bowers <deven.desai@linux.microsoft.com>,
	Shyam Saini <shyamsaini@linux.microsoft.com>,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] ipe: Search for the boot policy file in the source tree
Date: Wed, 22 Jan 2025 00:57:40 -0600
Message-Id: <20250122065740.545042-1-code@tyhicks.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Resolve CONFIG_IPE_BOOT_POLICY relative file paths in the source tree if
the file was not found within the object tree and is not an absolute path.

This fixes an IPE build failure that occurs when using an output directory,
such as with the `O=/tmp/build` make option, during a build with the
CONFIG_IPE_BOOT_POLICY option set to a path that's relative to the kernel
source tree. For example,

  $ grep CONFIG_IPE_BOOT_POLICY /tmp/build/.config
  CONFIG_IPE_BOOT_POLICY="ipe-boot-policy"
  $ touch ipe-boot-policy
  $ make O=/tmp/build
  make[1]: Entering directory '/tmp/build'
    GEN     Makefile
    UPD     include/config/kernel.release
    UPD     include/generated/utsrelease.h
    CALL    scripts/checksyscalls.sh
    CC      init/version.o
    AR      init/built-in.a
    CC      kernel/sys.o
    AR      kernel/built-in.a
    IPE_POL ipe-boot-policy
  An error occurred during policy conversion: : No such file or directory
  make[5]: *** [security/ipe/Makefile:14: security/ipe/boot_policy.c] Error 2
  make[4]: *** [scripts/Makefile.build:440: security/ipe] Error 2
  make[3]: *** [scripts/Makefile.build:440: security] Error 2
  make[2]: *** [Makefile:1989: .] Error 2
  make[1]: *** [Makefile:251: __sub-make] Error 2
  make[1]: Leaving directory '/tmp/build'
  make: *** [Makefile:251: __sub-make] Error 2

Fixes: ba199dc909a2 ("scripts: add boot policy generation program")
Cc: stable@vger.kernel.org
Signed-off-by: Tyler Hicks <code@tyhicks.com>
---
 security/ipe/Makefile | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/security/ipe/Makefile b/security/ipe/Makefile
index 2ffabfa63fe9..b54d7b7c9e6d 100644
--- a/security/ipe/Makefile
+++ b/security/ipe/Makefile
@@ -10,8 +10,10 @@ quiet_cmd_polgen = IPE_POL $(2)
 
 targets += boot_policy.c
 
-$(obj)/boot_policy.c: scripts/ipe/polgen/polgen $(CONFIG_IPE_BOOT_POLICY) FORCE
-	$(call if_changed,polgen,$(CONFIG_IPE_BOOT_POLICY))
+boot-pol := $(if $(wildcard $(CONFIG_IPE_BOOT_POLICY)),,$(srctree)/)$(CONFIG_IPE_BOOT_POLICY)
+
+$(obj)/boot_policy.c: scripts/ipe/polgen/polgen $(boot-pol) FORCE
+	$(call if_changed,polgen,$(boot-pol))
 
 obj-$(CONFIG_SECURITY_IPE) += \
 	boot_policy.o \
-- 
2.34.1

