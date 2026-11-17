Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.125.188.120
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794923482;
	b=bzSAjbfygJ5jnwZh8rAJQWhmvmeHIZ+7VV648ortHtP+3S+lHTbySdOc3b+JmBpO4Wk/
	 zo1+/7xuS84X2HdPLOnmkT48ot4pY7y3Xi2nwvyjv11a0C9RdOCjcHNq5oeAOEBw11P2q
	 ULrZ2SGuodyPnw0KzGvlYT9zW8nvzwCDM/cXxQ/bkMwzrobqTcm33ZXovN3Mwb7zpfzlb
	 5DXxBEh2bGzDzdc1eksZKG9LCZi0glJT+ak5k+4MOazvw4K7JHc9CBfgPWWcWV71qVpF6
	 hIBe6Kia/bNKzBCRb/DhvCqmH9S3k49vHc7pcrRDfZjNGfiB6PjCiEjBnzaqt6c7TSQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794923482;
	h=DMARC-Filter:Received:DKIM-Signature:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=lYWfR5kJc1w9vz0DTl33LUKszdGVz1u+/UcFP+nJEC4=;
	b=BL6gCiUb1KmjFeIEwmlM497VQMCWzuX+rHTW0A3Vp0VwD6TtVdVCzccYzfBjATwBt2th
	 qaWPz90CLVVsMh9K+FVFzHFVYSFWbVLpWxd9f2oReTtFLLMPZUJBB3pty5vYvAMm0k7ea
	 NU9GbE93yFOuqO5610zU2kmw1AYL5x4D781iVsou7Ms9tKTg8J5YMsih04+DBWWzDqH17
	 9ViNvNDKhvc+XpETze2m9+gMoFLaUG55Aj+RKuHMOxBuTUPJFe579Q76vgfNRQ5dy6GEf
	 RWZFacFkjWFt/u883xUMQzUWUEg3zVey0zGlKcnd9bGnICcr9QHIqvlaWhbn8z2X0ww==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=canonical.com;
	spf=pass smtp.mailfrom=canonical.com;
	dkim=pass header.d=canonical.com header.i=@canonical.com header.a=rsa-sha256 header.s=20251003 header.b=FlZyDEf7;
	arc=none smtp.remote-ip=185.125.188.120
Received: from smtp-relay-canonical-0.canonical.com (smtp-relay-canonical-0.canonical.com [185.125.188.120])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73E6E606A31C
	for <linux-security-module@vger.kernel.org>; Tue, 17 Nov 2026 13:51:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 73E6E606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.a=rsa-sha256 header.s=20251003 header.b=FlZyDEf7
