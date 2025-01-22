Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 303C319C56C;
	Wed, 22 Jan 2025 06:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737528948; cv=none; b=P2O0vDnhX8ELVE1MuLF+sTpvbP9s8xag/MVnStVJi7ab39Mgp2RNlvqFsT3h+iIAnBCvi1Cu20WeUIMxAuUwkxWPk4UAZtbHQNWLsx7H5e7AYIHVgpiCFydo7ya8mDL/hh++nuQvwTu6SS7JeyLg72duPNM4ofyFlGwHMjUMuYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737528948; c=relaxed/simple;
	bh=v2BTpHu6nyVgc4c3mvtmqGqywpf9dd4NWA3QvMWKDhI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=RDikQ2SQKCrz4GjNAnPJoZzev7vzr/YyCObYWa7H/lCvKaxUhsgutD0fbfXqD9J0359JsQby5FWCgn/SD+l8H+Iq22r2Bhwbr8j2cQP0xqaRaXCaqp4Jx3Y4UBYGj/nBfDJyTTb8Pw3SQqTeTImSMFLqkQPrfzfiY5Ub019cim0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rnZSVqXw; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rnZSVqXw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A4DAC4CEE2;
	Wed, 22 Jan 2025 06:55:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737528948;
	bh=v2BTpHu6nyVgc4c3mvtmqGqywpf9dd4NWA3QvMWKDhI=;
	h=From:To:Cc:Subject:Date:From;
	b=rnZSVqXwEDd46TiYzCwYpPM+mjCxSNL6DPhVqvIEwSjfsVZX1CXrr9v1ZF7Zr2bl7
	 VErHLx7GazMZCqK09x85OUdqIbqTBIbXiujjecUziwn+H1afP7/FG0f9awbsObpFP1
	 ZvnVVg/KtD+FhyHgqNwSjQQXUx98O84MIJOYIxvqkFwnMwKeAzLCOw5l6NlleUznkk
	 q6alfVR5y2oETGhl4Coe6mO9DW5Wdwvkvq1wP5hw0WqB7Xnmcha2BlVrDZyv83qdtG
	 8qrd28WTe0vP4ff+ZqQyoRqhXPhao4HwmO3qckN9vCYkWtTCV/3IRbugdQN7yKwwrR
	 QopSjWo0Kxzog==
From: Arnd Bergmann <arnd@kernel.org>
To: John Johansen <john.johansen@canonical.com>,
	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Colin Ian King <colin.i.king@gmail.com>,
	apparmor@lists.ubuntu.com,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] apparmor: remove unused variable
Date: Wed, 22 Jan 2025 07:55:35 +0100
Message-Id: <20250122065543.1515519-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

The local 'sock' variable has become unused after a change to the
aa_sock_file_perm() calling conventions:

security/apparmor/file.c: In function '__file_sock_perm':
security/apparmor/file.c:544:24: error: unused variable 'sock' [-Werror=unused-variable]
  544 |         struct socket *sock = (struct socket *) file->private_data;

Remove it here.

Fixes: c05e705812d1 ("apparmor: add fine grained af_unix mediation")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 security/apparmor/file.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/security/apparmor/file.c b/security/apparmor/file.c
index 85f89814af1e..e3a858649942 100644
--- a/security/apparmor/file.c
+++ b/security/apparmor/file.c
@@ -541,11 +541,8 @@ static int __file_sock_perm(const char *op, const struct cred *subj_cred,
 			    struct aa_label *flabel, struct file *file,
 			    u32 request, u32 denied)
 {
-	struct socket *sock = (struct socket *) file->private_data;
 	int error;
 
-	AA_BUG(!sock);
-
 	/* revalidation due to label out of date. No revocation at this time */
 	if (!denied && aa_label_is_subset(flabel, label))
 		return 0;
-- 
2.39.5

