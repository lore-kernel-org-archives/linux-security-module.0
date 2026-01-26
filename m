Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F98F2206AC
	for <linux-security-module@vger.kernel.org>; Mon, 26 Jan 2026 22:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769467319; cv=pass; b=f+5N6+pfPqkbjFKjd28UNgx+G/p8Ivu7PbTtT9Q3Woo3wluKvjA1y8dBp5mB8kmvVRJ+5YpR0vQiIQ0kAPTAeEWEbuVtRrISrXQctR1Ee6BgiYEWqC7BbdTvFYpsruvTOipG1QSglc0y/JKolSuAmHGtcYmldf1Gw1EGaDat5/Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769467319; c=relaxed/simple;
	bh=Q3G4ARwrh5Qce1UUq5S3zP0x4wInYa/dVEYHDQCXtfU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Lf0yGIK221qkQhYv7T/A/Ucaghj7reJt1HKKlcmcdpUvhqu2UUdlQgMrWZ7tqrD2Vng+/lmkxoepDz2y/ZdU8QoQDkhssrEjweXs2PDUE2K8IpGw4WZs8ymDszDm1XT9kjkSigRLlJpdYN82eTbnLNbXyQOeO1Yb10yBFvlkOqw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=HdKejOaw; arc=pass smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="HdKejOaw"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-352c414bbbeso4091414a91.0
        for <linux-security-module@vger.kernel.org>; Mon, 26 Jan 2026 14:41:58 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769467317; cv=none;
        d=google.com; s=arc-20240605;
        b=W2kXgBSF8JwKZEndl5NRiXLnTWdU+Miq2sJArW4V5n5p49dIT2xZV6gO0UsHNw2kXc
         YUwmvwMazZH8uR+TaWI/xG2jp01BaZ6ass50WPqrSXHFqYEcr0J6nYiNViTmbjROQ+oG
         fGl7dm3q6i6p99e6PX4qZd8bvGQY2U02x13RQiznb2TXKGCCfqzaYEFQAQOcnzXP42Rw
         w0zEXadtTMVt0dvhd1uWIwgm85zSHA0QEyw9RsFgZ9g3NlxrJY3V45AmJeUSmmEf290U
         4eodUL8YE8dI6v+fpjpxkgLxwxetlRPp+dtuOuOrjOq4HUKa/2FYfvH/iGInLzRqDdfw
         4r/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=X7jnwBcO9kfWrOClkw45F/yzW2eGiLRsPFFOYC93unk=;
        fh=4a3YQIOqMsCGtGsbq2pGAGk77MUOOE3rGOQ9tgqOWys=;
        b=dXxY8OkwYw06bGhpo//J4QJuwb5M5EErPLiWc5JYzctdwvF4XBctK38WTCL8yceM9h
         69/bOI1aOAeTTYFimbPAsBai+uP62IgVPhWD+AErBdxaLprY4px8VzCL74it0eYOEvv0
         0o32jC0lwwxky1uuwGhbyQ185h9Ti2KvCK1d+jvIvm4p4Vt0Ht2N9Ja9yJMRcpzOKlcy
         CQwng0jd1fMYecMkkUmxVQjSoUs0UEAX5141uAvokiKB4yrsEx+757w1V5iYznt8DjDk
         /kxQK5Yzrq7hIVS1qPA+GTDPuYz8mWLD7o2HPLWqS/EtPnUTDQF73OOwzi5H9gNjsXtY
         EvDA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1769467317; x=1770072117; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X7jnwBcO9kfWrOClkw45F/yzW2eGiLRsPFFOYC93unk=;
        b=HdKejOawXQz3LplRfJtM5nFR/KK20vbUZauCUkj2rPWboQGv5B1JNpzwD/74fNjam0
         aNpvleslja1QE2ju57WXKFpFg/I8rqTnyqc0kK0jimCsz5e5QdWC2xzIn3zpcbAd2nvx
         UxL1WkU+Wl3XiTrE/0GxhsWuHXSvsGXpp7fo0LAuR2TlDJgPXfj3tYVuo4nMk9xOd1v1
         p/4M6rYSs6mgL5CwLx4UJm2Ls0VEMBzWmAXxcC1pQ6jkO2DMtoMLoUYz9g1quv8RlT4V
         ohFQOaDKVPB+Es9seG6HB8JHkFuKyCk8b4t+eUKcBLW7qeYYRJB19pr1nWVsKU0w3GH+
         0LuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769467317; x=1770072117;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=X7jnwBcO9kfWrOClkw45F/yzW2eGiLRsPFFOYC93unk=;
        b=CLmPZQ5w0qZ20d101tSx/AVYp0NvLIMeGbQcOSh7acsesSCZIQKMM2veH3ofRQZ8Wx
         /2GBHaZvb/peQD7E1T8sYZPzthMtJxyA0kkHXOu0IPrBPTT5Mgb/cS6fxtAiBQAgybU0
         qm12I4FrJYGn0b/FzIi+r1UjzVwBK7bk6pK1//8RbyzpKq5s9rTvIL7ZfnmNjnzq4/2a
         kk7D2yBjz3qZINw/wNlJGWqP3kl8CCs+G/5EtHo83f80hCY1aka0dKxFuScJftD2Nzdk
         moxI53SIl9SLcemJVLFca25c7F9vtHKd69LkQXaKhUeMaWtXwR2+2Vw54zGtvAnB54XD
         qBNg==
