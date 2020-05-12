Return-Path: <SRS0=p3Qd=62=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FA55C54E8B
	for <linux-security-module@archiver.kernel.org>; Tue, 12 May 2020 10:51:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5F247206D6
	for <linux-security-module@archiver.kernel.org>; Tue, 12 May 2020 10:51:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="sWtwsGuw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728371AbgELKvt (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 12 May 2020 06:51:49 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:38240 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726193AbgELKvt (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 12 May 2020 06:51:49 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 04CAmH8D029284;
        Tue, 12 May 2020 10:48:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2020-01-29;
 bh=wVc9fpSrodGxYb5RZEktGgdm8O/3nO6kNy0sc9lTw+0=;
 b=sWtwsGuwod2beAvzDczkLArxcbMvXsPNDHE4njhlEO55htEluwHx9hnRFuTcFngv6qdW
 9E2puxiexZz43RFWA7YnVA9xVhrYAmelrRq5e03EWUfQhBOXC1gKcuw//iMinBJ6hoQF
 3A6bT3Z/BQ0PAnuIFoeAf9k6kR/XE5JHzOU9kz2cCOV6nCF7Vvk9hb4Gm+fsyNlU5fKJ
 RPhZJdFaIJKi/ZC3Ryi2aQCmpOgogqUeuaKgjvtCsYib018NKcCyI7otC0HpkHN3HxRZ
 Mz412ehNx9Zl5talbtqkFsHCLyPjJ3TBnXZMcWUTi/TxPx5wzpnDW0U8BbWN62jNWfDd yA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 30x3gmj8j6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 12 May 2020 10:48:19 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 04CAMZKF039405;
        Tue, 12 May 2020 10:48:18 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3020.oracle.com with ESMTP id 30xbgj4f65-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 May 2020 10:48:18 +0000
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 04CAmGEX021124;
        Tue, 12 May 2020 10:48:17 GMT
Received: from mwanda (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 12 May 2020 03:48:16 -0700
Date:   Tue, 12 May 2020 13:48:09 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     roberto.sassu@huawei.com
Cc:     linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org
Subject: [bug report] evm: Check also if *tfm is an error pointer in
 init_desc()
Message-ID: <20200512104809.GA262740@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9618 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxlogscore=999
 spamscore=0 suspectscore=10 phishscore=0 bulkscore=0 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2005120078
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9618 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxlogscore=999
 clxscore=1011 spamscore=0 lowpriorityscore=0 phishscore=0 bulkscore=0
 malwarescore=0 priorityscore=1501 mlxscore=0 suspectscore=10
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2005120079
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Hello Roberto Sassu,

The patch 53de3b080d5e: "evm: Check also if *tfm is an error pointer
in init_desc()" from Apr 27, 2020, leads to the following static
checker warning:

	security/integrity/evm/evm_crypto.c:119 init_desc()
	error: '*tfm' dereferencing possible ERR_PTR()

security/integrity/evm/evm_crypto.c
    89  
    90                  tfm = &evm_tfm[hash_algo];
    91                  algo = hash_algo_name[hash_algo];
    92          }
    93  
    94          if (IS_ERR_OR_NULL(*tfm)) {

This used to be a "if (!*tfm)" check.

    95                  mutex_lock(&mutex);
    96                  if (*tfm)
    97                          goto out;

Then we test again with the lock held.  But in the new code if "*tfm"
is an error pointer then we jump directly to the unlock and crash on the
next line.  I can't see how the commit would fix anything.

    98                  *tfm = crypto_alloc_shash(algo, 0, CRYPTO_NOLOAD);
    99                  if (IS_ERR(*tfm)) {
   100                          rc = PTR_ERR(*tfm);
   101                          pr_err("Can not allocate %s (reason: %ld)\n", algo, rc);
   102                          *tfm = NULL;
   103                          mutex_unlock(&mutex);
   104                          return ERR_PTR(rc);
   105                  }
   106                  if (type == EVM_XATTR_HMAC) {
   107                          rc = crypto_shash_setkey(*tfm, evmkey, evmkey_len);
   108                          if (rc) {
   109                                  crypto_free_shash(*tfm);
   110                                  *tfm = NULL;
   111                                  mutex_unlock(&mutex);
   112                                  return ERR_PTR(rc);
   113                          }
   114                  }
   115  out:
   116                  mutex_unlock(&mutex);
   117          }
   118  
   119          desc = kmalloc(sizeof(*desc) + crypto_shash_descsize(*tfm),
                                                                     ^^^^
I don't understand how using *tfm outside of a lock is safe at all
anyway.

   120                          GFP_KERNEL);
   121          if (!desc)
   122                  return ERR_PTR(-ENOMEM);
   123  

regards,
dan carpenter
