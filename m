Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63C9A352C2C
	for <linux-security-module@vger.kernel.org>; Sat, 15 Aug 2026 11:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786792849; cv=none; b=pIEVkqIUAoxKUW0cbtu/+eXs5CP2uFJW4RFYzDCfqnZ+vOkL5cgE/n11l9JBFJ8SXv8YgvHiW8ianbh3faGA+KVAgEa4jv0z+zMFxjswyfH7rbWp8kDPGygg7xg/C8/I5Cqv4NS5xmcyCV42BFBLx7O3f9jfNe+cpv5RvwqODTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786792849; c=relaxed/simple;
	bh=djLZMpUah7Mihpof97k8hEqjZOn9/S4jD4Bgilil3vg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XXKte3l0L8Um50shBaHXW4MonKZ5hfHKBxH8KJBn7i/c3MyoD6iXe67AjsXElaj0xxD9Q9q6Vb3K2dlpd6503iCjlXbgfEyzSv6O4B2c8vW6sd4FgHlAzAXSYcXxpHFO2H/DQK9X2saKNwmchD1lZvaDsM2KSbW63wFwrdxeo8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k4mRdM4r; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k4mRdM4r"
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-7dbcb505578so18035297b3.3
        for <linux-security-module@vger.kernel.org>; Sat, 15 Aug 2026 04:20:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786792846; x=1787397646; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=G+Pc3CG99YBm+EzYDINBR/q4A3NL6A7bn3Kkm4VNB1A=;
        b=k4mRdM4rQpUjwcAznPFhQOJfliG/ThLAXJ+nzL/wQ+gk7RXn1IZkyM3gwEBqliuGkt
         EVMFQTsJE2gQZE3z8eb4vlIQpmDT2lg70Qln5FkEBmVcRRzBERCNE6I4WagDM2/DMREY
         K3LLVNrTKJsHEx+aJ/318hCyJEA6qQo4JXWuajpk3XtNWguMXsnepnuP7yeezlI+51m3
         29Rv7V5r7SgnSRxDX3TLbNk1aUTOrwt1mGWx0nxYaJscKzpBpw0jgW/rUVRMpj4zGj4G
         eia9cCP/+6S3FntDVWKdSU56aldb6WMmLye7n3nkOtuRZhedce+nTr98KAp2Ry45oCjB
         jurA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786792846; x=1787397646;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=G+Pc3CG99YBm+EzYDINBR/q4A3NL6A7bn3Kkm4VNB1A=;
        b=gJ8PI9uMLElUdehpCPFiidJskivnnwkmj36meNq+I1rPRqwIdo88KMAWKe6koHHnBb
         U4sLAnbP3f1iU8VlrMVauE2oDWBWLvRt1npyxwe1SCxRQZFy77OsZqeAF0e9Y5TxnO6p
         qOUOtof31qR3oOJnXl1CbiWDXKTdjUU655+cbc26mHZ1iWwOuYwsMj//O99c6zCvYekK
         kPDEN7/qEw0xffNefbtfHb5vkVqBxQPhR34MADbT8UdkRkVEKt2Y6GORZrxeDNIQHFzf
         AIMWeX9Aq+ZI/pXwzspLL/Rvzyl8bAtA1z4NIc2NIK3PMbJjLR/s8zAMlh9YaqbnM5BV
         IjeQ==
X-Forwarded-Encrypted: i=1; AHgh+Royi1+9445ElEfeS4fhr/6og/iUtmY7Qb/byx12Ck5XgOJqt+q+SoIBFIg/jtNgFhBbN6bbiALD2jIIG+GZMNgse/agy+g=@vger.kernel.org
X-Gm-Message-State: AOJu0YyesPW4XaW0uZZzYq+WCNu9z9Rgk3tAgEtUvYYTTlQrsO9+UjLh
	2jHKNRQWgAvgfE0TRbTBxpyti3V/7/wRaHxSosHdyg0shRYZiGFYbkus
