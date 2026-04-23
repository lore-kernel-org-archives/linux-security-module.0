Received: from canpmsgout07.his.huawei.com (canpmsgout07.his.huawei.com [113.46.200.222])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D91893B52FD;
	Thu, 23 Apr 2026 02:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.222
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776912991; cv=none; b=lDcFZVS4VESraz9bSEdYLTzijO1cqomxE+/OCiW7ARdKqPm3S4GOETIzQcgwEzlBGkWxs5goW1g8iYpy9uJyOZxLyx0Ws6trJfmJRzG9KlKD1jCO+bLgCQQ40a1DcXfsWajDzp+8nXLFDa2cWH7EcZu86gVTDaL98szgI0pN3qk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776912991; c=relaxed/simple;
	bh=slp1/df97e9HejUPj2FtdsPJYodA3Os3oEE4UDiyAcs=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=H/Sb05FL9hbLItZnUgAHlkQYkyd52fgBW6qfBQpnLKNdP2V8tCxftLs96hBcojoVDV6s4Ns2bST+m2RcQwyzkWAIAWogtt5+JT3njdlLo/9BrU5yaedb8qlRQvYxceHLJWbiCFf+6J8tyyLehmi0PE8X0jURDvjVnBPt9O58cLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=b59gjuSn; arc=none smtp.client-ip=113.46.200.222
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="b59gjuSn"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=cI9EPb4U3rIy4OPkKYa2Khl98cSKaAlG52wx2V3maNo=;
	b=b59gjuSnw3qXHrJD0ddTyZp9qxJ4U5G+qvsWphgK1DqsCqxIxHFuzHQWCGMONsPV437r7R+Tw
	eqp/pVfALebDc/Ex2B413mcOCSOehPJXZZE2L3L0ipebc2MnnvX52yNbp9ul0k3jlPoMVq+QeJB
	lHtAT09iPASjBnBsZ/R7y4k=
Received: from mail.maildlp.com (unknown [172.19.162.92])
	by canpmsgout07.his.huawei.com (SkyGuard) with ESMTPS id 4g1LD60kcbzLlSv;
	Thu, 23 Apr 2026 10:49:58 +0800 (CST)
Received: from kwepemk100018.china.huawei.com (unknown [7.202.194.66])
	by mail.maildlp.com (Postfix) with ESMTPS id 6636E40562;
	Thu, 23 Apr 2026 10:56:20 +0800 (CST)
Received: from huawei.com (10.67.174.33) by kwepemk100018.china.huawei.com
 (7.202.194.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Thu, 23 Apr
 2026 10:56:19 +0800
From: GONG Ruiqi <gongruiqi1@huawei.com>
To: John Johansen <john.johansen@canonical.com>, Paul Moore
	<paul@paul-moore.com>, James Morris <jmorris@namei.org>, "Serge E . Hallyn"
	<serge@hallyn.com>, Georgia Garcia <georgia.garcia@canonical.com>
CC: <apparmor@lists.ubuntu.com>, <linux-security-module@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <lujialin4@huawei.com>,
	<gongruiqi1@huawei.com>, <zhaoyipeng5@huawei.com>
Subject: [PATCH] apparmor/lsm: Fix aa_dfa_unpack's error handling in aa_setup_dfa_engine
Date: Thu, 23 Apr 2026 11:10:56 +0800
Message-ID: <20260423031056.563527-1-gongruiqi1@huawei.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 kwepemk100018.china.huawei.com (7.202.194.66)

aa_dfa_unpack returns ERR_PTR not NULL when it fails, but aa_put_dfa
only checks NULL for its input, which would cause invalid memory access
in aa_put_dfa. Set nulldfa to NULL explicitly to fix that.

Fixes: 98b824ff8984 ("apparmor: refcount the pdb")
Signed-off-by: GONG Ruiqi <gongruiqi1@huawei.com>
---
 security/apparmor/lsm.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/security/apparmor/lsm.c b/security/apparmor/lsm.c
index c1d42fc72fdb..ead2f07982b6 100644
--- a/security/apparmor/lsm.c
+++ b/security/apparmor/lsm.c
@@ -2465,6 +2465,7 @@ static int __init aa_setup_dfa_engine(void)
 			    TO_ACCEPT2_FLAG(YYTD_DATA32));
 	if (IS_ERR(nulldfa)) {
 		error = PTR_ERR(nulldfa);
+		nulldfa = NULL;
 		goto fail;
 	}
 	nullpdb->dfa = aa_get_dfa(nulldfa);
-- 
2.43.0

