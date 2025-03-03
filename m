Received: from mail-ed1-f73.google.com (mail-ed1-f73.google.com [209.85.208.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B1CC1FFC60
	for <linux-security-module@vger.kernel.org>; Mon,  3 Mar 2025 19:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741031142; cv=none; b=tZoPZHDk+hU/NxePi4WfhX0ws04e8K5BiwL10TvzhsM8mew2H44qcW7TOeOggdPYlLsloUG8kbw/XdsZ41Q2BA9uU8QKFLSjn1aLtb/Zuzu9V/zPn2xkxyLPl5LPwZb/HlnU7krfQ9MBead9MSIgV7Zrd5/M3DUEOEz6AEaSQW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741031142; c=relaxed/simple;
	bh=LNhj+DGxktTxB8FdmUWwYvohBv0qL5MVFkUsGguvOds=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=VuIpzLYpVN7QqE6Dx2QEW0uOzvbaWIDa0iUv4B55kbagy0Ty6yTCBeRSjLgEhWr4SbDDadOL3uObn1qcx1h4cJ/Mrd/fRAEwToI2nf7Ero9WtBhDxDjVr6fJCAEgTjcACzBBAF/cct3OLJqzvSd3sN+nEWI9df8LVKA32tF+wwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--gnoack.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DONYKt3U; arc=none smtp.client-ip=209.85.208.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--gnoack.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DONYKt3U"
Received: by mail-ed1-f73.google.com with SMTP id 4fb4d7f45d1cf-5e4a0d66c69so6027844a12.0
        for <linux-security-module@vger.kernel.org>; Mon, 03 Mar 2025 11:45:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741031139; x=1741635939; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=duUSxcKBjL1V2Dc8BDWLklM2H+W6u03EYfGKcvUPxI4=;
        b=DONYKt3U6R2CRMWsPSjABt8osD+6FCB9C6Jb+HZ3fdeVJJ0TMrnjRyQxIf3g1jEROh
         GsQ0lGDmDFsxF5ToT4DJwS8hq42VbiRmcs7PTPKiT8BfTBsQVZWbOXxRUmz2K12UeO15
         6HNTUfABRagFmfQtLVZgH7zFMJ4pEv3pHE/0YEisepco65gbpW9eGWW3yaI9oKM2VVeq
         PYSl2XaYngWDhvAomLbFJ3EfKh8RnFJQkW9LNF1XI3uY2t1h50YMMRilLcsSrR+iPW+A
         1ZxSs9ZgZi1Hr9LdrTcsTib7v75PYicy8LGJAphayVsNDMyJ23ZV+S7ed+b/u1y9PXsl
         07zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741031139; x=1741635939;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=duUSxcKBjL1V2Dc8BDWLklM2H+W6u03EYfGKcvUPxI4=;
        b=WMYUk53SVi00xMjDzlHLMLjyxMonkEjmtwRxa6LeBDdfbuC4JNcSCUUv3qYWV3BjFs
         /7mIpDLOtf84l7ro+mu81Unh4l/J1PUFae+HjIs1QMwJrLZppOnACSpBt21TnOiOriWw
         VYi97p4FZAF4zLDWOBMgZYREBODff9iL7zyrkEhtL1k0rKOYZXWIisBW6ElQd+KPJdu4
         VrbzYqVRdo9sY+LOfN4zvdNxUp7ipb+o6BQDeF37YaFBRYuOtPUE0ne66WXo5aAiBggE
         EfpglKGpCUMhLEfyYSNo4NEeAxNApo8uZaFaDleGSiYb5DiQ45Y2Qzv4h4uBKD9vAonG
         oFKw==
X-Forwarded-Encrypted: i=1; AJvYcCVm52K69fG72G9AeYAuyN1d1f1qK2cIrjwzRKh2eHEZ8i1Q5PlNv+yZdhMpcDNn6WQnmZaUfboG0hUjwRbmRrlbhVotCUo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yywt2OKLOHIfdjdwbpLpINkZqP2glTfvrIy4aH5Ttv+SkI4vm7/
	jgJUM3T6hZ+SXAv8xULt77lBF73nGKEqYBrSgWnqcN3GHGKD4XcAuq1sUCoMQ5goN5LzMbrKENi
	1hQ==
X-Google-Smtp-Source: AGHT+IEI47ysZn1gwD3019R9A1nGc4J83o9X61Kejv4zfkJg/2a82TUZfTXuDTQol4MIym7PHZ9ctCgOhQ8=
X-Received: from edqr23.prod.google.com ([2002:aa7:d597:0:b0:5e4:d0e4:7ac3])
 (user=gnoack job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6402:42c4:b0:5e0:8920:c4c5
 with SMTP id 4fb4d7f45d1cf-5e4d6ade0dfmr14498230a12.11.1741031138934; Mon, 03
 Mar 2025 11:45:38 -0800 (PST)
Date: Mon,  3 Mar 2025 20:45:12 +0100
In-Reply-To: <20250303194510.135506-2-gnoack@google.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250303194510.135506-2-gnoack@google.com>
X-Mailer: git-send-email 2.48.1.711.g2feabab25a-goog
Message-ID: <20250303194510.135506-4-gnoack@google.com>
Subject: [PATCH v3 1/1] landlock: Clarify IPC scoping documentation
From: "=?UTF-8?q?G=C3=BCnther=20Noack?=" <gnoack@google.com>
To: "=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?=" <mic@digikod.net>, Tahera Fahimi <fahimitahera@gmail.com>, 
	Alejandro Colomar <alx@kernel.org>
Cc: "=?UTF-8?q?G=C3=BCnther=20Noack?=" <gnoack@google.com>, Tanya Agarwal <tanyaagarwal25699@gmail.com>, 
	linux-security-module@vger.kernel.org, 
	Daniel Burgener <dburgener@linux.microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

* Clarify terminology
* Stop mixing the unix(7) and signal(7) aspects in the explanation.

Terminology:

* The *IPC Scope* of a Landlock domain is that Landlock domain and its
  nested domains.
* An *operation* (e.g., signaling, connecting to abstract UDS) is said to
  be *scoped within a domain* when the flag for that operation was set at
  ruleset creation time.  This means that for the purpose of this
  operation, only processes within the domain's IPC scope are reachable.

Signed-off-by: G=C3=BCnther Noack <gnoack@google.com>
---
 Documentation/userspace-api/landlock.rst | 45 ++++++++++++------------
 1 file changed, 22 insertions(+), 23 deletions(-)

diff --git a/Documentation/userspace-api/landlock.rst b/Documentation/users=
pace-api/landlock.rst
index ad587f53fe41..4832b16deedb 100644
--- a/Documentation/userspace-api/landlock.rst
+++ b/Documentation/userspace-api/landlock.rst
@@ -317,33 +317,32 @@ IPC scoping
 -----------
=20
 Similar to the implicit `Ptrace restrictions`_, we may want to further res=
trict
-interactions between sandboxes. Each Landlock domain can be explicitly sco=
ped
-for a set of actions by specifying it on a ruleset.  For example, if a
-sandboxed process should not be able to :manpage:`connect(2)` to a
-non-sandboxed process through abstract :manpage:`unix(7)` sockets, we can
-specify such a restriction with ``LANDLOCK_SCOPE_ABSTRACT_UNIX_SOCKET``.
-Moreover, if a sandboxed process should not be able to send a signal to a
-non-sandboxed process, we can specify this restriction with
-``LANDLOCK_SCOPE_SIGNAL``.
+interactions between sandboxes.  Therefore, at ruleset creation time, each
+Landlock domain can restrict the scope for certain operations, so that the=
se
+operations can only reach out to processes within the same Landlock domain=
 or in
+a nested Landlock domain (the "scope").
=20
-A sandboxed process can connect to a non-sandboxed process when its domain=
 is
-not scoped. If a process's domain is scoped, it can only connect to socket=
s
-created by processes in the same scope.
-Moreover, if a process is scoped to send signal to a non-scoped process, i=
t can
-only send signals to processes in the same scope.
+The operations which can be scoped are:
=20
-A connected datagram socket behaves like a stream socket when its domain i=
s
-scoped, meaning if the domain is scoped after the socket is connected, it =
can
-still :manpage:`send(2)` data just like a stream socket.  However, in the =
same
-scenario, a non-connected datagram socket cannot send data (with
-:manpage:`sendto(2)`) outside its scope.
+``LANDLOCK_SCOPE_SIGNAL``
+    This limits the sending of signals to target processes which run withi=
n the
+    same or a nested Landlock domain.
=20
-A process with a scoped domain can inherit a socket created by a non-scope=
d
-process. The process cannot connect to this socket since it has a scoped
-domain.
+``LANDLOCK_SCOPE_ABSTRACT_UNIX_SOCKET``
+    This limits the set of abstract :manpage:`unix(7)` sockets to which we=
 can
+    :manpage:`connect(2)` to socket addresses which were created by a proc=
ess in
+    the same or a nested Landlock domain.
=20
-IPC scoping does not support exceptions, so if a domain is scoped, no rule=
s can
-be added to allow access to resources or processes outside of the scope.
+    A :manpage:`sendto(2)` on a non-connected datagram socket is treated a=
s if
+    it were doing an implicit :manpage:`connect(2)` and will be blocked if=
 the
+    remote end does not stem from the same or a nested Landlock domain.
+
+    A :manpage:`sendto(2)` on a socket which was previously connected will=
 not
+    be restricted.  This works for both datagram and stream sockets.
+
+IPC scoping does not support exceptions via :manpage:`landlock_add_rule(2)=
`.
+If an operation is scoped within a domain, no rules can be added to allow =
access
+to resources or processes outside of the scope.
=20
 Truncating files
 ----------------
--=20
2.48.1.711.g2feabab25a-goog

