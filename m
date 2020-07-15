Return-Path: <SRS0=JoCX=A2=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80274C433E3
	for <linux-security-module@archiver.kernel.org>; Wed, 15 Jul 2020 22:28:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4E5412065D
	for <linux-security-module@archiver.kernel.org>; Wed, 15 Jul 2020 22:28:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hxbzXSZ7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726770AbgGOW2r (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 15 Jul 2020 18:28:47 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:59142 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726965AbgGOW2r (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 15 Jul 2020 18:28:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1594852126;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=r7ysqoJ771cWpq2r7U8vAXss+T0bwN4WnRyfVotsoz8=;
        b=hxbzXSZ7LXiPE5d5p+CleAXl/rDJp3mLjsUEF3srx6pC1JnSWzVM7saus+aPA6/AQsvw3j
        f+orP28koUFqKafotD1//5C/KBMuAgtH14ua1WJPBwA9fTeAKgVFjQges4kieFZwbP05Yw
        ezzet+l4ulEniTS01Ln2kchFpHxtI5o=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-31-A0bR1z3CN4aAii1dDZUDNw-1; Wed, 15 Jul 2020 18:28:42 -0400
X-MC-Unique: A0bR1z3CN4aAii1dDZUDNw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A10231083;
        Wed, 15 Jul 2020 22:28:40 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-112-113.rdu2.redhat.com [10.10.112.113])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 64D4110013C2;
        Wed, 15 Jul 2020 22:28:39 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH] keys: asymmetric: fix error return code in
 software_key_query()
From:   David Howells <dhowells@redhat.com>
To:     torvalds@linux-foundation.org
Cc:     Wei Yongjun <weiyongjun1@huawei.com>, dhowells@redhat.com,
        jarkko.sakkinen@linux.intel.com, keyrings@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Wed, 15 Jul 2020 23:28:38 +0100
Message-ID: <159485211858.2340757.9890754969922775496.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.22
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

From: Wei Yongjun <weiyongjun1@huawei.com>

Fix to return negative error code -ENOMEM from kmalloc() error handling
case instead of 0, as done elsewhere in this function.

Fixes: f1774cb8956a ("X.509: parse public key parameters from x509 for akcipher")
Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
Signed-off-by: David Howells <dhowells@redhat.com>
---

 crypto/asymmetric_keys/public_key.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/crypto/asymmetric_keys/public_key.c b/crypto/asymmetric_keys/public_key.c
index d7f43d4ea925..e5fae4e838c0 100644
--- a/crypto/asymmetric_keys/public_key.c
+++ b/crypto/asymmetric_keys/public_key.c
@@ -119,6 +119,7 @@ static int software_key_query(const struct kernel_pkey_params *params,
 	if (IS_ERR(tfm))
 		return PTR_ERR(tfm);
 
+	ret = -ENOMEM;
 	key = kmalloc(pkey->keylen + sizeof(u32) * 2 + pkey->paramlen,
 		      GFP_KERNEL);
 	if (!key)


