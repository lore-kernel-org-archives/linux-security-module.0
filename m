Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1E3836495D
	for <linux-security-module@vger.kernel.org>; Mon, 16 Mar 2026 21:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773696983; cv=none; b=LnZJm8OpjqyKdQVsyW5GKjtrZnnKjOu/ZxDhUZgfR6ltokVmXHQLZX/kAPmDaYbcLhAB+3kYyeU0NAUQEKZuk4/fSUJCV0YK1jLIAlBRv6wb0oJv5Y3neVDLIu20FbJSZqTVWwQXab/KtvPlKW8cuKrzsPiokthZafkYgTHnWvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773696983; c=relaxed/simple;
	bh=ZHHsteO5AvuECau+jGB9nG1dY25l2SiYgEOKuw8Dlbo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oJw+s9iVLdUna9xjfYS+RGkoWyQXJ8ftRlsbxPfKEPpOP/eRKxMTLiRbf1vmSV6Qrv8stfYikJlUaqvQnB6trYmgg8OHgZ+Uz9q5B1dDhLprYJbmlMcXC1sZUP1IXjH7g9YhV0Zy4l9BYJr9kRG/ZeDHp35goHyHZR7GnEF7/o0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=Ftw2W6s/; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="Ftw2W6s/"
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-5090c48de85so57887211cf.0
        for <linux-security-module@vger.kernel.org>; Mon, 16 Mar 2026 14:36:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1773696981; x=1774301781; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UuAmGgbfl+JV2g5jci7AOV5QImEZLcznAUEhETM+f8o=;
        b=Ftw2W6s/R7WmEhemFD+epoWcOKvY0noPp8ClwdgCGW1KwGlLWrfXWJbkzMpZyDFbUd
         aEYzSWU1pl1UIDcKppkdvYZ3KCCPdQzbNY2guJkYf2Z3pzjwVfKc/IAbPZ0S+WwMukwE
         yXfGXLHfGaAw4Li7C0rsOzDpdSUQ5RPT1HpVKE5S8VvFuNe64OPGYHKAZSqeuG5KNcMS
         3aMmEfxIya9tqk8gahcJCTNDBKja1NzqJQ7CFsqXw07X/j6vZGF7UxvSsIfnNVh2rX7C
         xFESR4xhVIfZ5cXWyVfX9T70tqG6cLG0S9Ry1BPgA0qOIPh4ifdSrUIYqzaiz1t35DSQ
         91MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773696981; x=1774301781;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UuAmGgbfl+JV2g5jci7AOV5QImEZLcznAUEhETM+f8o=;
        b=ph4pQxkA5ViRqvWt3xTf7u85yMJTgIqrXwpjpmbHGquEZ0b8/Te8/heTyi1v/u0mon
         wZbeU0WONW1qZy46sfbry1DpQWWkDXnAxkAoqmaUpd7uGmrFg6vemGAcnUUFYB7WmuxH
         6RBgSy1ebcJYVSy5wG7OCRywkpENZj3AcqtQiNQ5NTgdKK9AQryPhm7lb6A1uxvGoIiJ
         CL3cYI/xHpio0LDBMHtRO5yruXErQLAzNJUuywo2kmJtUnpYM0P2Qrf5VCkx7mcLHw+d
         viknUdFyEVj51Lc4ftqw2gQd5E40V/2Tla5W1PWatb9RQib49VmXWbqIJ2IOqQg3cErR
         J0RQ==
X-Gm-Message-State: AOJu0YwThmaNXYRyxTg4fMJ7ViOaMIfhn4xug0QYV3ZGbdZBOCjgbfZ6
	na2Wv4TTQLZcv9zSZPXtwfzDpv2AnXIiGdbIP35HTiOHiNk20YICwbrI5tpFyYtoa5wqrtnB4ZP
	sfa4=
