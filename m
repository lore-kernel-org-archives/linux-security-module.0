Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2A82C4332D
	for <linux-security-module@archiver.kernel.org>; Tue,  9 Mar 2021 14:46:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 55B866522D
	for <linux-security-module@archiver.kernel.org>; Tue,  9 Mar 2021 14:46:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231532AbhCIOpj (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 9 Mar 2021 09:45:39 -0500
Received: from mailomta8-sa.btinternet.com ([213.120.69.14]:37891 "EHLO
        sa-prd-fep-042.btinternet.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S231254AbhCIOpa (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 9 Mar 2021 09:45:30 -0500
X-Greylist: delayed 325 seconds by postgrey-1.27 at vger.kernel.org; Tue, 09 Mar 2021 09:45:29 EST
Received: from sa-prd-rgout-002.btmx-prd.synchronoss.net ([10.2.38.5])
          by sa-prd-fep-041.btinternet.com with ESMTP
          id <20210309144003.DENC30505.sa-prd-fep-041.btinternet.com@sa-prd-rgout-002.btmx-prd.synchronoss.net>;
          Tue, 9 Mar 2021 14:40:03 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=btinternet.com; s=btmx201904; t=1615300803; 
        bh=PxstithgEvgCLW14hSPz6cRyW63QXoE33eCI61DXYtU=;
        h=From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version;
        b=kdGoZJnm86RIKxhKz70znB1Kbs46zKKBPslIWfUnWnmBhHrqDW2KgNmG5ouHJe0x9M2DMkvAJIz9BFMP032Cy8HMXKiT5Pcpt+8m5zChiZBrG8TBBMWoS9PcQt/a281RNLZ/B8U3McUWdBg1KLVAYxI7pl54RenXm9hHsT77VWXpR35s4rbvzh1pHDyDAZcy6JaH5k1C/WHtSbf2/wTCTjBvTJZwMUf6/8d3FWkJS4f/5otfURvmIONJJB/AleaeronX3pGBVqrhSUwF7DdXO2GlSdckPEc/FO10HBdJqZhI5pCMr3BBqvMYZ8uVMn45KhqYzNeKdi8r+oBYSPaYbw==
Authentication-Results: btinternet.com; none
X-SNCR-Rigid: 6038718301A65378
X-Originating-IP: [86.133.207.84]
X-OWM-Source-IP: 86.133.207.84 (GB)
X-OWM-Env-Sender: richard_c_haines@btinternet.com
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgeduledrudduiedgieejucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuueftkffvkffujffvgffngfevqffopdfqfgfvnecuuegrihhlohhuthemuceftddunecunecujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeftihgthhgrrhguucfjrghinhgvshcuoehrihgthhgrrhgupggtpghhrghinhgvshessghtihhnthgvrhhnvghtrdgtohhmqeenucggtffrrghtthgvrhhnpeeutddtleelheeugefgiefhiedtheeukeffveeitdffgeffieeugeeljeegvefgieenucfkphepkeeirddufeefrddvtdejrdekgeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhephhgvlhhopehlohgtrghlhhhoshhtrdhlohgtrghlughomhgrihhnpdhinhgvthepkeeirddufeefrddvtdejrdekgedpmhgrihhlfhhrohhmpeeorhhitghhrghruggptggphhgrihhnvghssegsthhinhhtvghrnhgvthdrtghomheqpdhrtghpthhtohepoegtrghsvgihsehstghhrghufhhlvghrqdgtrgdrtghomheqpdhrtghpthhtohepoegtohhrsggvtheslhifnhdrnhgvtheqpdhrtghpthhtohepoehjmhhorhhrihhssehnrghmvghirdhorhhgqedprhgtphhtthhopeeolhhinhhugidqughotgesvhhgvghrrdhkvghrnhgvlhdrohhrgheqpdhrtghpthhtohepoehlihhnuhigqdhsvggtuhhrihhthidqmhhoughulhgvsehvghgvrhdrkhgvrhhn
        vghlrdhorhhgqedprhgtphhtthhopeeophgruhhlsehprghulhdqmhhoohhrvgdrtghomheqpdhrtghpthhtohepoehrihgthhgrrhgupggtpghhrghinhgvshessghtihhnthgvrhhnvghtrdgtohhmqecuqfftvefrvfeprhhftgekvddvnehrihgthhgrrhgupggtpghhrghinhgvshessghtihhnthgvrhhnvghtrdgtohhmpdhrtghpthhtohepoehsvghrghgvsehhrghllhihnhdrtghomheq
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
X-SNCR-hdrdom: btinternet.com
Received: from localhost.localdomain (86.133.207.84) by sa-prd-rgout-002.btmx-prd.synchronoss.net (5.8.340) (authenticated as richard_c_haines@btinternet.com)
        id 6038718301A65378; Tue, 9 Mar 2021 14:40:03 +0000
From:   Richard Haines <richard_c_haines@btinternet.com>
To:     linux-security-module@vger.kernel.org, linux-doc@vger.kernel.org
Cc:     corbet@lwn.net, paul@paul-moore.com, jmorris@namei.org,
        serge@hallyn.com, casey@schaufler-ca.com,
        Richard Haines <richard_c_haines@btinternet.com>
Subject: [RFC PATCH 1/3] Documentation/security: Update LSM security hook text
Date:   Tue,  9 Mar 2021 14:39:51 +0000
Message-Id: <20210309143953.142341-2-richard_c_haines@btinternet.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210309143953.142341-1-richard_c_haines@btinternet.com>
References: <20210309143953.142341-1-richard_c_haines@btinternet.com>
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
2.29.2

