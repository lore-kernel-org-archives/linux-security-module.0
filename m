Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.152
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794871910;
	b=l/Wc2CpJFC96hpp4+K6zqD+T3yAUL5CWxDJ1qqUASxc61b3I1e5s0NhxBVms4u9x8AYw
	 YGpL82WilcvCGXvbO40NZEHN3D6CCdmwH6NzBIVUyiOgOPSDBana9/l3N70G6QrdD4Poh
	 FM9zjLGgwPl8gb9bJQJ8hAepsfjVUJiS2gaPa6g/J6sCl+YuQZQCccyMPSyac4eXvvF96
	 KohOGYT0+bnqt24GmdQfxw4OeffMLco0yHWWc05JuEw3Q899jDdfjmytjfZdv7rOnZrgJ
	 41S+t/Ur8Nc+K7Mbzvj72tCV05vNY1fZ+Sy10gYhAWTK5elJj3L2TSoVONKFF3/AITQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794871910;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=pU9WiPQLH50z4VT34yaFgr0xvmSmbxdFv9e2byyOafU=;
	b=nXcWeABca8G+/jQKyg04F7TumAD/zUtUaKS/vlhn3CMfF48mg+w8bLAWYMPsQ9QFlN8G
	 ++tCB4xxQpAo1geUmQlf1zMEJ133BEQxGAMEVs7vxkmXJcrxvtO49hq2r4SVFhROz7RiJ
	 PK83j/BNHCKrZO6E4VLBOJAAWJ0qccqdTcBd2zkfslxU4lvXMKAowSWyQyhzOw550egxd
	 fTfm8stg+WtYT+Y4uwOW3fnbuVWdaLDzdc5Ef2GJoP56xYcg0JiOZREDwaTDaQqmRJNVO
	 TdjIrbAvO/uVZx1AA+FHHoLQu7/TkLcBHJP6OEQ6jkr92dF6zpKS31JP59dMunrqXHg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=maowtm.org;
	spf=pass smtp.mailfrom=maowtm.org;
	dkim=pass header.d=maowtm.org header.i=@maowtm.org header.a=rsa-sha256 header.s=fm3 header.b=cQ2sQuG3;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=nEsx9+OS;
	arc=none smtp.remote-ip=202.12.124.152
Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CCFF606A31C
	for <linux-security-module@vger.kernel.org>; Mon, 16 Nov 2026 23:31:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2CCFF606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=maowtm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=maowtm.org header.i=@maowtm.org header.a=rsa-sha256 header.s=fm3 header.b=cQ2sQuG3;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=nEsx9+OS
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 4AB727A0038
	for <linux-security-module@vger.kernel.org>; Mon, 16 Nov 2026 18:31:49 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Mon, 16 Nov 2026 18:31:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maowtm.org; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to; s=fm3; t=1794871908; x=1794958308; bh=pU9WiPQLH50z4VT34yaFg
	r0xvmSmbxdFv9e2byyOafU=; b=cQ2sQuG3UxGRItxwzVxbSnsidJZOGk0W0iEKU
	C0D3jaPazzgpCA3ZtKDsM5l3Nsk8xlRetYdZxhTV+pYQbqNUUdCNS1B/eShEfd7l
	Ng39ojy5xdqFXNne39rgUpXJlu8gX2NGVWlXc9pqw1ahreOEE0ZrLsoq53l+2AI0
	JVSnW+ZfDay+3LNs4aSx5yiDK4yJh0HTUgrhoFr1hdcKVaKCYjANNI95HHp/3dR0
	uIKax7ol+g02bd4rCFipg5xoK3N/iPm1Ok50XCDxEzczI3Wmz0oJdB5uk0+NVhF0
	lzFjgjzqzOos8erCltCgUbbi7Zj0mzMNIInNpnY68w3yhkLfg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1794871908; x=1794958308; bh=pU9WiPQLH50z4VT34yaFgr0xvmSmbxdFv9e
	2byyOafU=; b=nEsx9+OSnX96kQixHaFghv+i7TlAGjU77x58NpgIaSllRIfCMVt
	TV8Bj4iMNHbDky7GmlULPIYVQHkfaY/7uFPXQEbWmmxKj6LXh2d2gXXDPbZiZVUO
	qpy7q3miw1VX2pADqKK8aBMRke6UHkLczvPGiFYdShIXBZb79A9p80KOw1XbAuMd
	0nv2YtcwEtDU+lyt2H3q76unDswDDphvvMXlw1MoR5T3APbN4KrnWuoXHgG1jVYj
	StKsTz6ix06KkLGNsM40q8t1DQw27om145t8ug+o2vAuH5M0P7VwmCgJW9hxQ6h/
	wzCmqf+xnblTSdc0yXdwc6aUt9McYoxulQg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=maowtm.org a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794871908; d=maowtm.org;
	mf=PG1AbWFvd3RtLm9yZz4=;
	rt=PGxpbnV4LXNlY3VyaXR5LW1vZHVsZUB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm3:rsa-sha256:gxGaw9GaGg9HHM3LAXD7+vv+6kX/mKdCnHyrqL9JL031qmy
	zDb2qm+OualZ1zBCEQcBEvK5jZ+8jKGuoS0hg0Y57zurN9IJwuwcGgSP4jGaP7++
	0x8JWNSbtLjZS+761dXsRL1/Qq9tulJRHquNIBhO87Jw0SUvArFrN0mUUO1TnS/a
	Gwc+KqU6qSqoKxESMAnro8AWG9fWqCkjHoqOdsCOtzGfI2yWbPLj8dNh1/yFEuds
	bedMZ0/WlcrHKbQev+4YrR5Kic63TySmWL5s4IleZZkfiCjmE1m8OmUZv7HSu6Ug
	+qSnfHPhWIBeechP5Oaw+u2JQGg4JfgDllXjJUg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=9;
	hn=cc,content-transfer-encoding,date,feedback-id,from,
	message-id,mime-version,subject,to;
