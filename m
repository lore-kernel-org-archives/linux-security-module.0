Received: from mail-ed1-f74.google.com (mail-ed1-f74.google.com [209.85.208.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F28C115B551
	for <linux-security-module@vger.kernel.org>; Fri, 24 Jan 2025 15:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737733508; cv=none; b=BnckCcTMlTHVM2dcWCYW1w6ZrZY3FqQN/Y8l6VqquOn3ZqNZxDlT3CcgifnqOFouejFUFSG9vEYvL6cXeUNn+uuVbxxrnpoUlEuzdaJd8Rh8koBhQns7mljNi1blQUBhHd/QWsfKRtivA42H4Zw6Fcf1fRxFdlWa5g8rSqUakvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737733508; c=relaxed/simple;
	bh=Lb0DZO2ogcE7XHY4yhpKqdQoP3eSsxLtmL14aQgh/Oo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=OXSqm73kU8LZmUQdQyrUFdbuXnM1GxAYzRE8WuFp79Z/TXaaQBUNWlWRgh59NAu9E5cCLub8n0MV6Ca5WF1GwyrUhN6obaFE8MuyWTa+oY1lHtZ6/NBK1OyNyyClDNohr7w/Yur6xAG4y89YqflSpJlvhZD1piwlsCidFB7tyu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--gnoack.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=n2nAWBZS; arc=none smtp.client-ip=209.85.208.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--gnoack.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="n2nAWBZS"
Received: by mail-ed1-f74.google.com with SMTP id 4fb4d7f45d1cf-5d3bf8874dbso2787923a12.2
        for <linux-security-module@vger.kernel.org>; Fri, 24 Jan 2025 07:45:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1737733505; x=1738338305; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fzlaiZNCW5VUtDWGIHCNXgnzf14nmQgFDHLwLf/uhBU=;
        b=n2nAWBZStpfUfHv473KBJPdpHKogpXUUhCpin4Vbwl+IwHlgTWS8v3/NIUtt8plm7K
         nADEsGQYSXVmp6mhd3Fno2JvqdaGcTXXxXfL/mhrCPVL9Ztu4SA6u/hRkspeydBq8d7Z
         oRHzr8n0zGVvpXeJXVyCHOtl58ZOu8uit63e9+hFktm2/Ae03zCMHZmIgj8YZ0poefA9
         0P8t1tYgTep8TUcS/ka36SE6ujVF80HDWvbiHiI2GQQr3aiC1Vk7doIHyAC1QqHADzFS
         c+M8xv4RsX3bVH2epIsQAczjX7F7ucn3lYVYEOGJriSZxA6EhcBp8BEgcFwOdtBMnsW2
         N6Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737733505; x=1738338305;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=fzlaiZNCW5VUtDWGIHCNXgnzf14nmQgFDHLwLf/uhBU=;
        b=rwvz44FcW0pqelkdqM4CJmL22+aPdzGKJtvbIVnqoLDRDgecqfgGY5TyXnS59aQcEN
         QpT0afOETvGbE1hm/3fVWw/hnol0VNtXYJgwWvlcUw2uVK+p6nXOOBWq3tA1degDqkya
         A+sBGNIOHZtocmIMhf7ovUyzYg9IuXBAlnP7YiWlvDnjngVQjIaUaRgxBoRt/L9jVF/e
         cnRIfRfxHJXXtlDE+oPFk7D4PTUqBcx6rEmurgYrbIb4ciBMxVZFnMnKw/NXhQ9Ib47o
         TM7/dy5kvHrB7qyAKlLGZGOBSucrAhUMJlBKJTZcY0MuC3C0e1I7pPkNILjKYNKwooLu
         +CXQ==
X-Gm-Message-State: AOJu0YwJHyoPPfitJ+wqJPAMqAwOjtBh0kAeobBbO4aj2z9jrcRsmZIR
	RoINahOpyzcC3yfCuGwJQHUM/qtIy9yubEWxFwYlFTpiRZsXYf8kOG2HN1C/r/mTYI1QZTroNSB
	HYL3yTuAWxqXDPinTzMsVIJH6UfP+jkPwMHo2IRRxwYKALJKSqSZisANtk78hYMBNqEu/enEjQd
	hQKvcn0qaZD7TivP+CBCCOjoQANb5WP0HpARURqXfYMTU7+UuOpE9O
X-Google-Smtp-Source: AGHT+IFfwS6RLIT0f/Yn4EaKV/NLfJbDDqfLmapiFyaLB43lXHjhnqWSutjeMS5sIzjDF/lQyI2bx1k1640=
X-Received: from edbew5.prod.google.com ([2002:a05:6402:5385:b0:5d8:388:5b17])
 (user=gnoack job=prod-delivery.src-stubby-dispatcher) by 2002:a50:8d08:0:b0:5db:dc6b:1354
 with SMTP id 4fb4d7f45d1cf-5dbdc6b1a53mr11522795a12.16.1737733505264; Fri, 24
 Jan 2025 07:45:05 -0800 (PST)
Date: Fri, 24 Jan 2025 15:44:45 +0000
In-Reply-To: <20250124154445.162841-1-gnoack@google.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250124154445.162841-1-gnoack@google.com>
X-Mailer: git-send-email 2.48.1.262.g85cc9f2d1e-goog
Message-ID: <20250124154445.162841-2-gnoack@google.com>
Subject: [PATCH 2/2] landlock: Clarify IPC scoping documentation
From: "=?UTF-8?q?G=C3=BCnther=20Noack?=" <gnoack@google.com>
To: linux-security-module@vger.kernel.org
Cc: "=?UTF-8?q?G=C3=BCnther=20Noack?=" <gnoack@google.com>, 
	"=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?=" <mic@digikod.net>, Tahera Fahimi <fahimitahera@gmail.com>, 
	Tanya Agarwal <tanyaagarwal25699@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

* Clarify terminology
* Stop mixing the unix(7) and signal(7) aspects in the explanation.

Terminology:

* The *IPC Scope* of a Landlock domain is that Landlock domain and its
  nested domains.
* An *operation* (e.g., signaling, connecting to abstract UDS) is said
  *to be scoped within a domain* when the flag for that operation was
  *set at ruleset creation time.  This means that for the purpose of
  *this operation, only processes within the domain's IPC scope are
  *reachable.

Cc: Micka=C3=ABl Sala=C3=BCn <mic@digikod.net>
Cc: Tahera Fahimi <fahimitahera@gmail.com>
Cc: Tanya Agarwal <tanyaagarwal25699@gmail.com>
Signed-off-by: G=C3=BCnther Noack <gnoack@google.com>
---
 Documentation/userspace-api/landlock.rst | 53 ++++++++++++------------
 1 file changed, 26 insertions(+), 27 deletions(-)

diff --git a/Documentation/userspace-api/landlock.rst b/Documentation/users=
pace-api/landlock.rst
index ca8b325d53e5..6b80106d33de 100644
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
-
-A sandboxed process can connect to a non-sandboxed process when its domain=
 is
-not scoped. If a process's domain is scoped, it can only connect to socket=
s
-created by processes in the same scope.
-Moreover, if a process is scoped to send signal to a non-scoped process, i=
t can
-only send signals to processes in the same scope.
-
-A connected datagram socket behaves like a stream socket when its domain i=
s
-scoped, meaning if the domain is scoped after the socket is connected, it =
can
-still :manpage:`send(2)` data just like a stream socket.  However, in the =
same
-scenario, a non-connected datagram socket cannot send data (with
-:manpage:`sendto(2)`) outside its scope.
-
-A process with a scoped domain can inherit a socket created by a non-scope=
d
-process. The process cannot connect to this socket since it has a scoped
-domain.
-
-IPC scoping does not support exceptions, so if a domain is scoped, no rule=
s can
-be added to allow access to resources or processes outside of the scope.
+interactions between sandboxes.  Therefore, at ruleset creation time, each
+Landlock domain can restrict the scope for certain operations, so that the=
se
+operations can only reach out to processes within the same Landlock domain=
 or in
+a nested Landlock domain (the "scope").
+
+The operations which can be scoped are:
+
+``LANDLOCK_SCOPE_SIGNAL``
+    When set, this limits the sending of signals to target processes which=
 run
+    within the same or a nested Landlock domain.
+
+``LANDLOCK_SCOPE_ABSTRACT_UNIX_SOCKET``
+    When set, this limits the set of abstract :manpage:`unix(7)` sockets w=
e can
+    :manpage:`connect(2)` to to socket addresses which were created by a p=
rocess
+    in the same or a nested Landlock domain.
+
+    A :manpage:`send(2)` on a non-connected datagram socket is treated lik=
e an
+    implicit :manpage:`connect(2)` and will be blocked when the remote end=
 does
+    not stem from the same or a nested Landlock domain.
+
+    A :manpage:`send(2)` on a socket which was previously connected will w=
ork.
+    This works for both datagram and stream sockets.
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
2.48.1.262.g85cc9f2d1e-goog

