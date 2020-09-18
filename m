Return-Path: <SRS0=iYml=C3=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D545C43465
	for <linux-security-module@archiver.kernel.org>; Fri, 18 Sep 2020 02:13:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5ADC223787
	for <linux-security-module@archiver.kernel.org>; Fri, 18 Sep 2020 02:13:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1600395196;
	bh=x8jtC8Q1lphuUcKtQz2n3M+Vhekuau3Ukrj1emkaMfk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=HquCyR+EYeK7XS9js2trSk40K/LY6BsZDO/kdPQfrkxuUZMtGZGwbCkf07C2wrMNm
	 Fvz3ySLKS4Fk++yWJ/v6hBhe2L3RUWKTehUaW/A2puSJWQIqyb/ymT8PC5gbYnOUPK
	 QFWqSIuG7D5EoRax93jTcvJEJgF+b5GBknvarA74=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727926AbgIRCNP (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 17 Sep 2020 22:13:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:40176 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727130AbgIRCNN (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 17 Sep 2020 22:13:13 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0B2B32376E;
        Fri, 18 Sep 2020 02:13:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600395192;
        bh=x8jtC8Q1lphuUcKtQz2n3M+Vhekuau3Ukrj1emkaMfk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=u+EV3DHEtp1ppHHb/JXwxMIB1oV+ollLQp8+5SK3JY0YfCdXaCVsuiCQzp77S3VdM
         4sABm8TIZX8Dlh3nnus6jbtZ7vLa7GiGDR+3BOGi7/rlj01EibL7FQqb41k57ohUyH
         cUzKFYet2OBRHrdHTqDA5r+IIr/f3l/N+DdTQ/JA=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Vasily Averin <vvs@virtuozzo.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Paul Moore <paul@paul-moore.com>,
        Sasha Levin <sashal@kernel.org>, selinux@tycho.nsa.gov,
        linux-security-module@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 044/127] selinux: sel_avc_get_stat_idx should increase position index
Date:   Thu, 17 Sep 2020 22:10:57 -0400
Message-Id: <20200918021220.2066485-44-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200918021220.2066485-1-sashal@kernel.org>
References: <20200918021220.2066485-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

From: Vasily Averin <vvs@virtuozzo.com>

[ Upstream commit 8d269a8e2a8f0bca89022f4ec98de460acb90365 ]

If seq_file .next function does not change position index,
read after some lseek can generate unexpected output.

$ dd if=/sys/fs/selinux/avc/cache_stats # usual output
lookups hits misses allocations reclaims frees
817223 810034 7189 7189 6992 7037
1934894 1926896 7998 7998 7632 7683
1322812 1317176 5636 5636 5456 5507
1560571 1551548 9023 9023 9056 9115
0+1 records in
0+1 records out
189 bytes copied, 5,1564e-05 s, 3,7 MB/s

$# read after lseek to midle of last line
$ dd if=/sys/fs/selinux/avc/cache_stats bs=180 skip=1
dd: /sys/fs/selinux/avc/cache_stats: cannot skip to specified offset
056 9115   <<<< end of last line
1560571 1551548 9023 9023 9056 9115  <<< whole last line once again
0+1 records in
0+1 records out
45 bytes copied, 8,7221e-05 s, 516 kB/s

$# read after lseek beyond  end of of file
$ dd if=/sys/fs/selinux/avc/cache_stats bs=1000 skip=1
dd: /sys/fs/selinux/avc/cache_stats: cannot skip to specified offset
1560571 1551548 9023 9023 9056 9115  <<<< generates whole last line
0+1 records in
0+1 records out
36 bytes copied, 9,0934e-05 s, 396 kB/s

https://bugzilla.kernel.org/show_bug.cgi?id=206283

Signed-off-by: Vasily Averin <vvs@virtuozzo.com>
Acked-by: Stephen Smalley <sds@tycho.nsa.gov>
Signed-off-by: Paul Moore <paul@paul-moore.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 security/selinux/selinuxfs.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/security/selinux/selinuxfs.c b/security/selinux/selinuxfs.c
index 00eed842c491c..bf50fead9f8c0 100644
--- a/security/selinux/selinuxfs.c
+++ b/security/selinux/selinuxfs.c
@@ -1425,6 +1425,7 @@ static struct avc_cache_stats *sel_avc_get_stat_idx(loff_t *idx)
 		*idx = cpu + 1;
 		return &per_cpu(avc_cache_stats, cpu);
 	}
+	(*idx)++;
 	return NULL;
 }
 
-- 
2.25.1

