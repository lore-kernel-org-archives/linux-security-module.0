Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9CE53876A0
	for <linux-security-module@vger.kernel.org>; Sun, 18 Oct 2026 17:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792344733; cv=none; b=MHhWpeuiD+Gx3y1x+3E2hVx/K3h6K6cyh/VoH4rWcvbwORi1FsNxxgd5j+tG3ygCkfSrPGYp2S8lhpt+mXMpSWMPo0gxOM2sUKzv3zfStIuaEeqmhQB6Kgzog8uVeJnCZ0w9vaYGP7hgdlnzmy0kGizzrjp4OGx+HVrYRwg3Btw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792344733; c=relaxed/simple;
	bh=wopI36+1f0d7JyRh58bRjbDWEo8uX/kUo9laR2jCIp4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GiTSfeLbETXLzv1tuqgOVtGdIOkayCk5A8pBW0OOyrllNd6QE4McsgDm5Fuc5pUzMmttGc+t4xz1CJfOCon8jvkuQANduG4Av9r/5aDHr9Dr0dmSu2AOJvrCFCDiBttExRb+/lEToXvECZqIxqH0Yv0yEiGOPOtgu+pm0CmsTco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=pass smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.b=AkLy6c5n; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.b="AkLy6c5n"
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-93f2493c28bso126079885a.0
        for <linux-security-module@vger.kernel.org>; Sun, 18 Oct 2026 10:32:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1792344731; x=1792949531; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dTbOUx5g6mCGei5oy9AlTEaE/QrV9Y7tMJhMcaOgj9U=;
        b=AkLy6c5nncn6P/mSESQYcixFdf4mLlr6M3pAJqOpCKaRTeDFvgxlwUeat066c8hLD8
         atCUfpVHNN0qnsDYZIqj51BQRa0cm3XxCkWlxKllAmvfHIxancV9VoTLP3mRDpvFY8Vo
         LFsNRY/jer+EieurxVIUboQnz2AY3Nh+6TEEw+oh/1Be5CzQp6GBbhPO1O8+luoxkToR
         yK63oKYC9jvGsWvKdq9wsYWHEXochjJTorfFwmA6dKRc9CTqI0QI4bkU0Nmvni3vxYKs
         K1s2dW0JLHtoK7Bj2n7b6vBYtAvV6pbri0WsejrNZt6r54JeXfXyHHzovzzx/h7FBjei
         saKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792344731; x=1792949531;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dTbOUx5g6mCGei5oy9AlTEaE/QrV9Y7tMJhMcaOgj9U=;
        b=zIre7plrt/AZw0ELOcirLk3bVifM9vvloSaPCzVx4HsK5sFFgJ+Xep5lSFikNqcJeC
         5Nmf0NFRtWQNe/y6gdMQKnprD17gpdKuB39eiTHgWvszUusnS9i8dAzyqe6iON9+Vsaj
         fyNYyYkLe9mEQ/guujPn7PuwElCXhQJkR2fR3ndFsxKij/6Qwih4Em9GiS0If9daBNuO
         01gO626XF1n3+Ie5y6wi4WstNrr6NLDF/alvFEQcDul5joFBUhsE1S7nWmiA8J9iRbi3
         xawmnjbPOGEd16qfz/kUDKhmNPDlicYt1jdRcVddaIGJMMK4i+M9i1P0Cj4MNySD+MKr
         8QWg==
X-Forwarded-Encrypted: i=1; AKwUvBydiggMSx0fIrrOdKxvwdX2NMh+civuCMtGTyVT0W7of2FVpFYuSplC3w397Enikp1GeXyOIRb1bkPZCysMgvadjwt92Y8=@vger.kernel.org
X-Gm-Message-State: AFq9FYIMiVXaImDgkwMS195Hv54bOb5vM3Y3vRmY0Tx80oEWmX9Hnwu7
	WnmOIz72bU36TOA0/xW6UfhoccBS1ANbVKvFQwYJPVO2UFA7ghbr4wIZmlAFxC0IvMBcjiA9Gmp
	aOfos
