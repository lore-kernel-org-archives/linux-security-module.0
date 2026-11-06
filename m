Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794008600;
	b=unCbKx895kQH3ZZpjIKHwqaQ26O0QEV/tn6GiMDichQAnV/D7HNfSAfHonieWDdnBmQW
	 5EwTYBbZTxyJhXkQErjCt8/b7mUn5WPFvoYNhWu/U1FAYAu6Yw8KZmhyWb5nrABkZLeuJ
	 +8YaLMSxHPRsmZlfeY5auVVDleMPB+VpZ6REKcvThQkVdsxjsvTsvv8Frv6E6eAEiniGv
	 KQwd1Bu72xDaAZ+YjCR6PrbitdoKKfWpk4p5T2JXKd9/fcdzxOCoW5ZBsOhuRCCynPGep
	 wDUaqaKQC4fyC1R0lyajkhOKLb6vAmpKWhhOBXiHMihI7wmpETM27UiaIwfQZ1skMtw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794008600;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=yRwbTzc+4Y4nBQrHleaku/vP6Zwjg6n1YmCmiprmN7s=;
	b=EONJJSSM+LRlshHP20hNO8yzkmjlnpt/EKVJi4YizPTTABZR+xDgh8t33DWVVrAiGzL/
	 5YHlegahFg+Njdg1/aO49NqT3YJXr+8n5bB3A+8+h5HkJ1/39/oGtbRebYau/csMhjT8J
	 scsTUX9hT5vduc0eJ4xazP2yYM+M8NT4kNSbh0VFDyqHnkjORAYaGu9RsUBSrPKy0T4ry
	 NumMUz35TimJ7acQWIbxMTkgavmDfyoW6/hU/gMStz97gJ7BbeFw/nxQQnWQugE7RML0M
	 7HnuzqBthBk9cujcuhwi/10al6REVyJx3VBGBfudtFX1dssWmFezF7XOZgs0inJJ87g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HttAHTo1;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09694606A326;
	Fri,  6 Nov 2026 23:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HttAHTo1
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 310CF1F0089F;
	Fri,  6 Nov 2026 23:43:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794008599;
	bh=yRwbTzc+4Y4nBQrHleaku/vP6Zwjg6n1YmCmiprmN7s=;
	h=From:To:Cc:Subject:Date;
	b=HttAHTo1Krfn+EPfX8TGj5Hd/bq71p9tNL+7aVVxz8wOhH3qRVJ7uyxqOkWsOAV4d
	 872ycw1NDAgM81yNWTsRWUceHRskn52JZlgA/4oDWXxKFgzK/JrHaYJ1CV0R0E6Pom
	 wZbooZA2ryFGyqq3G0nd11yOGtppV2UA2KOAnFBtU8A/jOMvPxEiVBeQEIQ7iYnR6H
	 +1uCchxZaIzwJVudjKY9TE+zzTLSnOAu+XtgPR5Ryg8Sa3zwY7MezccDqlfVx0fEhR
	 esY4if3VOc+avKpd0/8s5k7MWJ5yQKeO+ISBo6cXDV8dwRzx8lr2NDRXn/FrK4hf8Q
	 B/47I+TjTRRTw==
From: Eric Dumazet <edumazet@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Eric Dumazet <edumazet@kernel.org>,
	Simon Horman <horms@kernel.org>,
	David Ahern <dsahern@kernel.org>,
	Ido Schimmel <idosch@nvidia.com>,
	Paul Moore <paul@paul-moore.com>,
	linux-security-module@vger.kernel.org,
	Kyle Zeng <kylebot@openai.com>,
	netdev@vger.kernel.org
Subject: [PATCH net 0/2] ipv4: unclone skbs before recompiling IP options
Date: Sat,  7 Nov 2026 00:43:11 +0100
Message-ID: <20261106234313.2537882-1-edumazet@kernel.org>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

__ip_options_compile() updates Record Route and Timestamp options in
place. Two callers recompile options on an skb that can be a clone
sharing its data with other skbs, and thus write into shared packet
data:

 - ipv4_send_dest_unreach(), called from ipv4_link_failure()
 - cipso_v4_error(), called from the LSM socket receive hooks

If clones are processed concurrently, an option pointer can change
after it has been checked, corrupting the next option's length, which
__ip_options_echo() then trusts when building the ICMP reply.

Both patches unclone the skb before recompiling the options, as
ip_rcv_options() already does. The two patches are independent.

The issues were reported by Kyle Zeng and found by an AI code review
agent. They were not reproduced, and the fixes were only build-tested.

Eric Dumazet (2):
  ipv4: unshare headers before recompiling IP options in
    ipv4_send_dest_unreach()
  cipso: unshare headers before recompiling IP options in
    cipso_v4_error()

 net/ipv4/cipso_ipv4.c | 3 +++
 net/ipv4/route.c      | 3 ++-
 2 files changed, 5 insertions(+), 1 deletion(-)


base-commit: 30c71476d842b094651bd7712f6c8ee8716147d0
-- 
2.53.0

