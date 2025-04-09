Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F34225DAFC;
	Wed,  9 Apr 2025 15:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744211526; cv=none; b=E/VrrWM3UalNazvWnBbrS94SjDEROsupXbMFRCle8c9h79uPtGl1EQ56Qb44wW6WIz0oPtpujsEkF/8EcnL/h6k4BWp0EUwxRpwi2nNs/9ietIQEp0379pQop7Qb1GUEma3bLx4qqpBotsM8xN1W8czYOj+j9mgzT1cL8Z1vr60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744211526; c=relaxed/simple;
	bh=V9QuYbvBT5ghNE+9yNY1nau6WUkN8UbS/ahNkHmcztE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=KmfBTT+iPHEHmJiSvj5FQsj9g91Rci5Gjmvq5GmJQNXULK5NYI4oKrYL4Ay29pUdckwZUIMU+i5sQij0z+m9Z5nl8djQtccimo+e1s+OHB1rHCw8xggm4sykJoQOCFUVoEM1/v93hMFpKXW2FuH9tM3nN1vUaEPcP8l9L9qjNIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fUlciLw6; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fUlciLw6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88812C4CEE2;
	Wed,  9 Apr 2025 15:12:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744211525;
	bh=V9QuYbvBT5ghNE+9yNY1nau6WUkN8UbS/ahNkHmcztE=;
	h=From:To:Cc:Subject:Date:From;
	b=fUlciLw6EEtNwdC5sNo6FVFrvfsgc0ISvdpDykm0/QvlpZnC6qs40WTbaxwR90kJv
	 foVcsjlQ2BX1HKVWHO/SVtG7XKOMirKHTLmAwyeHXPKcTB8Zw/K5QePEPQCl9CqOvN
	 tdQ3i3MRlHoOJTnPP7+/wJCcCX5hFQNzFIXrI223analUDecLxCfhvYT3F08L3Ucgw
	 GSFgXImNPYeWTa2GqDzKIs+KpvOEwGxI5vECmQnCUYnCFoypD7XNqxxXFe2NDFeQT3
	 wvoe17Ta4MFkaqMwM7tnCbM12pIpflcgql44+LhJextOLb2VfJ4ba1YkaVPfnrDZq4
	 O6v1BS/mZL1KA==
From: Kees Cook <kees@kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Kees Cook <kees@kernel.org>,
	Mark Brown <broonie@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	linux-hardening@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] hardening: Disable GCC randstruct for COMPILE_TEST
Date: Wed,  9 Apr 2025 08:11:58 -0700
Message-Id: <20250409151154.work.872-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1392; i=kees@kernel.org; h=from:subject:message-id; bh=V9QuYbvBT5ghNE+9yNY1nau6WUkN8UbS/ahNkHmcztE=; b=owGbwMvMwCVmps19z/KJym7G02pJDOnf+uwet/+4NUHquhfDu+dL1vKkWZ/xZ78rfaot93OIo Ygqc6d6RykLgxgXg6yYIkuQnXuci8fb9nD3uYowc1iZQIYwcHEKwEQEDzD8r9v+trQ57IEgk69U 3qUSmy32vyYUBt3JCt65NHuvYunJIwz/lI+9n17oo8w9rVD7TNJrrr03kl099/os3JZekGuXOkW YGwA=
X-Developer-Key: i=kees@kernel.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

There is a GCC crash bug in the randstruct for latest GCC versions that
is being tickled by landlock[1]. Temporarily disable GCC randstruct for
COMPILE_TEST builds to unbreak CI systems for the coming -rc2. This can
be restored once the bug is fixed.

Suggested-by: Mark Brown <broonie@kernel.org>
Link: https://lore.kernel.org/all/20250407-kbuild-disable-gcc-plugins-v1-1-5d46ae583f5e@kernel.org/ [1]
Signed-off-by: Kees Cook <kees@kernel.org>
---
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: Paul Moore <paul@paul-moore.com>
Cc: James Morris <jmorris@namei.org>
Cc: "Serge E. Hallyn" <serge@hallyn.com>
Cc: linux-hardening@vger.kernel.org
Cc: linux-security-module@vger.kernel.org
---
 security/Kconfig.hardening | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/security/Kconfig.hardening b/security/Kconfig.hardening
index c17366ce8224..3fe9d7b945c4 100644
--- a/security/Kconfig.hardening
+++ b/security/Kconfig.hardening
@@ -344,7 +344,7 @@ config CC_HAS_RANDSTRUCT
 
 choice
 	prompt "Randomize layout of sensitive kernel structures"
-	default RANDSTRUCT_FULL if COMPILE_TEST && (GCC_PLUGINS || CC_HAS_RANDSTRUCT)
+	default RANDSTRUCT_FULL if COMPILE_TEST && CC_HAS_RANDSTRUCT
 	default RANDSTRUCT_NONE
 	help
 	  If you enable this, the layouts of structures that are entirely
-- 
2.34.1

