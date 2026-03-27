Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C79F435F18C
	for <linux-security-module@vger.kernel.org>; Fri, 27 Mar 2026 16:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774630152; cv=none; b=K5aeE6jDcoZVNXZfay73WhmJlz+zMg/i9Fpcl8Xoa/lJxQz7r37UhwZh3o4bN69cH8KBGZNM0BeFpruR19iLmzL9bNyexldYM9rcvqGmSMKCQXd8MJeUhmJke6Fzwfjs2yqsfEIbUL/CO62qPxE77moThoKCCAVMI2UaFxF4OJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774630152; c=relaxed/simple;
	bh=OhXXG2xIldVvbJF1GHdQoasLmdqqVTz3GR7wBlfcQIE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kZsawKRsVJNsB9IC5/fDWrvQpMhkEbXWJIebw42XwFZs392J1nKrCgYNhli99e0xbs1T8Yixtfau4/WU+JEVI6wQX5lfpqR+7/CTRrdPizPsWlA1a5ADrh/N092iveR/AyU4iRc9vchGcinq3DUfb4vrDqgbNspJdfWICOFBf5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PYj+U1JE; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PYj+U1JE"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-43b8e8e7432so1894940f8f.1
        for <linux-security-module@vger.kernel.org>; Fri, 27 Mar 2026 09:49:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774630149; x=1775234949; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rJshHyAlu0Amwsqvbh39fSwfWMmGLorddxfy+zZs6KE=;
        b=PYj+U1JExWdBw7HZC6dyeJPJEKTTN6+tIcW02fcS5cei6CJfFF6mbnyp5d2TlgLaqz
         K1ycIul3JchXUrdRbymjJMZse7VN+h1Kn4fKDsJgYSAhcRdoikI5zkbulWRJ17J2DrlI
         7d2qYfON7OZx6vNzg8ndUq/tHr4+R2gJH2T9vl49sGk/sGOXxfIH9jmZFyS0M1lpsbjI
         4coIe40lL3LXnmrXSXDkBExfua3Sy9ULO15E2GI1dICPmo1fJREBLMJLqHFRGX/3l3Tp
         8O0BPT8AQrn+czDpVSEkhh0J4ZcrCXACV3QL3LGBJX1XN+3Uyo73Vx14TGo2PVJzj6Rv
         3BsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774630149; x=1775234949;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=rJshHyAlu0Amwsqvbh39fSwfWMmGLorddxfy+zZs6KE=;
        b=VaAOuPy7clgHJ9CdTvb8Ie0PTVzLjeC/DTuzQJAmAEuAIWmER6Uv8tX5ZPirtkkHmJ
         1YvCBBwWVdbhnky4lYKJf6LeK3LVb56/zS1Meuq93RNKmy+ryPIw2xXGlw7bXr+MAxL8
         FCK24r0FkZN88hDKLG3SaXzj3mvHtsNYqytjes16V7vlu6JhJtPD6V+50x4pripqFM9r
         bkz/tGwQwlOOxoHT0qG/iu9fU8WNOY0K+Qcg9QckY/czydAQ2HzpI0dzlfk6hTbPXXNm
         gsX2RrLhvxGHbaD9R4YtA4rcYFnzEgqQwNa9CbW+kQ3IBWkLaBUgDDuTzya3mxjusIo+
         tYsw==
X-Forwarded-Encrypted: i=1; AJvYcCXrpkl3z/8BCopd7pm/FNPPQfsWhUaC1TVji/KL3JJF6YcTwFRp9AbZfmqaHkeTF74OJTqs4PnkqxviXNjd43R1JOeaDHw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyPsEnjwZFIHiYE1Wvc3e9isnUrSwp3LivX/u0mD/WKJ6jzShIs
	//klItPc55oOmbvy4l3Ct6VQ3RVCYxJoMKndh0lIEhIxP0nw2Ap2ceh6
X-Gm-Gg: ATEYQzyFRxCLcCr7x4AcDOrPghGLq8CVVFcvFF8cVN0EuX1RJpeu3g8ife6f+ULmpe4
	wi9PLOwClzrHs3+Izl6RhZmVjPQCLZtVCoaNJ08ZWNIDedTIm149cuvgpFVf83HAvMlY1aghZXq
	zVvsORg/4ythUklFXxJaALR6r+oH2ADZ8tmYn7hfloatXLcLNropz8jZtnwshu6MAVsDA38d6zm
	lPa9twRnrTvhlBpWqHYc84cBLfo98nTLzNoKDDi/yWUes2qZMQ4+cXolB5qAQ3dYdIriym6pE75
	P9FNCDcyuANbxVUhCpPxPKEwiQ8P3qpBjpBlYpTNVimlb6NTgP38pDY/gJEhBYcSp7YnqbguWjj
	4jKUIbW4SPZiqBJgLKOUuGtdge/yqcPdUEKJ5Yvabkk22mpv0jmMTeoapt/3BMo3sPP8wFbBJpz
	+uRkk4ELpDBwXy/U+4/fi2rx77SzMsBRLgeSERokq/3kx0Dokn
X-Received: by 2002:a05:6000:430a:b0:43b:5022:804 with SMTP id ffacd0b85a97d-43b9e9ee7a9mr5395217f8f.29.1774630148746;
        Fri, 27 Mar 2026 09:49:08 -0700 (PDT)
Received: from localhost (ip87-106-108-193.pbiaas.com. [87.106.108.193])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b91943184sm14466301f8f.14.2026.03.27.09.49.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Mar 2026 09:49:08 -0700 (PDT)
From: =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack3000@gmail.com>
To: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	"John Johansen" <john.johansen@canonical.com>
Cc: =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack3000@gmail.com>,
	linux-security-module@vger.kernel.org,
	"Tingmao Wang" <m@maowtm.org>,
	"Justin Suess" <utilityemal77@gmail.com>,
	"Samasth Norway Ananda" <samasth.norway.ananda@oracle.com>,
	"Matthieu Buffet" <matthieu@buffet.re>,
	"Mikhail Ivanov" <ivanov.mikhail1@huawei-partners.com>,
	konstantin.meskhidze@huawei.com,
	"Demi Marie Obenour" <demiobenour@gmail.com>,
	"Alyssa Ross" <hi@alyssa.is>,
	"Jann Horn" <jannh@google.com>,
	"Tahera Fahimi" <fahimitahera@gmail.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	"Kuniyuki Iwashima" <kuniyu@google.com>,
	"Georgia Garcia" <georgia.garcia@canonical.com>
Subject: [PATCH v8 02/12] landlock: Use mem_is_zero() in is_layer_masks_allowed()
Date: Fri, 27 Mar 2026 17:48:27 +0100
Message-ID: <20260327164838.38231-3-gnoack3000@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260327164838.38231-1-gnoack3000@gmail.com>
References: <20260327164838.38231-1-gnoack3000@gmail.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This is equivalent, but expresses the intent a bit clearer.

Signed-off-by: Günther Noack <gnoack3000@gmail.com>
---
 security/landlock/fs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/security/landlock/fs.c b/security/landlock/fs.c
index a03ec664c78e..97065d51685a 100644
--- a/security/landlock/fs.c
+++ b/security/landlock/fs.c
@@ -564,7 +564,7 @@ static void test_no_more_access(struct kunit *const test)
 
 static bool is_layer_masks_allowed(const struct layer_access_masks *masks)
 {
-	return !memchr_inv(&masks->access, 0, sizeof(masks->access));
+	return mem_is_zero(&masks->access, sizeof(masks->access));
 }
 
 /*
-- 
2.53.0

