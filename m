Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0A6634405B;
	Fri, 12 Jun 2026 06:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781244625; cv=none; b=RrATlrDT2GLvqOQe7e95xFK2AXKVBvLJpFv9ocykzVjYc0kmEFRKoS1KC5VqUJRV0Ba2pQWdhuyQrBwlM7OC3H4+nHZV8j7uo0uknWds9qUXb+T5EZ5rSQQ69dB01ueSDE2E5CSGBeQtSD1YwXgOtESxgOrroux9P8u1ExDBT5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781244625; c=relaxed/simple;
	bh=/pnmg4b6IbGgKPW95mtpYJMdXdq9qWFLslJWXAfkC98=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Rx+JmJQ7hNALO5U6V8SObhp/PawBZVTHhKGFcXmLwRVaDaATROu25hpOlZ5h1bNUylnnzvo+SXyjOjblaee8yXAnyFz+L2Lz1P3RLP6yOCNf+TFbptz7G5S2TD6gzEXY8DALrearWBIQnoXe1mmpKSIZtBpY5ybPc1zfvhzGgY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Q4jbyr2F; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Q4jbyr2F"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781244623; x=1812780623;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=/pnmg4b6IbGgKPW95mtpYJMdXdq9qWFLslJWXAfkC98=;
  b=Q4jbyr2FFRUT7zK9SOuugXNgFmP8NxB4eLWpBHXXTiflrkj4Ny/ymTFR
   VU5dBaAwVKS8xqS150shrWrg7qTTGxlG18HebIxlOb+nm9mJOdwkQpPQv
   fBu0q5u0Vtt5R/B3rQHE5BbI/h9QBE4B+kbrvALuMAelelcw3WP5zC8ZD
   ZJUN3+lgPaPYDmI+M/urkv2QGjXNWO+t85749kJPmK95LRCWeLW05KCbB
   QUAu+k2MlU1disXs3S7migVbUu411srTFmM1Ybi9atq63ePyh+fa+ONaG
   FLJlN0KitOFh8LpDkS1I2/BU61Qy0n4Je7nF9xR7MbNUKgg0/bjn3Mq1b
   w==;
X-CSE-ConnectionGUID: UFs3O/ogQQGuhWSCePN/rg==
X-CSE-MsgGUID: 3LyLgCZySOuRjc9T69/gDA==
X-IronPort-AV: E=McAfee;i="6800,10657,11813"; a="81813398"
X-IronPort-AV: E=Sophos;i="6.24,200,1774335600"; 
   d="scan'208";a="81813398"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2026 23:10:18 -0700
X-CSE-ConnectionGUID: WKbNtLBQQ/2A+My/OUI1Mw==
X-CSE-MsgGUID: xT8M6QAgS+amg3Sgb4sgYQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,200,1774335600"; 
   d="scan'208";a="245633328"
Received: from junxiao.bj.intel.com ([10.238.152.69])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2026 23:10:15 -0700
From: Junxiao Chang <junxiao.chang@intel.com>
To: john.johansen@canonical.com,
	paul@paul-moore.com,
	jmorris@namei.org,
	serge@hallyn.com,
	apparmor@lists.ubuntu.com,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: junxiao.chang@intel.com
Subject: [PATCH] apparmor: fix use-after-free in policy replacement path
Date: Sat, 13 Jun 2026 14:04:24 +0800
Message-ID: <20260613060424.2213712-1-junxiao.chang@intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A use-after-free issue can be triggered when running the
following stress-ng workload:

```
sudo stress-ng --apparmor 0 --timeout 30 \
    --oom-avoid-bytes 10% --skip-silent --verbose
```

The warning looks like:

```
refcount_t: addition on 0; use-after-free
aa_replace_profiles+0xbe5/0x12a0
policy_update+0xdb/0x170
profile_replace+0x4b/0xb0
```

The issue can be reproduced on both v7.1-rc7 and Ubuntu
6.17.0-35-generic kernels.

aa_get_profile_loaddata() requires the supplied loaddata object
to hold a valid reference. However, the loaddata reference count
may already have reached zero in the replacement loop, resulting
in a use-after-free condition.

Avoid calling aa_get_profile_loaddata() on loaddata objects with
a zero reference count and skip those entries instead.

Fixes: a0b7091c4de4 ("apparmor: fix race on rawdata dereference")
Signed-off-by: Junxiao Chang <junxiao.chang@intel.com>
---
 security/apparmor/policy.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/security/apparmor/policy.c b/security/apparmor/policy.c
index b6a5eb4021dbd..98f84d4552697 100644
--- a/security/apparmor/policy.c
+++ b/security/apparmor/policy.c
@@ -1220,7 +1220,7 @@ ssize_t aa_replace_profiles(struct aa_ns *policy_ns, struct aa_label *label,
 	/* check for duplicate rawdata blobs: space and file dedup */
 	if (!list_empty(&ns->rawdata_list)) {
 		list_for_each_entry(rawdata_ent, &ns->rawdata_list, list) {
-			if (aa_rawdata_eq(rawdata_ent, udata)) {
+			if (kref_read(&rawdata_ent->pcount) && aa_rawdata_eq(rawdata_ent, udata)) {
 				struct aa_loaddata *tmp;
 
 				tmp = aa_get_profile_loaddata(rawdata_ent);
-- 
2.43.0

