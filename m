Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F810318EE9
	for <linux-security-module@vger.kernel.org>; Mon, 16 Feb 2026 15:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771254398; cv=none; b=hbA08EZ7DdGqQpl4h8vN6TDuWfcLEkp8nXgA907KHrBfcmF8BDU2owUc9VoU43PUxcYGj+zZalGhzy4hLEc0HwXZsScF07SHMH9+RW5Y4Z0uwFasUKPsbBIl14Fxy5eUx6XtTyyLscDbYZVxtuC4ZXF3BWkvVvue8tXi9n3zB1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771254398; c=relaxed/simple;
	bh=zx3WubZPys3qQZ9hjzoig3BrUfn76syHM4LUOku80x4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=TeKVaU31SKhXMPiqTF2YkszFbaA2GuEqHYfgO4vNie4FPbu1ZsL2vNR3O6+BiFWzy+y1xGoQ4HOm4ExiHoPS0+w5TJ28BNNzuQ39VZ/jvEpLaV9gIfAHoTtbYu2gABEBTfmDiXVqv7ZjbK24RvFX3sC6VARTHqKv6k5e9+erYr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=F1F9nIA6; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="F1F9nIA6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1771254396;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aIxEocxEapJW7yU9OtfyLhPCnRBq6fT8ce1CcmY6sug=;
	b=F1F9nIA6w07RETzRGJXfQZlfb222A1Y2B67Ow7dxPmQbI6ML9exDSUxL2ZRfp0ozHHN+nw
	WIFJdD4RJyDIyeIHvl1yLOuj13x7BGJ13eYtoAwdgyONP0PADWBpVkgVXUpcVxLhRp+Kj3
	N8vMaPjdACOqoVsEhbjxk1FcaDGt2ng=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-222-BuIiUydRNtGCCVmSPkfBmg-1; Mon, 16 Feb 2026 10:06:33 -0500
X-MC-Unique: BuIiUydRNtGCCVmSPkfBmg-1
X-Mimecast-MFC-AGG-ID: BuIiUydRNtGCCVmSPkfBmg_1771254392
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-437700715ddso3253590f8f.2
        for <linux-security-module@vger.kernel.org>; Mon, 16 Feb 2026 07:06:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771254392; x=1771859192;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=aIxEocxEapJW7yU9OtfyLhPCnRBq6fT8ce1CcmY6sug=;
        b=qhe1fVDmb1PQnMDAWEQSoX7QHoAbkMxwfgzah2KE7mkuriS4qIQ9cAQ7dprpJSlFSC
         2AsBKEf2Ugshx0o/9OoRl9yw38xdSxMC95cW6xweMW+nWEyIJT2O5j7k2gZ+BpD2z6kc
         gjSqWFMM4twaPCe1aIlUwq+xepww2UUT+zM3chS8Oq/oJOY1r4wZsyBKhf5O3Cy5SVM8
         ms7PXHzkbtB14MYzOFWuqVoqCwkmJeMuI/QlRwAppOZVxseXH7fIkecZVpoE0PKv6Cu9
         eb2UA5SHaE+oo+OwvJ354ssa5Mur5TbiBgH8KUH4W8cPoU5ZdNrij41Id8CG0a9ke8ub
         n6fA==
X-Forwarded-Encrypted: i=1; AJvYcCXEDQPT+gve5Q4s1LJdxT+Yqs3O9xOL60IDKO1sJ7yFgBPUcFhZP1TeEOqXwqefPLqnOtpnYSXG1B3eYEkxo6WyU1JhefE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/mTtDmgRE076iQTejwrqbi6ih+fzeqjyapOn5iDY+ogdSNjud
	+dxpel5BHmvM0fHDlWk25BKjX20oO3+6EkJYQxHlLacx8slecmoxXAKL0gBGkUmH6Y7AIYeNaU/
	54IIeJgnkKKAXkYPBV4Y6GZj+zAO1EXVBjr+CM7LEzT59VXyrErta+yjNab6+2jMIDzbiJZwatX
	FO1wpTXTwaPQ==
