Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42CA8278E5D
	for <linux-security-module@vger.kernel.org>; Fri,  6 Feb 2026 15:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770390742; cv=none; b=gFfLTcWOoH7gzNSgHbjrFJQOoF2iF08lN84HB3X1zWCf+1TXczyvs8St6nDFYh8MF57a+Al9jfLDVMMQ/g2xfotGYW+B+1Hd92od1sd0IdAxIv4CiEDwJ4OmXv+AYYpZpJsXx2hIsIwgZoevoVyRvlO4Z++WmNO+QvGI68Wc3U8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770390742; c=relaxed/simple;
	bh=RH7lN2zEIpxzpr2H2DCJe7zo67+IC3mdDT5FekKAZKA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AwqSQakdCpXBEQfgwy8Z1eFuMLG+/F8IvoTTIDM/6DQjkT6R3Bfdgmaade78RoqFfY/ypn7UwDrdGfFGDVQgesW3t8jMcSfVKO+5amySq722RTUf2gM+3JmOfj7h8MmuaY/DIZE5M1pX7nO7ryJ2uGaaI6UfaepkpHaLub5jOqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CIgwpUjd; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CIgwpUjd"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-48069a48629so20367425e9.0
        for <linux-security-module@vger.kernel.org>; Fri, 06 Feb 2026 07:12:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770390741; x=1770995541; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VOKPHTIgtmdo60AgER0JbFBoUit1uTJcLtrJahXjLXk=;
        b=CIgwpUjdMtCXR4aLqrS67FCEfHQAoEfi4eEgMmpZ4s3PO3jh6KeapGUuJUYeyhsOxf
         uZNLrjd8qa3JQ9KXbTSgZvI/Rp7UniGGRTXRoeyAydyfbvU5yxEJ3oZuIHmROOnp389l
         x+usUntnr8CxKG6upsMQqHutscSWGWvaov2WPeYhBBuHuIJ2rXXB1YwVNGiVCwsLhKzm
         Ho5rI8aVPr+cvQqcO+tdWEs1GPrSgHj0TX7faJ/y8ulEZocjRT6OcYJWgoy2Xox5Isti
         Eth+eN7Fds1q3nXsrGjPEZOPrlyI6bM4G+d6LUymXGvrl2Aa23G4B8EpD7iSbgbsfs1V
         MhNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770390741; x=1770995541;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=VOKPHTIgtmdo60AgER0JbFBoUit1uTJcLtrJahXjLXk=;
        b=Qqb3wE1T13bwX8ZY2NtS9LYADEXIyfPx0qSI+mWe228D0qN+R8F0HA1W7OSp6wY9GO
         ORFbQAP5xy5wV9kEFAsoFk0i4+SRlX7y+1jMi6I9iExBD2GdzdmqIoRONEYvng6c7uX0
         YCsjCGbBQFGMkwYlj1Q24V1fU3LcbVIedS8aNgxmCL7C1UXQe5KCt0nDtQb1hpu1sZLm
         EbYjPQyLGrBzbEZVLNZ+BG8JpeNc0OsWjYEhDYwM/HhN42XVBD6vOmvp97DvkIT2PGM3
         kkHxNk/LK3LtV25li5RiZGdnDSsZ9YFLLgDRN22MTs5pJMPo9nSwMfJ3KQ9mWkzdpooD
         PAdA==
X-Forwarded-Encrypted: i=1; AJvYcCXJcy1LrINJPtQ/aybzsUZzZy9NHxtdlbkW0GOuqZls0cObfdz4a+5wRBjHN6DobEM/d0vNcaExPkbO/tWQEl5CojvAdC8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3VHTtUHoAbvoTv+HCBMeA5FBXrdKJC9VD475eKnffhGifzg0e
	Ox8+LLjrSxHLpYm4N8s7hBEzzCP0ooWtEUFtyc4RN18Aq2XU2nad9nYf
