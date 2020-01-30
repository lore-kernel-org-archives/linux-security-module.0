Return-Path: <SRS0=X2V5=3T=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DD58C33CB2
	for <linux-security-module@archiver.kernel.org>; Thu, 30 Jan 2020 03:17:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE226206F0
	for <linux-security-module@archiver.kernel.org>; Thu, 30 Jan 2020 03:17:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726719AbgA3DRh (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 29 Jan 2020 22:17:37 -0500
Received: from smtprelay0073.hostedemail.com ([216.40.44.73]:33128 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726485AbgA3DRg (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 29 Jan 2020 22:17:36 -0500
X-Greylist: delayed 491 seconds by postgrey-1.27 at vger.kernel.org; Wed, 29 Jan 2020 22:17:35 EST
Received: from smtprelay.hostedemail.com (10.5.19.251.rfc1918.com [10.5.19.251])
        by smtpgrave08.hostedemail.com (Postfix) with ESMTP id 8FFFE182D3EBF
        for <linux-security-module@vger.kernel.org>; Thu, 30 Jan 2020 03:09:25 +0000 (UTC)
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay01.hostedemail.com (Postfix) with ESMTP id 0B627100E7B42;
        Thu, 30 Jan 2020 03:09:24 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: bell00_6ef0b4c9d2c14
X-Filterd-Recvd-Size: 3866
Received: from XPS-9350.home (unknown [47.151.135.224])
        (Authenticated sender: joe@perches.com)
        by omf18.hostedemail.com (Postfix) with ESMTPA;
        Thu, 30 Jan 2020 03:09:22 +0000 (UTC)
Message-ID: <ab2e19123cc15e3f8039b0d36e6ebae385db700e.camel@perches.com>
Subject: Re: [PATCH] security/integrity: Include __func__ in messages for
 easier debug
From:   Joe Perches <joe@perches.com>
To:     Shuah Khan <skhan@linuxfoundation.org>, jmorris@namei.org,
        serge@hallyn.com, mpe@ellerman.id.au, zohar@linux.ibm.com,
        erichte@linux.ibm.com, nayna@linux.ibm.com, yuehaibing@huawei.com
Cc:     linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Wed, 29 Jan 2020 19:08:15 -0800
In-Reply-To: <20200130020129.15328-1-skhan@linuxfoundation.org>
References: <20200130020129.15328-1-skhan@linuxfoundation.org>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Wed, 2020-01-29 at 19:01 -0700, Shuah Khan wrote:
> Change messages to messages to make it easier to debug. The following
> error message isn't informative enough to figure out what failed.
> Change messages to include function information.
> 
> Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
> ---
>  .../integrity/platform_certs/load_powerpc.c     | 14 ++++++++------
>  security/integrity/platform_certs/load_uefi.c   | 17 ++++++++++-------
>  2 files changed, 18 insertions(+), 13 deletions(-)
> 
> diff --git a/security/integrity/platform_certs/load_powerpc.c b/security/integrity/platform_certs/load_powerpc.c

perhaps instead add #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
so all the pr_<level> logging is more specific.

This would prefix all pr_<level> output with "integrity: "

3integrity: Couldn't get size: 0x%lx
3integrity: Error reading db var: 0x%lx
3integrity: MODSIGN: Couldn't get UEFI db list
3integrity: Couldn't parse db signatures: %d
6integrity: Couldn't get UEFI MokListRT
3integrity: Couldn't parse MokListRT signatures: %d
6integrity: Couldn't get UEFI dbx list
3integrity: Couldn't parse dbx signatures: %d

5integrity: Platform Keyring initialized
6integrity: Error adding keys to platform keyring %s

---
 security/integrity/platform_certs/load_powerpc.c     | 3 +++
 security/integrity/platform_certs/load_uefi.c        | 2 ++
 security/integrity/platform_certs/platform_keyring.c | 2 ++
 3 files changed, 7 insertions(+)

diff --git a/security/integrity/platform_certs/load_powerpc.c b/security/integrity/platform_certs/load_powerpc.c
index a2900c..5cfbd0 100644
--- a/security/integrity/platform_certs/load_powerpc.c
+++ b/security/integrity/platform_certs/load_powerpc.c
@@ -5,6 +5,9 @@
  *
  *      - loads keys and hashes stored and controlled by the firmware.
  */
+
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
 #include <linux/kernel.h>
 #include <linux/sched.h>
 #include <linux/cred.h>
diff --git a/security/integrity/platform_certs/load_uefi.c b/security/integrity/platform_certs/load_uefi.c
index 111898a..480450a 100644
--- a/security/integrity/platform_certs/load_uefi.c
+++ b/security/integrity/platform_certs/load_uefi.c
@@ -1,5 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
 #include <linux/kernel.h>
 #include <linux/sched.h>
 #include <linux/cred.h>
diff --git a/security/integrity/platform_certs/platform_keyring.c b/security/integrity/platform_certs/platform_keyring.c
index 7646e35..9bd2846 100644
--- a/security/integrity/platform_certs/platform_keyring.c
+++ b/security/integrity/platform_certs/platform_keyring.c
@@ -6,6 +6,8 @@
  * Author(s): Nayna Jain <nayna@linux.ibm.com>
  */
 
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
 #include <linux/export.h>
 #include <linux/kernel.h>
 #include <linux/sched.h>

