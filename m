Return-Path: <SRS0=NNx2=72=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99464C433E1
	for <linux-security-module@archiver.kernel.org>; Sat, 13 Jun 2020 02:41:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6D2BF2074B
	for <linux-security-module@archiver.kernel.org>; Sat, 13 Jun 2020 02:41:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="BAKdp5qO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726449AbgFMCli (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 12 Jun 2020 22:41:38 -0400
Received: from linux.microsoft.com ([13.77.154.182]:54094 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726290AbgFMClg (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 12 Jun 2020 22:41:36 -0400
Received: from localhost.localdomain (c-73-42-176-67.hsd1.wa.comcast.net [73.42.176.67])
        by linux.microsoft.com (Postfix) with ESMTPSA id D7C17205DDA3;
        Fri, 12 Jun 2020 19:41:35 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com D7C17205DDA3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1592016096;
        bh=vaFIY848bzauzFCfpzzjSbZuqVCA6KD5jaD7Y2KRWaw=;
        h=From:To:Cc:Subject:Date:From;
        b=BAKdp5qOjEIdRsnotGep4dozpflsun+0alY4C689o3x6bOSyty8ObzTOMLaKYa/hF
         HY+jssMDf0f/1MHeyVHhMJWQ0ItLnNAevC51ndvv/2gn0nZTAAH87nhGrmfbPrpiDm
         /R2RQR2nvr+P7AQfH/xIT05T1FQ1bJt1DwX/GtxY=
From:   Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
To:     zohar@linux.ibm.com, stephen.smalley@gmail.com,
        casey@schaufler-ca.com
Cc:     jmorris@namei.org, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/5] LSM: Measure security module state
Date:   Fri, 12 Jun 2020 19:41:25 -0700
Message-Id: <20200613024130.3356-1-nramas@linux.microsoft.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Critical data structures of security modules are currently not measured.
Therefore an attestation service, for instance, would not be able to
attest whether security modules are always operating with the policies
and configuration that the system administrator had setup. The policies
and configuration for the security modules could be tampered with by
malware by exploiting Kernel vulnerabilities or modified through some
inadvertent actions on the system. Measuring such critical data would
enable an attestation service to better assess the state of the system.

IMA measures system files, command line arguments passed to kexec,
boot aggregate, keys, etc. It can be used to measure critical
data structures of security modules as well.

This change aims to address measuring critical data structures
of security modules when they are initialized, when they are updated
at runtime, and also periodically to detect any tampering.

This change set is based off of Linux Kernel version 5.8-rc1

Lakshmi Ramasubramanian (5):
  IMA: Add LSM_STATE func to measure LSM data
  IMA: Define an IMA hook to measure LSM data
  LSM: Add security_state function pointer in lsm_info struct
  LSM: Define SELinux function to measure security state
  LSM: Define workqueue for measuring security module state

 Documentation/ABI/testing/ima_policy |  6 +-
 include/linux/ima.h                  |  4 ++
 include/linux/lsm_hooks.h            |  5 ++
 security/integrity/ima/ima.h         |  1 +
 security/integrity/ima/ima_api.c     |  2 +-
 security/integrity/ima/ima_main.c    | 30 +++++++++
 security/integrity/ima/ima_policy.c  | 28 +++++++--
 security/security.c                  | 91 +++++++++++++++++++++++++++-
 security/selinux/hooks.c             | 43 +++++++++++++
 security/selinux/include/security.h  |  2 +
 security/selinux/selinuxfs.c         |  1 +
 11 files changed, 205 insertions(+), 8 deletions(-)

-- 
2.27.0

