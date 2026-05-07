Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97D0B4779B2;
	Thu,  7 May 2026 19:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778181296; cv=none; b=ovWbkfFU80o4bQBtTdP8dzmftkTqq9jTnUNLhsv2vrzX7qNaaKVNM7FWO0YbpHBji1y7aCye5ZfR43Sx5oxfnE604qPV0wEWStG8NA4jdDo/RjVLmfNVg36tYnqFkPeOLYQqoylrVMp17T4Rp145bVYlSCwKRMpqHCNpXiDjpz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778181296; c=relaxed/simple;
	bh=0zA1iY10OAejTHGLKVAyct5fV1I29qtDkgUyjhfh6VI=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SSAostyIRNfKIyIwxx0RX9HIBlnhvivppk9ku+ikSkbMurgXj28bPZN2bbtdxExebn5ilGjveepSkOdygc7TlrdecdzPAkLhgWeLSEAb+kJVfkzUf9YHxrG0WbLpsKygQ7gt0w2hq5Dnuczt1j46w+FWWGX2cVnyBf/uJXrRQow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=RThnAfVE; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="RThnAfVE"
Received: from narnia.corp.microsoft.com (unknown [40.78.12.246])
	by linux.microsoft.com (Postfix) with ESMTPSA id E842920B716B;
	Thu,  7 May 2026 12:14:32 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com E842920B716B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1778181274;
	bh=D1OsiZIRk5fwjHT2yiYyh62NPa6JsLWz8+CUIzDsvys=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=RThnAfVEi4kQ0P+FKdMvUyjRGAR+e3QJfQ3o6Ql/mBBIRwrP7M6gjZIkYW+r7jedq
	 vlyuux8kzHZvwZ6ONVVQAvUiSXQarrvAu4KNIKMOw3lFh8P4vFSIq/Fu5PiVOlkgc5
	 CCQMBpvjB7JWTqfJtZJyU3FUNBv3JpuVPW3TTeH4=
From: Blaise Boscaccy <bboscaccy@linux.microsoft.com>
To: "Blaise Boscaccy" <bboscaccy@linux.microsoft.com>,
	"Jonathan Corbet" <corbet@lwn.net>,
	"Paul Moore" <paul@paul-moore.com>,
	"James Morris" <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	"Dr. David Alan Gilbert" <linux@treblig.org>,
	"Andrew Morton" <akpm@linux-foundation.org>,
	James.Bottomley@HansenPartnership.com,
	dhowells@redhat.com,
	"Fan Wu" <wufan@kernel.org>,
	"Ryan Foster" <foster.ryan.r@gmail.com>,
	"Randy Dunlap" <rdunlap@infradead.org>,
	linux-security-module@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	"Song Liu" <song@kernel.org>
Subject: [PATCH v7 05/10] lsm: security: Add additional enum values for bpf integrity checks
Date: Thu,  7 May 2026 12:13:59 -0700
Message-ID: <20260507191416.2984054-6-bboscaccy@linux.microsoft.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260507191416.2984054-1-bboscaccy@linux.microsoft.com>
References: <20260507191416.2984054-1-bboscaccy@linux.microsoft.com>
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

