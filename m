Received: from mail-pz2-f12.google.com (mail-pz2-f12.google.com [74.125.228.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E39DB547043
	for <linux-security-module@vger.kernel.org>; Sat, 19 Sep 2026 03:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789790040; cv=none; b=cMyGnGepuK1kHWaFro7xMeSrlTJazlo7QCiFPPMvTrJiy5PZ5+wK2s1fxeZ+Ca+s9tmT0BzAEnlO30QrXQcDZSFuq7Pvgx89WZ5nJyjLvXleeCn3sNZDFMnlK5cGcCU1COvQVOjFkG46w9dU12Lqshl/FBaxxdzcK5lZNNzld9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789790040; c=relaxed/simple;
	bh=ar2zcNlv7+c1OyTtkaddUuGasqJNqHnuUoJCpv2NdIk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=c1JpiS/vNyWHSR/M5gMVwQ8P8zQamUNeIQQ25gQzsqbU3tEoFFTBPCqspsvyAcKgjomk0UVhQNehjvBMOVVv1CvqDSt9upiBXxFfJLRn+H7SHN5nWJRZ+Qb/6tT9902NRQK++Pb5KFMaUh4P9SDy+Ut6lhUzFQR8+keVlgjcvm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GMW7Rq2U; arc=none smtp.client-ip=74.125.228.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GMW7Rq2U"
Received: by mail-pz2-f12.google.com with SMTP id 41be03b00d2f7-cc1cebad4afso1002910a12.0
        for <linux-security-module@vger.kernel.org>; Fri, 18 Sep 2026 20:53:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789790038; x=1790394838; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=vINPVP5099LZ8ihUeZp3zwJQXFHBAyqFeLchbfWgNgA=;
        b=GMW7Rq2U6iBEIU5Camq06FyvBFRmvxCvNmgq7F55xS7rqCbz4sS8Owb2vP2W7ajGIa
         MYkQy50pfCiBGWsrmUe8h/AWPZ4jWnRnC7c9cLzLMwIo34gOt/Gwni9UN1Z1rKkR3+zR
         idiiBgG2nertauxD/eheJ4OtL5UdNclmwa0spVlFpcojo+OvZQLY9vuBAxFRwsKkFb0K
         QpPuksMAUJ9x/55YN3M6a8VJPwJ4+r+cJD6O9twIz+/qb6CIWcaWLjd3algWN93NwZS/
         GTJjXXVQ5sDe07BsHukcjMcmun+K8n0tlutL9pbgtEGvH8WDxCoXHv6U1KPZcktJqdKT
         tcLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789790038; x=1790394838;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vINPVP5099LZ8ihUeZp3zwJQXFHBAyqFeLchbfWgNgA=;
        b=g6HyrNvSuMOIj/ilryqxog69fAo9E8OcgA622AFRnjK12l0m9H8DaT55Zv62sfH/yM
         /ulJFsTxqBSVNngnJn8IeMRjz7es5jPSeRT5TBCfPt3KuzfXTiL/eD55cd48jFfJcVj9
         u58SFyK9+Lql6cMW61MowC806E2cD+MVmOnY5ejVSgL1NWCORBF8dHhp6q7mtPKanwel
         mBYsdMX3upt/DDKdJojkLeU/yegI5Lq2+AgF5Zq1WC7tn2HyrecyZ4E2ltyCqiJayZMT
         MXvWPulRho3iIbBneyJfwvz4YLvwE6L1wheSgmB0BHPOuvUznB1zg1/+fIN3wi1ZvdLW
         acjA==
X-Forwarded-Encrypted: i=1; AKwUvByBU48MjhD9f4BSDp7x22r9p8/0J9gjMUQe+Uj/vL9wvtpsoHn1bO2jVgunHFDSxmIA6tvYn2J58LIyWkdAyRPiYRTSkXI=@vger.kernel.org
X-Gm-Message-State: AFuF++m0Msr6dbzy475CI/vnqroZ3rW5wNMJN1mkl2VlFKs/+qB8yHvT
	dgq8gqKK/4f8KqvUMUCdHw/HfUPJH4FqFZkO9W5fLgsOuvKSZktq5Xx/
X-Gm-Gg: AYBFou2grC5hnAaPJyX0MyO94nr+UFJnxYXpAPPQpz9sfgWw71hl/bTp+FahrtkObe5
	3bjMMaW+iK8riIpnzDsFYPhkFcCQtN9cHQmLfQRSLo0j03uAJtbH0IvHuLIN5QREVqFT32aAR0e
	3HVljnz1B01+3Elwu14GTD7vcZcY7PfMCeLO7zBai5ApoXVHb1EMUeeBqTApwYtoM4KT++qV7N1
	IWu25DUb12S1BQpZyiBcnqd84cFq9ejizw0eeDclFVqO6iKYjMzf6mADcqngg2dm7EMqXDPSGvn
	DDPCA9LW9d1ToE5lUCYs0n7w/T6eRnCXwVyHsifEjKVPJ/Jh6xhfHAW8X4pOdNCWoJcrfeacILk
	1VmWgsBEN/jpRdeWMNxZxgIMOWIQogHlNWGPj8Z/Y1P8qR3eMyJzVxrdnOMv8XlO0oa7epGG6XK
	BHCuLrhebxgdC2Zv1EZ0gt9bB602oRF0bsJSuG8w+gOYL2qHHnnZY6b3F0xOWcBivxminlIgNgF
	zIfq89QdHOJsImW
X-Received: by 2002:a17:90a:e7c9:b0:39e:6c69:7771 with SMTP id 98e67ed59e1d1-39e6c69794bmr2720506a91.26.1789790038175;
        Fri, 18 Sep 2026 20:53:58 -0700 (PDT)
Received: from thangnn-ASUS.. ([2405:4802:1d4a:e90:814e:e9d3:767e:9a2a])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39e6cb3607csm2287560a91.16.2026.09.18.20.53.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Sep 2026 20:53:57 -0700 (PDT)
From: Nguyen Ngoc Thang <ngocthang2710.1999@gmail.com>
To: Casey Schaufler <casey@schaufler-ca.com>
Cc: Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E . Hallyn" <serge@hallyn.com>,
	Rafal Krypa <r.krypa@samsung.com>,
	Zbigniew Jasinski <z.jasinski@samsung.com>,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Nguyen Ngoc Thang <ngocthang2710.1999@gmail.com>,
	syzbot+fa63184795283ac3f842@syzkaller.appspotmail.com,
	stable@vger.kernel.org
Subject: [PATCH] smack: reject relabel-self writes from io_uring workers
Date: Sat, 19 Sep 2026 10:53:51 +0700
Message-ID: <20260919035351.88453-1-ngocthang2710.1999@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

smk_write_relabel_self() calls commit_creds() on current. When the write
is issued through io_uring it runs on an io-wq worker, and io_uring
override_creds()es the submitter's creds when they differ from the
worker's. commit_creds() then trips BUG_ON(task->cred != task->real_cred):

  kernel BUG at kernel/cred.c:376!
  commit_creds
  smk_write_relabel_self
  loop_rw_iter
  io_write
  io_wq_submit_work
  io_worker_handle_work
  io_wq_worker

Even without the override, committing creds on a worker would relabel
the worker rather than the submitting task. Refuse the write from
PF_IO_WORKER context.

Fixes: 38416e53936e ("Smack: limited capability for changing process label")
Reported-by: syzbot+fa63184795283ac3f842@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=fa63184795283ac3f842
Cc: stable@vger.kernel.org
Signed-off-by: Nguyen Ngoc Thang <ngocthang2710.1999@gmail.com>
---
Reproduced under QEMU (x86, v7.3-rc3 + 00834fcb20d0) with a small io_uring
program: async IORING_OP_WRITE to /sys/fs/smackfs/relabel-self to spawn
the worker, a direct write() to change the submitter's creds, then a
second async write. Before: BUG at kernel/cred.c:376. After: the write
fails with -EOPNOTSUPP and the program completes.

 security/smack/smackfs.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/security/smack/smackfs.c b/security/smack/smackfs.c
index a72bc7fabea9..0061220e2d00 100644
--- a/security/smack/smackfs.c
+++ b/security/smack/smackfs.c
@@ -2678,6 +2678,10 @@ static ssize_t smk_write_relabel_self(struct file *file, const char __user *buf,
 	if (!smack_privileged(CAP_MAC_ADMIN))
 		return -EPERM;
 
+	/* commit_creds() must act on the caller, not an io_uring worker. */
+	if (current->flags & PF_IO_WORKER)
+		return -EOPNOTSUPP;
+
 	/*
 	 * No partial write.
 	 * Enough data must be present.
-- 
2.43.0