X-Gm-Gg: AZuq6aLTqlm6PmBFGhvGZO8nMjZ2YKejGbkot/TO+oES2EN/G9JwAe8tnWzbrLTHlHS
	CkCQ22dnXrc3FXOV6o6RkHyuyU+pJfp5ooytAjQOqCQ0pn7UIgOVjYaZ5UM8vrkwHwsG3PCyD9q
	Fjm3+jXSTh/1ahrTZhOlpwH4UkoiMyyfYnCCpN7o0mPG23Zy0f1o96tRmkDvcpjWSCyp2VBjWny
	uPXkmRHr5c4gUIMEykEqQsx8o7jn2Fa80ns0aDkgMF0CRsjKOHU2W43zi7Ha6qvQmN8PmnUpaih
	J8xfrXPGW/6SOp0ePoduW6txGHJ/ljUHWGaYzbbaP4desKoSdSwQL0acbyuP/YEN+F6tsr9m8vk
	Wlq/sjfcDewQfhk5AfERuwHk29ggjki7TFCrwBtrl1l5X49piMwUgaWTJ0z4Amrv5OJYw5cJMy1
	j+bVwDQjPb60LNlPkOUhtGC6boRiFjga3lJWhymkgiEco1BI4=
X-Received: by 2002:a05:600c:4689:b0:477:7bca:8b2b with SMTP id 5b1f17b1804b1-483201e4b31mr45485815e9.15.1770390740352;
        Fri, 06 Feb 2026 07:12:20 -0800 (PST)
Received: from localhost (ip87-106-108-193.pbiaas.com. [87.106.108.193])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48320410b78sm34632645e9.2.2026.02.06.07.12.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Feb 2026 07:12:20 -0800 (PST)
From: =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack3000@gmail.com>
To: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
Cc: =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack3000@gmail.com>,
	linux-security-module@vger.kernel.org,
	"Tingmao Wang" <m@maowtm.org>,
	"Justin Suess" <utilityemal77@gmail.com>,
	"Samasth Norway Ananda" <samasth.norway.ananda@oracle.com>,
	"Matthieu Buffet" <matthieu@buffet.re>,
	"Mikhail Ivanov" <ivanov.mikhail1@huawei-partners.com>,
	konstantin.meskhidze@huawei.com,
	Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH v3 2/3] landlock: access_mask_subset() helper
Date: Fri,  6 Feb 2026 16:11:54 +0100
Message-ID: <20260206151154.97915-4-gnoack3000@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260206151154.97915-2-gnoack3000@gmail.com>
References: <20260206151154.97915-2-gnoack3000@gmail.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This helper function checks whether an access_mask_t has a subset of the
bits enabled than another one.  This expresses the intent a bit smoother
in the code and does not cost us anything when it gets inlined.

Signed-off-by: Günther Noack <gnoack3000@gmail.com>
---
 security/landlock/access.h | 7 +++++++
 security/landlock/fs.c     | 4 ++--
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/security/landlock/access.h b/security/landlock/access.h
index 7961c6630a2d..bab403470a6c 100644
--- a/security/landlock/access.h
+++ b/security/landlock/access.h
@@ -97,4 +97,11 @@ landlock_upgrade_handled_access_masks(struct access_masks access_masks)
 	return access_masks;
 }
 
+/* Checks the subset relation between access masks. */
+static inline bool access_mask_subset(access_mask_t subset,
+				      access_mask_t superset)
+{
+	return (subset | superset) == superset;
+}
+
 #endif /* _SECURITY_LANDLOCK_ACCESS_H */
diff --git a/security/landlock/fs.c b/security/landlock/fs.c
index 8205673c8b1c..aa8e7cddb929 100644
--- a/security/landlock/fs.c
+++ b/security/landlock/fs.c
@@ -331,7 +331,7 @@ int landlock_append_fs_rule(struct landlock_ruleset *const ruleset,
 
 	/* Files only get access rights that make sense. */
 	if (!d_is_dir(path->dentry) &&
-	    (access_rights | ACCESS_FILE) != ACCESS_FILE)
+	    !access_mask_subset(access_rights, ACCESS_FILE))
 		return -EINVAL;
 	if (WARN_ON_ONCE(ruleset->num_layers != 1))
 		return -EINVAL;
@@ -1704,7 +1704,7 @@ static int hook_file_open(struct file *const file)
 		ARRAY_SIZE(layer_masks));
 #endif /* CONFIG_AUDIT */
 
-	if ((open_access_request & allowed_access) == open_access_request)
+	if (access_mask_subset(open_access_request, allowed_access))
 		return 0;
 
 	/* Sets access to reflect the actual request. */
-- 
2.52.0

