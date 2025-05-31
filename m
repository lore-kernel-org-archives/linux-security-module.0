Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70FEF23E344;
	Sat, 31 May 2025 15:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748704110; cv=none; b=gip54EOz1wUJRhVcN+IfgkVMi+hXXsdf6C19IYdsPYLCGkDWpp3YJWVpYHV/t6ljr2uo7ywjNXGUtQVtrbCmsXrW7eSMLn/jqRRB3qPzASgisg62tCmg8N2ZzlSxve69fmdGFS+U/ptvFjyswVfp/2sdnayaSiiKontr3+ZJ7WU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748704110; c=relaxed/simple;
	bh=zeCNSk/4KTUwlgpHWG41sxNyfJ5kt9EedTqhnme5Y+Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z7KE3dHj7IflzhQgE8AU7wsulBv7x93+rhglD9dWDyJERT2BdKGISUOxK9pqV03PYO5rJh5x5/2FQwxDm5ezZhAQdmq22bgBfL+lVY1lqLMEbn7X5YXNfQd7w/8guqBC+40vFbnUDu3RKfAkIsnYQzNIIiuCNp3EDEUZn2GoEIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UvE0RzRT; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UvE0RzRT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 801B4C4CEEE;
	Sat, 31 May 2025 15:08:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748704109;
	bh=zeCNSk/4KTUwlgpHWG41sxNyfJ5kt9EedTqhnme5Y+Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UvE0RzRTvjbxPlvj54q6DyE3S+GwS52MAc5RYxdBBs/xN4n93hFk7J0e2dHMN23Ul
	 Yu8IgHKfeeDZ0zb0syLXynyDId9My1VWCNivUStvkqDBtIHiONsnL2mTCwsZzqpADo
	 A9F3iHP2wDsC2GJ5GfKOPPI1PWMon1bdHOs0lXdeeXpfJcFe4hbxcf5hMk4WOnNYZC
	 BED9lvtLrL+L4oIPH7m63qpLrC0Uasaixb1wCEWATYHOg9Pwz9AOpJAJ/98IllsZPg
	 0V83pzNvdhXaLrwmapAUv20/Ge6YicRJpgkFfTtMY9GmOZmx/8cR5Ul98f5+suGmXn
	 XsRQ8lEb50OTQ==
From: deller@kernel.org
To: linux-kernel@vger.kernel.org,
	apparmor@lists.ubuntu.com,
	John Johansen <john.johansen@canonical.com>,
	linux-security-module@vger.kernel.org
Cc: Helge Deller <deller@gmx.de>
Subject: [PATCH 2/2] apparmor: Fix unaligned memory accesses in KUnit test
Date: Sat, 31 May 2025 17:08:22 +0200
Message-ID: <20250531150822.135803-3-deller@kernel.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20250531150822.135803-1-deller@kernel.org>
References: <20250531150822.135803-1-deller@kernel.org>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Helge Deller <deller@gmx.de>

The testcase triggers some unneccessary unaligned memory accesses on the
parisc architecture:
  Kernel: unaligned access to 0x12f28e27 in policy_unpack_test_init+0x180/0x374 (iir 0x0cdc1280)
  Kernel: unaligned access to 0x12f28e67 in policy_unpack_test_init+0x270/0x374 (iir 0x64dc00ce)

Use the existing helper functions put_unaligned_le32() and
put_unaligned_le16() to avoid such warnings on architectures which
prefer aligned memory accesses.

Signed-off-by: Helge Deller <deller@gmx.de>
---
 security/apparmor/policy_unpack_test.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/security/apparmor/policy_unpack_test.c b/security/apparmor/policy_unpack_test.c
index 5b2ba88ae9e2..cf18744dafe2 100644
--- a/security/apparmor/policy_unpack_test.c
+++ b/security/apparmor/policy_unpack_test.c
@@ -9,6 +9,8 @@
 #include "include/policy.h"
 #include "include/policy_unpack.h"
 
+#include <linux/unaligned.h>
+
 #define TEST_STRING_NAME "TEST_STRING"
 #define TEST_STRING_DATA "testing"
 #define TEST_STRING_BUF_OFFSET \
@@ -80,7 +82,7 @@ static struct aa_ext *build_aa_ext_struct(struct policy_unpack_fixture *puf,
 	*(buf + 1) = strlen(TEST_U32_NAME) + 1;
 	strscpy(buf + 3, TEST_U32_NAME, e->end - (void *)(buf + 3));
 	*(buf + 3 + strlen(TEST_U32_NAME) + 1) = AA_U32;
-	*((__le32 *)(buf + 3 + strlen(TEST_U32_NAME) + 2)) = cpu_to_le32(TEST_U32_DATA);
+	put_unaligned_le32(TEST_U32_DATA, buf + 3 + strlen(TEST_U32_NAME) + 2);
 
 	buf = e->start + TEST_NAMED_U64_BUF_OFFSET;
 	*buf = AA_NAME;
@@ -103,7 +105,7 @@ static struct aa_ext *build_aa_ext_struct(struct policy_unpack_fixture *puf,
 	*(buf + 1) = strlen(TEST_ARRAY_NAME) + 1;
 	strscpy(buf + 3, TEST_ARRAY_NAME, e->end - (void *)(buf + 3));
 	*(buf + 3 + strlen(TEST_ARRAY_NAME) + 1) = AA_ARRAY;
-	*((__le16 *)(buf + 3 + strlen(TEST_ARRAY_NAME) + 2)) = cpu_to_le16(TEST_ARRAY_SIZE);
+	put_unaligned_le16(TEST_ARRAY_SIZE, buf + 3 + strlen(TEST_ARRAY_NAME) + 2);
 
 	return e;
 }
-- 
2.47.0

