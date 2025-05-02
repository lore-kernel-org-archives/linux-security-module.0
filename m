Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F279726AD9;
	Fri,  2 May 2025 01:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746150259; cv=none; b=crpQLxK6S21G20JknF5Kd9LMBPRB1ROyk92KAW8unYmXYrieJezV/C+p8+IwsA11MjbP4Ra07SujTOjKebeSFCOBfmnEfnhRiUmInYpP55BXB+uZt36vE3/4zcxZLVeJbtDMti5gwAv18UsSZiyyiV5z0aae9hs/pLp9rE1a5js=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746150259; c=relaxed/simple;
	bh=NklsBFoXQZqbYwgkrxmJvsEcB2wYi6W8c8133u8st14=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=f+YYm7pZ2rECFIL/Sgom9nHYc02xcywP23xncEeGnl0Y+RJ3MrYUiPozPMGnwk8isXD2/2VdMN2zERPdsZICEMzExOJsrwOtDt74LjRlUAsEqvIVnKOdPq/V0dSzruJWdnDd5rwfZTujjTQ553hg45FbJOxPNWjKQoL2d3DwPk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=qm3nRmRm; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="qm3nRmRm"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=4Lr87RbWXKo99QRyxBW8TG06bpLYqOX8TiwXB5KViIc=; b=qm3nRmRmSGqxmF1jh9W5clGYws
	oEkYrAyNK+qKtTMRFqg9uGC61llzYkxahSLM02BDeJGJyucfIYDEASmD3Ipifv3kn5LST/RqxtBMt
	Z/qXhPvcIp2C45GItMTzn/ZC2l+m4ViCBLWn1SY8av7fmV0aULKLAnkbmUsfjK2N6QZGMHmP9H18n
	kmOzu5edPopr2P9sB1be883oTX9aleAKzkqY4OxCmbBT3B/zpydfqbp8uKGDb2vEJQSDRr7R7XtLq
	l9MNVIPjNeriGQTjD+N91x+Y/gPdIKXYNNesomQ3lE5zl6Y9KQgOCbeIz+OIOpJkM3ly6DEsEQp20
	oL83GGDg==;
Received: from [50.39.124.201] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uAfRl-00000000Wil-01Kw;
	Fri, 02 May 2025 01:44:13 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-kernel@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>,
	John Johansen <john.johansen@canonical.com>,
	John Johansen <john@apparmor.net>,
	apparmor@lists.ubuntu.com,
	linux-security-module@vger.kernel.org,
	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>
Subject: [PATCH] apparmor: fix some kernel-doc issues in header files
Date: Thu,  1 May 2025 18:44:12 -0700
Message-ID: <20250502014412.682674-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit


cred.h:128: warning: expecting prototype for end_label_crit_section(). Prototype was for end_current_label_crit_section() instead
file.h:108: warning: expecting prototype for aa_map_file_perms(). Prototype was for aa_map_file_to_perms() instead

lib.h:159: warning: Function parameter or struct member 'hname' not described in 'basename'
lib.h:159: warning: Excess function parameter 'name' description in 'basename'

match.h:21: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
 * The format used for transition tables is based on the GNU flex table
 * The format used for transition tables is based on the GNU flex table

perms.h:109: warning: Function parameter or struct member 'accum' not described in 'aa_perms_accum_raw'
perms.h:109: warning: Function parameter or struct member 'addend' not described in 'aa_perms_accum_raw'
perms.h:136: warning: Function parameter or struct member 'accum' not described in 'aa_perms_accum'
perms.h:136: warning: Function parameter or struct member 'addend' not described in 'aa_perms_accum'

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: John Johansen <john.johansen@canonical.com>
Cc: John Johansen <john@apparmor.net>
Cc: apparmor@lists.ubuntu.com
Cc: linux-security-module@vger.kernel.org
Cc: Paul Moore <paul@paul-moore.com>
Cc: James Morris <jmorris@namei.org>
Cc: "Serge E. Hallyn" <serge@hallyn.com>
---
 security/apparmor/include/cred.h  |    2 +-
 security/apparmor/include/file.h  |    2 +-
 security/apparmor/include/lib.h   |    2 +-
 security/apparmor/include/match.h |    2 +-
 security/apparmor/include/perms.h |    8 ++++----
 5 files changed, 8 insertions(+), 8 deletions(-)

--- linux-next-20250501.orig/security/apparmor/include/cred.h
+++ linux-next-20250501/security/apparmor/include/cred.h
@@ -117,7 +117,7 @@ static inline struct aa_label *aa_get_cu
 #define __end_current_label_crit_section(X) end_current_label_crit_section(X)
 
 /**
- * end_label_crit_section - put a reference found with begin_current_label..
+ * end_current_label_crit_section - put a reference found with begin_current_label..
  * @label: label reference to put
  *
  * Should only be used with a reference obtained with
--- linux-next-20250501.orig/security/apparmor/include/file.h
+++ linux-next-20250501/security/apparmor/include/file.h
@@ -104,7 +104,7 @@ void aa_inherit_files(const struct cred
 
 
 /**
- * aa_map_file_perms - map file flags to AppArmor permissions
+ * aa_map_file_to_perms - map file flags to AppArmor permissions
  * @file: open file to map flags to AppArmor permissions
  *
  * Returns: apparmor permission set for the file
--- linux-next-20250501.orig/security/apparmor/include/lib.h
+++ linux-next-20250501/security/apparmor/include/lib.h
@@ -170,7 +170,7 @@ struct aa_policy {
 
 /**
  * basename - find the last component of an hname
- * @name: hname to find the base profile name component of  (NOT NULL)
+ * @hname: hname to find the base profile name component of  (NOT NULL)
  *
  * Returns: the tail (base profile name) name component of an hname
  */
--- linux-next-20250501.orig/security/apparmor/include/match.h
+++ linux-next-20250501/security/apparmor/include/match.h
@@ -17,7 +17,7 @@
 #define DFA_START			1
 
 
-/**
+/*
  * The format used for transition tables is based on the GNU flex table
  * file format (--tables-file option; see Table File Format in the flex
  * info pages and the flex sources for documentation). The magic number
--- linux-next-20250501.orig/security/apparmor/include/perms.h
+++ linux-next-20250501/security/apparmor/include/perms.h
@@ -101,8 +101,8 @@ extern struct aa_perms allperms;
 
 /**
  * aa_perms_accum_raw - accumulate perms with out masking off overlapping perms
- * @accum - perms struct to accumulate into
- * @addend - perms struct to add to @accum
+ * @accum: perms struct to accumulate into
+ * @addend: perms struct to add to @accum
  */
 static inline void aa_perms_accum_raw(struct aa_perms *accum,
 				      struct aa_perms *addend)
@@ -128,8 +128,8 @@ static inline void aa_perms_accum_raw(st
 
 /**
  * aa_perms_accum - accumulate perms, masking off overlapping perms
- * @accum - perms struct to accumulate into
- * @addend - perms struct to add to @accum
+ * @accum: perms struct to accumulate into
+ * @addend: perms struct to add to @accum
  */
 static inline void aa_perms_accum(struct aa_perms *accum,
 				  struct aa_perms *addend)
