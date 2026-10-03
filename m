Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 088288635D
	for <linux-security-module@vger.kernel.org>; Sat,  3 Oct 2026 02:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790995914; cv=none; b=o1ya0Cl5Nj1cFOCPUvG36X65vsOJkQ9/l8aH4xx9oRQWjnJ1hkY8JeJS5aw/hYcPs0iqLmfTNYiJXZg3TUjvv50hsn2omXOdLrVNN8iw4j/7djfQ9sCjZp+0VblY8KQDmbMj+HPSJez1a/EjYJZ2RCK38DaYc9oSw/+HkP2DysI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790995914; c=relaxed/simple;
	bh=cuPbim2qCq7YmWMv3uq88NoCkYCKSbGnDZuUYvW8oao=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h4mWPP5j/ALUuiKXxit6IrYzsWQXctWA3OS2XlL9v1FjRDCMOKJxxm6xM+ulwW+C7BxoWUen8Z/F+lyu20Z18q4ss7PPcb2nMVA1MhPoAV/Iu+0hWrMlDoMtHLuox+IBa9KJEDwgVsxybWmHi8RGrrLq/raEf7pGEX1yTELV5ng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WDYz+k59; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WDYz+k59"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB2E61F00893
	for <linux-security-module@vger.kernel.org>; Sat,  3 Oct 2026 02:51:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790995912;
	bh=mFYNhUDKLUE1MmT21X/qIZu6wU+a91V7IPfSMdFZE8s=;
	h=From:To:Subject:Date:In-Reply-To:References;
	b=WDYz+k59CXKVeP9duVykefCcZ+novvKSK4+MJ/Qfr61rYP2PWPzayfL5SGWItSiXN
	 GEIKOJOBWxq86ytBWd5CiKry9Ao0FX+9mexzTBvh8X6HYZNiZQ3tFmE7Qse4Iy7GTD
	 HND1sx6HcueYMRVirva3IBfZKQdhfYeVXQ7fSPkKBYXgXSR6aC1Acn4jvw/vb/BNnz
	 7nSKXLbunXUTY+v4xUJtVKYil5n3EZp6OKYkiIRfN8VoIyWkHneChBPUbqkXRDnC6m
	 fsdVOIJhE48OF5eltnqRWtHO9ngFagETnYJ+TciMXDz3SvnH13+tAF3/84CJcsLcer
	 jHfnXN1RHCj1Q==
From: Fan Wu <wufan@kernel.org>
To: linux-security-module@vger.kernel.org
Subject: [PATCH 1/6] ipe: constify token_default()
Date: Fri,  2 Oct 2026 19:51:30 -0700
Message-ID: <20261003025135.3666767-2-wufan@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261003025135.3666767-1-wufan@kernel.org>
References: <20261003025135.3666767-1-wufan@kernel.org>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

token_default() does not modify its argument, so make it const.

Assisted-by: LLM
Signed-off-by: Fan Wu <wufan@kernel.org>
---
 security/ipe/policy_parser.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/security/ipe/policy_parser.c b/security/ipe/policy_parser.c
index 6fa5bebf8471..f1c05e53667f 100644
--- a/security/ipe/policy_parser.c
+++ b/security/ipe/policy_parser.c
@@ -201,7 +201,7 @@ static int parse_header(char *line, struct ipe_parsed_policy *p)
  * * %false	- The token is not "DEFAULT"
  * * %true	- The token is "DEFAULT"
  */
-static bool token_default(char *token)
+static bool token_default(const char *token)
 {
 	return !strcmp(token, "DEFAULT");
 }
-- 
2.55.0

