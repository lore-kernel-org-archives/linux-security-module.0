Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793802305;
	b=2CfkHXbj6NMgnYBmaD8rmbVJ9H/TzWHsUZE0Cg64KZfEThxOZ47PXtgeVW0trseavxuZ
	 AkNxfxqgCI0KAohUIOot17s9rtwAPtVqaMMWBAVO94LOdEEX2fZElYKQ4uxS3qBmsrVxT
	 O7YZAqrL1uYoVbun4UTa3H+qsQzFrZR3t7wRIbH8DoIhusFmHOemtlFB/anp26jCB35lF
	 cVyTSIWC3sAR42ZYP69O1Q5L2TrIuJ+6F5ew7C8Bt6gINM5OL8UCoiXJ8yQUplqn36qzQ
	 I+MPZGY3aXN4xgUUoov42iK8xRieo0njqXxgKhflQngvHLuBIhwDqtlh6xOq2ymmrbA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793802305;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=pzxWQSDPM+PHVvsLYVB5w6iZUlMeuS6dTc4+BOVgaWE=;
	b=tfNf5vzS+GgrQDt0/B2/J5f8dPddNc1XUA5Cs7C3//+NCtRk2avBdWoSjMCZe7FTFPVc
	 X7dxuBttZ91qlFSszxmgCy1ymRwbDdGqn/Rt2zlYHK8fXuM+3OnFBndQffdcALhqq2k7j
	 1BruB7+fLmZ6gKSEdBmlDtXs/FFLfvNZTQSV2X5FHvHH3tghyqlxfKumDqBDFZaslVA+N
	 e3WFsy97mLuvbaVSkNs8H91dQV81CIq7FRqP1Im0jVvECIpXlLFi/iULpl1la2DDVKEZM
	 bFhlES2quiVYAc49uOVxTHOhXdp7Td0CTRKbIVydfpnvs7nMOAlLzycLnWifo1wLWHQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=toxicpanda.com;
	spf=pass smtp.mailfrom=toxicpanda.com;
	dkim=pass header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=abpmhxWR;
	arc=none smtp.remote-ip=209.85.160.179
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01B12606D80A
	for <linux-security-module@vger.kernel.org>; Wed,  4 Nov 2026 14:25:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 01B12606D80A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=abpmhxWR
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-537548b811aso5458971cf.3
        for <linux-security-module@vger.kernel.org>; Wed, 04 Nov 2026 06:25:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1793802304; x=1794407104; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pzxWQSDPM+PHVvsLYVB5w6iZUlMeuS6dTc4+BOVgaWE=;
        b=abpmhxWRH4LQzMV0jAKf8jiJ8cYZX2nqFZh/9yAXmihk/QVekTm4snUYAlMFDRVOny
         QNJXywiJD1EIHCgwX9PxmS3bZm36bzo66QuX/QVOkIIDheVR3RaX36MnVygU5uJin+gW
         /t8TUMPOzpWxHKGIeNfl8lKxKPYV3/8RrWd/4mxUy0g+bntqMz2hQMZy93aD5QPvEyh5
         5iy8Zh6K9g3PrErFoU1xS98FjEmypiz+xd1XqbOLTzSDRzeosxFaUh3SL9KWfSnK5A74
         OSyR69eAPyF2C5e8jbiu+bCdsHBDU+H1chxhVWzhgZp+KTqJoUVrFqj9XF0JvmGcYLrQ
         801w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793802304; x=1794407104;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pzxWQSDPM+PHVvsLYVB5w6iZUlMeuS6dTc4+BOVgaWE=;
        b=GoBQDcmG7wRwSmDHuXL4GUyDwUsFpnqwL+awQp/aq1RGvo66z2leHtMd9c+oEw4ict
         rrKQMIzXbBYa+zse5zXS6N3J6k9m8O4+XftcI9KN7lMNanI4vfufmWgzJQ/RVtRAXlk+
         ESzG8TnBUSKJu+b8bOLryhukHKJAFtx0d3ZnBTo/L5EnLCGKJK79VAskFJRvDWnsugas
         DyFMAWfJtlQ6V0+BRbL8nG5BnNcTj/SJezSZ69wpuwmOrw5Y4nCIaM88AXE42VVR+abR
         5zM/C0xUliNgplUtM1HtBrwvac+NBliyvADQypES0oe1I5O750yknVTqWhrG1uEu5qHX
         YeyA==
X-Forwarded-Encrypted: i=1; AKwUvBxZqk57L2aYZreDdTb9X25Q7JY8yHUqbe2XQGzx3p1BughDDO8r/LyeQ8ItjenVtl/MjRkNspSD68apFFHfTcjTS+M5Pa4=@vger.kernel.org
X-Gm-Message-State: APuU4Z+ys8c8zcAU9YBAY+t1bTXA9qnQmn8TeSx4XxL5ApY0CtGAln+S
	6A2m45HQ3CSNvX3iL9txnKl7XH573aRixcSSDy0SKyM0WJv2zMGtw1bC+55i2qtRZcc=
