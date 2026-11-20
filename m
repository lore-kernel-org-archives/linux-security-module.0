Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795160240;
	b=XVTGViipK1m3OHIrpjISG00XPfo0U5CYxm/8NPmqsRJN+rjdJ6nAgEjj5ZtKjI8nj+j1
	 bhReO1+mFEdNxezPTC+mUrkP8Udd1eobxFbhJjkLEKgNfSpijD38eGrF/RcjnCGUFElBW
	 NYv178P8bIOGdT7U4vaozXNn9BnKNNz8jHAcWBMzDlG/i+LpcDYKOYUwycmzXHyHBVtik
	 In68f0Kv/lm3xnnXp1TVy+m2NRHSq82PmqGOTUVB2JiuaHMhalt7J8qCAhdegaCRtT+Ua
	 HPJih+ZYICWr2lieiuBHeo17xMmbeSPFtjfkCVmfSvLIsBQAQeTqY1Z3A/0c8vef35A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795160240;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=RoorVLMi62FuFQRrqrflAmA+uFRRnvjjHFtI7v/dMic=;
	b=Z+Lrc24lDHyBE5M3+4LKAiVkP49rJeH4fSr04Qfnn8IAFxkotY7K7WH+hXz8JeEGe89A
	 /Drp1E7aCN2NAetnsUnxdZF7l5cGL5pvVDO+m1CAWrGtd3gBiNjfQRctAF/N08ESC4tGO
	 ISkqQ60+crigmxp4fzNhqI/tUXKpjU0iuxEz6FwmTALGBXN0ZMGo+wBDVkwQLM5cg+35V
	 3iIOJnDk97dhO18E6A3uO2OgVVDqkcL8Ad3VTc4a+TO7Uivcj7YU8jaYVt/ncOmJKG7Uc
	 Gy5uU3/raUUOZy+DCtYFKUkhH76d56VOo/LqjXttMKxowzRm1A/c+7YbRFP+rInOugg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=hceukMgh;
	arc=none smtp.remote-ip=209.85.208.51
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F92D606A332
	for <linux-security-module@vger.kernel.org>; Fri, 20 Nov 2026 07:37:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2F92D606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=hceukMgh
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-6ae305e3bd9so1063312a12.0
        for <linux-security-module@vger.kernel.org>; Thu, 19 Nov 2026 23:37:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795160238; x=1795765038; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=RoorVLMi62FuFQRrqrflAmA+uFRRnvjjHFtI7v/dMic=;
        b=hceukMghY7le6BIvmBla2eFNVCQIbmkpOBHR0Qmni9s9Tx5CJJVqMf3vpfilPmRW5G
         K5wgOLsqd9MAS1z6OmEN/CrYQRV9tFx2RXS6txqkQxbbd/dKWCfmrVKOilSn/zmap3b1
         YNsLVgq+Vm8OssuoTDaCUB7VlZ5YhvYFA+SIyOP0/6fykgUwThttvdaJNRdt+00yImGy
         +T4jsEnKlm3k7w4G0FPANL64WVx4J3DRwpm0UjGciS6HVC6q0moeniT6KYlLWLNDEAVd
         f5BhGFbkXk8GTLaKY51IysD3Ajx4lCQI120uvi9wU/CNygHwZmyVXAHogmXGeGP8PVSE
         HcAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795160238; x=1795765038;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=RoorVLMi62FuFQRrqrflAmA+uFRRnvjjHFtI7v/dMic=;
        b=NC7pZgzG+MTorxmn59gi9OESbn43Gih2erVtyvoF+hbJXq0af6U0ZIkZiwW+R+ntlk
         YZ57BsRoKBkQGNxTPykGumNTv0M2v2GuQlaO/StMf3cR53VfGzyOr0jwzMcQAjBL0pgk
         emyvVq9TPLts8std6QozXaPP4mBnIguJrQ8XJnWQ2SRb56nxwaVEQbeXDoCFS3KSV6RA
         FlbAn1z0HTw5TnpEX1IjXBB7QFoYHp2Eq8+OGgyucy6oi7RlD+yPeIHCBMpY2MtReKbF
         SfnarqwdvZm6rIQi6fNf3bryhTXlG+k5wzXlEOwy8+eCoWrBalUF9vonXKydTSBShorJ
         K1Bg==
X-Forwarded-Encrypted: i=1; AL+hErH0tm9zor46gXCC/tD9ou8bkUAk9z13wiioNRD1p0/WLsfXaox07bnssnGDDWuBa5549FvrpcEMcUQ3fgnHg77Bj/kxiac=@vger.kernel.org
X-Gm-Message-State: APuU4Z/abR09Xg4nNSGosixk0livqkg1Q6zn08oCgWUrwMNDS82RZU8b
	w1ULOxuEMtwznfMOSQTKWhxLE4/D+x4PuZopTqSNY4pkY/amo827MEns
