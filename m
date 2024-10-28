Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E6151D5CC5
	for <linux-security-module@vger.kernel.org>; Mon, 28 Oct 2024 12:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730118892; cv=none; b=OjO512oYfQtXoBEw82FzX+f3g8omWneVt5lMZlZTCMLVFQ27OzEUB4eMdZH6/gG481Gh1FgFJCkopQWRewPsUGGr5sC4ExZMf0C5IeW4aQ+2UPpmrti+z35+QJGS+UT8iFaUUUqNDjA7451X05V9T4WQ27unDeqSV4QRF4gcH7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730118892; c=relaxed/simple;
	bh=54620GN/b8tzXBU3NRajAw15Isqlyf4C7qPxGP7Pq/M=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=G4z8lLvmDsUvFdgqGCIafW6wrJuzehrq7TMU3eGOi5NSKdNntqjly/f0DHuiRf8x5OEOfmg7/7OqVlUN/pmGInM6mqe1POjqCFZV8QLzzsFzKqGObXA0PSmDgh/iS/nbke+jXUl4KtmzlvguGFGoNsZinqW1VkJksNJBYrTUD/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=AmydIm7Y; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="AmydIm7Y"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1730118886;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=MREqdIhMV696ufnyoHe89T22c4ii2X74R+5suzL/X8U=;
	b=AmydIm7Ypwe3nC3I/+piTl+Jlavhxf+BB9uIb5scDerBELhPUKMK4qxWEEYXwawXaeS3+K
	ROVi3t3mpejBh4vFbRLLVLfPWkPVd6oK6rLevZw2HgnFVh82GF3QoWoEuGsDkcrVE5RcEw
	FLkkbfGRITjGgur0ZkGWoKF1tim3UUY=
From: George Guo <dongtai.guo@linux.dev>
To: horms@kernel.org,
	paul@paul-moore.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	George Guo <guodongtai@kylinos.cn>
Subject: [PATCH net-next v2] netlabel: document doi_remove field of struct netlbl_calipso_ops
Date: Mon, 28 Oct 2024 20:34:35 +0800
Message-Id: <20241028123435.3495916-1-dongtai.guo@linux.dev>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: George Guo <guodongtai@kylinos.cn>

Add documentation of doi_remove field to Kernel doc for struct netlbl_calipso_ops.

Flagged by ./scripts/kernel-doc -none.

Signed-off-by: George Guo <guodongtai@kylinos.cn>
---
 include/net/netlabel.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/net/netlabel.h b/include/net/netlabel.h
index 529160f76cac..4afd934b1238 100644
--- a/include/net/netlabel.h
+++ b/include/net/netlabel.h
@@ -208,6 +208,7 @@ struct netlbl_lsm_secattr {
  * struct netlbl_calipso_ops - NetLabel CALIPSO operations
  * @doi_add: add a CALIPSO DOI
  * @doi_free: free a CALIPSO DOI
+ * @doi_remove: remove a CALIPSO DOI
  * @doi_getdef: returns a reference to a DOI
  * @doi_putdef: releases a reference of a DOI
  * @doi_walk: enumerate the DOI list
-- 
2.39.2

