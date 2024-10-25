Received: from out-171.mta1.migadu.com (out-171.mta1.migadu.com [95.215.58.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C7D81B3940
	for <linux-security-module@vger.kernel.org>; Fri, 25 Oct 2024 06:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729839307; cv=none; b=VDr8i0GBo1q6+ikBB9o9LlErOh7HlbHQWBRFWeY1HDADQp8+/On5G1lK5ZAP4Vlus3qnPjCDBoIQf0yBA8bL3uNg3n+hPxg+Rw1fMkQ7YLhRPUh2sevipIxIHiOJW+PKSiy51NqhNZLGo0E3HPjfePpFc5EPaZVn73HjDvsKh0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729839307; c=relaxed/simple;
	bh=tux+kVXoxeqatZsSvhUcOundmYXP9bd2WCJpZ0y15bQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WivemALgnOcx0O6LiEx1eoiqvmhlYUcCtMc0wFgbEEj6LfUzZM6jIDm6OSBObaLiIqL2NJK2d8lcZwytNpNTXW9GpHRbJIK+qe7/WqMekpD4mpEomJ731cHmkHwwnSW8nweDcc1jefkK582+dYXb/8ySuYJaENz4xlRfSPpfwcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ipvoAb7w; arc=none smtp.client-ip=95.215.58.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ipvoAb7w"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1729839296;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=utWPae6JOH6Gfwt6/OMxC57uOc92cN39G9Jp3wctaGM=;
	b=ipvoAb7wizNjLbnsMi5gnUC/2Kr5hGsx/CI0ySYYppvcYpqlTUz1B850F9inafyqCHXzXY
	E7DkHEaMgIrYY5RDQAZgpijc6GimwDDPw1Lz4E/aK0wvTtEMckswS67XU2Qo1fzsMF7QGG
	/XCQUFIUIWwLWVvd2uhykQ6kIGC1GUk=
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
Date: Fri, 25 Oct 2024 14:54:41 +0800
Message-Id: <20241025065441.1001852-1-dongtai.guo@linux.dev>
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

