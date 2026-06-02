Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3DE93655D1
	for <linux-security-module@vger.kernel.org>; Tue,  2 Jun 2026 20:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780431825; cv=none; b=fE0rCcivbEBY2FcJO/rAp3HWee6GtXNHtkS/N5iQBbEZV5xVdoFb+tZm/GXicuElBMs7/YPZUrkMVbdiuT2b3icSrXYcd9eW14fkqzIsQnxQ046YpZQkyrVB2pNylqbm1I2aYA+NBUIG+/a2cZFZ824JjAn3EVDvSIdAW/a3GIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780431825; c=relaxed/simple;
	bh=hwmRFYmS9rH7Y8oG0D6dZZyCeGr0Sq+ZxBhesepvngA=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZSLx6HR13NSFns4Y7zOE6LdEpFkxryDeXvR2jEMrm/ldYAvOtQjARC5n4fxAcLexpWTzW2JxDYpsCUPm6Yw9sGOwW5New9qoUezxviIuWGNfZ+1saFuc1hmk3wFE56QUBy13zfnIGz3gfDvGe/yLzfj7Y+SHUi25jxOSAU6HOKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=kIzREkc/; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="kIzREkc/"
Received: from narnia.corp.microsoft.com (unknown [40.78.13.173])
	by linux.microsoft.com (Postfix) with ESMTPSA id 87C3020B7169;
	Tue,  2 Jun 2026 13:23:29 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 87C3020B7169
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1780431809;
	bh=hHvJwYEBBPvMQRsdXYX8BY5UUJqza1KXfucOXv8xBf8=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=kIzREkc/1/9A28KoB9cISkEAKnUC23JRCWaTFyj4nmPY54XyiexQ3tBMHEXJLNA4k
	 sCinq9Py2BwILNUuwDZ8nzdmuDr7rffySIY6/ylH5EMmxD/OeMF+xx2XOQ4UtWUuxJ
	 EXT9IDbWdytzlOxGbj7MWw4zflBQaP0IYU5lVWCU=
From: Blaise Boscaccy <bboscaccy@linux.microsoft.com>
To: "Paul Moore" <paul@paul-moore.com>,
	"Fan Wu" <wufan@kernel.org>,
	"Blaise Boscaccy" <bboscaccy@linux.microsoft.com>,
	linux-security-module@vger.kernel.org
Subject: [PATCH 1/3] hornet: log map hash check failures in prog map validation
Date: Tue,  2 Jun 2026 13:23:20 -0700
Message-ID: <20260602202336.3579863-2-bboscaccy@linux.microsoft.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260602202336.3579863-1-bboscaccy@linux.microsoft.com>
References: <20260602202336.3579863-1-bboscaccy@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a pr_notice() before returning -EPERM when
hornet_check_prog_maps() fails to find a matching map hash.

This makes policy denials observable in kernel logs and improves
triage/debuggability of rejected BPF program loads without changing
enforcement behavior.

Signed-off-by: Blaise Boscaccy <bboscaccy@linux.microsoft.com>
---
 security/hornet/hornet_lsm.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/security/hornet/hornet_lsm.c b/security/hornet/hornet_lsm.c
index eeb422db1092d..fe133a0e8a11a 100644
--- a/security/hornet/hornet_lsm.c
+++ b/security/hornet/hornet_lsm.c
@@ -221,6 +221,7 @@ static int hornet_check_prog_maps(struct bpf_prog *prog)
 		}
 		if (!found) {
 			mutex_unlock(&prog->aux->used_maps_mutex);
+			pr_notice("hornet: map hash check failed");
 			return -EPERM;
 		}
 	}
-- 
2.53.0

