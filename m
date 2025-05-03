Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92C359475;
	Sat,  3 May 2025 04:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746247766; cv=none; b=D2ly5sIxfwKO/VshDZi3kl7lLqJEWXJUixxWFs/iK9JUbeQo2cA4hS2f2I1rHT/9N6ajBs4Hmxv/0JP2NmKWsTYr1TOulnAn9Mq8OUuXLAhVOlJd5bGVxlLZ95v2BCXtFyYlGzfSPZt1erAVThQ1Ao/UM6g1ldEjmNHvSOwUrc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746247766; c=relaxed/simple;
	bh=dSOtAsq8LZNB/Cq42AXzsyMQUEjKueeZCKh2uuGvuCE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tEwe8kGUcg/rSIVzCo7SO/Puq6AldWuflh4nhupU1GSIYGjhNDAMB/wR49NrvojZzIovQgR3ar1tnKE3M+W1a/5vhE3T2IdLuLp3dm9yQLGI+4iXi19M/yD1iKstC49j6luToX0jgXOsjAU7lGVEdbfl80AefcjLMlyQcc8/aGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=be0MxFmG; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="be0MxFmG"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=sTf1FRwH6A4D5MEzYn1PF7BFIhzDcDRYclZq1Br8IHw=; b=be0MxFmG3SfTq94tz0JamifAD/
	M8G2sFd+DDyrl+1SJjH3fv1KlpWSJ4g3skwo0K4A8lZmU1owz3+MMwmS+DYPbsDNo/jWF8Wqr8y5n
	nUoI9xkAjh11eJAhlQ/lLEz96Fth19nmPDDASrPRzPQH/lj3Q600FAPq2Qj3jexGeb8Jvkh0UQkyr
	0rwanT+F3efh57Q0s7UU2y2K2efGVgdcCeHpJmS4sugp6CXue4kG25pMUmjx/XNQXl9sct4OrVZ+h
	mt4S9F6TI0HwpLw3fwQrn5X9wj57Fd1lkSCQ7DeAC6fTEsFCar86FJYg4oF2dkVWpedAAPoHSeuWA
	jwPwogHg==;
Received: from [50.39.124.201] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uB4oS-00000003UxL-2jDO;
	Sat, 03 May 2025 04:49:20 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-kernel@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>,
	Ryan Lee <ryan.lee@canonical.com>,
	John Johansen <john.johansen@canonical.com>,
	John Johansen <john@apparmor.net>,
	apparmor@lists.ubuntu.com,
	linux-security-module@vger.kernel.org,
	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>
Subject: [PATCH v2] apparmor: fix some kernel-doc issues in header files
Date: Fri,  2 May 2025 21:49:19 -0700
Message-ID: <20250503044919.2251962-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix kernel-doc warnings in apparmor header files as reported by
scripts/kernel-doc:

cred.h:128: warning: expecting prototype for end_label_crit_section(). Prototype was for end_current_label_crit_section() instead
file.h:108: warning: expecting prototype for aa_map_file_perms(). Prototype was for aa_map_file_to_perms() instead

lib.h:159: warning: Function parameter or struct member 'hname' not described in 'basename'
lib.h:159: warning: Excess function parameter 'name' description in 'basename'

match.h:21: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
 * The format used for transition tables is based on the GNU flex table

perms.h:109: warning: Function parameter or struct member 'accum' not described in 'aa_perms_accum_raw'
perms.h:109: warning: Function parameter or struct member 'addend' not described in 'aa_perms_accum_raw'
perms.h:136: warning: Function parameter or struct member 'accum' not described in 'aa_perms_accum'
perms.h:136: warning: Function parameter or struct member 'addend' not described in 'aa_perms_accum'

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Reviewed-by: Ryan Lee <ryan.lee@canonical.com>
Cc: John Johansen <john.johansen@canonical.com>
Cc: John Johansen <john@apparmor.net>
Cc: apparmor@lists.ubuntu.com
Cc: linux-security-module@vger.kernel.org
Cc: Paul Moore <paul@paul-moore.com>
Cc: James Morris <jmorris@namei.org>
Cc: "Serge E. Hallyn" <serge@hallyn.com>
---
v2: add better commit message (Ryan)

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
