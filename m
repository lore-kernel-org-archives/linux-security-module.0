Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B4F5C433FE
	for <linux-security-module@archiver.kernel.org>; Mon, 28 Mar 2022 11:39:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241655AbiC1Lkm (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 28 Mar 2022 07:40:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241931AbiC1Ld5 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 28 Mar 2022 07:33:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C8F51114;
        Mon, 28 Mar 2022 04:25:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E704D611B3;
        Mon, 28 Mar 2022 11:25:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86664C36AE5;
        Mon, 28 Mar 2022 11:25:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648466701;
        bh=DKxsw4JmfpR/Bg/dltox9tnnAlydmzRJ553cHujidoY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AsTQDvJV80eQyUC+L1P7jVvn82R2d1xT3BtpRkKpyDV6xI/pBoW4wszuKRQ5VCNSY
         5h9aWZOZ/QD85+22idc1Qm5/HvVwffxNHvrdr+wh5CAJte5G+8IyVO6iOXqvW7x0hz
         S2q6Tij/A6j4kr+IMTeaPQlJ8uYeWW4+BUK/6OAK6r/a7ZhnHwnUQMWn/LiyqDwK02
         9FokU4lwmBNPsj3YdhijmaPCzzhJyDQ4oQwH/huryKKS6GqJUmY/o0RvnpB82DVOTF
         fEMYcu7HJYCqnbttsK2/d40wBiSh8NH1sj9pTvUQT/0FMNnzzSmFDGg9pl1AdtlaC6
         MKgPJJVHxWhqg==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Casey Schaufler <casey@schaufler-ca.com>,
        kernel test robot <lkp@intel.com>,
        Sasha Levin <sashal@kernel.org>, jmorris@namei.org,
        serge@hallyn.com, linux-security-module@vger.kernel.org
Subject: [PATCH AUTOSEL 4.9 3/8] Fix incorrect type in assignment of ipv6 port for audit
Date:   Mon, 28 Mar 2022 07:24:51 -0400
Message-Id: <20220328112456.1557226-3-sashal@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220328112456.1557226-1-sashal@kernel.org>
References: <20220328112456.1557226-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

From: Casey Schaufler <casey@schaufler-ca.com>

[ Upstream commit a5cd1ab7ab679d252a6d2f483eee7d45ebf2040c ]

Remove inappropriate use of ntohs() and assign the
port value directly.

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 security/smack/smack_lsm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index 589c1c2ae6db..84ed47195cdd 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -2567,7 +2567,7 @@ static int smk_ipv6_check(struct smack_known *subject,
 #ifdef CONFIG_AUDIT
 	smk_ad_init_net(&ad, __func__, LSM_AUDIT_DATA_NET, &net);
 	ad.a.u.net->family = PF_INET6;
-	ad.a.u.net->dport = ntohs(address->sin6_port);
+	ad.a.u.net->dport = address->sin6_port;
 	if (act == SMK_RECEIVING)
 		ad.a.u.net->v6info.saddr = address->sin6_addr;
 	else
-- 
2.34.1

