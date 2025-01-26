Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8C331FC0E8;
	Sun, 26 Jan 2025 14:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737903365; cv=none; b=BHTl9X5/sF9HUi2ZYxEv/ssqr9AHABznrolWNySRwYUb8os5zw14//XH/spO1iJ/Tr2FH3az9BopyLn0LjLycwFeIoVDlL7xDAgDY+KfI+DPkmzbHDXQHYz0eJDKo7wGTJZNi208V7fZXc6OaBMxQXTf7/TlZ1qI+zj8z1Rw8TY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737903365; c=relaxed/simple;
	bh=uPc4NVSveHI7GHriDuEDZNzg3746xNX8eV/7hKr234Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qi5f/midADd8oJ3wrxeEjoX85WA9EsiF5wDrg72GjWmu+xV1HnTnbhxjpSYP/G6OsmY2cLCBbNqLoeALxU/g1uAOqmNi0k68H0sWKMF0opWzXS+7Bjz3SOX+zFnsYyxFh06i27OhmeMrqXhg+/RII4kYHH93T+enu5vKAcnmwjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OAjWFkIv; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OAjWFkIv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0E2DC4CEE5;
	Sun, 26 Jan 2025 14:56:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737903364;
	bh=uPc4NVSveHI7GHriDuEDZNzg3746xNX8eV/7hKr234Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OAjWFkIvFqajG+bIJpHIkpDI07BpD7dJOZdLz2rWA0ADo9QVNznvS9xAogMci55OA
	 +mxX2W5VvIt7/CKj6ZEXoj0ggzvW1lekLnWaD9GLL5jjpgeIGtdU6Xho+UoiiOxGaH
	 q4tDM+Ax6w+9HiGMIU2LUQagBhHN4HbomMIAg8kVS/WFrtV/H4SNYQ4a/8hAUiWg58
	 X6uwPZ1BmH77HaVKsM2RNivwshNoqXNKRTObpCueMMRVIi/gYG2ePaDj8dW3YC+fgR
	 5wcahjJWawqeH+2BqyAyA/uUhSnMwIDr+3bW08yMrcQ75fVnrBexTHt0rZIcpLzlqr
	 Nk/YUjSDCth6A==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Leo Stone <leocstone@gmail.com>,
	syzbot+4eb7a741b3216020043a@syzkaller.appspotmail.com,
	Paul Moore <paul@paul-moore.com>,
	Sasha Levin <sashal@kernel.org>,
	mortonm@chromium.org,
	jmorris@namei.org,
	serge@hallyn.com,
	linux-security-module@vger.kernel.org
Subject: [PATCH AUTOSEL 6.12 28/31] safesetid: check size of policy writes
Date: Sun, 26 Jan 2025 09:54:44 -0500
Message-Id: <20250126145448.930220-28-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250126145448.930220-1-sashal@kernel.org>
References: <20250126145448.930220-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.11
Content-Transfer-Encoding: 8bit

From: Leo Stone <leocstone@gmail.com>

[ Upstream commit f09ff307c7299392f1c88f763299e24bc99811c7 ]

syzbot attempts to write a buffer with a large size to a sysfs entry
with writes handled by handle_policy_update(), triggering a warning
in kmalloc.

Check the size specified for write buffers before allocating.

Reported-by: syzbot+4eb7a741b3216020043a@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=4eb7a741b3216020043a
Signed-off-by: Leo Stone <leocstone@gmail.com>
[PM: subject tweak]
Signed-off-by: Paul Moore <paul@paul-moore.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 security/safesetid/securityfs.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/security/safesetid/securityfs.c b/security/safesetid/securityfs.c
index 25310468bcddf..8e1ffd70b18ab 100644
--- a/security/safesetid/securityfs.c
+++ b/security/safesetid/securityfs.c
@@ -143,6 +143,9 @@ static ssize_t handle_policy_update(struct file *file,
 	char *buf, *p, *end;
 	int err;
 
+	if (len >= KMALLOC_MAX_SIZE)
+		return -EINVAL;
+
 	pol = kmalloc(sizeof(struct setid_ruleset), GFP_KERNEL);
 	if (!pol)
 		return -ENOMEM;
-- 
2.39.5

