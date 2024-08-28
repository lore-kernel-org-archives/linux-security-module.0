Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E098E1741C3
	for <linux-security-module@vger.kernel.org>; Wed, 28 Aug 2024 12:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.255
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724847508; cv=none; b=n8Dl1Tsw14FnuJ4czW4ol/GGtE6h2SiNVbkiV5V0st+oWm71Szqnj5jUo3UWXu88x/jd6NdvV6R+5OKRQ6KKV0sD7YVFHn+6zFAFbshW0Wf0j4mmt6cVe68pSuG92r4z8RF8+fRwnFUKhJIU0CXsNqfQCmpCw6PyzxZH3j7DPdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724847508; c=relaxed/simple;
	bh=PNFYbupy/EWnR755FhcZaOx77a/NmXluebe3qNkl8/o=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=L/+qPa04r/pZbyBu3MADkO3VDMKuCfLJcBj5PxzRh+kci5EE2rtU07aSdYcMCTvPKppiUY49/aCXZbcdj3HImRMz+TErRoESVR7ktNqCVyCARUzAW3V0YSdrmT9/qzy9DFKneTRQAFuq6d9nE+qZej9kIyUgCnxbvECPPXmhXA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.255
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4Wv3MG4Ww7z16Pd1;
	Wed, 28 Aug 2024 20:17:30 +0800 (CST)
Received: from dggpeml500022.china.huawei.com (unknown [7.185.36.66])
	by mail.maildlp.com (Postfix) with ESMTPS id DD808180106;
	Wed, 28 Aug 2024 20:18:18 +0800 (CST)
Received: from huawei.com (10.90.53.73) by dggpeml500022.china.huawei.com
 (7.185.36.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Wed, 28 Aug
 2024 20:18:18 +0800
From: Hongbo Li <lihongbo22@huawei.com>
To: <john.johansen@canonical.com>, <paul@paul-moore.com>, <jmorris@namei.org>,
	<serge@hallyn.com>
CC: <apparmor@lists.ubuntu.com>, <linux-security-module@vger.kernel.org>,
	<lihongbo22@huawei.com>
Subject: [PATCH -next] apparmor: Use IS_ERR_OR_NULL() helper function
Date: Wed, 28 Aug 2024 20:26:18 +0800
Message-ID: <20240828122618.3697392-1-lihongbo22@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpeml500022.china.huawei.com (7.185.36.66)

Use the IS_ERR_OR_NULL() helper instead of open-coding a
NULL and an error pointer checks to simplify the code and
improve readability.

Signed-off-by: Hongbo Li <lihongbo22@huawei.com>
---
 security/apparmor/path.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/security/apparmor/path.c b/security/apparmor/path.c
index 45ec994b558d..d6c74c357ffd 100644
--- a/security/apparmor/path.c
+++ b/security/apparmor/path.c
@@ -130,7 +130,7 @@ static int d_namespace_path(const struct path *path, char *buf, char **name,
 	/* handle error conditions - and still allow a partial path to
 	 * be returned.
 	 */
-	if (!res || IS_ERR(res)) {
+	if (IS_ERR_OR_NULL(res)) {
 		if (PTR_ERR(res) == -ENAMETOOLONG) {
 			error = -ENAMETOOLONG;
 			*name = buf;
-- 
2.34.1

