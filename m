Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 815F1C433ED
	for <linux-security-module@archiver.kernel.org>; Fri, 16 Apr 2021 12:28:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 585AB611AF
	for <linux-security-module@archiver.kernel.org>; Fri, 16 Apr 2021 12:28:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243530AbhDPM3U (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 16 Apr 2021 08:29:20 -0400
Received: from mailomta23-re.btinternet.com ([213.120.69.116]:38907 "EHLO
        re-prd-fep-047.btinternet.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S243485AbhDPM3R (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 16 Apr 2021 08:29:17 -0400
Received: from re-prd-rgout-002.btmx-prd.synchronoss.net ([10.2.54.5])
          by re-prd-fep-047.btinternet.com with ESMTP
          id <20210416122851.PEFJ28099.re-prd-fep-047.btinternet.com@re-prd-rgout-002.btmx-prd.synchronoss.net>;
          Fri, 16 Apr 2021 13:28:51 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=btinternet.com; s=btmx201904; t=1618576131; 
        bh=UKwPGuS6hHKi/vOoUL4sIZTkf0ALcnjL8Vg71k+LWYA=;
        h=From:To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version;
        b=QR4c9TjvjzuRDSE/qTwvtZ7Ss9Xdo70TFGZgj0Ru5M+79hQAm3OqRyRUHUPG6/iF+ou2R2MwVLnnLFBM4+Cwp5ByELKRCYi2lCqk3/VqtIFr8AfjKfgO+SHB5ZXGFgGeVeIfj7xm8QEK743ikyFxKVLOMG1oyM5lPt6EVkiiFg8mi4IvY9SsgzT3c/IQKRaLE0T7ptd+NbQpOdo5nMZv40PzdxeYRasG/eHOlK5se/rwZSlougw37SXSIYuwhPh/Prbr2H4iKr3FvriyYIqi8VsLFyr+j6NzrL2EgCtqFEOqa/eQOlGkBufDTrKw8fFMgHDPB4n0D2l5egsBh2FFHA==
Authentication-Results: btinternet.com;
    auth=pass (PLAIN) smtp.auth=richard_c_haines@btinternet.com
X-SNCR-Rigid: 5ED9C0CC2F248680
X-Originating-IP: [86.184.99.58]
X-OWM-Source-IP: 86.184.99.58 (GB)
X-OWM-Env-Sender: richard_c_haines@btinternet.com
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgeduledrudelhedgheefucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuueftkffvkffujffvgffngfevqffopdfqfgfvnecuuegrihhlohhuthemuceftddunecunecujfgurhephffvufffkffoggfgsedtkeertdertddtnecuhfhrohhmpeftihgthhgrrhguucfjrghinhgvshcuoehrihgthhgrrhgupggtpghhrghinhgvshessghtihhnthgvrhhnvghtrdgtohhmqeenucggtffrrghtthgvrhhnpeelteffgeevveejheevhfetgfeuveduteetuddtffdvjeekieetgeehveefjedtfeenucfkphepkeeirddukeegrdelledrheeknecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehhvghloheplhhotggrlhhhohhsthdrlhhotggrlhguohhmrghinhdpihhnvghtpeekiedrudekgedrleelrdehkedpmhgrihhlfhhrohhmpeeorhhitghhrghruggptggphhgrihhnvghssegsthhinhhtvghrnhgvthdrtghomheqpdhrtghpthhtohepoegtrghsvgihsehstghhrghufhhlvghrqdgtrgdrtghomheqpdhrtghpthhtohepoegtohhrsggvtheslhifnhdrnhgvtheqpdhrtghpthhtohepoehjmhhorhhrihhssehnrghmvghirdhorhhgqedprhgtphhtthhopeeolhhinhhugidqughotgesvhhgvghrrdhkvghrnhgvlhdrohhrgheqpdhrtghpthhtohepoehlihhnuhigqdhsvggtuhhrihhthidqmhhoughulhgvsehvghgvrhdrkhgvrhhnvghlrdho
        rhhgqedprhgtphhtthhopeeophgruhhlsehprghulhdqmhhoohhrvgdrtghomheqpdhrtghpthhtohepoehrihgthhgrrhgupggtpghhrghinhgvshessghtihhnthgvrhhnvghtrdgtohhmqecuqfftvefrvfeprhhftgekvddvnehrihgthhgrrhgupggtpghhrghinhgvshessghtihhnthgvrhhnvghtrdgtohhmpdhrtghpthhtohepoehsvghrghgvsehhrghllhihnhdrtghomheq
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
X-SNCR-hdrdom: btinternet.com
Received: from localhost.localdomain (86.184.99.58) by re-prd-rgout-002.btmx-prd.synchronoss.net (5.8.340) (authenticated as richard_c_haines@btinternet.com)
        id 5ED9C0CC2F248680; Fri, 16 Apr 2021 13:28:51 +0100
From:   Richard Haines <richard_c_haines@btinternet.com>
To:     linux-security-module@vger.kernel.org, linux-doc@vger.kernel.org
Cc:     corbet@lwn.net, paul@paul-moore.com, jmorris@namei.org,
        serge@hallyn.com, casey@schaufler-ca.com,
        Richard Haines <richard_c_haines@btinternet.com>
Subject: [PATCH 0/3] LSM Documentation - Render lsm_hooks.h for kernel_docs
Date:   Fri, 16 Apr 2021 13:28:40 +0100
Message-Id: <20210416122843.4752-1-richard_c_haines@btinternet.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

This patch series updates the LSM hook text defined in the comments
section of inlcude/linux/lsm_hooks.h. This enables the hook functions to
be rendered in kernel_docs html or pdf format.

Note that no text has been changed in lsm_hooks.h, only formatting
to render the text.

For reference two hooks have been marked as deprecated: sb_copy_data() and
sb_parse_opts_str()

Tested using 'make pdfdocs' and 'make htmldocs'

Change from RFC patch: Rebased on 5.12-rc7

Richard Haines (3):
  Documentation/security: Update LSM security hook text
  include/linux: Update LSM hook text part1
  include/linux: Update LSM hook text part2

 Documentation/security/lsm-development.rst |    5 +-
 include/linux/lsm_hooks.h                  | 2365 +++++++++++---------
 2 files changed, 1364 insertions(+), 1006 deletions(-)

-- 
2.30.2

