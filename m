Received: from mail-dl2-f12.google.com (mail-dl2-f12.google.com [74.125.229.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DDD73B2FD4
	for <linux-security-module@vger.kernel.org>; Sun, 27 Sep 2026 16:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790526346; cv=none; b=iReirln+ehXafw3+fUcR/rjDe5c3Qb1q/EAuPTeSrQrvJ8Mov9btiQTUNZnhDok5++fXN3dgPziD/cL8zbYSQ3V41qzZGLqSyp4JIeWrMK0oR8IfFHR4zw3W7pBgHPWzyEMCLH45J86Bda6mLh1KxnIomlOk3UIdl+b1p0anv4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790526346; c=relaxed/simple;
	bh=p8H/veHYTzpsvpAbzEQ0MMeP9P0nDzZxFLy3CSDNRPA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DJ981hBAlaQYmFq9SEDcjsQ713+YTa9Hc5dWXuNhx3BIl1DZXDPvQcvfy55oCH2ZK+wWA3mOOxPmstg8dB0I+E7gYbD6vQguYAvRg+6Nw2IAfIRhKWA3qnpl33ZIfnWdav/phUlAhKxIK1+h4X/ZrYgJaqiybeZEoVu8m4pT3Pk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qwLWIL4h; arc=none smtp.client-ip=74.125.229.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qwLWIL4h"
Received: by mail-dl2-f12.google.com with SMTP id a92af1059eb24-141a5cf1371so129936c88.2
        for <linux-security-module@vger.kernel.org>; Sun, 27 Sep 2026 09:25:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790526344; x=1791131144; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=3ouNoglngZNElMele84FQctp5cVfzFDP+DtrEx06OLo=;
        b=qwLWIL4hPn41jCZCWLGzqaDxy73pDKAiiY/ASdnRuPiR1IyWL4mST/FU1Xvq7gNeoq
         k7FDA5zcfTjgAox3c0uFPsGQDZR6YIsjL8H298zSAVrt9SeQUKIkhYbBX+QGXL+w4A30
         fePvGKhNgaWaKJqVXqyAacDHPUJkoWHQc8+E90l646ttw9WvBOfbm+zdlu/jd4tjOLGZ
         TcFiIVX5v6iNn+Z9AcUHRfaT95iMvIHfCCE992elCp9msi8WtgncWQGLIMfimZRKCjTF
         gafR+mZvtWNFMJhuRDtF/FsrEmNwrLHu0Jq/Z1gb4SqWw3kCDDHJExEF5S1fNn0V49O0
         7lyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790526344; x=1791131144;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3ouNoglngZNElMele84FQctp5cVfzFDP+DtrEx06OLo=;
        b=Cz2FlobfEhQZx9DptIg3XPYB0YLftjM3CLC38hLoIYHJn8MFcCcnfZiKSt6lYjU8tA
         65RwRJAmtm+bUBjOm9RLKdq6OdvjonZJmXSZT2xYzYQEQvjd1V3FfG9oI4xasZdNcHOU
         uqvnOnlzJfZGgOjmZlDLZvAVWyFtBaynJTUT05MlR7UuaEtJjdfsl2M+d9H/92ZbhqHh
         pfxVjq4lJlyStjZ9To9D5+b3whSghQthCoeBqN2m9jQmcW0yisstyrN4ITsEXPVujXdf
         7u9rlr34tYGk6xmu8hH8QutYEw6QIvqDWZpOKfzX1gwsfQ2YKp07xBZ8GrSC/GJFMy1x
         n4Xg==
X-Forwarded-Encrypted: i=1; AKwUvBxppAwlxx9tiAqPUxu8b0EZZhKAxvonuRLl2C2MqsdVkSgy1pYfrX2Na2R2kX01CmgBzbG1zxk+uLot9xojunVlrMZAWQ4=@vger.kernel.org
X-Gm-Message-State: AFuF++mvg/F2On3GztTt2jy47GwNeDCYZp/yi2emGyAfFyA+BT1Vk2d+
	ymwHqGAl7yGt/eXdn00zZ8Wo5ur8swSvyPohW+7AMqzGRGDhmGSd+V3y
X-Gm-Gg: AYBFou0oS7O+cY97qjWoVbKpqshfJ6XqQ1VVR6Pi8gXKzEbHxlqJW1HeOXaWn0gk+r4
	KdoQcatW0TenB4WDEJ2/apVllqyOU/6Ysv3icJXnPO4DDpe/Fls4DdBDmZumsKcEDUju1OfKq5z
	pbdBiclwWr82ilSa745h+reC7ru1EI06aoDfDper1KEGgL3vcaR7p+hwn8xN7diVKnTFA9BRmKY
	SSElOxdXI6YtwcSGHjjidLF2eG36/yaEYKwHk0jRFyNsGgzdbngHktq20YnhlIrlLLuIeKCmOIg
	cgK0hDRyTn3Y3jDQahYDC1R6Z1aLHNIb82hQcADrHo5Ag2D2DvEYjJbc+po461+Kzrx9rNzx9zG
	DeUv4YyCinQ6Bwn7Ndg+GICO+foU1QP3k9OIO25gx+FHKO736Fddk+c0HnFSzIJteqQs2jedJJ2
	lR+hmZk+J3cc9NMlhnlU6pbiqk/wwEEj/0VOARInXPKjWR7emcyrJwF4sbjhWIUdtIekQvvzck5
	1tEO+FmOjQIkcsDKqvnEunKveDeyM/ZVySHZNGgSozQfUubfe2HQ4eqXa9h5jnGZPnlDTuM7O1t
	EQCqQg==
X-Received: by 2002:a05:701b:4542:20b0:139:81c6:67a1 with SMTP id a92af1059eb24-146cf7ee6efmr10726441c88.1.1790526344154;
        Sun, 27 Sep 2026 09:25:44 -0700 (PDT)
Received: from localhost.localdomain (95.169.12.199.16clouds.com. [95.169.12.199])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-145a7318afcsm18498575c88.0.2026.09.27.09.25.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Sep 2026 09:25:43 -0700 (PDT)
From: Chengfeng Ye <nicoyip.dev@gmail.com>
To: David Howells <dhowells@redhat.com>,
	Jarkko Sakkinen <jarkko@kernel.org>
Cc: Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E . Hallyn" <serge@hallyn.com>,
	keyrings@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Chengfeng Ye <nicoyip.dev@gmail.com>
Subject: [PATCH v3 0/2] keys: Fix ownership lifetime and accounting races
Date: Mon, 28 Sep 2026 00:25:26 +0800
Message-ID: <20260927162528.943886-1-nicoyip.dev@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series splits the previous bundled fix into two logical changes,
as requested by Jarkko.

Patch 1 protects key_user lifetime while key->user is replaced. It covers
namespace filtering, quota reservation and instantiated-key count updates,
with explicit locking at the affected access sites.

Patch 2 depends on patch 1 and extends the same critical sections so that
quota and instantiated-key accounting move together with ownership.
Notifications and reference release remain outside the spinlock.

The combined code change is identical to v2 applied to the current base.
Patch 1 fixes the lifetime race; the existing accounting races remain until
patch 2 is applied. Each commit has its own explanation and interleaving.

Changes in v3:
- Split v2 into a lifetime fix and an accounting-serialization fix.
- Rebase onto fd179f8a05be (current mainline at preparation time).
- Include a short, explicitly historical instrumented KASAN excerpt in
  patch 1, and add stable trailers for these long-standing bugs.
- Keep explicit lock acquisition at each reader; no locking accessor.

Validation:
- Built the four affected objects after each patch.
- Built the full x86_64 kernel after applying both patches, with KEYS,
  PROC_FS, USER_NS, WATCH_QUEUE and KEY_NOTIFICATIONS enabled.
- Both patches pass checkpatch --strict without errors or warnings.

Previous version:
https://lore.kernel.org/r/20260904080940.575882-1-nicoyip.dev@gmail.com/
Reviewer request:
https://lore.kernel.org/r/aqHhZO0GjMTOer4j@kernel.org/

Chengfeng Ye (2):
  keys: Protect key_user lifetime during ownership changes
  keys: Serialize ownership transfers with key accounting

 security/keys/key.c     | 13 +++++++++++--
 security/keys/keyctl.c  |  4 ++++
 security/keys/keyring.c |  7 ++++++-
 security/keys/proc.c    | 15 +++++++++++++--
 4 files changed, 34 insertions(+), 5 deletions(-)


base-commit: fd179f8a05be3ccae366b9b96e176b51fbe54aab
-- 
2.43.0

