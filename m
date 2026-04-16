Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55135254AFF;
	Thu, 16 Apr 2026 17:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776360937; cv=none; b=n11JANXZZAlHQLKfk1iQtsbquAkCgeqKT3+XPK2dHkurXNqKNw8Jg6KkIPajchOM0xY41hRN8aVRLEY7RpC/dxQBLS57Fc+gaaSqiAwubo7KeWzg2eL1c09v1CeVIYOXxXFEiqyo0Ktllz04zocz8kpMKJb7dpOokYeLHMhdTTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776360937; c=relaxed/simple;
	bh=0zA1iY10OAejTHGLKVAyct5fV1I29qtDkgUyjhfh6VI=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eJa8vjxqsNaJuuCjzpeuuxkgZyiUEtVdEg+q8ZxEmWtn/lNbtqttyzjbMxtaseguswkZlPI1ramCLJHn3kW1k3CdXuYlgPJWRHg1Y5VYs1M+j2JCrrYt4OihZCwfc1sWvRRmfENMfKw1NTsnq1rj0rWktKRm08JJJxSf6DDppSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=XmsNr/0x; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="XmsNr/0x"
Received: from narnia.corp.microsoft.com (unknown [40.78.12.246])
	by linux.microsoft.com (Postfix) with ESMTPSA id 5A58820B7136;
	Thu, 16 Apr 2026 10:35:34 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 5A58820B7136
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1776360935;
	bh=D1OsiZIRk5fwjHT2yiYyh62NPa6JsLWz8+CUIzDsvys=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=XmsNr/0x+f0JYyk3KtZaxu6R2GL99q7asd/OfsGUc7F/mK3mLo6YrJNutqoEfQc8i
	 iwEk361+aDFm4/hss7AIVKt9VjifYz1hxBv4nf5uWkumE2swWE45Msby3EuQY/vJJF
	 rBICGFPmqT1oF0bGrIQgnia8wRlx/6nPyg0Bwrjc=
From: Blaise Boscaccy <bboscaccy@linux.microsoft.com>
To: Blaise Boscaccy <bboscaccy@linux.microsoft.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	"Dr. David Alan Gilbert" <linux@treblig.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	James.Bottomley@HansenPartnership.com,
	dhowells@redhat.com,
	Fan Wu <wufan@kernel.org>,
	Ryan Foster <foster.ryan.r@gmail.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	linux-security-module@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	Song Liu <song@kernel.org>
Subject: [PATCH v4 05/10] lsm: security: Add additional enum values for bpf integrity checks
Date: Thu, 16 Apr 2026 10:33:26 -0700
Message-ID: <20260416173500.176716-6-bboscaccy@linux.microsoft.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260416173500.176716-1-bboscaccy@linux.microsoft.com>
References: <20260416173500.176716-1-bboscaccy@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

First add a generic LSM_INT_VERDICT_FAULT value to indicate a system
failure during checking. Second, add a LSM_INT_VERDICT_UNKNOWNKEY to
signal that the payload was signed with a key other than one that
exists in the secondary keyring. And finally add an
LSM_INT_VERDICT_UNEXPECTED enum value to indicate that a unexpected
hash value was encountered at some stage of verification.

Signed-off-by: Blaise Boscaccy <bboscaccy@linux.microsoft.com>
---
 include/linux/security.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/linux/security.h b/include/linux/security.h
index b3fd04baa78d0..4b4b8808f67de 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -106,6 +106,9 @@ enum lsm_integrity_verdict {
 	LSM_INT_VERDICT_OK,
 	LSM_INT_VERDICT_UNSIGNED,
 	LSM_INT_VERDICT_PARTIALSIG,
+	LSM_INT_VERDICT_UNKNOWNKEY,
+	LSM_INT_VERDICT_UNEXPECTED,
+	LSM_INT_VERDICT_FAULT,
 	LSM_INT_VERDICT_BADSIG,
 };
 
-- 
2.53.0

