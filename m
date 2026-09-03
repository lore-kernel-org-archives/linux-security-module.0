Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8967A4E8DF2
	for <linux-security-module@vger.kernel.org>; Thu,  3 Sep 2026 15:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788450983; cv=none; b=eCdKIZ0Up7A/CCHDxwVyZZGyMcWEroSLJkP1XMsHfNGXSD6UA4YNZf9PBDJnQ7bDJK6nmZfb94qnRAGQUdwqAIEf9juGRyW7IHU/ExvxCTEU94K4xP3AghMz3D2GHakcGSg8cgsug92Gct0jZnI/OHFUj21u+44GPYXAW/Wp7XI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788450983; c=relaxed/simple;
	bh=9BK1kyxk5Z0/CaDbriSQ++DzrreFQG+kLaclcVYwGN0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=o9ESAQRDew+HdO/0ZsbyTvBkov2EonTT/y/5/k4C7e+7Wio+h6aYTiTT7LsWImmUsG6iHxCTQxcw7JcnLROIbFTDA++LFhonILw91H8+b8TNr3Gy0V2vTy1a/uL3pXrCSI5s6Yn9YGnL/XeHYsBroQ+KTb2nPRJPF61N2dQRo4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=btkRkqlf; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="btkRkqlf"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-49a97714f5dso404875e9.0
        for <linux-security-module@vger.kernel.org>; Thu, 03 Sep 2026 08:56:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788450979; x=1789055779; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Qf5A2iWXrze7f/WQGCmLESIXScEzdMF2bet/pRtY3Is=;
        b=btkRkqlfotTbaNJJyaxS4LwL7rBuN8VRekBWvzMifhXVTv7st8iBwhg2et4/seMKtS
         5kuo1D/4VmvPntokf67cJPDTL4LNAz+SGUysGEw3s5N98UdMU1ZtwhVAvhi+ugahidtT
         jfSwJQ7pt+GVLsXUHRvvPtjmuMziLsx0F1yEEAC8PWrg/W1mpyacXoyLgZGqnQVA273r
         n2i5GatRaL7j9G+lbpjzzjimD0AMbaXAu3o3KhOAfahyW52IJHcUxKg0SCr+TeVFtSYl
         LGlpsCEQRtO0rJ3q7SZbTqvR4ugigRDWDeGnU0OgmVdqIfW8u//Ii3evKOY6AJACEg0S
         DACw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788450979; x=1789055779;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Qf5A2iWXrze7f/WQGCmLESIXScEzdMF2bet/pRtY3Is=;
        b=GgZcROBIAAjZK+LVoqbrqTnnuVkpdLBmogw5jbuNZl3m29p74I2OAtavv3tWopFBih
         l1cJE5PlCeO1wR9Bzli3E9grTkGAaOSFimVjOuH3Pvcslw+AQ1cVqiCuBJ5qOBIXcgym
         ZZdHDLqD3pV+h027PtVSZx2qusGmB5Oo+PmqgvCePiyqRIQ0copT4cs6gX5qMqAN1kNk
         oGgy2o87qUQoBxsbSrT4RHtwTJkOLdKVgrtxUFkRqULp+S1aOOISQAzUSm71YDccxNBO
         gwb+/Ft+eSPmGpmSN/YnE+Rx7FBr5V8g70u6McGWNFj9atXbiV239ydNb8Rj7pAlq2TU
         XILg==
X-Forwarded-Encrypted: i=1; AKwUvByTjDKMkwjoi8osRCPSW4esImOzSjbvR+FYUVnun1evO6NF8PQkd2YgnY3FFPYD/oV2J5R86HKwbQGkgjR80msv19VmnHI=@vger.kernel.org
X-Gm-Message-State: AFuF++nlwO889wP5ETeDombYbZJ3jlHpB555mnIxPb6VUjAqrdW4tC/e
	kVCAGcMtb5e3u3K8wQZuhBNWqLJFm7mKS9iTuJtIwebQUtq8UvFIAGjm
