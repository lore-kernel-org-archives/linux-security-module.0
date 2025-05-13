Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38F8A2144C7
	for <linux-security-module@vger.kernel.org>; Tue, 13 May 2025 09:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747127912; cv=none; b=Tm+n2PasSdKRIOjIA6VEDAM6wcjZ2mqkW2Q68l6ROJxyD+Qje21fq60bKUFMIHu4GSmMIqW0Oe2cbEUzM7UUV3LHFqejdynz+geCgx/wn/qqPKNxdGb53BEtPPbenHBwpUWbJ4lKmoO7PORS/IiOeE+xtdSHZuXr8Gy52MTR8rk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747127912; c=relaxed/simple;
	bh=7/qlLocSDGOnq9HanUewnfKPkCH1bdYdAp9tNZm+5GE=;
	h=From:Date:Subject:MIME-Version:Message-Id:References:In-Reply-To:
	 To:Cc:Content-Type; b=XtqfFOqtDHSzn3FD5jar+76AJzg5MFQsDSHxCVcPLZ1C/endkWQZRDGhFbn2GOgGKRY+i1u5UYEM29kMjC2yeMJmhUeMMCvKOHpzdUo/EpmK/vTX8fv7xqNpUQ88FePpd63nwaMdMVxnkljZ4a+d+qoGBxvgbjuNYG7nT17XKXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=jJ+jFPIa; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jJ+jFPIa"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747127903;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ls6EYzWLpzSyrbfDPukFujnVQKFcbGgB9h/N+wiqpNc=;
	b=jJ+jFPIa64Tsftg/mBJGPfODZ1x8ZTS7Q0+ojUe7VkkIfBT0327FdyN9uaxq03PTl2RMf1
	USz1WRPXvpOUXfwCbrbSiDona0KuEojBMmeJA9zjqvABT0URG4jI2RoZ9oOjlGN8YdCiY2
	LHYMGYySDDm9PX3neEk7pouEEkkEHEU=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-665-HgbKhsqfOFefUDJ2Yk-pUA-1; Tue, 13 May 2025 05:18:23 -0400
X-MC-Unique: HgbKhsqfOFefUDJ2Yk-pUA-1
X-Mimecast-MFC-AGG-ID: HgbKhsqfOFefUDJ2Yk-pUA_1747127902
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-442d472cf7fso31673305e9.3
        for <linux-security-module@vger.kernel.org>; Tue, 13 May 2025 02:18:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747127902; x=1747732702;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ls6EYzWLpzSyrbfDPukFujnVQKFcbGgB9h/N+wiqpNc=;
        b=c6/TvgTFht7+HCbKAXpbItZKivzm/32gXXVa3LvBxu9Y2saK+dgOEfOPxSKGkO+50G
         FxvCofhN2BIpWwJNJjV0CeC5zPXhcu2bhFr5hWcuCOhe59Lgl0cfYHvONmTjt2y7e/FP
         GWE3JxcX5aeyRmguDlChIcMF2PxUflzHr41S1ZEBsR2ZRbQyhYE2Z+KsAB1giDdXMQ8J
         4PX/7yuc1bh0gojtURu7kN2n3ZVs00AyiE4aaTM0s7+UNBxpr+oWPu8As9cAZYsQSchA
         uHRevvLqKhHweIa0+L1YES3/HGX5Tj3XNXl7ULdt3+DgFv/VQyRplhES3vicyfCG5eCo
         lQwQ==
X-Forwarded-Encrypted: i=1; AJvYcCWE5yB6iA24xgRA+Qxxff7gT28aT+uZJ1CbdzUvGW+OnXK+wSzsFW39R1kCDTbatHFnUKSDsX8MqolWY6kuriSM4g7+bAo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzj+NXVeguQVxj3YTP6BtmU9vCrfI4GmsNvwpGEBIfvceR2AxMA
	we7JImHjJkWW7f4KyseBg4X4FmWjBDFoPhU1hxV/cVxMxba2dEGsD5XGlXpxYYshfe/R6QMsk0V
	gJrPh4IasZvBEwy2/9NnVo+POP/d4uYFMSiAeWSUhMnjLPm7ilDeCOpUGaN2brYFLYPRRQ6Zu
X-Gm-Gg: ASbGncsx4eOMsSox5TIhneW2I4ghE3aID1ceWj3aH+RXZtAdPK4LWfJofpup9T8/sNW
	Eg0I73+LGqY4Kcoy1yR/t6C9ReYWG+bX1xUfYsswiXw7b1W0F0ZGNv85YNr9phFVLPEOAZY4wU7
	PdmbR2u/My26wqx+xJBm+WFVBO9DtVVLIbUn9n/Aw7+OGG510YvwiesxeDpFZZSPBWT2z+pwpo6
	BvIBa8XuIKK1XsOhQvtQol9ql4n8PJ1smfkk2kwa+VU2tjlURF4m6HNjEEwDhxvjlEDCZvxBx+K
	6CooucwunKrN1bw3MZOV2v0beI9Prg1NKFa2QYTnPNmE+pU=
