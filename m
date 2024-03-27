Received: from mail-ej1-f73.google.com (mail-ej1-f73.google.com [209.85.218.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A607D157472
	for <linux-security-module@vger.kernel.org>; Wed, 27 Mar 2024 13:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711545073; cv=none; b=AUbmk1ZstR1Zp03AEg4H2IoKpZ1F9qzhb6X+Z4yn3+ujCOugxULNw7tfhoGNNtB8MHhSXwKCyE1wD2UdYSMlwPIxinxBBL8jr+Ppw3WMrwW10OzwYzQt80SJmutqzmOSL3uACZa1Qt7JyHag0809yrJXfHL4a8qPAIN3fSVvlXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711545073; c=relaxed/simple;
	bh=DaxfOx5juRgkGT1onoeBml+KzX99DS3H5Kfd98iKnRA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=gl3yb5OOL7oqDM81gJ/w8QfR3FTdMCnS4MieSnI9YEgIypbeoj9wwZkcfe+N0CDAhpQ35KWyly7BDFi2bWjacGxKV8b7s8XWnAHhn8HDrJFbbnAhmEoi7mBo57B+6xTMY03fZdF6Sq/STSbnQPUsjWRjd00gXO000LZlVKh/SEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--gnoack.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lnTBa5uq; arc=none smtp.client-ip=209.85.218.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--gnoack.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lnTBa5uq"
Received: by mail-ej1-f73.google.com with SMTP id a640c23a62f3a-a4a356fc0d1so72343766b.3
        for <linux-security-module@vger.kernel.org>; Wed, 27 Mar 2024 06:11:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711545069; x=1712149869; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JyYxrfp8pIz08BwXl1sIdsAZMNI11A0A6tQ7MGaWE3A=;
        b=lnTBa5uqfVtfS29tUfP5h5yCrCyZWNqmNSPAdyChw/rok2c8rtAMBOK2Cn4IPjEeQp
         oMha+GFLF/sJG6ZFG3zUtJeQWtDJ1/RJ1i7H2pqt098wVkHvTpn0/xKmLssZzyhpegVX
         NShBh+V2YwQ36iTIWcjjJGZyqD/9p2VTYQkxQ6dhhi2UZlNR1o3pecJdGjol2dDAxd+X
         gIRy/vC1JTB/ZSKJPVkaNd/uI6xowdznOhNEYBjgUha4cCmhF00+qoin47v3fRjCfKFv
         XjkYXT7uE2+QlHL4FZANl2wiW6Zgm4E58tWR9z/UbyeXvi+MNt2Z/rd1J57C40Vkjax7
         FbEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711545069; x=1712149869;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=JyYxrfp8pIz08BwXl1sIdsAZMNI11A0A6tQ7MGaWE3A=;
        b=Nh2GjqZzdMFFDE9rJgY1P2/dAJVz+eKZIdd7bsfuAw8/vL40rliWdIVj346Z+2Au6e
         jI8xHWdRxOBmxaJPTUZmE+4VLUKzSh0qG2AMYH0rYYPOVlMtrGquUe8EKME4X+1G8wQG
         IAWth6cO0AW3NIDJzm1HId3CUk0NRStNlbHzsgzifQwm+TsCD4Dqr1uwGrBiUGONbB1k
         qZAo7MuBcETzP5NgkX8xZeo1XS78pQlR1SXcXGYamxMh04Ym0fg/s+woCM5rCfc6PwmI
         +j2nVai2SLeQW7Md6lk3CnVL3uk2isKEIW/tRWU+ZvDTZvXZSDv6k0jQIG7dDa4WmNf+
         wBcQ==
X-Gm-Message-State: AOJu0YwK3BMNkekPcjMayLXqA2h9opGB/MpJ9pmQ+P9Lrh3GVAUpEG1A
	FX6k9ms0byYqoTvyJSc1THBj3x0CdHAXxAhsou8dB0invKp1jJScl7MsPQEjrfo5hcrfye4Zt8+
	P6AufJy9G//h4XLHaFY3gqY9pZWtgnG568DPhOvMEDqwg/CbGmDFnlbDaeGw+TssX5ZGQSEb5b7
	3JSSin1yIgumuu8QP6uhACpdG7RLkcIWcw7mD4Ys07aOSlrRmO8zP0
X-Google-Smtp-Source: AGHT+IE0fDcnEvDqGJg1fVMOQ6R5gkGljbJZHgo/+asP4z0tgVwIay2ta6riix8G+ncHSOmPx2WqFOJsbtU=
X-Received: from swim.c.googlers.com ([fda3:e722:ac3:cc00:31:98fb:c0a8:1605])
 (user=gnoack job=sendgmr) by 2002:a17:906:a1d0:b0:a47:1499:6de0 with SMTP id
 bx16-20020a170906a1d000b00a4714996de0mr61846ejb.7.1711545068926; Wed, 27 Mar
 2024 06:11:08 -0700 (PDT)
Date: Wed, 27 Mar 2024 13:10:40 +0000
In-Reply-To: <20240327131040.158777-1-gnoack@google.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240327131040.158777-1-gnoack@google.com>
X-Mailer: git-send-email 2.44.0.396.g6e790dbe36-goog
Message-ID: <20240327131040.158777-11-gnoack@google.com>
Subject: [PATCH v13 10/10] fs/ioctl: Add a comment to keep the logic in sync
 with the Landlock LSM
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

Landlock's IOCTL support needs to partially replicate the list of
IOCTLs from do_vfs_ioctl().  The list of commands implemented in
do_vfs_ioctl() should be kept in sync with Landlock's IOCTL policies.

Signed-off-by: G=C3=BCnther Noack <gnoack@google.com>
---
 fs/ioctl.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/ioctl.c b/fs/ioctl.c
index 1d5abfdf0f22..661b46125669 100644
--- a/fs/ioctl.c
+++ b/fs/ioctl.c
@@ -796,6 +796,9 @@ static int ioctl_get_fs_sysfs_path(struct file *file, v=
oid __user *argp)
  *
  * When you add any new common ioctls to the switches above and below,
  * please ensure they have compatible arguments in compat mode.
+ *
+ * The commands which are implemented here should be kept in sync with the=
 IOCTL
+ * security policies in the Landlock LSM.
  */
 static int do_vfs_ioctl(struct file *filp, unsigned int fd,
 			unsigned int cmd, unsigned long arg)
--=20
2.44.0.396.g6e790dbe36-goog

