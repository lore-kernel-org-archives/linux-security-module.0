Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793624406;
	b=JB5GZdiunZ9hvrse+zZfkVnltZugMsqijx1JiiB0jnjIivgrMON/UKjBXO0tuLK9+YoP
	 OR6zZkodt67yL1y2Zg8pudGcDxiUqgnAEUTxY1v2QN79OQgV841WYfvLGYxGt0rBaI9zR
	 gMSqyoJUUNEx5WeXqi5dL7hGURUT/LXNP7JFGBU7hR/GwO/FJAWDLOYcDe+J4XIBlp2KE
	 N1HVexGVdmlR/dZRWmqo3UCHWWE2Yu/Ce3YiaZqtzrsD27j+qiplpvnnEGrHKESYwuoy+
	 m0hRydFsrYGKNF34TBhAPfFy2ytzKQlFgVNxWUZ5bd7Wn0a+fG2h0poX54CsDNZ6jgQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793624406;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=frhE3W4qDnG3cVd/hHd/v/tb70IxCaC+5G9n7Npi2B0=;
	b=I4kyZdvqALue0jo7dO7pLW6F9A9qaV4VpISoe2BYwmz3IEglleXIcRnV8RPumShP9FYG
	 5Z15+MARgKldFwUmEfre1oVW5Y7+f0CRqbb3c/grZbHvje74soAkO5cagkJkNlZL/8xvG
	 mNBvMOFqREB/h3/GJy7HbEUy7kFvUFafoFmCK0HaBkCCa3yWby517WMkuQxCPL8rMQfRn
	 0a9qngg1hN+clo6QE9H5Mm0AYqvZAjY06wwZLA00HmnUchPLooFVSTIPu8i3zYV2n96sL
	 ZFC5wcMsO1r1Bx5TZz6GnMYiGKKyTGW4Lo4LxKBBruhTGyBeeMptOU6keDM8+LWKzDg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YMhM3rQN;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67475606A326;
	Mon,  2 Nov 2026 13:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YMhM3rQN
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1142B1F00A17;
	Mon,  2 Nov 2026 13:00:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793624406;
	bh=frhE3W4qDnG3cVd/hHd/v/tb70IxCaC+5G9n7Npi2B0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=YMhM3rQNhLJib3fwaHBjiYulk7/r2by2R19mDpQiPPiMTXW8M1EAcTX7DO8sYmYop
	 zX0NULhNQQjrYFsMcLHNnJk2Snw5Wklow5AuXkD2KPbZ5VF/baUtzSkPdvQ7usomox
	 wNSmjEBNFOnM/ffhfs14yQyGP4P6J5Mewr26vdYvFLxpmfJp53+ZZC5g5aDZbAJZd8
	 wHBn+x6zgxNmZpFQcgZ5ukW4266tFjbLhsmVN0Kf5zvV0AuXfjq6ZkiwP4LIGrF1td
	 ltb4f9+sYyziY2eQ1wksg431h8kwIv4f6yWLmyJEnK9G3//2dS3PBNOLjEORMiA+bB
	 REFs/rXNm2zTA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 02F9D380821F;
	Mon,  2 Nov 2026 13:00:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
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
Subject: Re: [PATCH net v4] cipso: fix optlen corruption in cipso_v4_delopt()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179362440455.4016458.9024394156701425815.git-patchwork-notify@kernel.org>
Date: Mon, 02 Nov 2026 13:00:04 +0000
References: <20261029033942.3644-1-q.h.hack.winter@gmail.com>
In-Reply-To: <20261029033942.3644-1-q.h.hack.winter@gmail.com>
To: Qihang <q.h.hack.winter@gmail.com>
Cc: netdev@vger.kernel.org, paul@paul-moore.com,
 linux-security-module@vger.kernel.org, omniameasunt@proton.me

Hello:

This patch was applied to netdev/net.git (main)
by Dave Miller <davem@davem-thinkpadp1gen8.ibmlond.csb>:

On Thu, 29 Oct 2026 11:39:42 +0800 you wrote:
> cipso_v4_delopt() recomputes the option length by walking the option
> buffer after the CIPSO option has been moved out.  The walk then reads
> the stale bytes at the tail of the buffer as option data, and a crafted
> setsockopt(IP_OPTIONS) buffer can make it treat one of them as an option
> length, increasing opt->opt.optlen beyond the valid option data.
> 
> The corrupted length stays on the socket and is later used as the copy
> length by getsockopt(IP_OPTIONS) and by the udp/raw/ping sendmsg paths,
> where it exceeds the size of the buffers they copy into.
> 
> [...]

Here is the summary with links:
  - [net,v4] cipso: fix optlen corruption in cipso_v4_delopt()
    https://git.kernel.org/netdev/net/c/1f1f8e8c5176

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


