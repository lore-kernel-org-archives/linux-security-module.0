Return-Path: <SRS0=EAti=ZO=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B286CC43215
	for <linux-security-module@archiver.kernel.org>; Fri, 22 Nov 2019 05:58:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 809782068F
	for <linux-security-module@archiver.kernel.org>; Fri, 22 Nov 2019 05:58:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574402334;
	bh=Bem4WhKsnLL+Ib474HsvJfup41+lAtVmwSQHdCk7+NM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=0ANtJlE8Amq5nmVcfvHH5EVN9T405aj/IZqTVVH+Z8ibgRMZY1BU3QergKqx1pI5S
	 TFKA5Y+gkOEvRp6F4MM41OYNhkwSaEc9BrcP0K/LLM6DVoc/1Q2VnWF8hEseXFCp8g
	 Wgw0ogJ/QF2MLCNimFyT0I8KoABjUkCV/E7I5fXs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726752AbfKVF6s (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 22 Nov 2019 00:58:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:36650 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728789AbfKVF6B (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 22 Nov 2019 00:58:01 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 688982084B;
        Fri, 22 Nov 2019 05:58:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574402281;
        bh=Bem4WhKsnLL+Ib474HsvJfup41+lAtVmwSQHdCk7+NM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qnFaCxyjzX4OibSkLI2oZ3Y6oQ4h8sKr4opl+OBlDuYFmS0wNCvPkdMLGmtZvDCGj
         w3sCcTV8NZ38AmWjXmxiGKu9z9PsvCaggVmChSmJzIuMZxRoIra4AZrWYe5FZq5UVq
         Wh6EVcIBV11R2boApGur+320oqcJrDNfJzdAx+t8=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Chris Coulson <chris.coulson@canonical.com>,
        John Johansen <john.johansen@canonical.com>,
        Sasha Levin <sashal@kernel.org>,
        linux-security-module@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 120/127] apparmor: delete the dentry in aafs_remove() to avoid a leak
Date:   Fri, 22 Nov 2019 00:55:37 -0500
Message-Id: <20191122055544.3299-118-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191122055544.3299-1-sashal@kernel.org>
References: <20191122055544.3299-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

From: Chris Coulson <chris.coulson@canonical.com>

[ Upstream commit 201218e4d3dfa1346e30997f48725acce3f26d01 ]

Although the apparmorfs dentries are always dropped from the dentry cache
when the usage count drops to zero, there is no guarantee that this will
happen in aafs_remove(), as another thread might still be using it. In
this scenario, this means that the dentry will temporarily continue to
appear in the results of lookups, even after the call to aafs_remove().

In the case of removal of a profile - it also causes simple_rmdir()
on the profile directory to fail, as the directory won't be empty until
the usage counts of all child dentries have decreased to zero. This
results in the dentry for the profile directory leaking and appearing
empty in the file system tree forever.

Signed-off-by: Chris Coulson <chris.coulson@canonical.com>
Signed-off-by: John Johansen <john.johansen@canonical.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 security/apparmor/apparmorfs.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/security/apparmor/apparmorfs.c b/security/apparmor/apparmorfs.c
index dd746bd69a9b2..c106988c1b254 100644
--- a/security/apparmor/apparmorfs.c
+++ b/security/apparmor/apparmorfs.c
@@ -363,6 +363,7 @@ static void aafs_remove(struct dentry *dentry)
 			simple_rmdir(dir, dentry);
 		else
 			simple_unlink(dir, dentry);
+		d_delete(dentry);
 		dput(dentry);
 	}
 	inode_unlock(dir);
-- 
2.20.1

