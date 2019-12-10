Return-Path: <SRS0=PCLm=2A=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1A5AC43603
	for <linux-security-module@archiver.kernel.org>; Tue, 10 Dec 2019 01:53:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0BD120637
	for <linux-security-module@archiver.kernel.org>; Tue, 10 Dec 2019 01:53:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="Sv89smHy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726589AbfLJBxg (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 9 Dec 2019 20:53:36 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:45723 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726502AbfLJBxg (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 9 Dec 2019 20:53:36 -0500
Received: by mail-qt1-f194.google.com with SMTP id p5so1236775qtq.12
        for <linux-security-module@vger.kernel.org>; Mon, 09 Dec 2019 17:53:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=subject:from:to:cc:date:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=sWeZBHmuSI1Kzt9EWTQi4AaHQzc+vUUx0xdzmNCRzNU=;
        b=Sv89smHyJVpvE9ncP5CWnfh8QEf8fdVf+QlNG4GItGKMw10ItXVNtEabBmCncYFDhG
         W1Y+1/MvR/+S+YKREVhsOBwxglZ1BSIcgp7NMXnbriaHnAh1beiWKOC6pYHQjLtdB70X
         JWzVH+1ysqkLzHgESZGJyWYJaFcgNoohDd5FVbbwyTgbbpkxetYJhMge6EKen/nwP2DJ
         BK5GasTQKMr/xdeLQQgqF+fgKF5US5Ah7G/FuKTOuXg8FJxaHwb2j7ZnfOhKxf0gB31x
         1thdOr402ZdM42mzEL5ewcL+i4ONaiHumfAWmJE7Eymf3tErScKUAjwU5llS/iA0Ag5q
         bzBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:date:message-id:user-agent
         :mime-version:content-transfer-encoding;
        bh=sWeZBHmuSI1Kzt9EWTQi4AaHQzc+vUUx0xdzmNCRzNU=;
        b=GRD6LOaiQeIxp1MlzzvZGMHACK3M+tE5OG3RvZ31LD5pHqmDixz4eE6EG47b5pgHVc
         b/uMXSkCllhLa8pWSnp3VX5JJMSjPpTZ8Ze8KMuE7i0iBv1wQQkrI4UbIOzVnwxY1N1B
         h3e/Gbtl5hMM/nmsLQUvcDWYxo5xS21INRC2NqkQW71JqY5hpsVA2sSF90bFbOfLYvQH
         P1MxeRLBKsxLbuaOakWhv/4cs/idlNnk2bBlLwTBYgghVwtPEdXP9h1oIJbq+N2x66Uc
         8JmmVtGWFpQki218SfufIuGZcf5v2nWXxElD8/kRMQrndXUpFx6FtOLnurJvrpeuDBIb
         WOSQ==
X-Gm-Message-State: APjAAAUJs6yXputimVhpRVlDL3uOan4p7ePTa+zREIgyrDIMuCYRIQ2k
        LesHboSJiNy6YNKwoMcF1BbUcN75tDHW
X-Google-Smtp-Source: APXvYqyCHC4WGLhWBnsSMDIWmfML0gDpaQzvkyUJlFQ8E5VUB+uj+bEFzEl8i6vbvq4QX1RLt8+bZg==
X-Received: by 2002:ac8:499a:: with SMTP id f26mr18782855qtq.178.1575942814908;
        Mon, 09 Dec 2019 17:53:34 -0800 (PST)
Received: from localhost (static-96-233-112-89.bstnma.ftas.verizon.net. [96.233.112.89])
        by smtp.gmail.com with ESMTPSA id t23sm538336qto.88.2019.12.09.17.53.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2019 17:53:34 -0800 (PST)
Subject: [RFC PATCH] selinux: ensure we cleanup the internal AVC counters on
 error in avc_insert()
From:   Paul Moore <paul@paul-moore.com>
To:     selinux@vger.kernel.org
Cc:     rsiddoji@codeaurora.org, sds@tycho.nsa.gov,
        linux-security-module@vger.kernel.org
Date:   Mon, 09 Dec 2019 20:53:33 -0500
Message-ID: <157594281322.676903.11041338053333686450.stgit@chester>
User-Agent: StGit/0.21
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

In AVC insert we don't call avc_node_kill() when avc_xperms_populate()
fails, resulting in the avc->avc_cache.active_nodes counter having a
false value.  This patch corrects this problem and does some cleanup
in avc_insert() while we are there.

Reported-by: rsiddoji@codeaurora.org
Suggested-by: Stephen Smalley <sds@tycho.nsa.gov>
Signed-off-by: Paul Moore <paul@paul-moore.com>
---
 security/selinux/avc.c |   51 +++++++++++++++++++++++-------------------------
 1 file changed, 24 insertions(+), 27 deletions(-)

diff --git a/security/selinux/avc.c b/security/selinux/avc.c
index 23dc888ae305..6646300f7ccb 100644
--- a/security/selinux/avc.c
+++ b/security/selinux/avc.c
@@ -617,40 +617,37 @@ static struct avc_node *avc_insert(struct selinux_avc *avc,
 	struct avc_node *pos, *node = NULL;
 	int hvalue;
 	unsigned long flag;
+	spinlock_t *lock;
+	struct hlist_head *head;
 
 	if (avc_latest_notif_update(avc, avd->seqno, 1))
-		goto out;
+		return NULL;
 
 	node = avc_alloc_node(avc);
-	if (node) {
-		struct hlist_head *head;
-		spinlock_t *lock;
-		int rc = 0;
-
-		hvalue = avc_hash(ssid, tsid, tclass);
-		avc_node_populate(node, ssid, tsid, tclass, avd);
-		rc = avc_xperms_populate(node, xp_node);
-		if (rc) {
-			kmem_cache_free(avc_node_cachep, node);
-			return NULL;
-		}
-		head = &avc->avc_cache.slots[hvalue];
-		lock = &avc->avc_cache.slots_lock[hvalue];
+	if (!node)
+		return NULL;
 
-		spin_lock_irqsave(lock, flag);
-		hlist_for_each_entry(pos, head, list) {
-			if (pos->ae.ssid == ssid &&
-			    pos->ae.tsid == tsid &&
-			    pos->ae.tclass == tclass) {
-				avc_node_replace(avc, node, pos);
-				goto found;
-			}
+	avc_node_populate(node, ssid, tsid, tclass, avd);
+	if (avc_xperms_populate(node, xp_node)) {
+		avc_node_kill(avc, node);
+		return NULL;
+	}
+
+	hvalue = avc_hash(ssid, tsid, tclass);
+	head = &avc->avc_cache.slots[hvalue];
+	lock = &avc->avc_cache.slots_lock[hvalue];
+	spin_lock_irqsave(lock, flag);
+	hlist_for_each_entry(pos, head, list) {
+		if (pos->ae.ssid == ssid &&
+			pos->ae.tsid == tsid &&
+			pos->ae.tclass == tclass) {
+			avc_node_replace(avc, node, pos);
+			goto found;
 		}
-		hlist_add_head_rcu(&node->list, head);
-found:
-		spin_unlock_irqrestore(lock, flag);
 	}
-out:
+	hlist_add_head_rcu(&node->list, head);
+found:
+	spin_unlock_irqrestore(lock, flag);
 	return node;
 }
 

