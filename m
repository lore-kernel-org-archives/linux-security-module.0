Return-Path: <SRS0=nTNb=ON=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6D7EC04EBF
	for <linux-security-module@archiver.kernel.org>; Tue,  4 Dec 2018 07:37:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93653214D9
	for <linux-security-module@archiver.kernel.org>; Tue,  4 Dec 2018 07:37:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 93653214D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-security-module-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726005AbeLDHhZ (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 4 Dec 2018 02:37:25 -0500
Received: from mga03.intel.com ([134.134.136.65]:5832 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726017AbeLDHhZ (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 4 Dec 2018 02:37:25 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Dec 2018 23:37:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,313,1539673200"; 
   d="scan'208";a="107105256"
Received: from alison-desk.jf.intel.com (HELO alison-desk) ([10.54.74.53])
  by orsmga003.jf.intel.com with ESMTP; 03 Dec 2018 23:37:21 -0800
From:   Alison Schofield <alison.schofield@intel.com>
To:     dhowells@redhat.com, tglx@linutronix.de
Cc:     jmorris@namei.org, mingo@redhat.com, hpa@zytor.com, bp@alien8.de,
        luto@kernel.org, peterz@infradead.org,
        kirill.shutemov@linux.intel.com, dave.hansen@intel.com,
        kai.huang@intel.com, jun.nakajima@intel.com,
        dan.j.williams@intel.com, jarkko.sakkinen@intel.com,
        keyrings@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-mm@kvack.org, x86@kernel.org
Subject: [RFC v2 00/13] Multi-Key Total Memory Encryption API (MKTME)
Date:   Mon,  3 Dec 2018 23:39:47 -0800
Message-Id: <cover.1543903910.git.alison.schofield@intel.com>
X-Mailer: git-send-email 2.7.4
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Hi Thomas, David,

Here is an updated RFC on the API's to support MKTME.
(Multi-Key Total Memory Encryption)

This RFC presents the 2 API additions to support the creation and
usage of memory encryption keys:
 1) Kernel Key Service type "mktme"
 2) System call encrypt_mprotect()

This patchset is built upon Kirill Shutemov's work for the core MKTME
support.

David: Please let me know if the changes made, based on your review,
are reasonable. I don't think that the new changes touch key service
specific areas (much).

Thomas: Please provide feedback on encrypt_mprotect(). If not a
review, then a direction check would be helpful.

I picked up a few more 'CCs this time in get_maintainer!

Thanks!
Alison


Changes in RFC2
Add a preparser to mktme key service. (dhowells)
Replace key serial no. with key struct point in mktme_map. (dhowells)
Remove patch that inserts a special MKTME case in keyctl revoke. (dhowells)
Updated key usage syntax in the documentation (Kai)
Replaced NO_PKEY, NO_KEYID with a single constant NO_KEY. (Jarkko)
Clarified comments in changelog and code. (Jarkko)
Add clear, no-encrypt, and update key support.
Add mktme_savekeys (Patch 12 ) to give kernel permission to save key data.
Add cpu hotplug support. (Patch 13)

Alison Schofield (13):
  x86/mktme: Document the MKTME APIs
  mm: Generalize the mprotect implementation to support extensions
  syscall/x86: Wire up a new system call for memory encryption keys
  x86/mm: Add helper functions for MKTME memory encryption keys
  x86/mm: Set KeyIDs in encrypted VMAs
  mm: Add the encrypt_mprotect() system call
  x86/mm: Add helpers for reference counting encrypted VMAs
  mm: Use reference counting for encrypted VMAs
  mm: Restrict memory encryption to anonymous VMA's
  keys/mktme: Add the MKTME Key Service type for memory encryption
  keys/mktme: Program memory encryption keys on a system wide basis
  keys/mktme: Save MKTME data if kernel cmdline parameter allows
  keys/mktme: Support CPU Hotplug for MKTME keys

 Documentation/admin-guide/kernel-parameters.rst |   1 +
 Documentation/admin-guide/kernel-parameters.txt |  11 +
 Documentation/x86/mktme/index.rst               |  11 +
 Documentation/x86/mktme/mktme_demo.rst          |  53 +++
 Documentation/x86/mktme/mktme_encrypt.rst       |  58 +++
 Documentation/x86/mktme/mktme_keys.rst          | 109 +++++
 Documentation/x86/mktme/mktme_overview.rst      |  60 +++
 arch/x86/Kconfig                                |   1 +
 arch/x86/entry/syscalls/syscall_32.tbl          |   1 +
 arch/x86/entry/syscalls/syscall_64.tbl          |   1 +
 arch/x86/include/asm/mktme.h                    |  25 +
 arch/x86/mm/mktme.c                             | 179 ++++++++
 fs/exec.c                                       |   4 +-
 include/keys/mktme-type.h                       |  41 ++
 include/linux/key.h                             |   2 +
 include/linux/mm.h                              |  11 +-
 include/linux/syscalls.h                        |   2 +
 include/uapi/asm-generic/unistd.h               |   4 +-
 kernel/fork.c                                   |   2 +
 kernel/sys_ni.c                                 |   2 +
 mm/mprotect.c                                   |  91 +++-
 security/keys/Kconfig                           |  11 +
 security/keys/Makefile                          |   1 +
 security/keys/mktme_keys.c                      | 580 ++++++++++++++++++++++++
 24 files changed, 1249 insertions(+), 12 deletions(-)
 create mode 100644 Documentation/x86/mktme/index.rst
 create mode 100644 Documentation/x86/mktme/mktme_demo.rst
 create mode 100644 Documentation/x86/mktme/mktme_encrypt.rst
 create mode 100644 Documentation/x86/mktme/mktme_keys.rst
 create mode 100644 Documentation/x86/mktme/mktme_overview.rst
 create mode 100644 include/keys/mktme-type.h
 create mode 100644 security/keys/mktme_keys.c

-- 
2.14.1

