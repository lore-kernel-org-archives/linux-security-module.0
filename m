Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793664213;
	b=GCo2ZN25U0uKmE+RbdLYYmIaIK+62YRbVu6IxBET9pMPnsPpFTTqUQVY4I8/dTXEUl/O
	 pSOOSX2hsrnBU1bcTClC5dl6qxNa9mi9q2eKX0zOfuSyYk+2gyHMu6av9vsnBH6cHUiqt
	 JJYJGPTiYp/YJQGplTAZ3agZHq8+vGEczWmJqwAw7uf3GPbp+7Lv68HjrIv60p1+cZ6Hl
	 i5FLNDyAoPXnVgV1+9jcgUgwl8gw+R118HAG4u40JMskOG3zkxxR8Z1A9QFpunec/A5sF
	 FXuXjdbfX6ydyQ1/0EmUldwGvqd+riX2TamW7fyvzTTVxtWjDF2sMgFDD4HvoUk4egw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793664213;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=BD1RvPKIf9rUpyjEApgOeisHNSkvfoQ38KrFVqOeEz0=;
	b=X8CkmSrtZHGq/Uop023kKjj8YXQpD7p4ef5t2PrmzmhRtB7jCCfjRcMp5ktpBRDB5kcj
	 l7d+OX0RLULwLfbfOLKffzvynucthKipkfiI6jtduw/zNiUpu3moVY2pc3w6Mk3Ki9fWB
	 2vOUWtXHlTQJyV98hsOtO18SSMa0EUN5R2fFQ55TdutG4Dhaqvcp/l+wxnX2MktWrpdZD
	 T79OXl6HerLl77kJH7MRoQ0p7n0mCmWCBCy1muIla6HJ0NmOna1A8R8vvnp3r4cOwkINE
	 E5vj5dP5RQLb0CfFZP1xpkygClHxFfijt3spNYXiStvgAoLwtkBcgt4ixPpvxEvqczw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NaJhEO8s;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id 702D8606A324;
	Tue,  3 Nov 2026 00:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NaJhEO8s
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 7AB361F000C1;
	Tue,  3 Nov 2026 00:03:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793664213;
	bh=BD1RvPKIf9rUpyjEApgOeisHNSkvfoQ38KrFVqOeEz0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=NaJhEO8seab6bdKcM30Mc2vRIWR90O17lM865rTRZV6EQDyL98ryMcqy6bL8O1lo9
	 fxyLaZAs8znnL2R5LgbGKNQDum5NodPmONoYN8q7ykMlDBuCnFQqZ14wwZYArgwwrn
	 kqDmu6krszrFw5RBGpV6+8BiGE2JDe5etT5BtVD/DZ1dRMhD+jkLQsiuxGNYS6iMC3
	 F7CX9EZpeiAgRbClu1RAOVAblrmnoswcM4BZfzRrHm9HEWQpyy5ErqRgrQ/ARPv2tI
	 UkO87m2uARHg4O9kweeaIjsyAwaTJRxi793KOC1i7h4c0TGE0lKmspptGwbM/mT75d
	 TwPQOG+KWoi4w==
Date: Tue, 3 Nov 2026 02:03:29 +0200
From: Jarkko Sakkinen <jarkko@kernel.org>
To: David Howells <dhowells@redhat.com>
Cc: Eric Biggers <ebiggers@kernel.org>, linux-integrity@vger.kernel.org,
	Mimi Zohar <zohar@linux.ibm.com>,
	Roberto Sassu <roberto.sassu@huawei.com>,
	Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
	Eric Snowberg <eric.snowberg@oracle.com>,
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	"open list:SECURITY SUBSYSTEM" <linux-security-module@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH 0/4] KEYS: sanitize the garbage collector behavior
Message-ID: <aukk0VsRnXY9o-kF@kernel.org>
References: <20261102121518.1197453-1-jarkko@kernel.org>
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261102121518.1197453-1-jarkko@kernel.org>

On Mon, Nov 02, 2026 at 02:15:11PM +0200, Jarkko Sakkinen wrote:
> 1. Remove key_type_dead and replace it with the regular module semantics.
> 2. Replace variable size workqueue items with fixed-size 64 key chunks.
> 
> The first change has user space visible effect: rmmod semantics will change
> from always succeeding into returning -EBUSY when keys or restrictions have
> the LKM pinned.
> 
> Jarkko Sakkinen (4):
>   KEYS: trusted: Disable sysfs bind attributes for TEE driver
>   KEYS: Pin the backing module for struct key_type
>   KEYS: Remove key_type_dead
>   KEYS: key_garbage_collector(): process in chunks

This turned into patch set consisting of 10 kernel patches. It will
take a bit to get them out as I'm still polishing them.

I thought that it would hard to project beforhand all the possible
corner cases so I made the first version a probe version, so that
Sashiko would expose them at plain sight.

Doing this was definitely worth it, as it would have been almost
impossible get this exactly right in a single shot.

Br, Jarkko