X-Gm-Gg: AR+sD11MHxMlCSTcjFkwLasX1KJriCw7vHWc+yNLquFajc027tIt8dHh8cy/J7yKc8v
	zKjWIb2S2IkGMmfZqKPZptuVYKiPUYLsFNPojg+Pwrapntod9uPehHmBpCFASRfDlx6G0y8iNOT
	5qAqElFWOLx0srRO6g3imLE9pIfLZtvLePB28PCZlVjKAxNJa4v4o6lgzDc5s979S56fc9E4lOS
	l75Cs/iS9ieJytUq4/dP6lNLetleG8D99DOY15XY4NqJgCO4Xq40uBr1ZM7BSHZTFNz8eHWAqSr
	ELW7OxpjAq0mS+9KzxTka9NfpfSvErKRj4HVR0wpJbtsHLrdqa5Hcx2PqYxVu3ozObwZf6VRYez
	71Vh/d5IcyzlNkLoQvGAJMFmei5DI7Pdz5KWUrQbdTuMv8jF77wPqY12nF5ivvExqKbX2hqIjGb
	8gtkoxV5B+iIvdabL50O8pcYTnWdLNqSB0hJhpuBIej8WKIMGLiwV5+UFzCH9y7EcNs2x0DiKpm
	T+K6EDgwFZoy+anhTKUUuY=
X-Received: by 2002:a05:690c:a4c8:b0:81d:a1e5:a4d7 with SMTP id 00721157ae682-8370c93d31amr36153457b3.5.1786792846338;
        Sat, 15 Aug 2026 04:20:46 -0700 (PDT)
Received: from zenbox ([2600:1700:18fb:6011:31f0:efe0:f2d8:ae44])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-836c36a84d9sm24388037b3.46.2026.08.15.04.20.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Aug 2026 04:20:46 -0700 (PDT)
From: Justin Suess <utilityemal77@gmail.com>
To: Alexei Starovoitov <ast@kernel.org>,
	Paul Moore <paul@paul-moore.com>,
	Xiu Jianfeng <xiujianfeng@huawei.com>
Cc: linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	bpf@vger.kernel.org,
	Justin Suess <utilityemal77@gmail.com>
Subject: [PATCH bpf-next 0/2] lsm: give BPF programs a way to query locked_down state
Date: Sat, 15 Aug 2026 07:20:39 -0400
Message-ID: <20260815112041.1248855-1-utilityemal77@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Howdy,

BPF programs can attach to the locked_down LSM hook and contribute a
verdict, but they have never been able to ask the locked_down question
themselves: there is no way for a program to invoke the hook and learn
whether a given operation is locked down. (i.e be a caller of
security_locked_down rather than a consumer).

Today the state has to be fed in out of band, for example userspace
reading /sys/kernel/security/lockdown and writing the result into a
map. That is a time-of-check/time-of-use race: a security_locked_down
verdict can be raised at runtime, so the cached answer can be stale
by the time the program acts on it.

Add a bpf_security_locked_down() kfunc that calls
security_locked_down() and returns its verdict, letting LSM and
syscall programs query locked_down state at decision time. Out-of-range
reasons are rejected with -EINVAL before dispatching the hook, and the
kfunc is refused to programs attached to the locked_down hook itself,
which would recurse into the dispatch. (how the obvious recursion issue
is addressed).

As this is the first pure-lsm-hook kfunc, add a new file security/lsm_kfuncs.c
to host it.

This kfunc has no reliance on / relation to the Lockdown LSM, despite the
similar naming. It is an LSM-agnostic caller of security_locked_down, and
Lockdown just happens to be the only in-tree subscriber to this hook at the
moment.

In fact, the test environment does not rely on CONFIG_SECURITY_LOCKDOWN at
all, and uses a BPF implementation of security_locked_down.

This kfunc can cause notices to be printed with kmsg if the Lockdown LSM is
enabled due to this line in security/lockdown/lockdown.c:

  pr_notice_ratelimited("Lockdown: %s: %s is restricted; see man kernel_lockdown.7\n",
				                 current->comm, lockdown_reasons[what]);

Patch 1 adds the kfunc, patch 2 the selftests. This is based on bpf-next/master, but
applies cleanly to the lsm tree.

Justin

Justin Suess (2):
  lsm: add bpf_security_locked_down() kfunc
  selftests/bpf: Test bpf_security_locked_down kfunc

 security/Makefile                             |  1 +
 security/lsm_kfuncs.c                         | 84 +++++++++++++++++++
 .../selftests/bpf/prog_tests/lsm_kfuncs.c     | 28 +++++++
 .../testing/selftests/bpf/progs/lsm_kfuncs.c  | 34 ++++++++
 .../selftests/bpf/progs/lsm_kfuncs_fail.c     | 26 ++++++
 5 files changed, 173 insertions(+)
 create mode 100644 security/lsm_kfuncs.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/lsm_kfuncs.c
 create mode 100644 tools/testing/selftests/bpf/progs/lsm_kfuncs.c
 create mode 100644 tools/testing/selftests/bpf/progs/lsm_kfuncs_fail.c


base-commit: d82ebfc685c91e7f5623a8be949da1ddb767420b
-- 
2.54.0

