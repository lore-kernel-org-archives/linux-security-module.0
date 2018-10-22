Return-Path: <SRS0=zjoR=NC=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 091E1C67863
	for <linux-security-module@archiver.kernel.org>; Mon, 22 Oct 2018 07:39:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD69320779
	for <linux-security-module@archiver.kernel.org>; Mon, 22 Oct 2018 07:39:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="S6YK+fcN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD69320779
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=HansenPartnership.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-security-module-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727458AbeJVP5Q (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 22 Oct 2018 11:57:16 -0400
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:49718 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727135AbeJVP5Q (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 22 Oct 2018 11:57:16 -0400
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id BB1C68EE0FC;
        Mon, 22 Oct 2018 00:39:54 -0700 (PDT)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id tiZEVSCX4YlF; Mon, 22 Oct 2018 00:39:54 -0700 (PDT)
Received: from [172.20.48.127] (unknown [62.232.21.219])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 548CC8EE02B;
        Mon, 22 Oct 2018 00:39:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1540193994;
        bh=tH9nL1PHeJPUUsYyaRgxhyUs82JiWIIbsXwj/BZusjo=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=S6YK+fcN1z/p0FL3z4IxOCd0+SqjNBDUv8GFqsdSD7dMBFLZ4TGg5UkBfjoYoOcJQ
         gOOKaYdCFtbwHhd2xw1vuXN6PEBP4jiTxoCqoQxirgnK+RXr+UY1/T5MO3k3BTEb4C
         girKevzi+tiJYToHeCpxToEaDJFMSC9ASDXlY1Oc=
Message-ID: <1540193990.3202.15.camel@HansenPartnership.com>
Subject: [PATCH v4 6/7] tpm: add the null key name as a tpm2 sysfs variable
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     linux-integrity@vger.kernel.org
Cc:     linux-crypto@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Mon, 22 Oct 2018 08:39:50 +0100
In-Reply-To: <1540193596.3202.7.camel@HansenPartnership.com>
References: <1540193596.3202.7.camel@HansenPartnership.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

This is the last component of encrypted tpm2 session handling that
allows us to verify from userspace that the key derived from the NULL
seed genuinely belongs to the TPM and has not been spoofed.

The procedure for doing this involves creating an attestation identity
key (which requires verification of the TPM EK certificate) and then
using that AIK to sign a certification of the Elliptic Curve key over
the NULL seed.  Userspace must create this EC Key using the parameters
prescribed in TCG TPM v2.0 Provisioning Guidance for the SRK ECC; if
this is done correctly the names will match and the TPM can then run a
TPM2_Certify operation on this derived primary key using the newly
created AIK.

Signed-off-by: James Bottomley <James.Bottomley@HansenPartnership.com>
---
 drivers/char/tpm/tpm-sysfs.c | 27 ++++++++++++++++++++++++++-
 1 file changed, 26 insertions(+), 1 deletion(-)

diff --git a/drivers/char/tpm/tpm-sysfs.c b/drivers/char/tpm/tpm-sysfs.c
index 83a77a445538..7e901d9e893e 100644
--- a/drivers/char/tpm/tpm-sysfs.c
+++ b/drivers/char/tpm/tpm-sysfs.c
@@ -284,6 +284,19 @@ static ssize_t timeouts_show(struct device *dev, struct device_attribute *attr,
 }
 static DEVICE_ATTR_RO(timeouts);
 
+static ssize_t null_name_show(struct device *dev, struct device_attribute *attr,
+			      char *buf)
+{
+	struct tpm_chip *chip = to_tpm_chip(dev);
+	int size = TPM2_NAME_SIZE;
+
+	bin2hex(buf, chip->tpmkeyname, size);
+	size *= 2;
+	buf[size++] = '\n';
+	return size;
+}
+static DEVICE_ATTR_RO(null_name);
+
 static struct attribute *tpm_dev_attrs[] = {
 	&dev_attr_pubek.attr,
 	&dev_attr_pcrs.attr,
@@ -298,17 +311,29 @@ static struct attribute *tpm_dev_attrs[] = {
 	NULL,
 };
 
+static struct attribute *tpm2_dev_attrs[] = {
+	&dev_attr_null_name.attr,
+	NULL,
+};
+
 static const struct attribute_group tpm_dev_group = {
 	.attrs = tpm_dev_attrs,
 };
 
+static const struct attribute_group tpm2_dev_group = {
+	.attrs = tpm2_dev_attrs,
+};
+
 void tpm_sysfs_add_device(struct tpm_chip *chip)
 {
 	/* XXX: If you wish to remove this restriction, you must first update
 	 * tpm_sysfs to explicitly lock chip->ops.
 	 */
-	if (chip->flags & TPM_CHIP_FLAG_TPM2)
+	if (chip->flags & TPM_CHIP_FLAG_TPM2) {
+		WARN_ON(chip->groups_cnt != 0);
+		chip->groups[chip->groups_cnt++] = &tpm2_dev_group;
 		return;
+	}
 
 	/* The sysfs routines rely on an implicit tpm_try_get_ops, device_del
 	 * is called before ops is null'd and the sysfs core synchronizes this
-- 
2.16.4

