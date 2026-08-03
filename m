Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5FFC381E91;
	Mon,  3 Aug 2026 23:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785800003; cv=none; b=MyxfyhRSzOkcbibjjPHNikEfzv+Nc3Qe4ZJVkvhg0PT7fBwCauyVLxmCXFG0Gt2V6c42QdLInweE+jeg5aHsZHz6VzBEDsMIzSpx4WrIcIJNsMPt2yw9fSuoQ6isP7uRdwi/iVYsUCoSHIAXsHIz9OWdiujIohztdsGFwCr5nXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785800003; c=relaxed/simple;
	bh=JAN1h6Csz40PXYt8XaCOmNHIWk3zB5rBu2K7NU/Zt6o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GRYZ18go4fEE8WXQZzs0pUHS2rgfhwA5vyKalys3hA7n3bQ5fhdqWy7+L/W/6m6wGqLDdg+4sU2c7ZkpUb5RUFO/1wPjYL0F2E+lOLRQVmS2lVwr8I9HaxQqzu1z2t4VPRnEVa0dGesHrA/tXldd5jWfHiItgaICaCbGsWo63Qg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XtszbGH8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XtszbGH8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E69A1F00A3A;
	Mon,  3 Aug 2026 23:33:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785800001;
	bh=52HD5zn7Xy3Fi4ssq2rl+OSECk5ABt1cwC/JC+RryXA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=XtszbGH8RGBGUZqH6qoP1mCKKQ0KAVJGEFPEdeT1TjLMi4u/4nDzZKlAVSEzVWBwd
	 prGSnUSyhgqRoOaDfe/7a4/SAFHMwXsIEMLIJ+G5vooDUpccpE0gbAG8B3ffhFsTq4
	 OrdBgx6wI9gPPvnVER4EeSK9mGlhR7xq/HKbnhTGzR0uayfs+gZUyaZ10c/OlSe5LK
	 8b9T4H+PlMpthe46JZmFaGm33mImyZlgc2dOr2pfYSD5j54SVLvbSNeucjuqgTeDDO
	 NEIcGfW+RKflNQ+l/zYoIyEhd4SybJZO8L4QGDKGDKBE13X8a7nTfJTABBiT49DyIq
	 nlmtoBXdvD4ng==
From: Jakub Kicinski <kuba@kernel.org>
To: heminhong@kylinos.cn
Cc: Jakub Kicinski <kuba@kernel.org>,
	paul@paul-moore.com,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	horms@kernel.org,
	netdev@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v2] netlabel: check register_netdevice_notifier() error in netlbl_unlabel_init()
Date: Mon,  3 Aug 2026 16:32:03 -0700
Message-ID: <20260803233202.2330171-2-kuba@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260729090716.138608-1-heminhong@kylinos.cn>
References: <20260729090716.138608-1-heminhong@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

AI says that this can never fail in practice. Please make that clear
in the commit message. Take a look at the other comment too, and if
it's incorrect explain in the commit msg why.
---
This is an AI-generated review of your patch.

netlabel: check register_netdevice_notifier() error in netlbl_unlabel_init()

This makes netlbl_unlabel_init() check the return value of
register_netdevice_notifier() instead of ignoring it, and on failure it
clears the netlbl_unlhsh global, waits for a grace period and frees the
hash table before returning the error.

No Link: tags present in the commit header.

> diff --git a/net/netlabel/netlabel_unlabeled.c b/net/netlabel/netlabel_unlabeled.c
> index 47bae5e48db6c..fe1be424601f6 100644
> --- a/net/netlabel/netlabel_unlabeled.c
> +++ b/net/netlabel/netlabel_unlabeled.c

[ ... ]

> @@ -1419,7 +1420,16 @@ int __init netlbl_unlabel_init(u32 size)
>  	rcu_assign_pointer(netlbl_unlhsh, hsh_tbl);
>  	spin_unlock(&netlbl_unlhsh_lock);
>  
> -	register_netdevice_notifier(&netlbl_unlhsh_netdev_notifier);
> +	err = register_netdevice_notifier(&netlbl_unlhsh_netdev_notifier);
> +	if (err) {

[Severity: Low]
[Finding: main-1-0]
[Sources: opus-5]
Can this branch ever be taken, and can its cleanup ever be observed?

register_netdevice_notifier() in net/core/dev.c only returns the result of
raw_notifier_chain_register() (-EEXIST for an already registered
notifier_block, which cannot happen for the single static
netlbl_unlhsh_netdev_notifier) or an error returned by the per-net
NETDEV_REGISTER replay.  The replay calls
netlbl_unlhsh_netdev_handler(), which always ends with:

net/netlabel/netlabel_unlabeled.c:netlbl_unlhsh_netdev_handler() {
	...
	return NOTIFY_DONE;
}

so the replay cannot fail either.

Even if it did, the sole caller turns the new return value into a
noreturn panic():

net/netlabel/netlabel_kapi.c:netlbl_init() {
	...
	ret_val = netlbl_unlabel_init(NETLBL_UNLHSH_BITSIZE);
	if (ret_val != 0)
		goto init_failure;
	...
init_failure:
	panic("NetLabel: failed to initialize properly (%d)\n", ret_val);
}

which means clearing the global, the synchronize_rcu() wait and both
kfree() calls can never have any observable effect.  The remaining
behaviour change is that a previously ignored condition now reaches
panic() during subsys_initcall, which the changelog does not mention.
Would it be simpler to keep the call unchecked here, or to document the
panic-on-failure behaviour in the changelog?

> +		spin_lock(&netlbl_unlhsh_lock);
> +		rcu_assign_pointer(netlbl_unlhsh, NULL);
> +		spin_unlock(&netlbl_unlhsh_lock);
> +		synchronize_rcu();

[Severity: Low]
[Finding: main-2-2]
[Sources: opus-5]
Is it safe to publish NULL into netlbl_unlhsh here?

Up to now netlbl_unlhsh is assigned exactly once during __init and is
never NULL, and every reader in this file dereferences it without a NULL
check:

net/netlabel/netlabel_unlabeled.c:netlbl_unlhsh_hash() {
	return ifindex & (netlbl_unlhsh_rcu_deref(netlbl_unlhsh)->size - 1);
}

net/netlabel/netlabel_unlabeled.c:netlbl_unlhsh_search_iface() {
	...
	bkt_list = &netlbl_unlhsh_rcu_deref(netlbl_unlhsh)->tbl[bkt];
	...
}

net/netlabel/netlabel_unlabeled.c:netlbl_unlabel_staticlist() {
	...
	for (iter_bkt = skip_bkt;
	     iter_bkt < rcu_dereference(netlbl_unlhsh)->size;
	     iter_bkt++) {
		iter_list = &rcu_dereference(netlbl_unlhsh)->tbl[iter_bkt];
	...
}

netlbl_unlhsh_search_iface() is reached both from the receive path
netlbl_unlabel_getattr() and from netlbl_unlhsh_netdev_handler(), and
the synchronize_rcu() above is a blocking point executed while the
global is already NULL, so the NULL window is not instantaneous.

Nothing oopses today because netlbl_init() panics right away and the
netlabel generic netlink families are only registered later by
netlbl_netlink_init(), so no reader is expected in that window.  If the
panic is ever relaxed into a graceful failure, which is the direction
this patch points at, would every unlabeled lookup and netlink dump then
become a NULL dereference?  Leaving the (empty) table installed on the
failure path would avoid creating the NULL state at all.

> +		kfree(hsh_tbl->tbl);
> +		kfree(hsh_tbl);
> +		return err;
> +	}
>  
>  	return 0;
>  }
-- 
pw-bot: cr
