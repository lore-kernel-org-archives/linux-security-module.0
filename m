Received: from smtp-relay-canonical-1.canonical.com (smtp-relay-canonical-1.canonical.com [185.125.188.121])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E05561CFBE;
	Thu, 25 Jul 2024 18:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.121
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721931307; cv=none; b=IL9Ye3RPAEXbRF5FFgG9zIRd4iluPWt0x8aGXoYa/+9Gl3bFjHjUMbvnnBPo9yn6rFc7zGwgYDac/C0+jmpDi5DjY88Jg/toTgFWwdVuU2fLbyEQv/KU21PiJEXcIffDVd83qCM2Q7bhdW/ECrhvzNwYtmoAuCOF5KxGcyKqQds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721931307; c=relaxed/simple;
	bh=f9oPIuuZfcma+zZ7cmW+c4KNs72hYlD1U0n1FbGpWQk=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:Content-Type; b=J8FRLeXnwVfwN+Ynk9yUSul+hWc0C6vAhZIKABLqmRjJNXQgP8Ega1lLkexlku5CylnEMDsgH/7qvHyGKqAlzkpxL1qoqkLA48GOF5rVdU7dKoDUuR3uilvPNDKh5m6zspaUNfmXrj2B0U0yNCnMIQ/vX/3esOvAlHKQ039Qz+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=aU6ZdjmL; arc=none smtp.client-ip=185.125.188.121
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="aU6ZdjmL"
Received: from [192.168.192.84] (unknown [50.39.103.33])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id 051F93F22D;
	Thu, 25 Jul 2024 18:06:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1721930791;
	bh=kjl8LMrfWr6rVujED62zhlYN6A3G3U9WrClP7RazZas=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:Content-Type;
	b=aU6ZdjmLY1xlMQP7IAuRuZSXPB8gEpXmlsVL7xhv+xhWP8eeo0o51eFD97kqCtlo2
	 XZbvUTbSBwRTxZXADHrX4qIlXbrwxBmqpFj3wgKi2HPk6xSHbJSLhjqEu3ybV850oF
	 Dzm3vy7853NEb2SR50RJuRUTaRvCbhBJsVbMO1N09ztcoHJAglPGv3ZKO8cHhhzKkZ
	 jpWxUYmATij1I43tqb/3uJHRiHweyH7T5KYUmLBU6x2slmU10Wx9qLp1y9tv1B2BXA
	 OMz8d8POusroUChpSgZcC14G4o9Fr1DxiIxG/z+b8BvYcblZ6+YNkLkScFCn0dP0me
	 k/C4VJzSfKFuw==
Message-ID: <d6585289-6146-4a10-bbdc-7bdfa5b16ffb@canonical.com>
Date: Thu, 25 Jul 2024 11:06:28 -0700
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: John Johansen <john.johansen@canonical.com>
Subject: [GIT PULL] AppArmor updates for 6.11-rc1
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: LKLM <linux-kernel@vger.kernel.org>,
 "open list:SECURITY SUBSYSTEM" <linux-security-module@vger.kernel.org>
Content-Language: en-US
Autocrypt: addr=john.johansen@canonical.com; keydata=
 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 lT9Q
Organization: Canonical
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Linus,

I know this is running extremely late so I have only included bug fixes
and a few small cleanups.

In particular the cleanup
   optimization: try to avoid refing the label in apparmor_file_open
is nice to have for scaling on large systems, as it avoids take a ref count when
it isn't necessary. For the file open test resulting in

   kernel test robot noticed a 93.1% improvement of will-it-scale.per_process_ops on:


These patches have all been merge tested against your tree as of
this morning and regression tested against your tree as of yesterday.

thanks
- john




The following changes since commit 4cece764965020c22cff7665b18a012006359095:

   Linux 6.9-rc1 (2024-03-24 14:10:05 -0700)

are available in the Git repository at:

   git://git.kernel.org/pub/scm/linux/kernel/git/jj/linux-apparmor tags/apparmor-pr-2024-07-25

for you to fetch changes up to e0ff0cff1f6cdce0aa596aac04129893201c4162:

   apparmor: unpack transition table if dfa is not present (2024-07-24 11:15:06 -0700)

----------------------------------------------------------------
apparmor-pr-2024-07-24 PR 2024-07-25

+ Cleanups
       - optimization: try to avoid refing the label in apparmor_file_open
       - remove useless static inline function is_deleted
       - use kvfree_sensitive to free data->data
       - fix typo in kernel doc

+ Bug fixes
       - unpack transition table if dfa is not present
       - test: add MODULE_DESCRIPTION()
       - take nosymfollow flag into account
       - fix possible NULL pointer dereference
       - fix null pointer deref when receiving skb during sock creation

----------------------------------------------------------------
Alexander Mikhalitsyn (1):
       apparmor: take nosymfollow flag into account

Christian Göttsche (1):
       apparmor: fix typo in kernel doc

Colin Ian King (1):
       apparmor: remove useless static inline function is_deleted

Fedor Pchelkin (1):
       apparmor: use kvfree_sensitive to free data->data

Georgia Garcia (1):
       apparmor: unpack transition table if dfa is not present

Jeff Johnson (1):
       apparmor: test: add MODULE_DESCRIPTION()

Leesoo Ahn (1):
       apparmor: fix possible NULL pointer dereference

Mateusz Guzik (1):
       apparmor: try to avoid refing the label in apparmor_file_open

Xiao Liang (1):
       apparmor: Fix null pointer deref when receiving skb during sock creation

  security/apparmor/apparmorfs.c         |  4 ++++
  security/apparmor/file.c               | 13 ----------
  security/apparmor/include/cred.h       | 20 ++++++++++++++++
  security/apparmor/lsm.c                | 14 ++++++++---
  security/apparmor/mount.c              |  2 ++
  security/apparmor/policy.c             |  2 +-
  security/apparmor/policy_unpack.c      | 43 ++++++++++++++++++++--------------
  security/apparmor/policy_unpack_test.c |  1 +
  8 files changed, 65 insertions(+), 34 deletions(-)

