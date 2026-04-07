Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D896372B3B
	for <linux-security-module@vger.kernel.org>; Tue,  7 Apr 2026 13:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775567123; cv=none; b=lwIcyNS8bCysITcPj0TNhE3JG02lOAzwjOklK2Mh9mqm620ce1yXcf0jVadNNDhjtron6FLBVE7I/8AJ9SRZ9n+zB4VEfiz4/mtagqgTfpDkaHCpm5ZS9h+B88IjY2grixKZzBMx46KRniQ4xy+xxqIQy0Pp61RITDuWwHxNcKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775567123; c=relaxed/simple;
	bh=1G1PvJ9sljvQHnODv9BNC37tg5Ir59mfeBIQTEmltUA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=LVpFk5NdviSFDkZ1ZqIwAmK7FUYruTvPxrC56TUhiBFB34z694pVulZpyYfoZ9oabOPe5dtdL/tC0y7hgI2xppfgwjCI9I427cnwTpro+vQMcqhVbiQTakaqaXyu4L0ecqKZx9UIpsA8d9+RyGopw1ms9kDpO1ekXn2oUi8SASs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tpxu/MFa; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tpxu/MFa"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-43cff5dafc3so4401414f8f.1
        for <linux-security-module@vger.kernel.org>; Tue, 07 Apr 2026 06:05:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775567120; x=1776171920; darn=vger.kernel.org;
        h=content-transfer-encoding:content-disposition:mime-version
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oipARofKieVoI6IiaE0rpflVsalDoSLrUlN/Dq4QXVo=;
        b=tpxu/MFanc9wxu3l0wUczsvcaAFbQpOppX2t4UOc0eTOTDX9aKK/qPDzyK9N0EWJtK
         zfXJzzvvnkyRz8KclFsyFNYQNucvnzygVpl48AN2zCpn6vsKW7O4WKhAMGm672x0fUwI
         0TK6vkDVsCswQnsLPIhhhp+gqq1rvLEzkDUhVofrmLN22bj7P57w8QVuU0W41A2lqGgn
         OgiD4xdK/jfVAxK3cSj/8EQZda3oiCL1olp+DdVpL4kRGDRrVQ/u65vKQoci+p1SnoP1
         yrHb13Kls8Hmy4EOmH6yMp8M+a4oig9EpSMMUe+9Y8zReqq99eOhSgdv+EiwRGIlfE8Q
         CqtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775567120; x=1776171920;
        h=content-transfer-encoding:content-disposition:mime-version
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=oipARofKieVoI6IiaE0rpflVsalDoSLrUlN/Dq4QXVo=;
        b=ZLHt7EC3bSIj22GX7KtNbhwRZiFUy86uNbMxSptOe5X7LRlq6+mn9us+ICVAumMqsa
         Z514b8+XQni1N5jdw7jNx4jYU8jeJ+lQ09PuqMBTlEGS8aKQ6ha2XQWZRZBDePJRO2UG
         EftXKTowkmzcdkvecTKIh3e1Chfvo8/OyjQiqz2uQoujo3L7cKwPxRvW0KZYJgGuKtna
         SxkUA2KQFZsraKwd6Efwts2hERjc8Db77movkDdB6sJcqv0MSL9kwiLf6gmT+X8M+9/L
         kNmZxxFsWOgLJEFLF977mJ7/8rkyPvibA8dTjKgk7iZ71s4D3mKawQnoPAcIBwZTNOSw
         t77A==
X-Gm-Message-State: AOJu0YzcqSHVIpNRlXbALDAltXgBuppR9GtZmyQqQsa/gni+gSTgPex/
	YRddOxmLf09GHLtwc6zJKWb8bsty7eU3QRoH3uRO7/qjmjranqSvoal+kvdpZQY62SFxKXoEfB8
	4Jizrl45n
