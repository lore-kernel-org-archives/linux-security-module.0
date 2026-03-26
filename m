Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B4B93B27CC;
	Thu, 26 Mar 2026 06:07:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774505236; cv=none; b=MVreVBlCqQjm/aZhRSc9hBNqwhf/OKGuhnGc7LhIOkGo2bGNYBaaTH696MZtguus/F4ugBi/T/ybtkrmqrefvTOOnWVIGifTlTdhl9PmiezuWNLpilItU13yssRh/GZ20BOiuwS871zBDmvogxE0PTzTPcTRzrUltEPSgnoJDa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774505236; c=relaxed/simple;
	bh=lYY7mlnz/I5tTigKcZU1CGQmpWi+foMTdQ91LE8eJUY=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bs8lYTbT2N1wHA+80QD8rVO+rROuOScxZ+pD5oKGbFUGG5ZxSIEuvsUBooIoSyCjAoiEKVhNkhE8hyncVOy4UixiFNo3CcEA8Gsz6ljwY3K6a920a7/0rqwLqDvQqcRWFQ7kAozfMb2nLm5SEZp2GKylxZU/2U+4PMJK++/UQnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=tMWln0cW; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="tMWln0cW"
Received: from narnia.corp.microsoft.com (unknown [40.78.13.173])
	by linux.microsoft.com (Postfix) with ESMTPSA id A821F20B7135;
	Wed, 25 Mar 2026 23:07:13 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com A821F20B7135
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1774505235;
	bh=h+ZXPkrSgGzxoBzPwxxF4EFDe8cfsVIUv4H7fHFxIBY=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=tMWln0cWZL+Zue3zqlV7P+TxPY5E//icK6I25ng2m0X04F5jHqU7HVn2QDvUPIJak
	 iuCyaBJr8vW00JbUdRYt+gWafbJHlaLnGSGEKQlWYInyguW8OvSRkJz7sfBmrZS7W/
	 rl16rmTFLG0NwXJs0a+A4TY2sqU8WYhsnk5uv9DQ=
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
	bpf@vger.kernel.org
Subject: [PATCH v3 5/9] lsm: security: Add additional enum values for bpf integrity checks
Date: Wed, 25 Mar 2026 23:06:34 -0700
Message-ID: <20260326060655.2550595-6-bboscaccy@linux.microsoft.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260326060655.2550595-1-bboscaccy@linux.microsoft.com>
References: <20260326060655.2550595-1-bboscaccy@linux.microsoft.com>
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
index 298a43b7744a4..84c82c41b48c4 100644
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

