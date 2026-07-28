Received: from smtp-42ae.mail.infomaniak.ch (smtp-42ae.mail.infomaniak.ch [84.16.66.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 349513AEB40
	for <linux-security-module@vger.kernel.org>; Tue, 28 Jul 2026 11:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.16.66.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785236593; cv=none; b=AOcWy/Zhs9RwDaJk4jlvoETQJGJvBp7CkozeZMLiORA3LfqA/RJ67qrCf2xckTKHPqeO1XHj4KFuGtNKX2TsbYiw07nuVcFHyNiMcvs2IhK3Rbv8LPt5Fc/qgjVObycbFUK9vWYLRBvfA0r3vmDOZnokHJNi7ClsjDo3E0J4N64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785236593; c=relaxed/simple;
	bh=VKaWqklAbWhXNpRX7/mIUhrGKRCxjx1FcoXTh+JQCTA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dM4+kvJp6yTSNxjVkuGknMvU3MUEZgV4U4uyORwuuVAUZ9oU59LHsz7nPUoULeb/UvxWStdyNQIxP7Jq+CDW4CS/LOHb2y8t9ef8plhpNj+ABVwlkdoSNnrWqgjeWeiMqG9x4YIAhnonwrvlMFlX6L9gkeLva49dzbpmvbUqOdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=nedNowlX; arc=none smtp.client-ip=84.16.66.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="nedNowlX"
Received: from smtp-4-0001.mail.infomaniak.ch (smtp-4-0001.mail.infomaniak.ch [10.7.10.108])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4h8Xcg598kzD2N;
	Tue, 28 Jul 2026 13:02:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1785236579;
	bh=0k6vCwS6Nq1mOjqVRjq8Jo8jywrf/uj+ox1pBO72g4M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nedNowlXJBEehf/rxB/GGwW6cUFanrenGshpr5tdp0zWco7ua1l7XwF75K/hVFB8i
	 qgvNwXXrBq/MjQKyXIFoNfgY5l8nRMWruhfpdNfTkd04dGato77XdiUpPAeOuqfX+E
	 Xukydta9X+S2JROGm0Zp9vPw6w/HSj4VoSFu5e3I=
Received: from unknown by smtp-4-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4h8Xcf3wdjzvXH;
	Tue, 28 Jul 2026 13:02:58 +0200 (CEST)
Date: Tue, 28 Jul 2026 13:02:57 +0200
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Oxana Kharitonova <oxana@cloudflare.com>
Cc: gnoack@google.com, paul@paul-moore.com, serge@hallyn.com, 
	wangyan01@kylinos.cn, linux-security-module@vger.kernel.org, 
	linux-kernel@vger.kernel.org, landlock@lists.linux.dev, webprosto@gmail.com, 
	kernel-team@cloudflare.com, Christian Brauner <brauner@kernel.org>, 
	Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH 0/6] landlock: Add POSIX message queue scoping
Message-ID: <20260728.Heephie1tai3@digikod.net>
References: <20260722122952.42149-1-oxana@cloudflare.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260722122952.42149-1-oxana@cloudflare.com>
X-Infomaniak-Routing: alpha

Hi Oxana,

Thanks for this patch series.  Overall it looks good but you'll find
some feedback to improve and send a v2, following Günther's and Justin's
ones.

You should also Cc Christian and Al and ask for a review of the
mqueue-specific patches (e.g. patch 1) for v2.

You'll find AI reviews here:
https://sashiko.dev/#/patchset/20260722122952.42149-1-oxana%40cloudflare.com

A test should create a domain that denies LANDLOCK_ACCESS_FS_READ_FILE
and make sure the msgqueue scoping control stays the same.

The question about unlinking mqueue is a bit tricky.  I don't think this
should be restricted by an mqueue scope because that would mean that a
sandboxed process creating an mqueue would not be able to remove the
next time the same sandboxed program tries to clean up its files.  So,
we should check if such file are automatically removed if its creator
exits.  In any case, this should at least be documented in the user
documentation.

The user doc should explain this new scope (see previous scope addition
for examples).

tools/testing/selftests/landlock/config must be updated with
CONFIG_POSIX_MQUEUE=y

Other questions/comments should either be answered to explain why they
don't make sense or otherwise be implemented with v2.


On Wed, Jul 22, 2026 at 01:29:36PM +0100, Oxana Kharitonova wrote:
> Hi,
> 
> This series adds landlock support for scoping POSIX message queuesi [1].

Nit: Landlock (in all docs, comments, and messages).

>  
> Landlock already supports scoped IPC restrictions for signals and abstract
> UNIX sockets. These restrictions make it possible to prevent a sandboxed
> task from interacting with IPC objects outside of its Landlock domain,
> while still allowing communication within the same domain or with nested
> domains.
>  
> This series extends the same model to POSIX message queues with a new
> LANDLOCK_SCOPE_POSIX_MSG_QUEUE scope. When this scope is enforced, a task
> can only open POSIX message queues that were created by a task in the same
> landlock domain or in a nested domain.
>  
> The implementation tags mqueuefs inodes at creation time with the creator's
> landlock domain. This domain is kept alive for the lifetime of the inode
> and is checked when the queue is opened.
>  
> The series also exposes the mqueuefs magic number through the shared UAPI
> magic header, bumps the Landlock ABI, updates documentation, adds sandboxer
> support, and adds selftests.
>  
> The new behavior is:
>  
> - a task restricted with LANDLOCK_SCOPE_POSIX_MSG_QUEUE cannot open a queue
>   created outside of its Landlock scope;
> - a task can still open a queue created within its own Landlock domain;
> - queues created outside of any Landlock domain are treated as outside the
>   scope for a scoped opener.
> 
> [1] https://man7.org/linux/man-pages/man7/mq_overview.7.html
> 
> Oxana Kharitonova (6):
>   ipc: Move mqueue fs magic to uapi magic header
>   landlock: Scope POSIX message queue opens
>   landlock: Bump ABI for LANDLOCK_SCOPE_POSIX_MSG_QUEUE
>   selftests/landlock: Test POSIX message queue scoping
>   samples/landlock: Support POSIX message queue scoping
>   landlock: Document POSIX message queue scoping
> 
>  Documentation/admin-guide/LSM/landlock.rst    |   6 +-
>  Documentation/userspace-api/landlock.rst      |  11 +-
>  include/uapi/linux/landlock.h                 |   7 +-
>  include/uapi/linux/magic.h                    |   2 +
>  ipc/mqueue.c                                  |   2 +-
>  samples/landlock/sandboxer.c                  |  16 +-
>  security/landlock/audit.c                     |   9 +
>  security/landlock/audit.h                     |   1 +
>  security/landlock/fs.c                        |  35 +++
>  security/landlock/fs.h                        |  15 ++
>  security/landlock/limits.h                    |   2 +-
>  security/landlock/ruleset.c                   |   1 -
>  security/landlock/syscalls.c                  |   2 +-
>  security/landlock/task.c                      |  43 ++++
>  security/landlock/task.h                      |   4 +
>  tools/testing/selftests/landlock/base_test.c  |   2 +-
>  .../landlock/scoped_posix_msg_queue_test.c    | 223 ++++++++++++++++++
>  .../testing/selftests/landlock/scoped_test.c  |   2 +-
>  18 files changed, 371 insertions(+), 12 deletions(-)
>  create mode 100644 tools/testing/selftests/landlock/scoped_posix_msg_queue_test.c
> 
> -- 
> 2.50.1 (Apple Git-155)
> 
> 
