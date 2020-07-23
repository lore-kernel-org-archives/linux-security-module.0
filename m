Return-Path: <SRS0=LdBn=BC=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FAD9C433EA
	for <linux-security-module@archiver.kernel.org>; Thu, 23 Jul 2020 15:22:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2DCFE20771
	for <linux-security-module@archiver.kernel.org>; Thu, 23 Jul 2020 15:22:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="clyq7lFo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729548AbgGWPWm (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 23 Jul 2020 11:22:42 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:50976 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725808AbgGWPWm (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 23 Jul 2020 11:22:42 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06NFMPO7079280;
        Thu, 23 Jul 2020 15:22:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type : in-reply-to;
 s=corp-2020-01-29; bh=FQoH8PZdFrtXDF0CKE9wBRE+k2081C1vXYNww8W4egE=;
 b=clyq7lFojSeJAVNdRMUhev37xl1pPQTz7bRboKM8hgZzqDGHiTgt7vnM5+5aZAKojQnC
 S2KNq8/yb3jRYYpwBrKb7wwZWY0hzF608Urf44QhAMZaEt6dHXEDm1s7vZh2khu7+dYL
 FJF1Nc6HG94fJRYUDSFFBcdESghhaH7ZUAYanzEGGBjHpiuqWIaKdmRZMOE8XCEMZeLF
 05Dxaw1zq9+cw/RSUSAdB7Nfc56bc5ZQ+FsrEPwB7b3UUcbaDTDLmDxAFvv4qjWPepCq
 PfNd38a4j83RRXYSxQcI0D3QryUPfsNgsMmFy6ShSbKM6EeoEO6RChG+2zE8FmDHcstI Ng== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 32brgrt2g4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 23 Jul 2020 15:22:29 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06NFEPsc117761;
        Thu, 23 Jul 2020 15:22:28 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3020.oracle.com with ESMTP id 32fc5nn4u2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 23 Jul 2020 15:22:28 +0000
Received: from abhmp0009.oracle.com (abhmp0009.oracle.com [141.146.116.15])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 06NFMQZb032275;
        Thu, 23 Jul 2020 15:22:26 GMT
Received: from mwanda (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 23 Jul 2020 08:22:25 -0700
Date:   Thu, 23 Jul 2020 18:22:19 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Subject: [PATCH 1/2] Smack: fix another vsscanf out of bounds
Message-ID: <20200723152219.GA302005@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000000000000d282bd05ab0bf532@google.com>
X-Mailer: git-send-email haha only kidding
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9691 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 phishscore=0 mlxscore=0 suspectscore=0 spamscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2007230114
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9691 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0 spamscore=0
 impostorscore=0 suspectscore=0 adultscore=0 clxscore=1011 mlxlogscore=999
 priorityscore=1501 phishscore=0 lowpriorityscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2007230115
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

This is similar to commit 84e99e58e8d1 ("Smack: slab-out-of-bounds in
vsscanf") where we added a bounds check on "rule".

Reported-by: syzbot+a22c6092d003d6fe1122@syzkaller.appspotmail.com
Fixes: f7112e6c9abf ("Smack: allow for significantly longer Smack labels v4")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
This check is very straight forward and should fix the bug.  But if you
look at the fixes tag we used to rely on the check:

	if (count != (SMK_CIPSOMIN + catlen * SMK_DIGITLEN))

and now that has been changed to:

	if (format == SMK_FIXED24_FMT &&
	    count != (SMK_CIPSOMIN + catlen * SMK_DIGITLEN))
                goto out;

so it doesn't apply for every format.

 security/smack/smackfs.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/security/smack/smackfs.c b/security/smack/smackfs.c
index c21b656b3263..81c6ceeaa4f9 100644
--- a/security/smack/smackfs.c
+++ b/security/smack/smackfs.c
@@ -905,6 +905,10 @@ static ssize_t smk_set_cipso(struct file *file, const char __user *buf,
 
 	for (i = 0; i < catlen; i++) {
 		rule += SMK_DIGITLEN;
+		if (rule > data + count) {
+			rc = -EOVERFLOW;
+			goto out;
+		}
 		ret = sscanf(rule, "%u", &cat);
 		if (ret != 1 || cat > SMACK_CIPSO_MAXCATNUM)
 			goto out;
-- 
2.27.0

