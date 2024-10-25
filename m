Received: from out-179.mta1.migadu.com (out-179.mta1.migadu.com [95.215.58.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 967321B0F1C
	for <linux-security-module@vger.kernel.org>; Fri, 25 Oct 2024 06:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729838453; cv=none; b=apPngpQdH3Rj7WeCIhNLaMy2CFb3/M6IzKq3GDGGacgqV6kEkSU8M7giC5SAdO/eoFSBqSJiPIoRsauzo+VUT9iJ0vm6elgEY/bOJiqf4XLiZ7yQe8mJVe/i+SlapEBFcIf1zA2rUPUCs6nQb5i7C5BeKGIYY6J764T2cLQuHmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729838453; c=relaxed/simple;
	bh=tux+kVXoxeqatZsSvhUcOundmYXP9bd2WCJpZ0y15bQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GSL0yUKm+oOcgKHwIHx06aaMbHXN1AXkFlV7qZ4loZFQhy0Rg1mRHr+0FvYAgvO0BtzY6hSExIPMYqTnenkDy8YpOasSWyu1rHNNHraX1b/ltzf9UTx5IEOks+jYBYg0PHDzRXaq4QgFh9PQzTv1k4ayobueD1twXvIalMXVl2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=X5tHcEWB; arc=none smtp.client-ip=95.215.58.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="X5tHcEWB"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1729838443;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=utWPae6JOH6Gfwt6/OMxC57uOc92cN39G9Jp3wctaGM=;
	b=X5tHcEWB8OdWSIIyQT+3QxldtX7NRuHMzh+qXnCQ9ncWmoejFFWDWhAXbsNW2Ar2F68uVp
	9Itqwi9IJs8ODBkR9ziKTO11Gfa+I6ya2kVPkcIhzasoHxgWMnakw/TO2cp467Ho0h55Yn
	+sCAcKwHPCQA47e4imk7BAXHiNS+U5w=
From: George Guo <dongtai.guo@linux.dev>
To: pabeni@redhat.com
Cc: davem@davemloft.net,
	dongtai.guo@linux.dev,
	edumazet@google.com,
	guodongtai@kylinos.cn,
	kuba@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	netdev@vger.kernel.org,
	paul@paul-moore.com
Subject: [PATCH 1/1] add comment for doi_remove in struct netlbl_lsm_secattr
Date: Fri, 25 Oct 2024 14:40:31 +0800
Message-Id: <20241025064031.994215-1-dongtai.guo@linux.dev>
In-Reply-To: <0667f18b-2228-4201-9da7-0e3536bae321@redhat.com>
References: <0667f18b-2228-4201-9da7-0e3536bae321@redhat.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: George Guo <guodongtai@kylinos.cn>

---
 include/net/netlabel.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/net/netlabel.h b/include/net/netlabel.h
index 48106f910139..7091c8552fa1 100644
--- a/include/net/netlabel.h
+++ b/include/net/netlabel.h
@@ -209,6 +209,7 @@ struct netlbl_lsm_secattr {
  * struct netlbl_calipso_ops - NetLabel CALIPSO operations
  * @doi_add: add a CALIPSO DOI
  * @doi_free: free a CALIPSO DOI
+ * @doi_remove: remove a CALIPSO DOI
  * @doi_getdef: returns a reference to a DOI
  * @doi_putdef: releases a reference of a DOI
  * @doi_walk: enumerate the DOI list
-- 
2.34.1

