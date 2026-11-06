Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.231.136
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793991343;
	b=1EE3a6yW8X4coMZGab+76EIx9hSDBXLNKe+WM6K4rj3izt2xVOCdmj4E9eLxvbzhn4YO
	 B4VD63EQ8lYddxqJhhuwulaPj1Eu0HnBEY1SePwTGMU2A4ikZZvjxcQtV9v6Rhj+6dpqx
	 BfDJ+mfJdmuS5IhpDQ3pL6idB+aL1k7dzRHfhvRSdXl5m29+Y/cr35zmFiPxrF/soGTaM
	 mctS+VHvB0w4RqKoFzh0ZxoHRh7JEnPLRwo3lW0IHZm/0gB7UNm0xT06DcHmtofKMIyIY
	 g4hueVJDNNc40Jo8DHl8ioqEEfxugV65Ms9d1HbQVZkjxUH/gVS/lrPZo9RGOCnt4Uw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793991343;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=ZGyxnJnZbbXGMPkgOS5KrZfDWbz6ljrwSXVVr6mtPoc=;
	b=IjeYtg8XbBTWAPYnDvW0BByU8rhXxmkwNrArn4VIeQUTnSG0+/Xf2hPfqmxq67LbawrN
	 XP9IfXDGby4xzOhvx2QAU2N4Kr7+M/lr9yTRIqTyfaVa1H233KU7Ti8nK+rA1iNFDhmOk
	 CWk1wWhc9oKBZ+7rQ5jr9bUdgjRQn0KElRIjYGmtRprPEN7Gd2v/LLN6Par836reKJPYk
	 5kb2EF37RFkyBfwd1p60WaYQfa6jlj1pOxQtiW/if2Vndd2iCRDjqAmDedhrwPYk/SY5o
	 jJj6reEBFbv+gA9WUHAsBra2OOW0iH+R1hOkGTzIfjBgr88zhQdjRTN8r0canexfecQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=O64ZZ8O4;
	arc=none smtp.remote-ip=74.125.231.136
Received: from mail-oo2-f8.google.com (mail-oo2-f8.google.com [74.125.231.136])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37F86606A326
	for <linux-security-module@vger.kernel.org>; Fri,  6 Nov 2026 18:55:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 37F86606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=O64ZZ8O4
Received: by mail-oo2-f8.google.com with SMTP id 46e09a7af769-843c8bbfbc4so424626a34.1
        for <linux-security-module@vger.kernel.org>; Fri, 06 Nov 2026 10:55:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793991342; x=1794596142; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ZGyxnJnZbbXGMPkgOS5KrZfDWbz6ljrwSXVVr6mtPoc=;
        b=O64ZZ8O4Otw3jQgY45uKa3s7MDVMBUfVYcPhZ0dL85m++Y0nU1g2lW5fpiMjaCul0l
         SeKRwKGkTwguv59Rjil8siP4CjPFaWgDeN217uY0bE7ZfqG3KF0p/e9TiYdja2PjsybD
         nggmuNsFpbjXpdot4sLXJ6Qd1D1gSon74JuxLtcx0e+hpsx+c2/CFEqHp9ZWkZ82Iso4
         uWwv1yEwR5S9GKxA5XlfjzJWj5Uhhs2kRmGBHZ9ojPs7DfYcpn7JRmATCBL/SDt6Y5mO
         94lqsgPIpDRe/DONK5J6RyWZUC+ikfnGzo9aFEuB/Nya8u/Qp6OoUbnApbcknwZMEyhv
         ZrOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793991342; x=1794596142;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ZGyxnJnZbbXGMPkgOS5KrZfDWbz6ljrwSXVVr6mtPoc=;
        b=OYUoA2oKIiuwRyvtlyqM29ys8iWpQ/kdI7ywHNeaxF4thLHW8vNvG6MdU+96rv76/Y
         ymWPXWddZMX0VUc+HxviFgaP9776mg0YJ+mLBh3ZCxCts9Ix/6UqFDbR2/aBA9Kb+vNB
         jjQWhLkRsW34t48miN2JUAsBRhgZyJRb2xPK20Y6pxSTpa0/cVUHULJgxeX84u6iHgT2
         GcULSZ7qXADeJLDmPG9qM/TU+KrdDD37P+qPpdAN9+BlOGQUT1gVOdfD962D20xj9jDO
         utlKx8i41e2cW34vWtzYceGntrfqWWCc+8Cr+Y6o4TRZOB4C8kpcqiytKCFp7sbpB4NN
         9jHQ==
X-Forwarded-Encrypted: i=1; AKwUvBzFHJXANYkGsp8nAYgEwm8x3nK4i3lyHJh84uVQAHyi/U5fFEUKP/9yqWsfNJShjmifRdC8Cu+1id57uinCZysZ4CxI36Y=@vger.kernel.org
X-Gm-Message-State: APuU4Z9ZbrU87ZCN4EN2gNBQFkLlD5XyCJuuCcn+fsIyq7Wt7apu/YH3
	pC4Lokj6llIdQKyRWyvWqQXXrxBEbKLAKq6TJkYAvPNtnrZVGkW2gBpx
