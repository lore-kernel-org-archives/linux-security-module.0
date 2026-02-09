Received: from mail-oo1-f52.google.com (mail-oo1-f52.google.com [209.85.161.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 473193064A0
	for <linux-security-module@vger.kernel.org>; Mon,  9 Feb 2026 21:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770672115; cv=none; b=lgrAGIgUMGjMERIvQCjpgz8LFFpQ6EdW2d4pESxMWIlzlVk8uTNkSJXtdFv+E8Lpru+He8nZxyNPhbI4cA4G3YPkpJXyGRcR2coL3rEN7DZWsrKdYaHFgTDWNN/90nmEXEhUJ/QWk3z2Q+e964V4wI6FMyAbCN/YZMkMnVa1EUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770672115; c=relaxed/simple;
	bh=E44D0I52YoGh+U5fwPkQ5hEITkBV+sZorQSKCWfktmc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=R57amnqquyensQdlFEuZJaZ5RHomq/S4Ixizv9lUCX5LlkjAgnA+X68s/3iQM4eE7NnTV/J/YzB9IHLelT+s+1R+P5XqbRwH8P5VcIk+sNQLlZZTzgKX4ozuQnhEAV/8bt2eh4Kv2dk8maaQF/Pkv5e0KGW90OV0rfWAbuRrISU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=UjWsGNw3; arc=none smtp.client-ip=209.85.161.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="UjWsGNw3"
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-66314fa03c9so3058203eaf.2
        for <linux-security-module@vger.kernel.org>; Mon, 09 Feb 2026 13:21:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1770672113; x=1771276913; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=B8RijGQOfqPIwUgELzLaWOi9LUBjEfJ1NBk4LJfVwV0=;
        b=UjWsGNw3GBANp1Ibh+JJia1OeYMnwWi09DWePej20aQMtbCT1fXT/G24nTO6bGhMmL
         SwIJ6FnnfZ4gofxXO0Xd+VWhVCl71k753SK+tXn6CJCqBdciNTdsP8zHaZCoK9XcBE6B
         RXQkqkxqXWNycwtMRR5rkMvfaBb2cZXJhej9zxrOzsn5O98IpiL44p4HVs0yHSp7UBXE
         5dQ7rF51s3JaL9ZWDJ/WfSZ7LJ1zGoIfvTm/WtnEt+zMixPEzcKgRQd6kfn9R52XvMnn
         GJi0Fm6RP+TfOCK6hwxUgrtVOHTzlytSVIRORoUdjQxqfQ/4OEaaykkckgbTO6JhTO6o
         6bEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770672113; x=1771276913;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=B8RijGQOfqPIwUgELzLaWOi9LUBjEfJ1NBk4LJfVwV0=;
        b=TuNlDjsWyugNgg5yAyBBFEuk8oS52p9x1E6kfQb2+t9zA/N3jxiit3oyQ36rCZi7V3
         oAaziSwNDzldZqIbd1DysVLi/KTeJI/7+3tJFtaz/m3RThPCWu6sKXn6RwqOO+6VkOag
         Jl40j5zA6D24/B5ev3xaD5ZZI8eAa04WYsxyTqD95kZBXK8AhNgivt8PZho91ajGVoRk
         4HTeuEdimuM41d1aQ/7eCb8CMyfHByJTLGwg07h0Fe9aCoxOXMuiR2US3imIM/5N4zX+
         DBxi7FgYi9CsDLglnOvxBL3DNsouMkQ1uE+arW6uzky+nYA4tzCLLr/dhXfWvYi3Tfha
         YHXA==
X-Forwarded-Encrypted: i=1; AJvYcCWxqmlyJjtGfofS2cNKTV/jXqjQ5CdQGmqhXiBH7tCZfwh1VAOEVTKY0MaUA1U7g8AC5owGI3o+s9Q7de2KmIpC6RRT++8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxtVh3hn6xy6m/MHQ8gF9j5ODUbT3F8CqoYUhHYdmlM4a3qNH9y
	Kbl4kyp5LZy3RpMDywvgpIG1sSmFIpl5bXs7e3IK6335RSO2wlWggB8MGNLzMldV1D4=
X-Gm-Gg: AZuq6aJZTPOoy2Zg7Udkk68KIcFbjifddNr2g1ZMCazh3xH/M9asbPwDj2h/jIhzV1I
	0NRbTmXLgAcIJx6F6nOwsnLWCbm+4Cp71bgx/GKXs76PClyxjetB6+0H/SYOh9DNG3swdPzhFZb
	KIE2lMpau4r863TJMe242BNIUp+0Jc7+EH3yG57y5J2MJOCrYQYCGdwaos5kBNzo/G5ShVrTCzq
	S2zb5B5LaZlbMhSUn2Ax3PEuMGWs573skjEYECN3SpMntp/2yCEexSe1wA9R5fJQMe62yXqJFg6
	4vbKuhIXDZQJocp1KypxCnxeczVie9yAWWxNI3R+jc+Ca6kX1MsaXa5vgsPFrMz9VM5O+jMMDoJ
	k3aAWGqBzJjj9olpM+AgRTtD1aEOHPn01iqRcz9b9wjKZylCJHzEOh6CJe5lxAPz6uLu9urjZQA
	==
X-Received: by 2002:a05:6820:602:b0:664:685e:76b3 with SMTP id 006d021491bc7-66d0d205325mr5909878eaf.73.1770672113246;
        Mon, 09 Feb 2026 13:21:53 -0800 (PST)
Received: from [127.0.1.1] ([2a09:bac5:947d:1b37::2b6:46])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-66d390b935asm6591730eaf.5.2026.02.09.13.21.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Feb 2026 13:21:53 -0800 (PST)
From: Frederick Lawler <fred@cloudflare.com>
Date: Mon, 09 Feb 2026 15:21:48 -0600
Subject: [PATCH v6 1/3] ima: Unify vfs_getattr_nosec() stat comparisons
 under helper function
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260209-xfs-ima-fixup-v6-1-72f576f90e67@cloudflare.com>
References: <20260209-xfs-ima-fixup-v6-0-72f576f90e67@cloudflare.com>
In-Reply-To: <20260209-xfs-ima-fixup-v6-0-72f576f90e67@cloudflare.com>
To: Mimi Zohar <zohar@linux.ibm.com>, 
 Roberto Sassu <roberto.sassu@huawei.com>, 
 Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, 
 Eric Snowberg <eric.snowberg@oracle.com>, Paul Moore <paul@paul-moore.com>, 
 James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, 
 "Darrick J. Wong" <djwong@kernel.org>, 
 Christian Brauner <brauner@kernel.org>, Josef Bacik <josef@toxicpanda.com>, 
 Jeff Layton <jlayton@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org, 
 linux-security-module@vger.kernel.org, kernel-team@cloudflare.com, 
 Frederick Lawler <fred@cloudflare.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1964; i=fred@cloudflare.com;
 h=from:subject:message-id; bh=E44D0I52YoGh+U5fwPkQ5hEITkBV+sZorQSKCWfktmc=;
 b=owEBbQKS/ZANAwAKAasltHYDktNtAcsmYgBpik/tn6socxTvLoAVUKBxgks8JYngsmEQKClzr
 9PM/m9505aJAjMEAAEKAB0WIQTLNBqMVmu1PHvjOe2rJbR2A5LTbQUCaYpP7QAKCRCrJbR2A5LT
 bWf/EACRQr5bwV3DkSeYkjepPfCow9f0Jr7heeQz7lqiKJFOsMCSFCDBhJYOA23nT2Ea77SUlPe
 m/Uwiv9MG4ys0RaFvnPwtTDrVX4CUwWZrq1qaCadNlL8gfnJrHOHiwRFMkJjE5Ac332XRK0lcIX
 W7cuICWBzOZE5PI8KIwiijeL9ZAUDcGMYNu5FkRK9MkLSU5hyOr9vDqTi6o18TR2J+/FO+uCAss
 ZpKWlVck4xy821WwrgLUfCMZfYWkRd+Y2H//r7GA3Ve2/Ya25h34L9RKxNaJbmrjluV+sGhQHrT
 ELDCW2TA1MMLooG8qd07MN0LoajUHEO9amvBMOX3pdbl7okt457Ogc2GdKquP31STJFmhlJI4mz
 WulxzkC9LhFbzrCdVs2ZiJEufNxPODo1aZOs4MBqE/CT4O0m4lpCxFIGUe2cMEDCAQWXSr/bP4X
 oRIIMdOvZXk4jaAWUuYv0r9cZhQjYryDRFNop1Yxk7rne23EOLA0CLm0gWHQU6FxxiPJx908WIH
 cbH28KD9pwJ2zmsR+IT9KZUayWzkVlxTOPWRG8v0LLYSaVjoCKdN5WOAMWs2WNfOFWZvN7XR9Vd
 Dc8UZiu0RoEkK88tfAenmAtq78oIW4WDIt2XUPLV41BIG+H/ejmvtjckxEN54W8W3ugoKLlA3he
 PfKIr1+nk/S8j5g==
X-Developer-Key: i=fred@cloudflare.com; a=openpgp;
 fpr=CB341A8C566BB53C7BE339EDAB25B4760392D36D

The logic for comparing kstat.change_cookie against IMA version is
hard to read. Abstract comparison logic into a new function
integrity_inode_attrs_stat_changed().

No functional change intended.

Signed-off-by: Frederick Lawler <fred@cloudflare.com>
---
 include/linux/integrity.h         | 11 +++++++++++
 security/integrity/ima/ima_main.c |  4 ++--
 2 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/include/linux/integrity.h b/include/linux/integrity.h
index f5842372359be5341b6870a43b92e695e8fc78af..beb9ab19fa6257e79266b58bcb5f55b0c5445828 100644
--- a/include/linux/integrity.h
+++ b/include/linux/integrity.h
@@ -49,6 +49,17 @@ integrity_inode_attrs_store(struct integrity_inode_attributes *attrs,
 	attrs->ino = inode->i_ino;
 }
 
+/* Compares stat attributes for change detection. */
+static inline bool
+integrity_inode_attrs_stat_changed
+(const struct integrity_inode_attributes *attrs, const struct kstat *stat)
+{
+	if (stat->result_mask & STATX_CHANGE_COOKIE)
+		return stat->change_cookie != attrs->version;
+
+	return true;
+}
+
 /*
  * On stacked filesystems detect whether the inode or its content has changed.
  */
diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
index 5770cf691912aa912fc65280c59f5baac35dd725..6570ad10887b9ea1172c78274cf62482350e87ff 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -201,8 +201,8 @@ static void ima_check_last_writer(struct ima_iint_cache *iint,
 		    vfs_getattr_nosec(&file->f_path, &stat,
 				      STATX_CHANGE_COOKIE,
 				      AT_STATX_SYNC_AS_STAT) ||
-		    !(stat.result_mask & STATX_CHANGE_COOKIE) ||
-		    stat.change_cookie != iint->real_inode.version) {
+		    integrity_inode_attrs_stat_changed(&iint->real_inode,
+						       &stat)) {
 			iint->flags &= ~(IMA_DONE_MASK | IMA_NEW_FILE);
 			iint->measured_pcrs = 0;
 			if (update)

-- 
2.43.0