X-Gm-Gg: AZFdTZdgHrPy0UalMuBO3NoQ5lCY/PCwijiQgxez+hsDifw/3gaqc6/ctqQbGJMRnu4
	IcvRF4rVk2UAlPFcW+nD8kf2SYkpiASlN81TsFaMF86AAseAOT/m+1RkPvAAAsX7NeWDw0uL2GF
	R8EJSh2KWV8lCjlV5vgUwX4FTOcFgAsDvkoHKveE08zxk5AclxPPymz5lMZh+9AxBx15QCnj5/M
	N62wtiUzDFHw6no1CCJSiVGTeet3byDIENyJZJGWROzIMeFTIhaNJN0j5/L/BetIZUbpmT+1n5m
	QZkL6Czyq6Dtm9whu3qpN2PnQJQ65l+Rde4YnoKaj43LD7q/RvRxjpJjoWB9pvF8iMVQ44TTp2v
	ZuVlCWM2vtMdRCFrq/kLDGQzlUqFFf0d96A7MQnUMX1/Sc7E2QCoRD2sRMS6K5gzigLiyKwpk/E
	7s3qLn7KCr+Y6KgSus2IFpXQCrab/ZxXQnofFQph1uOVee4uWhp/AzOJqX+Sw/EvdB00fR1+nF0
	Y1o8/65u3kvS8VqLBzyP9bSEpNEi+NTrkgptL5B2uJgTyhS0ShIJXOzwx7DvwINQpPRc57aFD1Z
	zzehUUSa3SAWRKisDs0SxyX55RBNu0BTbIgJWxv/VwCAyVPcRhcQiwmzDD1hlJCVO7e62KQfq0x
	AClhXrrhrwhI=
X-Received: by 2002:a05:6402:210a:b0:6ba:4bf3:4a7 with SMTP id 4fb4d7f45d1cf-6ba4bf3066fmr408910a12.23.1795160238249;
        Thu, 19 Nov 2026 23:37:18 -0800 (PST)
Received: from localhost (178-84-201-199.dynamic.upc.nl. [178.84.201.199])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6ba370fc020sm841867a12.25.2026.11.19.23.37.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2026 23:37:17 -0800 (PST)
From: Amir Goldstein <amir73il@gmail.com>
To: Paul Moore <paul@paul-moore.com>
Cc: James Morris <jmorris@namei.org>,
	"Serge E . Hallyn" <serge@hallyn.com>,
	Miklos Szeredi <miklos@szeredi.hu>,
	linux-security-module@vger.kernel.org,
	linux-unionfs@vger.kernel.org,
	Stephen Smalley <stephen.smalley.work@gmail.com>,
	Vivek Goyal <vgoyal@redhat.com>,
	Christian Brauner <brauner@kernel.org>,
	Chris Mason <mason@kernel.org>,
	Josef Bacik <josef@toxicpanda.com>,
	linux-fsdevel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH RESEND] lsm: put the copy up creds when an LSM hook fails
Date: Fri, 20 Nov 2026 08:37:16 +0100
Message-ID: <20261120073717.1588080-1-amir73il@gmail.com>
X-Mailer: git-send-email 2.56.1
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chris Mason <mason@kernel.org>

security_inode_copy_up() leaks a struct cred when one LSM allocates new
creds for an overlayfs copy up and a later LSM then denies the copy up.
One such pair is SELinux and a BPF LSM program that denies
inode_copy_up. Enabling both LSMs and loading the program requires
root. After that, each denied copy up leaks one struct cred, no matter
which user triggers it.

The hook calls each enabled LSM in turn. SELinux or Smack allocates the
creds and returns them through a pointer argument of the hook. A later
LSM can still return an error, and the hook then returns that error with
the creds still allocated. Its kernel-doc does not say that the caller
owns them on error, and the only caller, overlayfs, does not put them.

Reproduced with SELinux and such a BPF LSM program: 36000 failed opens
and chmods by an unprivileged user on an overlayfs mount left 36000
struct cred objects allocated, which kmemleak reported.

Fix this by putting the creds in security_inode_copy_up() when the hook
fails, so the caller gets either creds that it owns or none.

Fixes: d8ad8b496184 ("security, overlayfs: provide copy up security hook for unioned files")
Cc: stable@vger.kernel.org
Signed-off-by: Chris Mason <mason@kernel.org>
[amir: put the creds in security_inode_copy_up() instead of in overlayfs]
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---

Hi Paul,

Apologies for missed the LSM list and maintainers in first posting [1].
Resending with proper Cc list.

I think this LSM hook was introduced with confusing contact for chained
LSMs and this change makes the hook contract more sane in this case.

Thanks,
Amir.

[1] https://lore.kernel.org/r/20261104082128.3573690-1-amir73il@gmail.com/

 security/security.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/security/security.c b/security/security.c
index f6583d5073959..ad382afbff271 100644
--- a/security/security.c
+++ b/security/security.c
@@ -2314,18 +2314,26 @@ void security_inode_getlsmprop(struct inode *inode, struct lsm_prop *prop)
 /**
  * security_inode_copy_up() - Create new creds for an overlayfs copy-up op
  * @src: union dentry of copy-up file
- * @new: newly created creds
+ * @new: newly created creds, must point to NULL on entry
  *
  * A file is about to be copied up from lower layer to upper layer of overlay
  * filesystem. Security module can prepare a set of new creds and modify as
  * need be and return new creds. Caller will switch to new creds temporarily to
  * create new file and release newly allocated creds.
  *
- * Return: Returns 0 on success or a negative error code on error.
+ * Return: Returns 0 on success or a negative error code on error, in which
+ *         case @new is left pointing to NULL.
  */
 int security_inode_copy_up(struct dentry *src, struct cred **new)
 {
-	return call_int_hook(inode_copy_up, src, new);
+	int rc = call_int_hook(inode_copy_up, src, new);
+
+	/* An earlier LSM may have prepared creds before a later one failed */
+	if (unlikely(rc < 0) && *new) {
+		put_cred(*new);
+		*new = NULL;
+	}
+	return rc;
 }
 EXPORT_SYMBOL(security_inode_copy_up);
 
-- 
2.55.0

