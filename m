Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793375112;
	b=kE1eMeNe3UKLY6bcmFWKUqR06acFhsIWEh+cJOtcAMC6Yj+/bTlmvZOb32f90pr13XGY
	 SfQ+jV4qdYbzbZdblwfjJqhQ83vdt/xJbIceOFLlu8p4+wn3vsQ91MbDgPt6LplyC3ul/
	 SzbFZlqxt27U6BhZtsK2mtCeJG+BUpylbNEd2Rl4AakguztrKYI3e/djRhvKY3znTU5ia
	 W9p07JcNijHdGvsvUwt9IhgQ4pohwGoXWz8KzSNNGmQ8CVfTidYCD4v5kqu3faKrrFg9a
	 BJJJen8P24MAWJe+Wjk9D8m2ejyz2QOj1AU3pCRdvWq4TJSGMCNYlTqxGginAbl1LXQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793375112;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding;
	bh=hLhpSxs/CI8L6fPpKCYlBQ7uDJcGOM1i7tYlKx8Tjmc=;
	b=MTGWr2lSAcfPf63+ZeKbTcF36bq/Mu7ZAylql2qgD/GlDjQAHWX0UhLmWNUvUyL0oYxc
	 EQTxsT0pxKlZ2Y1M8UcA72GcyTxNN6QoyzzQtPBpSRplaAkm5LpD4V45NBd25klT1b5nV
	 1AKitU1PkvRuDg7PYOkRzxqZC++SBG/LCC7SkWC8iQz+b5jr8aOIajlA9uNkvXiBnwRkA
	 9XYDSU1/ch9qdyUD5PG3RfbXMxcZ17dG0LJwVw33KNhfk9+0FNx7nrkDIoWhnMdljXNsC
	 nobrOb+I1nin0d2XMCUE9amn56/gFVCB2tKj/1lNf4o5fVA2p9NdxlODKqVbfCgGY0w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=kJCb30Cu;
	arc=none smtp.remote-ip=209.85.128.48
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 893B1606A31D
	for <linux-security-module@vger.kernel.org>; Fri, 30 Oct 2026 15:45:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 893B1606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=kJCb30Cu
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4a9a8d6cea8so11032195e9.1
        for <linux-security-module@vger.kernel.org>; Fri, 30 Oct 2026 08:45:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793375111; x=1793979911; darn=vger.kernel.org;
        h=content-transfer-encoding:content-disposition:content-type
         :mime-version:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=hLhpSxs/CI8L6fPpKCYlBQ7uDJcGOM1i7tYlKx8Tjmc=;
        b=kJCb30CumIs39BYjENNb8QuYW3xpPW52sdHuKI4pKjROlEqtqanFqcEhQ69xV5/ncC
         pdosYpoWsFqljmKt9u2KPYM2dFGOyniti84h1W4rFMtIzftI4d9jAHNyoJ0qi6qUaqGM
         0jT9fF/a3kgcbjP6Ho4iLIiYuLwJ8QHRTiaK7Fc4bnMv4JerqKKpWgJFDRjIJBhHMaGm
         SZOYcnD9gQXkvY6Srb/3+mQMCUq44G7Y7q9iYY1nG5Qj2/hWj4nyis38a6tokg1orGGL
         0Wd6blNXOPHTGclX+zNbtcoOH5Zwu/sz7HkIJqtrCnFMg3KC/Am8vvY7r6LTnzIhmGfH
         W0MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793375111; x=1793979911;
        h=content-transfer-encoding:content-disposition:content-type
         :mime-version:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hLhpSxs/CI8L6fPpKCYlBQ7uDJcGOM1i7tYlKx8Tjmc=;
        b=IJDRui239nM07me5R/E3at9+5l5MglvGVnfASi8bsPXHyd1ZdYrsz/1aNy7ICZRHKf
         q9n2K+SrtDewsn5BDYX9ZX+9/0ScfRUH9LlzW79vbzDTZEQiQBirziANVTBGzC0zeQOe
         1W3B85nkzlfiTqvbk7zD9K/2fKtxjOaOLsaJ5GMrYc5EbrzGivhs0DVQT9u8AyosuXV7
         EsEtqzSxlKfGTtsqdsy1Xu7g0XE9hEa62ioc1GjWwTutQPuZTjrzQPRnoaW9PP5Wyxwl
         feGn4lBU/C4MwJ59of31aTzNKG5eaufnVLDSCPOk8b1Mnu1donGeGf15Tc01byXBfUe9
         2CIQ==
