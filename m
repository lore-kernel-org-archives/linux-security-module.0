Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 630202ECD32
	for <linux-security-module@vger.kernel.org>; Sun, 30 Aug 2026 20:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788121025; cv=none; b=CV//jFsPt3Mwf458/1ih6WQo73dOc5qY1DM5CzBrNZ1i36p96zfXOT1qE3jDrD9T4DQSgRzAys0Meo0XrQ0GAdnl7fEnGTMqzCqHy9AmdoxbqZ6PgGIpT6SAHBHPy5qqNOZyZb8UoezNSdfkuEQ8gAdDZXiOe2LIlMYVsC3M8jA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788121025; c=relaxed/simple;
	bh=e1JVroCpy0yxR3TLrzWrxJUaIa9LSvQI5OwiRs8w1Q8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YtZhIy4VMyCzRXLC9PKHSxy1g1cIrik7Pc+Mnhz+P/64aKQAypK5/LON/m8AcIDuk09fsRfHl5g79JDnmdZ4EWunuegDAre90M79qfP7YW4DHNARsW9vwE9tqz742Qw0PPKwgPdG00yXn5Dohe9perg47VnKgMRW9HIV/1ivW38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Bi7Tswx2; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bi7Tswx2"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-482e61a34e5so907113f8f.3
        for <linux-security-module@vger.kernel.org>; Sun, 30 Aug 2026 13:17:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788121022; x=1788725822; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=xRwk2mxThRhdae+9PHJjX8tprSZn9ioaIXoGdJjtfRc=;
        b=Bi7Tswx2iRL3kWhvq05zRpVft+pem7uoRNqq7koRkuCoJFNUegGcgZxdI2prFGpwA1
         /NFWSBFTEhPaZv7S21YCBUkX71p/msmUcfQBBN8bjmYKgHZzcLZJ1HrVU2/o1lT5bBZU
         ZwOr62Y03cFccXb7d65Sd9y/ti7jVU5+9c8/FGFdvtIqw+ZiW1O4DlvfqJBBgQMaqZgu
         PRPbKuhFGrZHjUJv+SPVUf5c76E7Ro2hN5GlLCy8J1/FQ1HNLe7z6LjITQy3RkipPkuE
         oXKtsJd545dmvfANV1GbZrze6/XPCfOYuPocT454aFH9UFN7m6bbYUM3C71md+RWN1Jn
         7ZuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788121022; x=1788725822;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xRwk2mxThRhdae+9PHJjX8tprSZn9ioaIXoGdJjtfRc=;
        b=k8laJVX3NIFFI4ej+/A0iYrSOxnXUSzzw95HYX+z+ppADidIamxDf5tNmPcEncLgA7
         LImI+rmz8gZhu9eZDY6q7xieRSqdkyuwh7MNaojgxktTFhRSZPWlXRDVveXI3wX/L0Cm
         pqX0bgLcek1cnv2X8nlovQYHpn0HMXQ8QUl/Fzkqdx/c0nAohpGFH+G4BYztUbog5vXN
         ipaoJ/i+082rCEm1CDkEegc/ijmejnnmEtbh2v1qOO8Tqk2TjMPLFEEUDf9sPVLsYpJr
         Y0Yspsj9lkro5XK6ixB6cRAZ6th/TSKCHkjMImzFo2+/rim1SjXUiGQeWeDOC0k7e/fG
         sJwg==
X-Forwarded-Encrypted: i=1; AHgh+RqAVaT/ElxMBdHy71VWWIp1UvtG3awl66IRx/DyKCZ7q9Wu+mPNcHJy6HzyaHjeqkCo3de9V+r3m05yvGRN1gIczFsv1qU=@vger.kernel.org
X-Gm-Message-State: AFuF++ly04kLxuz6YvWHFpq8gpjOYVODik6seCFxod2tECwuRXgfKcOS
	nYwtOu4rh/cdmO3Q0G23D5CGDF3RwZYSiO1S0Mdtz4IAdQXJgakW0wfz