X-Gm-Gg: AeBDieuhKp1VSi4YokCtf5NdirhLh22UM+IuaYPF9xwh98MFQunq4Vmn5SSizstnWXE
	C9pJIcCkdQ1xXJGJMj+DHFX7rNVARe4I801KbdbQNW7ywFJZRgrDu+YzDQa2t2ErujPwVoy+A5u
	uJFQgI2tPCClTGY6IXbKQ1HNQuBC3iNapIGes2vNIE7/emq64wCyde2atwjc/53wYGZGOT2CUnc
	CASNDLR6BWvioOLzh8DHMaySg6/bvE0g6ikNw/9bQaiG8XMXzoBnXPqL7QjdEPkH3K/RkH4uPrE
	QxHrgZlpCOZPX2ipQNyjtsUHBe+SFRCY9f4O6Nr9No0nRzuDHd90da2SpTJhLEpJombHRARZnwr
	LleZvKKyTrETTVGVMWiAL2HfvmxUAIGTyVS1pNkIkW18F+AYMWJGu4bwMK5t5zMpLh7H31b6XZu
	2ZU4Rv4V6G2hcbh5Y1rSQaPy/4XJoFEAY6MQUjsb7Gyb6MkJH1xlyvJhnP1DjD9IWJ
X-Received: by 2002:a05:6000:1acd:b0:43b:45d1:f449 with SMTP id ffacd0b85a97d-43d292f5827mr23214806f8f.51.1775567119836;
        Tue, 07 Apr 2026 06:05:19 -0700 (PDT)
Received: from google.com ([2a00:79e0:288a:8:1b63:327a:301d:8eab])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43d1e2c54bdsm51322313f8f.16.2026.04.07.06.05.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2026 06:05:18 -0700 (PDT)
Date: Tue, 7 Apr 2026 15:05:13 +0200
From: =?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>
To: Christian Brauner <brauner@kernel.org>,
	=?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>,
	Paul Moore <paul@paul-moore.com>
Cc: linux-security-module@vger.kernel.org
Subject: LSM: Whiteout chardev creation sidesteps mknod hook
Message-ID: <adUBCQXrt7kmgqJT@google.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

Hello Christian, Paul, Mickaël and LSM maintainers!

I discovered the following bug in Landlock, which potentially also
affects other LSMs:

With renameat2(2)'s RENAME_WHITEOUT flag, it is possible to create a
"whiteout object" at the source of the rename.  Whiteout objects are
character devices with major/minor (0, 0) -- these devices are not
bound to any driver, so they are harmless, but still, the creation of
these files can sidestep the LANDLOCK_ACCESS_FS_MAKE_CHAR access right
in Landlock.


I am unconvinced which is the right fix here -- do you have an opinion
on this from the VFS/LSM side?


Option 1: Make filesystems call security_path_mknod() during RENAME_WHITEOUT?

Do it in the VFS rename hook.

* Pro: Fixes it for all LSMs
* Con: Call would have to be done in multiple filesystems


Option 2: Handle it in security_{path,inode}_rename()

Make Landlock handle it in security_inode_rename() by looking for the
RENAME_WHITEOUT flag.

* Con: Operation should only be denied if the file system even
  implements RENAME_WHITEOUT, and we would have to maintain a list of
  affected filesystems for that.  (That feels like solving it at the
  wrong layer of abstraction.)
* Con: Unclear whether other LSMs need a similar fix


Option 3: Declare that this is working as intended?

* Pro: (0, 0) is not a "real" character device


In cases 1 and 2, we'd likely need to double check that we are not
breaking existing scenarios involving OverlayFS, by suddenly requiring
a more lax policy for creating character devices on these directories.

Please let me know what you think.  I'm specifically interested in:

1. Christian: What is the appropriate way to do this VFS wise?
2. LSM maintainers: Is this a bug that affects other LSMs as well?

Thanks,
—Günther

P.S.: For full transparency, I found this bug by pointing Google
Gemini at the Landlock codebase.