Message-Instance: m=1; h=sha256:30UrvD7ubAD+cSKIJNEgQ9g6pbyqdtQ3b0xXDMP/+i0=:4lm7SJItf2be195yJOpElXn1RjZ1I+E/nC7QPzViESo=;
X-ME-Sender: <xms:ZJL7ale3V83itGH61oSpsRliz3BAyW-czqONAujFwQD25LaQG_U-3g>
    <xme:ZJL7aqP6cxZHi630yt47f8MAn1SgaJ9hGvRXz7lUsNnk_Qz6aLaPAHjNgng3FqVi5
    4GjLh-u4AUYNO67g5K0uJEXvM9PkUW6T3TMiIJyfxKa2VegtZdwqA>
X-ME-Received: <xmr:ZJL7ajg3vph2a1gFeUwJ7d_7IyRvewf3K-xk6UaIIg37UGsJ8lPIKtXgO-DnyaQHz1sPqrR1-nPOXEdeCFGmAVI0xfX--9UulIW4JbJXvzunOFFkR-br>
X-ME-Proxy-Cause: dmFkZTE2XJrw+C7uxtZt69k83G8xDNAokmBKJwrkzQVsMj4v2XEHaNQhDrCfImAJgrKYEg
    OucqQaVJiz81M8UBW6EM3KRn7SRROyh+iambx44XBW+XEYjJk08cjxJAOpf4u5mI2so7ZM
    FJKa8STe2/8QM6PCFVJKMD+R1+FndYiVEcTem4HMgeaMw8fr5yaiF0r7xVLybcrs4342bU
    Ov4dM6S/ezqalul2CCFtjSfjHkz3Vs4i+Lx10Iq2MpYfOZVBNbmQvXZ+6VdQwyhwGRO2jC
    oeeg/nxaaIfxMTo2IS9tlgvSz5tKUuoFcXZm0Um9nk4m20Pli78wso4FWOCweqXWzcvfGL
    HML3OwZOwmrE7p8FHYQrCLJBda4C7P6x3QIbbKjNgwSO31qMc4eiHrzjEXKvItWz3IjBL0
    pJ/aMSJaB2ayAe9zmvCgZ4i5akBhWGrNDI5T+4uRb6n4/OMv7rX8pQp0Ns/uRk0/Ks0ocL
    +E1Ca1rIfd6yaFTpZF43sTjnlSLZ9BI/NhCqv7U+idJdK7QiExUvOgxX4kwILKosrfHgQN
    lv0SZXbdKWF0kamCq3VN8JyKh5ie95L2NTMfUG7vWn/rg2gpvQp6VjaWPh2hjAe+WnSqbQ
    A8SGqVjHoalf293uIHU7ljLI4+PDGLNTXFAoCAkqMzZHit1Rsb9gXbuGlVEw
X-ME-Proxy: <xmx:ZJL7at3gWT_Dir5jlSLgxQne6JDagBGMk2-eSVK5LypskA8CNDqGaw>
    <xmx:ZJL7atiBSFiml-7Eplt5snMwQKFXrDBbFj_6OgvtnsvYk0uHf24LGQ>
    <xmx:ZJL7atemPQ1HXZc0E8l5W_HOEZu3n6782h20ZaznV8_IrSkoc3T4Vg>
    <xmx:ZJL7aglHRM905r2uZc_L_pPmQF_Y005QTFc-NLUtd1K1Y1Y3Juxbow>
    <xmx:ZJL7arTjpGH54_HthJF-aMozsyy_2cd5eOF7q7hUFu6QQjYdTR4YfniF>
Feedback-ID: i580e4893:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 16 Nov 2026 18:31:47 -0500 (EST)
From: Tingmao Wang <m@maowtm.org>
To: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
Cc: Tingmao Wang <m@maowtm.org>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack3000@gmail.com>,
	linux-security-module@vger.kernel.org
Subject: [PATCH] landlock: Add missing EINVAL case in the doc for landlock_add_rule
Date: Mon, 16 Nov 2026 23:31:37 +0000
Message-ID: <20261116233139.206924-1-m@maowtm.org>
X-Mailer: git-send-email 2.56.1
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is another way it can return EINVAL but is not documented.  Documenting
it is useful to help rule out errors.

Signed-off-by: Tingmao Wang <m@maowtm.org>
---
 security/landlock/syscalls.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/security/landlock/syscalls.c b/security/landlock/syscalls.c
index fb5af318b69b..29e9d5d7399d 100644
--- a/security/landlock/syscalls.c
+++ b/security/landlock/syscalls.c
@@ -629,6 +629,7 @@ static int add_rule_capability(struct landlock_ruleset *const ruleset,
  * - %EAFNOSUPPORT: @rule_type is %LANDLOCK_RULE_NET_PORT but TCP/IP is not
  *   supported by the running kernel;
  * - %EINVAL: @flags is not valid;
+ * - %EINVAL: @rule_type is not valid;
  * - %EINVAL: The rule accesses are inconsistent (i.e.
  *   &landlock_path_beneath_attr.allowed_access or
  *   &landlock_net_port_attr.allowed_access is not a subset of the ruleset

base-commit: 57493c3b7f449a60d1c43322158671b98684f9b1
-- 
2.56.1