X-Gm-Gg: AR+sD10VmtQtyMfbmIMcHD3N2N8ZKk5NkjwPktHL5b2+27sCSiWUEVXV1gksukIIqzv
	3GIsVBBaJ2b9iLZQfqVDFr0CRTaN2KM15JxGL7JJ/0R22S8S4KdUxp5wBum5mt3ELJamZyITj5g
	vHPuOyAvJU8JYPvkZ1jhVNDKkyque8eL3+TmbfxCVnf5eU28bnsiXlmbSF3d4pockFVyvchCbzS
	l/+758UEVmmg4cfk4SC+X1Vei2wrLd4R25zBSnThbrhc10MvyObUmW0didgM/pRL/KOYVKMIvkt
	BQ11YqiDhlNtR8VfPxQi5YN8p5txTtTiVJsuyckxOhp1PStHFIBn7rVQlbHeMfCLjm1mX6F2p1w
	A+IEstQof4mw9/pO6c6JDfd+VBJHuH34qUoJTAHFkB2yirvc2a2Lw4VHNeo9MOV+MZ09W57J9/a
	vTjgF4e8GZrjOKKeElvKdlmeAcqAzrOodfQBTETBuej/kgUyghAAxIj6+1pPFOwm+C9Nkn79pIr
	80jXadhlInSTw==
X-Received: by 2002:a05:600c:6215:b0:499:5a50:b022 with SMTP id 5b1f17b1804b1-49b91c1bb18mr334176195e9.3.1788121022190;
        Sun, 30 Aug 2026 13:17:02 -0700 (PDT)
Received: from localhost (ip87-106-108-193.pbiaas.com. [87.106.108.193])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49b91c5790csm193360025e9.0.2026.08.30.13.17.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Aug 2026 13:17:01 -0700 (PDT)
From: =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack3000@gmail.com>
To: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
Cc: Matthieu Baerts <matttbe@kernel.org>,
	Mat Martineau <martineau@kernel.org>,
	Geliang Tang <geliang@kernel.org>,
	Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>,
	mptcp@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack3000@gmail.com>
Subject: [PATCH 1/6] samples/landlock: Implement best-effort fallback for network rules.
Date: Sun, 30 Aug 2026 22:16:45 +0200
Message-ID: <20260830201650.67050-2-gnoack3000@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260830201650.67050-1-gnoack3000@gmail.com>
References: <20260830201650.67050-1-gnoack3000@gmail.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The sandboxer sample tool added network rules unconditionally, even on
systems that only support lower Landlock ABI versions, resulting in
errors.

This change implements the correct best-effort fallback: As on older
Landlock ABI versions, the given operation is not restrictable, is
also does not need to be allow-listed.

Signed-off-by: Günther Noack <gnoack3000@gmail.com>
---
 samples/landlock/sandboxer.c | 20 ++++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

diff --git a/samples/landlock/sandboxer.c b/samples/landlock/sandboxer.c
index 030583273f3f..1c514efecafb 100644
--- a/samples/landlock/sandboxer.c
+++ b/samples/landlock/sandboxer.c
@@ -198,6 +198,10 @@ static int populate_ruleset_net(const char *const env_var, const int ruleset_fd,
 		.allowed_access = allowed_access,
 	};
 
+	/* A rule without access rights and flags is a no-op. */
+	if (!allowed_access && !flags)
+		return 0;
+
 	env_port_name = getenv(env_var);
 	if (!env_port_name)
 		return 0;
@@ -657,19 +661,27 @@ int main(const int argc, char *const argv[], char *const *const envp)
 	}
 
 	if (populate_ruleset_net(ENV_TCP_BIND_NAME, ruleset_fd,
-				 LANDLOCK_ACCESS_NET_BIND_TCP, 0)) {
+				 ruleset_attr.handled_access_net &
+					 LANDLOCK_ACCESS_NET_BIND_TCP,
+				 0)) {
 		goto err_close_ruleset;
 	}
 	if (populate_ruleset_net(ENV_TCP_CONNECT_NAME, ruleset_fd,
-				 LANDLOCK_ACCESS_NET_CONNECT_TCP, 0)) {
+				 ruleset_attr.handled_access_net &
+					 LANDLOCK_ACCESS_NET_CONNECT_TCP,
+				 0)) {
 		goto err_close_ruleset;
 	}
 	if (populate_ruleset_net(ENV_UDP_BIND_NAME, ruleset_fd,
-				 LANDLOCK_ACCESS_NET_BIND_UDP, 0)) {
+				 ruleset_attr.handled_access_net &
+					 LANDLOCK_ACCESS_NET_BIND_UDP,
+				 0)) {
 		goto err_close_ruleset;
 	}
 	if (populate_ruleset_net(ENV_UDP_CONNECT_SEND_NAME, ruleset_fd,
-				 LANDLOCK_ACCESS_NET_CONNECT_SEND_UDP, 0)) {
+				 ruleset_attr.handled_access_net &
+					 LANDLOCK_ACCESS_NET_CONNECT_SEND_UDP,
+				 0)) {
 		goto err_close_ruleset;
 	}
 
-- 
2.55.0