X-Gm-Message-State: AFq9FYK01FNmrkiPdD/JCE+bbncUue4nm3HlV3+3/gcTnuCsoxsaf1NL
	2iN1XY8LJP44dVAHnNjZeSsUd/4Pbv1O0KXY0mMKSjzx10M+fPqAuwoAjmC/1OKwyQ==
X-Gm-Gg: AYBFou1WKuc1SmC9UxbjcZtjPmFeqs/z/+wgsIZw+YYvi+R3M4Yi9PwxBnbxv9w+2kr
	2qOvAI35xtu8lpC4FE5gvGNHw7YE3BIAw0I8cdA19uZ3Sri1SbCXMYBdYoKqu0N/FLPjkS7lkZC
	BJoCUCSX9vy1Rw+cl/w+FWHUVfV+UJOfIMs8GSTObxCFi9sUCjXV2a34TehEjW4qgyvXSpMuOkz
	KbHBmOG7A+QgE/2QZXF1C47qs4Nw7WCR1nAuTVEbhxyRfrGndbuPzTedozjRx6Qrq1UJG41KcgQ
	0nYm1b8yBxHzUhUwCy2HJTXcpbhC8Wo31Jd/ofzgTUhBDjWY4jThShWmGQec9ZvDYd5M5XnNYkn
	9Uj+ZJRaFKU9hdS3T2YQiDftRxVrfk7v2FLn6RzQM6gwJGauQ9554drshsfrCsqevXUWnFOQrSe
	NWxMvkbKYE2/DsMg3OO2q4K/iBXi6ngzbxfUWnNOgxQhWxx60OuZD2U0PZM8pIb1IqL+t4Q2v6v
	RqYpUqRTdGA315jN/zpHttZCoFtx06i9fp3CLrqFQdT72Uf49TX2/qgmJOKU8J48syBC2uIN7eq
	U91g2eU1DUPwHGALrzHFbwAY7o8gOfzSEU+fNl5qmErxDjohAFkIS9/Dp3iW
X-Received: by 2002:a05:600c:64c9:b0:4a2:180a:3417 with SMTP id 5b1f17b1804b1-4ac14dd1debmr62418945e9.1.1793375110258;
        Fri, 30 Oct 2026 08:45:10 -0700 (PDT)
Received: from google.com ([2a00:79e0:288a:8:43c5:cfa4:de19:f8f0])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e71b77f06sm3901507f8f.21.2026.10.30.08.45.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 08:45:09 -0700 (PDT)
Date: Fri, 30 Oct 2026 16:45:04 +0100
From: =?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>
To: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
Cc: linux-security-module@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	Tingmao Wang <m@maowtm.org>, Justin Suess <utilityemal77@gmail.com>
Subject: landlock bug: procfs denials because inodes have unstable identity
Message-ID: <auS7gAFy13EOp_Zt@google.com>
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

Hello!

The Landlock LSM lets processes define policies which are attached to
struct inode objects internally.  As a consequence, if filesystems
forget these inodes and start using new inode objects for the same
files or directories later on, these policies do not work as intended
any more.

As it turns out, procfs has that property as well and can lose inode
identities over time, even though it does not happen immediately.

In my understanding, this is not intended.  Landlock has explicit
selftests to exercise that Landlock policies work in Procfs.

For reference, similar issues have been investigated also for hostfs
[1] and 9p [2]:

[1] https://lore.kernel.org/all/20230309165455.175131-2-mic@digikod.net/
[2] https://lore.kernel.org/all/cover.1756935780.git.m@maowtm.org/


Steps to reproduce
==================

Process A:

* Enter a Landlock domain where access to /proc/sys/kernel/random
  (and files below it) is allowed.
* Repeatedly open and close the boot_id file from that same directory

At the same time, the dentry caches get freed up.
We can emulate this by writing to /proc/sys/vm/drop_caches from
another (root) process:

# echo 2 > /proc/sys/vm/drop_caches

Observed result: Process A fails because of a Landlock refusal opening
  the boot_id file.  When Landlock walks the path for the check, the
  inodes have now a different identity than before and don't match, so
  Landlock denies the operation.

Expected result: Dropping the caches should not affect Landlock's
  behaviour.