X-Gm-Gg: AYBFou0efPe7bhZuptjaOroOK5dQp1qJLq/I+boseiAVZR9XqWMtMMxe2ByUNRaMQdo
	3gMavQ7SltF4SFQtMlRFY58McGGTf4vyuMkvCUKRKFmklDaakmz903DgVK97NPA5+PYP8LUvtfe
	lHuoMYvMLl9nYvzIUdJE/d17jRE6IZs/xC9Uiwwnbu1eaboILQ+Ky+nxOhAn8pi/iOjUH0JY7Iw
	JvF2NY93/KwSezjnajCMfGnbtqNtX3GtEajH5qOq4OiwqnFzxn1i9x8gslb2HEXbhts3WE9byik
	w43+vX5zpbbS7g/RTRVp6p9frkPM+cg/HR2DOyE21J/zgVyENUoVusQf8pLTT+M0YSSc50vikPM
	zpi7zBzxVGpIhebvYdsJvA6u0np6eeJX0yqAZnFQIGh9viWEmMSWoFSQjYGEiiKUW2rlHZt5xQ7
	vQXv24Dqhbx6ujUo3y3DpPiNec2fWV/gxy422k5lw758MmGEsmesXSh0u5AWpfvOCygH8+SRdvo
	vgrvmZWpLXbAfveHwsZ1ux6ZCGGnmU3vpumvkd/Ugzh/e9LzZKFpsbolFK52DrrqDEghlqoCicr
	shKnEFZhjQMODifr3G9oHHHS58zEQIjzoF+EtQYWKLR0sQ==
X-Received: by 2002:ac8:6f18:0:b0:535:b506:11e8 with SMTP id d75a77b69052e-542b059d43dmr270409281cf.0.1793802303769;
        Wed, 04 Nov 2026 06:25:03 -0800 (PST)
Received: from toxicpanda.com ([153.61.196.252])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91e7dfb2f7dsm19989856d6.9.2026.11.04.06.25.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 06:25:02 -0800 (PST)
From: Josef Bacik <josef@toxicpanda.com>
Date: Wed, 04 Nov 2026 14:24:35 +0000
Subject: [PATCH v2 08/13] sys: use cred_ids_allow_control() for prlimit()
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261104-b4-cred-ids-v2-8-956213608f16@toxicpanda.com>
References: <20261104-b4-cred-ids-v2-0-956213608f16@toxicpanda.com>
In-Reply-To: <20261104-b4-cred-ids-v2-0-956213608f16@toxicpanda.com>
To: Christian Brauner <brauner@kernel.org>, 
 Paul Moore <paul@paul-moore.com>
Cc: Serge Hallyn <sergeh@kernel.org>, linux-fsdevel@vger.kernel.org, 
 linux-security-module@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openssh-sha256; t=1793802280; l=983;
 i=josef@toxicpanda.com; h=from:subject:message-id;
 bh=AmRLLf/ajEZHDzB808RxO2+24TBUMQvXN4g91Lyjmbk=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgUBr36M/n0nWN0DNbnxwzIiCZez6MG
 JiruuNaSCI/zXsAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QGpZzMvVaH4ibXmx5ousAath+mI0qxdFXNLVR2xSo9jo5cA9roD99j8rxu9C/s/7ztc5IbA7gAt
 1Ysj9JO0LIQk=
X-Developer-Key: i=josef@toxicpanda.com; a=openssh;
 fpr=SHA256:C8kOX2QUJCMqnCX+KEeoqRAjLo9L+ELOSH2NSAJHqGA

check_prlimit_permission() wants the real uid and gid of the caller to be
all three of the uids and gids of the target. Use the library.

No functional change.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 kernel/sys.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/kernel/sys.c b/kernel/sys.c
index e43491a9dceb..b341910f24ee 100644
--- a/kernel/sys.c
+++ b/kernel/sys.c
@@ -1716,12 +1716,7 @@ static int check_prlimit_permission(struct task_struct *task,
 		return 0;
 
 	tcred = __task_cred(task);
-	id_match = (uid_eq(cred->uid, tcred->euid) &&
-		    uid_eq(cred->uid, tcred->suid) &&
-		    uid_eq(cred->uid, tcred->uid)  &&
-		    gid_eq(cred->gid, tcred->egid) &&
-		    gid_eq(cred->gid, tcred->sgid) &&
-		    gid_eq(cred->gid, tcred->gid));
+	id_match = cred_ids_allow_control(cred, CRED_IDS_REAL, tcred);
 	if (!id_match && !ns_capable(tcred->user_ns, CAP_SYS_RESOURCE))
 		return -EPERM;
 

-- 
2.55.0

