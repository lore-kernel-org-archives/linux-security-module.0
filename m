Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BD8C3B4E84
	for <linux-security-module@vger.kernel.org>; Sun, 18 Oct 2026 17:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792344731; cv=none; b=nyiFNVX4SvqHAFwcreR8RI9cfg6J2KE22FlGEEkRhjfm4m5YDsetgh/+wBtT8KNoZaObjZidsaGivRoU1pXecCXtnDknpBNo47XbeJb9fkQ809yUQHvjN2nUEklLZn4hWSpkHiaXB8f6mKtpSbuVqdUgvdmYfkqlbHtezvCVe0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792344731; c=relaxed/simple;
	bh=8Y4pdoO8o6DG3dxU9nQ9kNWZgM1e4m0YatPzcl98+Nc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kHlRVecRgr+/RsiAn1/0LxbZSya6VFskiEThgnDgvNNWw5NFHjiPYgs3tFirtwa8T4NTsh03VplyX64sk/vnCt/12NU5gxt2vNy9lSZekMU49omS1ZdxfS4TETmZO7scllAVjTnn9+4H2biqS2mGJf6ebMI3g3Y6ttvEbiB0dA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=pass smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.b=CdyGEHLf; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.b="CdyGEHLf"
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-93f3c89594cso25478385a.2
        for <linux-security-module@vger.kernel.org>; Sun, 18 Oct 2026 10:32:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1792344729; x=1792949529; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=heYAltlYf2s0SUcvKUJj27EViC0/q0e21YMnkOQZEqI=;
        b=CdyGEHLfUt96NQyLg8/tLKLafwMDl0BRAKhfJOtI+mKRuxsI6qFRgw0jCpKh1D/Ofp
         IGhp7ZnjZGZ6mqxi84CPMPYe2Ju4/7mij+aD+pgTL5aT/HUIfc8qyw7YBYwwPnN1EocB
         SdTAYS2y5nko74nw6YwlZjWw0Vk2gzoLOQjAWLpqVdfJIws0J94SOaLDB3byBkJWiMER
         rHGOZW2/qmacgnTSHdoWwY7OJ22kCK0QEpvymGmAPf3pmfmpNWWfe9Zet2oDpYHayb4Y
         34O1QSWZhEBd3M3jFmKjkJXkER0iUBb+o+Ut/eAjjCpLQvfJUpGeD4MJbL2XzAc8ZH40
         WkSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792344729; x=1792949529;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=heYAltlYf2s0SUcvKUJj27EViC0/q0e21YMnkOQZEqI=;
        b=SoNDm40PXvVaj27bftWHyIO3bQbXnxBcpTyHYz1b2JQ2QWzeCry4efFOq6rk5QT62L
         WycngYrU2iIRLR75hNbb2NPnab/TDxxJItc+9gzW5DhfgZl9lD28C2Mo0M8JUcnoL/GF
         LnVbuVSNH/d+qJ4KsOAZ4d3xJj9cbDnUVf8k8Ioi7y1g4Ii684vhIO+AMnoJ9nlJUzac
         f1AM4TMEu9HedAMyzfytEaJ6unqbXRYsB2rQpiZkWaRbdCOwGV4pg549J2cmdC8o6Wsa
         VlwGapqTEMHnJlSqji6tBo8BbgHjGm07uhJPxwG+z1cX9rX2WPZWdh2zP8vFPzfo4ViC
         4EHw==
X-Forwarded-Encrypted: i=1; AKwUvBxlcLQcq0Ykphiqcjb4g5fbHnCPaG0nLZA88wwa0y67Rq3or9td9G0swkNe+qKpie5P8dR0xGl6/ylg09epwJEy7TjjXtM=@vger.kernel.org
X-Gm-Message-State: AFq9FYLV8FXEge63cheU9la3jfkYZ21wkHLyPgdIJ+oz65LsSkSrOBlK
	zvgMa4U6qhP4mCt1u6uSZ9JBXYjxoCuu+gUGF9ofgHlFWXrcqNAzM2np2/eT9saPNYryO3svM8y
	nw34g
