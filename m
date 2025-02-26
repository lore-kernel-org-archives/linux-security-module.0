Received: from mail-ed1-f73.google.com (mail-ed1-f73.google.com [209.85.208.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 345FF15852E
	for <linux-security-module@vger.kernel.org>; Wed, 26 Feb 2025 21:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740604732; cv=none; b=p7FKK5wQC74Wi71gnDkEqtXNnmC9Kmle7uZsW5tA+b0vWsNZ6CUNOHQVlIhm4/wrcyqEe9iJKTqGhg33vNlbH9wT2J5CHD1Cn+rStRXRiDh9IuRcPdTuIE/uV+12pIlafYlTFqTaiqOkaNKcvIbnc0+5jqCuvdipseZ0Aj8urHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740604732; c=relaxed/simple;
	bh=X20nqFkTMfMq6XxnXPK8V5lwD90N6aAWra99rUjR9P0=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=SnJiIy8cMSvZLyzKWH54iohr+tM0D4+TRcsycoa9O49MtjGumczDiv9YOor2failY39fRGCBDHdYi3+h4SNG1J1JtXzjtbUB1R03MuXUP/Jmtd/GtenAGbk4/QL5CKkdJ+Kd9x8OS2udf9G5dD7i2A3CrtCHxstwpJoSp+cS9mo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--gnoack.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FXuMWwCV; arc=none smtp.client-ip=209.85.208.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--gnoack.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FXuMWwCV"
Received: by mail-ed1-f73.google.com with SMTP id 4fb4d7f45d1cf-5e4becb4582so171661a12.3
        for <linux-security-module@vger.kernel.org>; Wed, 26 Feb 2025 13:18:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740604729; x=1741209529; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vB60kpD9YkIPX3mHegNvRGxuQxipw1V9ucaDBv79txE=;
        b=FXuMWwCVflY4pPg7Ea/LP6qyc+m43ru5BKFXhdOyvh2az65VU6dhGeMu8enCtDLWM9
         jpZYZkc7m1GNNkLaks6uARx1tsfW5mmWdbQU6RepbT9jiduRC6MG1bN/N3uRqpbWnDfT
         apHZuJKAs8O/1O4iMBnEGHnX9aqgvCQNdZSDWYUkiXtsFdFIPFfGKuVXX1KAjO7KYils
         m3pUpe65nhMYDjqiZpwtTq9u2K+ijcSx6XP7+DoDikqRZQwnki/PtK9UZB3RoYcisFU3
         Ew8fiqAuIJ0BmQw5fLcZ9qSH+uL7KjT0kLECh5MIHqrT4x1TQ48VmiadbIhTaSLA4lVj
         lbWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740604729; x=1741209529;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vB60kpD9YkIPX3mHegNvRGxuQxipw1V9ucaDBv79txE=;
        b=MahtIzlWvKh9rBjtf2vxhRQTk69GRjYhEqzFNP++1luuV2/NVfOkLipzJO1FPEKjOc
         +uGJJq/yQSu0XKPRfwRcCvfQJXSeJsibuiIgKyaf6d6BJrA/DIwqnGQ02RBdJ7vcR2D3
         YDkHs5+ZRsTlD2fQADZB5XFZAzcM1zbWGyuUPNpUG51g6EyYVYXY/AUbtpUnLjkLRL1j
         c+e8WimkoKR0ArRf1GfumS3tPGq/PDpzh+JmW9xd70Nz+3AqfVCip/Sk5HCze4w/lZY8
         d2H15FcNv+BVI7fRDk/FqPoi+lyYVCV/hhPG8128ETc35vpNkDF02av4ktC96Y2jerVJ
         II2w==
X-Forwarded-Encrypted: i=1; AJvYcCVMIHyiQeIRsdhK1af2QDktLIknwBtfAjY+WvyfkLjrot6T3u/yz+0mMfYbYNEm2Rgd1fSI0OpwKf/KsE3Uw6rbnotEsQ8=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywl5nREcNY3A4E3eCOTXQSVH5Mm06SZv+6kf1gUs7eJupRvzl2U
	iB3ru53/lf+1pjVwQuchAfhGpo+WS+NxjXccPPosrMySEr3BcfEDudC/Xs0Wp4vgSSvBmdsoLAY
	t1A==
X-Google-Smtp-Source: AGHT+IEn8y09Zy8TsAqgrYEr7+zi7FI2Sq6nYESVKo7UTkSN8gHtO3Xi4R/D+aQsInprHRsSk5XcarjUB7Q=
X-Received: from edah39.prod.google.com ([2002:a05:6402:ea7:b0:5e0:a9b0:d3d4])
 (user=gnoack job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6402:208a:b0:5e0:2e70:c2af
 with SMTP id 4fb4d7f45d1cf-5e44a2545e5mr9541871a12.26.1740604729620; Wed, 26
 Feb 2025 13:18:49 -0800 (PST)
Date: Wed, 26 Feb 2025 22:18:14 +0100
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.48.1.711.g2feabab25a-goog
Message-ID: <20250226211814.31420-2-gnoack@google.com>
Subject: [PATCH v2 0/1] landlock: Clarify IPC scoping documentation
From: "=?UTF-8?q?G=C3=BCnther=20Noack?=" <gnoack@google.com>
To: "=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?=" <mic@digikod.net>, Tahera Fahimi <fahimitahera@gmail.com>, 
	Alejandro Colomar <alx@kernel.org>
Cc: "=?UTF-8?q?G=C3=BCnther=20Noack?=" <gnoack@google.com>, Tanya Agarwal <tanyaagarwal25699@gmail.com>, 
	linux-security-module@vger.kernel.org, 
	Daniel Burgener <dburgener@linux.microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello!

Thank you for your feedback, here is the second version.

Changes in V2:

* As Micka=C3=ABl already applied the first commit ("Minor typo and grammar=
 fixes in
  IPC scoping documentation"), this one is left out here.

* Applied remarks by Daniel Burgener, Alejandro Colomar and Micka=C3=ABl Sa=
la=C3=BCn

* Replaced reference to send(2) with sendto(2), which is slightly more
  appropriate in that place.

For your convenience, the range-diff at the bottom shows the diff between t=
he
two patch sets (checkpatch.pl complains about it, but it's just in the cove=
r
letter).

=E2=80=94G=C3=BCnther

G=C3=BCnther Noack (1):
  landlock: Clarify IPC scoping documentation

 Documentation/userspace-api/landlock.rst | 45 ++++++++++++------------
 1 file changed, 22 insertions(+), 23 deletions(-)

Range-diff against v1:
1:  7df39814a3a6 < -:  ------------ landlock: Minor typo and grammar fixes =
in IPC scoping documentation
2:  c86636efac8d ! 1:  d288be2c7b94 landlock: Clarify IPC scoping documenta=
tion
    @@ Commit message
    =20
         * The *IPC Scope* of a Landlock domain is that Landlock domain and=
 its
           nested domains.
    -    * An *operation* (e.g., signaling, connecting to abstract UDS) is =
said
    -      *to be scoped within a domain* when the flag for that operation =
was
    -      *set at ruleset creation time.  This means that for the purpose =
of
    -      *this operation, only processes within the domain's IPC scope ar=
e
    -      *reachable.
    +    * An *operation* (e.g., signaling, connecting to abstract UDS) is =
said to
    +      be *scoped within a domain* when the flag for that operation was=
 set at
    +      ruleset creation time.  This means that for the purpose of this
    +      operation, only processes within the domain's IPC scope are reac=
hable.
    =20
    -    Cc: Micka=C3=ABl Sala=C3=BCn <mic@digikod.net>
    -    Cc: Tahera Fahimi <fahimitahera@gmail.com>
    -    Cc: Tanya Agarwal <tanyaagarwal25699@gmail.com>
         Signed-off-by: G=C3=BCnther Noack <gnoack@google.com>
    =20
      ## Documentation/userspace-api/landlock.rst ##
    @@ Documentation/userspace-api/landlock.rst: IPC scoping
     -scenario, a non-connected datagram socket cannot send data (with
     -:manpage:`sendto(2)`) outside its scope.
     +``LANDLOCK_SCOPE_SIGNAL``
    -+    When set, this limits the sending of signals to target processes =
which run
    -+    within the same or a nested Landlock domain.
    ++    This limits the sending of signals to target processes which run =
within the
    ++    same or a nested Landlock domain.
     =20
     -A process with a scoped domain can inherit a socket created by a non-=
scoped
     -process. The process cannot connect to this socket since it has a sco=
ped
     -domain.
     +``LANDLOCK_SCOPE_ABSTRACT_UNIX_SOCKET``
    -+    When set, this limits the set of abstract :manpage:`unix(7)` sock=
ets we can
    -+    :manpage:`connect(2)` to to socket addresses which were created b=
y a process
    -+    in the same or a nested Landlock domain.
    ++    This limits the set of abstract :manpage:`unix(7)` sockets to whi=
ch we can
    ++    :manpage:`connect(2)` to socket addresses which were created by a=
 process in
    ++    the same or a nested Landlock domain.
     =20
     -IPC scoping does not support exceptions, so if a domain is scoped, no=
 rules can
     -be added to allow access to resources or processes outside of the sco=
pe.
    -+    A :manpage:`send(2)` on a non-connected datagram socket is treate=
d like an
    -+    implicit :manpage:`connect(2)` and will be blocked when the remot=
e end does
    -+    not stem from the same or a nested Landlock domain.
    ++    A :manpage:`sendto(2)` on a non-connected datagram socket is trea=
ted as if
    ++    it were doing an implicit :manpage:`connect(2)` and will be block=
ed if the
    ++    remote end does not stem from the same or a nested Landlock domai=
n.
     +
    -+    A :manpage:`send(2)` on a socket which was previously connected w=
ill work.
    -+    This works for both datagram and stream sockets.
    ++    A :manpage:`sendto(2)` on a socket which was previously connected=
 will not
    ++    be restricted.  This works for both datagram and stream sockets.
     +
     +IPC scoping does not support exceptions via :manpage:`landlock_add_ru=
le(2)`.
     +If an operation is scoped within a domain, no rules can be added to a=
llow access
--=20
2.48.1.711.g2feabab25a-goog

