Received: from out-171.mta1.migadu.com (out-171.mta1.migadu.com [95.215.58.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65F34219EB7
	for <linux-security-module@vger.kernel.org>; Mon,  9 Dec 2024 11:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733742351; cv=none; b=akSc0wQ59+v+HIkSopC9WPkRrL5yfPGFJ65Q+pcUBSjnWosE7tgNcEYOW1oa8fcj7tl59TmHaoWn5LmGwnLHLLrCRDMlYkjqoa8Q/ImvoNy4ydLqhBrBi7yDhL633xGlQocQjxRwQni0mRtXdFJLM9YsR+12qMgn3Umy6cakFzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733742351; c=relaxed/simple;
	bh=fDLGCHNnvCUBeSFHUfuHIPxsjXABmImXePDSaZv4E1Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=g6z2x2Pyo8nDNvljevqpGNspWQYeEcUlZgA/vSMYUXD5smtegx0/BIDBfIkEnFE/YLZ/t1ItZHUAfHbzTn+3FwkVp3eOmvw3BZ4U+3I2NDKktGn6KuK1ZW99C+8+gTmB1Nhr6B8Kib8bGz+daQmK/iyVbdv7p2LZ6VbBCM8gLxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=jlhPltXn; arc=none smtp.client-ip=95.215.58.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="jlhPltXn"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1733742345;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=WolgYZMpfkMHRgR0fLb1WnIXgvr5tDlp1x/fhzwycmc=;
	b=jlhPltXnqDGtTD1/ewQIh4My78FKjyA4eYFNP4PVyHBC8XR84JxecPhvQDWvRRkwoaEQ0z
	bE1/4CFHbIMCRuqqOrtIDdKtmFNHkrA9+elN6I4CV4EolOKiFRrpQMG1+SHwSN58eMuLha
	BVy0pY606SP4d5T8W9fpCLiLoBmAhro=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: John Johansen <john.johansen@canonical.com>,
	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	apparmor@lists.ubuntu.com,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RESEND PATCH] apparmor: Use str_yes_no() helper function
Date: Mon,  9 Dec 2024 12:05:16 +0100
Message-ID: <20241209110515.39744-2-thorsten.blum@linux.dev>
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
index 2c0185ebc900..1bce9a7d2129 100644
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
2.47.1

