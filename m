Received: from beta.bencteux.fr (114.ip-51-178-41.eu [51.178.41.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 309E636AB5B
	for <linux-security-module@vger.kernel.org>; Sun, 12 Apr 2026 10:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.178.41.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775988520; cv=none; b=ABx1U1kdlcDwImEAwo4TCvgyJ6VN+NY+NVZi9QcNERoq89QeraZYyZHuxkGxkRJCXB5LyOkbmqZxiyF3UTe9ISb3/nzX9xP+PZeTYKXWqExK0hrl/LmYYgMzJ2yD7f8+TinFWJyncScnx3mfqB3Qe+NJ5UO/8/VSsvjfJsEUrRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775988520; c=relaxed/simple;
	bh=+9ax2ryJL3v3T2vvn1KL7o6LwTOfvz4HprD3glESk2A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gDkVya0PeVHXcvdQI+xH0HmU/4q+qJVnZR5J4hwY5g2hQ23dlajIgAFJlc7w6jhQPEbXODDDUGkmvc7qEHe1+oLCOmdZW/f6YR5UBuldrBC33SQyL8+PoW+ddlNTYLueNIjPurU56M0joszxUhn+ufoQN68WE/42v6Pi0HdH5+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bencteux.fr; spf=pass smtp.mailfrom=bencteux.fr; dkim=pass (1024-bit key) header.d=bencteux.fr header.i=@bencteux.fr header.b=0WOIE57H; arc=none smtp.client-ip=51.178.41.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bencteux.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bencteux.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bencteux.fr header.i=@bencteux.fr header.b="0WOIE57H"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=bencteux.fr; s=mail;
	t=1775988106; bh=+9ax2ryJL3v3T2vvn1KL7o6LwTOfvz4HprD3glESk2A=;
	h=From:To:Cc:Subject:Date:From;
	b=0WOIE57HXmkSr92mugQbYEV3+IUZvRPUsmsBJfAqjg+GcN/S5KwIKF1HMrqyEET0b
	 YXbEdUR/fXh3mN3Luu+UMfGRprhpxVwh6G3VfpFzkCae3NNB5io5f2vhElC0Mjzr5q
	 0FsBVhz2bejlJGUjx1Qv41bRI3lHvvkUDZ74SYEw=
Received: from localhost (lfbn-idf3-1-911-123.w90-3.abo.wanadoo.fr [90.3.226.123])
	by beta.bencteux.fr (Postfix) with ESMTPSA id AB01C40324;
	Sun, 12 Apr 2026 12:01:46 +0200 (CEST)
From: Jeffrey Bencteux <jeff@bencteux.fr>
To: mic@digikod.net,
	gnoack@google.com,
	paul@paul-moore.com,
	jmorris@namei.org,
	serge@hallyn.com
Cc: linux-security-module@vger.kernel.org,
	jeff@bencteux.fr
Subject: landlock: Add support for chmod and chown system calls families
Date: Sun, 12 Apr 2026 11:50:39 +0200
Message-ID: <20260412095233.34306-1-jeff@bencteux.fr>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

This patch serie add support for chmod and chown system calls families
in Landlock.

These system calls could be used when exploiting applications. Two new
flags are added for struct landlock_ruleset_attr:

* LANDLOCK_ACCESS_FS_CHMOD
* LANDLOCK_ACCESS_FS_CHOWN

Restriction is limited to files as the security.c hooks for both
system calls seem to only applies to files. More digging is needed
before being able to restrict calls to chmod and chown on directories.

It adds basic tests for both family operations, one for when it is
allowed, one for when it is not.

First patch also fixes a bug I encountered when writing the tests.

