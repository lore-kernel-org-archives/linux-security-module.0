Return-Path: <SRS0=zjoR=NC=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3AEBC67863
	for <linux-security-module@archiver.kernel.org>; Mon, 22 Oct 2018 07:33:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 891D52083A
	for <linux-security-module@archiver.kernel.org>; Mon, 22 Oct 2018 07:33:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="kSkyUSGL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 891D52083A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=HansenPartnership.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-security-module-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727600AbeJVPuk (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 22 Oct 2018 11:50:40 -0400
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:49538 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727497AbeJVPuk (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 22 Oct 2018 11:50:40 -0400
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 26B388EE0FC;
        Mon, 22 Oct 2018 00:33:20 -0700 (PDT)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id E8K1Qal0MtHb; Mon, 22 Oct 2018 00:33:20 -0700 (PDT)
Received: from [172.20.48.127] (unknown [62.232.21.219])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 77C438EE02B;
        Mon, 22 Oct 2018 00:33:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1540193599;
        bh=dc3JO6W77lZTwqNbliI7b5ZSGQfaZgNt8dgy+kbZOfk=;
        h=Subject:From:To:Cc:Date:From;
        b=kSkyUSGLmtabL/RW1nJjcHoBdpo50wpO+DW/xgqlCOIvmclp/FnTThz+fclDKeS+I
         S7mjTyiMxsADm8gWXCE0w6dSDw+ZXNJqDs2EcTEzaiUhCqEboCLtzEs8/FbwxeGWyu
         6g5EP8vJ19mNkskTnkBMNFqY/r7ZOv0kZiqr1Rc0=
Message-ID: <1540193596.3202.7.camel@HansenPartnership.com>
Subject: [PATCH v4 0/7] add integrity and security to TPM2 transactions
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     linux-integrity@vger.kernel.org
Cc:     linux-crypto@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Mon, 22 Oct 2018 08:33:16 +0100
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

By now, everybody knows we have a problem with the TPM2_RS_PW easy
button on TPM2 in that transactions on the TPM bus can be intercepted
and altered.  The way to fix this is to use real sessions for HMAC
capabilities to ensure integrity and to use parameter and response
encryption to ensure confidentiality of the data flowing over the TPM
bus.

This patch series is about adding a simple API which can ensure the
above properties as a layered addition to the existing TPM handling
code.  This series now includes protections for PCR extend, getting
random numbers from the TPM and data sealing and unsealing.  It
therefore eliminates all uses of TPM2_RS_PW in the kernel and adds
encryption protection to sensitive data flowing into and out of the
TPM.

In the third version I added data sealing and unsealing protection,
apart from one API based problem which means that the way trusted keys
were protected it's not currently possible to HMAC protect an authority
that comes with a policy, so the API will have to be extended to fix
that case

In this fourth version, I tidy up some of the code and add more
security features, the most notable is that we now calculate the NULL
seed name and compare our calculation to the value returned in
TPM2_ReadPublic, which means we now can't be spoofed.  This version
also gives a sysfs variable for the null seed which userspace can use
to run a key certification operation to prove that the TPM was always
secure when communicating with the kernel.

I've verified this using the test suite in the last patch on a VM
connected to a tpm2 emulator.  I also instrumented the emulator to make
sure the sensitive data was properly encrypted.

James

---


James Bottomley (7):
  tpm-buf: create new functions for handling TPM buffers
  tpm2-sessions: Add full HMAC and encrypt/decrypt session handling
  tpm2: add hmac checks to tpm2_pcr_extend()
  tpm2: add session encryption protection to tpm2_get_random()
  trusted keys: Add session encryption protection to the seal/unseal
    path
  tpm: add the null key name as a tpm2 sysfs variable
  tpm2-sessions: NOT FOR COMMITTING add sessions testing

 drivers/char/tpm/Kconfig              |    3 +
 drivers/char/tpm/Makefile             |    3 +-
 drivers/char/tpm/tpm-buf.c            |  191 ++++++
 drivers/char/tpm/tpm-chip.c           |    1 +
 drivers/char/tpm/tpm-sysfs.c          |   27 +-
 drivers/char/tpm/tpm.h                |  129 ++--
 drivers/char/tpm/tpm2-cmd.c           |  248 ++++---
 drivers/char/tpm/tpm2-sessions-test.c |  360 ++++++++++
 drivers/char/tpm/tpm2-sessions.c      | 1188 +++++++++++++++++++++++++++++++++
 drivers/char/tpm/tpm2-sessions.h      |   57 ++
 10 files changed, 2027 insertions(+), 180 deletions(-)
 create mode 100644 drivers/char/tpm/tpm-buf.c
 create mode 100644 drivers/char/tpm/tpm2-sessions-test.c
 create mode 100644 drivers/char/tpm/tpm2-sessions.c
 create mode 100644 drivers/char/tpm/tpm2-sessions.h

-- 
2.16.4