X-Gm-Gg: AYBFou2Bav3v6AD7EzehcoYDWbxYoa6gyAybTNkQBxJGoZCtj7S5s6epz7zjvNpaINh
	gXoyXCoKj72dyQRH0eBllBgdAQXV1fbCT+cZ7tt9rfs1LIAUMojhBIMoxzCIE+JEPYLk2NT4pKV
	UMzqIsaV/80o6gQ01jdk8ehZ6xkx6PdRnA7z9IzrcaoA3KfYK80fFxxLYXuHUNcRgygnO1CHT1x
	oNz1CnBi84+plDCmUVkRzgYFoYZolJMbBmAA6czhCnTETTyeeShOJRlLVYHYCTeL1sm8YoW/hTF
	KiQziRVJFo/W4Kdg2emOteKYhfoWxVMCp+mc4NN2lXCId7V7dqF9ZhGpzg0F3OeX5/zV/uvmGWx
	G1FSUn/EztiP57qMy1cmOP5dsIerjFTWr0jB+1ruaDsIzgy6xBvWpk4haCo812iASU7nSn1/hLr
	tAp7dkk8vsBIgIX3IT5U03T1GUN6lq6yRi2NgryyxtxeNGTF83ai4ewPSho2MKeanMhOpjnK2Bn
	vof4v0Qbcxg47A=
X-Received: by 2002:a05:620a:3715:b0:93e:c12c:9dd3 with SMTP id af79cd13be357-93f29e0afd2mr914791385a.83.1792344728950;
        Sun, 18 Oct 2026 10:32:08 -0700 (PDT)
Received: from toxicpanda.com ([153.61.196.243])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93f1a16950dsm746673585a.15.2026.10.18.10.32.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Oct 2026 10:32:08 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
Date: Sun, 18 Oct 2026 17:31:48 +0000
Subject: [PATCH 06/13] MIPS: use cred_ids_allow_sched()
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261018-b4-cred-ids-v1-6-7bdf2db4ea9f@toxicpanda.com>
References: <20261018-b4-cred-ids-v1-0-7bdf2db4ea9f@toxicpanda.com>
In-Reply-To: <20261018-b4-cred-ids-v1-0-7bdf2db4ea9f@toxicpanda.com>
To: Christian Brauner <brauner@kernel.org>, 
 Paul Moore <paul@paul-moore.com>
Cc: Serge Hallyn <sergeh@kernel.org>, linux-fsdevel@vger.kernel.org, 
 linux-security-module@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openssh-sha256; t=1792344714; l=837;
 i=josef@toxicpanda.com; h=from:subject:message-id;
 bh=8Y4pdoO8o6DG3dxU9nQ9kNWZgM1e4m0YatPzcl98+Nc=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgUBr36M/n0nWN0DNbnxwzIiCZez6MG
 JiruuNaSCI/zXsAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QHZf0IHNIwf7wrO6Y1j4UwsKUNBcMOqzphoWpEgtgup+ODegOLhRBlu/opGGICZhaQf6f0L2pAT
 YdUYU2k+HeQQ=
X-Developer-Key: i=josef@toxicpanda.com; a=openssh;
 fpr=SHA256:C8kOX2QUJCMqnCX+KEeoqRAjLo9L+ELOSH2NSAJHqGA

The FPU affinity code has a copy of check_same_owner() from the scheduler.
Use the library there as well.

No functional change. Compile tested only.

Assisted-by: LLM
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 arch/mips/kernel/mips-mt-fpaff.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/mips/kernel/mips-mt-fpaff.c b/arch/mips/kernel/mips-mt-fpaff.c
index 4fead87d2f43..1ac86a897956 100644
--- a/arch/mips/kernel/mips-mt-fpaff.c
+++ b/arch/mips/kernel/mips-mt-fpaff.c
@@ -54,8 +54,7 @@ static bool check_same_owner(struct task_struct *p)
 
 	rcu_read_lock();
 	pcred = __task_cred(p);
-	match = (uid_eq(cred->euid, pcred->euid) ||
-		 uid_eq(cred->euid, pcred->uid));
+	match = cred_ids_allow_sched(cred, pcred);
 	rcu_read_unlock();
 	return match;
 }

-- 
2.55.0

