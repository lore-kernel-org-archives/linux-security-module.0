Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F6FB3BFE33
	for <linux-security-module@vger.kernel.org>; Wed,  9 Sep 2026 19:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788982690; cv=none; b=orhY4D24Nj4L5mnBM6RG75G9VFIu/nAizO3XjKoRi+sM66cWw2qUAjx+UUukk6l5IhAdfgPuOQMSwpb9OIdTypja4dhBs8lUSTaCaKxSMWde432hXKNf0GGBSFAeJdxmz3xGWvPLuYJ0/C24z/JekWTjlQZqbTXe9gZ2dMEcMHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788982690; c=relaxed/simple;
	bh=gK5MnwxSIYAl7ZmjTB1FKOm55yKxqXXey3cseNQLAt4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c0WypIcO0UC4sqWcaCBJoN10ye9kLT7Iu8W58kDmXa8ZxqVApEPwJMRI3C++oyGwj93dTYsBbdgj5ef44fq/8rQ2nux/ZZYGB8p1Y+34W7RauEO+UJmzs/Z0MksJoj24v44dyzxXQqP3++PJPiovD2Ty22COepdeHodMtTWJf9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mCl06AXg; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mCl06AXg"
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-864cd11a932so889427b3.0
        for <linux-security-module@vger.kernel.org>; Wed, 09 Sep 2026 12:38:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788982687; x=1789587487; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ZqUYtQxdenK0ojTeBznvGiMR4AWulNf4CY2WGcBzpw0=;
        b=mCl06AXgDgW+7opueNvlzgNxuRKgcNQjkHarp1U5ZlThuNwTckUAgcCJ7Vkq3qcowb
         YLFR06YqtXIMFPXny0RuBidOdhMUPcpSE47WQU8TXGcHfXyaJonC5RLjPQIxMME50OEV
         I3Wrgl1pkpy9M+n3tCL20TQNn1FxHTYRmC+bfEweZTJLn2u6b2xqXdOYWJwb5mEE8j8V
         xC/wwFTBJ+0ZMlmXKQKJjKrXfsKza4XiCV/a9nKnc5wsUT5W0qDNOfAVnA3aTWclZi1B
         Bv3xFOxDQzIBTiMKMDyWLcg0semiYSKOWIeItVGAGAJzb8V0K69Qul6doa9hdsLOjiZB
         JWjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788982687; x=1789587487;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ZqUYtQxdenK0ojTeBznvGiMR4AWulNf4CY2WGcBzpw0=;
        b=BUa8H6XQEs5jxKYPpgVIzopsDvxCVQtABAaYRiwWedCOyND0C9DmRLH4z2eLWPiYHq
         kfZSeXVb6BEo5fgJSxrTURHi37dNSIJyafoipiCloppsEFQM0BLT/1ACfVFCUH6auDM9
         5n45P+63gac0CqNwXjazqsllKvr9eSOWFuQLDVvB7rPkbJE24YoTxA0Y5Xgy25jnzqnA
         B3qqGjxIteLEqa7YJ0Kk5ZOF8YFPSHfvKplRO5FC/7P8IG+79mfs2+pk1jEHnBBUCL0B
         aN2wAfNJJjGxCXdzaTNCXA0z7Nk04C6PmupzmYlJW98ZQPw7N/RLQn9m36NiiWSjrjjC
         yyHQ==
X-Forwarded-Encrypted: i=1; AKwUvBzUj1kDIyJI1HLF9o7BPCb3sBurnTq8XDpCwGzXK06jkChNmIwdE43jEvV18n+HmyunQ1Hw8rk+zyFHcv9CJzhn6vgOp50=@vger.kernel.org
X-Gm-Message-State: AFuF++mfCZWVou7hjBHtG55L1h2jpc10eeFHm4U4dFWuKNpgz6T5iGgq
	0U2T2pZ15d6SI8x84MXUyL5EHgW/FIwjMhP8EwfDp3LD3Yt5t0Mo1ssM
X-Gm-Gg: AYBFou1I6IhJpePNpTyLYaX7al6PTDwCKk+SXZLU0vCtLHxGzt/Dt+Xp+Dutm30qS/h
	GEkpFjT6L89otuPEx99i6kjFlP5luEREoq/bwEFWhCzyMjp2566o4FZIkJCl0g7T3BGnV3vBun/
	uPIXJ1Wdz9Jmn7Yiq5HQPST27aF82sh0YN4NoU3ApyjAolJwW5qxRvEieSFhEo2edWUCISymc/D
	K/jBPJ9W5vHjeI5rnfWyzih7h6YMnGiNI98BW0ERsPByXBX955gTEj7zKdWAWp00lehmoVvVcL6
	cQ1yc8Q/+fB4Z/jehb+5JiU0KuVDAnre2EFdlR2SlVere/QfO/mUEVs9RhAFjL2o0EzGoTZHU03
	WjExqL9VF+NIOkgKwDVs/Es3MrDq54Y8lRUPQhqoyiQhbE7xYfWoEnjgGGHXjIZ9hrHkjsn/Du1
	KnOl+Z1sRmWyJEkDz/QMmlVmhA7Z0V3xwxUr0EDNQPVnkLxqmejpYr1LSRE+bcxH4fhDgcFyVxZ
	4iGNZVPDyHqZbsfumdBdMh2NHtcvJUm
