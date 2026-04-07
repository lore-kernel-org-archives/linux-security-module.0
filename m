Received: from mail-yx1-f48.google.com (mail-yx1-f48.google.com [74.125.224.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E915638910E
	for <linux-security-module@vger.kernel.org>; Tue,  7 Apr 2026 20:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775592178; cv=none; b=bRr+z3ilwwQhcD+k4SiWyWJyZM2ppoy4+yxNLm88ToitpSrf97vHmV72bdGvsXi5o/87jaPjq8EnLBDEVg0I6uh6/Zl3/ThZ2KryVPW781st2zoLqTjSvINRiv2x3slA6neVKuIOCsZmaVEFCb7RWSxIyHRPHmNQ8N1PWFP0+Ns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775592178; c=relaxed/simple;
	bh=CmtKHOc332qKALJYWCWgXBnvrRYVAERnFXRVui+qI44=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JcXqXcegF9WR/eZf1qTVjzuDmMGC9vcEQdQAD3jnkHsNhZtxkv8Aw2w9XgL8VMHPfJal0UxCEPws4Tzpua+HdJwCb7APpbSoFOkm1/facXJggqLrrfMrF0YoEHgARjUvRVWUi8tWezH58qU9x7/raxhLj03UO9ukUpKHM+aCvts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OvRx75UH; arc=none smtp.client-ip=74.125.224.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OvRx75UH"
Received: by mail-yx1-f48.google.com with SMTP id 956f58d0204a3-6500eae6d2fso5544819d50.1
        for <linux-security-module@vger.kernel.org>; Tue, 07 Apr 2026 13:02:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775592175; x=1776196975; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cMKVwFWhx9p/bEmXNWYwd3ePZhFhwvaKwwQ8qBoxvaM=;
        b=OvRx75UHfpBZZXZyBICCoXtAnF6tUkJpi66vOk/+BVVg27EvOn7C6o/cFjxwtCV9jV
         91mNr3r8xmZns5taDG/hxzbLqACblWgu/FSx0tpVSFdGUYGZONAB4NFexRUYMFFcs12C
         TDsFZWvMD/+T+cU6wMrw9I5l7PZoeAI2zo/ReJwE4ZLBcH1pOpe7+C01CGmn104blOk7
         e/sLsPhXtGIkFFnVi3JTnrtonZ3DDke6QwPMiqZ83asCCjpvkLtKCX5WbPXYhA6zNdCS
         9A82DqkuQgRV5tgeB582j+AbwPJKRg13dDIHEM7IciVSm3oZYCcNFs2yG8+8Pfcczn0l
         9keA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775592175; x=1776196975;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cMKVwFWhx9p/bEmXNWYwd3ePZhFhwvaKwwQ8qBoxvaM=;
        b=oZQlFYtJJeO7fQtKnG/Y5Qcc9PYhJvYTO8VlrAPtFrcu4YI2K8P85AYwBbKAscicvV
         c/IT1e6zRPLWP4wu7bMEfHSJnSFWlXKAW3iv+WB4sfWB3EpJEb5yEQmF+xLJHhcaI103
         LY0fuxn67DudfPPtbRhZj5NnjJ/TL+LADc+UDiM2sVMEZPE3hhjw95TuNtEtkoh48XqF
         z4ULLWnqI2paJRVt2KTtd1oAAOzBD//HvKDsiHGuLUZgo4S6oFOZYI6zkcv3a4w/eH6u
         5IorSOcfH3dwI3b0sIxkx7/DtN4Rr0nwQ5Oi9uX+TIFS73iYvPAJkjjH0CK9NqlkB0mc
         TmLQ==
X-Forwarded-Encrypted: i=1; AJvYcCWyguaq2fSWET4Upz1nP9Aj8RfBwDtcsPo8Er805Aksts3NHrroJ1CX9nc7l81rpTzn6hZXnjexTIBRRwSwVdmeC7qeEj4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwRcB0VZKARDCvMzGbzM+R2Ca1P3tMfeg2/n2c+i7pq4ysRLjz1
	IGYyjzFgQS+MKk6Be/G/qXkPzYCbjmYJcohbXA2wiWAxgKlmFEKWSCIs
X-Gm-Gg: AeBDievmXwdodSAedN46KeeFdwwZCZR+NjHcuUqAhlKRRW5DDiM3vItMsyOsyxR/CCF
	Q+1O8pOyvKXom9L+l9PlW6qlqZquoDlOv76qOgSTUMnIeeGJ2kYFVMSX71rz+UXwPBks5g9GiZq
	wRI9I/1WscLJPJAcbrHXZEFk8nETf7FKwUYuKsbtWqbWo4/cXEV6DaB7U/D3tA9+XwDxa8IwzTM
	X7LDo2NtBL2PhximRcnSfsMmLrOf+f6Zhfpo2+FO+lxHoF5iQWhJFBhJrT+mRrXzDwnn06orzPM
	ieL9izjIvElIyCv9jr78Ded+YmcuQMWIwOP1rBPLC10TOpRbQtv+LtPPG1+1dfTd2b6hC4wMib0
	MlCrWOEMy3klTbFgSx1xEjhQAG7zCMhesmPplCqm8icOi6UQmKgQ1F4znlzAhfU+giyj1276uL2
	z3+LFWv09OUDZprA9zTc2a4eap/X9vNPgoYvNIWny1DjFdIfMaa6JItKNWXqJwcduN5ncn8LJn
X-Received: by 2002:a53:c709:0:b0:650:4a4:e0fe with SMTP id 956f58d0204a3-650488904fbmr12715781d50.66.1775592174870;
        Tue, 07 Apr 2026 13:02:54 -0700 (PDT)
Received: from zenbox.prizrak.me ([2600:1700:18fb:6011:92f8:8594:e84e:1d9a])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-6503a828f3csm8354078d50.3.2026.04.07.13.02.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2026 13:02:54 -0700 (PDT)
From: Justin Suess <utilityemal77@gmail.com>
To: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	kpsingh@kernel.org,
	paul@paul-moore.com,
	mic@digikod.net,
	viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	kees@kernel.org
Cc: gnoack@google.com,
	jack@suse.cz,
	jmorris@namei.org,
	serge@hallyn.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	martin.lau@linux.dev,
	m@maowtm.org,
	eddyz87@gmail.com,
	john.fastabend@gmail.com,
	sdf@fomichev.me,
	skhan@linuxfoundation.org,
	bpf@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Justin Suess <utilityemal77@gmail.com>
Subject: [RFC PATCH 19/20] bpf: Document BPF_MAP_TYPE_LANDLOCK_RULESET
Date: Tue,  7 Apr 2026 16:01:41 -0400
Message-ID: <20260407200157.3874806-20-utilityemal77@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260407200157.3874806-1-utilityemal77@gmail.com>
References: <20260407200157.3874806-1-utilityemal77@gmail.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Document the BPF_MAP_TYPE_LANDLOCK_RULESET map type and explain the
kfuncs it is associated with.

Signed-off-by: Justin Suess <utilityemal77@gmail.com>
---
 Documentation/bpf/map_landlock_ruleset.rst | 181 +++++++++++++++++++++
 1 file changed, 181 insertions(+)
 create mode 100644 Documentation/bpf/map_landlock_ruleset.rst

diff --git a/Documentation/bpf/map_landlock_ruleset.rst b/Documentation/bpf/map_landlock_ruleset.rst
new file mode 100644
index 000000000000..90f3141a829b
--- /dev/null
+++ b/Documentation/bpf/map_landlock_ruleset.rst
@@ -0,0 +1,181 @@
+.. SPDX-License-Identifier: GPL-2.0-only
+
+==============================
+BPF_MAP_TYPE_LANDLOCK_RULESET
+==============================
+
+``BPF_MAP_TYPE_LANDLOCK_RULESET`` is a specialized, array-backed map for
+holding references to Landlock rulesets that were created from userspace.
+It is meant to bridge BPF LSM policy selection with Landlock policy
+enforcement: userspace creates a normal Landlock ruleset, inserts its file
+descriptor into the map, and a BPF LSM program later looks up that ruleset and
+applies it with a Landlock kfunc during ``execve()`` preparation.
+
+BPF programs cannot create, inspect, or modify Landlock policy through this
+map.  The looked-up object is exposed only as an opaque
+``struct bpf_landlock_ruleset`` reference.
+
+The map uses ``__u32`` keys as array indexes and stores one ruleset reference
+per slot.  Like other array maps, its size is fixed at creation time and its
+elements are preallocated.
+
+Usage
+=====
+
+Kernel BPF
+----------
+
+.. note::
+   This map type is only supported for BPF LSM programs.  In practice, it is
+   useful for sleepable BPF LSM programs attached to
+   ``bprm_creds_for_exec`` or ``bprm_creds_from_file``, because those are the
+   hooks where the associated Landlock kfuncs are available.
+
+bpf_map_lookup_elem()
+~~~~~~~~~~~~~~~~~~~~~
+
+.. code-block:: c
+
+   void *bpf_map_lookup_elem(struct bpf_map *map, const void *key)
+
+Lookup returns a trusted pointer to an opaque ``struct bpf_landlock_ruleset``.
+The verifier treats the result as a referenced BTF object, not as a pointer to
+the raw ``__u32`` map value declared in the map definition.
+
+Each successful lookup acquires a ruleset reference.  The BPF program must
+release that reference with ``bpf_landlock_put_ruleset()`` on all paths after
+the lookup succeeds.
+
+The returned pointer is intended to be passed to
+``bpf_landlock_restrict_binprm()``.  It is opaque and cannot be dereferenced
+or inspected from BPF.
+
+bpf_map_delete_elem()
+~~~~~~~~~~~~~~~~~~~~~
+
+.. code-block:: c
+
+   long bpf_map_delete_elem(struct bpf_map *map, const void *key)
+
+Delete removes the ruleset reference stored in the selected slot and drops the
+map's own reference to that ruleset.
+
+Landlock kfuncs
+---------------
+
+The map contains objects designed to work with the following Landlock kfuncs:
+
+.. code-block:: c
+
+   void bpf_landlock_put_ruleset(const struct bpf_landlock_ruleset *ruleset)
+
+.. code-block:: c
+
+   int bpf_landlock_restrict_binprm(struct linux_binprm *bprm,
+                                    const struct bpf_landlock_ruleset *ruleset,
+                                    __u32 flags)
+
+``bpf_landlock_restrict_binprm()`` applies the looked-up ruleset to the new
+program credentials that are being prepared for ``execve()``.  The ``flags``
+argument uses the same Landlock restriction flags as
+``landlock_restrict_self()``, including ``LANDLOCK_RESTRICT_SELF_NO_NEW_PRIVS``.
+When this flag is used from BPF, ``no_new_privs`` is staged through the exec
+context and committed only after exec reaches point-of-no-return.  This avoids
+side effects on failed executions or ``AT_EXECVE_CHECK`` while ensuring that
+the resulting task cannot gain more privileges through later exec transitions.
+
+Userspace
+---------
+
+bpf_map_update_elem()
+~~~~~~~~~~~~~~~~~~~~~
+
+.. code-block:: c
+
+   int bpf_map_update_elem(int fd, const void *key, const void *value, __u64 flags)
+
+Userspace populates the map by writing a Landlock ruleset file descriptor into
+the selected slot.  The map uses FD-array update semantics:
+
+- ``key`` points to a ``__u32`` array index.
+- ``value`` points to a ``__u32`` containing the ruleset file descriptor.
+- ``flags`` must be ``BPF_ANY``.
+
+The supplied file descriptor must refer to a valid Landlock ruleset.
+
+Userspace lookup of map contents is not supported for this map type.
+
+Example
+=======
+
+Kernel BPF
+----------
+
+The following snippet shows a sleepable BPF LSM program that looks up a
+ruleset, applies it during exec credential preparation, and releases the
+lookup reference.
+
+.. code-block:: c
+
+   struct {
+           __uint(type, BPF_MAP_TYPE_LANDLOCK_RULESET);
+           __uint(max_entries, 1);
+           __type(key, __u32);
+           __type(value, __u32);
+   } ruleset_map SEC(".maps");
+
+   SEC("lsm.s/bprm_creds_for_exec")
+   int BPF_PROG(apply_ruleset, struct linux_binprm *bprm)
+   {
+           const struct bpf_landlock_ruleset *ruleset;
+           __u32 key = 0;
+
+           ruleset = bpf_map_lookup_elem(&ruleset_map, &key);
+           if (!ruleset)
+                   return 0;
+
+           bpf_landlock_restrict_binprm(
+                   bprm, ruleset, LANDLOCK_RESTRICT_SELF_NO_NEW_PRIVS);
+           bpf_landlock_put_ruleset(ruleset);
+           return 0;
+   }
+
+Userspace
+---------
+
+The following snippet shows how to insert a previously created Landlock
+ruleset into the map.
+
+.. code-block:: c
+
+   int populate_ruleset_map(int map_fd, int ruleset_fd)
+   {
+           __u32 key = 0;
+           __u32 value = ruleset_fd;
+
+           return bpf_map_update_elem(map_fd, &key, &value, BPF_ANY);
+   }
+
+Semantics
+=========
+
+- Map creation requires ``CONFIG_SECURITY_LANDLOCK``.  Otherwise,
+  ``BPF_MAP_CREATE`` for this type fails with ``-EOPNOTSUPP``.
+- Map definitions use ``sizeof(__u32)`` for both keys and values because
+  userspace writes ruleset file descriptors into the map.
+- From BPF, only ``bpf_map_lookup_elem()`` and ``bpf_map_delete_elem()`` are
+  supported for this map type.
+- From userspace, insertion is done with ``bpf_map_update_elem()`` using a
+  Landlock ruleset FD.
+- The looked-up value is an opaque, trusted BTF object reference, so BPF must
+  treat it as a handle and release it with ``bpf_landlock_put_ruleset()``.
+- ``LANDLOCK_RESTRICT_SELF_NO_NEW_PRIVS`` on the BPF path pins the resulting
+   task with ``no_new_privs`` after exec is committed.  When used from
+   ``bprm_creds_from_file``, this does not retroactively suppress privilege gain
+   for the current exec transition itself.
+- If Landlock support is disabled in the running kernel, programs using the
+  associated Landlock kfuncs may still load, but the kfunc call returns
+  ``-EOPNOTSUPP`` at runtime.
+
+See ``tools/testing/selftests/bpf/progs/landlock_kfuncs.c`` for a complete
+example.
-- 
2.53.0

