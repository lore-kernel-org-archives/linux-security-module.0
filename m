Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4633B1E9B3E
	for <linux-security-module@vger.kernel.org>; Wed, 12 Mar 2025 21:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741814577; cv=none; b=KwcXxxWINkf1XGRdxW5AKtTGawF16SebK4XecKi1SYWXJS9CJt8BTea9+Sz/hOn3tXkMsaFeybO2R8j4iIaCRr/gZEdVtwFZpFL20MKYOmdt7xgMYfEkKKh70Aiogktwd2RhGMAu54SCJXTGTSHuHKRNYDTY2uGDrehD/jQElso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741814577; c=relaxed/simple;
	bh=6cBhe/0J0x7XG16Ij8KWWPYPemaK8pVTxylYk+O6p0E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=H7hH8QYwDxwuF7I+1b1KZsZxV8z1MaPKEhuzKfkTs7wRi/8P+s6NNWRCXvUXNtBl11sDGvO92RCMn9lFJxNu++XiPa/jyYS2ZikN9cl3LUJaeqvujAGGPmvj58zoCeIMogWviTh9NOPjHWUbSj8ic4H3F0d1f5Tgpj3VdX9fES8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=HyGcuxw2; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="HyGcuxw2"
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 5E4363F6FE
	for <linux-security-module@vger.kernel.org>; Wed, 12 Mar 2025 21:22:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1741814564;
	bh=UYHE7PfrFzAetCRzPVVNsPinECVfo2Zm0WG/ZDMIyJE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
	b=HyGcuxw2WVxK/+P+1a2tGfC211wxeIptyQto0MTo4Sz9qbVXStMHLM2LBYKqURoZ4
	 Kt6NIVGWWeBnbQPly22DDz8P/GIOqyfZtXTOoeAQ4s9zZ94OlLVVWRVRQ4JTDk1CvM
	 7mQDw/D2kdsZWkaCOKWkge0kTLkaIbV4zVrAe2TiS8C02wvmAMTDKh9WVXqkJSn/ih
	 BI5ql+kemD+hEhJ1x8C8Fa3ymBY5dOFmjZ3hHil4LO+IoHLfCyYsnDWfQ+FlLpgZHf
	 NCoGoPvS5xChb/hZkKfyvGAgKVSl27unjlQjSu6YIxFiqmqlpmAvTHPgTqjjGVqJpK
	 MWJtuVMZOMA0Q==
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-2ff798e8c90so478550a91.1
        for <linux-security-module@vger.kernel.org>; Wed, 12 Mar 2025 14:22:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741814562; x=1742419362;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UYHE7PfrFzAetCRzPVVNsPinECVfo2Zm0WG/ZDMIyJE=;
        b=ipYMc+71uldPbAtjuOmqM56Q6wDMsFeeggWN/+nA75/ScA42K/ePfcRUzJ+8Rxm/5/
         gxuobhxb50iKR0ACkm0cjGXvWP3FxbmP55ZmlfLz8Tjgdldq6WlAXiVe3ts+0bxGObzi
         Ye0f8pLj6/px24mXExtKxg13wOTv4VPzQSf9c560l+EQW1OP2AQcvyeVXySHK5i60Xjn
         Kdgk0jLnWA1Ec8WLTPggI30A2WI7vJaVi4NkbkI9dui6N3XUSHq3c25p7OvDpYxLJayT
         txV7vWK8rfFSA/gjRcsPd4IQRxqzWPhzdgBsvmW85KDLsrozKBjmI+M8LhJujHr+aEJJ
         AlnQ==
X-Forwarded-Encrypted: i=1; AJvYcCWL49gbRJN86BBdJnqh8Wn2BEXR9ZsIHzW00XRee+RTkpefZZO3Xagz22Cntm/R6LXrlUfSMCKE8MROjKMSi8fnG5zvGKE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzTqszXXGPHs70dAzWEf1RPzhtTytpunsMv8W6mv1D/THZH0/Zc
	wb4n/QVTaOoasVf/x9uvBRHQnckxF+sGWWl766xMbabbhW642U4mHdwbpvioe1zIKkxfi8peCvz
	nC5qth3e4rNCARCVYdrFHmveS24TN3vaJbg2eSLxxOXybMQODAKFlMDEN4QoqWQ3gQJPZ+5aWcj
	qAaiTZhzGVbk90GA==