Received: from sec-questing-amd64 (lfbn-idf3-1-218-1.w90-22.abo.wanadoo.fr [90.22.217.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id BE31842CE0;
	Tue, 17 Nov 2026 13:51:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20251003; t=1794923479;
	bh=lYWfR5kJc1w9vz0DTl33LUKszdGVz1u+/UcFP+nJEC4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type;
	b=FlZyDEf7SVypayH0GRrR2/S9b7x6XYnO4wGrx2F2uPsnhg1hGKTNH84cdoiBbWHz4
	 Dee2rCqQNOIzMZ5u6cBHtZKrs9bmsA9E5boMIWYPPOp3lmOqHM4CPDV6YA8Dw+lDr/
	 eXb7U5hcOc9WdudlxVfdHHYtn9SQni6yEnc5xIP5sTY1TWZqS2PwAFtPwgyp3fNjjA
	 SsoJPY2hK4zRvoFjtbvc1Q0ohZeANE3g3z6ph7BWtFzDIv+tr+RS2gnHLCiBAX44vx
	 ec74libqnhauBPV2AJBWUfOvsxlq6e348xyNIMIMFOrEylFtGtjmAcXR+w9jZ/JP6c
	 4RcWR5aFr7pUvl9wpxn9ojflbYAmEPoH17RNL4jU6ZDApNQcRE3dR3JWAqF7psXosO
	 xO9fGfbry3vLYmaUV3tcpju7SE9k9DQFrdhT/oWuLuYLVpmgtA+3d2tQlIlbpp8GnU
	 RIwFroEZ61/Id9I4fKqjFuQPcfIpatJ/BV8vk+CLVP9YViZdYvFzsY0JZqOJ0u85w6
	 JVLYN0rPOppSmKlMIVcJlwnoc0WEbdCZp9L+OFeDSk83kVjVvNKC+KzuvHrBn42nU+
	 6VtsG9xs+/+CqkZqfXuSAYZbdG3er/eyVKJuTJSFGcXKfrKDpDLKfQmdvHwrcV6caM
	 Gl45C/r9QuSqFOMlkuKchMIM=
From: =?UTF-8?q?Maxime=20B=C3=A9lair?= <maxime.belair@canonical.com>
To: John Johansen <john.johansen@canonical.com>,
	Georgia Garcia <georgia.garcia@canonical.com>
Cc: apparmor@lists.ubuntu.com,
	linux-security-module@vger.kernel.org,
	=?UTF-8?q?Maxime=20B=C3=A9lair?= <maxime.belair@canonical.com>
Subject: [PATCH 4/4] kbuild: install the AppArmor feature set with the modules
Date: Tue, 17 Nov 2026 14:50:10 +0100
Message-ID: <20261117135042.78238-5-maxime.belair@canonical.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20261117135042.78238-1-maxime.belair@canonical.com>
References: <20261117135042.78238-1-maxime.belair@canonical.com>
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

A package hook that compiles the policy for a kernel when it is
installed only knows the release of that kernel, so the feature set
has to be in a place that is derived from the release.

Install it as $(MODLIB)/apparmor/features with modules_install

aa-precompile, which is proposed for the apparmor user space tools,
reads the file from /lib/modules/<release>/apparmor/features if it
exists.

Signed-off-by: Maxime Bélair <maxime.belair@canonical.com>
---
 Documentation/admin-guide/LSM/apparmor.rst | 15 +++++++++++++++
 scripts/Makefile.modinst                   |  6 ++++++
 2 files changed, 21 insertions(+)

diff --git a/Documentation/admin-guide/LSM/apparmor.rst b/Documentation/admin-guide/LSM/apparmor.rst
index 47939ee89d74..90e216556198 100644
--- a/Documentation/admin-guide/LSM/apparmor.rst
+++ b/Documentation/admin-guide/LSM/apparmor.rst
@@ -37,6 +37,21 @@ For AppArmor to enforce any restrictions beyond standard Linux DAC permissions
 policy must be loaded into the kernel from user space (see the Documentation
 and tools links).
 
+Feature set
+===========
+
+The kernel lists what it supports in the securityfs directory
+``/sys/kernel/security/apparmor/features``. The user space tools read it when
+they compile policy, and keep the compiled policy of each feature set apart.
+
+The same feature set is written to ``security/apparmor/features`` when the
+kernel is built, in the form that the user space tools flatten the directory
+to, and ``make modules_install`` installs it as
+``/lib/modules/$(KERNELRELEASE)/apparmor/features``. With that file the policy
+can be compiled for a kernel that is not running, e.g. when it is installed::
+
+   apparmor_parser --kernel-features=<file> ...
+
 Documentation
 =============
 
diff --git a/scripts/Makefile.modinst b/scripts/Makefile.modinst
index 9ba45e5b32b1..9df8e5ae014c 100644
--- a/scripts/Makefile.modinst
+++ b/scripts/Makefile.modinst
@@ -38,6 +38,12 @@ install-$(CONFIG_BUILTIN_MODULE_RANGES) += $(MODLIB)/modules.builtin.ranges
 $(addprefix $(MODLIB)/, modules.builtin modules.builtin.modinfo modules.builtin.ranges): $(MODLIB)/%: % FORCE
 	$(call cmd,install)
 
+# AppArmor feature set, to compile the policy for this kernel before it boots
+install-$(CONFIG_SECURITY_APPARMOR) += $(MODLIB)/apparmor/features
+
+$(MODLIB)/apparmor/features: security/apparmor/features FORCE
+	$(call cmd,install)
+
 endif
 
 modules := $(call read-file, modules.order)
-- 
2.51.0