X-Gm-Gg: AYBFou2X4kYRlfU//zEGncqN7sjqRbFjN6vl6UjRP00cLbz9t0/GUihmo1P6kuK8OUB
	HNWo6tzuP0mLc1/AIFjlOqy54127ye/Uxj+yb77/ZiuOm/j/YzVxGzW7QX+/W4zAetbmrUSjiuM
	Z/UjSnZCBFjdK0JPWHSKjc2RcWRzuRB8i5FXtKVIYqIwWsLwcTHTsxVW/eJJUreXZDD+CU+M5FO
	poSQrjV3fo2Y9NTgpocTw19VpI1p9x9PMjWGDQNXuEBYSay8r8L09dsTgEK8t+zAgWuVfvwSrLJ
	1VlOigFV0JYUI62xJ5cVxWHx0olEEIJEQS3DXv6Mbv6RqamWZI7NLLVrwAUI4/XABwVwKUhKpzT
	HOW+5Q5mzzHtFeqok//qcK18rEixyXt+h1HQm2XF80A0F2R3+bWuYq14zSaderrntLnB5e85Oe9
	9b0I5Ex0WzS+dS74UvUL43Z7o2gDUYq/35QJAqpRkQ2+UMz7DcYNqKvUsF2noz8QPmrEQibwPbc
	tFXdB7m+gKyhb0g9dFxYCp9shNhb9gofOB5pg==
X-Received: by 2002:a05:600c:354b:b0:49b:d03:8d3a with SMTP id 5b1f17b1804b1-49ce58180bbmr220232615e9.11.1788450978626;
        Thu, 03 Sep 2026 08:56:18 -0700 (PDT)
Received: from omos-acer (109-81-21-204.rct.o2.cz. [109.81.21.204])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49cee6024a8sm80527185e9.6.2026.09.03.08.56.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2026 08:56:17 -0700 (PDT)
From: =?UTF-8?q?Ondrej=20Mosn=C3=A1=C4=8Dek?= <omosnacek@gmail.com>
To: Paul Moore <paul@paul-moore.com>
Cc: selinux@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] =?UTF-8?q?MAINTAINERS,=20mailmap:=20update=20email=20addr?= =?UTF-8?q?ess=20for=20Ondrej=20Mosn=C3=A1=C4=8Dek?=
Date: Thu,  3 Sep 2026 17:56:15 +0200
Message-ID: <20260903155615.516010-1-omosnacek@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

I'm going to use my personal email for kernel contributions from now on.
Update MAINTAINERS and .mailmap to reflect this.

Also switch to use proper spelling with diacritics, since I normally use
the full Unicode name with my personal email address. I'm leaving
in-code occurences unchanged though, as that would be just unnecessary
churn.

Link: https://lore.kernel.org/lkml/CAFqZXNvOGbzy8-ZnJtKi94jfu2H173Tz7VYpK8KuseMQS-9tNA@mail.gmail.com/
Signed-off-by: Ondrej Mosnáček <omosnacek@gmail.com>
---

Hoping for this to get picked up via the SELinux tree, since the main
change is in the SELinux MAINTAINERS entry.

 .mailmap    | 1 +
 MAINTAINERS | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/.mailmap b/.mailmap
index 6803f3bd2865..0e672a60afdc 100644
--- a/.mailmap
+++ b/.mailmap
@@ -699,6 +699,7 @@ Oliver Hartkopp <socketcan@hartkopp.net> <oliver.hartkopp@volkswagen.de>
 Oliver Hartkopp <socketcan@hartkopp.net> <oliver@hartkopp.net>
 Oliver Upton <oupton@kernel.org> <oupton@google.com>
 Oliver Upton <oupton@kernel.org> <oliver.upton@linux.dev>
+Ondrej Mosnáček <omosnacek@gmail.com> <omosnace@redhat.com>
 Ondřej Jirman <megi@xff.cz> <megous@megous.com>
 Oza Pawandeep <quic_poza@quicinc.com> <poza@codeaurora.org>
 Pali Rohár <pali@kernel.org> <pali.rohar@gmail.com>
diff --git a/MAINTAINERS b/MAINTAINERS
index fc320b373656..875d0baed8b9 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -24772,7 +24772,7 @@ K:	\bsecurity_[a-z_0-9]\+\b
 SELINUX SECURITY MODULE
 M:	Paul Moore <paul@paul-moore.com>
 M:	Stephen Smalley <stephen.smalley.work@gmail.com>
-R:	Ondrej Mosnacek <omosnace@redhat.com>
+R:	Ondrej Mosnáček <omosnacek@gmail.com>
 L:	selinux@vger.kernel.org
 S:	Supported
 W:	https://github.com/SELinuxProject
-- 
2.54.0

