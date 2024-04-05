Received: from mail-ed1-f74.google.com (mail-ed1-f74.google.com [209.85.208.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88D01174EEA
	for <linux-security-module@vger.kernel.org>; Fri,  5 Apr 2024 21:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712353272; cv=none; b=UN0UyoNuihHkaMA0axKgaZ/5giB+6N+nbeiGI8bRvXwf1XldT++UfUw5L4+s560xbjpHS3c9mSU+mEEDzS5PYLRpUdwECaemnY292fvQi1ygQLDmBdiWba22yFuFQ6tWdKrM2Is4Eq2lZO/JqDqFAfmTbXU+Sw9kOuZguz+yEKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712353272; c=relaxed/simple;
	bh=rfuLSAoxAdlMwMqf+SnAQnLHYITftcO5C8a85oncnfw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=RWeHKIMEMUnkVbiUYDooBLo5I6EJK5I5EnuJ+mmNzbowpS1DK2fvfFNMkt7zQP2Xd7/c9vD22o659BbifFX1X+Bf7hA3Lr8g40B96DdlIEKTkFeJm4qsOAXILR1mcs76b37/8AuE0TOcRdycWqGj4Bca2OHI1YKVMvuG/va5iHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--gnoack.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ij3wKDpQ; arc=none smtp.client-ip=209.85.208.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--gnoack.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ij3wKDpQ"
Received: by mail-ed1-f74.google.com with SMTP id 4fb4d7f45d1cf-56e41cde4b7so47768a12.1
        for <linux-security-module@vger.kernel.org>; Fri, 05 Apr 2024 14:41:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712353269; x=1712958069; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bgpVwwJA3MRA3y75oko3ScmdG271fOGajLCK9HYUHOE=;
        b=ij3wKDpQSjbdh7EQNpsbZxecBWwKQeShMyXH+jd7e2XNxBZ5N+IA2CSyc1E4myooyo
         WbWhCkZMmkDDbqLyC0DxPTQsMlm13UItS7DH3A+3bjb0mJZvC+nz0j2AfoEGozI5nyy0
         CZDolQeGu5xreTMKKPeYNdJ2QYWjSYRL8rHjFh+cFreEds+G6pGWmrZBtv0fnJo2EdDa
         aYH0xJpPmuFVdvKgIbD8Yv2z0pVUovJ0GSTvjGPsMCzPE2b8+OJ7GDZ+MIqVL3mEcfsE
         5dbomu0u2PceScdz6G2LWDhxk3CIOodewOKdbEjf1y+/mHYDFwEEBhU1/1LR2QYD6hmK
         18wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712353269; x=1712958069;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=bgpVwwJA3MRA3y75oko3ScmdG271fOGajLCK9HYUHOE=;
        b=k007oDSzuPPFPyw1BQgyU3PeFVZe6GInx2+/QPuURyJCUuBn/AjdY8Hf3kMT5ymjpF
         L/2drYNgUm8Odnvi+NGqdT1HX99fUs1Q6mV+ce9yCMTTbERhGmff7tZIC/FYmBMFO+bJ
         IiqZ6bCyhi2iZ+oTcs3V8s6balbFMuR2dTLQI0YwkhcAdUCuBxzccipbz4wYVBH+VY+U
         t/kPVO1fgHA6vhVgB86EhZI7NyWucbdmj0UDUY7CkUHObGKBvGmh80oL/zzTaM+MrGFf
         BvZoCG6eMZr8cb4RTjFoEIDju8wZ+LlRWWisVHiIAX/Qy6XEeB7AK8hBtPu41Ir6ngqX
         O9/w==
X-Gm-Message-State: AOJu0Yy7RoWWtOyug0p64RWreG+RZo7MvlISOMzVPaLBWa3rIqvmPZ9A
	tmxQVc4Jsw/9aaLmMdoI5u2yxbAZjwIxXD8oZEJxMJrtWwbVlHdZFZ0vsgdcv05P4H0CjvRDPhw
	LwBm34ikOK/4Gsy5TpZiF5ptFxzG+CiaQ7eMHhFl/x2UOwHeGb0QLFMuxJvwNob5iAz+jvlEipl
	wvturFwmKToaZXzSSlc4H9SAFG3BCUhVQmGOnMgAjBlcG+VFc5mxJC
X-Google-Smtp-Source: AGHT+IHkbB1/lpQMCZ+T3EoTISTLjUbfzEEhtyXSAqwnbQlBAsQnDVelSn77Kb6Gj2ka8UBRWJNxL5i6tes=
X-Received: from swim.c.googlers.com ([fda3:e722:ac3:cc00:31:98fb:c0a8:1605])
 (user=gnoack job=sendgmr) by 2002:a05:6402:370e:b0:56b:e571:8d40 with SMTP id
 ek14-20020a056402370e00b0056be5718d40mr3568edb.7.1712353268414; Fri, 05 Apr
 2024 14:41:08 -0700 (PDT)
Date: Fri,  5 Apr 2024 21:40:29 +0000
In-Reply-To: <20240405214040.101396-1-gnoack@google.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240405214040.101396-1-gnoack@google.com>
X-Mailer: git-send-email 2.44.0.478.gd926399ef9-goog
Message-ID: <20240405214040.101396-2-gnoack@google.com>
Subject: [PATCH v14 01/12] fs: Return ENOTTY directly if FS_IOC_GETUUID or
 FS_IOC_GETFSSYSFSPATH fail
From: "=?UTF-8?q?G=C3=BCnther=20Noack?=" <gnoack@google.com>
To: linux-security-module@vger.kernel.org, 
	"=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?=" <mic@digikod.net>
Cc: Jeff Xu <jeffxu@google.com>, Arnd Bergmann <arnd@arndb.de>, 
	Jorge Lucangeli Obes <jorgelo@chromium.org>, Allen Webb <allenwebb@google.com>, 
	Dmitry Torokhov <dtor@google.com>, Paul Moore <paul@paul-moore.com>, 
	Konstantin Meskhidze <konstantin.meskhidze@huawei.com>, Matt Bobrowski <repnop@google.com>, 
	linux-fsdevel@vger.kernel.org, 
	"=?UTF-8?q?G=C3=BCnther=20Noack?=" <gnoack@google.com>, Kent Overstreet <kent.overstreet@linux.dev>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Dave Chinner <dchinner@redhat.com>, 
	"Darrick J . Wong" <djwong@kernel.org>, "Theodore Ts'o" <tytso@mit.edu>, Josef Bacik <josef@toxicpanda.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

These IOCTL commands should be implemented by setting attributes on the
superblock, rather than in the IOCTL hooks in struct file_operations.

By returning -ENOTTY instead of -ENOIOCTLCMD, we instruct the fs/ioctl.c
logic to return -ENOTTY immediately, rather than attempting to call
f_op->unlocked_ioctl() or f_op->compat_ioctl() as a fallback.

Why this is safe:

Before this change, fs/ioctl.c would unsuccessfully attempt calling the
IOCTL hooks, and then return -ENOTTY.  By returning -ENOTTY directly, we
return the same error code immediately, but save ourselves the fallback
attempt.

Motivation:

This simplifies the logic for these IOCTL commands and lets us reason about
the side effects of these IOCTLs more easily.  It will be possible to
permit these IOCTLs under LSM IOCTL policies, without having to worry about
them getting dispatched to problematic device drivers (which sometimes do
work before looking at the IOCTL command number).

Link: https://lore.kernel.org/all/cnwpkeovzbumhprco7q2c2y6zxzmxfpwpwe3tyy6c=
3gg2szgqd@vfzjaw5v5imr/
Cc: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>
Cc: Dave Chinner <dchinner@redhat.com>
Cc: Darrick J. Wong <djwong@kernel.org>
Cc: Theodore Ts'o <tytso@mit.edu>
Cc: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: G=C3=BCnther Noack <gnoack@google.com>
---
 fs/ioctl.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/ioctl.c b/fs/ioctl.c
index 1d5abfdf0f22..fb0628e680c4 100644
--- a/fs/ioctl.c
+++ b/fs/ioctl.c
@@ -769,7 +769,7 @@ static int ioctl_getfsuuid(struct file *file, void __us=
er *argp)
 	struct fsuuid2 u =3D { .len =3D sb->s_uuid_len, };
=20
 	if (!sb->s_uuid_len)
-		return -ENOIOCTLCMD;
+		return -ENOTTY;
=20
 	memcpy(&u.uuid[0], &sb->s_uuid, sb->s_uuid_len);
=20
@@ -781,7 +781,7 @@ static int ioctl_get_fs_sysfs_path(struct file *file, v=
oid __user *argp)
 	struct super_block *sb =3D file_inode(file)->i_sb;
=20
 	if (!strlen(sb->s_sysfs_name))
-		return -ENOIOCTLCMD;
+		return -ENOTTY;
=20
 	struct fs_sysfs_path u =3D {};
=20
--=20
2.44.0.478.gd926399ef9-goog

