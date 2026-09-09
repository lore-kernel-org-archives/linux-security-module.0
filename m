Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 636023DB964
	for <linux-security-module@vger.kernel.org>; Wed,  9 Sep 2026 19:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788982718; cv=none; b=a+GvhTsmVyXRCyN1RPfcTXsTRBX6QqPqhT8XJN76E+OoMXMUrJwEYIbl2vzp9hUXZTDFNsz1CqW10qMaBXosROthlZBRY0v3w0FA3r0nKzKec5+qsvFcZNabeFVFCFhyus5yjoFXzd+YncT8v86awm6/6ewnMGcTzfRFOfkjTlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788982718; c=relaxed/simple;
	bh=waHQHiFfqMIJ1vdwpMD2w/AcnmEjSVLl6pRymyrAAEA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=H53xBsO49nCKTawcwDivA9UfZMcZwwm7CArbHU97etkkpGz7cUzOw4+HzkRMJP9mjYrMforoe/OESUM0fd2zy6yuYt+0jrcyB0ElDXGPKArN0KziM6/1SG9p/9wkcF3Vi9SfpBeJFWQG+hX+crYNH8VO5SPieCrmNH2ZPblF1Vc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RennIaof; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RennIaof"
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-8623b1e7cb2so45764767b3.1
        for <linux-security-module@vger.kernel.org>; Wed, 09 Sep 2026 12:38:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788982713; x=1789587513; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=evloMT+R7+GF/RTy6Xj0kggqlRDodR8G5+ybCy69Si4=;
        b=RennIaof8bDg1nyCeSmOO/nBVNKQvsg6zxKyFVvh6XJVN42lXt3u8hAF+CxYuFJd/E
         cqIkqbpYtty7EUeYmAsfub28euj5mEKyb5mfqmxsrP29IysLnHeW+7oiPB9kwkedcNTO
         gX2mo7+UoA1dVhq3ljI4VKrzds9z2cboEUHp78cpZCPjPRU0VXBk0I40V/sNFVoF1F9M
         MC2yCUxmWTDTwu6thElzBwS5JGVqshXbFP3okzf27IJ4Hm9S4FHaNDw+RHzwW3NQcac/
         Ul5TrYDn0aP0FlL39f8oD6r+wUSCnVlBleOlo9nordQz57wqxWG0X5oGgFpP8/P+kOvy
         nn8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788982713; x=1789587513;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=evloMT+R7+GF/RTy6Xj0kggqlRDodR8G5+ybCy69Si4=;
        b=Q7ZE9MZTrpZfrInhXsTMjZ76xcEYuQeoBx/wzZDvrPulwvF7ZhfU0owXB3eOe4xZbx
         +OVtcEkkQEEfyi6Tbx4LLl+YMalqT8sCRK+HUWZIXcoyDXfRYnVs+BC/KYmt21um/GMY
         a+3WGxcfJfoMUGEtr8cPcErc0kTo+c1B743z97t5EZJAMyR6duUWZpH6qiKozhrFnW95
         yDEf8I3kWHKOWGOpuAZvEUmv50MTU03+Eie+Iq9h8yvN9OiWoY3AebhEybmj7l0KUHpV
         1WExiH5rPqyPCYpiJOdKu29ntlnU3B2eucCIdawfFjCwOwEv4i5NjqQSKMe6cXATY90B
         KxQQ==
X-Forwarded-Encrypted: i=1; AKwUvBxLM6XDeVBmoJX3CYi9NTmPU9ZptZJ5indRo5+JRyvshWyCgv+kBayOKIV0GhL64EQibWZ4BEXmt9eTCqMQo2+O5fQLjGQ=@vger.kernel.org
X-Gm-Message-State: AFuF++mfKMBVFng/AFwIAg6aDbpqaiJngHu30ZJNx/nO6oE9bklynCBM
	lNm4GT/EAwxxCbMMxsq+1uqDhdHuzk7ETm3VTK+dhZbXOqZVv2yhbBRp
X-Gm-Gg: AYBFou3FEmI+F55ptWoT4hi7dZ3MoEE4FdEj/gYSqW7F+dPq/Kqp0GtLcHc+M8N61Ws
	c3lO3IT74lZffZzxHgMfoCMkdNqygCkdAPObhzXjZ8fnNwgMUMK1Q196Z5iY1Fd5oCMSGPCKnRc
	j0FpKEWJ7frKDvw+tEtxMA7POwFnjv5o24eY/Tk6ITf9H2GI6lIUaVzN5R4tsc63GZzy0/W5+kw
	rb8DlHUSLuit7YfeG0TcfTLzee9fPdtGjlvLguAFYHQJ/3oZ22j9zl02KBwoDrrj8MXfvgwuMfA
	kWa2z0zwP0q2IWJrhrAdCdC8jZ0UY/aiMMDY6l4zwkrKg3W81vB7BzyQ1svGIwMW9w/UBxwTLfS
	vcGl5EV50hf+t6AkqrHPGiDoAmBEhLoZz65IpeJhhzJDOtmDhhjg2PNU+3orNpHApZ+gqXfDNXB
	cTleebRnVd5e6E/9IdYuLIoYM2FwBoJ2o7J1MInFET1GiRLEfm138Iabh37vkxeQ+8bmQOPJN+1
	W6QAEhupiBO3+VcjyhjutGnkuHZVrTO
