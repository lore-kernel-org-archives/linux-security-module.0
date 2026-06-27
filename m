Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D35A292B4B
	for <linux-security-module@vger.kernel.org>; Sat, 27 Jun 2026 05:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782538147; cv=none; b=kJ/3G3kcyEjKj5NZ9yzHxKUJ68fJ9jq0z5V/ET7YC7xj2+cztNtjvQmQCcip7IUuiongMw+S6EUyLRRmZQKUW0Scrl4eFZWI+MybspamdKWoyL8jXfWk4xsClfL1Jlz5ecbrXld3jUMmN+k708yEBIB1sLTiHQ8NokFW93O0MrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782538147; c=relaxed/simple;
	bh=D5s3R3niZVIUOGDu7mziXizVg0cziH2fG1zX+NAS5Vk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oPbzwlqzwLEwMfBRKBhfFJ0UcH7oSkrkgwRDcnFxMb0b7lvG8CXIoOhTjJ8ARfKeuSAZo5Lz/AWJuswli/BjzQgPvfxPzJYfECngIHR9MrEES0x7F/Hh3ksg479S/IypxwdEs7iKtnE7s6C6zWahl66bvT8Sa4wA5ak4BA2xQFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from www262.sakura.ne.jp (localhost [127.0.0.1])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 65R5SwGv004925;
	Sat, 27 Jun 2026 14:28:58 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from [192.168.1.6] (M106072072000.v4.enabler.ne.jp [106.72.72.0])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 65R5Svq0004920
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Sat, 27 Jun 2026 14:28:57 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <2951101e-d503-4a48-91b8-d6f041f0b1b6@I-love.SAKURA.ne.jp>
Date: Sat, 27 Jun 2026 14:28:57 +0900
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tomoyo: Enforce connect policy in TCP Fast Open
To: Matthieu Buffet <matthieu@buffet.re>
Cc: Bryam Vargas <hexlabsecurity@proton.me>,
        =?UTF-8?B?TWlja2HDq2wgU2FsYcO8?=
 =?UTF-8?Q?n?= <mic@digikod.net>,
        =?UTF-8?Q?G=C3=BCnther_Noack?=
 <gnoack@google.com>,
        linux-security-module@vger.kernel.org,
        Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>,
        Paul Moore <paul@paul-moore.com>, Yuchung Cheng <ycheng@google.com>,
        Eric Dumazet <edumazet@google.com>, netdev@vger.kernel.org,
        Kentaro Takeda <takedakn@nttdata.co.jp>
References: <20260619002207.61104-1-matthieu@buffet.re>
Content-Language: en-US
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <20260619002207.61104-1-matthieu@buffet.re>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Anti-Virus-Server: fsav301.rs.sakura.ne.jp
X-Virus-Status: clean

On 2026/06/19 9:22, Matthieu Buffet wrote:
> Tomoyo restricted TCP connections in 2011 in commit
> 059d84dbb389 ("TOMOYO: Add socket operation restriction support.")
> using the socket_connect() LSM hook.
> 
> However, the MSG_FASTOPEN sendmsg() flag was added in 2012 to allow
> combining connect() and the first sendmsg(). Tomoyo was not updated to
> take this into account in its send hook.
> 
> This resulted in a TCP connect policy bypass similar to that reported in
> Landlock in 2024 (see Link below), with the difference that Tomoyo was
> fine when originally merged, and the problem got introduced when adding
> fastopen support, possibly due to lack of synchronization between lsm
> and netdev worlds.
> 
> Add MSG_FASTOPEN handling in Tomoyo's existing send hook.
> 
> Link: https://github.com/landlock-lsm/linux/issues/41
> Link: https://lore.kernel.org/all/20260616201615.275032-1-hexlabsecurity@proton.me/
> Fixes: cf60af03ca4e ("net-tcp: Fast Open client - sendmsg(MSG_FASTOPEN)")
> Cc: stable@kernel.org
> Signed-off-by: Matthieu Buffet <matthieu@buffet.re>
> ---
>  security/tomoyo/network.c | 16 +++++++++++++++-
>  1 file changed, 15 insertions(+), 1 deletion(-)
> 

Thank you for finding this problem and making a patch.
I updated your patch like below in order to exclude kernel threads from this check.
If we are OK to go with modifying individual LSM, I'll apply this change.

 security/tomoyo/network.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/security/tomoyo/network.c b/security/tomoyo/network.c
index cfc2a019de1e..50d27c773b10 100644
--- a/security/tomoyo/network.c
+++ b/security/tomoyo/network.c
@@ -765,6 +765,15 @@ int tomoyo_socket_sendmsg_permission(struct socket *sock, struct msghdr *msg,
 	const u8 family = tomoyo_sock_family(sock->sk);
 	const unsigned int type = sock->type;
 
+	if ((msg->msg_flags & MSG_FASTOPEN) && msg->msg_name && type == SOCK_STREAM &&
+	    (family == PF_INET || family == PF_INET6) &&
+	    (sock->sk->sk_protocol == IPPROTO_TCP || sock->sk->sk_protocol == IPPROTO_MPTCP)) {
+		address.protocol = SOCK_STREAM;
+		address.operation = TOMOYO_NETWORK_CONNECT;
+		return tomoyo_check_inet_address((struct sockaddr *)msg->msg_name,
+						 msg->msg_namelen, 0, &address);
+	}
+
 	if (!msg->msg_name || !family ||
 	    (type != SOCK_DGRAM && type != SOCK_RAW))
 		return 0;
-- 
2.54.0


