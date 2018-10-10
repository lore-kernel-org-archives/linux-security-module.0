Return-Path: <SRS0=tN9D=MW=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABAFBC43441
	for <linux-security-module@archiver.kernel.org>; Wed, 10 Oct 2018 10:42:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 567E4214DA
	for <linux-security-module@archiver.kernel.org>; Wed, 10 Oct 2018 10:42:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="x1OiYh7G"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 567E4214DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-security-module-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726617AbeJJSEM (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 10 Oct 2018 14:04:12 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:58450 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726022AbeJJSEM (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 10 Oct 2018 14:04:12 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w9AAYNh1015095;
        Wed, 10 Oct 2018 10:42:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2018-07-02;
 bh=lpY8tD6bdFwnwtV8ZAE2TaUU6IywfzDUlCLJtEzmlPo=;
 b=x1OiYh7GJZ2ZuOSTwMuzKmRe/o8LTj1lZcAFfWj2JjY9XtpPl6dsXcfWpQFK6BQsN1ke
 As+XhLyt0cM1W3mO63da7ryuIcCg8ml8LNQ1FcgEK6hCX8+C9XOzAHn5jO/iKvuAgIgZ
 w12NOsR5bBLaZFLaW6munKsyXBSebMFA2wO7s6ySRKqFHud2qdNPF3mA2+YyK7UZpsza
 bfEFwypDKEntFbsImsOkeMR/yJEORPPlQN4cvlIY/IwNWpYt0x13jxNURMMqv3oa3kEt
 uQ1l5JhvmIqZ+DlMbH5cNfSTr4UtVaVVNpSgJ5XWB1owgosM/NbZS4QzilCfvpuiw4no dw== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by userp2130.oracle.com with ESMTP id 2mxmftu700-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 10 Oct 2018 10:42:35 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w9AAgYua009839
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 10 Oct 2018 10:42:34 GMT
Received: from abhmp0014.oracle.com (abhmp0014.oracle.com [141.146.116.20])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w9AAgYa1005583;
        Wed, 10 Oct 2018 10:42:34 GMT
Received: from mwanda (/197.232.248.111)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 10 Oct 2018 10:42:33 +0000
Date:   Wed, 10 Oct 2018 13:42:28 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     mjg59@google.com
Cc:     linux-security-module@vger.kernel.org
Subject: [bug report] apparmor: Parse secmark policy
Message-ID: <20181010104228.GA15360@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9041 signatures=668706
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=677
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1810100109
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Hello Matthew Garrett,

The patch 9caafbe2b4cf: "apparmor: Parse secmark policy" from May 24,
2018, leads to the following static checker warning:

	security/apparmor/policy_unpack.c:580 unpack_secmark()
	warn: should '(struct aa_profile)->secmark' be freed with kzfree()'

security/apparmor/policy_unpack.c
   558                  profile->secmark_count = size;
   559  
   560                  for (i = 0; i < size; i++) {
   561                          if (!unpack_u8(e, &profile->secmark[i].audit, NULL))
   562                                  goto fail;
   563                          if (!unpack_u8(e, &profile->secmark[i].deny, NULL))
   564                                  goto fail;
   565                          if (!unpack_strdup(e, &profile->secmark[i].label, NULL))
   566                                  goto fail;
   567                  }
   568                  if (!unpack_nameX(e, AA_ARRAYEND, NULL))
   569                          goto fail;
   570                  if (!unpack_nameX(e, AA_STRUCTEND, NULL))
   571                          goto fail;
   572          }
   573  
   574          return 1;
   575  
   576  fail:
   577          if (profile->secmark) {
   578                  for (i = 0; i < size; i++)
   579                          kfree(profile->secmark[i].label);
                                      ^^^^^^^^^^^^^^^^^^^^^^^^^
   580                  kfree(profile->secmark);
                              ^^^^^^^^^^^^^^^^
Smatch thinks that these need to be zeroed for security.  I don't know
the details though.

   581                  profile->secmark_count = 0;
   582          }
   583  
   584          e->pos = pos;
   585          return 0;
   586  }

regards,
dan carpenter
