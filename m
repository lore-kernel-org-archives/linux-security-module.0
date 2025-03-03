Received: from mail-ed1-f73.google.com (mail-ed1-f73.google.com [209.85.208.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD13C1FFC60
	for <linux-security-module@vger.kernel.org>; Mon,  3 Mar 2025 19:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741031490; cv=none; b=lttYSlHj36fTkzTvYjK6UxaS3BWZrmxJ+UOJSJ/3iWZnkS0WsSj4f8XiN9EZKuXZoTWj58C3QVELBFzjgwi5wTJI842OGGc7ahVxpW3H5y7MOn8iGfdKnwNZesshW1Mtx2lBpeNbGFHMfSu70ix8ETxfsFwtrPhuuIxoh0r/fSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741031490; c=relaxed/simple;
	bh=EisHnp36Xfqh6mZ9v1E5Ggl0darjOdAqSpbX3sVgux0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=hu0+QjHk1moP04Lke0w7XjP9wwCphCRzyYyEuwhbxZBKPgN3eOlaaAd4Q7pscZfNmK8LkICg2UrqMjcHPkz+nSBfLH+A2tApWO4x3PrwmiOqUJx2FdY/RzRQLP5hYx8ca+NxZ/pElOcPMcaQik5YgHtS7nVNQRqdEIE2xNhMiQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--gnoack.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SnxYLWat; arc=none smtp.client-ip=209.85.208.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--gnoack.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SnxYLWat"
Received: by mail-ed1-f73.google.com with SMTP id 4fb4d7f45d1cf-5e4c261813bso6247519a12.0
        for <linux-security-module@vger.kernel.org>; Mon, 03 Mar 2025 11:51:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741031487; x=1741636287; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=U9iLjZMCE3cy6A/klAm6ZRsftAKr5JxRQVfnMywvK2Y=;
        b=SnxYLWatuZMsbDyYG3zpJFm8wN6jr0C3aMM+GCOlgwArWxkx6DuENwnLHExkIR2V1v
         0lYZ2m9+zLn1tFUtVvjC4Kpr1UIWMnU1kr4Ajj9Z+KB7Zba3L4fpXbKwz4tkyoXDddRQ
         hsN/83QO6j2HPq5e5ZwFLT14oPEJ2pqI/Pf4IQhztGPgQai/2kdm0ioMkjXvzpl1IBNU
         A579kaZcQGFzhRdDi4eZ45QCDKZwLqXvIf9n0D5ixINQchVRxuIkLFODSWsMSJwPpIS0
         qZeCudtny2VxKCKvBDFsYqKcVk8i0EpstBgUj5+1NeCFGnE7DRHwNB+PffdSIhKFay1u
         peoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741031487; x=1741636287;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=U9iLjZMCE3cy6A/klAm6ZRsftAKr5JxRQVfnMywvK2Y=;
        b=Vj5rI85tMXEtyZvJysCk9rZ85SmKu8TD8zf4wZQmsibCb+YoYY13ltw4CuLJdK/jJ9
         ZeFi7W2d+eJ4qOZwxl3H0TRGjr3DSikDGfU0ac13+WepKNz/JXokthRY4gFr8hZ1UMDR
         4L4L3PjtJ2vp6r1bIU9KEKoUt+8X0d7NbiXHX5uToUY7K5cXSfKvOe5nhdor1UixXcgF
         bQWpZnCZilsH5MQeLvhjTOEYitMf5mpNUCCwNPWkIBnB3lIB3KkWFgGeY4LKFVnTDQzi
         4OH/c2725VNMVBJiGItoKGg11GEb3fPh0ZFUz2jZ4P5qGcTHu7w3dvZtNvO3A9U/0L/t
         paSg==
X-Forwarded-Encrypted: i=1; AJvYcCUfSFBcaptzZQj/WOanm4Qgub8bErCBqg9q1f5Lum24RvVyT4aWT2ksdWS6/y51hz39AYqfteGsoCPDuy7pcrfH0un00bU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNkHsrkPO1VkOwvhc+9zRFAD94jKj01rVJFcYw4Pk/NSYXauBo
	BLl0pTX7UlQIQeAP7RUG0YSla9HI6/EXP5elL5XO/QHj104HyDAZRcOwNeU8Yub6UReKkdPNjsA
	Blw==
X-Google-Smtp-Source: AGHT+IHL4JDJaFQlHdbDQAS7nZhyfFK7YPmNy3QRyIMGp32vdHmYkE8noVJYpRDO4S5pZR7/x0e8muFLy48=
X-Received: from edbes5.prod.google.com ([2002:a05:6402:3805:b0:5e4:ab67:1387])
 (user=gnoack job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6402:27d1:b0:5e0:82a0:50d9
 with SMTP id 4fb4d7f45d1cf-5e4d6b62693mr15249345a12.25.1741031487235; Mon, 03
 Mar 2025 11:51:27 -0800 (PST)
Date: Mon,  3 Mar 2025 20:50:31 +0100
In-Reply-To: <20250303194510.135506-2-gnoack@google.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250303194510.135506-2-gnoack@google.com>
X-Mailer: git-send-email 2.48.1.711.g2feabab25a-goog
Message-ID: <20250303195056.136777-4-gnoack@google.com>
Subject: [PATCH man v3 2/2] landlock.7: Add IPC scoping documentation in line
 with kernel side
From: "=?UTF-8?q?G=C3=BCnther=20Noack?=" <gnoack@google.com>
To: Alejandro Colomar <alx@kernel.org>, 
	"=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?=" <mic@digikod.net>, Tahera Fahimi <fahimitahera@gmail.com>
Cc: "=?UTF-8?q?G=C3=BCnther=20Noack?=" <gnoack@google.com>, Tanya Agarwal <tanyaagarwal25699@gmail.com>, 
	linux-security-module@vger.kernel.org, linux-man@vger.kernel.org, 
	Daniel Burgener <dburgener@linux.microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

* Move over documentation for ABI version 6 (IPC scoping features)
* Clarify terminology
* Stop mixing the unix(7) and signal(7) aspects in the explanation.

With this ABI version, Landlock can restrict outgoing interactions with
higher-privileged Landlock domains through Abstract Unix Domain sockets and
signals.

Terminology:

* The *IPC Scope* of a Landlock domain is that Landlock domain and its
  nested domains.

* An *operation* (e.g., signaling, connecting to abstract UDS) is said to
  be *scoped within a domain* when the flag for that operation was set at
  ruleset creation time.  This means that for the purpose of this
  operation, only processes within the domain's IPC scope are reachable.

Link: https://lore.kernel.org/all/20250303194510.135506-4-gnoack@google.com=
/
Signed-off-by: G=C3=BCnther Noack <gnoack@google.com>
---
 man/man7/landlock.7 | 65 ++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 64 insertions(+), 1 deletion(-)

diff --git a/man/man7/landlock.7 b/man/man7/landlock.7
index 7b7a797ad..aa383860c 100644
--- a/man/man7/landlock.7
+++ b/man/man7/landlock.7
@@ -246,7 +246,8 @@ This access right is available since the fifth version =
of the Landlock ABI.
 .SS Network flags
 These flags enable to restrict a sandboxed process
 to a set of network actions.
-This is supported since the Landlock ABI version 4.
+.P
+This is supported since Landlock ABI version 4.
 .P
 The following access rights apply to TCP port numbers:
 .TP
@@ -256,6 +257,24 @@ Bind a TCP socket to a local port.
 .B LANDLOCK_ACCESS_NET_CONNECT_TCP
 Connect an active TCP socket to a remote port.
 .\"
+.SS Scope flags
+These flags enable isolating a sandboxed process from a set of IPC actions=
.
+Setting a flag for a ruleset will isolate the Landlock domain
+to forbid connections to resources outside the domain.
+.P
+This is supported since Landlock ABI version 6.
+.P
+The following scopes exist:
+.TP
+.B LANDLOCK_SCOPE_ABSTRACT_UNIX_SOCKET
+Restrict a sandboxed process from connecting to an abstract UNIX socket
+created by a process outside the related Landlock domain
+(e.g., a parent domain or a non-sandboxed process).
+.TP
+.B LANDLOCK_SCOPE_SIGNAL
+Restrict a sandboxed process from sending a signal
+to another process outside the domain.
+.\"
 .SS Layers of file path access rights
 Each time a thread enforces a ruleset on itself,
 it updates its Landlock domain with a new layer of policy.
@@ -332,6 +351,47 @@ and related syscalls on a target process,
 a sandboxed process should have a subset of the target process rules,
 which means the tracee must be in a sub-domain of the tracer.
 .\"
+.SS IPC scoping
+Similar to the implicit
+.BR "Ptrace restrictions" ,
+we may want to further restrict interactions between sandboxes.
+Therefore, at ruleset creation time,
+each Landlock domain can restrict the scope for certain operations,
+so that these operations can only reach out to processes
+within the same Landlock domain or in a nested Landlock domain (the "scope=
").
+.P
+The operations which can be scoped are:
+.TP
+.B LANDLOCK_SCOPE_SIGNAL
+This limits the sending of signals to target processes
+which run within the same or a nested Landlock domain.
+.TP
+.B LANDLOCK_SCOPE_ABSTRACT_UNIX_SOCKET
+This limits the set of abstract
+.BR unix (7)
+sockets to which we can
+.BR connect (2)
+to socket addresses which were created
+by a process in the same or a nested Landlock domain.
+.IP
+A
+.BR sendto (2)
+on a non-connected datagram socket is treated as if it were doing an impli=
cit
+.BR connect (2)
+and will be blocked if the remote end does not stem
+from the same or a nested Landlock domain.
+.IP
+A
+.BR sendto (2)
+on a socket which was previously connected will not be restricted.
+This works for both datagram and stream sockets.
+.P
+IPC scoping does not support exceptions via
+.BR landlock_add_rule (2).
+If an operation is scoped within a domain,
+no rules can be added to allow access to
+resources or processes outside of the scope.
+.\"
 .SS Truncating files
 The operations covered by
 .B LANDLOCK_ACCESS_FS_WRITE_FILE
@@ -411,6 +471,9 @@ _	_	_
 \^	\^	LANDLOCK_ACCESS_NET_CONNECT_TCP
 _	_	_
 5	6.10	LANDLOCK_ACCESS_FS_IOCTL_DEV
+_	_	_
+6	6.12	LANDLOCK_SCOPE_ABSTRACT_UNIX_SOCKET
+\^	\^	LANDLOCK_SCOPE_SIGNAL
 .TE
 .P
 Users should use the Landlock ABI version rather than the kernel version
--=20
2.48.1.711.g2feabab25a-goog

