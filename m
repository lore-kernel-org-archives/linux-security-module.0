Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 237E33C1D48
	for <linux-security-module@vger.kernel.org>; Wed,  9 Sep 2026 19:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788982666; cv=none; b=b8U6it/XKd+1wd7jsNPL4tgyugMeXTeEw38z2bZ3/rHm4q+IciKE5I88+RXnxgyRpVOt/rcE65b36tPcyXrkX6xcuAAi+ujsv10OTxhSAsjpRn6LLoe1kanLCArAR/maG3KbajcI/qbnbIkHCw/wfBy3gDBiVMdJeHAyJUOjcWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788982666; c=relaxed/simple;
	bh=1LzvLV16xeBAkstMGb/MXqY0fnWj9soFnay87GQLE4I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lUbUKX9EmjsUA6seHnKZWfT8SagjDJWHrGxnK1TVvFbWpL5MT861Xp4xd5nafCJNAJ0vuOONu0pWGHYVOUbLnd6xvyZAe+B9qhz43s6SWbBDlBdjwz0Y8AjEb2nFbfwP0bWoXf0az+ciJ9UJc37+UHOyTV7mjj1lrBGze8lP9xI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JQUApE5n; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JQUApE5n"
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-861f30636f9so98968557b3.0
        for <linux-security-module@vger.kernel.org>; Wed, 09 Sep 2026 12:37:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788982664; x=1789587464; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gtEYMRE/KFKlT1/9bXmERUsL0M9lvoNkItLmndtSgzs=;
        b=JQUApE5n99dyerryUAtbX4T3wFcxmhOhMp/XL6CtqilC1uucsGziGBY91J92vSLZYN
         IrH3V72+1yBLHLbRpaR2zVW4nPnAhnTz7NAd0Tqb/e3dESNrpkfXaSHk2PeuOKG1JbN0
         qKMO8FARWnzIvT0LLqBtlYlEDnHxUKlNzhlrF93aZnh5AzfTJzENv+jHeMxbAKckSiCt
         B3TmVeeSZHEtWYwdqgslVE30woIUNnuhIP5cYTZHKaEH/4Mke+OO0ZiM+9iOVvkWb9tO
         aX7valwJl06aescUImrzZC7zlSFMEUR9lE9ZtsDs3EYv/lZiHWoTKbVrJn2F/mKBS5Wt
         iIOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788982664; x=1789587464;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=gtEYMRE/KFKlT1/9bXmERUsL0M9lvoNkItLmndtSgzs=;
        b=BIr5JbRUNeU1K4nZktBCHSYZ0nv918MBAZiQD1WgA851snWjkcCTQ9k19NukCqqZ83
         7Ll+LmsJy6NnlZyhR/WrsAyE/Ji/OtalE4dnuDMw/xA2/0+yjNMyupa5MLuMooEOVojC
         55uocNTlf9CzUoMSSQinIodyIq2VmM/+Rl8FACXxiR7PrFnmujWKGQlHtl3EFSxSqx04
         zNlcrh8f5T36zsSjTFaMzew14FFyBnqjDpq3M3XDs07TmMdWJ0u66yaTpaOMCxXJJdyS
         N6yHDDTjyJu63TeYnaR4BT2lO25XLHKX9NiZdh1K9RinOj+PjP2YQNe7kDnVS/E12Yun
         VR4g==
X-Forwarded-Encrypted: i=1; AKwUvBzC+gl5XpR/kluiHdFDZIY0sQvK/keOKXzdmignhiLtlfsFdRqeuWiLjQ08XVeHC11FP5eXocZkmgGRiHlobiRWOi+gtZM=@vger.kernel.org
X-Gm-Message-State: AFuF++lIAxE/eY3TBP+7uqg0j3tXTpWryOyQiLldPHZKmLiJWplomA4R
	YQz78Ctpsarv7/QILVh5vtu+7k2zhbDbBe1MhSyUeihHJN1AAvEOtyJ0
X-Gm-Gg: AYBFou0Xh2g6RXevYz++dFxKomvC5SOYmoNpnz2etA4OQiYYjs/odhXDcSNt+1Av1XH
	Y80KA5A4zLct6CSFkzw6JnXFlaoOCHEDTVo8PxIsgiyVosI06y79Tesh9ZSvnVvj1yaGHTLbuD0
	eGdyBP6kb2JFlBCyvW8TyAvw0iWeEGXxsTyGx4ptPKWTc6PXw0/9Sjj4/MQUPdh0gZ2RZ0RPR/W
	D9D3Q5DJiSLy6JHiEUkua7YS/XdSWec/8UfukHBC450K14fzPk7zf+dN7TddnnvacQq6KX+CiPZ
	WrvRFGxm/AfMAPpY6C9AQkbsWEsRsHrIuSq8kcD2c5759JB3fZPSNN4EUCqVVLLmtOe9OWOa8t1
	yc/LAyub/Wm43idpBcHLHCyTvjgUiFjvSEw4CO4d0c/QqlhsJlAByeHRAp2ZWqhW3jfmb9xEkv3
	0A9YFmQq2zX4jV2TgRCT/JRKEtgKoz7uu32M4YqT7DO4WP6RNT8/tGAdxpIYG2LBF/nbV7TGpJl
	wMzArcxQ5MkT+tF51CUlCR/PY72t+1a
