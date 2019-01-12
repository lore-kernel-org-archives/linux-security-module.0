Return-Path: <SRS0=mPKg=PU=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3831EC43387
	for <linux-security-module@archiver.kernel.org>; Sat, 12 Jan 2019 01:48:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07F1E20870
	for <linux-security-module@archiver.kernel.org>; Sat, 12 Jan 2019 01:48:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="XO372pDC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726376AbfALBsb (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 11 Jan 2019 20:48:31 -0500
Received: from sonic302-8.consmr.mail.bf2.yahoo.com ([74.6.135.47]:42697 "EHLO
        sonic302-8.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726227AbfALBsa (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 11 Jan 2019 20:48:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1547257709; bh=3T/fHYYvmo2xejiI510m7OsI/uDbaSeN0VKF8T7C0Vs=; h=Subject:To:References:Cc:From:Date:In-Reply-To:From:Subject; b=XO372pDCn0MluS/V/DmZKkuDocNCVA4BWCn4cZ7KFCgHq5C+ETzAG5eS6KgpOltm9W9BGdm6CDmiKS6kgmQkFaFuxX2vBV1nwxgIlPs7j6u03AAdJBo3NQz2l9CRz9ntZCR5Cz0gtktGE7/TTyG1n5c3k6AeocOoPHViQMzbYAst9DlzM/zrYcy6pssMe8PQvPoagSzmBFNO36Y0wYiUndhtJVbysJ9HtYZGUVdyvc0sI8wnP6KCxGNZMq0wuZhVSTsbqBviFHK1pStE76m0N9QfppwyoHXFEiEzjs33fexI9gw/XwM0cnDPMghJKfkwPFey57Vzm3TUnn8HVQoZFA==
X-YMail-OSG: pmE45WcVM1ne49SDjJyRkDUePmCxgxbvaV17xNv6bS4dN.oHqhBvvxeMF68uP6R
 5nDgwqcA5aGs8T9IZkZfHOvtQRtc81lNuntLXvyk1I6QiO8CgS0ICNuFesU28ibBbPFdTns843AC
 80GsXOBmxSUIhD_sBIpGHBZFa817E8R558HxBAHa8JbH6oSR8TJvw8SlMhhgqJt0um5SWNDQaZBs
 sQa_xQKYWWJ2jmx4CxDMD.mykBz1pQhxGmFYp7G7sd26dvDYpP.lhQJ9FNixOXzbrFYOSH.jjBSg
 7N8x1xJcJjirVhIyxB4403PWsDkxhVhdAw4peGwVVbx0jYJydwSwncQVfcSASATFbC4_BY0mbhBg
 b9adJF0xApvZucNBZ1bOGsgO9amJnc09ZrE.8.VRpEzNVyBKqToAGqzcGJtiYTkvgktamtNumuJs
 0J2dzOFQXv8xJTbP74M.qLQNHy4s5LiT.nuH8Dx_6bBMMW86skrExwciEJ0frIJk1OHAJ9GFrwow
 H3uijkGB0mvHlayMBGacvgyv9_jZVrI88n8Ru6d4YbTs6HTGe8LSrLGY.xHhZQ5rkgWtHI49sMuB
 bEfM5yeDa36AgTj2g3PwvT4sdyGftItypaOK4y_QMBZvhI4qcPoBsyh4npq_a9yFtGbwEMuY2ulM
 zR_gNjBJECwZMvDoRi.jDre2_5RP4yu1z5IVZGitojwXGRXsWHFgh3otXK9VW.kgmqlyndHXuNYF
 fGBCma2VVkqlUH6we3Y1tVHl6UZOwUJAc1OAsBYtchwrJPQccJda_yv7r8_DOoECggAvM7cwMBBm
 .EQbxA1HnD4e.hFZQbZ12XuvzCikW7q9IclUqJV4LEls_qf2vsHChY7d8HifHc6qZcmUqsTug8Dv
 QSZ_GmRFYzPf_eterJTpa4R1BEJub4U8vXuDSksZtJ4VZPj8gOt47yzoF7626xk314N7vq._pCM8
 oV.BXIt61Pt0sRCye53c3nn2uZSiKbrkDsyrBVh.pdBscF8Q9xeekYKEUl.p9EYE2TB64v3n5LIn
 8s7dPFq7Gaot9aoaNe.amW57_33mlbGx8isQdiqdiO1czRAlmE.mhOCTmbwYpmEn4imtT1c7FLcB
 hRP6WyJCwLktnSyFANlsrHxgR0PyL9eRLuBQgPQcO
Received: from sonic.gate.mail.ne1.yahoo.com by sonic302.consmr.mail.bf2.yahoo.com with HTTP; Sat, 12 Jan 2019 01:48:29 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO [192.168.0.102]) ([67.169.65.224])
          by smtp425.mail.bf1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 84cce40cbe5743dc80789c2b04069165;
          Sat, 12 Jan 2019 01:48:27 +0000 (UTC)
Subject: Re: WARNING in apparmor_cred_free
To:     John Johansen <john.johansen@canonical.com>, jmorris@namei.org,
        linux-security-module@vger.kernel.org, serge@hallyn.com
References: <0000000000007f604f057f2b8509@google.com>
 <6213e783-4377-489d-cdfb-1a83f4497076@schaufler-ca.com>
 <b0d2811e-87e4-21d4-c33a-2d2012a906cc@canonical.com>
 <2ccf6281-3f4b-a94a-ed71-31905e583fa6@schaufler-ca.com>
 <234c868b-4521-0707-a135-d8c24bc179bd@schaufler-ca.com>
Cc:     Casey Schaufler <casey@schaufler-ca.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
Message-ID: <546a62d3-29a9-f8cf-09f7-ab760b50dc19@schaufler-ca.com>
Date:   Fri, 11 Jan 2019 17:48:24 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.3
MIME-Version: 1.0
In-Reply-To: <234c868b-4521-0707-a135-d8c24bc179bd@schaufler-ca.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

From 1a2a99f3cfd069baf9aa0ef91529558bcbe64c14 Mon Sep 17 00:00:00 2001
From: Casey Schaufler <casey@schaufler-ca.com>
Date: Fri, 11 Jan 2019 17:37:56 -0800
Subject: [PATCH 2/2] AppArmor: Fix credential blob assertions

The assertions for NULL credential blobs don't take blob
offsetting into account. Check the raw data, not th eoffset value.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 security/apparmor/include/cred.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/security/apparmor/include/cred.h b/security/apparmor/include/cred.h
index b9504a05fddc..29cef1b5687c 100644
--- a/security/apparmor/include/cred.h
+++ b/security/apparmor/include/cred.h
@@ -27,7 +27,7 @@ static inline struct aa_label *cred_label(const struct cred *cred)
 {
 	struct aa_label **blob = cred->security + apparmor_blob_sizes.lbs_cred;
 
-	AA_BUG(!blob);
+	AA_BUG(!cred->security);
 	return *blob;
 }
 
@@ -36,7 +36,7 @@ static inline void set_cred_label(const struct cred *cred,
 {
 	struct aa_label **blob = cred->security + apparmor_blob_sizes.lbs_cred;
 
-	AA_BUG(!blob);
+	AA_BUG(!cred->security);
 	*blob = label;
 }
 
-- 
2.20.1


