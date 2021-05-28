Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E12AC4708E
	for <linux-security-module@archiver.kernel.org>; Fri, 28 May 2021 07:38:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E433C613C9
	for <linux-security-module@archiver.kernel.org>; Fri, 28 May 2021 07:38:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236077AbhE1HkQ (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 28 May 2021 03:40:16 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:3097 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229835AbhE1HkG (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 28 May 2021 03:40:06 -0400
Received: from fraeml714-chm.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4FrxGG23y4z6N46l;
        Fri, 28 May 2021 15:32:06 +0800 (CST)
Received: from roberto-ThinkStation-P620.huawei.com (10.204.62.217) by
 fraeml714-chm.china.huawei.com (10.206.15.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Fri, 28 May 2021 09:38:28 +0200
From:   Roberto Sassu <roberto.sassu@huawei.com>
To:     <zohar@linux.ibm.com>, <mjg59@srcf.ucam.org>
CC:     <linux-integrity@vger.kernel.org>,
        <linux-security-module@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Roberto Sassu <roberto.sassu@huawei.com>
Subject: [PATCH v2 0/7] ima: Add template fields to verify EVM portable signatures
Date:   Fri, 28 May 2021 09:38:05 +0200
Message-ID: <20210528073812.407936-1-roberto.sassu@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.204.62.217]
X-ClientProxiedBy: lhreml754-chm.china.huawei.com (10.201.108.204) To
 fraeml714-chm.china.huawei.com (10.206.15.33)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

The recent patch set 'evm: Improve usability of portable signatures' added
the possibility to include EVM portable signatures in the IMA measurement
list.

However, the information necessary to verify the signature were not
included in the IMA measurement list. This patch set introduces new
template fields to accomplish this goal:

- 'iuid': the inode UID;
- 'igid': the inode GID;
- 'imode': the inode mode;
- 'xattrnames': a list of xattr names (separated by |), only if the xattr is
  present;
- 'xattrlengths': a list of xattr lengths (u32), only if the xattr is present;
- 'xattrvalues': a list of xattr values;

Patch 1 adds an helper function to show integers in the measurement list.
Patches 2, 3 and 5 introduce new template fields. Patch 4 make it possible
to verify EVM portable signatures which protect xattrs belonging to LSMs
not enabled in the target platform. Patch 6 introduces the new IMA template
evm-sig. Patch 7 fixes a small issue in evm_write_xattrs() when audit is
not enabled.

This patch set has been tested with:

https://github.com/robertosassu/ima-evm-utils/blob/ima-template-fields-v2-devel-v5/tests/verify_evmsig.test
https://github.com/robertosassu/ima-evm-utils/blob/ima-template-fields-v2-devel-v5/tests/evm_hmac_non_enabled_xattrs.test

The first test aims at checking whether the EVM portable signature included
in the measurement list can be verified with the information also in the
measurement list.

It uses two methods for the verification: the first creates a copy of a
measured file, sets metadata parsed from the measurement list to that copy
and calls evmctl to verify the signature; the second lets evmctl verify the
measurement list directly.

The test is performed without and with an idmapped mount. Given that IMA
always provides the original UID and GID, no more actions are needed in the
second case.

The second test verifies that setting a non-enabled xattr does not change
the HMAC.

The test results are available at:

https://travis-ci.com/github/robertosassu/ima-evm-utils/jobs/508604164
https://travis-ci.com/github/robertosassu/ima-evm-utils/jobs/508604168

This patch set has been also tested on s390x, with and without the
canonical format enabled (the test results are not shown, as the UML kernel
used in Travis is not available for this architecture).

Changelog

v1:
- remove the mntuidmap and mntgidmap template fields and always display the
  original inode UID and GID (suggested by Christian Brauner)
- replace the evmxattrs template field with xattrnames, xattrlengths and
  xattrvalues (suggested by Mimi)
- introduce the new IMA template evm-sig (suggested by Mimi)
- use only one variable in ima_eventinodedac_init_common() (suggested by
  Mimi)

Roberto Sassu (7):
  ima: Add ima_show_template_uint() template library function
  ima: Define new template fields iuid and igid
  ima: Define new template field imode
  evm: Verify portable signatures against all protected xattrs
  ima: Define new template fields xattrnames, xattrlengths and
    xattrvalues
  ima: Define new template evm-sig
  evm: Don't return an error in evm_write_xattrs() if audit is not
    enabled

 Documentation/security/IMA-templates.rst  |   8 +
 include/linux/evm.h                       |  16 ++
 security/integrity/evm/evm.h              |   1 +
 security/integrity/evm/evm_crypto.c       |   7 +
 security/integrity/evm/evm_main.c         | 125 ++++++++++++++--
 security/integrity/evm/evm_secfs.c        |  18 ++-
 security/integrity/ima/ima_template.c     |  18 +++
 security/integrity/ima/ima_template_lib.c | 169 +++++++++++++++++++++-
 security/integrity/ima/ima_template_lib.h |  14 ++
 9 files changed, 362 insertions(+), 14 deletions(-)

-- 
2.25.1

