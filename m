Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C18C3F4122
	for <linux-security-module@vger.kernel.org>; Sun, 20 Sep 2026 23:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789948373; cv=none; b=f3jQHFGzVtqD7RGrdaYYzKM8DC1XlA3EbufPD4HsoWB167VnyCf+nrPu3k+iaIFS81wdF/utwZ0OGPM6xWp4FwJ/+1rkMo3Ls2Xqzp9OrlwB8+Y1Z5YPrk5+Wx3xvw9scwA2QheH8R43n0FyaJ9tyS6RF7AVh3iyMsqLXdWeLeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789948373; c=relaxed/simple;
	bh=DdpNXSidQFvpDfBnNgiQM+SzaBF2RjrrqFZBe/ypr34=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JE77qykKn2g08yI+hlOpB1ttw99we3fuCYRc6mCnXuSF7j4o8h1ENjUaCUB20y4+qHStRtmOzI46Bwf+lLNqI/0e3XD2f9VcK2NQfuWwtipev4fUjLnqZdjE+dt9f1bUYbCMfCREM64uA8NR12bovHp8T1EYyzwRbLCc+0pxdPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nLv2VGgm; arc=none smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nLv2VGgm"
Received: by mail-pj2-f13.google.com with SMTP id d9443c01a7336-2d91ede8035so28573475ad.3
        for <linux-security-module@vger.kernel.org>; Sun, 20 Sep 2026 16:52:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789948371; x=1790553171; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=EhakzEdE29nOvUv7Mc+RF2KlaAe5CVApdx8H1znJCcg=;
        b=nLv2VGgmk6Q6nXxfqY7Ao+KrEk825hmRWaoLUbtWv6u5xhgHMoqMuf5HOfhqeppUQ8
         A4XN3ipB4tj1lEhSz94rw7UvnRTXtySFTqVY09FlNPVnOqJjFvVHl+qCW884RfynCZVS
         8cuaCi0q7AT5pOcLUflSA3JdlAYWv0YajB6AfPYwivD158DDG1OPRAQLCE8lhyzbdT9x
         djQUVGWfTS0sO9GqbYsYjdDuZCt1xuIqgC423QaW/T3d5TzIrRrBMdfsnKGnAPQscmX8
         HbystK3PXtI2ygYKPWd8yznqj/ZwGKFlV9gk+/8TYRmWITCRkJbsC8PTIwo8JEx1/6Xf
         UqqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789948371; x=1790553171;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=EhakzEdE29nOvUv7Mc+RF2KlaAe5CVApdx8H1znJCcg=;
        b=rigsEBKWDK4RSLSKWqYrrbE0StQm6vVTU8EGULrGWAV9vTa+06y9KBIDZaNNqoHlgv
         GqxdgImyiuGVU2eHdb8A1ER9m9Q8537sCu/jmbIJfqDk0xejJA0CQnzpz013CpJP2vl4
         sI9uky50uC/gMmbzDiuQAx3sygqibdaH4YSP9dJIi7ltPosdhYDVsAKd2VjE/N/uD5cJ
         JiUv4knk4FXkVn12NDjqZnb63iHf1fs1/n/E4FSGh2lKSWA46dVHZNKmYXbyKLanSwmY
         oiYgb/WPAl9YR6ppSVtj5L+4bmmxR+J/Pp9DJh4ungbOJIdXhdErylYBRTfzKkqoRuHt
         yj9A==
X-Forwarded-Encrypted: i=1; AKwUvByyIJ8B8D3oFIJDXvNCwMjUhkZqXqAObcg+jo2aQgluy43D2GH2UZUK6kiUn1hUXO41iO1jYIDQZNk9RzoKt3NRKT3idf8=@vger.kernel.org
X-Gm-Message-State: AFuF++l/5GiasVeKOT7lSIc3hgrsYcWHNDQTvXhM70dre01kbTDhbLJk
	SflU9853tlYD6Cvb0uNyjAR3lUNoG1pfgRg3/TcpD/QVRry64hjGwmqI
X-Gm-Gg: AYBFou0PDPgyUebJL3QbjOPsytDBzVIakVReAKhuAPVCShb3hntZ5bd8X+7YfGQCe+e
	SuAT04yUR5QnUFkvBkQlNncIpB1XLq0TwBf9VHtJo/pZ4/A12LveNJEfDT9psAcp9EM24eOFoch
	0sRex6HHvB/ZCibfxUI6QTMax83xnv76GdNZwLgFWaWd2dFiRf8ZK2DyjqJmvZlRjW2/Vsy1eSw
	OW07DUe3xSCuPGDG01BdL3KvlboTsHRaKnyhxAIXW3ZtJZajcRoCny1EEv7WQZOebIw23HZcIMW
	s3QP7OVIT5GFFOnWCLNRtGXATnyWHG55TqD/UZDRuhYCA74Q7Ml7xLsRO8tr5MOpSHubaGhVjaM
	QNkTeLfL46f+tvTGLktlayuPzl9RtW4rqxWiBG23ilA6jEZr7KgZmWvTd0FJklO9QRKhy3bvUoA
	UXFEVlIAEY9IxWnnHDbi4lD1eOlFFn3NK43RlR/HpxvroNnZgu02Wa6IzHdo0UuLGwdbcDiGsDE
	DakhSRS5lbz41Is2Rnu/5wdB4mXengFKGouHDW/PzZJOWBO7pWwxd1g3HDNis35ZnTGm8yYHFdK
	MfwrA1fds9Cew8w3pHkM
