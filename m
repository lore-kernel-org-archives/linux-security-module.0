Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 285C21D47BD;
	Tue, 14 Jan 2025 22:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736895126; cv=none; b=r2zyITS3ohzD5aiqlh9OYNGmFKqQr4hig6X5UtnWKP5AkbdeOMVRZt5MRwz6aNdg+h6QmsrvVcYFBNJoDqq6Fw1n8D81ziag8IlPRWn/0jpqBts5s9YidSAPiEkU30A43U6R3ut4UAvMV3JQSDcoYBlPtd6qyhSImppjHY/g6RQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736895126; c=relaxed/simple;
	bh=oUqudbsJVvJK2eLFC4NL3NopizVp4ti7NTk9yZrtAy4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=i+JnOTeVJzUDwrdOTK5NOO6eVd+FrURVt4Kjo2B7f3SZiiDvwnExHGBBEy0DmG3Bdgjd55sKC1Cq0Dgx8jjoudzqc5WbRUNSV6ihMtvSb9N/J1STlWaz6JEwBu4hkTGl2IZls23egzkU4Dwi18G5PFlN69yKdiOiS5nQtfDKH9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=h/KgglXK; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="h/KgglXK"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=xb5GiasEopiXQJY5FlPq9WPy1iZGuHLmFEUm3QLs3Mw=; b=h/KgglXKTldu8AR2YC6eZ6KfHn
	jszJMl1enKghbHjWoVXSBxoUjhYd6uIly+P4B79GrAiyEr0HTAoJNsUHXBPrKF4sZ5NirMUCsmoYw
	EGyV3I7KSG/8uuUKzG4AEvQXrPXTQUj6quYYA4oqMIw5KpDrXg6dPd9sivsqxErD/pnFXYeSDnRLi
	qSv1avuu0TJpZavQEe913OeiiDehTmtT6q66SE8IkaNt+vjN6y1F29OAK5VVPB7jqEGq6PEYE8aQg
	FGkVf/0qUrAz2HjPU+8PoAvy+5hZy7tNh1Q4PT9nPunyzMufkOfhvu64hWbg5jN2WCEqhtyRuNny6
	jj6p62cg==;
Received: from [50.53.2.24] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tXplQ-00000009zFD-01m5;
	Tue, 14 Jan 2025 22:52:00 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-doc@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>,
	Kees Cook <kees@kernel.org>,
	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <sergeh@kernel.org>,
	linux-security-module@vger.kernel.org,
	Kentaro Takeda <takedakn@nttdata.co.jp>,
	Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
	John Johansen <john.johansen@canonical.com>,
	John Johansen <john@apparmor.net>,
	Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH] Docs/security: update cmdline keyword usage
Date: Tue, 14 Jan 2025 14:51:56 -0800
Message-ID: <20250114225156.10458-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use "lsm=name,..." instead "security=name,..." since the latter is
deprecated.

Fixes: 89a9684ea158 ("LSM: Ignore "security=" when "lsm=" is specified")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Kees Cook <kees@kernel.org>
Cc: Paul Moore <paul@paul-moore.com>
Cc: James Morris <jmorris@namei.org>
Cc: "Serge E. Hallyn" <sergeh@kernel.org>
Cc: linux-security-module@vger.kernel.org
Cc: Kentaro Takeda <takedakn@nttdata.co.jp>
Cc: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Cc: John Johansen <john.johansen@canonical.com>
Cc: John Johansen <john@apparmor.net>
Cc: Jonathan Corbet <corbet@lwn.net>
---
 Documentation/admin-guide/LSM/apparmor.rst |    4 ++--
 Documentation/admin-guide/LSM/index.rst    |    2 +-
 Documentation/admin-guide/LSM/tomoyo.rst   |    2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

--- linux-next-20250113.orig/Documentation/admin-guide/LSM/apparmor.rst
+++ linux-next-20250113/Documentation/admin-guide/LSM/apparmor.rst
@@ -27,10 +27,10 @@ in the list.
 Build the kernel
 
 If AppArmor is not the default security module it can be enabled by passing
-``security=apparmor`` on the kernel's command line.
+``lsm=apparmor`` on the kernel's command line.
 
 If AppArmor is the default security module it can be disabled by passing
-``apparmor=0, security=XXXX`` (where ``XXXX`` is valid security module), on the
+``apparmor=0, lsm=XXXX`` (where ``XXXX`` is valid security module), on the
 kernel's command line.
 
 For AppArmor to enforce any restrictions beyond standard Linux DAC permissions
--- linux-next-20250113.orig/Documentation/admin-guide/LSM/index.rst
+++ linux-next-20250113/Documentation/admin-guide/LSM/index.rst
@@ -7,7 +7,7 @@ various security checks to be hooked by
 "module" is a bit of a misnomer since these extensions are not actually
 loadable kernel modules. Instead, they are selectable at build-time via
 CONFIG_DEFAULT_SECURITY and can be overridden at boot-time via the
-``"security=..."`` kernel command line argument, in the case where multiple
+``"lsm=..."`` kernel command line argument, in the case where multiple
 LSMs were built into a given kernel.
 
 The primary users of the LSM interface are Mandatory Access Control
--- linux-next-20250113.orig/Documentation/admin-guide/LSM/tomoyo.rst
+++ linux-next-20250113/Documentation/admin-guide/LSM/tomoyo.rst
@@ -18,7 +18,7 @@ to know what TOMOYO is.
 How to enable TOMOYO?
 =====================
 
-Build the kernel with ``CONFIG_SECURITY_TOMOYO=y`` and pass ``security=tomoyo`` on
+Build the kernel with ``CONFIG_SECURITY_TOMOYO=y`` and pass ``lsm=tomoyo`` on
 kernel's command line.
 
 Please see https://tomoyo.sourceforge.net/2.6/ for details.
