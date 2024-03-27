Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BB81156F59
	for <linux-security-module@vger.kernel.org>; Wed, 27 Mar 2024 13:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711545069; cv=none; b=hKgtpD7X80lA7IeNsI0diQAczsmeIQqAqQXThzMUGuwymzm6SchkROoK4r66tL11YkP/bzVtyLhJqbR7Xm5hFMHtlGLM6BErAuC/583h945X6KOaVE7IBTRIQD724OrpNhVxDp9+6tSEtzqH/S9FfLQU3QunPtmSkeJHZYvBv14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711545069; c=relaxed/simple;
	bh=y+r+QiYljJ8LyQPSz6ila4q3cE0VvWJjqVMPhAkSt5o=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ObwZumxQpd+chKimMUi+hIaDBmcWId34JuyGYVjrpxYu7ln7pJ92XwTMCIsdSNEqXdKv6X9qtYqw1EhVhRAxHVLq+NlGY09aPSIQ+4h8rEHacQpWy7j+AXwPHxohOH0oFJ7OuOV8r+TyqPFUX2ndi1wJS6xdnoI3MTDAvNq6DJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--gnoack.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zAGVyGo1; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--gnoack.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zAGVyGo1"
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dc6ceade361so12451805276.0
        for <linux-security-module@vger.kernel.org>; Wed, 27 Mar 2024 06:11:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711545066; x=1712149866; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OgH+A9pGo8bgeAYR/oROdEMFeGk4hRe3NHSXR6u/PQc=;
        b=zAGVyGo13mPvorWxeq/7hQXRjIB2xwIC0DsLN+8paYKG27bpNg7mJT6TiuNDGADvk8
         Vf93SKdC+uz4qGJojqYMHReo8FLpC1cipZEIM7Ll4UNLBPVymz/oYU4W2G1qzN9xwwLm
         +fHGKF75eTGqhSEA7QrBNWFOI69yjKPP/dXrQJHLUStDN1EgAhjZN+9haT32YrZw5kiJ
         cLPOsdpU7Sd1TXVQ8kfwwdK1jLqcSq3h5DBkty+YF57WaCA9I2H1JFVV/2WAkIBevtCT
         ZMwY020Yg6pvQ+OuFZL2yvhQj+DjNX0yh0b4MQf2AZtXeUR1Wu1aS2pxiQ31lyRStsi4
         WClw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711545066; x=1712149866;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=OgH+A9pGo8bgeAYR/oROdEMFeGk4hRe3NHSXR6u/PQc=;
        b=Gl7Sae+hYEpi4oOS6bWGDFERagrkLOLxhEHLnk0cWuaaw/33cohfWk5SLP33u1ChsE
         0d45Y2vsFbumVJMVIFj1U8KYtpK2k6ONQs342GjcsUvCkaBzmXatrYtNuHu9H1PMkvIt
         lDwKZyzBj/00rsowgBPWTzgQ4WJ9uzlrbnVVS0uCJahYyBzgKQDjNV51C8LQAbRaxF29
         X4lM4RXHkmnX++knUvu8r2Gvh3mRTUSE+KVlsBTYasA/MPlIRl8SS1fCRUGE+SNjgBy6
         ydF/cCcDnNc9A3QXbib+BdkmY2jhEeFM8WSmgTPqk0I91ZfEKyiyHyiD3kY5IUhppzoa
         Kbcw==
X-Gm-Message-State: AOJu0YzMusUCpIROP2CzfX5bWICdVwVlRlzsnWbSxZmCDOopu2R/y+D9
	8YHiyVlQkkSonmKFtuC5B+0lDWmL4jWWEsLte/kplMr0vmUT4sm/eLVtUdwjjLC99zhft4WJHA/
	BdUfaz2XbO8gQkzIB6w603l4cT9A3UAt7nj52VOjB2NKu0QdLDh3r2DK3r/Ctr3Bne3bGCDnAgv
	9M55CVUCkKtNAl0difkqCn1uIXYzmBZkHQWINM9DUQcrwOonR9d/Tv
X-Google-Smtp-Source: AGHT+IEGx+pRisBXIjqRw7WTmfJs7jTAXuVLd8tF0S97jUlViAzTO05AtGfmYNmzpOBX3iVy3fk2d4rEJuc=
X-Received: from swim.c.googlers.com ([fda3:e722:ac3:cc00:31:98fb:c0a8:1605])
 (user=gnoack job=sendgmr) by 2002:a05:6902:220a:b0:dcc:f01f:65e1 with SMTP id
 dm10-20020a056902220a00b00dccf01f65e1mr4043330ybb.8.1711545066672; Wed, 27
 Mar 2024 06:11:06 -0700 (PDT)
Date: Wed, 27 Mar 2024 13:10:39 +0000
In-Reply-To: <20240327131040.158777-1-gnoack@google.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240327131040.158777-1-gnoack@google.com>
X-Mailer: git-send-email 2.44.0.396.g6e790dbe36-goog
Message-ID: <20240327131040.158777-10-gnoack@google.com>
Subject: [PATCH v13 09/10] MAINTAINERS: Notify Landlock maintainers about
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
2.44.0.396.g6e790dbe36-goog

