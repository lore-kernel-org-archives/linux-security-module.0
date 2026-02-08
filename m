Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A7B62DA75A
	for <linux-security-module@vger.kernel.org>; Sun,  8 Feb 2026 23:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770592286; cv=none; b=YjVF7FS7yRepwm+ayETHyQP3U/ndhkn7MhozkjBzjEAtG2taCFENHo61VRSdkJzpV/aNEhPe5gc+tGn/ISf5cbx9Kg78XAFmOrWTl54aCdweSVBwQHZ8sQ6mD9qVmjxiu+2kBXDzQsd6B6YDDa8s31shJ10/lLubIoI2MSR4HAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770592286; c=relaxed/simple;
	bh=QOm9F4rAdHIw0Y1+r1xirK/H3bmY8d8frKBBirnCKq0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kX2gErS4BQ1HMboKtDHtlyGWDBXxvsW7dxKSBh+90DHf8B6flg35ZGOGMO+uNra5Z5X5VMKk8tRjP/NrRofc2xD2GIzYoPBYIw2WqXJn7CCMCIYL3WrX/pK9Zr0D5pClnQ+xjAHjmIiSZwewP7eazwWwfl5nJN5WzDzcXeCkspE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QvvMnCyK; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QvvMnCyK"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-48068ed1eccso38597585e9.2
        for <linux-security-module@vger.kernel.org>; Sun, 08 Feb 2026 15:11:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770592284; x=1771197084; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZKIbbH25AkZ/XRQpPyQa4nvfKuzS5hDxsm5xC75qvbs=;
        b=QvvMnCyKOi3mVNS13P7JoRHnsLtOFhvycVyOlVJBxlKdvPXuOiL0a3EXWJ1Df8JeDA
         Xv260HGAAZn59I9OnToPwbNqINuQPm0c0+vstvQWNroGl5jWVgr+qXlg2rSow8jqp34v
         BiouthqnxCqrRSSaFS6V3tOR2M6poZVMZDmBr3CYZJl0WoZ1QtJ02BGxF4rtWWnyKWZB
         WREDRiXEuaiX8+/i2V2cB6J71WapGKKvtdgyAeOxWU2WCPkDANUnhg2KwaJSaReFs0kX
         t74DbatmqQLm74Q7ytzrrPJi6blIUbYEBJGCewZjMvW6RHAw7rF/DeNibhImqKjQ2+uG
         DOyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770592284; x=1771197084;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ZKIbbH25AkZ/XRQpPyQa4nvfKuzS5hDxsm5xC75qvbs=;
        b=LGymgoAhs1Bc0QY1hSBFt7DYnUV5uwvlm1d/qEF8F1PndQIj+TIDieA+bpWuNia4Ls
         fZKE00JCZxfGFq57XZJYpGj9DgeMW3Yfhf7aeA7C3FeOV9X2Px5Ql2voEcy8dI05ezAk
         d+Iux0UkNSSRV82Uu228SkZgNnpuqpHWBtHujX7cY2duPZ2iDgf2olIdzu+aiNLyLhoV
         SvhnsNp6WvUVDfgFrHzhe7JeTdGfC5jFl22moNlwuTleWjk9Dp7am0uXQUz0L+knH9v5
         1CEb2koLpN9WSPW96+Q6K0MNJdUTwLNZSw/p7Pd5b6bpIDWt2BtwJ0hBuzSykvSy0oAo
         XGeA==
X-Forwarded-Encrypted: i=1; AJvYcCX7cL/x9NZan1/y1lYgVJNGlgzsRVbCyDPqJNlLeiCDVcmROhHdut3KOtOVcy2UZJIyct7JOi8sgp0XGsAHAyBWIGn2o8c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+AhJiBtf163KbrTvKD1QL7+lbk9n5HJUeR6OvEF3uxaPdARye
	lnFg6XlPP6gsKU9Bwz9vPnMtIMFD18djiEIs8b9QEa1Dshnt8lqifKXB
X-Gm-Gg: AZuq6aLhvjwQyZA/g4QdVFvp/XQJfp+IyuChjRZDe/T8Dtkmc1f8VXJtpJjAkbREv9e
	2FW1jAayqRmJ2KtQY4ILB3BtOB8cwqd4ewWJcQRLn99/Kdl1fM+RjqPSpbUITKpUnfmfU00S72y
	/K+5WIVPXrAAt8OJD7VVN9XBF0RS2DqPtWZAuECz64d+2Pyn0SBUDYiOQEqnM2gksDZhhu7flDr
	vq0zMpfYDIrOo/eqahCkvQL08DhnfJa+kXBOmcrJeppdmVhFz5TcGLfxFhenb02SKNTf63IOGmY
	8WgBEmPWxtJpzlgsf00Q6TiV2tkIltNPjh2ocmqFM3L+lNce9gK+TegApQ/ty/TaX7o4OJ32B/0
	GWyG2UPlnSnxHCeMgSWCbkCngBqihfTiZMiyQtu1oWUK3hzQ7p2o8ZhJIv99MT9xgffx1JeyfpN
	3iKQRFcR9bKniduKbf6X6RONdvUm3u7E19ldUz
