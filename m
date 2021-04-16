Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D5D9C433B4
	for <linux-security-module@archiver.kernel.org>; Fri, 16 Apr 2021 12:30:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DDFF7611AE
	for <linux-security-module@archiver.kernel.org>; Fri, 16 Apr 2021 12:30:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235074AbhDPMat (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 16 Apr 2021 08:30:49 -0400
Received: from mailomta12-re.btinternet.com ([213.120.69.105]:56797 "EHLO
        re-prd-fep-046.btinternet.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S243484AbhDPM3R (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 16 Apr 2021 08:29:17 -0400
Received: from re-prd-rgout-002.btmx-prd.synchronoss.net ([10.2.54.5])
          by re-prd-fep-046.btinternet.com with ESMTP
          id <20210416122851.VNGL3547.re-prd-fep-046.btinternet.com@re-prd-rgout-002.btmx-prd.synchronoss.net>;
          Fri, 16 Apr 2021 13:28:51 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=btinternet.com; s=btmx201904; t=1618576131; 
        bh=Yzbq3tnFV9EKG+e9MnzyPWJ/lOYbRA/QGHWxjL55i9Y=;
        h=From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version;
        b=fQAYwxn76yTvS6uJAgbyQuOLrAmOWpkXKXJTlUdGGoe5Da/VGatS6YN4q0NLEEEfZzkD8TCK9XioX/wGtZiuabVNAUYBNCIHEmeQOh69sRYI80dCeddt6GfIzikA0YsvY+d54ELBLo5K9TX0kHi/t0wYoRjmkFrdt7fWe71BFJltEQjgcUUQv0sU4mNpJzeQDbyTSQj50OgwjLVgLrJ0ud8JNQsip7/ll592RZVR0QTGbSed4RfsbtnbKXYFFy20ze9u2iJJ1HmbXX2M+ZZtMT+3R8dK9AShFH6cxLoVQEOb/wAXlmvY/g/dAWA+4FU3hbxRilEM96vcRZi5psrAtA==
Authentication-Results: btinternet.com; none
X-SNCR-Rigid: 5ED9C0CC2F24868F
X-Originating-IP: [86.184.99.58]
X-OWM-Source-IP: 86.184.99.58 (GB)
X-OWM-Env-Sender: richard_c_haines@btinternet.com
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgeduledrudelhedgheefucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuueftkffvkffujffvgffngfevqffopdfqfgfvnecuuegrihhlohhuthemuceftddunecunecujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeftihgthhgrrhguucfjrghinhgvshcuoehrihgthhgrrhgupggtpghhrghinhgvshessghtihhnthgvrhhnvghtrdgtohhmqeenucggtffrrghtthgvrhhnpeeutddtleelheeugefgiefhiedtheeukeffveeitdffgeffieeugeeljeegvefgieenucfkphepkeeirddukeegrdelledrheeknecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehhvghloheplhhotggrlhhhohhsthdrlhhotggrlhguohhmrghinhdpihhnvghtpeekiedrudekgedrleelrdehkedpmhgrihhlfhhrohhmpeeorhhitghhrghruggptggphhgrihhnvghssegsthhinhhtvghrnhgvthdrtghomheqpdhrtghpthhtohepoegtrghsvgihsehstghhrghufhhlvghrqdgtrgdrtghomheqpdhrtghpthhtohepoegtohhrsggvtheslhifnhdrnhgvtheqpdhrtghpthhtohepoehjmhhorhhrihhssehnrghmvghirdhorhhgqedprhgtphhtthhopeeolhhinhhugidqughotgesvhhgvghrrdhkvghrnhgvlhdrohhrgheqpdhrtghpthhtohepoehlihhnuhigqdhsvggtuhhrihhthidqmhhoughulhgvsehvghgvrhdrkhgvrhhnvghl
        rdhorhhgqedprhgtphhtthhopeeophgruhhlsehprghulhdqmhhoohhrvgdrtghomheqpdhrtghpthhtohepoehrihgthhgrrhgupggtpghhrghinhgvshessghtihhnthgvrhhnvghtrdgtohhmqecuqfftvefrvfeprhhftgekvddvnehrihgthhgrrhgupggtpghhrghinhgvshessghtihhnthgvrhhnvghtrdgtohhmpdhrtghpthhtohepoehsvghrghgvsehhrghllhihnhdrtghomheq
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
X-SNCR-hdrdom: btinternet.com
Received: from localhost.localdomain (86.184.99.58) by re-prd-rgout-002.btmx-prd.synchronoss.net (5.8.340) (authenticated as richard_c_haines@btinternet.com)
        id 5ED9C0CC2F24868F; Fri, 16 Apr 2021 13:28:51 +0100
From:   Richard Haines <richard_c_haines@btinternet.com>
To:     linux-security-module@vger.kernel.org, linux-doc@vger.kernel.org
Cc:     corbet@lwn.net, paul@paul-moore.com, jmorris@namei.org,
        serge@hallyn.com, casey@schaufler-ca.com,
        Richard Haines <richard_c_haines@btinternet.com>
Subject: [PATCH 1/3] Documentation/security: Update LSM security hook text
Date:   Fri, 16 Apr 2021 13:28:41 +0100
Message-Id: <20210416122843.4752-2-richard_c_haines@btinternet.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210416122843.4752-1-richard_c_haines@btinternet.com>
References: <20210416122843.4752-1-richard_c_haines@btinternet.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

This patch series updates the LSM hook text defined in the comments
section of inlcude/linux/lsm_hooks.h.

This enables the hook functions to be rendered in kernel_docs html or
pdf format.

Note that no text has been changed in lsm_hooks.h, only formatting
to render the text.

Signed-off-by: Richard Haines <richard_c_haines@btinternet.com>
---
 Documentation/security/lsm-development.rst | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/Documentation/security/lsm-development.rst b/Documentation/security/lsm-development.rst
index ac53e5065..f85897814 100644
--- a/Documentation/security/lsm-development.rst
+++ b/Documentation/security/lsm-development.rst
@@ -11,7 +11,10 @@ that end users and distros can make a more informed decision about which
 LSMs suit their requirements.
 
 For extensive documentation on the available LSM hook interfaces, please
-see ``include/linux/lsm_hooks.h`` and associated structures:
+see ``include/linux/lsm_hooks.h`` and associated structures.
+
+The LSM hooks are described below in the ``RET (*NAME)(__VA_ARGS__)`` format
+under the `Description` header.
 
 .. kernel-doc:: include/linux/lsm_hooks.h
    :internal:
-- 
2.30.2