X-Gm-Gg: AYBFou3o4l+nByIYPrwrGa+dxwVjGNw8+gvFXXPWliW+UlzPqYrwbKDNdwM5w4lhoLt
	2plyOtYR6NPZcTJk81Is/y2kzgBKJsi/6PDZFV6Ocnrjwqo4uyQdtkCaptwUciPJojGyHS2d7QK
	eWixZphHPlbYNQPPWJxdbjAoXbsMvxdgoja5dx73jd0N23i31rKVF8S3O6vGHnVfkhVb//+rxtR
	IKmNbjYkr4NMLmC4sQLwkebeg+5xj6TRWIKgHO4AzeVN1cdIae2hJB4e919PiU1TSRuoXg6qhMR
	1WGgrhGAP5k+quTk8QhqvIwkws2aDIVDF7fiWUu9ZXgK8yBAA5qcviosRElrgfOJmrQpKbS/VSA
	eWAKEA12audbCBzWr4tTXpD8dGY1alcNPTnTg6BDaDvjqqdCmk1Tug/wXBOBlM+rK0n6pNDbmYp
	q5PqzUAvU9G2hE9VVfX4Rp9WZNkklyLqnLoridDyco3y6Mg/OQqly0uTkEMDgWjTNrSxFzw9L1x
	1iTPeu6yw4/4jufIBR1czJsqPwJU5kYSLFcJ0VAPf2Hxwduu7lcORTtT/KvoKlNKtpZJQpSPfdO
	BPNN0RBDNIxHC8VogtMkNf3JrYmwZz8M73NWz9FrEqfJoiOt/MZQPNwBw6KztGZOLUuG
X-Received: by 2002:a05:6808:10d3:b0:4f3:36ff:e521 with SMTP id 5614622812f47-567e13f9a5dmr2809962b6e.58.1793991342161;
        Fri, 06 Nov 2026 10:55:42 -0800 (PST)
Received: from localhost.localdomain ([14.116.239.41])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-567e7e70338sm2162164b6e.12.2026.11.06.10.55.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 10:55:40 -0800 (PST)
From: Henry Martin <bsdhenrymartin@gmail.com>
To: john.johansen@canonical.com,
	georgia.garcia@canonical.com,
	paul@paul-moore.com,
	jmorris@namei.org,
	serge@hallyn.com
Cc: apparmor@lists.ubuntu.com,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Henry Martin <bsdhenrymartin@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] apparmor: fix out-of-bounds read in unix socket address audit
Date: Sat,  7 Nov 2026 02:55:32 +0800
Message-ID: <20261106185532.3338123-1-bsdhenrymartin@gmail.com>
X-Mailer: git-send-email 2.43.7
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

audit_unix_addr() logs pathname unix addresses with
audit_log_untrustedstring(), which sizes the string with strlen().
The sockaddr passed to the LSM hook is not NUL-terminated:
__sys_bind() copies only addrlen bytes from userspace into an
on-stack buffer and leaves the tail uninitialized. A pathname
address without a NUL byte within addrlen makes strlen() run past
the stack object, and adjacent kernel stack contents end up in the
audit record. E.g. on mainline (05441d697f7f, KASAN build):

    BUG: KASAN: stack-out-of-bounds in strlen+0x93/0xa0
    Read of size 1 at addr ffffc9000287fe98 by task poc/1004
    CPU: 3 UID: 1000 PID: 1004 Comm: poc
    Call Trace:
     strlen+0x93/0xa0
     audit_log_untrustedstring+0x19/0x30
     audit_net_cb+0x3cb/0x760
     aa_check_perms+0x19d/0x340
     aa_unix_bind_perm+0x73a/0xb60
     security_socket_bind+0x2c/0x60
     __sys_bind+0x103/0x200

Bound the string by the address length with strnlen(), matching
the abstract-address branch.

This issue was discovered by Tencent CodeBuddy Security.

Cc: stable@vger.kernel.org
Fixes: c05e705812d1 ("apparmor: add fine grained af_unix mediation")
Signed-off-by: Henry Martin <bsdhenrymartin@gmail.com>
---
 security/apparmor/net.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/security/apparmor/net.c b/security/apparmor/net.c
index 136d14226b97d..cc8dcc5bd619c 100644
--- a/security/apparmor/net.c
+++ b/security/apparmor/net.c
@@ -86,7 +86,8 @@ static void audit_unix_addr(struct audit_buffer *ab, const char *str,
 		audit_log_format(ab, " %s=none", str);
 	} else if (addr->sun_path[0]) {
 		audit_log_format(ab, " %s=", str);
-		audit_log_untrustedstring(ab, addr->sun_path);
+		audit_log_n_untrustedstring(ab, addr->sun_path,
+					    strnlen(addr->sun_path, len));
 	} else {
 		audit_log_format(ab, " %s=\"@", str);
 		if (audit_string_contains_control(&addr->sun_path[1], len - 1))
-- 
2.43.7

