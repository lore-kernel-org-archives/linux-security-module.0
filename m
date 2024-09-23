Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1305752F62;
	Mon, 23 Sep 2024 11:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727091778; cv=none; b=u/+GyF2x6iQFCY5uD80ggImivQQRgTnYth7CV6zFsPisEARpi1VS6JIUWUMNMkpKc38Ek6Vzequ6oeArwSwFDlNmLwHUVeaSYeyGEq6sp1d0vn7ilkOdpR2gTLq1VQlCabyTSMxEmsUboVI1W5i9sgKJN+dFB/xrAgn32xrbVcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727091778; c=relaxed/simple;
	bh=b41EEy3szhsO1UvdNry3bFFvKHTBCd5ElOBFgCAFDuk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=GOj555L/fJKUJR3j8OLLxSbDIouLmK7x/Ftbl265pE6EuZ57V2pVoVrXuWUb1UXXtBZPNcoL7ORux+NUjR+VNlPcVxIVGeMa4aOJClnOGqTbeMwL6y2JqXWJgdWF/w3TWMn3GuAIjX4DaYdYiblXfj1ADF68N5zx6SM+Nww13UA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4XC1Jg6spczfd0m;
	Mon, 23 Sep 2024 19:40:35 +0800 (CST)
Received: from kwepemh500013.china.huawei.com (unknown [7.202.181.146])
	by mail.maildlp.com (Postfix) with ESMTPS id 34F7E140384;
	Mon, 23 Sep 2024 19:42:52 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemh500013.china.huawei.com
 (7.202.181.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 23 Sep
 2024 19:42:51 +0800
From: Jinjie Ruan <ruanjinjie@huawei.com>
To: <wufan@linux.microsoft.com>, <paul@paul-moore.com>, <jmorris@namei.org>,
	<serge@hallyn.com>, <deven.desai@linux.microsoft.com>,
	<linux-security-module@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <ruanjinjie@huawei.com>
Subject: [PATCH] ipe: Fix out-of-bound access of kunit_suite_num_test_cases()
Date: Mon, 23 Sep 2024 19:52:52 +0800
Message-ID: <20240923115252.3562956-1-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemh500013.china.huawei.com (7.202.181.146)

Currently, there is no terminator entry for ipe_parser_test_cases,
hence facing below KASAN warning,

	BUG: KASAN: global-out-of-bounds in kunit_suite_num_test_cases+0xb4/0xcc
	Read of size 8 at addr ffffffe21035fec0 by task swapper/0/1

	CPU: 1 UID: 0 PID: 1 Comm: swapper/0 Tainted: G                 N 6.11.0+ #327
	Tainted: [N]=TEST
	Hardware name: linux,dummy-virt (DT)
	Call trace:
	 dump_backtrace+0x94/0xec
	 show_stack+0x18/0x24
	 dump_stack_lvl+0x90/0xd0
	 print_report+0x1f4/0x5b4
	 kasan_report+0xc8/0x110
	 __asan_report_load8_noabort+0x20/0x2c
	 kunit_suite_num_test_cases+0xb4/0xcc
	 attr_module_get+0x54/0xc0
	 kunit_print_attr+0x234/0x358
	 kunit_run_tests+0x138/0xbf4
	 __kunit_test_suites_init+0x110/0x1d0
	 kunit_run_all_tests+0x358/0x394
	 kernel_init_freeable+0x488/0x61c
	 kernel_init+0x24/0x1e4
	 ret_from_fork+0x10/0x20

	The buggy address belongs to the variable:
	 ipe_parser_test_cases+0x60/0x1ba0

	The buggy address belongs to the virtual mapping at
	 [ffffffe20ffe0000, ffffffe2120c1000) created by:
	 paging_init+0x474/0x60c

	The buggy address belongs to the physical page:
	page: refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x4535f
	flags: 0x3fffe0000002000(reserved|node=0|zone=0|lastcpupid=0x1ffff)
	raw: 03fffe0000002000 fffffffec014d7c8 fffffffec014d7c8 0000000000000000
	raw: 0000000000000000 0000000000000000 00000001ffffffff 0000000000000000
	page dumped because: kasan: bad access detected

	Memory state around the buggy address:
	 ffffffe21035fd80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
	 ffffffe21035fe00: 00 00 00 00 00 f9 f9 f9 f9 f9 f9 f9 00 00 00 00
	>ffffffe21035fe80: 00 00 00 00 00 00 00 00 f9 f9 f9 f9 00 00 00 00
	                                           ^
	 ffffffe21035ff00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
	 ffffffe21035ff80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
	==================================================================

Add a dummy terminator entry at the end to assist
kunit_suite_num_test_cases() in traversing up to the terminator entry
without accessing an out-of-boundary index.

Fixes: 10ca05a76065 ("ipe: kunit test for parser")
Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
 security/ipe/policy_tests.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/security/ipe/policy_tests.c b/security/ipe/policy_tests.c
index 89521f6b9994..0725fe36f8bb 100644
--- a/security/ipe/policy_tests.c
+++ b/security/ipe/policy_tests.c
@@ -286,6 +286,7 @@ static void ipe_parser_widestring_test(struct kunit *test)
 static struct kunit_case ipe_parser_test_cases[] = {
 	KUNIT_CASE_PARAM(ipe_parser_unsigned_test, ipe_policies_gen_params),
 	KUNIT_CASE(ipe_parser_widestring_test),
+	{}
 };
 
 static struct kunit_suite ipe_parser_test_suite = {
-- 
2.34.1