X-Received: by 2002:a05:600c:4fc8:b0:46f:c55a:5a8d with SMTP id 5b1f17b1804b1-483201dc396mr145786915e9.4.1770592283797;
        Sun, 08 Feb 2026 15:11:23 -0800 (PST)
Received: from localhost (ip87-106-108-193.pbiaas.com. [87.106.108.193])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48317d835f0sm279873645e9.14.2026.02.08.15.11.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Feb 2026 15:11:23 -0800 (PST)
From: =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack3000@gmail.com>
To: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	"John Johansen" <john.johansen@canonical.com>
Cc: =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack3000@gmail.com>,
	Justin Suess <utilityemal77@gmail.com>,
	linux-security-module@vger.kernel.org,
	"Tingmao Wang" <m@maowtm.org>,
	"Samasth Norway Ananda" <samasth.norway.ananda@oracle.com>,
	"Matthieu Buffet" <matthieu@buffet.re>,
	"Mikhail Ivanov" <ivanov.mikhail1@huawei-partners.com>,
	konstantin.meskhidze@huawei.com,
	"Demi Marie Obenour" <demiobenour@gmail.com>,
	"Alyssa Ross" <hi@alyssa.is>,
	"Jann Horn" <jannh@google.com>,
	"Tahera Fahimi" <fahimitahera@gmail.com>
Subject: [PATCH v4 3/6] samples/landlock: Add support for named UNIX domain socket restrictions
Date: Mon,  9 Feb 2026 00:10:13 +0100
Message-ID: <20260208231017.114343-4-gnoack3000@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260208231017.114343-1-gnoack3000@gmail.com>
References: <20260208231017.114343-1-gnoack3000@gmail.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The access right for UNIX domain socket lookups is grouped with the
read-write rights in the sample tool.  Rationale: In the general case,
any operations are possible through a UNIX domain socket, including
data-mutating operations.

Cc: Justin Suess <utilityemal77@gmail.com>
Cc: Mickaël Salaün <mic@digikod.net>
Signed-off-by: Günther Noack <gnoack3000@gmail.com>
---
 samples/landlock/sandboxer.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/samples/landlock/sandboxer.c b/samples/landlock/sandboxer.c
index e7af02f98208..0bbbc5c9ead6 100644
--- a/samples/landlock/sandboxer.c
+++ b/samples/landlock/sandboxer.c
@@ -111,7 +111,8 @@ static int parse_path(char *env_path, const char ***const path_list)
 	LANDLOCK_ACCESS_FS_WRITE_FILE | \
 	LANDLOCK_ACCESS_FS_READ_FILE | \
 	LANDLOCK_ACCESS_FS_TRUNCATE | \
-	LANDLOCK_ACCESS_FS_IOCTL_DEV)
+	LANDLOCK_ACCESS_FS_IOCTL_DEV | \
+	LANDLOCK_ACCESS_FS_RESOLVE_UNIX)
 
 /* clang-format on */
 
@@ -295,11 +296,12 @@ static bool check_ruleset_scope(const char *const env_var,
 	LANDLOCK_ACCESS_FS_MAKE_SYM | \
 	LANDLOCK_ACCESS_FS_REFER | \
 	LANDLOCK_ACCESS_FS_TRUNCATE | \
-	LANDLOCK_ACCESS_FS_IOCTL_DEV)
+	LANDLOCK_ACCESS_FS_IOCTL_DEV | \
+	LANDLOCK_ACCESS_FS_RESOLVE_UNIX)
 
 /* clang-format on */
 
-#define LANDLOCK_ABI_LAST 7
+#define LANDLOCK_ABI_LAST 9
 
 #define XSTR(s) #s
 #define STR(s) XSTR(s)
@@ -444,6 +446,13 @@ int main(const int argc, char *const argv[], char *const *const envp)
 			"provided by ABI version %d (instead of %d).\n",
 			LANDLOCK_ABI_LAST, abi);
 		__attribute__((fallthrough));
+	case 7:
+		__attribute__((fallthrough));
+	case 8:
+		/* Removes LANDLOCK_ACCESS_FS_RESOLVE_UNIX for ABI < 9 */
+		ruleset_attr.handled_access_fs &=
+			~LANDLOCK_ACCESS_FS_RESOLVE_UNIX;
+		__attribute__((fallthrough));
 	case LANDLOCK_ABI_LAST:
 		break;
 	default:
-- 
2.52.0

