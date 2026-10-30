Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793394614;
	b=oLb7jRPuqGxoBsMs+lP8c1e1V53bOyOT6HBTipdUT6/VQEUj/FTq04LM6h0HZ/WqfB4+
	 juVmMHVY6A+pouPeanNW83MiFNW8DhHflSYXTt4ctaUHrLPVxM34RkuSfyCMajr0p1ncF
	 a9iMJNOie6SFPotdZIXSTzKsh8Kagkf3/2TTSohCubx4KVHjNHTYCu5GCJIO2dQcs+RFi
	 +g74uJ+gdLncphVzANm8Eqz8+mBrkhUgwjuns7OT15sQAg1zh57QOJ8tXPCDRFAn7549x
	 WdxZOVzc3iyELljLC9UmW/UDi37FGHS46W3YeP7YfVOjnONwWJ2wCC0NA4MAPGyO6Bw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793394614;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=WWFHdhsqkiSrahXyVyHuACAJn5u+mkpktpUzIjfAX54=;
	b=n/QnfL++AWJ/TXEEebbZiKp2zO8/Ym1bvisafKuQfJsgITTXojz9yjZ8tIt1i1P8+EBf
	 kvlFxMhslScDqFd72IwnPB5PgVXLFGCV2wQ88bd7qEDNgodyoyow626IGJc4JDMgVZOUP
	 kPVr395K58jTt7BMv0otuWsGUrlipWPsIzsS6b0kuLCU46K8r+0lHO2wJfWfXk/vc/y0B
	 buSWnAe+RjXTHyRemEcFWfXEqI9SHgb/WE08HnN4qvPlwtRJzy+fKlB9Nk0hGdg0kCP0h
	 ZPDhMY9Wh8Ev8ZGPzsSADj0C2uUaY0LCqpVM3sgtr9b+wcKRu4fxVdBsX4hI+a8Rvxg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arista.com;
	spf=pass smtp.mailfrom=arista.com;
	dkim=pass header.d=arista.com header.i=@arista.com header.a=rsa-sha256 header.s=google header.b=ivo2T3XK;
	arc=none smtp.remote-ip=74.125.82.170
Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com [74.125.82.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76CBC606A320
	for <linux-security-module@vger.kernel.org>; Fri, 30 Oct 2026 21:10:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 76CBC606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=arista.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arista.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=arista.com header.i=@arista.com header.a=rsa-sha256 header.s=google header.b=ivo2T3XK
Received: by mail-dy1-f170.google.com with SMTP id 5a478bee46e88-36a17a332ecso2121097eec.1
        for <linux-security-module@vger.kernel.org>; Fri, 30 Oct 2026 14:10:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google; t=1793394613; x=1793999413; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=WWFHdhsqkiSrahXyVyHuACAJn5u+mkpktpUzIjfAX54=;
        b=ivo2T3XKqnoTABezZSv1AgcxO9h6PJ7Qopg7cUS65dXJFysagwyPqQGUk8hWhqHvpK
         71FOoOHiaTT+wsagSGZ2Psrdkzxniqz7Otz9mwCH040rLqxkpyZTi86b/Kp8dUqOOSVq
         seujfQwMyQWx7L481DgAeN6tGyeAaoGE6gZJrCgPB17QtI+G2xshds41s36d1gEicJyo
         XMsooceQR8/4pAi1nRLpgGi0xsdp6LvVo0dIhHhkPbVE9X4lccFrRbDx5d/x/SgkttxW
         2+6w0zIDkSSuXAOGFD3P+iPwCda2DWqfqeOYS+cbnOyhRaYEzu1i6OARqGJxaIQdlhL7
         /OzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793394613; x=1793999413;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=WWFHdhsqkiSrahXyVyHuACAJn5u+mkpktpUzIjfAX54=;
        b=rj/HhH1pkAS2XHO+etw14Crsm/OdObTTXmw2m+jlvP4wOPUWo4K0vn8UBF4JISNXxu
         VuMhNaAcv1TSlvNDYRfEejP7pzKrK46SSz1r0f7EUWwOmItZ4O+iFmAWW0xRrq4m2Vqy
         UXu/cliL2Hy5OmIaSLIyU63jFnOKJN9drA0uPvxJFLfyZLHWoPR8LFawzXK9Uq/i7GHU
         C4X+35Tb+Qz9gEL0xrYywEV3nTQLq6Aqq3csJwrWoWE3/qYsKRa2ia2LlAT904t6q2ed
         RW6p6lr85B5sBPlASVjenTahBxEj59ckmCCrKWqlrY52B8/OooqIjNxyHNSMPJ4hM1eH
         s6ag==
X-Forwarded-Encrypted: i=1; AKwUvBxlA0yyxyRlcTSMsDn2NbBIEBi8BNlooIUgIjVJx4yBbset+u9qApZqLv/9ZtDS2RDK1LNkUrOSF7t8k3uZEf5EJYdJlLw=@vger.kernel.org
X-Gm-Message-State: AFq9FYJgNuBfPtefnWTjtc0jIfyhExc90EKJKNCy9SWlJ4D2nc+4xs3X
	QgQLXovTwkFRAY0HN1X+TaENOmktZLu/1I8MDNj0rk5PAYyGhMGYiPdLTSQRvbG56A==
X-Gm-Gg: AYBFou3bQjSA3o8nCGB8JKQTXylLb8cU75Im1udodWbGHZkQuUMmN5mTZ1tH3OKL4bd
	MeiU47+OssreifGwFfhAuBdesv8lF78IxaS/izV1lS9m4zDMNR0dPw42sckC5wQcI+0DOo/C//S
	pnASuPdtcP2c/AoJ6uGNnC4tAXvt7YRv2GhcXP8WzWMyZRxvVerhAjLaray6B+x8vIdGaLeosaQ
	SW2uaITcj4ePFP1SICwkz+WT4FC1ioPdoEAZpxpjcUjLvZCmAdRnhOT3nhFmVpfydTztN7Q10V0
	pCDw6P41pRe7qp7NlUasev7p6ylUSWQQ8OPJxzQ/qCfjfK0ye1EOCB2YDQv/SPr1i/pDxA7CmGl
	e5noIEc/xbzI6XoqjSRs7fqJtKHCVsU7W97lnAYcuSHnBwDrLa3M34TxM7A4RjmuWipnrk0SqQ+
	8e1p8cv2jHvALhADagUK/wO4K6Lz4RBM/lhEiedBvS2e44D5qA/QZe5323ImGQvpDd7cle4PMjt
	K1xoIL6WmjthoHVngOHYzUbQuU0JYMFBzktX77Mupnv/S7b6V2/gvROvaNrh9qTrOdnmV+Jt6cU
	VeZ8445FgFi42cptVSIKg1J2UfBZY6FBIig+gu4ofVaB1DbBADryW1tzMEQV022EmVJUiKaKaTZ
	CJGI4pfFh5/ikm42dTW7UXXc=
X-Received: by 2002:a05:701a:c907:b0:185:33ab:4d55 with SMTP id a92af1059eb24-1ac5f1810d2mr4226717c88.29.1793394600810;
        Fri, 30 Oct 2026 14:10:00 -0700 (PDT)
Received: from dannyhu-upstreamLinux.sjc.aristanetworks.com ([74.123.28.18])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1ac1abcf67csm9471777c88.21.2026.10.30.14.09.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 14:10:00 -0700 (PDT)
From: Danny Hu <dannyhu@arista.com>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>
Cc: Mimi Zohar <zohar@linux.ibm.com>,
	Roberto Sassu <roberto.sassu@huawei.com>,
	Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
	Eric Snowberg <eric.snowberg@oracle.com>,
	Jan Kara <jack@suse.cz>,
	Victor Kamensky <kamensky@cisco.com>,
	Taras Kondratiuk <takondra@cisco.com>,
	Tianxing Zhang <zhangtianxing3@huawei.com>,
	Zheng Zengkai <zhengzengkai@huawei.com>,
	zhoushuiqing <zhoushuiqing2@huawei.com>,
	zhangguangzhi <zhangguangzhi3@huawei.com>,
	Danny Hu <dannyhu@arista.com>,
	Jason Yan <yanaijie@huawei.com>,
	silviu.vlasceanu@huawei.com,
	hpa@zytor.com,
	arnd@arndb.de,
	rob@landley.net,
	james.w.mcmechan@gmail.com,
	niveditas98@gmail.com,
	pierre@arista.com,
	julien@arista.com,
	kbharathi@arista.com,
	erosca@de.adit-jv.com,
	alexandr.lobakin@intel.com,
	jim_baxter@mentor.com,
	linux-fsdevel@vger.kernel.org,
	linux-integrity@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-kbuild@vger.kernel.org,
	initramfs@vger.kernel.org,
	linux-api@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bug-cpio@gnu.org
Subject: [PATCH v5 0/4] initramfs: add support for xattrs in the initial ram disk
Date: Fri, 30 Oct 2026 14:09:39 -0700
Message-ID: <20261030210944.2143778-1-dannyhu@arista.com>
X-Mailer: git-send-email 2.51.0
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch set aims at solving the following use case: appraise files from
the initial ram disk. To do that, IMA checks the signature/hash from the
security.ima xattr. Unfortunately, this use case cannot be implemented
currently, as the CPIO format does not support xattrs.

This proposal consists in including file metadata as additional files named
METADATA!!!, for each file added to the ram disk. The CPIO parser in the
kernel recognizes these special files from the file name, and calls the
appropriate parser to add metadata to the previously extracted file. It has
been proposed to use bit 17:16 of the file mode as a way to recognize files
with metadata, but both the kernel and the cpio tool declare the file mode
as unsigned short.

This v5 revives Roberto Sassu's v4 series posted on May 23, 2019
(https://lkml.org/lkml/2019/5/23/415). The github issue tracking the
revival of this patchset is here
(https://github.com/linux-integrity/linux/issues/11).
This revision incorporates unpublished changes
from other contributors that can be found in
(https://github.com/linux-integrity/linux/tree/initramfs-xattr-v1-devel-v1)
and adapts the implementation to newer kernel interfaces. Compared with
v4, this revision adds an IMA deadlock fix for restoring security.ima
xattrs during initramfs unpacking, switches to a Kconfig choice for
metadata type selection, and updates gen_initramfs.sh to pass source
paths to gen_init_cpio for nonregular entries, allowing their xattrs to be
read from the correct source object that will be included in the archive.
This revision also includes various improvements to error path cleanup,
debug output and tool documentation.

The difference from v2, v3 (https://lkml.org/lkml/2019/5/9/230,
https://lkml.org/lkml/2019/5/17/466) is that file metadata are stored in
separate files instead of a single file. Given that files with metadata
must immediately follow the files metadata will be added to, image
generators have to be modified in this version.

The difference from v1 (https://lkml.org/lkml/2018/11/22/1182) is that
all files have the same name. The file metadata are added to is always the
previous one, and the image generator in user space will make sure that
files are in the correct sequence.

The difference with another proposal
(https://lore.kernel.org/patchwork/cover/888071/) is that xattrs can be
included in an image without changing the image format. Files with metadata
will appear as regular files. It will be task of the parser in the kernel
to process them.

This patch set extends the format of data defined in patch 9/15 of the last
proposal. It adds header version and type, so that new formats can be
defined and arbitrary metadata types can be processed.

The changes introduced by this patch set don't cause any compatibility
issue: kernels without the metadata parser simply extract the special files
and don't process metadata; kernels with the metadata parser don't process
metadata if the special files are not included in the image.

From the kernel space perspective, backporting this functionality to older
kernels should be very easy. It is sufficient to add two calls to the new
function do_process_metadata() in do_copy(), and to check the file name in
do_name(). From the user space perspective, unlike the previous version of
the patch set, it is required to modify the image generators in order to
include metadata as separate files.

Changelog

Changes in v5 relative to v4:
- Rebase onto vfs.all
- Add an IMA fix to avoid a deadlock during initramfs metadata restoration
- Use u32 metadata record lengths and reject records smaller than their
  header
- Improve debug output for binary xattr data
- Cleanup metadata buffers at the end of unpack_to_rootfs() 
- For CONFIG_INITRAMFS_FILE_METADATA, replace the metadata string prompt
  with a none/xattr choice
- Fix resource cleanup and format specifiers in gen_init_cpio
- Update gen_initramfs.sh to pass source paths to gen_init_cpio.c for
  nonregular entries (slink, dir, nod). Modify gen_init_cpio to
  properly collect xattrs from the source object. Without this change,
  xattrs will not get included for slink, dir and nod.
- Add documentation of xattr option in usage() for gen_init_cpio

v3:
- include file metadata as separate files named METADATA!!!
- add the possibility to include in the ram disk arbitrary metadata types

v2:
- replace ksys_lsetxattr() with kern_path() and vfs_setxattr()
  (suggested by Jann Horn)
- replace ksys_open()/ksys_read()/ksys_close() with
  filp_open()/kernel_read()/fput()
  (suggested by Jann Horn)
- use path variable instead of name_buf in do_readxattrs()
- set last byte of str to 0 in do_readxattrs()
- call do_readxattrs() in do_name() before replacing an existing
  .xattr-list
- pass pathname to do_setxattrs()

v1:
- move xattr unmarshaling to CPIO parser

Danny Hu (1):
  ima: skip algorithm availability check until initramfs unpacking is
    finished

Mimi Zohar (1):
  initramfs: add file metadata

Roberto Sassu (2):
  initramfs: read metadata from special file METADATA!!!
  gen_init_cpio: add support for file metadata

 include/linux/initramfs.h             |  19 +++
 init/initramfs.c                      | 140 ++++++++++++++++-
 security/integrity/ima/ima_appraise.c |  25 +++
 usr/Kconfig                           |  19 +++
 usr/Makefile                          |   3 +-
 usr/gen_init_cpio.c                   | 216 ++++++++++++++++++++++----
 usr/gen_initramfs.sh                  |  15 +-
 7 files changed, 401 insertions(+), 36 deletions(-)
 create mode 100644 include/linux/initramfs.h


base-commit: 2c3ba1f1cb416b81d617b92a24a4bcaa48d574e3
-- 
2.51.0

