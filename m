Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F6FE22B8CF;
	Sun, 26 Jan 2025 15:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737903910; cv=none; b=Me7hANabCjioMXX3t3AtUH4dr73Vpz2XffDGpTvIO1b5/niqhjt9VYbwIWMofl8FK+CXQB5HnoccJdYn/MAUX1P7zCh+Ga40aCdJ2rGICdYekE+dFaAk6TxB8nnWGF5r19llP3JI3/F5/vTRyFiVVjInabQp1KMESLxsZa6T2wM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737903910; c=relaxed/simple;
	bh=BoKVT25+FzNZDExRSFKExNoNJZeO5nsZ/vqkPeYVsCg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=npweapTrYdjyblnMVEw8nTb3Ae4e8OWgWm7ZVQKyL5ahWout+XaoUXEtxPfjlxo7xTeOknDl7GxN1gI3YIBmRp6fGkgektd9FVXYGEw/m5CC7lGSZTmaQGBRpbTYCgXnvleQzCVTB9LVXRbUIDG2N8V8u6AFhYPLAwKzPQVy/Go=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cgw+EAM6; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cgw+EAM6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 454F7C4CEE2;
	Sun, 26 Jan 2025 15:05:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737903910;
	bh=BoKVT25+FzNZDExRSFKExNoNJZeO5nsZ/vqkPeYVsCg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cgw+EAM6IEewmJjCBEFFh56iwjQAgEAwIQe9wMBAoVH+bzt2Z/nF629YhPZZpBdfE
	 gJx58g5H9g5v1yl6HRh12gmeGI07nTuqUcKGK379B9whJJ2g3QX6fHbIZrBXxtzSZz
	 5ivA/7T0Dz9tvp+fFf5xbsrteWVG+VxWDnHs+U+6WjlMgkBafztzAUMk9VJj9QsTTs
	 Y+mdQyCcSe+jvc1fW+bWwXh2PaoXxw/o/2qklePm98a3o6uwR3KcZrR1s6MPEYmr9o
	 SiPNoqIvDIHJqSLQxeA5/IfYBuVzWhZBZ6169/tYeffV1WqxshpJ20Q0Xz+uhNJ0QK
	 GOIbfc/ZYCCwQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
	syzbot+7536f77535e5210a5c76@syzkaller.appspotmail.com,
	Leo Stone <leocstone@gmail.com>,
	Sasha Levin <sashal@kernel.org>,
	takedakn@nttdata.co.jp,
	paul@paul-moore.com,
	jmorris@namei.org,
	serge@hallyn.com,
	linux-security-module@vger.kernel.org
Subject: [PATCH AUTOSEL 5.10 04/12] tomoyo: don't emit warning in tomoyo_write_control()
Date: Sun, 26 Jan 2025 10:04:52 -0500
Message-Id: <20250126150500.959521-4-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250126150500.959521-1-sashal@kernel.org>
References: <20250126150500.959521-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.233
Content-Transfer-Encoding: 8bit

From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>

[ Upstream commit 3df7546fc03b8f004eee0b9e3256369f7d096685 ]

syzbot is reporting too large allocation warning at tomoyo_write_control(),
for one can write a very very long line without new line character. To fix
this warning, I use __GFP_NOWARN rather than checking for KMALLOC_MAX_SIZE,
for practically a valid line should be always shorter than 32KB where the
"too small to fail" memory-allocation rule applies.

One might try to write a valid line that is longer than 32KB, but such
request will likely fail with -ENOMEM. Therefore, I feel that separately
returning -EINVAL when a line is longer than KMALLOC_MAX_SIZE is redundant.
There is no need to distinguish over-32KB and over-KMALLOC_MAX_SIZE.

Reported-by: syzbot+7536f77535e5210a5c76@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=7536f77535e5210a5c76
Reported-by: Leo Stone <leocstone@gmail.com>
Closes: https://lkml.kernel.org/r/20241216021459.178759-2-leocstone@gmail.com
Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 security/tomoyo/common.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/security/tomoyo/common.c b/security/tomoyo/common.c
index 6235c3be832aa..e23993c784405 100644
--- a/security/tomoyo/common.c
+++ b/security/tomoyo/common.c
@@ -2673,7 +2673,7 @@ ssize_t tomoyo_write_control(struct tomoyo_io_buffer *head,
 
 		if (head->w.avail >= head->writebuf_size - 1) {
 			const int len = head->writebuf_size * 2;
-			char *cp = kzalloc(len, GFP_NOFS);
+			char *cp = kzalloc(len, GFP_NOFS | __GFP_NOWARN);
 
 			if (!cp) {
 				error = -ENOMEM;
-- 
2.39.5

