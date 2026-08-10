Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DE7835B634
	for <linux-security-module@vger.kernel.org>; Mon, 10 Aug 2026 09:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786355499; cv=none; b=QsP0cIYlytW7So6adsp8vBwfNUrDjSvldwGtLO948KLaEYSKVF0BjSNJEiG/ZrsWpzJlBI9zBaAFjvl5p5X9FtKr1sqXOLJRRknTbww9cscDsQrwWouzxCyr+W3yNMLO2efcSDgCnNKCeOzdmE05OiUYm7lGF+UFpMZd1s1uT40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786355499; c=relaxed/simple;
	bh=nvniQgPA+fhZfF9wwnXTCMn46BvjL7y4quRh2Zwb/uQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=A0UjA+cI8q5euT0T9uLjyxsoVOE8frXgKeOilDBLjH/hGwtrViZwe4x4tTrl5QQwVYEf8rQWArOYmeBLCS1M6SPap7BvLogu1nERPHZDxQFvmlIWFqQz1gkFSg3idzM1kxp+hP5264TWvORYeDRvunYYNzJoJBY4bZ0HK0Zr6lc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NsYH4Jca; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NsYH4Jca"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-84536ecfc5bso1630452b3a.2
        for <linux-security-module@vger.kernel.org>; Mon, 10 Aug 2026 02:51:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786355497; x=1786960297; darn=vger.kernel.org;
        h=content-disposition:content-type:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wA+cmO7SoKemRFZ6sHEtBKqAxv5tHrt90NEorSG0nJE=;
        b=NsYH4JcaBwx38XMscIzS6lfaGI2UfPEnVfaC0QlD+ht9eM5mCFU5KhKBQAzqdOjqku
         1ya+V+8T9OgBtqmJogj+mWDrjcxBpzm0suU8ytjI/NuyfsqCXDYULc1kE0AfCDFKllAm
         7FgLuTdCs/GYcwqsptJUwO0EZ4sZ/k6vy3y2jpXeCLpfBJSxh31ElL4nW2kjc9mYlQrI
         6Okzrx60ROJvX1VONHQ2rgu5fOCqu+qodlQ0MqXXCH7rbWU2H+uFcVbxWPXeikwLNQ7O
         /0o1phhfm+a1vnxHKRKN2nTX3clBlnnrJotKtjRRTNYd5FG4TZVcRfTsvYd9zx+AXUh7
         QQZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786355497; x=1786960297;
        h=content-disposition:content-type:mime-version:message-id:subject:cc
         :to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wA+cmO7SoKemRFZ6sHEtBKqAxv5tHrt90NEorSG0nJE=;
        b=TnuQ6l4BXpPe37GQY3WnuCAyAVUdj3SQ02EuKI0tIyyAe8CzPO7qDBAgCxZgOYDIIb
         /m/BFHcPirDG9QKYLlOvolwOc4xQlkp31DqzpyJo8PDZW8i3JtmohOPb/qfAjaMLLKjc
         FObEXqnHVqdA3Qonc3dm8nMvJS8veu1Wab982WsRkCJDJuqBGDTfZnijmHsA/emwyc1f
         o8nDg62Qk0eHv4W7dCReSMIP4+IKugCjr87i3PH0EnJgvZHGoCcp8EzICIp2nEW/azfM
         L/Jb1xuam8a60zozT2SEP3iwbSnrS0XiJ+KbJu3nRoq1wVlX5fEFtuFy2eGzd5cSm9+h
         fK7w==
X-Forwarded-Encrypted: i=1; AHgh+Rr0CYzl5oppJSHUI3neQ0JuqVrGJ63K1FMD+Mld4VUgkkURtDrZThp2zVjoKqPf00tELtn0qjOQV5fbc/GrMC/5F2IrbCg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWWlbf5oRsCxQUQ3PYK1EpHZmhlTp2BEotLFfYRcvOU3vil27F
	r//oV5FUaOtJ0CkhnMOkxDWxVt6N2W4LMRwxi2clRg2iBfocU+rc/ob/
X-Gm-Gg: AR+sD11pvtAUF4yTrvHkGzmDDdpJZHSYuxbMRgbq5hLxOZ8wdD8hEjNX/6F5GeMNqe7
	YZE+OXmdjwWdguc03eEWcxIdCsayy+JzTIxV53TjnsHmLyG+XltPeyJzJ2xJ7wI0A9WJpLh0YUy
	BtSJq2Vypsmvz5xTtWoCyhq1kP94d+abtQOvF3U4BAYWyE8Brp6kuTxokXps008/FkmYEBq4fEj
	7CsKUWkkmrkdCkafVpeKtXbWwBUFBziFUPyD0y7DUa869q+G6e7gm4007JR4Lk6Z2dn1zhNk/2d
	8IzG6NZ6f6cOPPD5DaiSlwTTU5zVs/xmWWDnSh27wuIB+iXA/gwh8toHJlj0M9AxEbz8DnYeDR1
	ky/UgKZELqjSEUyqWVj3dd+zur1uGGlsScCalZ0TEVrmKqZs7qr/mLbOfL6p9RKC31jXQLTm4C/
	elJ5798SxfCOEO2svQyfMnL934nupEu4cxZZ0OW/Tv5kBOajPn9MfOns5bOS21jvvfEICkI4vV2
	ib7l8g6