X-Forwarded-Encrypted: i=1; AJvYcCWdPwR6EwFCKwkwr6ZALphpEPjW1JRYp6dex6XpORVjpDch2coFFJkQNGHSsmxCTQkBJ3vE8233RxdE2wyEOeV4wyYfdsc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLYi/aymQfwS+M0yKrS9sx2a9sgxQ9R9y2+hqWdMZ5aNKqEpxq
	9+2UmlMW/FhEyIgX4hIxMYPKryt/lOXfIxHWDMT0sbu3mzDjtCm4c13fmkE+y057Kz11cAtl+RZ
	sr8n9PXyX6KJBJRLYTZbk9bRdAXnptrUfv+YcWcqA
X-Gm-Gg: AZuq6aLwon/6hD20BKaxFf4y1gLJTfr/TFgdNzBowX8J65GjDf7ZrUNk/jP+bicT4dE
	reioiqCajD+kbN0yYjQJ8Aq/C+jlFYPE9XFns9WhdAf4PAP0CetTQGjEDgPBMP+O/fQByVpgcjM
	syJe7WbZ8gH0+rssqw/wwXt5tS2B/Gao7zjIHJ/q0DbrogF884xDj8/AvsEMCL2K5Kbkm4I/z22
	cFuxQWBvI1fB3kfRZ+jClGm5/ve3Ep5T2JC/+1OP76qrF+TkpXMAaJYy48xGOwBjtgSRuw=
X-Received: by 2002:a17:90b:3b4a:b0:343:3898:e7c7 with SMTP id
 98e67ed59e1d1-353c4625b54mr4450699a91.12.1769467317586; Mon, 26 Jan 2026
 14:41:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <924f9cf5-599a-48f0-b1e3-94cd971965b0@I-love.SAKURA.ne.jp>
 <537343f7-c580-43b0-9ad2-691701b9fb8e@I-love.SAKURA.ne.jp>
 <287edf7f-85fb-46c3-9c70-c8ec7014a0db@I-love.SAKURA.ne.jp> <aXIGxmCB2QU86-iA@secunet.com>
In-Reply-To: <aXIGxmCB2QU86-iA@secunet.com>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 26 Jan 2026 17:41:46 -0500
X-Gm-Features: AZwV_QgYmUrGPybMCCDRtzN_TKJkWDkwDRu5nDZr9abvGoEUZ-CUdGucaUzu1nA
Message-ID: <CAHC9VhQ54LRD7k_x6tUju2kPVBEHcdgBh46_hBN8btG0vhfy_w@mail.gmail.com>
Subject: Re: [PATCH] xfrm: force flush upon NETDEV_UNREGISTER event
To: Steffen Klassert <steffen.klassert@secunet.com>
Cc: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>, 
	Aviad Yehezkel <aviadye@mellnaox.com>, Aviv Heller <avivh@mellanox.com>, 
	Boris Pismenny <borisp@mellanox.com>, "David S. Miller" <davem@davemloft.net>, 
	Florian Westphal <fw@strlen.de>, Guy Shapiro <guysh@mellanox.com>, Ilan Tayari <ilant@mellanox.com>, 
	Kristian Evensen <kristian.evensen@gmail.com>, Leon Romanovsky <leon@kernel.org>, 
	Leon Romanovsky <leonro@nvidia.com>, Raed Salem <raeds@mellanox.com>, Raed Salem <raeds@nvidia.com>, 
	Saeed Mahameed <saeedm@mellanox.com>, Yossi Kuperman <yossiku@mellanox.com>, 
	Network Development <netdev@vger.kernel.org>, 
	linux-security-module <linux-security-module@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 22, 2026 at 7:00=E2=80=AFAM Steffen Klassert
<steffen.klassert@secunet.com> wrote:
> On Thu, Jan 22, 2026 at 05:24:22PM +0900, Tetsuo Handa wrote:

...

> > Therefore, I wonder what are security_xfrm_state_delete() and security_=
xfrm_policy_delete()
> > for. Can I kill xfrm_dev_state_flush_secctx_check() and xfrm_dev_policy=
_flush_secctx_check() ?
>
> This might violate a LSM policy then.

Exactly.  SELinux is currently the only LSM that enforces any access
controls on the XFRM/IPsec code, but it does use both of these LSM
hooks to authorize deletion of SPD/SA objects.

--=20
paul-moore.com
