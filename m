Return-Path: <SRS0=FLpC=6I=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E20DC54FD0
	for <linux-security-module@archiver.kernel.org>; Fri, 24 Apr 2020 13:20:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EA79F20776
	for <linux-security-module@archiver.kernel.org>; Fri, 24 Apr 2020 13:20:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="a/nKnXk/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728022AbgDXNUj (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 24 Apr 2020 09:20:39 -0400
Received: from mailout2.samsung.com ([203.254.224.25]:18172 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728021AbgDXNUj (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 24 Apr 2020 09:20:39 -0400
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20200424132036epoutp02716f00c8698bd7970bacf22632116b2d~IxA64i8WB1281512815epoutp02X
        for <linux-security-module@vger.kernel.org>; Fri, 24 Apr 2020 13:20:36 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20200424132036epoutp02716f00c8698bd7970bacf22632116b2d~IxA64i8WB1281512815epoutp02X
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1587734436;
        bh=fQKH9QlmIlAGvKr7V5WKuFLyssTMbCuG6BNkIal6tCY=;
        h=From:To:Cc:Subject:Date:References:From;
        b=a/nKnXk/LC+PLo856Ry0h/Rfw2NKqOCyythtOOttUIzfVwMQNiSbozq7Rl5CmY9jq
         yNLJ72BgVrUVJD0oLIY5tXzEhs/VfoJAOO1yES9DKvOxm14BQmU98MjDie/lQAhMEg
         MTY8hKajASBnuWfzreuCFfdI2gvCnSc+hC93EusU=
Received: from epsmges5p1new.samsung.com (unknown [182.195.42.73]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTP id
        20200424132035epcas5p38fd6a4b25a584cf6fb716c15e85daf00~IxA6FMSGo3204432044epcas5p33;
        Fri, 24 Apr 2020 13:20:35 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
        epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        56.41.04782.3A7E2AE5; Fri, 24 Apr 2020 22:20:35 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
        20200424131638epcas5p300fec614f4a2d6aedc3de337cb3fd259~Iw9dL1DW50364803648epcas5p3k;
        Fri, 24 Apr 2020 13:16:38 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200424131638epsmtrp1ecba1de0bcc2ca5fab2dca0bd48e830c~Iw9dLDP5y2002120021epsmtrp1o;
        Fri, 24 Apr 2020 13:16:38 +0000 (GMT)
X-AuditID: b6c32a49-89bff700000012ae-6a-5ea2e7a33bb7
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        87.BA.25866.5B6E2AE5; Fri, 24 Apr 2020 22:16:38 +0900 (KST)
Received: from localhost.localdomain (unknown [107.108.92.210]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200424131636epsmtip17a9af7606f6909c676808a3b6e6a0dc9~Iw9cHQfrq3162631626epsmtip1M;
        Fri, 24 Apr 2020 13:16:36 +0000 (GMT)
From:   Vishal Goel <vishal.goel@samsung.com>
To:     casey@schaufler-ca.com, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Vishal Goel <vishal.goel@samsung.com>,
        Amit Sahrawat <a.sahrawat@samsung.com>
Subject: [PATCH 1/1] Smack:- Remove mutex lock "smk_lock" from inode_smack
 structure.
Date:   Fri, 24 Apr 2020 18:25:19 +0530
Message-Id: <1587732920-49120-1-git-send-email-vishal.goel@samsung.com>
X-Mailer: git-send-email 1.9.1
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrAIsWRmVeSWpSXmKPExsWy7bCmhu7i54viDC6sELC4uDvV4t62X2wW
        l3fNYbP40POIzWLd7dOMDqwefVtWMXoc3b+IzePzJrkA5igum5TUnMyy1CJ9uwSujO8XXzAW
        vBGrOHCkl7mB8bBQFyMnh4SAicSp65dYuxi5OIQEdjNKLDq5iA0kISTwiVHi5PtwiMRnRokX
        z34ywXQ03//FDJHYxShxf1U/C4TzhVHi86/p7CBVbALaEr3z7oJ1iAgkSnx4sgMsziwQLLHx
        wxUWEFtYIFxiyuOpQJM4OFgEVCWmH9QFCfMKuEu8utTIDrFMTuLksclg50kI9LNLbHrcxw5S
        LyHgIrGjLRGiRlji1fEtUPVSEi/729gh6tsZJY7O2gjlTGGU+LfvBlSVvcTr5gYmkEHMApoS
        63fpQ4RlJaaeWscEcSefRO/vJ1Af80rsmAdjq0pMndQNNUZa4vCNMywQtofE7zUbWCBBFyvx
        908b8wRG2VkIGxYwMq5ilEwtKM5NTy02LTDMSy3XK07MLS7NS9dLzs/dxAiOZy3PHYyzzvkc
        YhTgYFTi4WU4tChOiDWxrLgy9xCjBAezkghvTAlQiDclsbIqtSg/vqg0J7X4EKM0B4uSOO8k
        1qsxQgLpiSWp2ampBalFMFkmDk6pBkYX2+b9bP9Xshqof9d+e+CIv4/tw7zVXGd/97yRT7x5
        g7tEUFGWPfhA4cUrDTorn747WrquZUlPksaTqVaJBnveLijOYdpYx+b7dGZYvBl7e8LitjVz
        bsx8+qt6nZeOnky1akVlcaVQ/P5j8/6oeHXn/Ihny0p5pGFdGS5i/W5va8XmxvCPZ5RYijMS
        DbWYi4oTAQ0B2bHjAgAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrJJMWRmVeSWpSXmKPExsWy7bCSnO62Z4viDFasY7S4uDvV4t62X2wW
        l3fNYbP40POIzWLd7dOMDqwefVtWMXoc3b+IzePzJrkA5igum5TUnMyy1CJ9uwSujO8XXzAW
        vBGrOHCkl7mB8bBQFyMnh4SAiUTz/V/MXYxcHEICOxgl5mxdyQyRkJZY0vmGHcIWllj57zk7
        RNEnRomW+ZvAitgEtCV6591lArFFBJIldjdPZwSxmQWCJU737GQBsYUFQiUuXnkLVMPBwSKg
        KjH9oC5ImFfAXeLVpUao+XISJ49NZp3AyLOAkWEVo2RqQXFuem6xYYFRXmq5XnFibnFpXrpe
        cn7uJkZwaGhp7WDcs+qD3iFGJg7GQ4wSHMxKIrwxJYvihHhTEiurUovy44tKc1KLDzFKc7Ao
        ifN+nbUwTkggPbEkNTs1tSC1CCbLxMEp1cC0U4JB6XjYQ7ODtex5G4/2nnk8pTHxVJTIzWu3
        tlQUPRA2WPHC6OCjA7z7FVyPzd/UsGeb3+6uTuGMz10qFQde7Zi1O6abY/2czjfmUUmVkrc+
        bc1Wcc19+f+cvurl285bch5v2LT+XNeUlT/XGantfv/QdPK2nYssxNgNkpasvbpwl8aRgLB+
        009zDJdGS2qs6tW+J/7WyyP3ebmm2sqtTBvdLD+XfJFZtW3vBTPNtzpalw9tlZUorpf5zede
        c2eH/zt1pv2sjDXLX7N1ec+apbak6vJsTYdFn17MC2S5tczCgqPx1ezn+9LNp+kmXuNKUCxV
        811U/M2vPmdm8OrJdlvPS7mLBq7Y/nXr/EU7PJRYijMSDbWYi4oTAaohdix8AgAA
X-CMS-MailID: 20200424131638epcas5p300fec614f4a2d6aedc3de337cb3fd259
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
X-CMS-RootMailID: 20200424131638epcas5p300fec614f4a2d6aedc3de337cb3fd259
References: <CGME20200424131638epcas5p300fec614f4a2d6aedc3de337cb3fd259@epcas5p3.samsung.com>
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

"smk_lock" mutex is used during inode instantiation in
smack_d_instantiate()function. It has been used to avoid
simultaneous access on same inode security structure.
Since smack related initialization is done only once i.e during
inode creation. If the inode has already been instantiated then
smack_d_instantiate() function just returns without doing
anything.

So it means mutex lock is required only during inode creation.
But since 2 processes can't create same inodes or files
simultaneously. Also linking or some other file operation can't
be done simultaneously when the file is getting created since
file lookup will fail before dentry inode linkup which is done
after smack initialization.
So no mutex lock is required in inode_smack structure.

It will save memory as well as improve some performance.
If 40000 inodes are created in system, it will save 1.5 MB on
32-bit systems & 2.8 MB on 64-bit systems.

Signed-off-by: Vishal Goel <vishal.goel@samsung.com>
Signed-off-by: Amit Sahrawat <a.sahrawat@samsung.com>
---
 security/smack/smack.h     | 1 -
 security/smack/smack_lsm.c | 8 ++------
 2 files changed, 2 insertions(+), 7 deletions(-)

diff --git a/security/smack/smack.h b/security/smack/smack.h
index 62529f3..fd09dc8 100644
--- a/security/smack/smack.h
+++ b/security/smack/smack.h
@@ -109,7 +109,6 @@ struct inode_smack {
 	struct smack_known	*smk_inode;	/* label of the fso */
 	struct smack_known	*smk_task;	/* label of the task */
 	struct smack_known	*smk_mmap;	/* label of the mmap domain */
-	struct mutex		smk_lock;	/* initialization lock */
 	int			smk_flags;	/* smack inode flags */
 	struct rcu_head         smk_rcu;	/* for freeing inode_smack */
 };
diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index 2862fc3..10c2bdd 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -317,7 +317,6 @@ static void init_inode_smack(struct inode *inode, struct smack_known *skp)
 
 	isp->smk_inode = skp;
 	isp->smk_flags = 0;
-	mutex_init(&isp->smk_lock);
 }
 
 /**
@@ -3274,13 +3273,12 @@ static void smack_d_instantiate(struct dentry *opt_dentry, struct inode *inode)
 
 	isp = smack_inode(inode);
 
-	mutex_lock(&isp->smk_lock);
 	/*
 	 * If the inode is already instantiated
 	 * take the quick way out
 	 */
 	if (isp->smk_flags & SMK_INODE_INSTANT)
-		goto unlockandout;
+		return;
 
 	sbp = inode->i_sb;
 	sbsp = sbp->s_security;
@@ -3331,7 +3329,7 @@ static void smack_d_instantiate(struct dentry *opt_dentry, struct inode *inode)
 			break;
 		}
 		isp->smk_flags |= SMK_INODE_INSTANT;
-		goto unlockandout;
+		return;
 	}
 
 	/*
@@ -3466,8 +3464,6 @@ static void smack_d_instantiate(struct dentry *opt_dentry, struct inode *inode)
 
 	isp->smk_flags |= (SMK_INODE_INSTANT | transflag);
 
-unlockandout:
-	mutex_unlock(&isp->smk_lock);
 	return;
 }
 
-- 
1.9.1