X-Gm-Gg: AYBFou1QjV7KKbGCKMCBE6uTRLCQ03fVWZuCn//WEG5l+D7sg2Fc2zRgX91oqmdraYs
	U+iOy4x2HvhgdI8L9LAEvKPnQH/6xZsIH0Jb/koy6X3BjPDLEG7KtSRFRNpSQiShWufm9Fl1GW6
	1CP8FVffySz6jC2RhRnDYFCJQ5rLK98ZrX4hXUQg9FSemcBF7IZA/GP5LQ7r64wQyxKCCln4eZ7
	n/3kIPU3Ychchrn3bw67VrtcEDwaBUmgfzwULR2cUryJYnpB8y6GuaAjyMWKY0mIlcgfjGsb9Df
	qiZucMxy8svwabYdM9rpwcfGDohC9IVlpNBSBq4pOOz8gyXHKHl2O5oywnbfv1Q/TyKwuhmmlJh
	bmSfc1p/W7V8YqLKT77tMv2HmuSmf0PuVYcwgR30Q0m7csTDazTYNvwcOEFB7CVUhq0JsUaTrMc
	aqv8rPhj6/QVPK6e+p2ndMYfh2/CMjP29TPWLsHeh5gc2H5tPuI0BkFWHu9ICKCLeKto4XKKzdt
	dzPyWnRjtJcVdM=
X-Received: by 2002:a05:620a:2891:b0:93b:d7a2:83d1 with SMTP id af79cd13be357-93f29db6679mr964109985a.64.1792344730777;
        Sun, 18 Oct 2026 10:32:10 -0700 (PDT)
Received: from toxicpanda.com ([153.61.196.252])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93f1cfa8b51sm689579785a.20.2026.10.18.10.32.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Oct 2026 10:32:10 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
Date: Sun, 18 Oct 2026 17:31:49 +0000
Subject: [PATCH 07/13] sys: use cred_ids_allow_sched() for setpriority()
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261018-b4-cred-ids-v1-7-7bdf2db4ea9f@toxicpanda.com>
References: <20261018-b4-cred-ids-v1-0-7bdf2db4ea9f@toxicpanda.com>
In-Reply-To: <20261018-b4-cred-ids-v1-0-7bdf2db4ea9f@toxicpanda.com>
To: Christian Brauner <brauner@kernel.org>, 
 Paul Moore <paul@paul-moore.com>
Cc: Serge Hallyn <sergeh@kernel.org>, linux-fsdevel@vger.kernel.org, 
 linux-security-module@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openssh-sha256; t=1792344714; l=789;
 i=josef@toxicpanda.com; h=from:subject:message-id;
 bh=wopI36+1f0d7JyRh58bRjbDWEo8uX/kUo9laR2jCIp4=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgUBr36M/n0nWN0DNbnxwzIiCZez6MG
 JiruuNaSCI/zXsAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QBkWiicG2j/UXFtUTQjUw20euw1url/UCIDA49IlnH51dOlSU9SQAr+6RKZqkZ5RgcvQKhvaR/C
 3sr5kYrKZrQY=
X-Developer-Key: i=josef@toxicpanda.com; a=openssh;
 fpr=SHA256:C8kOX2QUJCMqnCX+KEeoqRAjLo9L+ELOSH2NSAJHqGA

set_one_prio_perm() makes the two comparisons of check_same_owner(),
written the other way around. Use the library.

No functional change.

Assisted-by: LLM
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 kernel/sys.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/kernel/sys.c b/kernel/sys.c
index 35b538ba843c..efef06240a8f 100644
--- a/kernel/sys.c
+++ b/kernel/sys.c
@@ -220,8 +220,7 @@ static bool set_one_prio_perm(struct task_struct *p)
 {
 	const struct cred *cred = current_cred(), *pcred = __task_cred(p);
 
-	if (uid_eq(pcred->uid,  cred->euid) ||
-	    uid_eq(pcred->euid, cred->euid))
+	if (cred_ids_allow_sched(cred, pcred))
 		return true;
 	if (ns_capable(pcred->user_ns, CAP_SYS_NICE))
 		return true;

-- 
2.55.0

