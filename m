Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5F18175BF
	for <linux-security-module@vger.kernel.org>; Thu, 27 Mar 2025 13:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743081523; cv=none; b=XiKat7m6ow9tqz3oYuTz0DVWOpBXTAZSdwPpTjq/a8VozF2nxs2luSNFfzoVMNdXLRVOBrJCsVGr/8TPV9/G+Ftv5nk7rCIWPcONv2fzifTn7ldtV/PfJGpiraXnhAcQ8x8qOWzP8/pJo+cNX+sOULH/xxuoYM2I/MAv/pSQhmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743081523; c=relaxed/simple;
	bh=doZ1WB1pIE0B3uLKLNfehG9hwJG/S4B8u/9WZV64lx0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j2FFbipJoHTaPa+8C4aoEhSDGB8Bozf/Rm2ZRqlcQazEAx0xDIL8KT+jj9RS3U/599Nu3Kj/agLEOBIG9tHknJj3Bhxav1ruOorVYh00oYMA0knd8s9+lKf+N2p3+xE0iTk7rIrOLCr7LLZ2SdiGorjoSpWCKBvQk1NAXsQ7Zk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id E1DC32116C;
	Thu, 27 Mar 2025 13:18:39 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A8AEB1376E;
	Thu, 27 Mar 2025 13:18:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id NtiAJy9Q5We7SwAAD6G6ig
	(envelope-from <pvorel@suse.cz>); Thu, 27 Mar 2025 13:18:39 +0000
Date: Thu, 27 Mar 2025 14:18:38 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.de>
Cc: ltp@lists.linux.it, linux-security-module@vger.kernel.org,
	=?iso-8859-2?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>,
	=?iso-8859-2?Q?G=FCnther?= Noack <gnoack@google.com>
Subject: Re: [LTP] [PATCH 0/4] Landlock tests for ABI v6
Message-ID: <20250327131838.GB77751@pevik>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <20250327-landlock_unix_socket-v1-0-584653f66d9c@suse.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250327-landlock_unix_socket-v1-0-584653f66d9c@suse.com>
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Spam-Level: 
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Spam-Score: -4.00
X-Spam-Flag: NO
X-Rspamd-Queue-Id: E1DC32116C
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org

Hi all,

FYI new batch of Andrea's work on landlock test coverage in LTP.
Feel free to have a look.

https://patchwork.ozlabs.org/project/ltp/list/?series=450223&archive=both
https://lore.kernel.org/ltp/20250327-landlock_unix_socket-v1-0-584653f66d9c@suse.com/T/#t

Kind regards,
Petr

> Landlock released a new feature for IPC scoping in the new ABI.
> This includes the following new rules which will be tested in
> this patch-set:

> - LANDLOCK_SCOPE_ABSTRACT_UNIX_SOCKET
> - LANDLOCK_SCOPE_SIGNAL

> https://docs.kernel.org/userspace-api/landlock.html#ipc-scoping

> Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
> ---
> Andrea Cervesato (4):
>       Add landlock ABI v6 fallback
>       landlock02: support landlock ABI v6
>       landlock: add landlock09 test
>       landlock: add landlock10 test

>  include/lapi/landlock.h                            |  23 +++-
>  testcases/kernel/syscalls/landlock/.gitignore      |   2 +
>  testcases/kernel/syscalls/landlock/landlock02.c    |  10 +-
>  testcases/kernel/syscalls/landlock/landlock09.c    | 132 +++++++++++++++++++++
>  testcases/kernel/syscalls/landlock/landlock10.c    | 110 +++++++++++++++++
>  .../kernel/syscalls/landlock/landlock_common.h     |  11 ++
>  6 files changed, 280 insertions(+), 8 deletions(-)