X-Received: by 2002:a17:903:2c0c:b0:2dd:b3e0:850 with SMTP id d9443c01a7336-2ddb3e008d2mr126436425ad.17.1789948370862;
        Sun, 20 Sep 2026 16:52:50 -0700 (PDT)
Received: from phui-2.c.googlers.com.com (78.123.83.34.bc.googleusercontent.com. [34.83.123.78])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ddc1788173sm24228375ad.19.2026.09.20.16.52.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Sep 2026 16:52:50 -0700 (PDT)
From: Hui Peng <benquike@gmail.com>
To: David Howells <dhowells@redhat.com>,
	Lukas Wunner <lukas@wunner.de>,
	Ignat Korchagin <ignat@linux.win>
Cc: Herbert Xu <herbert@gondor.apana.org.au>,
	Paul Moore <paul@paul-moore.com>,
	keyrings@vger.kernel.org,
	linux-crypto@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Hui Peng <benquike@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v2] certs: x509: duplicate cert->tbs when sig->algo_takes_data is set
Date: Sun, 20 Sep 2026 23:52:49 +0000
Message-ID: <20260920235249.260530-1-benquike@gmail.com>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
In-Reply-To: <CAHC9VhS7sZQaPaRswKQ1ETrReEPB2f5buNAMGSXqZ1iBKTs+bg@mail.gmail.com>
References: <20260919223438.3883567-1-benquike@gmail.com> <CAHC9VhS7sZQaPaRswKQ1ETrReEPB2f5buNAMGSXqZ1iBKTs+bg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In x509_get_sig_params(), when sig->algo_takes_data is true, sig->m is
assigned (u8 *)cert->tbs with sig->m_free = false. However, cert->tbs
points into the temporary ASN.1 buffer (prep->data) passed to
x509_cert_parse(), while cert->sig is retained in
prep->payload.data[asym_auth] by x509_key_preparse() after prep->data
is freed by the caller. Subsequent signature verification on the key's
public_key_signature dereferences the freed TBS buffer.

Duplicate cert->tbs with kmemdup() and set sig->m_free = true so sig->m
remains valid for the lifetime of struct public_key_signature.

Tested in QEMU against Linux 7.3.0-rc3 with KASAN enabled by adding an
ML-DSA-44 (OID 2.16.840.1.101.3.4.3.17) X.509 certificate via
add_key("asymmetric", ...) and linking it into a signature-restricted
keyring via keyctl(KEYCTL_LINK), which triggers the following KASAN
slab-use-after-free before this patch:

  BUG: KASAN: slab-use-after-free in mldsa_verify+0x95/0xa0 [mldsa]
  Read of size 1 at addr ffff88800108c004 by task init/1

  Call Trace:
   <TASK>
   dump_stack_lvl+0x70/0xa0
   print_report+0x153/0x4c6
   kasan_report+0xf1/0x120
   mldsa_verify+0x95/0xa0 [mldsa]
   public_key_verify_signature+0x5cb/0x8e0
   verify_signature+0xe4/0x130
   key_or_keyring_common+0x428/0x850
   key_link+0x22e/0x360
   keyctl_keyring_link+0x6b/0xc0
   __do_sys_keyctl+0x146/0x4f0
   do_syscall_64+0xda/0x4b0
   entry_SYSCALL_64_after_hwframe+0x77/0x7f
   </TASK>

  Allocated by task 1:
   kasan_save_stack+0x30/0x50
   kasan_save_track+0x14/0x30
   __kasan_kmalloc+0x7f/0x90
   __kvmalloc_node_noprof+0x1c2/0x5b0
   __do_sys_add_key+0x1c2/0x390
   do_syscall_64+0xda/0x4b0
   entry_SYSCALL_64_after_hwframe+0x77/0x7f

  Freed by task 1:
   kasan_save_stack+0x30/0x50
   kasan_save_track+0x14/0x30
   kasan_save_free_info+0x3b/0x70
   __kasan_slab_free+0x47/0x70
   kfree+0x159/0x420
   __do_sys_add_key+0x2b3/0x390
   do_syscall_64+0xda/0x4b0
   entry_SYSCALL_64_after_hwframe+0x77/0x7f

  The buggy address belongs to the object at ffff88800108c000
   which belongs to the cache kmalloc-4k of size 4096
  The buggy address is located 4 bytes inside of
   freed 4096-byte region [ffff88800108c000, ffff88800108d000)

Fixes: f3eccecd782d ("pkcs7: Allow the signing algo to do whatever digestion it wants itself")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Hui Peng <benquike@gmail.com>
---
Changes in v2:
- Dropped the net/netlabel/netlabel_calipso.c change, keeping only the
  crypto/asymmetric_keys/x509_public_key.c fix.
- Added the KASAN slab-use-after-free report and test description to the
  commit message.

 crypto/asymmetric_keys/x509_public_key.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/crypto/asymmetric_keys/x509_public_key.c b/crypto/asymmetric_keys/x509_public_key.c
index 25cf8ac7f257..5c9165a83f91 100644
--- a/crypto/asymmetric_keys/x509_public_key.c
+++ b/crypto/asymmetric_keys/x509_public_key.c
@@ -53,9 +53,11 @@ int x509_get_sig_params(struct x509_certificate *cert)
 
 	if (sig->algo_takes_data) {
 		/* The signature algorithm does whatever passes for hashing. */
-		sig->m = (u8 *)cert->tbs;
+		sig->m = kmemdup(cert->tbs, cert->tbs_size, GFP_KERNEL);
+		if (!sig->m)
+			return -ENOMEM;
 		sig->m_size = cert->tbs_size;
-		sig->m_free = false;
+		sig->m_free = true;
 		goto out;
 	}
 
-- 
2.47.3