At the bottom of this email, I am including the source code for a
program that does Process A -- you can run this to reproduce, and then
write into the drop_caches file from another process as root.


Solution...?
============

I don't have a fix for it yet.

I am open to suggestions.  Is this feasible to change in procfs?

—Günther



Reproducer program, for easier reproduction (don't forget to drop
caches in parallel):

---landlock_uuid.c
#define _GNU_SOURCE
#include <err.h>
#include <fcntl.h>
#include <linux/landlock.h>
#include <stddef.h>
#include <sys/prctl.h>
#include <sys/syscall.h>
#include <unistd.h>

static int landlock_create_ruleset(struct landlock_ruleset_attr *attr,
				   size_t size, __u32 flags)
{
	return syscall(__NR_landlock_create_ruleset, attr, size, flags);
}

static int landlock_add_rule(int ruleset_fd, enum landlock_rule_type rule_type,
			     void *rule_attr, __u32 flags)
{
	return syscall(__NR_landlock_add_rule, ruleset_fd, rule_type,
		       rule_attr, flags);
}

static int landlock_restrict_self(int ruleset_fd, __u32 flags)
{
	return syscall(__NR_landlock_restrict_self, ruleset_fd, flags);
}

int main(void)
{
	struct landlock_ruleset_attr ruleset_attr = {
		.handled_access_fs =
			LANDLOCK_ACCESS_FS_EXECUTE |
			LANDLOCK_ACCESS_FS_WRITE_FILE |
			LANDLOCK_ACCESS_FS_READ_FILE |
			LANDLOCK_ACCESS_FS_READ_DIR |
			LANDLOCK_ACCESS_FS_REMOVE_DIR |
			LANDLOCK_ACCESS_FS_REMOVE_FILE |
			LANDLOCK_ACCESS_FS_MAKE_CHAR |
			LANDLOCK_ACCESS_FS_MAKE_DIR |
			LANDLOCK_ACCESS_FS_MAKE_REG |
			LANDLOCK_ACCESS_FS_MAKE_SOCK |
			LANDLOCK_ACCESS_FS_MAKE_FIFO |
			LANDLOCK_ACCESS_FS_MAKE_BLOCK |
			LANDLOCK_ACCESS_FS_MAKE_SYM |
			LANDLOCK_ACCESS_FS_REFER |
			LANDLOCK_ACCESS_FS_TRUNCATE |
			LANDLOCK_ACCESS_FS_IOCTL_DEV |
			LANDLOCK_ACCESS_FS_RESOLVE_UNIX,
	};
	/*
	 * Backwards compatibility checks omitted for brevity.
	 * Assuming Linux 7.3 here. :)
	 */

	int ruleset_fd = landlock_create_ruleset(&ruleset_attr,
						 sizeof(ruleset_attr), 0);
	if (ruleset_fd < 0)
		err(1, "landlock_create_ruleset");

	int parent_fd = open("/proc/sys/kernel/random", O_PATH | O_CLOEXEC);
	if (parent_fd < 0)
		err(1, "open(/proc/sys/kernel/random)");

	struct landlock_path_beneath_attr path_beneath = {
		.allowed_access = LANDLOCK_ACCESS_FS_READ_FILE,
		.parent_fd = parent_fd,
	};
	if (landlock_add_rule(ruleset_fd, LANDLOCK_RULE_PATH_BENEATH,
			      &path_beneath, 0) < 0)
		err(1, "landlock_add_rule");

	close(parent_fd);

	if (prctl(PR_SET_NO_NEW_PRIVS, 1, 0, 0, 0) < 0)
		err(1, "prctl(PR_SET_NO_NEW_PRIVS)");

	if (landlock_restrict_self(ruleset_fd, 0) < 0)
		err(1, "landlock_restrict_self");

	close(ruleset_fd);

	/* Print out the boot_id file once a second. */
	for (;;) {
		int fd = open("/proc/sys/kernel/random/boot_id", O_RDONLY);
		if (fd < 0)
			err(1, "open(/proc/sys/kernel/random/boot_id)");

		char buf[64];
		ssize_t n;
		while ((n = read(fd, buf, sizeof(buf))) > 0) {
			if (write(STDOUT_FILENO, buf, n) < 0)
				err(1, "write");
		}
		if (n < 0)
			err(1, "read");

		close(fd);
		sleep(1);
	}

	return 0;
}
---
