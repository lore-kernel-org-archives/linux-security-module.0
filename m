Received: from mail-dl1-f51.google.com (mail-dl1-f51.google.com [74.125.82.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A3913546FD
	for <linux-security-module@vger.kernel.org>; Tue, 19 May 2026 14:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779201876; cv=none; b=RVOXeeYrSrNqOQqNT/X7/xfwZ6k4OpYI9R3TRrUOQ5xBVb4EQgHdGs5i6OURAHftmCaLNTfMaaabCsvjpw/mBydaT+UjbgsPJY6vgks6Fx8TlxMpKKAAfKn7J1aGof5rJWLq1ghYXHc4+NvBX6QXgYYAqg4vcO+GXKMkIt4c4qk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779201876; c=relaxed/simple;
	bh=mwiEUl6i8qzKyhgvrXCmm8xKF60p0orj3WXB0AZY4AQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SBQsTGG6+lMyoaDPRgfc1XIW85rhW4B/uTGDexwF/3DSzkIDu8kxVpk1izJfzegVgqQHRgXLlFoBYU5k2CvjguAPbHB6+JG7hsFJfyvG52o8Zi1UsvNyrQFglDsB8zZCJmynyAz2hQuyg3S6zB0Y7fI/q1mNPo9DgFYLWqEbLzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=s3spdfcX; arc=none smtp.client-ip=74.125.82.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="s3spdfcX"
Received: by mail-dl1-f51.google.com with SMTP id a92af1059eb24-1353c2f35cfso12389810c88.1
        for <linux-security-module@vger.kernel.org>; Tue, 19 May 2026 07:44:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779201861; x=1779806661; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Seai4fWqb4mwDhLXDN1f51FodXQt4GGEE1K9qVn4MNo=;
        b=s3spdfcXlGF5UYUVsQgY6pxGGTc0bC+D+uuP2ZPM/qi39+sQcCmC7qd2m8D+fqyVEv
         LmqEh5jfhQbsO4Ysv5cUmsZam/+e4qG1k+yeCc/PjiyY2Ruegm/R7x+M5DXuqv+ioXlf
         hgX9He+tq2yv7Q/K2lgrA1HDCvb8kN2F+U1ZPZGPhu16e9cNhKp2z6Bref0i724LBxk3
         1EwOEjMEwRC/Tl0fYByXSVNeh/l3HkR5pfS9V1NseozJksO0kVWmJxBOr0/Dd9GPof4N
         HBpeH4oxuG725Zbyq2t3LxKSlwrXSrUE4u4+eE2fCW3nNJ/sfCQBdB6zJK0VmCb0V989
         RtLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779201861; x=1779806661;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Seai4fWqb4mwDhLXDN1f51FodXQt4GGEE1K9qVn4MNo=;
        b=B1aqaWGocWmXoaDcHEYNQaMlXdlIXiVR7ScWfQxhov3IJQ6p3rRlxQ3V12Bx/ERE4N
         GzT3sOp0XBhPZ6/eXDZSpJCOdm2EsRUYixqwLE/mw8d/tt0YEerpyF3pkGl/g55RZjAJ
         oyaht+LuF2UAu2qrGV14MIojtrloa07C4k5+c2nA1GIg65yuCxBzWGtOqZzm4i7kAAQR
         bgw8owOgNtpSa6Lp6s2PAe7Eh4CQWsOXse+yg0RRkLGtxPDdHTdmMfMfL1K0NPWqa3kF
         o786Rc4br3wFkzaKQYzKvI4iSg4Hu1C1mNVqGar7QZYtlRWuuwqcpxSDo6SZBPtLkXU+
         gsUQ==
X-Forwarded-Encrypted: i=1; AFNElJ/y9B/6mFD+8ECg1glwQnJoy9ZKqqqS9FgTymLWRWnmn0SkLXT3+HuHwu6yN1e3lcFYIOizIinSFbFbe57N6eJqjr5vajY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwzHAOdCyWwmTy7nuoXcl3vLcCG8CWfX87i5qCVw/0FVmaJMqJc
	bGcLAuyA11c+IYldTZ5xVgVzCE7DOpSGIKvLyR/t0ruIfPLpK+8FeQS3
X-Gm-Gg: Acq92OEUkHDAPb8TC/VepmZB4iBauhMwNCHgFc9yqxuC+LioSZJ5f69cR9IH/r9P/2g
	XyTztu9sUm4l0wlFibTw6mM7Q4Jpq7KRVHotsg1ede4zjxGukBqegB0QlhWBcxaGxmew77HGo6I
	az+NCkhWOBQxtIWhG3/n0ymqM2ZSH6ILNCd3oWgtSJS6krmmOvv1cobi68VnXJN6HCLdlHdGAbg
	FKTCOd2ciCfZqg1v2hmeOG8RSw3m2syg9k+tkv1bCDwQ4ftxv2INbqHZhz3XZ9BrTVs9JAQGnKx
	sf7GOaCp+I4a28zvRKRbujDIJ2zS2s6DsmpoXtbXRogyc6MvJhQMi8dj7rszRhFUPXYbfshKwCH
	XGk+ibgLwCB2ZI2oi0nd0od1x/u6G+6XSlJaxOivuGQbsjfp2Een9qaaTHzNJxj6YxiJpBFhPTW
	21Eb19iGWmrnT3PLAXSU3XceYWiWNAT4+NQ2YUraqvGvHcnhCx
X-Received: by 2002:a05:7022:7a2:b0:132:2486:acb with SMTP id a92af1059eb24-13504415962mr8368979c88.12.1779201860844;
        Tue, 19 May 2026 07:44:20 -0700 (PDT)
Received: from localhost.localdomain ([148.135.103.3])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-135e5c0a918sm1276868c88.14.2026.05.19.07.44.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2026 07:44:20 -0700 (PDT)
From: Shaomin Chen <eeesssooo020@gmail.com>
To: keyrings@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: David Howells <dhowells@redhat.com>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>
Subject: [bug report] keys: request_key_auth payload use-after-free in keyctl_instantiate_key_common()
Date: Tue, 19 May 2026 22:44:03 +0800
Message-ID: <20260519144403.436694-1-eeesssooo020@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

keyctl_instantiate_key_common() can use a stale request_key_auth payload after
the current request-key authorisation key has been revoked.

The relevant code pattern is:

	rka = instkey->payload.data[0];
	...
	copy_from_iter_full(payload, plen, from);   /* can fault and sleep */
	...
	get_instantiation_keyring(ringid, rka, &dest_keyring);
	key_instantiate_and_link(rka->target_key, payload, plen,
				 dest_keyring, instkey);

keyctl_instantiate_key_common() does not hold authkey->sem, an RCU read-side
critical section, or a reference to the request_key_auth payload across the
sleeping copy and later rka dereferences.

One race sequence is:

	Task A: request-key helper child        Task B: original request_key path
	-------------------------------        ---------------------------------
	assume request-key authority
	enter KEYCTL_INSTANTIATE_IOV
	rka = instkey->payload.data[0]
	block in copy_from_iter_full()
	                                      helper parent instantiates target key
	                                      helper returns to kernel
	                                      complete_request_key(authkey, 0)
	                                      key_revoke(authkey)
	                                      request_key_auth_revoke(authkey)
	                                      rcu_assign_keypointer(authkey, NULL)
	                                      call_rcu(&rka->rcu, ...)
	                                      request_key_auth_rcu_disposal()
	                                      free_request_key_auth(rka)
	resume from copy_from_iter_full()
	get_instantiation_keyring(..., rka, ...)
	key_instantiate_and_link(rka->target_key, ...)

I reproduced this on a current upstream v7.1-rc3 based tree,
HEAD ab5fce87a778c, with KASAN enabled:

	BUG: KASAN: slab-use-after-free in keyctl_instantiate_key_common+0x1dc/0x2a0
	Read of size 8
	Allocated by task:
	  request_key_auth_new+0xe0/0x4d0
	Freed by task:
	  key_revoke+0x62/0xc0
	  call_sbin_request_key+0x6cb/0x740

The reproducer uses a request-key helper that forks a second process with the
request-key authority.  The second process enters KEYCTL_INSTANTIATE_IOV and
blocks in copy_from_iter_full() on a user fault after rka has been loaded.  The
original helper then instantiates the target key and returns, which revokes the
auth key and queues the request_key_auth payload for RCU freeing.  When the
blocked instantiate path resumes, it dereferences the stale rka pointer.

I can provide the reproducer and a candidate patch.

Regards,
Shaomin Chen
