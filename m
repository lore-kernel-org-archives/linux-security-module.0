Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FE8812D21B
	for <linux-security-module@vger.kernel.org>; Sun, 21 Jun 2026 03:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782013963; cv=none; b=ry+TwDDbHk6PwYrjPfly9V3VsfZqFtyuhw3DGp0V/rEjwtTGM/4T23x1vDgemgbEmPftIcdSGWYb7AO7j7fANV3OiV7qiAiZe1SrFoLqlDt5Yzl53uS0G/YQS2N9la5mek0rYbA8TB9tcj36oI94acv/reWuZwJLXP3mjFC25HY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782013963; c=relaxed/simple;
	bh=FZd5DsHPj4rFhiKKfaIJxVG1cMqjNuywmpkSrL6N4wc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iByFZVNYed2O9SKTlusRudtzUVFKvGdRKbspmkiVnP51RRcXfkOy/KRXE2sufMTBhRcs14z+1WYlP9hdQKNAF/34QljIUYfCzKdXUrxkM5x+FaP3pWvhdUe0Jd+A6CJRvBx62nR0+4+xqzA7Y4bxVXxUH3e/dA0onjyRWH4EonI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Plsefd1I; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Plsefd1I"
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-7fe723ca5e5so35120097b3.2
        for <linux-security-module@vger.kernel.org>; Sat, 20 Jun 2026 20:52:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782013961; x=1782618761; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8fq04o7upT7hpwl1ku/PstTdBA7bX7Cs7dspUhvNNew=;
        b=Plsefd1IWiZ0wj4CK2DDLEh8DZHwS7v1pH36OYMnQ2dxwivOkn3aXPwLEXvltf6Esw
         JQA1m/h7QT1Bo2jmy5HFN9SBhsLnpoPD8uyRineik5J+3QIe43moxaMulp2DmCkynV8B
         iBxVymqAy3ZzqACT+lWADTwaIkpFhbD62onSUfkxWkjOpzaIvwoyNvV3QfdsalixOg+P
         wwf1laEF7PBqkSEz1x2UWHvAVDtdoL42F/ESU8ZrdnwZm2S/Q7KxJfsqOWYKmXfwgWJu
         BC1zOA5MXVDTUINPrciWmxqWv/PxPvj9co2rwTPeIjBprdUn2RoVuGtVMm+lVVpljAuw
         OIDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782013961; x=1782618761;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8fq04o7upT7hpwl1ku/PstTdBA7bX7Cs7dspUhvNNew=;
        b=nmhXPBLckfPbCthGQFI4mPzByTkZqmLGhygEviCZFzysldirOc6I0GbJj7q855uDQf
         WIaaLAO6fLfcweILoN7kGMswyJDlGn+DGCY/iSqHJvi9GpZwYYil9Fo6MEDKFf0x3RYG
         bMJmKWT++8/xet/68XZbVS+y1vdpn3TOxr+ZABSDdC8ZwVFiLycNFoTZpePgNse94EN1
         1/0oaECIlWV8+ohDPlN+JCn984eKb8M5FOUtJZkQG8BV6Kfkt7zzAZvoiKQIqCRtI910
         5KzOyy9J2wXpZvBb0Ktti3t0v/7Np9uip1BGStfm9yjx5R1ffwS9Y1vLRbz67Y4t6yHv
         pxUQ==
X-Gm-Message-State: AOJu0Yz3tdyCSuplglNoEU7wV37e9QSL6XC1JIC3P3NsmR8k+fHI+ami
	7YOEMwJtHxW5BI2w0X5N0oO/wtP50ckBDNeT5WfVty0fQp66NU+Q6nkqRzcFCA==
X-Gm-Gg: AfdE7cnaRngkA1t6vFIkDXj9lU+zi9scnOXB1PYEuRVC8m56xEcZi07Le6R8OFljSCw
	0j9P3quNZRFGsGLgTrjlAlomo9z3tE0TqqlQs9ZvuF/cWt6AOWjJeisZ7s2ayREfs5kot6sM2M0
	4TMuFKoCpqnQ33GlsqvYMvYhDWK14MHEHCkfFCLieiz4A1Er65/0KiynuBKJO8RbaVagMRJYyot
	P3AI4GfQ7v/L1+q9QuVG5XqEgfUfpz94gk39npdXAA1VbpPwNGYIKjonmZmNo11EfljmZa9cVJF
	9UhFpKzl6ino5phh5L4Z5TY5vbVdHiCPLFEQ0lW8MWxS4DtGZUMYHbd06uRqtzIBsBEQ0q6iEhU
	owCWy7xMvXGWfflnVQp6Tfb6V77spOuxDPcsYZdEjW54L5d7IYns6EOwO6JTh2F28dfR6SZztlO
	NQUKD/xpXRKnaJneh2rhCQa3CLTxi+bqO08njb38yCTlKP00nFCkg2lNqt
X-Received: by 2002:a05:690c:c521:b0:7dc:9693:57b0 with SMTP id 00721157ae682-80133402b29mr100004327b3.42.1782013961541;
        Sat, 20 Jun 2026 20:52:41 -0700 (PDT)
