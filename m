Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4242AC433E0
	for <linux-security-module@archiver.kernel.org>; Mon, 15 Feb 2021 10:26:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ED71E64E04
	for <linux-security-module@archiver.kernel.org>; Mon, 15 Feb 2021 10:26:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230134AbhBOK0u (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 15 Feb 2021 05:26:50 -0500
Received: from mout.kundenserver.de ([212.227.17.10]:39939 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230163AbhBOK0f (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 15 Feb 2021 05:26:35 -0500
Received: from weisslap.aisec.fraunhofer.de ([146.52.20.127]) by
 mrelayeu.kundenserver.de (mreue106 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1Mj831-1lqj5T1yVh-00f7aH; Mon, 15 Feb 2021 11:23:30 +0100
From:   =?UTF-8?q?Michael=20Wei=C3=9F?= <michael.weiss@aisec.fraunhofer.de>
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     linux-integrity@vger.kernel.org,
        =?UTF-8?q?Michael=20Wei=C3=9F?= <michael.weiss@aisec.fraunhofer.de>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] integrity/ima: Provide Kconfig option for ima-modsig template
Date:   Mon, 15 Feb 2021 11:23:05 +0100
Message-Id: <20210215102305.10722-1-michael.weiss@aisec.fraunhofer.de>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:Tj1jVlPN+On9YTD2FDue8BmSoZGSwbmt9Z6n49BR9gKZiDp2aFI
 sfSaBVdsYgtmLzMAPEQuFNl+Dl4UwL8WWz/4yTOYQQF8P/AKbtRzj8l5dej+bxrtbDGydsp
 apHdJHqm4l4naX73lAikLOHtoLwma32gWAlmtc1DrzyTRyyroSnaKzX6tFptz2QuC7jMtHM
 2e9BEmkJrCuoZ96XpyFyw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:J3DaKQuyKxU=:0BiWYf46e9gBiOpinzbJT1
 PGiZCPorWxRNz3TFFDPVejtiv7bMjJnpT4LqGS8KW1H2KV4xDAoe71UnYWBHmX0QM15H0fanC
 jxFw8+H+8uAlMkmwvLY2bjmiK0GGfrYIGwsClkabE6FLeKUNUZNG+vt+hOYihHYQlAKd6nGJl
 VSj4IT16bQUASGRGgD+BiaQxD/YHzVRjoXxETxgNTQuo20A9hyrzfWw5TQGyavr7YJOcJKF+E
 O+bO0F32Z/PFW2IusZULJw3Dm/DqVs/A6zy+ik3ph2+L9CAH5D3xavwdSBT6HOivYS6w8qkWL
 nmthSmnAKnXH7cfDzVqmf/139pVsxQQE9aQ2kH1JU62/JTQJsExw64goTDj7mpwkmSa/Tr2CN
 V3TfhbqknvuljL5O4E1n7S93GnUb6BPiYTSzKY/G/BWUfGbayToyxfiioR3wJgX1UumhGIJEK
 ZGnTV+JVSw==
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

'ima-modsig' was not in the list of selectable templates in Kconfig.
The missing Kconfig options were added to support the ima-modsig
template as default template.

Signed-off-by: Michael Weiß <michael.weiss@aisec.fraunhofer.de>
---
 security/integrity/ima/Kconfig | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/security/integrity/ima/Kconfig b/security/integrity/ima/Kconfig
index 12e9250c1bec..32b9325f49bf 100644
--- a/security/integrity/ima/Kconfig
+++ b/security/integrity/ima/Kconfig
@@ -78,6 +78,8 @@ choice
 		bool "ima-ng (default)"
 	config IMA_SIG_TEMPLATE
 		bool "ima-sig"
+	config IMA_MODSIG_TEMPLATE
+		bool "ima-modsig"
 endchoice
 
 config IMA_DEFAULT_TEMPLATE
@@ -86,6 +88,7 @@ config IMA_DEFAULT_TEMPLATE
 	default "ima" if IMA_TEMPLATE
 	default "ima-ng" if IMA_NG_TEMPLATE
 	default "ima-sig" if IMA_SIG_TEMPLATE
+	default "ima-modsig" if IMA_MODSIG_TEMPLATE
 
 choice
 	prompt "Default integrity hash algorithm"
-- 
2.20.1

