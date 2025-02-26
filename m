Received: from mail-ed1-f74.google.com (mail-ed1-f74.google.com [209.85.208.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34DC62571A7
	for <linux-security-module@vger.kernel.org>; Wed, 26 Feb 2025 21:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740604747; cv=none; b=fNAAx2OkfF52//cDI2W1RqbLpC/+xlG6h21ypLi7GAofqHrxzBM9/8AO6ujR8PM7YAXQR4gPVE1TFeXPCQ8luhoGrJtIBkvEfv1KQvdD10+UOSEQqZvAULpn/5VtatI16fK/f3dlmjM+BuHoltZLUtmDQY4hfQOcspFZaq/6K90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740604747; c=relaxed/simple;
	bh=LNhj+DGxktTxB8FdmUWwYvohBv0qL5MVFkUsGguvOds=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=if8Mho9JzE5qgQsY8ImAWVEgrq15fe4jgMC7YBEnDgvKdtVgyiUOtU+Af2k4MHzpzBFZtONRipZ0nkKiKKIHvN4sSEoPIZcH+FlNJTzA+4A4k/QH55fxkq6AzGjLk1kJepFjbgLPxbJoCiRQzTLYbM3/Pjf02Udk9FICB6uK2YQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--gnoack.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=a7mbj0e0; arc=none smtp.client-ip=209.85.208.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--gnoack.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="a7mbj0e0"
Received: by mail-ed1-f74.google.com with SMTP id 4fb4d7f45d1cf-5da15447991so134773a12.3
        for <linux-security-module@vger.kernel.org>; Wed, 26 Feb 2025 13:19:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740604744; x=1741209544; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=duUSxcKBjL1V2Dc8BDWLklM2H+W6u03EYfGKcvUPxI4=;
        b=a7mbj0e0x3wPnZxyXBbg90QJ4zh4HzM/nlbK+f0LGFLVBKbKjw3GYl9cJE8yAXD//W
         BWPaMVnChiGobmYJasvMyJ0SKxpxvhrY8BWGXv6W9V5EjBN65HIECiFlzi01Slxgux+V
         zts8pyHsQt1U1+QYqfRJUeKm2k/AmK9WIfOLDZlYoRMBdIs3CjBCzYykqyeOwC3hjg8r
         +1fXBxoPcKkyNsmM7MTNv2LEzYmq/bIVtgdvf8SoUOrclXc/sfuWXk8f8ujw2PFhOZB/
         ebgkbNXmtbTV/h9oCg8aEdQOU2G4DE0Dygjc/8k77ENbs0ANrUwvebkqnN2BC+4slq8m
         KOpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740604744; x=1741209544;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=duUSxcKBjL1V2Dc8BDWLklM2H+W6u03EYfGKcvUPxI4=;
        b=VKu822h6WLmFwRufkRM0HtAKMdYyoCGMzkPbCqllsVeOIqpmUImBkWt6L/judyxbLb
         CTYNpwD5kUNXfd8QTXlmAAlhGtd8o9LFwCiR1jq86/Eta56z+Fh9fUJKLM8D3Im5z3SV
         Hq34pX5fGYznJrcYmManTKN0+qCpoN1nBUJ5fZvnfOw8aaTC5SHJnF6R+/6oEzwNtgsj
         s8ZWagTA/8funPK9EVHFHMDPgKTOb5r38W5pmevXmfU11LhttwKS6V1PSSlCdwmSZcWL
         b01NZei63/YwZgEOGdUodAIk1sGmJSvT+6FHcVUgw0HarlM50rJKLyWzun2fak+fpSAD
         JHgA==
X-Forwarded-Encrypted: i=1; AJvYcCUNyH92qruFSVUpP5+0a4qDhQzsSg7GhSbNWo00Y9gI2NMxsNm8VZ/pd/OxkGWZAtXL54dOODfavp8Mfex+UxvVsTt8x9I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyx/WmdF1/yq+kn8aGEiyRRYdKlF3rvfoMFdpvLpPUKH0dYTYpx
	R4+/E0HaDnvdzT/FoCrd8rnBl35Gi98oKAa32tgFqhTM5cOYczuzhoJMyl+GasIQ/b3+meeVj3k
	8bg==
X-Google-Smtp-Source: AGHT+IHXpHdqdH6Dco/NCDzY1hE8mnVJMoMXwcWuu5mJ6JTz/XtU3cTHMgAzaIvPF9M2oSa24BBCtyIXmpY=
X-Received: from edbio9.prod.google.com ([2002:a05:6402:2189:b0:5dd:a70d:303a])
 (user=gnoack job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6402:5d5:b0:5e4:be64:b576
 with SMTP id 4fb4d7f45d1cf-5e4be64b76dmr2204593a12.1.1740604744548; Wed, 26
 Feb 2025 13:19:04 -0800 (PST)
Date: Wed, 26 Feb 2025 22:18:16 +0100
In-Reply-To: <20250226211814.31420-2-gnoack@google.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250226211814.31420-2-gnoack@google.com>
X-Mailer: git-send-email 2.48.1.711.g2feabab25a-goog
Message-ID: <20250226211814.31420-4-gnoack@google.com>
Subject: [PATCH v2 1/1] landlock: Clarify IPC scoping documentation
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