X-Gm-Gg: ASbGncv4wNqYdz6ozsehF6U026Ik5TLzHcbMbRy/XZbzrvNc3KWvFOqdvbP2FRHgbrV
	MAZLsn2uLYDYmsP4G6Qer79tztT/QQMEekKSMtNviB0bd4VwExYLRBTKJq94vqp+aBkG1qWZp8s
	w7+QHHT/cC9tit7aKqVwdwwJy0+n594Hxq2wDI96lDmkg1QRMttcnMzV39AVsdy5O3hf2QUAFR3
	Va7NH5mXXE8KufRPXPBpB7lTJtdbl4Uh7+8bN0sdQ2eSsCzXq91SYYsk/tDVbMMbVLhULOnc7Lr
	9xsfkD2EbrY+8IR1UDRK942Hrf0QLE82/2ms43mC0szqnl2q1chV18AMqOXqBNXM3HGhb88=
X-Received: by 2002:a17:90b:1d8c:b0:2ee:f677:aa14 with SMTP id 98e67ed59e1d1-2ff7ce6ff9dmr33955131a91.13.1741814562177;
        Wed, 12 Mar 2025 14:22:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IESqd74aQLaRYMlhUC52mOCTMPtX58VJpqPHYNlhWsmVgCtfWUR4bux5MtYAMon8vBiSS29gA==
X-Received: by 2002:a17:90b:1d8c:b0:2ee:f677:aa14 with SMTP id 98e67ed59e1d1-2ff7ce6ff9dmr33955108a91.13.1741814561871;
        Wed, 12 Mar 2025 14:22:41 -0700 (PDT)
Received: from ryan-lee-laptop-13-amd.. (c-76-103-38-92.hsd1.ca.comcast.net. [76.103.38.92])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-301190b98b7sm2353887a91.32.2025.03.12.14.22.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Mar 2025 14:22:41 -0700 (PDT)
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
Subject: [RFC PATCH 0/6] fs, lsm: mediate O_PATH fd creation in file_open hook
Date: Wed, 12 Mar 2025 14:21:40 -0700
Message-ID: <20250312212148.274205-1-ryan.lee@canonical.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Calls to the openat(2) family of syscalls are mediated by the file_open LSM
hook, but the opening of O_PATH file descriptors completely bypasses LSM
mediation, preventing LSMs from initializing LSM file security context
blobs for such file descriptors for use in other mediation hooks.

This patchset enables mediation of O_PATH file descriptors through the
file_open hook and updates the LSMs using that hook to unconditionally
allow creation of O_PATH fds, in order to preserve the existing behavior.
However, the LSM patches are primarily meant as a starting point for
discussions on how each one wants to handle O_PATH fd creation.

Ryan Lee (6):
  fs: invoke LSM file_open hook in do_dentry_open for O_PATH fds as well
  apparmor: explicitly skip mediation of O_PATH file descriptors
  landlock: explicitly skip mediation of O_PATH file descriptors
  selinux: explicitly skip mediation of O_PATH file descriptors
  smack: explicitly skip mediation of O_PATH file descriptors
  tomoyo: explicitly skip mediation of O_PATH file descriptors

 fs/open.c                  |  7 ++++++-
 security/apparmor/lsm.c    | 10 ++++++++++
 security/landlock/fs.c     |  8 ++++++++
 security/selinux/hooks.c   |  5 +++++
 security/smack/smack_lsm.c |  4 ++++
 security/tomoyo/file.c     |  4 ++++
 6 files changed, 37 insertions(+), 1 deletion(-)

-- 
2.43.0

