Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E48A22417D1
	for <linux-security-module@vger.kernel.org>; Sat, 11 Apr 2026 09:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775898618; cv=none; b=GXKeyQb2t2bS/JGgJwCHbVASo4Z4jdT9IpPq4j4RvuRyL7u0MhfDHXNB2rUmm0ptVwQRJv21LFWizT0n3X2zuMSj5TTmGjYO7NpCgksjJBSk6WWziYIlc9O1elDwRogTLqL1hY389e3spjgHmXgKWJ/x2Vd0Rp6soqYy0F5x01k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775898618; c=relaxed/simple;
	bh=J8z+RgmNnH4bgcNYzvuL+pU3F3T9gT3HICxT4bkPIvE=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=GcWP1YT//tnGe4RepN8PTAz0Yt9GpD2xZD5dsMnHghuNjuvS+94ek6pixnjKBLS/DSfmfZPgLuG/HgFIoxh24rsfI7fVhRsX5O5IMi/9hKEHDOIxelzTAWDRpflp+FQeK9rVty0tbt3YClRFqxNY+xcrJ55HcBtugKiEGATRThU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--gnoack.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=v6huwkGw; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--gnoack.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="v6huwkGw"
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-488d4ac6ff9so11990545e9.1
        for <linux-security-module@vger.kernel.org>; Sat, 11 Apr 2026 02:10:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775898615; x=1776503415; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:from:to:cc:subject:date:message-id:reply-to;
        bh=127o4HDS6+Bv2199Lrxa79+ntmr5bNns4x8YhtzA5eo=;
        b=v6huwkGwnFJ9mqB3YZ/qUw16MSRiYXESiwOHouzRGMRoQoJGkM2wyyFf9SL3t66q54
         kr0U/hZ9/M9YdKztBMPS68LUMpmGt40BGNubYjGQlXe1TlEoekiIxYxqArFZbr3vOivv
         1YBUst4nIXsLxpK8Pm2VMBYMCuBVtEYmNoZcCapRzARJuizIFhy9DN4o2VI3tWqd/MRc
         AkK/fa7meXYktnX+ClSFvDkq1p5QTMRiaC7G9ebsyExXZ6MCViOWuH1iRU/jsBAf0hl2
         P3eB2FiwPJbJGofqPtLfEBBrK4juy183gJxhcRDLSR6JIH86GFigBlfdQ+bTa83/vRNU
         MHPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775898615; x=1776503415;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=127o4HDS6+Bv2199Lrxa79+ntmr5bNns4x8YhtzA5eo=;
        b=fEv6JiLGqBw2A4qxI1roimQw598R6YlSWpC3Axh+N+GBhslqIcaVU4rUX2H/lzFGDR
         EoOozw9Zsu4JTB3jgB0GdD+QU+MXz7iNIVhTRj9qFNmz6hsX0paJawcAsd/Q5SNfXrFh
         6eNJc3E2fp0wR9ZS0yPTFszk5vLJNJ90zuAeW11CAQ9lMbpRX4Fl1ooe72Bv2sjAbtRh
         7q4VJ1f2fbGuUs3yNRJUEeYtgbvPabaEafJ2TQUWjWrchniuvVh+pPSAcXs2ppFxt65j
         LBfsDxzLzVpFhyVX2M2/AUi3Oo/jFE+i1fdgZ0F4q9SeCeb+sP/JUcFty1OnpOPHFxGS
         URiw==
X-Gm-Message-State: AOJu0YwjWBOwapV6SE3G5joYHU3WKsvy4jXTrKuWImW9/L/0L6/AD7gc
	Y3/nzpgrA0mnrsz7MCy/K+SG5tQt1ISlkkxRzL+1Gzq0xiNxBkoW9evcCzcWM6QDZZ3OsVJL6TN
	KsLW6Ew==
