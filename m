Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84B6DC433DB
	for <linux-security-module@archiver.kernel.org>; Tue,  9 Mar 2021 14:47:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3C6C06522D
	for <linux-security-module@archiver.kernel.org>; Tue,  9 Mar 2021 14:47:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230325AbhCIOql (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 9 Mar 2021 09:46:41 -0500
Received: from mailomta13-sa.btinternet.com ([213.120.69.19]:57856 "EHLO
        sa-prd-fep-041.btinternet.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S231596AbhCIOqO (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 9 Mar 2021 09:46:14 -0500
Received: from sa-prd-rgout-002.btmx-prd.synchronoss.net ([10.2.38.5])
          by sa-prd-fep-040.btinternet.com with ESMTP
          id <20210309144002.DMPA32153.sa-prd-fep-040.btinternet.com@sa-prd-rgout-002.btmx-prd.synchronoss.net>;
          Tue, 9 Mar 2021 14:40:02 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=btinternet.com; s=btmx201904; t=1615300802; 
        bh=n2nmFWy/2P5LgAC5TNi1QDq/XzLB5HbajAyu+dTZSdM=;
        h=From:To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version;
        b=Nz6bePhWX7oWhRKhW5fih4RqHdynQixWNBnsWxop7LjgbIEnoLBCpnsbUKwIXepppsxW/60P9f0pjRsC5rmLqcp8umsDCEMNeygx31BqukWwVBrHk7uWqP3o2WyjOQxmorxGxGZq7UY805fyf6Wq4b6QQ1sNjOR1Eqq79hoPBkgrxKulHSfUzV6NTxFvJGjV21A2RenaDVNG8zW3MrGpKqCpYrFFI2+pHB2Qvx7n7mmOaVn7EoqhchhvUUTcfw8331TACxZssBHjgHCeJ6aHt0jue1SpplCBTux9iPy1jvTi0/rP4FE0aNB/XGsX6EjqCxll0qijGwqJ0OzyrQht9Q==
Authentication-Results: btinternet.com;
    auth=pass (PLAIN) smtp.auth=richard_c_haines@btinternet.com
X-SNCR-Rigid: 6038718301A65373
X-Originating-IP: [86.133.207.84]
X-OWM-Source-IP: 86.133.207.84 (GB)
X-OWM-Env-Sender: richard_c_haines@btinternet.com
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgeduledrudduiedgieejucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuueftkffvkffujffvgffngfevqffopdfqfgfvnecuuegrihhlohhuthemuceftddunecunecujfgurhephffvufffkffoggfgsedtkeertdertddtnecuhfhrohhmpeftihgthhgrrhguucfjrghinhgvshcuoehrihgthhgrrhgupggtpghhrghinhgvshessghtihhnthgvrhhnvghtrdgtohhmqeenucggtffrrghtthgvrhhnpeelteffgeevveejheevhfetgfeuveduteetuddtffdvjeekieetgeehveefjedtfeenucfkphepkeeirddufeefrddvtdejrdekgeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhephhgvlhhopehlohgtrghlhhhoshhtrdhlohgtrghlughomhgrihhnpdhinhgvthepkeeirddufeefrddvtdejrdekgedpmhgrihhlfhhrohhmpeeorhhitghhrghruggptggphhgrihhnvghssegsthhinhhtvghrnhgvthdrtghomheqpdhrtghpthhtohepoegtrghsvgihsehstghhrghufhhlvghrqdgtrgdrtghomheqpdhrtghpthhtohepoegtohhrsggvtheslhifnhdrnhgvtheqpdhrtghpthhtohepoehjmhhorhhrihhssehnrghmvghirdhorhhgqedprhgtphhtthhopeeolhhinhhugidqughotgesvhhgvghrrdhkvghrnhgvlhdrohhrgheqpdhrtghpthhtohepoehlihhnuhigqdhsvggtuhhrihhthidqmhhoughulhgvsehvghgvrhdrkhgvrhhnvghl
        rdhorhhgqedprhgtphhtthhopeeophgruhhlsehprghulhdqmhhoohhrvgdrtghomheqpdhrtghpthhtohepoehrihgthhgrrhgupggtpghhrghinhgvshessghtihhnthgvrhhnvghtrdgtohhmqecuqfftvefrvfeprhhftgekvddvnehrihgthhgrrhgupggtpghhrghinhgvshessghtihhnthgvrhhnvghtrdgtohhmpdhrtghpthhtohepoehsvghrghgvsehhrghllhihnhdrtghomheq
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
X-SNCR-hdrdom: btinternet.com
Received: from localhost.localdomain (86.133.207.84) by sa-prd-rgout-002.btmx-prd.synchronoss.net (5.8.340) (authenticated as richard_c_haines@btinternet.com)
        id 6038718301A65373; Tue, 9 Mar 2021 14:40:02 +0000
From:   Richard Haines <richard_c_haines@btinternet.com>
To:     linux-security-module@vger.kernel.org, linux-doc@vger.kernel.org
Cc:     corbet@lwn.net, paul@paul-moore.com, jmorris@namei.org,
        serge@hallyn.com, casey@schaufler-ca.com,
        Richard Haines <richard_c_haines@btinternet.com>
Subject: [RFC PATCH 0/3] LSM Documentation - Render lsm_hooks.h for kernel_docs
Date:   Tue,  9 Mar 2021 14:39:50 +0000
Message-Id: <20210309143953.142341-1-richard_c_haines@btinternet.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

This patch series updates the LSM hook text defined in the comments
section of inlcude/linux/lsm_hooks.h. This enables the hook functions to
be rendered in kernel_docs html or pdf format.

Note that no text has been changed in lsm_hooks.h, only formatting
to render the text.

To get the correct rendering some lines have exceeded checkpatch limits and
therefore has a moan. The function statements seem to need being a
continuous line. The others can be split, but decided not to.
Any better ideas ??

The hook functions render in HTML ok, however in PDF format the only issue
is that the long function definitions do not wrap and therefore truncated.
Check the 'int sb_mount(const char *dev_name' entry in:
Documentation/output/pdf/security.pdf

For reference two hooks have been marked as deprecated: sb_copy_data() and
sb_parse_opts_str()

Tested using 'make pdfdocs' and 'make htmldocs'

Richard Haines (3):
  Documentation/security: Update LSM security hook text
  include/linux: Update LSM hook text part1
  include/linux: Update LSM hook text part2

 Documentation/security/lsm-development.rst |    5 +-
 include/linux/lsm_hooks.h                  | 2365 +++++++++++---------
 2 files changed, 1364 insertions(+), 1006 deletions(-)

-- 
2.29.2

