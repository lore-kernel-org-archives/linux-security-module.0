Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8D702222D5;
	Tue,  6 May 2025 17:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746551080; cv=none; b=Q/fqTnHWy7vrBA1lJT0BkfXZQBlYKzWG64BObJFKolWs9Oej1KfOGtPRKmeN7Z+BEHQb1dbWd2uXQJ7lEJ3o0ALxUJIoYZH6fi61+kKkpriX45bzFWn3SFPlhtbrTWEAP4NpKR11lvRF5tVwuglKBzSvNRQ6dPkj6qc76PtyXP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746551080; c=relaxed/simple;
	bh=NTLZprBk8WjLy0eoklCp7F0D3ryeFo+5bfQpOu4stxQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=XvFwjrGu5GGtiDL0HmVV0a6JromIDdP2oH2xgUhcCZ4u7vdhYdbKYBsBEwXJSMXZOZppLx7dCYXziD1oNNWDBpb9/Cmmb1KR3kx2U6ewKFWzbTL9cLJAXU35/JUsXuAtDGCK0GumpHrnWjoHtqUxE70DblI4crzIJrdLiPv0EPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f+hnPZj5; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f+hnPZj5"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-39efc1365e4so2866306f8f.1;
        Tue, 06 May 2025 10:04:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746551077; x=1747155877; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jQWhiv0DTzqaPZaBIOGTarBM4HQ98nU1bKdfrUKqucA=;
        b=f+hnPZj5F3xhN0XMGCLO6W+/MEXtHJ5VIJF8TLVGIABdwY+W/FDDeOUb5AJ2tjTy7i
         KuZjzlSlOEffeum+U1v2APTiIyQFcf7zmkfW5iyIpBZIWzWyAP8m7saLJrDdcEaV81/R
         aBNrm1r9i1hjFD5J+WHg5P89NVvjGYJXLSv8qAg2zPdXYr/q1Un80Pl5PofWTz9z+Noe
         et7qdp365Wz2G7VTS0iP+ILePQOthR/Jq+r3PsdQnHyD5rxyldCk2c05UiCgKwWNYe0t
         vLTXimq7EOsR6joRb+S3nMhcHjnIw66XpJRb9rvJm1o5Mksxr6Ag8zvCN4Xm03X1tqlf
         tfPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746551077; x=1747155877;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jQWhiv0DTzqaPZaBIOGTarBM4HQ98nU1bKdfrUKqucA=;
        b=E4YOQVi00EMeaIKntyY/KoSiuIWdYHPERg1H/FU83mc0xJ9lIe1QhHwU53HlJfBYWq
         cbhxvpU2LODb7/q+0djorFOKtoTKDF82/T0zTLZHcgw0ntzlaQu++KNmQE5i9xjPPDSI
         3XTGRiAOLJs6HdJSy1RjvkgpS30o0nyfKpywdxUeN3RnCZhls0ea9CqThG0wIOUADOvI
         SLQ9pfi1Lq0Q6EDtgz712tGD2YGw6IjMjQAv0htElB7C5XM7DSMeH3tEj43fvQNhYr7M
         KzqCT4nldxGfOww8utTGnE8E/YNevqe+qdqDvb742aGhx7TwsA86DxXrd6J0KE/ruP7J
         qk5g==
X-Forwarded-Encrypted: i=1; AJvYcCW4THdKnQJ2qA1vzDwG7stzLOAp8HCOusQFo5riYpYEzs3XaNY81q8tOzBa18iJnKooz6jEuT4XFWQT+sw=@vger.kernel.org, AJvYcCXPkwMYnRqfakC1ek/ZgTtcGTEleuKYXkT/Ku5ehxfslfJFHq5q/ppzvRL2HkDciXFGUXKnib6XZvKqS8vZcwwlEha859HT@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6xBgtvnDKlvgP6ELPR5JeAGAPbga18qo20RX46+eipVgK86ZM
	yZ+gfaKS0V1lO8G4WbncGGp7kXoTvn0b1+CNlC4MwfXj1p4/m9Ks
X-Gm-Gg: ASbGnctyt139KJnoNirE18DRUmYGtHQkYT870knpn3SIyCi+3TpEqrOwclq7LD0MQV9
	en7mWyu4ZiyT4Z+hPdAZ1AKuAeEQbCWyIs0tXHYStWGCuzJwQkiIMd0aRWKTA9Xy0joyXx5wOHw
	8tGGMcpzvlyrVWN3gKTxhuUk1DJjjHipHeb70qcl6shGLNCRDFUJj/kMqqON8+KAc+f7fcWl84L
	l8Gxnb3wnFEWCJ7k2YjF5L9k68eFaOhMmVWcm0tXSowXJIfoaGgN53bC+J687sqDjKhZS/T9uNF
	NvqHlINhUKUhlLzj9lleLxoTzKXePznBFM2r63jiXw==
X-Google-Smtp-Source: AGHT+IESL1kCWs4E6tOCvkozKB9xowA7eobWpZSDmFdHYxe69d+ICgCkdYKqEpcClD1YAk5OprcpxQ==
X-Received: by 2002:a05:6000:2483:b0:3a0:9705:eb13 with SMTP id ffacd0b85a97d-3a0b4a3ede3mr146964f8f.43.1746551076952;
        Tue, 06 May 2025 10:04:36 -0700 (PDT)
Received: from localhost ([194.120.133.25])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3a099ae3ccdsm14411110f8f.38.2025.05.06.10.04.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 May 2025 10:04:36 -0700 (PDT)
From: Colin Ian King <colin.i.king@gmail.com>
To: John Johansen <john.johansen@canonical.com>,
	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E . Hallyn" <serge@hallyn.com>,
	apparmor@lists.ubuntu.com,
	linux-security-module@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH][next] apparmor: Fix incorrect profile->signal range check
Date: Tue,  6 May 2025 18:04:25 +0100
Message-ID: <20250506170425.152177-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

The check on profile->signal is always false, the value can never be
less than 1 *and* greater than MAXMAPPED_SIG. Fix this by replacing
the logical operator && with ||.

Fixes: 84c455decf27 ("apparmor: add support for profiles to define the kill signal")
Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 security/apparmor/policy_unpack.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/security/apparmor/policy_unpack.c b/security/apparmor/policy_unpack.c
index 73139189df0f..e643514a3d92 100644
--- a/security/apparmor/policy_unpack.c
+++ b/security/apparmor/policy_unpack.c
@@ -919,7 +919,7 @@ static struct aa_profile *unpack_profile(struct aa_ext *e, char **ns_name)
 
 	/* optional */
 	(void) aa_unpack_u32(e, &profile->signal, "kill");
-	if (profile->signal < 1 && profile->signal > MAXMAPPED_SIG) {
+	if (profile->signal < 1 || profile->signal > MAXMAPPED_SIG) {
 		info = "profile kill.signal invalid value";
 		goto fail;
 	}
-- 
2.49.0

