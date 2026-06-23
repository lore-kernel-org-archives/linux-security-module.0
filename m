Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6388522256F;
	Tue, 23 Jun 2026 01:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782179463; cv=none; b=SxXbTVP22q4F/G+6e7qK+YS6lgdwiyLsvJB94aa4jPxC+XMxmViDYUASM/HAJl6qnZPi7Pyn+VCgWmCdVEIwTVMaQ18jQ7JbMyJUPWvnXKewcHwetP4E/nhzgvu+/J9M21hhAM1DkyiD+82FK7Qsfq27RmAhecYT/pd0iXswPE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782179463; c=relaxed/simple;
	bh=xXaIVclTBxxMHebQRc9bqNv0HFQ7pgJxzL+B0F+JVHQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=AtyaUBhZQitznX7M+6oqW6L/Z7b9O1WP8/Sw3JfrshwafNszdsFtt48U/N8AgV5ciO/LDCBb+iC/YBqXPMN3YwhoUSgiwR0tpnTUrdHGj3vWNV+9Q60tHZ23cy7SxV3icYfOvivgIatgoUsPgCCuqP3sJAIwbb4vrSZnScbzvXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: f8314ae86ea511f1aa26b74ffac11d73-20260623
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:0888dc32-b462-4b12-8b01-e3b6f94b13e7,IP:0,U
	RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-5
X-CID-META: VersionHash:e7bac3a,CLOUDID:d4a2e6bf207307ba2fabbbb3674f094e,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:102|123|136|850|865|898|915,TC:nil,Conte
	nt:0|15|50,EDM:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL
	:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: f8314ae86ea511f1aa26b74ffac11d73-20260623
X-User: yaolu@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <yaolu@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 608691221; Tue, 23 Jun 2026 09:50:53 +0800
From: yaolu@kylinos.cn
To: john.johansen@canonical.com,
	paul@paul-moore.com,
	jmorris@namei.org,
	serge@hallyn.com
Cc: apparmor@lists.ubuntu.com,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Lu Yao <yaolu@kylinos.cn>,
	k2ci <kernel-bot@kylinos.cn>
Subject: [PATCH] apparmor: mv get_loaddata_common_ref() into CONFIG_SECURITY_APPARMOR_EXPORT_BINARY block
Date: Tue, 23 Jun 2026 09:50:49 +0800
Message-Id: <20260623015049.41392-1-yaolu@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Lu Yao <yaolu@kylinos.cn>

When SECURITY_APPARMOR_EXPORT_BINARY is not set, the compiler emits an
unused-function warning which is promoted to an error with -Werror:
  security/apparmor/apparmorfs.c:177:28: error: ‘get_loaddata_common_ref’ defined but not used [-Werror=unused-function]

Move the function into the #ifdef block to match its only call site,
silencing the warning.

Fixes: 8e135b8aee5a ("apparmor: fix race between freeing data and fs accessing it")
Reported-by: k2ci <kernel-bot@kylinos.cn>
Signed-off-by: Lu Yao <yaolu@kylinos.cn>
---
 security/apparmor/apparmorfs.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/security/apparmor/apparmorfs.c b/security/apparmor/apparmorfs.c
index ededaf46f3ca..f762b101d682 100644
--- a/security/apparmor/apparmorfs.c
+++ b/security/apparmor/apparmorfs.c
@@ -174,14 +174,6 @@ static struct aa_proxy *get_proxy_common_ref(struct aa_common_ref *ref)
 	return NULL;
 }
 
-static struct aa_loaddata *get_loaddata_common_ref(struct aa_common_ref *ref)
-{
-	if (ref)
-		return aa_get_i_loaddata(container_of(ref, struct aa_loaddata,
-						      count));
-	return NULL;
-}
-
 static void aa_put_common_ref(struct aa_common_ref *ref)
 {
 	if (!ref)
@@ -1318,6 +1310,14 @@ static const struct file_operations seq_rawdata_ ##NAME ##_fops = {	      \
 	.release	= seq_rawdata_release,				      \
 }									      \
 
+static struct aa_loaddata *get_loaddata_common_ref(struct aa_common_ref *ref)
+{
+	if (ref)
+		return aa_get_i_loaddata(container_of(ref, struct aa_loaddata,
+						      count));
+	return NULL;
+}
+
 static int seq_rawdata_open(struct inode *inode, struct file *file,
 			    int (*show)(struct seq_file *, void *))
 {
-- 
2.25.1