X-Received: by 2002:a05:600c:37c7:b0:43c:efed:733e with SMTP id 5b1f17b1804b1-442d6d379b2mr155020005e9.14.1747127901728;
        Tue, 13 May 2025 02:18:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHEEtHWgn5s898vXVMD6AEOwzulPPtHZtUMHxI74NvDZ3sPtiUYejsU22j+vwltmbRtQ8fYMg==
X-Received: by 2002:a05:600c:37c7:b0:43c:efed:733e with SMTP id 5b1f17b1804b1-442d6d379b2mr155019705e9.14.1747127901297;
        Tue, 13 May 2025 02:18:21 -0700 (PDT)
Received: from [127.0.0.2] (109-92-26-237.static.isp.telekom.rs. [109.92.26.237])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-442ed666dc7sm12345655e9.18.2025.05.13.02.18.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 May 2025 02:18:20 -0700 (PDT)
From: Andrey Albershteyn <aalbersh@redhat.com>
X-Google-Original-From: Andrey Albershteyn <aalbersh@kernel.org>
Date: Tue, 13 May 2025 11:17:57 +0200
Subject: [PATCH v5 4/7] fs: split fileattr/fsxattr converters into helpers
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <20250513-xattrat-syscall-v5-4-22bb9c6c767f@kernel.org>
References: <20250513-xattrat-syscall-v5-0-22bb9c6c767f@kernel.org>
In-Reply-To: <20250513-xattrat-syscall-v5-0-22bb9c6c767f@kernel.org>
To: Richard Henderson <richard.henderson@linaro.org>, 
 Matt Turner <mattst88@gmail.com>, Russell King <linux@armlinux.org.uk>, 
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
 Geert Uytterhoeven <geert@linux-m68k.org>, Michal Simek <monstr@monstr.eu>, 
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>, 
 Helge Deller <deller@gmx.de>, Madhavan Srinivasan <maddy@linux.ibm.com>, 
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
 Christophe Leroy <christophe.leroy@csgroup.eu>, 
 Naveen N Rao <naveen@kernel.org>, Heiko Carstens <hca@linux.ibm.com>, 
 Vasily Gorbik <gor@linux.ibm.com>, 
 Alexander Gordeev <agordeev@linux.ibm.com>, 
 Christian Borntraeger <borntraeger@linux.ibm.com>, 
 Sven Schnelle <svens@linux.ibm.com>, 
 Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, 
 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, 
 "David S. Miller" <davem@davemloft.net>, 
 Andreas Larsson <andreas@gaisler.com>, Andy Lutomirski <luto@kernel.org>, 
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, 
 Chris Zankel <chris@zankel.net>, Max Filippov <jcmvbkbc@gmail.com>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 =?utf-8?q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>, 
 =?utf-8?q?G=C3=BCnther_Noack?= <gnoack@google.com>, 
 Arnd Bergmann <arnd@arndb.de>, 
 =?utf-8?q?Pali_Roh=C3=A1r?= <pali@kernel.org>, 
 Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, 
 "Serge E. Hallyn" <serge@hallyn.com>, 
 Stephen Smalley <stephen.smalley.work@gmail.com>, 
 Ondrej Mosnacek <omosnace@redhat.com>, Tyler Hicks <code@tyhicks.com>, 
 Miklos Szeredi <miklos@szeredi.hu>, Amir Goldstein <amir73il@gmail.com>
Cc: linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-m68k@lists.linux-m68k.org, 
 linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org, 
 linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, 
 linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, 
 linux-fsdevel@vger.kernel.org, linux-security-module@vger.kernel.org, 
 linux-api@vger.kernel.org, linux-arch@vger.kernel.org, 
 selinux@vger.kernel.org, ecryptfs@vger.kernel.org, 
 linux-unionfs@vger.kernel.org, linux-xfs@vger.kernel.org, 
 Andrey Albershteyn <aalbersh@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3154; i=aalbersh@kernel.org;
 h=from:subject:message-id; bh=7/qlLocSDGOnq9HanUewnfKPkCH1bdYdAp9tNZm+5GE=;
 b=owJ4nJvAy8zAJea2/JXEGuOHHIyn1ZIYMpT5vBmqeS9Of1kvckyD89yLKSHZd6cITHwR8ON6Q
 Krbn8kRqyw6SlkYxLgYZMUUWdZJa01NKpLKP2JQIw8zh5UJbAgXpwBMZHojI8Npu1fs2yWveYpu
 X75O9+PGOXL/F3U+vN7XHFJf5fdw0aozDH/lf/x993b3NibzczpnPr7ddd+5/McRwUl+3zqveq7
 g+LeWDwBTZEzV
