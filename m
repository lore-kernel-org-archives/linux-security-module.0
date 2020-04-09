Return-Path: <SRS0=+lL4=5Z=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B979C2BA2B
	for <linux-security-module@archiver.kernel.org>; Thu,  9 Apr 2020 12:50:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6D3020730
	for <linux-security-module@archiver.kernel.org>; Thu,  9 Apr 2020 12:50:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="aH9lC/5s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726714AbgDIMt7 (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 9 Apr 2020 08:49:59 -0400
Received: from mailout2.samsung.com ([203.254.224.25]:36271 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726470AbgDIMt7 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 9 Apr 2020 08:49:59 -0400
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20200409124957epoutp028cfb4829741383337ad661fef922fc5e~EJ64c27DR2734727347epoutp02L
        for <linux-security-module@vger.kernel.org>; Thu,  9 Apr 2020 12:49:57 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20200409124957epoutp028cfb4829741383337ad661fef922fc5e~EJ64c27DR2734727347epoutp02L
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1586436597;
        bh=k127lAaemQMj/UxuaYJHqu26q7MPrNgzRaknKbgSsf0=;
        h=From:To:Cc:Subject:Date:References:From;
        b=aH9lC/5sYSfdgu0FWppKJyeFctE7U9niFnQ5lD/3vYVSg2lg8F/TgO69aU3MPh7dy
         xw6WUb2WG+aqtV77iACLwenOWc4q5v/mZ+w/4uDMkS4wNaDUKLJSBRZYlXs5tnCdcv
         fA2ky4L/iXDZHy6l8FycjiF6QDylXZGM/mCzzAf4=
Received: from epsmges5p3new.samsung.com (unknown [182.195.42.75]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTP id
        20200409124957epcas5p3dfbf7b1eda2f7fbb79cea1a1f234cfdf~EJ64IgjDX0948209482epcas5p3s;
        Thu,  9 Apr 2020 12:49:57 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
        epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
        69.E7.04736.5F91F8E5; Thu,  9 Apr 2020 21:49:57 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
        20200409124013epcas5p33036c008f30327378a6ff02050261626~EJyY8LLLP3207032070epcas5p3i;
        Thu,  9 Apr 2020 12:40:13 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200409124013epsmtrp10b7baeb055849648c1ebca84be825506~EJyY7dqyu3224132241epsmtrp1J;
        Thu,  9 Apr 2020 12:40:13 +0000 (GMT)
X-AuditID: b6c32a4b-ae3ff70000001280-4a-5e8f19f5c79f
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        69.B3.04158.DA71F8E5; Thu,  9 Apr 2020 21:40:13 +0900 (KST)
Received: from localhost.localdomain (unknown [107.109.224.135]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200409124012epsmtip272daa145077cb78ee405e314a1f6a06a~EJyXWxDKh1242112421epsmtip2l;
        Thu,  9 Apr 2020 12:40:12 +0000 (GMT)
From:   Maninder Singh <maninder1.s@samsung.com>
To:     casey@schaufler-ca.com, jmorris@namei.org, serge@hallyn.com
Cc:     linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, a.sahrawat@samsung.com,
        v.narang@samsung.com, Maninder Singh <maninder1.s@samsung.com>
Subject: [PATCH 1/1] smack: remove redundant structure variable from header.
Date:   Thu,  9 Apr 2020 18:09:58 +0530
Message-Id: <1586435998-18921-1-git-send-email-maninder1.s@samsung.com>
X-Mailer: git-send-email 2.7.4
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrGIsWRmVeSWpSXmKPExsWy7bCmpu5Xyf44g+d7WCwu7k61uLftF5vF
        uvWLmSwu75rDZvGh5xGbxeH5bSwW5y+cY7c4dHIuowOHx7XdkR4935M9+rasYvQ4un8Rm8fn
        TXIBrFFcNimpOZllqUX6dglcGf3HIwsms1V07dvJ3sDYxNrFyMkhIWAi8ar7JksXIxeHkMBu
        RonVy7axQjifGCX+tv9hB6kSEvjGKDGvWwam483cFVAdexklnn46CeV8ZZRYt2gjE0gVm4Ce
        xKpde1hAbBEBe4nJ2++xgdjMAosZJd42KoDYwgI+Ejt/LgKq5+BgEVCV2HarGiTMK+Au8fr0
        R2aIZXISN891MoPMlxDoYJNY2rWNESLhInHnWhM7hC0s8er4FihbSuJlfxs7REMzo8SnfWsZ
        IZwpjBJLL36E+tpe4nVzA9hmZgFNifW79CHCshJTT61jgjiUT6L39xMmiDivxI55MLaqRMvN
        DVBjpCU+f/zIAmF7SEza9hFspJBArMTsf6kTGGVnISxYwMi4ilEytaA4Nz212LTAOC+1XK84
        Mbe4NC9dLzk/dxMjOPa1vHcwbjrnc4hRgINRiYe3g6k/Tog1say4MvcQowQHs5IIr3dTb5wQ
        b0piZVVqUX58UWlOavEhRmkOFiVx3kmsV2OEBNITS1KzU1MLUotgskwcnFINjJ7th3IWlTvY
        P97yIG+yu/+dt32T+Ca5lh0XTUz7IvWS6YPGob4HvvLaJ7K3RV22OZqh9v7xwvcHrG52Wtfq
        Rax1r1l7NP5VUlLn7x+yCzuDbum+O/4mzjR7gs41YSHZr0acm4IXdTatV1m0Y292YGxEWbR+
        M9OBdkkzm7AjNxXdJlTxzw68oMRSnJFoqMVcVJwIAH46SEf5AgAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFuphluLIzCtJLcpLzFFi42LZdlhJXneteH+cwf8rphYXd6da3Nv2i81i
        3frFTBaXd81hs/jQ84jN4vD8NhaL8xfOsVscOjmX0YHD49ruSI+e78kefVtWMXoc3b+IzePz
        JrkA1igum5TUnMyy1CJ9uwSujP7jkQWT2Sq69u1kb2BsYu1i5OSQEDCReDN3BUsXIxeHkMBu
        RolD+94zQiSkJX7+e88CYQtLrPz3nB2i6DOjxPqfh8GK2AT0JFbt2gNUxMEhIuAs8Ws5M0gN
        s8ByRomDxx6BbRAW8JHY+XMRE0gNi4CqxLZb1SBhXgF3idenPzJDzJeTuHmuk3kCI88CRoZV
        jJKpBcW56bnFhgVGeanlesWJucWleel6yfm5mxjBYaSltYPxxIn4Q4wCHIxKPLwGDP1xQqyJ
        ZcWVuYcYJTiYlUR4vZt644R4UxIrq1KL8uOLSnNSiw8xSnOwKInzyucfixQSSE8sSc1OTS1I
        LYLJMnFwSjUwys16bZCxzWfn3WmPpHQr8sysotY3BJR0LH3zpOLn7F93WxsXHRJ3qPtS/tak
        +NQCoRszO9c+q9i4QOa9stXMPJuzzEz37m+RVp/J8s3229xFS8ubH7Dt2X0koZthJw9H7IUr
        Sy4v/2cgbDljQtkUgYr5FbZXVFh3zIt8nZZ98ShzhNA8mY1dAUosxRmJhlrMRcWJAF/bcy8f
        AgAA
X-CMS-MailID: 20200409124013epcas5p33036c008f30327378a6ff02050261626
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
X-CMS-RootMailID: 20200409124013epcas5p33036c008f30327378a6ff02050261626
References: <CGME20200409124013epcas5p33036c008f30327378a6ff02050261626@epcas5p3.samsung.com>
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

commit afb1cbe37440 ("LSM: Infrastructure management
of the inode security") removed usage of smk_rcu,
thus removing it from structure.

Signed-off-by: Maninder Singh <maninder1.s@samsung.com>
Signed-off-by: Vaneet Narang <v.narang@samsung.com>
---
 security/smack/smack.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/security/smack/smack.h b/security/smack/smack.h
index 62529f3..5ebd0bb 100644
--- a/security/smack/smack.h
+++ b/security/smack/smack.h
@@ -111,7 +111,6 @@ struct inode_smack {
 	struct smack_known	*smk_mmap;	/* label of the mmap domain */
 	struct mutex		smk_lock;	/* initialization lock */
 	int			smk_flags;	/* smack inode flags */
-	struct rcu_head         smk_rcu;	/* for freeing inode_smack */
 };
 
 struct task_smack {
-- 
1.9.1

