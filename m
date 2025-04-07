Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F2012550CE;
	Mon,  7 Apr 2025 21:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744060241; cv=none; b=VSX5s+LHk7p95W5H1hZAxVHGvZaUYejdehCV9xfzu1v7Xvn5sTdEe4pfz7e2onEpfqJf1DXISLnouvvEaEHfVcwSdZq7/LnK72vATSbz+gEZtc6W6Go5XMxl5KQpW9/RdpEdg6j73tFzPy+0jFF4AUPCB4aOgPMiTudy8tbQ9I4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744060241; c=relaxed/simple;
	bh=brpFVo8UvhI+dLDZkVYf5Q8wXfm0uRTbp38j5NZgP3E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=sgY2q3rbb3o8nWuikuVh+TendZDZK9Wxmlm7ynCQRJUIUkhkwGOo56Jpr57zfDMxf7EpgHSp0rYKaWC2/oA2+HLeP8+EPzMnjnIDW/RwzBKcKL+nnK3enWInK6F52sho7amrMo/saGKzuk8FCIfZbcM5PXv5Y9QNVpp1TyBo7s0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jv74tbaW; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jv74tbaW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE84FC4CEED;
	Mon,  7 Apr 2025 21:10:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744060240;
	bh=brpFVo8UvhI+dLDZkVYf5Q8wXfm0uRTbp38j5NZgP3E=;
	h=From:Date:Subject:To:Cc:From;
	b=Jv74tbaW1z9GlbmKwjUV0u8B8UcWwmKx90JyTHWha8Undg21FQgQZlUqC1PnWgard
	 hvgv5MDmOjCK1YgSj/aDbgUDsrCyMeKJsyEWzIjThaIvlBBSk95aqSvKyFWJbzzp55
	 X6Rx2IobOHpM1/0+dkyD4Lh1t/MitCn/0iQKF6njpsulHqHvQlOsVM6g1TII7Vc4kV
	 +pPDsP8mfDZlkVIiMQT4XYT8CsgVxKb1lhhav++rwT2/07+tDMcJheqSPT7wEdweP+
	 GGRBK1MGaW5vTMof7VQwwwAvsbaXStldI25Td/rH+tgdFIYiSnISs7c/zB41Bvx27X
	 IIBlxWvGK4/rw==
From: Mark Brown <broonie@kernel.org>
Date: Mon, 07 Apr 2025 21:57:32 +0100
Subject: [PATCH] gcc-plugins: Disable GCC plugins for compile test builds
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250407-kbuild-disable-gcc-plugins-v1-1-5d46ae583f5e@kernel.org>
X-B4-Tracking: v=1; b=H4sIADs89GcC/x3MSwqDMBAA0KvIrDswauunVyku8pnGwRAlg0UQ7
 27o8m3eCcpZWOFdnZD5JyprKqgfFbjZpMAovhgaal70pB4Xu0v06EWNjYzBOdziHiQpDj3VxnQ
 0OttCCbbMXzn++We6rhuXJoY4bAAAAA==
X-Change-ID: 20250407-kbuild-disable-gcc-plugins-8701aa609cb3
To: Linus Torvalds <torvalds@linux-foundation.org>, 
 Kees Cook <kees@kernel.org>, 
 =?utf-8?q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>, 
 =?utf-8?q?G=C3=BCnther_Noack?= <gnoack@google.com>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-hardening@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org, 
 Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.15-dev-c25d1
X-Developer-Signature: v=1; a=openpgp-sha256; l=2028; i=broonie@kernel.org;
 h=from:subject:message-id; bh=brpFVo8UvhI+dLDZkVYf5Q8wXfm0uRTbp38j5NZgP3E=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBn9D9NFa1CcYWHR9Jafm0V3+B0BSeBSppLOL80Eo13
 /5YKXmqJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZ/Q/TQAKCRAk1otyXVSH0FVlB/
 9bzbJ3wzNgGnwSOkcK0bI+lv9NfuUW1TYwntVoPd5trP2im1S0pkznBsxarhFp7KFhCigYv3oV1PK1
 skwMSW2P4lHUVETiN4CgpawF9G7gpGljTiyZd41ZR5Lq+5MUG4//lRJSPUNcY7Jd+V6iknh285jdYZ
 hsNMkwQYwq/7OamiB8djDkOKMXr/uBDEN/8+btNrvy7hWl8DLQl5RBUUPvqqaWp8zcf4nDamKNstce
 MXTcp6nPt0vF0HaY8D0vRaoaiEt6u6XL8UYFAnn8Wmtl129GdHzO3Geiy4NceIz1qK1lfVq/YEeKgX
 x29r3FWVa3t11pD0SjtdoU1TnksOE9
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

In current mainline x86_64 allmodconfig builds done with tuxmake GCC 13
and GCC 14 toolchains (which are Debian ones packaged up into containers)
generate ICEs in landlock:

Event                            | Plugins
PLUGIN_FINISH_TYPE               | randomize_layout_plugin
PLUGIN_FINISH_DECL               | randomize_layout_plugin
PLUGIN_ATTRIBUTES                | latent_entropy_plugin randomize_layout_plugin
PLUGIN_START_UNIT                | latent_entropy_plugin stackleak_plugin
PLUGIN_ALL_IPA_PASSES_START      | randomize_layout_plugin
/build/stage/linux/security/landlock/fs.c: In function ‘hook_file_ioctl_common’:
/build/stage/linux/security/landlock/fs.c:1745:61: internal compiler error: in c
ount_type_elements, at expr.cc:7075
 1745 |                         .u.op = &(struct lsm_ioctlop_audit) {
      |                                                             ^

Arnd bisected this to c56f649646ec ("landlock: Log mount-related
denials") but that commit is fairly obviously not really at fault here,
most likely this is an issue in the plugin.  Given how disruptive having
key configs like this failing let's disable the plugins for compile test
builds until a fix is found.

Suggested-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 scripts/gcc-plugins/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/scripts/gcc-plugins/Kconfig b/scripts/gcc-plugins/Kconfig
index e383cda05367..29b03c136165 100644
--- a/scripts/gcc-plugins/Kconfig
+++ b/scripts/gcc-plugins/Kconfig
@@ -7,6 +7,7 @@ config HAVE_GCC_PLUGINS
 
 menuconfig GCC_PLUGINS
 	bool "GCC plugins"
+	depends on !COMPILE_TEST
 	depends on HAVE_GCC_PLUGINS
 	depends on CC_IS_GCC
 	depends on $(success,test -e $(shell,$(CC) -print-file-name=plugin)/include/plugin-version.h)

---
base-commit: 0af2f6be1b4281385b618cb86ad946eded089ac8
change-id: 20250407-kbuild-disable-gcc-plugins-8701aa609cb3

Best regards,
-- 
Mark Brown <broonie@kernel.org>

