Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F23237A498
	for <linux-security-module@vger.kernel.org>; Sat,  3 Oct 2026 02:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790995915; cv=none; b=frjHsgAIjXyg883jpMJ7S6STv0L4TdSS9cQyy/NeRlX0+sDVvq2IBug5VvyeF0acGHITmB3hrUuMDdunHnc7A2REcg2uVraRkG3lGGJpbu0GVeEgOJCc4RpDzFnKbOCvUKc3rSUAkiaC+s9p2tvhLlWYD+kIIxnV8cs9AgVp2DQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790995915; c=relaxed/simple;
	bh=kSM8ikHUl1CnSqOAhzV0MQKGmCtJYHR09abdLCo/gZk=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dHd1YtyOuDTos4AlkfPMwGTftDtBNm4h49yhzIPWM4FZGkTn67yd+OI8VnPfyDSufEHYd0sEH484C3gzEX+m8wmihVjB4ewd/OkYIIUqe09tHl44OS4NGAFzT9Dmj2tNWx8x5TNK45o0ANaGe5Q5X3x2EucOR57EO64QHgiDMj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z7V7Cfl0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z7V7Cfl0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 674641F0089C
	for <linux-security-module@vger.kernel.org>; Sat,  3 Oct 2026 02:51:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790995913;
	bh=vaNGFAcFTy61wB/V1mnRIIDXs30qUZnVoTQ5o9jmWE0=;
	h=From:To:Subject:Date:In-Reply-To:References;
	b=Z7V7Cfl0peMTYGDCKbJhri/z6MiUeDsAJ4h5HU2NroAh4KIs2M5VJQuic0BobFop6
	 0xXM8UtPpF6noCJUjYTSYbIjxpgTDXY5gu8zcuygyHCas3MN7MJbZMY0txE41lWWlM
	 ihZKbB3ChiVm96ctRt7eTmmNsE9sF0xN+snL4Winfys0hquxbNPvo04MEZVbwaYHI8
	 Iwb8eVHQPbva3WfDP6BfQnBlFCUIRwn1oMWhaFW3kQFRX6O6tO/1I2FAEMK+sbaFGk
	 t9TYpPNIDzXrGbfyd+Bz3fp8tUyTk+RSI/cOYJ3e2vklpLiwXyKQVoF+d+4z2m/3Bg
	 A159bAxDwfD1w==
From: Fan Wu <wufan@kernel.org>
To: linux-security-module@vger.kernel.org
Subject: [PATCH 6/6] ipe: update the project and test suite links
Date: Fri,  2 Oct 2026 19:51:35 -0700
Message-ID: <20261003025135.3666767-7-wufan@kernel.org>
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

IPE now has a project website at https://ipe-lsm.org/, and its
integration tests are maintained in the Integrity-Policy-Enforcement/ci
repository.

Point the admin guide to the website, and point the test suite link in
the developer documentation to the new repository.

Assisted-by: LLM
Signed-off-by: Fan Wu <wufan@kernel.org>
---
 Documentation/admin-guide/LSM/ipe.rst | 2 +-
 Documentation/security/ipe.rst        | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/admin-guide/LSM/ipe.rst b/Documentation/admin-guide/LSM/ipe.rst
index a756d8158531..978773a256e4 100644
--- a/Documentation/admin-guide/LSM/ipe.rst
+++ b/Documentation/admin-guide/LSM/ipe.rst
@@ -791,7 +791,7 @@ Allow execution of a specific fs-verity file
 Additional Information
 ----------------------
 
-- `Github Repository <https://github.com/microsoft/ipe>`_
+- `IPE website <https://ipe-lsm.org/>`_
 - :doc:`Developer and design docs for IPE </security/ipe>`
 
 FAQ
diff --git a/Documentation/security/ipe.rst b/Documentation/security/ipe.rst
index 5eb3e6265fbd..4490aed5918a 100644
--- a/Documentation/security/ipe.rst
+++ b/Documentation/security/ipe.rst
@@ -442,5 +442,5 @@ IPE has KUnit Tests for the policy parser. Recommended kunitconfig::
   CONFIG_SECURITY_IPE_KUNIT_TEST=y
 
 In addition, IPE has a python based integration
-`test suite <https://github.com/microsoft/ipe/tree/test-suite>`_ that
+`test suite <https://github.com/Integrity-Policy-Enforcement/ci>`_ that
 can test both user interfaces and enforcement functionalities.
-- 
2.55.0