X-Received: from wmpf21.prod.google.com ([2002:a05:600c:4915:b0:488:7e69:14c1])
 (user=gnoack job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:3047:b0:488:d6eb:e635
 with SMTP id 5b1f17b1804b1-488d6ebe7ebmr49955835e9.12.1775898615153; Sat, 11
 Apr 2026 02:10:15 -0700 (PDT)
Date: Sat, 11 Apr 2026 11:09:42 +0200
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.rc0.605.g598a273b03-goog
Message-ID: <20260411090944.3131168-2-gnoack@google.com>
Subject: [PATCH 0/3] landlock: Restrict renameat2 with RENAME_WHITEOUT
From: "=?UTF-8?q?G=C3=BCnther=20Noack?=" <gnoack@google.com>
To: "=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?=" <mic@digikod.net>, Christian Brauner <brauner@kernel.org>
Cc: linux-security-module@vger.kernel.org, Paul Moore <paul@paul-moore.com>, 
	Amir Goldstein <amir73il@gmail.com>, Miklos Szeredi <miklos@szeredi.hu>, Serge Hallyn <serge@hallyn.com>, 
	"=?UTF-8?q?G=C3=BCnther=20Noack?=" <gnoack@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello!

As discussed in [1], the renameat2() syscall's RENAME_WHITEOUT flag allows
the creation of chardev directory entries with major=3Dminor=3D0 as "whiteo=
ut
objects" in the location of the rename source file [2].

This functionality is available even without having any OverlayFS mounted
and can be invoked with the regular renameat2(2) syscall [3].


Motivation
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

The RENAME_WHITEOUT flag side-steps Landlock's LANDLOCK_ACCESS_FS_MAKE_CHAR
right, which is designed to restrict the creation of chardev device files.

This patch set fixes that by adding a check in Landlock's path_rename hook.


Tradeoffs considered in the implementation
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

Q: Should we guard it with a dedicated LANDLOCK_ACCESS_FS_MAKE_WHITEOUT
   right?

   Pros:
   * This would be the fully backwards compatible solution,
     and Linux always strives for full backward compatibility.

   Cons:
   * Complicates the Landlock API surface for a very minor use case.

     In Debian Code search, the only use of RENAME_WHITEOUT from userspace
     seems to be for fuse-overlayfs.  It is used there for the same purpose
     as in the kernel OverlayFS and it likely does not run in a Landlock
     domain.

   The tradeoff does not seem worth it to me.  The chances that we break
   anyone with this seem very low, and I'm inclined to treat it as a bugfix
   for the existing LANDLOCK_ACCESS_FS_MAKE_CHAR right.


Q: Should we add a Landlock erratum for this?

   I punted on it for now, but we can do it if needed.

Q: Should the access right check be merged into the longer
   current_check_refer_path() function?

   I am leaning towards keeping it as a special case earlier.  This means
   that we traverse the source path twice, but as we have seen in Debian
   Code Search, there are apparently no legitimate callers of renameat2()
   with RENAME_WHITEOUT who are calling this from within a Landlock domain.
   (fuse-overlayfs is legitimate, but is not landlocked)

   It doesn't seem worth complicating our common rename code for a corner
   case that doesn't happen in practice.


[1] https://lore.kernel.org/all/adUBCQXrt7kmgqJT@google.com/
[2] https://docs.kernel.org/filesystems/overlayfs.html#whiteouts-and-opaque=
-directories
[3] https://man7.org/linux/man-pages/man2/renameat2.2.html#DESCRIPTION
[4] https://codesearch.debian.net/search?q=3Drename.*RENAME_WHITEOUT&litera=
l=3D0


G=C3=BCnther Noack (3):
  landlock: Require LANDLOCK_ACCESS_FS_MAKE_CHAR for RENAME_WHITEOUT
  selftests/landlock: Add test for RENAME_WHITEOUT denial
  selftests/landlock: Test OverlayFS renames w/o
    LANDLOCK_ACCESS_FS_MAKE_CHAR

 security/landlock/fs.c                     | 16 ++++++++
 tools/testing/selftests/landlock/fs_test.c | 45 ++++++++++++++++++++++
 2 files changed, 61 insertions(+)

--=20
2.54.0.rc0.605.g598a273b03-goog

