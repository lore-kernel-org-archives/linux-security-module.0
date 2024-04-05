Received: from mail-ed1-f74.google.com (mail-ed1-f74.google.com [209.85.208.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06863176FB4
	for <linux-security-module@vger.kernel.org>; Fri,  5 Apr 2024 21:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712353296; cv=none; b=JGVYCF9RXZ4Eu3Uf6eqv1cYMTWEmshk2c+UEzhjq4jXNXl8gxSU12Ad1/b3VBPMX4bUT5B29oS0abIfcC2Luhwx2Bn7LW63hQe+whXa2giTwi6PZONTXsv0xdN8njuPDkIGM+lR68luFdcrfWx3nTb/syEC7WfE9sYImahplmr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712353296; c=relaxed/simple;
	bh=eerKUwOAJdG4l07tn4UJJFXLatw+oUupMvi98+9SFSM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=tLyAlk+cMs0yJAb1E0XB/1SgZ89VKmVZCuOVcSBfT0xNryn94bWSo5EljkVORH4earKCjdY2JKFzD71skAVerkS4k6fp/cyE8IjZmuYm9ys/RjXEjWZUg1VMvV8fD1oipeifPlBnTOTgCTUagNpmKqfFXHrFa5btBJ9Xn6jgTRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--gnoack.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QuG+Qxfc; arc=none smtp.client-ip=209.85.208.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--gnoack.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QuG+Qxfc"
Received: by mail-ed1-f74.google.com with SMTP id 4fb4d7f45d1cf-5684345c0ebso4011873a12.1
        for <linux-security-module@vger.kernel.org>; Fri, 05 Apr 2024 14:41:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712353293; x=1712958093; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gfT1cU34Qatifm1LZ7TB36yHQ1WB+M5CqgNm/urbeDk=;
        b=QuG+Qxfci83vAdzMxx/+kBFIL+Cr2P3RV0bzClVXwzBc6s1+saBfAy9vreGy+ViMnO
         o5CO41z4t+M4pjNSREpJYQGLtsHi1+oMbAT91mMJ0ZHvFY1UIm/wXf6xArvrY/68W/Al
         UlpKCkCEpFWxNmmSEFZvtWosRCB1hSatZ/Kaqma6e36Ni7QRf4Mkbi8G3VRNGoiEgX/V
         NzrVAFK+8Yuz7F11T0ZxHK/gGQPCJSJXx4JJKUftUHp3F48kO8l3XD7rwZPEj9hufNQa
         GAshZdvJwROFId9ql6t6w3zH7423y9zcp8p7n4Gh+VLaOc7gau9P0XjM26K3e3a3zoUL
         Ddyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712353293; x=1712958093;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=gfT1cU34Qatifm1LZ7TB36yHQ1WB+M5CqgNm/urbeDk=;
        b=nYcvDz+ysVpomR7Ah+zu4cWxhltYaNeJrfj6XjDT9ik7pP4p2M/SPNrEdQ8kS203i9
         zxKBJwG9MU+vMaLdO37emRAqAw4HKh+Xqt5MGooSbbBKnd2WKUS+kmy0rHkwOee5VY0E
         nJ9o28myp6k7IiUpsiB5BOxo87hDB7NGFyycb6OjX+ZXLNQxdAUC3beTKHz7Li7cX+Ut
         0NHkgv2yMtIi73msgADhRgonvlOnaTw0jYyb0+PNbP91jM9lklI88WhmS67yfcndJe04
         D/Q4evTQPJNupYken1trwbToX3DLZb4F8ZBVDmXnZr94UxExwztflqyCWUBvJXrtNrUM
         /z0w==
X-Gm-Message-State: AOJu0Yz+SL7UPSojbu6uEqFkpuvk6bEt2l+at5sYzbRaaOLC2BC3FoqD
	9sq10922aYu4d37EvHiVbMr08+CDQ2FkVKodUKZLxoaPksSO5Pw3Qe6wpADC4EKsWretCAX1/tI
	Yf0b4/++PQ77keL1xn57J+WcpeJGVpU9rzcgibC40gZN5IIzVrBp2ULHUA0qkY659vjKPyEuoMu
	hAXBnQEdtX64ugfac9P/IbDNv3wQZzDHHFImkpc4vS417TwlJvRYlY
X-Google-Smtp-Source: AGHT+IEAdLuUBypZI8eUpc+P8XMt48vwGgNa6irD0KxC4ZtesgZXcC4GYp2ABm0GpsyFPJv/hcaNj/eaHIw=
X-Received: from swim.c.googlers.com ([fda3:e722:ac3:cc00:31:98fb:c0a8:1605])
 (user=gnoack job=sendgmr) by 2002:a05:6402:2696:b0:56c:2c3f:9c82 with SMTP id
 w22-20020a056402269600b0056c2c3f9c82mr8485edd.1.1712353293398; Fri, 05 Apr
 2024 14:41:33 -0700 (PDT)
Date: Fri,  5 Apr 2024 21:40:39 +0000
In-Reply-To: <20240405214040.101396-1-gnoack@google.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240405214040.101396-1-gnoack@google.com>
X-Mailer: git-send-email 2.44.0.478.gd926399ef9-goog
Message-ID: <20240405214040.101396-12-gnoack@google.com>
Subject: [PATCH v14 11/12] MAINTAINERS: Notify Landlock maintainers about
 changes to fs/ioctl.c
From: "=?UTF-8?q?G=C3=BCnther=20Noack?=" <gnoack@google.com>
To: linux-security-module@vger.kernel.org, 
	"=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?=" <mic@digikod.net>
Cc: Jeff Xu <jeffxu@google.com>, Arnd Bergmann <arnd@arndb.de>, 
	Jorge Lucangeli Obes <jorgelo@chromium.org>, Allen Webb <allenwebb@google.com>, 
	Dmitry Torokhov <dtor@google.com>, Paul Moore <paul@paul-moore.com>, 
	Konstantin Meskhidze <konstantin.meskhidze@huawei.com>, Matt Bobrowski <repnop@google.com>, 
	linux-fsdevel@vger.kernel.org, 
	"=?UTF-8?q?G=C3=BCnther=20Noack?=" <gnoack@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Landlock needs to track changes to do_vfs_ioctl() when new IOCTL
implementations are added to it.

Suggested-by: Micka=C3=ABl Sala=C3=BCn <mic@digikod.net>
Signed-off-by: G=C3=BCnther Noack <gnoack@google.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index aa3b947fb080..c95dabf4ecc9 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -12222,6 +12222,7 @@ W:	https://landlock.io
 T:	git https://git.kernel.org/pub/scm/linux/kernel/git/mic/linux.git
 F:	Documentation/security/landlock.rst
 F:	Documentation/userspace-api/landlock.rst
+F:	fs/ioctl.c
 F:	include/uapi/linux/landlock.h
 F:	samples/landlock/
 F:	security/landlock/
--=20
2.44.0.478.gd926399ef9-goog

