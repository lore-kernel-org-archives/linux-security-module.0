Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 760BB1F0E37
	for <linux-security-module@vger.kernel.org>; Wed, 12 Mar 2025 21:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741814582; cv=none; b=qs3svHOVpFeVYgrfl2B+UMPTieJ20NmBmuklO2egvlLAybzyy2eGwBJA9EmS0sQJ0p7jb8Xe4lILuUHihqt0mcR+hJoHENb9+PNKbnTWk7O77I9BMOJgHu7mfjmgBdWablTO9aBYOaKUqWnntDcsNs3gnHH3Ba18mCr7ajSLKXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741814582; c=relaxed/simple;
	bh=UQi4jGJd9JPX9q54M13Eyu1joQsCWppMerqI6/F5Zeo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rXM5KKlnIJj7NZovpE2jgPYck/OY6nud9kxWtm9rooN6RVhd5BnA8c0hVTV01dseQHVSwm1qYApjEPKSHJhb+eYFzqN4AJ2SqywXgIUMglvtH0OCO8/VGeotp8EznvbF1VKjlR82hBvqPBxs9WcodjUrKF+F9RGAdM/sS+O9aHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=IvOTjGfD; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="IvOTjGfD"
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id BAD7B3FCE6
	for <linux-security-module@vger.kernel.org>; Wed, 12 Mar 2025 21:22:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1741814572;
	bh=vkBChevR2KYwwFZBDZ6M820pfzcyPKZb2PO3mstNSrA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version;
	b=IvOTjGfDOeV+7+jE5ZqGMXYIHwZItB9xf/HAArSEziIzzlTQNFfUXLiJfjoHChKc6
	 h3iFkco6Pk8NOLVR+QP231nD11eRWUcjQ9PKNf+xUInJihfTnkVW0OF0Vzgbmbrym/
	 ZNi0MWga7/ZvB2PPPfWU8IVqeG8y7B+p1Ky6F3jj4tnmV/Tcg8IUi10X0dz3pdqTUE
	 8T1cv8Rd51VoJNsJEUKXUQFxhuMdap0kCOJBbnLpn1ditlC28yGy6yUGvfzb14UFCe
	 GYhHVDjRU4tnqiyNxAxw7LJN/sg3jrJYUg8oRFMkUEmicM+j5TnNX2uBRYsKDfYiwX
	 un2+Kx6NvCpww==
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-2ff53a4754aso719010a91.2
        for <linux-security-module@vger.kernel.org>; Wed, 12 Mar 2025 14:22:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741814571; x=1742419371;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vkBChevR2KYwwFZBDZ6M820pfzcyPKZb2PO3mstNSrA=;
        b=ZKn7mVHJzbpPxctg2G1NsylOEmC7awOJzQ07wAVKWfpDSf4sSynmG5ibEW/fcuXhHo
         z0UK/mjFrwf8+3F9TjuYY4NAJp6V+NQGPUC9SZbSQOmZ7KN3vmHe5hOjrHxN9LR96L7/
         JIpcc+mr2QeygI/kpbv5+6z8K+uP1QtR+7RH88z42iadS4eKqAQArrB12xq4fD+N1ibv
         MuTSi761A/D7+me6EmrJFtUlnF1trCagN9Ql4ZdW2nbZUDeMfullrTj7fl2Mp73ywRdb
         UJNKyRA8BbCJwYb6AfZ2Jl4FKkKafbpQLX8LkmMRINKYfk/7gQTmWt/shLygYLMvaiH4
         eQ3A==
X-Forwarded-Encrypted: i=1; AJvYcCXyK4iUOj8cV+EnGQixTyXb/tJgFVlOQeVSMNnIvKxZZ9aIfPxlBWUjWVRF0bUAdcT2tPE24nkYmzequpFz0eFlPV6r1+0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxMmub1G/U+JkHOZBodxxsdhxqNUi5ISOCREdefRVRHsSOmHLjM
	oPL+bTU0FCOja74ndyM7fmjglb0wet6ywgKgKJmZ8D4zP1Lbp8mA+dAz2rguyCvN2pH1jeRy6tI
	BG54UiV6cNVVXLYyT4OBn/kTkx9EIBHxxwkgHQT9terxcUEQJYDvFpwPIedCBhYDvzQ/ZOqs63t
	Qjcow1OxVwFytdWQ==