X-Received: by 2002:a05:690c:6508:b0:873:5c0f:28d with SMTP id 00721157ae682-8735c0f03eamr136509517b3.55.1788982712679;
        Wed, 09 Sep 2026 12:38:32 -0700 (PDT)
Received: from zenbox ([2600:1700:18fb:6011:bae:bfc2:7e96:e5c8])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-871493155d3sm115277577b3.16.2026.09.09.12.38.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2026 12:38:32 -0700 (PDT)
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
Subject: [PATCH bpf-next v3 15/15] landlock: Document the BPF policy interface
Date: Wed,  9 Sep 2026 15:37:18 -0400
Message-ID: <20260909193719.518517-16-utilityemal77@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260909193719.518517-1-utilityemal77@gmail.com>
References: <20260909193719.518517-1-utilityemal77@gmail.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Describe how the generic LSM policy kfuncs apply to Landlock
rulesets: the program-side flow, the staged restriction and its trace
event, the LANDLOCK_RESTRICT_SELF_NO_NEW_PRIVS semantics on an
execution, and why the bprm path carries no no_new_privs/
CAP_SYS_ADMIN precondition.  Note the new emission point in the trace
events overview.

Cc: Mickaël Salaün <mic@digikod.net>
Signed-off-by: Justin Suess <utilityemal77@gmail.com>
---

Notes:
    v2->v3:
        - No change.

 Documentation/security/landlock.rst     | 38 +++++++++++++++++++++++++
 Documentation/trace/events-landlock.rst |  5 +++-
 2 files changed, 42 insertions(+), 1 deletion(-)

diff --git a/Documentation/security/landlock.rst b/Documentation/security/landlock.rst
index 2d6e1076484e..ddc0d149ae8f 100644
--- a/Documentation/security/landlock.rst
+++ b/Documentation/security/landlock.rst
@@ -130,6 +130,44 @@ The reasoning is:
   restrictions, because access within the same scope is already
   allowed based on ``LANDLOCK_ACCESS_FS_RESOLVE_UNIX``.
 
+BPF kfuncs
+==========
+
+BPF programs can apply a userspace-created Landlock ruleset to an
+execution, through the generic LSM policy kfuncs (see
+Documentation/security/lsm-development.rst).  A syscall program
+(``BPF_PROG_TYPE_SYSCALL``), running in the context of the process
+that set the ruleset up, acquires the ruleset with
+``bpf_lsm_policy_from_fd()`` and typically hands it over through a
+map kptr field; a sleepable LSM BPF program attached to the
+``bprm_creds_for_exec`` or ``bprm_creds_from_file`` hooks then
+enforces it on an execution with ``bpf_lsm_policy_apply_bprm()``.
+
+The restriction is staged in the Landlock blob of the credentials
+prepared for the execution and committed past the exec point of no
+return, so a failed execution leaves the calling task untouched.  The
+commitment emits the ``landlock_enforce_domain`` trace event (see
+Documentation/trace/events-landlock.rst).  The kfunc flags take the
+``landlock_restrict_self(2)`` flags with their usual semantics, with
+the exception of ``LANDLOCK_RESTRICT_SELF_TSYNC``, which is rejected:
+the restriction targets the execution, not the calling threads.
+
+``LANDLOCK_RESTRICT_SELF_NO_NEW_PRIVS`` makes the executed program
+start with no_new_privs set, binding it and all its descendants.  It
+does not affect the current execution's privilege computation: the
+bprm credentials, including any setuid elevation, are computed before
+the flag is set.
+
+Unlike ``landlock_restrict_self(2)``, the bprm path has no
+no_new_privs/``CAP_SYS_ADMIN`` precondition: a task that is not
+no_new_privs can carry a BPF-applied domain, and its setuid
+executions still elevate while confined.  This is sound because
+attaching the BPF program is itself privileged, granting the same
+power as the syscall's ``CAP_SYS_ADMIN`` carve-out.
+
+Executions may run concurrently: each takes its own reference on
+the shared ruleset with ``bpf_lsm_policy_acquire()``.
+
 Tests
 =====
 
diff --git a/Documentation/trace/events-landlock.rst b/Documentation/trace/events-landlock.rst
index af9267cca47d..6cec3194af0b 100644
--- a/Documentation/trace/events-landlock.rst
+++ b/Documentation/trace/events-landlock.rst
@@ -34,7 +34,10 @@ Landlock trace events are organized in four categories:
 - ``landlock_add_rule_fs``: a filesystem rule is added to a ruleset
 - ``landlock_add_rule_net``: a network port rule is added to a ruleset
 - ``landlock_create_domain``: a new domain is created from a ruleset
-- ``landlock_enforce_domain``: a domain is enforced on a thread
+- ``landlock_enforce_domain``: a domain is enforced on a thread.  Also
+  emitted at ``execve(2)``'s point of no return when a BPF program has
+  staged a policy on the execution (see the BPF kfuncs section of
+  Documentation/security/landlock.rst)
 
 **Denial events** are emitted when an access is denied:
 
-- 
2.55.0

