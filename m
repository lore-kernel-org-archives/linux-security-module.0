Return-Path: <SRS0=tahD=X2=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15B9CECE58A
	for <linux-security-module@archiver.kernel.org>; Tue,  1 Oct 2019 16:58:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D345421855
	for <linux-security-module@archiver.kernel.org>; Tue,  1 Oct 2019 16:58:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569949133;
	bh=6vs+mxOj8LdnxQhig/ZrlnZJRypReXhz9Lk/p8RpLM8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=paggsNB8ZNrpPGx2OdLg6Bq6IVmPJp7gCsbnOyhubqrBsR3LdPGrn1Sz3e98973zm
	 AjkoU0Az1KYT3IUkDpq7rnaxIWOJytAU0SMUxXgWzQsSCt6bqSfohC9+1UsYBGOR/I
	 d5g8vPn2GdC+o5nslRY3WJHSnVZ4fQCx7SkXbsk0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729564AbfJAQ6w (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 1 Oct 2019 12:58:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:53012 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730941AbfJAQl3 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 1 Oct 2019 12:41:29 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D1DB32168B;
        Tue,  1 Oct 2019 16:41:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569948088;
        bh=6vs+mxOj8LdnxQhig/ZrlnZJRypReXhz9Lk/p8RpLM8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qbfGs+npIO3cHCmu/sZF3MGlvzQ6LFbAjW91OpFuWCtHHw9jzaaSyORfWmBOp+hKl
         zcJflDo8YglPt6bCt1Wqfr1XD3DplK171SeRucuM2vYUj3KBr9dKkQz2pckScYTkzm
         c12DH/4sx3BCTZrdcHaHMeyNk0F/tD5SQD+GOLIQ=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Sascha Hauer <s.hauer@pengutronix.de>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Sasha Levin <sashal@kernel.org>,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org
Subject: [PATCH AUTOSEL 5.2 02/63] ima: always return negative code for error
Date:   Tue,  1 Oct 2019 12:40:24 -0400
Message-Id: <20191001164125.15398-2-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191001164125.15398-1-sashal@kernel.org>
References: <20191001164125.15398-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

From: Sascha Hauer <s.hauer@pengutronix.de>

[ Upstream commit f5e1040196dbfe14c77ce3dfe3b7b08d2d961e88 ]

integrity_kernel_read() returns the number of bytes read. If this is
a short read then this positive value is returned from
ima_calc_file_hash_atfm(). Currently this is only indirectly called from
ima_calc_file_hash() and this function only tests for the return value
being zero or nonzero and also doesn't forward the return value.
Nevertheless there's no point in returning a positive value as an error,
so translate a short read into -EINVAL.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 security/integrity/ima/ima_crypto.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/security/integrity/ima/ima_crypto.c b/security/integrity/ima/ima_crypto.c
index d4c7b8e1b083d..7532b062be594 100644
--- a/security/integrity/ima/ima_crypto.c
+++ b/security/integrity/ima/ima_crypto.c
@@ -268,8 +268,11 @@ static int ima_calc_file_hash_atfm(struct file *file,
 		rbuf_len = min_t(loff_t, i_size - offset, rbuf_size[active]);
 		rc = integrity_kernel_read(file, offset, rbuf[active],
 					   rbuf_len);
-		if (rc != rbuf_len)
+		if (rc != rbuf_len) {
+			if (rc >= 0)
+				rc = -EINVAL;
 			goto out3;
+		}
 
 		if (rbuf[1] && offset) {
 			/* Using two buffers, and it is not the first
-- 
2.20.1

