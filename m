Return-Path: <SRS0=BnuI=3Q=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E79FC2D0DB
	for <linux-security-module@archiver.kernel.org>; Mon, 27 Jan 2020 17:06:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DEFE821739
	for <linux-security-module@archiver.kernel.org>; Mon, 27 Jan 2020 17:06:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725897AbgA0RGG (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 27 Jan 2020 12:06:06 -0500
Received: from lhrrgout.huawei.com ([185.176.76.210]:2300 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725845AbgA0RGG (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 27 Jan 2020 12:06:06 -0500
Received: from LHREML710-CAH.china.huawei.com (unknown [172.18.7.107])
        by Forcepoint Email with ESMTP id 5EF55959F844E6E4E5B7;
        Mon, 27 Jan 2020 17:06:03 +0000 (GMT)
Received: from roberto-HP-EliteDesk-800-G2-DM-65W.huawei.com (10.204.65.160)
 by smtpsuk.huawei.com (10.201.108.33) with Microsoft SMTP Server (TLS) id
 14.3.408.0; Mon, 27 Jan 2020 17:05:34 +0000
From:   Roberto Sassu <roberto.sassu@huawei.com>
To:     <zohar@linux.ibm.com>, <jarkko.sakkinen@linux.intel.com>,
        <james.bottomley@hansenpartnership.com>,
        <linux-integrity@vger.kernel.org>
CC:     <linux-security-module@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <silviu.vlasceanu@huawei.com>,
        Roberto Sassu <roberto.sassu@huawei.com>
Subject: [PATCH 0/8] ima: support stronger algorithms for attestation
Date:   Mon, 27 Jan 2020 18:04:35 +0100
Message-ID: <20200127170443.21538-1-roberto.sassu@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.204.65.160]
X-CFilter-Loop: Reflected
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

IMA extends Platform Configuration Registers (PCRs) of the TPM to give a
proof to a remote verifier that the measurement list contains all
measurements done by the kernel and that the list was not maliciously
modified by an attacker.

IMA was originally designed to extend PCRs with a SHA1 digest, provided
with the measurement list, and was subsequently updated to extend all PCR
banks in case a TPM 2.0 is used. Non-SHA1 PCR banks are not supposed to be
used for remote attestation, as they are extended with a SHA1 digest padded
with zeros, which does not increase the strength.

This patch set addresses this issue by extending PCRs with the digest of
the measurement entry calculated with the crypto subsystem. The list of
algorithms used to calculate the digest are taken from
ima_tpm_chip->allocated_banks, returned by the TPM driver. The SHA1 digest
is always calculated, as SHA1 still remains the default algorithm for the
template digest in the measurement list.

This patch set also makes two additional modifications related to the usage
of hash algorithms. First, since now the template digest for the default
IMA algorithm is always calculated, this is used for hash collision
detection, to check if there are duplicate measurement entries.

Second, it uses the default IMA hash algorithm to calculate the boot
aggregate, assuming that the corresponding PCR bank is currently allocated.
Otherwise, it finds the first PCR bank for which the crypto ID is known.
IMA initialization fails only if no algorithm known to the crypto subsystem
is found.

This patch set does not yet modify the format of the measurement list to
provide the digests passed to the TPM. However, reconstructing the value of
the quoted PCR is still possible for the verifier by calculating the digest
on measurement data found in binary_runtime_measurements.

The attest-tools library [1] has been updated to verify non-SHA1 PCR
banks [2] and to handle non-SHA1 boot aggregate [3].

[1] https://github.com/euleros/attest-tools/tree/0.2-devel
[2] https://github.com/euleros/attest-tools/commit/282a0b1a5e6d9c87adf21561018528d7bbdc7f38
[3] https://github.com/euleros/attest-tools/commit/3a4c8e250fde7661257aba022d677bf0af5399da

Roberto Sassu (8):
  tpm: initialize crypto_id of allocated_banks to HASH_ALGO__LAST
  ima: evaluate error in init_ima()
  ima: store template digest directly in ima_template_entry
  ima: switch to dynamically allocated buffer for template digests
  ima: allocate and initialize tfm for each PCR bank
  ima: calculate and extend PCR with digests in ima_template_entry
  ima: use ima_hash_algo for collision detection in the measurement list
  ima: switch to ima_hash_algo for boot aggregate

 drivers/char/tpm/tpm2-cmd.c           |   2 +
 security/integrity/ima/ima.h          |   7 +-
 security/integrity/ima/ima_api.c      |  20 ++-
 security/integrity/ima/ima_crypto.c   | 219 ++++++++++++++++++++------
 security/integrity/ima/ima_fs.c       |   4 +-
 security/integrity/ima/ima_init.c     |   6 +-
 security/integrity/ima/ima_main.c     |   6 +
 security/integrity/ima/ima_queue.c    |  36 +++--
 security/integrity/ima/ima_template.c |  22 ++-
 9 files changed, 241 insertions(+), 81 deletions(-)

-- 
2.17.1