X-Received: by 2002:a05:6a00:3486:b0:847:9aa8:d3bb with SMTP id d2e1a72fcca58-84f694910cfmr20417057b3a.12.1786355497510;
        Mon, 10 Aug 2026 02:51:37 -0700 (PDT)
Received: from v4bel ([58.123.110.97])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cbe8f1af985sm3689439a12.11.2026.08.10.02.51.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Aug 2026 02:51:37 -0700 (PDT)
Date: Mon, 10 Aug 2026 18:51:33 +0900
From: Hyunwoo Kim <imv4bel@gmail.com>
To: john.johansen@canonical.com, georgia.garcia@canonical.com,
	paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com,
	maxime.belair@canonical.com, cengiz.can@canonical.com
Cc: apparmor@lists.ubuntu.com, linux-security-module@vger.kernel.org,
	imv4bel@gmail.com
Subject: [PATCH] apparmor: fix out-of-bounds write when null terminating a
 label vec
Message-ID: <anmfJev64DOumiA9@v4bel>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

aa_vec_unique() null terminates at vec[n - dups] when VEC_FLAG_TERMINATE
is passed. If the components are all distinct no duplicates are dropped,
dups is 0 and the terminator goes to vec[n], so the caller has to provide
room for n + 1 entries.

aa_label_strn_parse() sets up its vector with vec_setup(profile, vec, len,
gfp) and then calls aa_vec_unique(vec, len, VEC_FLAG_TERMINATE), but
vec_setup() does not reserve the terminator entry. Up to LOCAL_VEC_ENTRIES
it uses the local array of LOCAL_VEC_ENTRIES pointers, above that it
allocates exactly len pointers. The terminator therefore lands one entry
past the end of the local array when len is LOCAL_VEC_ENTRIES, and one
entry past the end of the allocation when len is larger.

len comes from the number of "//&" separated components in the label name
and label_count_strn_entries() does not bound it. An unprivileged task
reaches the parse by writing to /proc/self/attr/apparmor/current or through
lsm_set_self_attr(2), both of which go through do_setattr(), and the name
is parsed before the change_profile permission is checked.
The query_label() path behind the securityfs .access file, which is
mode 0666, performs no permission check at all. Every component has to
resolve to a loaded profile, so a system with policy loaded is required.

The other two VEC_FLAG_TERMINATE users work on a label vec that
aa_label_alloc() has already sized with "+ 1 for null terminator entry on
vec". Reserve the same entry in vec_setup() and DEFINE_VEC(). Passing
len + 1 from the caller instead would move len == LOCAL_VEC_ENTRIES out of
the local array and into kzalloc().

Fixes: f1bd904175e8 ("apparmor: add the base fns() for domain labels")
Cc: stable@vger.kernel.org
Signed-off-by: Hyunwoo Kim <imv4bel@gmail.com>
---
 security/apparmor/include/label.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/security/apparmor/include/label.h b/security/apparmor/include/label.h
index b5a722a47fd2c8..37cb135de32320 100644
--- a/security/apparmor/include/label.h
+++ b/security/apparmor/include/label.h
@@ -23,7 +23,7 @@ struct aa_ruleset;
 
 #define LOCAL_VEC_ENTRIES 8
 #define DEFINE_VEC(T, V)						\
-	struct aa_ ## T *(_ ## V ## _localtmp)[LOCAL_VEC_ENTRIES];	\
+	struct aa_ ## T *(_ ## V ## _localtmp)[LOCAL_VEC_ENTRIES + 1];	\
 	struct aa_ ## T **(V)
 
 #define vec_setup(T, V, N, GFP)						\
@@ -31,10 +31,10 @@ struct aa_ruleset;
 	if ((N) <= LOCAL_VEC_ENTRIES) {					\
 		typeof(N) i;						\
 		(V) = (_ ## V ## _localtmp);				\
-		for (i = 0; i < (N); i++)				\
+		for (i = 0; i <= (N); i++)				\
 			(V)[i] = NULL;					\
 	} else								\
-		(V) = kzalloc(sizeof(struct aa_ ## T *) * (N), (GFP));	\
+		(V) = kzalloc_objs(struct aa_ ## T *, (N) + 1, (GFP));	\
 	(V) ? 0 : -ENOMEM;						\
 })
 
-- 
2.43.0