X-Gm-Gg: ATEYQzyBKHKtJwO/SlAq6MBXClVpY4EtzXvBgnPDIDmi45uu2ONnW80qhp3rMqFmzuA
	kMv5J+fLENs0o/u1I6FsnlokvtJ2cO1N6FBaAGHtNmw3OfKsTu9/6jkjgORfGXnLnnfFyVgrSD1
	gKq7f5uHSbkGfcguoYCG/qrHyx2KVMCVKZlrF36+yTRnYX23LrQziJm8JKQH6bUgM6QnruTBGsr
	W3gj287CoU7azYqqD0bNCc10PVhSA1I48RQ4LC/Jj6D5MNtdmw67Ec1nT/9WFSvo3R8S3pZRson
	rovWV+fX1J3vaHW6ZwZH1J6E8gLioUA+vqd0xAxOYd5/Ptcv7sHqwUUeyA/vN30OUYyRiqbqPzT
	lnxy9lGi/saMSp136vIBvD9J+5kXnxs2KzJFTJVjj8x8gHyIxzBn2KMKQusTCH5FAfXs7jDHlV2
	3S8fzA2fAo4ytj1AgB/62vsJtvXQJhPjAE+n7rjvRreqzwXM4fFXN0rMnv8tfc1IT4kwyz
X-Received: by 2002:a05:622a:199d:b0:509:99c:2cbc with SMTP id d75a77b69052e-50957e1106cmr194434801cf.63.1773696981096;
        Mon, 16 Mar 2026 14:36:21 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5094a03556csm105356641cf.2.2026.03.16.14.36.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2026 14:36:20 -0700 (PDT)
From: Paul Moore <paul@paul-moore.com>
To: linux-security-module@vger.kernel.org,
	selinux@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-unionfs@vger.kernel.org,
	linux-erofs@lists.ozlabs.org
Cc: Amir Goldstein <amir73il@gmail.com>,
	Gao Xiang <xiang@kernel.org>
Subject: [PATCH 0/3] Fix incorrect overlayfs mmap() and mprotect() LSM access controls
Date: Mon, 16 Mar 2026 17:35:55 -0400
Message-ID: <20260316213606.374109-5-paul@paul-moore.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The existing mmap() and mprotect() LSM access control points for the
overlayfs filesystem are incomplete in that they do not cover both the
user and backing files.  This patchset corrects this through the addition
of a new backing file specific LSM hook, security_mmap_backing_file(),
a new user path file associated with a backing file that can be used by
LSMs in the security_file_mprotect() code path, and the associated
SELinux code changes.

The security_mmap_backing_file() hook is intended to allow LSMs to apply
access controls on mmap() operations accessing a backing file, similar to
the security_mmap_file() for user files.  Due to the details around the
accesses and the desire to distinguish between the two types of accesses,
a new LSM hook was needed.  More information on this new hook can be
found in the associated patch.

The new user path file replaces the existing user path stored in the
backing file.  This change was necessary to support LSM based access
controls in the mprotect() code path where only one file is accessible
via the vma->vm_file field.  Unfortunately, storing a reference to the
user file inside the backing file does not work due to the cyclic
ref counting so a stand-in was necessary, the new user O_PATH file.
This new O_PATH file is intended to be representative of the original
user file and can be used by LSMs to make access control decisions based
on both the backing and user files.

The SELinux changes in this patchset involve making use of the new
security_mmap_backing_file() hook and updating the existing mprotect()
access controls to take into account both the backing and user files.
These changes preserve the existing SELinux approach of allowing access
on overlayfs files if the current task has the necessary rights to the
user file and the mounting process has the necessary rights to the
underlying backing file.

--
Amir Goldstein (1):
      backing_file: store user_path_file

Paul Moore (2):
      lsm: add the security_mmap_backing_file() hook
      selinux: fix overlayfs mmap() and mprotect() access checks

 fs/backing-file.c             |   28 +++++---
 fs/erofs/ishare.c             |   12 ++-
 fs/file_table.c               |   53 +++++++++++++---
 fs/fuse/passthrough.c         |    3 
 fs/internal.h                 |    5 -
 fs/overlayfs/dir.c            |    3 
 fs/overlayfs/file.c           |    1 
 include/linux/backing-file.h  |   29 ++++++++-
 include/linux/file_ref.h      |   10 ---
 include/linux/lsm_audit.h     |    2 
 include/linux/lsm_hook_defs.h |    2 
 include/linux/security.h      |   10 +++
 security/security.c           |   25 +++++++
 security/selinux/hooks.c      |  108 ++++++++++++++++++++++++++++------
 14 files changed, 231 insertions(+), 60 deletions(-)

