Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795771802;
	b=zuGBx9vvCB9j8w70Y9qJMDFOr+F2rjWfAknjntOZf185Z6J1BgOaSraz9E3GvKyWEUKR
	 Ei/x44/3gRakNSs1Hvk0cvVNzkWOmA8XE1gIC0KykBKXhuT9sqXS36JSt7N3ihuQ1j+bS
	 IJOVY2wzrrUFjWQmt79xQaZNWr38/9ORFirTACwab9+EIpWIp5XcRL1pCfk+FMAl7ijUz
	 jAkYmXpks8spe4kpX7UtnCqnKuxAuEveqPId3PXQfTqzZmxbTwCWa2o7/jGb6Wl1JkO9P
	 Cz5UlTkM6xT21VQ79n6yKfsC/awRUTx3O+x1ShpqZ6PNN3WXn/LONGoN/P1S5W3y17g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795771802;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Auto-Submitted:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=oj2zs7YpNjut+Fle9NDI2/nVbuq1xcuWOh/20pAlrQ0=;
	b=gvgzPw8D8k+kkg7rWfbysHZfPCRmpyNjqT+ls5yJwDLPucAWrZJbo5YxbxD1N0U/XWfP
	 SQSV2naV7ngGy1904TXhYLsQoMwXgHk3+0OMdBrVCfGJ9MmFP01QY6o0Faxi8jHJPqyQI
	 K7ZY1yWpso5un7KBz8bLOu+iULkbCM6pui8KFQoCzIw8uzMqf0CZg3n4ga6i1BrpKo0JH
	 5mMH+80swSfyyPCiAQIn7jtlf6grvx18puz3qZsRLuueHF2BadZwGbskRoY1BuCOwW9q/
	 pP2YQ9DqqLZ3xomgPjMdnoJUUwqQZbAm+R+9cnxaZlcRGfQ7EAw5wNYdon/FiuJOlfg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OQxtStAT;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A286D606A323;
	Fri, 27 Nov 2026 09:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OQxtStAT
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C5321F0089C;
	Fri, 27 Nov 2026 09:30:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795771802;
	bh=oj2zs7YpNjut+Fle9NDI2/nVbuq1xcuWOh/20pAlrQ0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=OQxtStAT4Tan2k3a5Y/wXcqjjer5povqz7NT4oMrd/LVYTWxo2GDFLQq0qKFVpv7X
	 ZQkrqKGdPDR7VZzOfsPgOIuFwpfcj+jeHm0zdYvrd92z947cQkzvxiI+P8kLSyXBxZ
	 c7Ef6Hcei7uWp7xVN69IbafKrLXwHBLAxJHm/5ADpboPmCA9XwV9AhTiNjEt/25p1s
	 zwgrA8sexhqJTRwJZRcjSCLTo0T33TI0y+y81NipB6+FpeZPKFY5m3u/noW5WuaQGs
	 Kwld15lEt5Vs/uIYPYOA7PIlLyITpWleC7I4k7n6F3lW1XoFuA02QT9lKHaBbFUeau
	 28MsVugJZSVMw==
From: netdev-bot+sinfo@kernel.org
To: Linkui Xiao <xiaolinkui@126.com>
Cc: Paul Moore <paul@paul-moore.com>, netdev@vger.kernel.org,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, James Morris <jmorris@namei.org>,
 linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
 Linkui Xiao <xiaolinkui@kylinos.cn>
Subject: 
 Re: [PATCH net] netlabel: fix a race in netlbl_unlhsh_condremove_iface()
Date: Fri, 27 Nov 2026 09:30:00 +0000
Message-ID: <179577180092.3294.8221608635673838533@kernel.org>
In-Reply-To: <20261127092325.3563681-1-xiaolinkui@126.com>
References: <20261127092325.3563681-1-xiaolinkui@126.com>
Auto-Submitted: auto-generated
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Hi!

This is an automated message. This series looks like a fix, but its
commit messages seem to be missing some information:

 - How the issue was discovered, e.g. hit in production, hit during
   development, syzbot report, manual code inspection, LLM or static
   analysis tool scan.

 - Whether the issue was actually triggered, or is only theoretical
   (e.g. found by LLM and not proven at runtime). If it was triggered
   please include the symptoms, like the stack trace or kernel messages.

Please do not repost the series just to address the above. Instead,
reply to this email with the missing information, so that reviewers
can take it into account.

*IMPORTANT*: If you do repost (for other reasons) - please include
the relevant info in the cover letter or commit messages.
-- 
The evaluation is done by an LLM so it may be wrong, if you think
that is the case please reply and explain.
