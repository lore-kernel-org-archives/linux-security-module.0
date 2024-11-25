Received: from server02.seltendoof.de (server02.seltendoof.de [168.119.48.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD355192B7F;
	Mon, 25 Nov 2024 10:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.48.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732532374; cv=none; b=ZrXX42DK3O1wgas3qwok5Ed2sls3i1EriM30gMaRvWIEWPtf0ZSlsKewrjLo2qfK71b4ekf1lErVS4RdSc0gq7xZZH6CrX0y6fcnjGJ0qUccgFYXqIRErDF9rJNE1PMRIai1u1+hGBHdu51SGpJyidNufpQs7OSWVKSFngvmXoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732532374; c=relaxed/simple;
	bh=GHS/SEzX4n4lOOmfdbeh+O3yKhBWSQkgZFU5DwY6NuE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FLLO7EFiDywahPrDxEqov86qiL8xqLgA25poTq0Yuuj2hGbLClEtqtqhHh1956FHTLqTYOQ6RB+Mv99BBamBvDE9byCDwgP7lbP9qknDTTed2I9N4ZrADAYCIhUGIzga1rvuEXKDe0UMFPExkRnxHGzyADcmw/zArmJB2W5t4S8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de; spf=pass smtp.mailfrom=seltendoof.de; dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b=dRKsxhNV; arc=none smtp.client-ip=168.119.48.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b="dRKsxhNV"
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1732532371;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nkyprKAwDQMKqKiqTw5jnahGqPM9yDb/oFOya9sneAI=;
	b=dRKsxhNVdxme8dJtfyhu1h1ogCJmeUhR9he/Uql+oqIjMVUD78SfSVWPlwemKtk4Tq6M0g
	WnriIsTytTGRwsygYYm9odz0uQRi1JbVPB5O/cSlSQxQGQJGHfB0LdUXKvnCFTrTEtodj2
	WN4DI+GP7tWTlYdVP9OwDQ+gP3qXb/mywiLKryP9qgmgwtlDfzPQA5L7/Gck+X7XP9XGlL
	oe24CAAkJbuzf7/i6ifVWUp+md6uJ16KO5kPj9hFcXArxS1h5ba9JYD9tKUHqA1u1StATP
	o6P0yIArBszG4c/rLlM/4phSKiZsaXmr9imst7zh9rUQ5yQ9klOwQXaAVRf5WQ==
To: 
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>,
	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev
Subject: [PATCH 1/2] lsm: constify function parameters
Date: Mon, 25 Nov 2024 11:59:24 +0100
Message-ID: <20241125105926.47141-2-cgoettsche@seltendoof.de>
In-Reply-To: <20241125105926.47141-1-cgoettsche@seltendoof.de>
References: <20241125105926.47141-1-cgoettsche@seltendoof.de>
Reply-To: cgzones@googlemail.com
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Christian Göttsche <cgzones@googlemail.com>

The functions print_ipv4_addr() and print_ipv6_addr() are called with
string literals and do not modify these parameters internally.

Reported by clang:

    security/lsm_audit.c:324:7: warning: passing 'const char[6]' to parameter of type 'char *' discards qualifiers [-Wincompatible-pointer-types-discards-qualifiers]
      324 |                                                 "laddr", "lport");
          |                                                 ^~~~~~~
    security/lsm_audit.c:183:27: note: passing argument to parameter 'name1' here
      183 |                                    __be16 port, char *name1, char *name2)
          |                                                       ^

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 security/lsm_audit.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/security/lsm_audit.c b/security/lsm_audit.c
index 849e832719e2..f1fe99f2221d 100644
--- a/security/lsm_audit.c
+++ b/security/lsm_audit.c
@@ -171,7 +171,7 @@ int ipv6_skb_to_auditdata(struct sk_buff *skb,
 
 static inline void print_ipv6_addr(struct audit_buffer *ab,
 				   const struct in6_addr *addr, __be16 port,
-				   char *name1, char *name2)
+				   const char *name1, const char *name2)
 {
 	if (!ipv6_addr_any(addr))
 		audit_log_format(ab, " %s=%pI6c", name1, addr);
@@ -180,7 +180,7 @@ static inline void print_ipv6_addr(struct audit_buffer *ab,
 }
 
 static inline void print_ipv4_addr(struct audit_buffer *ab, __be32 addr,
-				   __be16 port, char *name1, char *name2)
+				   __be16 port, const char *name1, const char *name2)
 {
 	if (addr)
 		audit_log_format(ab, " %s=%pI4", name1, &addr);
-- 
2.45.2