X-Received: by 2002:a05:690c:9c0d:b0:861:850e:dd59 with SMTP id 00721157ae682-882018855cemr4754927b3.9.1788982686908;
        Wed, 09 Sep 2026 12:38:06 -0700 (PDT)
Received: from zenbox ([2600:1700:18fb:6011:bae:bfc2:7e96:e5c8])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-871493155d3sm115277577b3.16.2026.09.09.12.38.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2026 12:38:06 -0700 (PDT)
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
Subject: [PATCH bpf-next v3 08/15] lsm: Document the LSM policy object interface
Date: Wed,  9 Sep 2026 15:37:11 -0400
Message-ID: <20260909193719.518517-9-utilityemal77@gmail.com>
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

Describe the split of responsibilities in lsm-development.rst: the
LSM framework owns the BPF-facing kfuncs, an LSM opts in by embedding
struct lsm_policy_object, tagged with its lsmid and an LSM-private
type, and implementing ordinary LSM hooks, and the lifetime contract
those hooks must satisfy comes from BPF's execution model.

Cc: Paul Moore <paul@paul-moore.com>
Cc: Casey Schaufler <casey@schaufler-ca.com>
Signed-off-by: Justin Suess <utilityemal77@gmail.com>
---

Notes:
    v2->v3:
        - No change.

 Documentation/security/lsm-development.rst | 49 ++++++++++++++++++++++
 1 file changed, 49 insertions(+)

diff --git a/Documentation/security/lsm-development.rst b/Documentation/security/lsm-development.rst
index 5895e529da7f..190d9b8f2346 100644
--- a/Documentation/security/lsm-development.rst
+++ b/Documentation/security/lsm-development.rst
@@ -15,3 +15,52 @@ see ``security/security.c`` and associated structures:
 
 .. kernel-doc:: security/security.c
    :export:
+
+LSM policy objects and BPF kfuncs
+=================================
+
+The LSM framework implements an interface for individual LSMs to
+expose their policy through BPF kfuncs and kptrs. An LSM may not
+export any kfunc or other BPF interface directly.
+
+An LSM opts in by embedding ``struct lsm_policy_object`` in one of
+its own objects, setting its ``lsmid`` to the LSM's ``LSM_ID_*``
+value and its ``type`` to a nonzero value of the LSM's choosing, and
+implementing the policy object hooks (``policy_object_from_fd``,
+``policy_object_get``, ``policy_object_put``, and per-operation hooks
+such as ``bprm_apply_policy_object``) like any other hook, resolving
+the containing object with ``container_of()``. The ``type`` namespace
+is private to the owning LSM, which uses it to tell its own policy
+object kinds apart; the framework never interprets it, and 0 is
+reserved as "unset".
+
+The kfuncs, defined once in ``security/bpf_lsm_kfuncs.c``, dispatch
+each call on an object to the single LSM matching its ``lsmid``. The
+fd translation has no object yet: the framework offers the fd to
+every ``policy_object_from_fd`` implementation in turn, and an LSM
+declines a fd that is not one of its own with ``-EOPNOTSUPP``; any
+other error fails the translation. A program that expects a policy of
+a specific LSM can read the returned object's ``lsmid``. Either way,
+a BPF program reaches an LSM the same way every other kernel caller
+does, through an LSM hook, while the BPF verifier tracks the object
+as a referenced kptr.
+
+An LSM opting in must satisfy the lifetime contract that BPF's
+execution model imposes: the containing object is reference counted,
+``policy_object_get`` acquires with inc-not-zero semantics and fails
+once the count dropped to zero, ``policy_object_put`` may be called
+from contexts that cannot sleep (map destructors), and the object's
+memory is freed only after an RCU grace period, as programs load
+policy object kptrs from BPF maps under RCU. Hooks for operations an
+LSM does not provide are simply not implemented: the corresponding
+kfunc then fails with ``-EOPNOTSUPP`` at runtime. Whether the LSM
+providing an operation is built in and active is likewise a runtime
+property: the kfuncs are always registered when ``CONFIG_BPF_LSM`` is
+enabled, so BPF program loading is independent of the boot-time LSM
+configuration.
+
+.. kernel-doc:: security/bpf_lsm_kfuncs.c
+   :identifiers: bpf_lsm_policy_acquire
+                 bpf_lsm_policy_apply_bprm
+                 bpf_lsm_policy_from_fd
+                 bpf_lsm_policy_release
-- 
2.55.0

