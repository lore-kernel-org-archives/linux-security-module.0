Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5FFB17C91
	for <linux-security-module@vger.kernel.org>; Thu, 25 Jul 2024 05:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721886288; cv=none; b=un46TzDqIQHN0OFjovbN7rB6Ah+qEFCBCQFDXAKU5QVyv6rbZq/4/9epdF9cv1GDkPPoNCjmRjJSmlhGJb1GDOzGkr+segkC0cMJlqcl8gfei5dr3rMZxG+JYXr8zGVguaFUCsSz4/50ZruqRKZf2NoPPO5PjM8IlkvUq2AIF10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721886288; c=relaxed/simple;
	bh=rnMZufw172JYLMQqq5Nl1gT0fronYVdAub+e8XlBwmU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=MWI6f80YXITTeOm4x4zdYmuaoD2i9YRTftdqCuYMxhTWk3YbfsZX3Qshb3zaPfcFb03tG3Q8USZF4Z1Lr0fIkXRyaM97sYS2jlhlxEYD35+CeDtzvCJth+XzPJPQDmoWx1v4Bkq65/2hUNwKBX4ZWitNW7YnNrcNCFdIMFzx9wg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MpHYYIu6; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MpHYYIu6"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-70d357040dbso464582b3a.1
        for <linux-security-module@vger.kernel.org>; Wed, 24 Jul 2024 22:44:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721886286; x=1722491086; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GA4Q0PEAfW2jt86r/hAorSNxePdrjLgo3D0ZU/jn9Es=;
        b=MpHYYIu6uO1/me5u3SnS1quLh3gksBZRftevnnRSwS6jR3upmp1p5+p5tLskj61/bp
         dBBXD2G+coMY/Mp24KfSiFtdxujbPq90TSiWgXUD0ZIYajIxQVtYVz/eXI/tAZ++hvVP
         y1lHdX2lzn1toAyyW1ixh+PYF/Er2oIU+ndJJtcLk0FUdkx2Cz29/LQlKnKCFOSDnWgT
         DiDYqyHv1noRTNl7vdMuCjVvqFSxs/UXb4nYNau3tEO5z2bx8eWCUVUAqgZj5MLxn9LA
         VMjp+pQF8vL9zxADJ4OC7b/EvfopQ9M3SefmEi9KoOz8x2IgwCGi7HQAU9r4UJjjGvSn
         mgjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721886286; x=1722491086;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GA4Q0PEAfW2jt86r/hAorSNxePdrjLgo3D0ZU/jn9Es=;
        b=wlC61vJ54E9fC6sYO9a7kN7Ke4VD/f9tASBWbQb1UQxEugoI2SoZ3qez+HUyko6goA
         O4Sni7sZ/Xg1j6SZvLqxAjWT9WJoip7R9ZhBulUR79hXVkdHXm2ihPbFiz4XWUu15ccT
         jl84sL28qqiAAeNP6JHWD8sIpKD/HZG3WFzJN+wYoycwmwlQI2t/L0bEKclodj3WJhO+
         BhjXW6YEcZAuJNFdFX1lz11r6xzDx6hUmhN41+/Prcw1p2brs1V61F577Jymh/oSdQOh
         sK7fIa1xRFyY3jnlPTI8dBuOhtG0BhY5M6GYZ1Osf72LMzWE8eek/MmNC0ULQfJEff5/
         /gHw==
X-Gm-Message-State: AOJu0YzS+T9+lvT4CzytIVkg70xhZ8L2gmu9nKO87x9f7ChUV+P60usE
	o8afrVsMMO+ISEW7fze3ZboQSpw6/laW70fO3927AnBcThhpj+NJ
X-Google-Smtp-Source: AGHT+IFr6rjW2cPduNWAbaqO1ie+Y121oaa/a1oFRj7tT4BAyHzWpnVilfXZPVuCAPW4TfYKqrNclA==
X-Received: by 2002:a05:6a20:3954:b0:1be:cea:d381 with SMTP id adf61e73a8af0-1c472aa4b6fmr2649099637.18.1721886285684;
        Wed, 24 Jul 2024 22:44:45 -0700 (PDT)
