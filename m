Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65B553C5DD9
	for <linux-security-module@vger.kernel.org>; Mon, 23 Mar 2026 16:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774285093; cv=none; b=jAMjeoEr8xpNEYaquR8qQy60mlOaoYjLmLSD0z6IiAaHnp4TDaZA5gtBKf1iYk9/mq+y4QXPVQuEtRBd6U4x4kmjR2dhEtYTJahzJG+oXbJ7ibPsSsyY5lgfrNTdRRi1Y8pozNX7HWdf/vAqHMOyCKA3ts4b3gy4tQq/sZPOIpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774285093; c=relaxed/simple;
	bh=OhXXG2xIldVvbJF1GHdQoasLmdqqVTz3GR7wBlfcQIE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sS7HGNAnui0Vl7OStX7He3EariHQxD5eajwt38PplV2ZYSbp2cmiJ0gWDucB8FQufLRkMMUDVXxOZHBryAggyIqQ0v4rI1btjuFaR2zenOGUvwgdxJsUaoxK4FCoOJn77HttxKsV/4XLOP0oW+ev34u2Hb9jZFeeuODgNJ3mH68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jD14BhHO; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jD14BhHO"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-43b40003d13so2724389f8f.2
        for <linux-security-module@vger.kernel.org>; Mon, 23 Mar 2026 09:58:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774285091; x=1774889891; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rJshHyAlu0Amwsqvbh39fSwfWMmGLorddxfy+zZs6KE=;
        b=jD14BhHOZpD1xIc+SU03POzSTSIh2Ju9hQr3S9MQv1BWRGNnazDLhB7KvvhywizP6R
         bEeTCASklRwoVqKdQfAQAD84BLqtP1CDqUh7C7fnmI3Szv137nzfnr/EtRwZonZ2odsz
         wXMpu6WlXGR4K3xWpWPKwlZBqGk2OG6wdSCmlcGLyBtG1zkNqVYfhN7Agu1wJmpbSjcx
         x7QcO0jC365WeYOhWm1tnT2LzGsH+qAH9XY3UA/fKcCZiRITmsY2zWr78NFyUIUoPbZQ
         IT8nwAGMTEC7k0OlP6bwEXaAHklsH2iZdBRokF5cagChZOPueVxbpSMjuh4nJwA07sA2
         GYsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774285091; x=1774889891;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=rJshHyAlu0Amwsqvbh39fSwfWMmGLorddxfy+zZs6KE=;
        b=QdOE7JBNsVtuTEcvYWOR9+VcJ93E8+Wox8yXXf8VlUtaE+J3PpauMDYSOPR0S8eQuY
         CWzUruKP/vl4lIeRroqXm+2krp3lvJg7VqwUfAEpiOX/FXlDrWkzDsKyL9ssVXCEGJ5x
         CGMoIWn3SSGXAHgeuIBvrZQVjxWxIda5GGOOB9ovbFcfYa0UPDT8Wua2vOtKnzFLeDU+
         La8MGzuHExmeuNt0AP3F1Exi6k/F555om6r/Z4Ojsctrop0Lcf0GE4mwKqoFwDu93Bsy
         1jMobifnbFnATGuYRk1aj3fqFHHxkECtnaUPp940BegxxzyP+Yxq/GHG/3+ERNKMx/V/
         MB5g==
X-Forwarded-Encrypted: i=1; AJvYcCWRJngqCXf9LotV0FRHfIcHke/BwQKHbB4bMPUcl8/AnMJZ7Wkr17PqK+lA5+YJ6KUEoHIpBTP0wDBxEhBJ/7RlHRLPuJc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwgLRsg422j81CGRZ6Gj4iEVJCVr1vhrXVCjiXByY4TJ9GGqraa
	lW1CGgKJZkYPIQS6VklwyGX73Dul4uxRAmVQauOF/7o8hdGlhtsf2Vnv
X-Gm-Gg: ATEYQzxbQB/Uu+UnpD2qB3ExhXMD73gNxpJRA/rGMUSpYMTDN/uFeOgiStPULOoiJ5E
	vPITTDXtqFO/Q561emJVcsOJKhNi3ZpWSs7DA2/Pk8vUNYky2yg5CRQeNcrBsuD9RqVbUnyW6el
	pTFgghrgTDgI2osOM/DnIHw6UqrpixQVKr/Pr7RtJLQhTGKV4E8doQVTWP+RI/Qf4gxxqND/wRh
	tzsc+QilgXVoNwcsLSnNxQTO0eJoUfCledbK0U+KI/R5X+wgT1kKHyoSpDJbBvVQH7Z/atJyL6l
	Y4xjQC4Ooa8Hea9OQvCHZev6lQDiaMePLA60GMueut8YoshusMGBEyjeqsYJHG9LhctiAfunYwk
	eREKjYVc20B4imt+febKp8lyTWzEwiz48KRJ4cDdMnzbWoFO1x9ffZc4HERQytLoYk3w/gklm0x
	yr/+w7XDl5SBx6Xw0VXCVsnBzQ0thXAf19ynZPkApGjClRFEvMJTEM7he85NI=
X-Received: by 2002:a5d:5f86:0:b0:439:936b:bff4 with SMTP id ffacd0b85a97d-43b642824c1mr21080130f8f.46.1774285090669;
        Mon, 23 Mar 2026 09:58:10 -0700 (PDT)
Received: from localhost (ip87-106-108-193.pbiaas.com. [87.106.108.193])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b647036e0sm31301857f8f.21.2026.03.23.09.58.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2026 09:58:10 -0700 (PDT)
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
	"Kuniyuki Iwashima" <kuniyu@google.com>
Subject: [PATCH v7 02/11] landlock: Use mem_is_zero() in is_layer_masks_allowed()
Date: Mon, 23 Mar 2026 17:56:44 +0100
Message-ID: <20260323165654.193957-3-gnoack3000@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260323165654.193957-1-gnoack3000@gmail.com>
References: <20260323165654.193957-1-gnoack3000@gmail.com>
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