X-Developer-Key: i=aalbersh@kernel.org; a=openpgp;
 fpr=AE1B2A9562721A6FC4307C1F46A7EA18AC33E108
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: tRkrMYUmzYZaqQat2yY_cBuMAFENds7-PBDhm3EsCfU_1747127902
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

This will be helpful for file_get/setattr syscalls to convert
between fileattr and fsxattr.

Signed-off-by: Andrey Albershteyn <aalbersh@kernel.org>
Reviewed-by: Jan Kara <jack@suse.cz>
---
 fs/file_attr.c           | 32 +++++++++++++++++++++-----------
 include/linux/fileattr.h |  2 ++
 2 files changed, 23 insertions(+), 11 deletions(-)

diff --git a/fs/file_attr.c b/fs/file_attr.c
index be62d97cc444a445deac1c8ac8331f4a3766126a..d9eab553dc250f84075ac74c1c7d8d6fd6588374 100644
--- a/fs/file_attr.c
+++ b/fs/file_attr.c
@@ -89,6 +89,16 @@ int vfs_fileattr_get(struct dentry *dentry, struct fileattr *fa)
 }
 EXPORT_SYMBOL(vfs_fileattr_get);
 
+void fileattr_to_fsxattr(const struct fileattr *fa, struct fsxattr *fsx)
+{
+	memset(fsx, 0, sizeof(struct fsxattr));
+	fsx->fsx_xflags = fa->fsx_xflags;
+	fsx->fsx_extsize = fa->fsx_extsize;
+	fsx->fsx_nextents = fa->fsx_nextents;
+	fsx->fsx_projid = fa->fsx_projid;
+	fsx->fsx_cowextsize = fa->fsx_cowextsize;
+}
+
 /**
  * copy_fsxattr_to_user - copy fsxattr to userspace.
  * @fa:		fileattr pointer
@@ -100,12 +110,7 @@ int copy_fsxattr_to_user(const struct fileattr *fa, struct fsxattr __user *ufa)
 {
 	struct fsxattr xfa;
 
-	memset(&xfa, 0, sizeof(xfa));
-	xfa.fsx_xflags = fa->fsx_xflags;
-	xfa.fsx_extsize = fa->fsx_extsize;
-	xfa.fsx_nextents = fa->fsx_nextents;
-	xfa.fsx_projid = fa->fsx_projid;
-	xfa.fsx_cowextsize = fa->fsx_cowextsize;
+	fileattr_to_fsxattr(fa, &xfa);
 
 	if (copy_to_user(ufa, &xfa, sizeof(xfa)))
 		return -EFAULT;
@@ -114,6 +119,15 @@ int copy_fsxattr_to_user(const struct fileattr *fa, struct fsxattr __user *ufa)
 }
 EXPORT_SYMBOL(copy_fsxattr_to_user);
 
+void fsxattr_to_fileattr(const struct fsxattr *fsx, struct fileattr *fa)
+{
+	fileattr_fill_xflags(fa, fsx->fsx_xflags);
+	fa->fsx_extsize = fsx->fsx_extsize;
+	fa->fsx_nextents = fsx->fsx_nextents;
+	fa->fsx_projid = fsx->fsx_projid;
+	fa->fsx_cowextsize = fsx->fsx_cowextsize;
+}
+
 static int copy_fsxattr_from_user(struct fileattr *fa,
 				  struct fsxattr __user *ufa)
 {
@@ -122,11 +136,7 @@ static int copy_fsxattr_from_user(struct fileattr *fa,
 	if (copy_from_user(&xfa, ufa, sizeof(xfa)))
 		return -EFAULT;
 
-	fileattr_fill_xflags(fa, xfa.fsx_xflags);
-	fa->fsx_extsize = xfa.fsx_extsize;
-	fa->fsx_nextents = xfa.fsx_nextents;
-	fa->fsx_projid = xfa.fsx_projid;
-	fa->fsx_cowextsize = xfa.fsx_cowextsize;
+	fsxattr_to_fileattr(&xfa, fa);
 
 	return 0;
 }
diff --git a/include/linux/fileattr.h b/include/linux/fileattr.h
index 6030d0bf7ad32693a0f48a6f28475d97e768bb3e..433efa0f47844ef063373eb390672812682b6388 100644
--- a/include/linux/fileattr.h
+++ b/include/linux/fileattr.h
@@ -33,7 +33,9 @@ struct fileattr {
 	bool	fsx_valid:1;
 };
 
+void fileattr_to_fsxattr(const struct fileattr *fa, struct fsxattr *fsx);
 int copy_fsxattr_to_user(const struct fileattr *fa, struct fsxattr __user *ufa);
+void fsxattr_to_fileattr(const struct fsxattr *fsx, struct fileattr *fa);
 
 void fileattr_fill_xflags(struct fileattr *fa, u32 xflags);
 void fileattr_fill_flags(struct fileattr *fa, u32 flags);

-- 
2.47.2

