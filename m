Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44590C433FE
	for <linux-security-module@archiver.kernel.org>; Fri, 17 Sep 2021 07:38:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2E5CD61152
	for <linux-security-module@archiver.kernel.org>; Fri, 17 Sep 2021 07:38:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241219AbhIQHjw (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 17 Sep 2021 03:39:52 -0400
Received: from mailout4.samsung.com ([203.254.224.34]:28615 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241237AbhIQHjv (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 17 Sep 2021 03:39:51 -0400
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20210917073828epoutp04f990ba9338a63000f845a736659c2f67~li-FDQS0N0870008700epoutp048
        for <linux-security-module@vger.kernel.org>; Fri, 17 Sep 2021 07:38:28 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20210917073828epoutp04f990ba9338a63000f845a736659c2f67~li-FDQS0N0870008700epoutp048
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1631864308;
        bh=9k617nToWu1aztUcRNugGa4QkemtAsxGJpZ5BOciR4A=;
        h=From:To:Cc:Subject:Date:References:From;
        b=gCn51D4QU0cF1J54rh45oE0nCNuRINqhJmyp7laFizUWz9gVqrtWzSxQ4OQpxcDDs
         xY0i5ZBzsmx41mzyfbs0Fu2O3VP1XzDbqyk7JPPXn0RyMCNTyMDifYZGIM6AmCQ2FU
         DjBRP3uO23G6ZGa5KwW7TSx6UHZ4/Uw4alHglSck=
Received: from epsmges5p1new.samsung.com (unknown [182.195.42.73]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTP id
        20210917073827epcas5p4cc663a17d90b9dbe65df88bcb65c5912~li-EooENt0255802558epcas5p4M;
        Fri, 17 Sep 2021 07:38:27 +0000 (GMT)
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
        epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        2A.F2.59762.3F544416; Fri, 17 Sep 2021 16:38:27 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
        20210917073827epcas5p11a811c82ba4c748de3923a62f51250ed~li-EIl3mH0487004870epcas5p1H;
        Fri, 17 Sep 2021 07:38:27 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20210917073827epsmtrp26329dd03eeec07a9c879c76c7d76970d~li-EGzcqU0944309443epsmtrp2Q;
        Fri, 17 Sep 2021 07:38:27 +0000 (GMT)
X-AuditID: b6c32a49-10fff7000000e972-3e-614445f349f5
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        BE.85.08750.3F544416; Fri, 17 Sep 2021 16:38:27 +0900 (KST)
Received: from localhost.localdomain (unknown [107.109.224.44]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20210917073826epsmtip29ff1b4a27b28c9f1b5a52fab1d3266ef~li-C5d9Df1800018000epsmtip2M;
        Fri, 17 Sep 2021 07:38:25 +0000 (GMT)
From:   Vishal Goel <vishal.goel@samsung.com>
To:     casey@schaufler-ca.com, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     a.sahrawat@samsung.com, v.narang@samsung.com,
        Vishal Goel <vishal.goel@samsung.com>
Subject: [PATCH 1/1] Smack:- Use overlay inode label in
 smack_inode_copy_up()
Date:   Fri, 17 Sep 2021 13:08:14 +0530
Message-Id: <1631864294-25794-1-git-send-email-vishal.goel@samsung.com>
X-Mailer: git-send-email 2.7.4
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrFIsWRmVeSWpSXmKPExsWy7bCmlu5nV5dEg11TDC0u7k61uLftF5vF
        5V1z2Cw+9Dxiszh0ci6jxbrbpxkd2Dz6tqxi9Di6fxGbx+dNcgHMUVw2Kak5mWWpRfp2CVwZ
        B55PYiz4zF6x+zpHA+Nhti5GTg4JAROJF0tmsHQxcnEICexmlLhy7yMThPOJUWJN90JGkCoh
        gc+MEpM7OGA6Otc8Z4Uo2sUo0fJiKhuE84VR4tGtX2Bz2QS0JXrn3WUCsUUEEiU+PNnBDmIz
        C0RKPDl4DiwuLOAvsffOL2YQm0VAVWLa+atgvbwC7hI3T++Auk9O4ua5TmaQBRIC/ewSOw4e
        AjqWA8hxkVj5lwWiRlji1fEt7BC2lMTnd3vZIOrbGSUmzPrNDJGYwChx9q0khG0v8eTiQlaQ
        OcwCmhLrd+lD3MYn0fv7CRPEeF6JjjYhiGpViamTuqHGS0scvnEGaq2HROvXiWyQAIqVWNe0
        inUCo8wshKELGBlXMUqmFhTnpqcWmxYY5qWW6xUn5haX5qXrJefnbmIER6+W5w7Guw8+6B1i
        ZOJgPMQowcGsJMJ7ocYxUYg3JbGyKrUoP76oNCe1+BCjNAeLkjjvx9eWiUIC6YklqdmpqQWp
        RTBZJg5OqQYmL2l73ujPe9f89c5f7xIxa5PSftb80/KMFXuMPhznavmZL7L/4sMjbDzG0TwH
        Ld/O/Mv3v/n1J7+9rDu/ZGUuZ3t5+Llj09n95otevkmYtyBa5Kn20qnPS9a4Vr25vM762D3H
        Cp/LLN+0rt3Tazz6909aGcOaELeCa8K/5etqZMxmRSxnD++f/aLuH+eRfcXPKjlNrlSdnvJq
        xs27lUfFJhzi0FNRZZfya4t1P1M2e8HT/BS1DAb3gy5V882uvJcOXOVzPdsvdod332uF2HNr
        JxyykRS4yp7vP/9pf83R0/8+lNznsj1876tkrPD1uJhpdyyVBTUm3DLdwMhw9N/9yEl/Txiw
        /MqWXbD55VXjx0osxRmJhlrMRcWJAPtV58VNAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrHJMWRmVeSWpSXmKPExsWy7bCSvO5nV5dEg+MTuC0u7k61uLftF5vF
        5V1z2Cw+9Dxiszh0ci6jxbrbpxkd2Dz6tqxi9Di6fxGbx+dNcgHMUVw2Kak5mWWpRfp2CVwZ
        B55PYiz4zF6x+zpHA+Nhti5GTg4JAROJzjXPWbsYuTiEBHYwSmyd1MAEkZCWWNL5hh3CFpZY
        +e85O0TRJ0aJRbvugBWxCWhL9M67C2aLCCRL7G6ezghiMwtES/Q8XwUWFxbwlbi+cQaYzSKg
        KjHt/FWwzbwC7hI3T++AukJO4ua5TuYJjDwLGBlWMUqmFhTnpucWGxYY5aWW6xUn5haX5qXr
        JefnbmIEB4mW1g7GPas+6B1iZOJgPMQowcGsJMJ7ocYxUYg3JbGyKrUoP76oNCe1+BCjNAeL
        kjjvha6T8UIC6YklqdmpqQWpRTBZJg5OqQamnklpitsz7z9eeVLgoMrppqvl7kfnvLXTdJt1
        x0/T+eDXX7sLK7ZXaZnsM4zjTvRuDQ9vOnT/em7sRe1wRfNYtwKDw4HfPOa5BZTwFln6ZgUV
        npj2OvLu6fVsUY9nHTPVzFpkF6Fpquu17tkGlfh5VbskHGb1+k+9ujJBY3XI+bg971gMI04f
        4p8qs1og7+32eQ9LLcsaM39K3/pmG3NC3XDjC+8Nhb5qYctXr1VrO75Jbo9m52b3nEcfl87a
        n+u16/TPbwv27/6ne7pkd8nxXTHOGlduPGubYmv5tlnF5/rNY3N4z1yoMM5xsbn61YD5iOea
        V3+1up5f2PX8cn12a1aV3/zXd3zfrPd+zqt0RomlOCPRUIu5qDgRAKnAukOBAgAA
X-CMS-MailID: 20210917073827epcas5p11a811c82ba4c748de3923a62f51250ed
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
X-CMS-RootMailID: 20210917073827epcas5p11a811c82ba4c748de3923a62f51250ed
References: <CGME20210917073827epcas5p11a811c82ba4c748de3923a62f51250ed@epcas5p1.samsung.com>
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Currently in "smack_inode_copy_up()" function, process label is
changed with the label on parent inode. Due to which,
process is assigned directory label and whatever file or directory
created by the process are also getting directory label
which is wrong label.

Changes has been done to use label of overlay inode instead
of parent inode.

Signed-off-by: Vishal Goel <vishal.goel@samsung.com>
---
 security/smack/smack_lsm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index cacbe7518..91e50e5cb 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -4634,7 +4634,7 @@ static int smack_inode_copy_up(struct dentry *dentry, struct cred **new)
 	/*
 	 * Get label from overlay inode and set it in create_sid
 	 */
-	isp = smack_inode(d_inode(dentry->d_parent));
+	isp = smack_inode(d_inode(dentry));
 	skp = isp->smk_inode;
 	tsp->smk_task = skp;
 	*new = new_creds;
-- 
2.17.1

