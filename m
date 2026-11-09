Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=113.46.200.225
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794193478;
	b=1vSvE1NDw7jdvVQ0LjzYzvO8QhNCaGRUiyBYehV0oKMLEVC4INdoKQ4X0La1gA3mkLpg
	 Eq191t4H3W1NoNd8d97r64hxb0jewHFQ40O3oKlVzGMmOsiV92O2qalxzFUa0txifs/ka
	 f3n8YkITaZD4n+M4QiDGEB5xwwD6YPV1VIXjVHxtyKpWGEO48isLmiEiXsVxDjI0O+hyT
	 MgiTo4LrCWXoFCPrA5znrtZxcj3FV4Ijyrb18EZBFQnj8mhwP3S+ElPkH87XxFcGPGYnB
	 9m6YjW+RJNvDYnfV5RCy2RjARyOo7p00UlG8JGZQX08q83Q4eWGdqp91kiX69NjvyyA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794193478;
	h=DMARC-Filter:dkim-signature:Received:Received:Received:From:To:CC:
	 Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-ClientProxiedBy;
	bh=Mbaxm6pY4DxTSQpSJHy5VFk99rqnTyFhJcAlVZ816Oc=;
	b=HDYmO74+yxpZeWlYmYVuU7iWaJzVAt44Sg1IaBImGQ3lSFaB9zEE9liJafAGy2dmqfNN
	 H0OLgLZa8cyDnYARSq2mMnr99VSFB3BfsO+umbl6r1AYb0SvxpT79krZ6MpqtGijjxygc
	 C1lBaYvO5U3weASjpiJRL/5ObwhrapxK+Dr8poGdEbDswf1gwBpXjIfqxV3HZBOssLhcq
	 YLiXTU+w5VhwPaga/LcYBVVWWvcM5flvYYNcUQCLu7yiIVqqsNTQzRSV/gAWh6CH21B16
	 E4tg66tLl/7cvUF25bx9OIEbYXZ06kuyP4T/M3unlf1uMsQtgncxWk4uaMKJWhclAOw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=huawei.com;
	spf=pass smtp.mailfrom=huawei.com;
	dkim=pass header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=CtYCblXF;
	arc=none smtp.remote-ip=113.46.200.225
Received: from canpmsgout10.his.huawei.com (canpmsgout10.his.huawei.com [113.46.200.225])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7625606A31C;
	Mon,  9 Nov 2026 03:04:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A7625606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=CtYCblXF
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=Mbaxm6pY4DxTSQpSJHy5VFk99rqnTyFhJcAlVZ816Oc=;
	b=CtYCblXFy/cGn0hGPSCCSQ18qXbxR6oawatN6w1O3/wMKm7tujOVfxw+d9a5gLpD4r0XqwFnE
	0H8hBRFJJP8RckrglcAuREAk8RCtGQ/T6Ob+lI9OVQjG8owTT2uvRysPTEzPVUZarOBZGmWSPFL
	VtJNROtL5QnLfCR26uXv2io=
Received: from mail.maildlp.com (unknown [172.19.163.163])
	by canpmsgout10.his.huawei.com (SkyGuard) with ESMTPS id 4jNF4V2976z1K9BF;
	Mon,  9 Nov 2026 11:04:26 +0800 (CST)
Received: from dggpemr200001.china.huawei.com (unknown [7.185.36.96])
	by mail.maildlp.com (Postfix) with ESMTPS id 317694048B;
	Mon,  9 Nov 2026 11:04:34 +0800 (CST)
Received: from huawei.com (10.50.85.155) by dggpemr200001.china.huawei.com
 (7.185.36.96) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Mon, 9 Nov
 2026 11:04:33 +0800
From: Ran Hongyun <ranhongyun1@huawei.com>
To: <john.johansen@canonical.com>, <georgia.garcia@canonical.com>,
	<paul@paul-moore.com>, <jmorris@namei.org>, <serge@hallyn.com>
CC: <apparmor@lists.ubuntu.com>, <linux-security-module@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <ranhongyun1@huawei.com>,
	<chengzhihao1@huawei.com>, <yangerkun@huawei.com>, <yi.zhang@huawei.com>
Subject: [PATCH] apparmor: fix double d_instantiate() in ns_mkdir_op()
Date: Mon, 9 Nov 2026 10:56:00 +0800
Message-ID: <20261109025600.2031008-1-ranhongyun1@huawei.com>
X-Mailer: git-send-email 2.52.0
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 dggpemr200001.china.huawei.com (7.185.36.96)

ns_mkdir_op() drops inode_lock for simple_pin_fs() and re-acquires it
before instantiating the dentry.  A concurrent mkdir() of the same name
can pass the VFS negative-dentry checks in that window and also reach
d_instantiate(), tripping BUG_ON(!hlist_unhashed(&d_alias)).

Re-check that the dentry is still negative after re-acquiring inode_lock
and return -EEXIST if a concurrent mkdir() won the race.

Fixes: 4ae47f33354a ("apparmor: add mkdir/rmdir interface to manage policy namespaces")
Signed-off-by: Ran Hongyun <ranhongyun1@huawei.com>
---
 security/apparmor/apparmorfs.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/security/apparmor/apparmorfs.c b/security/apparmor/apparmorfs.c
index a99366467217..5a9565eeb62b 100644
--- a/security/apparmor/apparmorfs.c
+++ b/security/apparmor/apparmorfs.c
@@ -2111,6 +2111,12 @@ static struct dentry *ns_mkdir_op(const struct mnt_idmap *idmap, struct inode *d
 	if (error)
 		goto out;
 
+	/* the dentry may be instantiated by a concurrent mkdir */
+	if (unlikely(d_really_is_positive(dentry))) {
+		error = -EEXIST;
+		goto out_pin;
+	}
+
 	error = __aafs_setup_d_inode(dir, dentry, mode | S_IFDIR,  NULL,
 				     NULL, NULL, NULL);
 	if (error)
-- 
2.52.0