Received: from localhost.localdomain ([39.144.45.37])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fed7ef4490sm5280895ad.179.2024.07.24.22.44.41
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Jul 2024 22:44:45 -0700 (PDT)
From: Yafang Shao <laoar.shao@gmail.com>
To: takedakn@nttdata.co.jp,
	penguin-kernel@I-love.SAKURA.ne.jp
Cc: linux-security-module@vger.kernel.org,
	Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH] security/tomoyo: Prevent message flooding if no Tomoyo loader is present
Date: Thu, 25 Jul 2024 13:42:16 +0800
Message-Id: <20240725054216.18587-1-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

After upgrading our OS to Rocky Linux 9, we've noticed an abundance of
Tomoyo-related messages in the dmesg output, specifically indicating that
Mandatory Access Control is not being activated due to the absence of
/sbin/tomoyo-init. These messages repeatedly appear as systemd periodically
checks for Tomoyo, but since the loader does not exist, it triggers the
messages, as follows,

[2362655.988555] Not activating Mandatory Access Control as /sbin/tomoyo-init does not exist.
[2362956.054826] Not activating Mandatory Access Control as /sbin/tomoyo-init does not exist.
[2363256.123963] Not activating Mandatory Access Control as /sbin/tomoyo-init does not exist.
[2363556.176985] Not activating Mandatory Access Control as /sbin/tomoyo-init does not exist.
[2363856.239882] Not activating Mandatory Access Control as /sbin/tomoyo-init does not exist.
[2364041.613547] Not activating Mandatory Access Control as /sbin/tomoyo-init does not exist.
[2364155.298170] Not activating Mandatory Access Control as /sbin/tomoyo-init does not exist.
[2364455.361375] Not activating Mandatory Access Control as /sbin/tomoyo-init does not exist.
[2364755.411385] Not activating Mandatory Access Control as /sbin/tomoyo-init does not exist.
[2364816.253043] Not activating Mandatory Access Control as /sbin/tomoyo-init does not exist.

The tomoyo configs in our kernel config are as follows,

  CONFIG_SECURITY_TOMOYO=y
  CONFIG_SECURITY_TOMOYO_MAX_ACCEPT_ENTRY=2048
  CONFIG_SECURITY_TOMOYO_MAX_AUDIT_LOG=1024
  # CONFIG_SECURITY_TOMOYO_OMIT_USERSPACE_LOADER is not set
  CONFIG_SECURITY_TOMOYO_POLICY_LOADER="/sbin/tomoyo-init"
  CONFIG_SECURITY_TOMOYO_ACTIVATION_TRIGGER="/usr/lib/systemd/systemd"
  # CONFIG_SECURITY_TOMOYO_INSECURE_BUILTIN_SETTING is not set

While disabling Tomoyo is a straightforward solution to prevent the message
flooding, it's suboptimal as we're unsure if any system components rely on
its functionality. A more elegant approach would be to modify the logging
mechanism to use pr_info_once() instead of the default one, which would
reduce the number of redundant messages without compromising the
functionality of the system. This change would ensure that the necessary
information is logged once, preventing the dmesg from being cluttered
with repetitive messages.

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
---
 security/tomoyo/load_policy.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/security/tomoyo/load_policy.c b/security/tomoyo/load_policy.c
index 363b65be87ab..4e64b5678abf 100644
--- a/security/tomoyo/load_policy.c
+++ b/security/tomoyo/load_policy.c
@@ -41,8 +41,8 @@ static bool tomoyo_policy_loader_exists(void)
 	if (!tomoyo_loader)
 		tomoyo_loader = CONFIG_SECURITY_TOMOYO_POLICY_LOADER;
 	if (kern_path(tomoyo_loader, LOOKUP_FOLLOW, &path)) {
-		pr_info("Not activating Mandatory Access Control as %s does not exist.\n",
-			tomoyo_loader);
+		pr_info_once("Not activating Mandatory Access Control as %s does not exist.\n",
+			     tomoyo_loader);
 		return false;
 	}
 	path_put(&path);
-- 
2.43.5

