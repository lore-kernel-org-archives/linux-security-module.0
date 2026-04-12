Received: from beta.bencteux.fr (114.ip-51-178-41.eu [51.178.41.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3094F36A027
	for <linux-security-module@vger.kernel.org>; Sun, 12 Apr 2026 10:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.178.41.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775988520; cv=none; b=S8DDVCa7tkvi0lzmB8c2FsLBp4+nO8zhmcYaMo6jI49Fo7fdbX15XUivCiu6ZZqxnlyAuyu+sIT1EK3tiloMNZqAueE6OwrXvlZ6nYbyWAiVVHZ3lGYHyP4jRgVVRFtGyApsYl7fMtttNcCTGl+h+8prn/NE3Srw1fX7/T6irh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775988520; c=relaxed/simple;
	bh=Fw8pZuDVnoqT6yUTv9XTFYhqMAzV06r4HNTOcM0xeWw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tjnp3pMif1QcIZpES83QHehp0VA5v9a29QaYt3yQpAqdeRa6nLFxVCYEGolH+GwP211PF1qN4C7Op5yGr6+l/kCoYpyh3+nI/Lhz1SN+eBtbGQIsTCN7A6xJ3CCjMuxJ39fCKiT39JfioQtzKjKeCrqQtEQ2Xj1nyvS3ayvinD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bencteux.fr; spf=pass smtp.mailfrom=bencteux.fr; dkim=pass (1024-bit key) header.d=bencteux.fr header.i=@bencteux.fr header.b=cHlDoL+B; arc=none smtp.client-ip=51.178.41.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bencteux.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bencteux.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bencteux.fr header.i=@bencteux.fr header.b="cHlDoL+B"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=bencteux.fr; s=mail;
	t=1775988107; bh=Fw8pZuDVnoqT6yUTv9XTFYhqMAzV06r4HNTOcM0xeWw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cHlDoL+Byq0qANs2wfrD3HS1KivVSaoMBT5qGcOp8Kw5a4W9HSeweZ5zdD+I9VGkS
	 Bl0y6NcaAtnMbHRaBxDQeQstOA0zB8dCb/3TQ+i4+W0F5LEKfo3Od7M2dLfWShVD8B
	 s14Sp2niFrSY1v6zEi7eC1o4nMTXtG24KZflfXH0=
Received: from localhost (lfbn-idf3-1-911-123.w90-3.abo.wanadoo.fr [90.3.226.123])
	by beta.bencteux.fr (Postfix) with ESMTPSA id 288B34032B;
	Sun, 12 Apr 2026 12:01:47 +0200 (CEST)
From: Jeffrey Bencteux <jeff@bencteux.fr>
To: mic@digikod.net,
	gnoack@google.com,
	paul@paul-moore.com,
	jmorris@namei.org,
	serge@hallyn.com
Cc: linux-security-module@vger.kernel.org,
	jeff@bencteux.fr
Subject: [PATCH 1/5] selftests/landlock: fix return condition on create_directory
Date: Sun, 12 Apr 2026 11:50:40 +0200
Message-ID: <20260412095233.34306-2-jeff@bencteux.fr>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260412095233.34306-1-jeff@bencteux.fr>
References: <20260412095233.34306-1-jeff@bencteux.fr>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If path exists when calling create_directory() in tests, i-e. when
mkdir() return with EEXISTS, directory creation fails. This patch
fixes it by allowing create_directory to use eventual existing
directories.

Signed-off-by: Jeffrey Bencteux <jeff@bencteux.fr>
---
 tools/testing/selftests/landlock/fs_test.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/landlock/fs_test.c b/tools/testing/selftests/landlock/fs_test.c
index 968a91c927a4..e5898dc7e53e 100644
--- a/tools/testing/selftests/landlock/fs_test.c
+++ b/tools/testing/selftests/landlock/fs_test.c
@@ -218,8 +218,11 @@ static void mkdir_parents(struct __test_metadata *const _metadata,
 static void create_directory(struct __test_metadata *const _metadata,
 			     const char *const path)
 {
+	int err;
+
 	mkdir_parents(_metadata, path);
-	ASSERT_EQ(0, mkdir(path, 0700))
+	err = mkdir(path, 0700);
+	ASSERT_FALSE(err && errno != EEXIST)
 	{
 		TH_LOG("Failed to create directory \"%s\": %s", path,
 		       strerror(errno));

base-commit: 82544d36b1729153c8aeb179e84750f0c085d3b1
-- 
2.53.0

