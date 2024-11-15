Received: from out-176.mta0.migadu.com (out-176.mta0.migadu.com [91.218.175.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63B891898E9
	for <linux-security-module@vger.kernel.org>; Fri, 15 Nov 2024 10:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731665970; cv=none; b=esWlGQcf2S5G2+7rQMtoVtGRaH0LXLiveXKMq3z6XnFAYqizEpbOiOsRNC24UghPv91+BrIH/I7AHMDMgKk9U63UraPcJyOzmIgj75Ag1ELO0k5fxe6lHjKo7H+3eY/bbtZ4h5WRtKlraZPh5nOZ5P1BDtVkMoxAZNJ0YueGHXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731665970; c=relaxed/simple;
	bh=x7grUB44aQbAI627SgXKyzSOuD74l0wxSK2+BvHM5Ws=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GX81eipBYJNPncFw2TJJi1v2oyhmFfXrXbducRDs8JRaPKdbouCf3vycpSKT9wqlg8hdDl96Ei8xK0Zc+AIMqPC9GBdSXpQumo6gg4TU1dKq3A/ddyp+Mc2HH0S5U2tr+/rTwtFdcdHWLCkeoL/Xlaebr7QLfwT9HNBe1xR2EZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=MQFOGp5W; arc=none smtp.client-ip=91.218.175.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="MQFOGp5W"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1731665965;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=PaMXN2z2MU2mjVatiCT8fXujY/n/ws40Qs7HOkyj45M=;
	b=MQFOGp5WMSc5QypbSAtCvI8xfClmzLiqrQFo/wbf2KBUFee0DyyLk5G/AzVK/yd9OsCJsr
	HdejZkfKEk6/9CGRLezsoVDbx+zHdBVZtmaoNOQ/tBhrVrcxuMz+rdfSwHAGrqSxIkcsR6
	Btf42Nwe2m8gCtCQF94HRgZv4hMQUcw=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: John Johansen <john.johansen@canonical.com>,
	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	apparmor@lists.ubuntu.com,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] apparmor: Use str_yes_no() helper function
Date: Fri, 15 Nov 2024 11:18:44 +0100
Message-ID: <20241115101844.93574-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Remove hard-coded strings by using the str_yes_no() helper function.

Fix a typo in a comment: s/unpritable/unprintable/

Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 security/apparmor/apparmorfs.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/security/apparmor/apparmorfs.c b/security/apparmor/apparmorfs.c
index 01b923d97a44..94dbe91bf17a 100644
--- a/security/apparmor/apparmorfs.c
+++ b/security/apparmor/apparmorfs.c
@@ -997,7 +997,7 @@ static int aa_sfs_seq_show(struct seq_file *seq, void *v)
 
 	switch (fs_file->v_type) {
 	case AA_SFS_TYPE_BOOLEAN:
-		seq_printf(seq, "%s\n", fs_file->v.boolean ? "yes" : "no");
+		seq_printf(seq, "%s\n", str_yes_no(fs_file->v.boolean));
 		break;
 	case AA_SFS_TYPE_STRING:
 		seq_printf(seq, "%s\n", fs_file->v.string);
@@ -1006,7 +1006,7 @@ static int aa_sfs_seq_show(struct seq_file *seq, void *v)
 		seq_printf(seq, "%#08lx\n", fs_file->v.u64);
 		break;
 	default:
-		/* Ignore unpritable entry types. */
+		/* Ignore unprintable entry types. */
 		break;
 	}
 
@@ -1152,7 +1152,7 @@ static int seq_ns_stacked_show(struct seq_file *seq, void *v)
 	struct aa_label *label;
 
 	label = begin_current_label_crit_section();
-	seq_printf(seq, "%s\n", label->size > 1 ? "yes" : "no");
+	seq_printf(seq, "%s\n", str_yes_no(label->size > 1));
 	end_current_label_crit_section(label);
 
 	return 0;
@@ -1175,7 +1175,7 @@ static int seq_ns_nsstacked_show(struct seq_file *seq, void *v)
 			}
 	}
 
-	seq_printf(seq, "%s\n", count > 1 ? "yes" : "no");
+	seq_printf(seq, "%s\n", str_yes_no(count > 1));
 	end_current_label_crit_section(label);
 
 	return 0;
-- 
2.47.0