X-Gm-Gg: ASbGnctsQNNTADQ+eEyjLLgKmOcz3G4JH+9YXyIuKvrOm0uTLS7+ldiNqk/TIYIZmQ+
	nk6g5XTF0s5B/tR0M8p3UEJVHW74TsEwdr4ZpUTyyTgXK/lIe+1a0mB8bQi5fFOY3uVYXJeDPLt
	bLxs3ATBdrje3kVpxdgwfebvfiOzgXbDmrD3sWLsRLouaW9MRXUpVHcnt7sK6afuoXPSfHVXNCw
	7GCgkL3G2KRzHSiZGgKkOf9QnXWgbmGdoGKFY6mgBhz+nyUD+nT4YFyFi4K9nF/Ym4rOf1mCaGa
	oG14kfprAgRYFUbDjSMDj8O0Lb/D9LXsy5IHGRsyD6olZ+IjK42Por3DynwV+itpP1NX2nM=
X-Received: by 2002:a17:90b:1b05:b0:2ee:8427:4b02 with SMTP id 98e67ed59e1d1-2ff7cef76acmr32847528a91.28.1741814570801;
        Wed, 12 Mar 2025 14:22:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG2zy2F9PoKbQMeK6fUS3X/Yt717KlC839Q5G4xkP4Nr8/wnDbMYJ8pDxU6TgdAPfQxzzejkA==
X-Received: by 2002:a17:90b:1b05:b0:2ee:8427:4b02 with SMTP id 98e67ed59e1d1-2ff7cef76acmr32847501a91.28.1741814570519;
        Wed, 12 Mar 2025 14:22:50 -0700 (PDT)
Received: from ryan-lee-laptop-13-amd.. (c-76-103-38-92.hsd1.ca.comcast.net. [76.103.38.92])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-301190b98b7sm2353887a91.32.2025.03.12.14.22.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Mar 2025 14:22:50 -0700 (PDT)
From: Ryan Lee <ryan.lee@canonical.com>
To: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	apparmor@lists.ubuntu.com,
	linux-security-module@vger.kernel.org,
	selinux@vger.kernel.org
Cc: Ryan Lee <ryan.lee@canonical.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	John Johansen <john.johansen@canonical.com>,
	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	Stephen Smalley <stephen.smalley.work@gmail.com>,
	Ondrej Mosnacek <omosnace@redhat.com>,
	Casey Schaufler <casey@schaufler-ca.com>,
	Kentaro Takeda <takedakn@nttdata.co.jp>,
	Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Subject: [RFC PATCH 4/6] selinux: explicitly skip mediation of O_PATH file descriptors
Date: Wed, 12 Mar 2025 14:21:44 -0700
Message-ID: <20250312212148.274205-5-ryan.lee@canonical.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250312212148.274205-1-ryan.lee@canonical.com>
References: <20250312212148.274205-1-ryan.lee@canonical.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Now that O_PATH fds are being passed to the file_open hook,
unconditionally skip mediation of them to preserve existing behavior.

Signed-off-by: Ryan Lee <ryan.lee@canonical.com>
---
 security/selinux/hooks.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 07f71e6c2660..886ee9381507 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -4009,6 +4009,11 @@ static int selinux_file_open(struct file *file)
 	 */
 	fsec->isid = isec->sid;
 	fsec->pseqno = avc_policy_seqno();
+
+	/* Preserve the behavior of O_PATH fd creation not being mediated */
+	if (file->f_flags & O_PATH)
+		return 0;
+
 	/*
 	 * Since the inode label or policy seqno may have changed
 	 * between the selinux_inode_permission check and the saving
-- 
2.43.0

base-kernel: v6.14-rc6