X-Gm-Gg: AZuq6aJXZTI9R63y6Ud+ex4XY0A3ZWnMud9+6Lzl/5DzQUFsH3vF1Hd2KBlVw/B6RN4
	zMhAD08Lmx+SlPhw+yvJArK4r4P81kk3t93P8oBWzFsUXrEW/rtZoBUg1djmdfFFBToS1WVoAWd
	oYcQ6K0fIXzcjoa72N4emUqxd6BQJi38kGM7fp1ikqUNwDmqWTkItK5hYIrSCgoJ7wxWurflUbN
	Bi24+dFHnrKsQ+CkvidXk/XvepB3330MTWPGq85ylnnm2i/T+o14pOXm3XANnhmU4+/yJsGgIbq
	MPCT0K5Z54Mofnkr6hMn+MoNHKiBKJARHRMTZlXDFfY1fv3p6dzpxxQJgbBVNdhqdIk2blSwPqj
	LECJFoLKHzsF2L1zSUt15xsm7gHuU4i7uzoxvUMREISVRwayE
X-Received: by 2002:a05:6000:420a:b0:437:6758:ce75 with SMTP id ffacd0b85a97d-43796ac216amr22698927f8f.23.1771254391993;
        Mon, 16 Feb 2026 07:06:31 -0800 (PST)
X-Received: by 2002:a05:6000:420a:b0:437:6758:ce75 with SMTP id ffacd0b85a97d-43796ac216amr22698863f8f.23.1771254391533;
        Mon, 16 Feb 2026 07:06:31 -0800 (PST)
Received: from fedora.redhat.com (109-81-17-58.rct.o2.cz. [109.81.17.58])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43796abc9b2sm25631899f8f.21.2026.02.16.07.06.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Feb 2026 07:06:30 -0800 (PST)
From: Ondrej Mosnacek <omosnace@redhat.com>
To: Jan Kara <jack@suse.cz>
Cc: Amir Goldstein <amir73il@gmail.com>,
	Matthew Bobrowski <repnop@google.com>,
	linux-fsdevel@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	selinux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] fanotify: call fanotify_events_supported() before path_permission() and security_path_notify()
Date: Mon, 16 Feb 2026 16:06:25 +0100
Message-ID: <20260216150625.793013-3-omosnace@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260216150625.793013-1-omosnace@redhat.com>
References: <20260216150625.793013-1-omosnace@redhat.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: XL__rIdr540z0ANhqsiKyMws3UNPpwajAFqpmKrjBKg_1771254392
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

The latter trigger LSM (e.g. SELinux) checks, which will log a denial
when permission is denied, so it's better to do them after validity
checks to avoid logging a denial when the operation would fail anyway.

Fixes: 0b3b094ac9a7 ("fanotify: Disallow permission events for proc filesystem")
Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
---
 fs/notify/fanotify/fanotify_user.c | 25 ++++++++++---------------
 1 file changed, 10 insertions(+), 15 deletions(-)

diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fanotify_user.c
index 9c9fca2976d2b..bfc4d09e6964a 100644
--- a/fs/notify/fanotify/fanotify_user.c
+++ b/fs/notify/fanotify/fanotify_user.c
@@ -1210,6 +1210,7 @@ static int fanotify_find_path(int dfd, const char __user *filename,
 
 		*path = fd_file(f)->f_path;
 		path_get(path);
+		ret = 0;
 	} else {
 		unsigned int lookup_flags = 0;
 
@@ -1219,22 +1220,7 @@ static int fanotify_find_path(int dfd, const char __user *filename,
 			lookup_flags |= LOOKUP_DIRECTORY;
 
 		ret = user_path_at(dfd, filename, lookup_flags, path);
-		if (ret)
-			goto out;
 	}
-
-	/* you can only watch an inode if you have read permissions on it */
-	ret = path_permission(path, MAY_READ);
-	if (ret) {
-		path_put(path);
-		goto out;
-	}
-
-	ret = security_path_notify(path, mask, obj_type);
-	if (ret)
-		path_put(path);
-
-out:
 	return ret;
 }
 
@@ -2058,6 +2044,15 @@ static int do_fanotify_mark(int fanotify_fd, unsigned int flags, __u64 mask,
 			goto path_put_and_out;
 	}
 
+	/* you can only watch an inode if you have read permissions on it */
+	ret = path_permission(&path, MAY_READ);
+	if (ret)
+		goto path_put_and_out;
+
+	ret = security_path_notify(&path, mask, obj_type);
+	if (ret)
+		goto path_put_and_out;
+
 	if (fid_mode) {
 		ret = fanotify_test_fsid(path.dentry, flags, &__fsid);
 		if (ret)
-- 
2.53.0

