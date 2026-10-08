Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8084F3A5452;
	Thu,  8 Oct 2026 02:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791426611; cv=none; b=FqlUM7cTOoldGfmQT34oEN1TDG4ACrlK44C9mGVe+1Q0HP36h2V/dWwOtt2Ai4OjqKOfmRpix4VgDF13bpaczTUuwzwQe+61j6AS8zyPVA3fHgp13MJ49tN9C02HoNlbViDVKjCD5Yi90oES5sIboJXynjAX5FIdXkuj9zsBf14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791426611; c=relaxed/simple;
	bh=I27rRhn58fI39cqw79T1wFeJaXzTECV2dnSjLIcGZIc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=hGYILX9WQ9ypvUj2YyZ5IqTbS8roIDzWAQ5FVuTfjE7MeoY1nj0h3+FLqDaGRg2Yni32g3C0OuqgGQBysTUS8eoKisaIxmaC2iEfs9X1fIBKsycYDxZ/7/SfPZv4bsH4BoyrEAMqlzDe1Z7pXU1MPvIArKnPaNv8tl5lf9Wj4vA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z/wQv5Uf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z/wQv5Uf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE3FC1F000FF;
	Thu,  8 Oct 2026 02:30:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791426608;
	bh=9k4ZBxh+JBZUg2t0YivBqanLOHiRzWKja7+psTdWYPU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=Z/wQv5Ufg4mYaKZShUpC82KKERMtj3z2cfgdba/MV/vepqZFFCmWVxBSCaV+rZNu3
	 Sl9RIgftwTRWXcoqYstPHL10srJNLrCzN7a2JlS5p0Q8x83sYZDsPuTZflc3pwJisO
	 T9bRY1GC9R6Yi4i0FCSESfgptP+VRVAnHFDBLIhIYR8m59wyHGnQQnKZOSw/U7FyO+
	 L/MYZ4js5IDj0djvxZSXKo+SgHh/mBesOZtQyMe06DQyEufwyWletSZhzCL3mN9AU8
	 JeqwJtlS6akkzlyhtDmAiztwXOGqjkB63cR9+X/rQnzFbW+osu0sve0Gzx7IGIHuRO
	 CVmminJVCPqIg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B46C53809A09;
	Thu,  8 Oct 2026 02:30:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] cipso: adjust cached option offsets when removing
 CIPSO
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179142660756.3776717.7354784609355599036.git-patchwork-notify@kernel.org>
Date: Thu, 08 Oct 2026 02:30:07 +0000
References: <20261006035108.3101440-1-4ncienth@gmail.com>
In-Reply-To: <20261006035108.3101440-1-4ncienth@gmail.com>
To: Daehyeon Ko <4ncienth@gmail.com>
Cc: paul@paul-moore.com, omosnacek@gmail.com, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 netdev@vger.kernel.org, linux-security-module@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue,  6 Oct 2026 12:51:08 +0900 you wrote:
> cipso_v4_skbuff_delattr() removes the CIPSO bytes but does not adjust
> cached offsets for options that follow them.
> 
> For example, with a valid 10-byte CIPSO option followed by a seven-byte
> RR option, parsing records rr at offset 30.  Removing CIPSO moves RR to
> offset 20, while the cached offset remains 30.  Consumers such as
> ip_forward_options() and __ip_options_echo() then access the wrong bytes;
> the latter may interpret packet data as the option length and copy it into
> fixed-size option storage.
> 
> [...]

Here is the summary with links:
  - [net,v2] cipso: adjust cached option offsets when removing CIPSO
    https://git.kernel.org/netdev/net/c/6d25ffca055a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