X-Received: by 2002:a05:690c:c501:b0:871:a319:3ee8 with SMTP id 00721157ae682-871a31948c5mr132151937b3.10.1788982663710;
        Wed, 09 Sep 2026 12:37:43 -0700 (PDT)
Received: from zenbox ([2600:1700:18fb:6011:bae:bfc2:7e96:e5c8])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-871493155d3sm115277577b3.16.2026.09.09.12.37.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2026 12:37:43 -0700 (PDT)
From: Justin Suess <utilityemal77@gmail.com>
To: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	kpsingh@kernel.org,
	matt@bobrowski.net,
	paul@paul-moore.com,
	mic@digikod.net,
	viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	kees@kernel.org
Cc: casey@schaufler-ca.com,
	gnoack@google.com,
	jack@suse.cz,
	song@kernel.org,
	yonghong.song@linux.dev,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	memxor@gmail.com,
	jolsa@kernel.org,
	m@maowtm.org,
	bpf@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Justin Suess <utilityemal77@gmail.com>
Subject: [PATCH bpf-next v3 02/15] lsm: Add the bprm_apply_policy_object LSM hook
Date: Wed,  9 Sep 2026 15:37:05 -0400
Message-ID: <20260909193719.518517-3-utilityemal77@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260909193719.518517-1-utilityemal77@gmail.com>
References: <20260909193719.518517-1-utilityemal77@gmail.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the first policy object operation, applying a policy to the
credentials prepared for an execution:

  bprm_apply_policy_object(bprm, object, flags)

The hook is only called between the preparation and the commitment of
the bprm's credentials, i.e. from a bprm_creds_for_exec() or
bprm_creds_from_file() context, where the executed task can still be
arranged to start confined by the policy.

How the policy composes with restrictions the credentials already
carry, and the meaning of @flags, are defined by the implementing
LSM, which must reject unsupported flags with -EINVAL.  An LSM with
no notion of applying a policy object to an execution does not
implement the hook, and the calling kfunc fails with -EOPNOTSUPP.

Like the lifetime hooks, this hook is excluded from the "bpf" LSM's
attachment points, as the targeted dispatch makes an attachment there
unreachable.

Cc: Paul Moore <paul@paul-moore.com>
Cc: Casey Schaufler <casey@schaufler-ca.com>
Signed-off-by: Justin Suess <utilityemal77@gmail.com>
---

Notes:
    v2->v3:
        - No change.

 include/linux/lsm_hook_defs.h | 2 ++
 kernel/bpf/bpf_lsm.c          | 1 +
 2 files changed, 3 insertions(+)

diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.h
index d7684407737a..ddb15bea383e 100644
--- a/include/linux/lsm_hook_defs.h
+++ b/include/linux/lsm_hook_defs.h
@@ -452,6 +452,8 @@ LSM_HOOK(int, 0, bpf_token_create, struct bpf_token *token, union bpf_attr *attr
 LSM_HOOK(void, LSM_RET_VOID, bpf_token_free, struct bpf_token *token)
 LSM_HOOK(int, 0, bpf_token_cmd, const struct bpf_token *token, enum bpf_cmd cmd)
 LSM_HOOK(int, 0, bpf_token_capable, const struct bpf_token *token, int cap)
+LSM_HOOK(int, -EOPNOTSUPP, bprm_apply_policy_object, struct linux_binprm *bprm,
+	 struct lsm_policy_object *object, u32 flags)
 LSM_HOOK(int, -EOPNOTSUPP, policy_object_from_fd, int fd,
 	 struct lsm_policy_object **object)
 LSM_HOOK(int, -EOPNOTSUPP, policy_object_get, struct lsm_policy_object *object)
diff --git a/kernel/bpf/bpf_lsm.c b/kernel/bpf/bpf_lsm.c
index f762cac6838b..f3de70511c0f 100644
--- a/kernel/bpf/bpf_lsm.c
+++ b/kernel/bpf/bpf_lsm.c
@@ -56,6 +56,7 @@ BTF_ID(func, bpf_lsm_xfrm_decode_session)
 #endif
 BTF_ID(func, bpf_lsm_ismaclabel)
 BTF_ID(func, bpf_lsm_file_alloc_security)
+BTF_ID(func, bpf_lsm_bprm_apply_policy_object)
 BTF_ID(func, bpf_lsm_policy_object_from_fd)
 BTF_ID(func, bpf_lsm_policy_object_get)
 BTF_ID(func, bpf_lsm_policy_object_put)
-- 
2.55.0

