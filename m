Return-Path: <SRS0=daWi=T5=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88F4AC28CC0
	for <linux-security-module@archiver.kernel.org>; Wed, 29 May 2019 17:17:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68E5F23F25
	for <linux-security-module@archiver.kernel.org>; Wed, 29 May 2019 17:17:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726099AbfE2RRu (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 29 May 2019 13:17:50 -0400
Received: from gateway20.websitewelcome.com ([192.185.59.4]:23512 "EHLO
        gateway20.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725917AbfE2RRu (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 29 May 2019 13:17:50 -0400
X-Greylist: delayed 1445 seconds by postgrey-1.27 at vger.kernel.org; Wed, 29 May 2019 13:17:50 EDT
Received: from cm11.websitewelcome.com (cm11.websitewelcome.com [100.42.49.5])
        by gateway20.websitewelcome.com (Postfix) with ESMTP id 663F2400C6FD4
        for <linux-security-module@vger.kernel.org>; Wed, 29 May 2019 10:53:24 -0500 (CDT)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id W1phhRrL6dnCeW1phh6cK0; Wed, 29 May 2019 11:53:45 -0500
X-Authority-Reason: nr=8
Received: from [189.250.47.159] (port=50894 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.91)
        (envelope-from <gustavo@embeddedor.com>)
        id 1hW1pf-002Frw-RX; Wed, 29 May 2019 11:53:44 -0500
Date:   Wed, 29 May 2019 11:53:43 -0500
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     Mimi Zohar <zohar@linux.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>
Cc:     linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH] ima: use struct_size() in kzalloc()
Message-ID: <20190529165343.GA2584@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 189.250.47.159
X-Source-L: No
X-Exim-ID: 1hW1pf-002Frw-RX
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [189.250.47.159]:50894
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 15
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

One of the more common cases of allocation size calculations is finding
the size of a structure that has a zero-sized array at the end, along
with memory for some number of elements for that array. For example:

struct foo {
   int stuff;
   struct boo entry[];
};

instance = kzalloc(sizeof(struct foo) + count * sizeof(struct boo), GFP_KERNEL);

Instead of leaving these open-coded and prone to type mistakes, we can
now use the new struct_size() helper:

instance = kzalloc(struct_size(instance, entry, count), GFP_KERNEL);

This code was detected with the help of Coccinelle.

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 security/integrity/ima/ima_template.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/security/integrity/ima/ima_template.c b/security/integrity/ima/ima_template.c
index b631b8bc7624..b945dff2ed14 100644
--- a/security/integrity/ima/ima_template.c
+++ b/security/integrity/ima/ima_template.c
@@ -281,9 +281,8 @@ static int ima_restore_template_data(struct ima_template_desc *template_desc,
 	int ret = 0;
 	int i;
 
-	*entry = kzalloc(sizeof(**entry) +
-		    template_desc->num_fields * sizeof(struct ima_field_data),
-		    GFP_NOFS);
+	*entry = kzalloc(struct_size(*entry, template_data,
+				     template_desc->num_fields), GFP_NOFS);
 	if (!*entry)
 		return -ENOMEM;
 
-- 
2.21.0

