Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAF0231A07B;
	Wed, 11 Feb 2026 06:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770790930; cv=none; b=Vgks2yXZCdWfb4glU3LNXxUsTF/8fDZk0AtqwIgneO/7gDdyAd+4kcQiT2WcwwfR4+ILTfvRaY16/3Qs45qeJUZHVZZKXor7m4RgBuJcd+r2QMIFOt5M50t+OQmgIoOhp9JSQaM1IDrXRztvIGuw1gv9ufk+1r84p/sXozd1bRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770790930; c=relaxed/simple;
	bh=hoQGoRtOTClqVvAKmOCwgjf1WeJvo/dSejIuk7I6Bxc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Nt8FgCxPfeBtULbjLLzQ4twJC57/Ix6HbNzwISQA+GLv4UTQWCQ6E/GrUKNLVEkAQKQjn9Xlax1lbHry4g9hn9wPxNZFsO4cyB1qs++sVoiQacmM0XFlNWbrVdHPl48a/kIwiFsvXx/Q0XSTup2Ls1GI7jsqcZEKwPvk+LakdvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost (unknown [124.16.138.129])
	by APP-05 (Coremail) with SMTP id zQCowACHGw8HIIxp3b0KCA--.48696S2;
	Wed, 11 Feb 2026 14:21:59 +0800 (CST)
From: Chen Ni <nichen@iscas.ac.cn>
To: mic@digikod.net
Cc: gnoack@google.com,
	shuah@kernel.org,
	linux-security-module@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Chen Ni <nichen@iscas.ac.cn>
Subject: [PATCH] selftests/landlock: Remove duplicate include of stdio.h
Date: Wed, 11 Feb 2026 14:21:22 +0800
Message-Id: <20260211062122.2975127-1-nichen@iscas.ac.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowACHGw8HIIxp3b0KCA--.48696S2
X-Coremail-Antispam: 1UD129KBjvdXoW7Jw48Kry7Wr1fZw18Zr1UJrb_yoWxZFgEyw
	4I9rW7GF98AFy7AF4rX3ZxAF4Skw1UGrs7ZF1YgwnxtF9rAF45Ga1DAF15CF1Yg39xCa43
	XF1UJFZxGr9xKjkaLaAFLSUrUUUUbb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbsxFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr0_
	Cr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s
	0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xII
	jxv20xvE14v26r106r15McIj6I8E87Iv67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr
	1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxkF7I0En4kS14v26r12
	6r1DMxkIecxEwVAFwVW8AwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8Jw
	C20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAF
	wI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjx
	v20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2
	jsIE14v26r4j6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0x
	ZFpf9x0JU4uWJUUUUU=
X-CM-SenderInfo: xqlfxv3q6l2u1dvotugofq/

Remove duplicate inclusion of stdio.h in fs_bench.c to clean up
redundant code.

Signed-off-by: Chen Ni <nichen@iscas.ac.cn>
---
 tools/testing/selftests/landlock/fs_bench.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/testing/selftests/landlock/fs_bench.c b/tools/testing/selftests/landlock/fs_bench.c
index 733c1264e5fd..551cb615ad93 100644
--- a/tools/testing/selftests/landlock/fs_bench.c
+++ b/tools/testing/selftests/landlock/fs_bench.c
@@ -26,7 +26,6 @@
 #include <linux/prctl.h>
 #include <stdbool.h>
 #include <stdio.h>
-#include <stdio.h>
 #include <errno.h>
 #include <stdlib.h>
 #include <string.h>
-- 
2.25.1

