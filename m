Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8918B204096;
	Thu,  9 Oct 2025 15:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760024729; cv=none; b=sIHOzxePG4z8rOf/zLvSHdT+AHIFKOQXKY82r33N6xRYHSEMwe7M2yAq24EaXqqy7l8vutlMQwJMyTsLENlxtp4jNrsKA1nSKs6tPAW/T+zPrvas3DNfwMJyAfHKZ4XAgHHzOwIjYYOgfBwNKrAft6e6kex151XuC15oxz2t2rM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760024729; c=relaxed/simple;
	bh=INih87lrkNUaRNY1givnDmLLrDi+lAHVDzrnGVSMCbE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cTYeda32RSHdvabGoifOI0Af1YleaHoXJxgoa7C+kAuShP6xRc5pGQunLZMdCOXxn7sjUg+IMKsWLJC0bsKewRLrPWmd1gNeLm53kqMO0uG3NCpz0MqVDN0st1i1jZGrbL6QE9d93cxiDJg//6BFVHrnxLpSQCbcoEmOKlksquo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D5P2R1uh; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D5P2R1uh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDE00C4CEE7;
	Thu,  9 Oct 2025 15:45:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760024729;
	bh=INih87lrkNUaRNY1givnDmLLrDi+lAHVDzrnGVSMCbE=;
	h=From:To:Cc:Subject:Date:From;
	b=D5P2R1uhk85l4PfIvL8s1c4mpLI8It99bpfwp7Gm9dBgp2uWD3GtMm23QUmV2QPod
	 d8zj/Q1Hl1WOeL/wJj9aPO0nFXoiNPgUXoM/C240G6xU8z8cFwYElqqCuGJme3sAWn
	 mbqtX+atfVZb3v67p2EJEmCG7igyoNqs+lIOfNxsXtO+Bf8/ZTLkhdvJBHnhsUQKi8
	 hGLP6o7wYTQv4e+/0JYi/FWt7pi5OcsYKfI45sHr3j2nMZa1B0vzMtZ9jusdIKkB+F
	 kdXJSBa4lqIdih+lalT0m+e5O1S2oIdPAhgfRcIpv78HrnGmzhTDC0axOeA9NlkB65
	 4JJ4knHIQYscQ==
From: Borislav Petkov <bp@kernel.org>
To: Fan Wu <wufan@kernel.org>
Cc: Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	linux-security-module@vger.kernel.org,
	LKML <linux-kernel@vger.kernel.org>,
	"Borislav Petkov (AMD)" <bp@alien8.de>
Subject: [PATCH] ipe: Drop a duplicated CONFIG_ prefix in the ifdeffery
Date: Thu,  9 Oct 2025 17:45:25 +0200
Message-ID: <20251009154525.31932-1-bp@kernel.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Borislav Petkov (AMD)" <bp@alien8.de>

Looks like it got added by mistake, perhaps editor auto-completion
artifact. Drop it.

No functional changes.

Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
---
 security/ipe/hooks.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/security/ipe/hooks.c b/security/ipe/hooks.c
index d0323b81cd8f..42857c2ea2a5 100644
--- a/security/ipe/hooks.c
+++ b/security/ipe/hooks.c
@@ -311,4 +311,4 @@ int ipe_inode_setintegrity(const struct inode *inode,
 
 	return -EINVAL;
 }
-#endif /* CONFIG_CONFIG_IPE_PROP_FS_VERITY_BUILTIN_SIG */
+#endif /* CONFIG_IPE_PROP_FS_VERITY_BUILTIN_SIG */
-- 
2.51.0