Received: from zenbox ([2600:1700:18fb:6011:2de9:628a:4b2:9b39])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8025cf61d36sm17155677b3.11.2026.06.20.20.52.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Jun 2026 20:52:41 -0700 (PDT)
From: Justin Suess <utilityemal77@gmail.com>
To: linux-security-module@vger.kernel.org,
	mic@digikod.net
Cc: m@maowtm.org,
	gnoack@google.com,
	gnoack3000@gmail.com,
	matthieu@buffet.re,
	Justin Suess <utilityemal77@gmail.com>
Subject: [PATCH v9 7/9] samples/landlock: Add LANDLOCK_ADD_RULE_NO_INHERIT to landlock-sandboxer
Date: Sat, 20 Jun 2026 23:52:20 -0400
Message-ID: <20260621035223.2651547-8-utilityemal77@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260621035223.2651547-1-utilityemal77@gmail.com>
References: <20260621035223.2651547-1-utilityemal77@gmail.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a new LL_FS_NO_INHERIT environment variable to the sandboxer.
Paths listed in it are added with the LANDLOCK_ADD_RULE_NO_INHERIT
flag, demonstrating how to set up a parent directory with broader
access than its children.

The flag is silently skipped on kernels older than ABI 11.

Cc: Tingmao Wang <m@maowtm.org>
Signed-off-by: Justin Suess <utilityemal77@gmail.com>
---

Notes:
    Changes since v8:
    - Added an explicit ABI 10 case to the sandboxer's downgrade switch so
      the NO_INHERIT flag is stripped on kernels with ABI < 11.
    - Updated for the merged quiet-flag env-var renames, LANDLOCK_ABI_LAST,
      and help text (ABI >= 11).
    - Rebased onto mic/next.

 samples/landlock/sandboxer.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/samples/landlock/sandboxer.c b/samples/landlock/sandboxer.c
index ac71019e6212..80c2120d4171 100644
--- a/samples/landlock/sandboxer.c
+++ b/samples/landlock/sandboxer.c
@@ -59,6 +59,7 @@ static inline int landlock_restrict_self(const int ruleset_fd,
 #define ENV_FS_RO_NAME "LL_FS_RO"
 #define ENV_FS_RW_NAME "LL_FS_RW"
 #define ENV_FS_QUIET_NAME "LL_FS_QUIET"
+#define ENV_FS_NO_INHERIT_NAME "LL_FS_NO_INHERIT"
 #define ENV_TCP_BIND_NAME "LL_TCP_BIND"
 #define ENV_TCP_CONNECT_NAME "LL_TCP_CONNECT"
 #define ENV_NET_QUIET_NAME "LL_NET_QUIET"
@@ -369,7 +370,7 @@ static int add_quiet_access(const char *const env_var,
 	return 0;
 }
 
-#define LANDLOCK_ABI_LAST 10
+#define LANDLOCK_ABI_LAST 11
 
 #define XSTR(s) #s
 #define STR(s) XSTR(s)
@@ -405,6 +406,7 @@ static const char help[] =
 	"but to test audit we can set " ENV_FORCE_LOG_NAME "=1\n"
 	ENV_FS_QUIET_NAME " and " ENV_NET_QUIET_NAME ", both optional, can then be used "
 	"to make access to some denied paths or network ports not trigger audit logging.\n"
+	ENV_FS_NO_INHERIT_NAME " can be used to suppress access right propagation (ABI >= 11).\n"
 	ENV_QUIET_ACCESS_NAME " can be used to specify which accesses should be quieted "
 	"(required when " ENV_FS_QUIET_NAME " or " ENV_NET_QUIET_NAME " is set):\n"
 	"  - \"all\" to quiet all of the accesses below\n"
@@ -453,6 +455,7 @@ int main(const int argc, char *const argv[], char *const *const envp)
 		.quiet_scoped = 0,
 	};
 	bool quiet_supported = true;
+	bool no_inherit_supported = true;
 	int supported_restrict_flags = LANDLOCK_RESTRICT_SELF_LOG_NEW_EXEC_ON;
 	int set_restrict_flags = 0;
 
@@ -545,6 +548,10 @@ int main(const int argc, char *const argv[], char *const *const envp)
 			  LANDLOCK_ACCESS_NET_CONNECT_SEND_UDP);
 		/* Removes quiet flags for ABI < 10 later on. */
 		quiet_supported = false;
+		__attribute__((fallthrough));
+	case 10:
+		/* Removes no_inherit flag for ABI < 11 later on. */
+		no_inherit_supported = false;
 
 		/* Must be printed for any ABI < LANDLOCK_ABI_LAST. */
 		fprintf(stderr,
@@ -649,6 +656,13 @@ int main(const int argc, char *const argv[], char *const *const envp)
 			goto err_close_ruleset;
 	}
 
+	/* Don't require this env to be present. */
+	if (no_inherit_supported && getenv(ENV_FS_NO_INHERIT_NAME)) {
+		if (populate_ruleset_fs(ENV_FS_NO_INHERIT_NAME, ruleset_fd, 0,
+					LANDLOCK_ADD_RULE_NO_INHERIT))
+			goto err_close_ruleset;
+	}
+
 	if (populate_ruleset_net(ENV_TCP_BIND_NAME, ruleset_fd,
 				 LANDLOCK_ACCESS_NET_BIND_TCP, 0)) {
 		goto err_close_ruleset;
-- 
2.54.0

