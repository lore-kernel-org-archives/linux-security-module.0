Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C93C61EF096
	for <linux-security-module@vger.kernel.org>; Wed, 12 Mar 2025 21:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741814578; cv=none; b=En/eY50jz3xkSMcIchmMC7l93P/ZCfRPJ8M/KMS9OqNYSXMobppdUu9tzemnlgTnjR7y0+h+Xi6sfAVWGlbtUV4cvtC/1mEk9x4SWGsWT+P9irvJU4tscc6jBagg+WKV/BFz4wGbN0LKz8GRi4Unr9uLEA8jSfe6qv0DHD5mgUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741814578; c=relaxed/simple;
	bh=mvIFvWIp9NnNpqjlb78s7uPPK/9pOen0F/aXj53TS9k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QmTSagEwQ2cU7IJjryhI3JOFUWyBFhPyzJqbMM09M8x+hpEYDNSYrM3xG5Zz/wXzjkMeHK9G+pXNheyYsg61GaqQ+rrZB+63Q/zbPtdYKyOkVXwReWKW2a3uybwC1xni8uofjT3v9RzD7qlD4fu2OXT/AWPA+Z9p/P1FGns/c5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=uI6awYxi; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="uI6awYxi"
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id F222D3F2C0
	for <linux-security-module@vger.kernel.org>; Wed, 12 Mar 2025 21:22:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1741814566;
	bh=JJCUu0nnTlIAwhQtLazst1i1S2GtJ41RAYnP5gniTzw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version;
	b=uI6awYxim82/z5f5cvID+u84PqHGP29jae936qURO6TZh3kPt3VKdd6QkBG0BPfDN
	 nUFwZr5tefTaOWSeS2C1nLfySfDhDJYGEOMPcNLyo1JercStvR0sjcr8JcA3BSP8CK
	 CXfGsdg1q9o4/fLkUpopNjz8jQFiSWePp5XRQ71WBH3tEa46uHhl24Z4Tk0xb6yvNP
	 VGn10AfZCM+I28zcs3gUYpiRDmr/i5RXMMN9X4f7mX78WGGTZha8SQN7PG23HA38h/
	 cJTkaQFJ0AFxLq54T1zwnCLYIE7CCBh9gYTmcOsNK5LZUHECkkY8JzkQWJrF+Y0+Jh
	 h412IuCb3sapA==
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-22406ee0243so3064025ad.3
        for <linux-security-module@vger.kernel.org>; Wed, 12 Mar 2025 14:22:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741814564; x=1742419364;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JJCUu0nnTlIAwhQtLazst1i1S2GtJ41RAYnP5gniTzw=;
        b=DVIuA8iTcq+oYZWAmxCIBcygX8d2MnxT0Ff5qqFmqhwK6IW9hQrzVbhtbbPvYSfmBr
         deeBfqZruTuyUfa1/++gqtvyj8xoIEJMdviQhkdEhkiERn3jQlHjuV96Cga3H9NPBrL2
         lEyTERlZ8BONVJUYDJi1YG9u9lPlFA3AmxuWGL2ru4edmYGyCsQI4Y47Gj0j9G5t3z/H
         v5Stdf9TU6H5pO3GgMX7yBUtFxsVd8ui+DlZxtKrTrYpcFYnBLs1M7/Z6rijkMNnchF9
         GHSTTJTr8s83f6rkOOiP7fPlJzQmiv3rQdWkxBpd7jRxcu6O8lNULenhAEDbE320CPA8
         FNRw==
X-Forwarded-Encrypted: i=1; AJvYcCWKXsat7pKOISCDic/xHaI5PsxiD7xjDAWFjZRImFSxFrFI549dpT561+OPPTEFpaKR/HceNYqrXC23qhxI1cEgf8jMtwc=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywi9BYedKRfc4eSsRTk9Q7Xt7rq6Fvon6sOotP8P/Lq2l9RapTN
	V+ARkks1XRDaMa3rRFPpLpHQbtm292Fwy6vIMA/cbE2siJNyEpSWsdn9jL8nw7I4XajtF4hAVIu
	YBeWXYOtykN4mfwzWNzS4s69/S9P3rbTRNAK7sLDCfirYwrJxfeOEVW+jhTvycYDWh+TmUk7gdJ
	SJ2hbboV/IJ8iSDw==
X-Gm-Gg: ASbGnctlv9abvfvVMJfmGHERWD3iMbOa/y2tAUvdEs6aQVi50rztRiVYqaFEB+/6CSg
	bOjDmLaT29i1zqA6OTctqv0XP50VCvdt8JhTmBAYsJ6gdKUeSraurk6WCxHM13wL6hRlL8J2EjJ
	EIf7Sm5burDlHu70NK3jEGbwyj5ZssSrZOP1ezwGLiBbdyKjzqOdrxe8fXS7NgrrDJ5Qh9pVBJg
	hxZp1XAaP6xf095NfuTb0/ismUeI6LgI1l8nrrxjDFnjPurjEidzIRzmZuJYDpoFNUev+6rX0Cg
	H+v71MtEz5uybPR1qkgtfV1wrrNxrT1UY5M5Eq8d9+9mMHIbuMcgAqm0GE4z/i08lJ9rXXk=
X-Received: by 2002:a17:902:ea07:b0:224:a79:5fe4 with SMTP id d9443c01a7336-2242888681cmr334106855ad.2.1741814564404;
        Wed, 12 Mar 2025 14:22:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFjVvzREwSOFKw0Hfsl/h89sadLsPdTTQZ/I/XFETV/GwxC6RNVuLWxGdk5FbZ6Djc3RCsmNQ==
X-Received: by 2002:a17:902:ea07:b0:224:a79:5fe4 with SMTP id d9443c01a7336-2242888681cmr334106495ad.2.1741814564101;
        Wed, 12 Mar 2025 14:22:44 -0700 (PDT)
Received: from ryan-lee-laptop-13-amd.. (c-76-103-38-92.hsd1.ca.comcast.net. [76.103.38.92])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-301190b98b7sm2353887a91.32.2025.03.12.14.22.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Mar 2025 14:22:43 -0700 (PDT)
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
Subject: [RFC PATCH 1/6] fs: invoke LSM file_open hook in do_dentry_open for O_PATH fds as well
Date: Wed, 12 Mar 2025 14:21:41 -0700
Message-ID: <20250312212148.274205-2-ryan.lee@canonical.com>
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

Currently, opening O_PATH file descriptors completely bypasses the LSM
infrastructure. Invoking the LSM file_open hook for O_PATH fds will
be necessary for e.g. mediating the fsmount() syscall.

Signed-off-by: Ryan Lee <ryan.lee@canonical.com>
---
 fs/open.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/fs/open.c b/fs/open.c
index 30bfcddd505d..0f8542bf6cd4 100644
--- a/fs/open.c
+++ b/fs/open.c
@@ -921,8 +921,13 @@ static int do_dentry_open(struct file *f,
 	if (unlikely(f->f_flags & O_PATH)) {
 		f->f_mode = FMODE_PATH | FMODE_OPENED;
 		file_set_fsnotify_mode(f, FMODE_NONOTIFY);
 		f->f_op = &empty_fops;
-		return 0;
+		/*
+		 * do_o_path in fs/namei.c unconditionally invokes path_put
+		 * after this function returns, so don't path_put the path
+		 * upon LSM rejection of O_PATH opening
+		 */
+		return security_file_open(f);
 	}
 
 	if ((f->f_mode & (FMODE_READ | FMODE_WRITE)) == FMODE_READ) {
-- 
2.43.0

base-kernel: v6.14-rc6
