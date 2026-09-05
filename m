Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E84243B777C
	for <linux-security-module@vger.kernel.org>; Sat,  5 Sep 2026 12:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788611699; cv=none; b=ProuQmnE1+uuaJwXrkI3jUvKXWs06SI8rUckDoaLcXm+HoNhhB/1+ee5bLMnr1gVZbSbrct7QVEN0R8ZA/ynnxGa1dEIkmNJUXNewFdy/M/fgDyQKkWgDMQ0nYxjIuDhkIo2f8kFhZuH+gtdNUbiuOoHzFOmSzsYziXRtdSYMh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788611699; c=relaxed/simple;
	bh=6f5p//qeeEhJiLT6hla2lNz47zEGEWS2WmSvXXHcHig=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=g9VYI+22dT0lyQ7N5/YVjeWqWtgZ/i8o8EUW/PfR+A+nyVefz32dGwUqW/g7r+IHBPUQ5HZrQ+FqW1T2r/6uvPgX/qnR1mrLieu6G63pDtrX9Ploo9CHq/PjMAj8SY/o9bFuJ6rxUDoqTjCensA0uIO9j3r/U5VROS0bNzPZLBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YtbnSs8q; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YtbnSs8q"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-382ef647e20so1981374a91.1
        for <linux-security-module@vger.kernel.org>; Sat, 05 Sep 2026 05:34:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788611696; x=1789216496; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=sCkeW/rlDEZbQRwhNQlqYVSLXnulFlxF+aDVtk4kLrI=;
        b=YtbnSs8qfPdzgH+oeRaodn+q8Vb2tox19c9H6lxT0EFKc+LY1/TEPedO12k3EV0weq
         ZubHW2aMvu5d9wRdvZ2JZKz7OYJGt9lSYnONx4iIPgTgklB3Zi9nQUeDscBHQNI2nipN
         8PAydIGehlYBeD+FYQjwg6pUJGFz8Zv+UkkQ3/NrLop+gj8ozrTjmwWo2IbPI+M0RoI2
         BN+5/uzNIMcpl8wO3T4RqLVBYURIS6zQbCgT+MIiipkpQV3o9deat8Ivesk3Ege7KHGV
         agTdBI1D8e/AHP9rHdTaJMom7wYS+xvDGlXRUX3Io89bY3cqjDkY4ewjOrVt3ANdSDC6
         BPIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788611696; x=1789216496;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=sCkeW/rlDEZbQRwhNQlqYVSLXnulFlxF+aDVtk4kLrI=;
        b=asUU36PkXjh5ssfXCSXIuDuDjY57a1QlJa98RNIwREuKa2FWexFMHiJCxcKklmndS7
         Ms0dmFf3WjfWD6Hr0L+zglXnKWfyNyah0RXiYTmSN+Nv2GwlK7R7ajYq28o1wicaF8+G
         yXNjJcKpJ/9OHs8w/nylNkR2nWzLDt/TaAzX9xmkM7cPK9NB4UXugtj2No2Rm5RqEzmh
         U4qpDivYwsUineGWz/M5XWy6scnixNMYD4gNQRI4u+QH0w04AekyKx/t3yHcWjWcWBiW
         xk/5Qr6e5R5cw2D9W/cpUs7gBWUnZKZLYsTzktlRkcAPAvlNdrX720SlsTQ5lTf8h5T1
         DYbQ==
X-Forwarded-Encrypted: i=1; AKwUvBxITWNEcDz8yUM4EgiZXGJcWSupcIYVnJ4GGqWmy1/IQOuCrhBEy8IlQ/q7prIlcESXMEOMJ8n9kchpdP2v6pvNWOoaBpk=@vger.kernel.org
X-Gm-Message-State: AFuF++kl8H2fO+fQaQIU7PCI12yHut4Ss1SKLEcvjtqY2ftiq8A9aUWe
	PUqFBTYil1f/RWFL1FkouAleBANVfKXNN9J4moELcl8EwnGVnks4UUonSLBV/yga9DU=
X-Gm-Gg: AYBFou0agF9nmfyH9rrWhcCecw59mRq55ZsKnc1YbRkJm0TGn+2mJeeQPocv4nK8Ro+
	MpXa8MnUKp7PT89JUgHurmqZZMN1h0cuPYZNr+EsPuUBKKWOk1kyHk8U3C017oB7Ig60hc/77Zr
	jCMCRYj3XQs8oomzDl0PpX4LcYvgUUHF27EjhsKluivF3FTdCC+5aqpxSaG5W92HKHoagfEVrN6
	k58lpFnHx/VbSfV12NoKTJLIeIm54c3heFrLP6gy9LKXffIbhig1zNqoNgeaNx+a2VUi/skGgQw
	ZF5g44u05MvZFzWKifJyIUVafB2kK7WAgW/jReIcEj/qjXxEH193Fs+aQD5s29Tq+x77wX4FKR8
	36FruoNqc+MmzFU/GEUCwvGhkfmLYwsOJ6hfWwu4uWamWTH2XbNkKQvkCBVFHju4gBuCzXhyiYm
	JE52/Wt9DSa1/amPSiQd8LgwchIlcO06etJWkK1UXkb00VQw5+hYKDRgbhFA+JFsXucPsy4Pl0K
	e8wo67wYvr7lryUHZFkEc+2VbVZjYWN
X-Received: by 2002:a17:90b:5905:b0:398:9bd5:490b with SMTP id 98e67ed59e1d1-39b262133ccmr17366120a91.18.1788611696373;
        Sat, 05 Sep 2026 05:34:56 -0700 (PDT)
Received: from Biostar-A520MT.. ([187.94.13.245])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3339bdf26c5sm13829815eec.27.2026.09.05.05.34.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Sep 2026 05:34:55 -0700 (PDT)
From: Breno Rodrigues Alves <breno3011alves@gmail.com>
To: gregkh@linuxfoundation.org
Cc: torvalds@linux-foundation.org,
	linux-kernel@vger.kernel.org,
	arnd@arndb.de,
	linux-clk@vger.kernel.org,
	linux-input@vger.kernel.org,
	linux-media@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-usb@vger.kernel.org,
	linux-sound@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-fbdev@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	Breno Rodrigues Alves <breno3011alves@gmail.com>
Subject: [PATCH v6 1/4] interconnect: mediatek: fix Makefile typo for mt8196
Date: Sat,  5 Sep 2026 09:34:47 -0300
Message-ID: <20260905123450.5620-1-breno3011alves@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Correct a copy-paste typo in the MediaTek interconnect Makefile that
mapped mt8196.o to CONFIG_INTERCONNECT_MTK_MT8195 instead of MT8196.

Assisted-by: OpenCode AI
Signed-off-by: Breno Rodrigues Alves <breno3011alves@gmail.com>
---
 drivers/interconnect/mediatek/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/interconnect/mediatek/Makefile b/drivers/interconnect/mediatek/Makefile
index 6bd656668..64170ab16 100644
--- a/drivers/interconnect/mediatek/Makefile
+++ b/drivers/interconnect/mediatek/Makefile
@@ -3,4 +3,4 @@
 obj-$(CONFIG_INTERCONNECT_MTK_DVFSRC_EMI) += icc-emi.o
 obj-$(CONFIG_INTERCONNECT_MTK_MT8183) += mt8183.o
 obj-$(CONFIG_INTERCONNECT_MTK_MT8195) += mt8195.o
-obj-$(CONFIG_INTERCONNECT_MTK_MT8195) += mt8196.o
+obj-$(CONFIG_INTERCONNECT_MTK_MT8196) += mt8196.o
-- 
2.43.0

