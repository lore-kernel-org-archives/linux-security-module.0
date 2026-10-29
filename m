Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793292579;
	b=TDmiUXGbm10CcSrH5aZNwp+559n4t3rUnJepBxqOLrUwE3LsvNoB+UGiWeGJjOojFopj
	 JY4GggVpjfOq0wV4FSrTE4QnrwF5bJVwEWG78WDzLw81AaFv4G6F3fpzdmTMtyHZGlrYs
	 RUTckMehEDdTDE3rXYcQxB2blOCd6X2PHUWjKVS5wo1yI39U271zyVZHpsvh8l0E4E65d
	 OwA5W1XUF5sUf+mTimaOGA4bDUmo5uMqi0vTUjoM5SvEQ4tdM4ZHstJPWIUHsFiswwE6Z
	 brMfP5LlgDvsKXAEpX4UzbvnVw+i3tmajHnpSO1iYMU5IBa+DG7XBVNwriyd9zuwBvg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793292579;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=4hkrpsJOtpoHDkQwBMB9FCY1st3Lb3QGTbmdto/ps1U=;
	b=Xuy0aENU+MGSpM4Z0M2q1qTyCUM/G9hzKu7Rq1PaskyIYBf0lJF/tkOHNXw86MnYdljw
	 RrI0SxqawfhM+jwOF8GAEYUalqhZnCjfrq/6AYE7JFpoH2oWmF9UJ+FNtRVkb3hFnNvOZ
	 h8gGYwzUvjb6eq6kkKZVS40aafBLTjdLUZ0+ncl7AFMj7CLs/0TWXkDPOtlU4O5vg7h0L
	 /80yLygU8XsZ+zy04IeIkv9ZJ3GJ2vh3n01nzMvxZbpTT2pn/nrjbW0G8C2AvNenz9AGM
	 BfLnNhMdJ1QCX1vQ3ogO8GOl41yNLYW3YZT0piG+EtRWV+a4jmnoXWxBoAZ/Z08TLLg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gvyzzJFt;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B28EF606A31A
	for <linux-security-module@vger.kernel.org>; Thu, 29 Oct 2026 16:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gvyzzJFt
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 708101F01816
	for <linux-security-module@vger.kernel.org>; Thu, 29 Oct 2026 16:49:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793292578;
	bh=4hkrpsJOtpoHDkQwBMB9FCY1st3Lb3QGTbmdto/ps1U=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=gvyzzJFtK9Bmc6pb5a02J5Tti+mJ/Qj0VRirr/L5TQeqiLrpMWJmwCNHmO/iZvBNh
	 elrlFywpGoA+wxz9H8ChHMOVHbjUMIF0l2Zx/RmlT89aHapt54w955ruH0WYt0syu/
	 Tk+W9IdfJBp/fhQG6paO7bKWzN8mp7FuBuWJxBvtDGkE5GirgXv3oI4lyY0dgAGe58
	 8o+uuEt2qPv/zrTNVC4hS8+MrZNgSRkLNpT1mzRUxaG/TN04DkDJNBJjH7TbngxGa8
	 ZHKuEM2LtuSuPXgHrXmn0Ngl9ufACWzUYIyeXC1Ucc2OBKRM3B91YgyEdvFDKpr2+d
	 HRHUsPl6ltWsg==
Message-ID: <sashiko-outbox-189681@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 5/7] nstree: drop ns_tree_add_raw()
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20261029-work-security-namespace_free-v2-5-65591dbba7b3@kernel.org>
References: <20261029-work-security-namespace_free-v2-0-65591dbba7b3@kernel.org>
 <20261029-work-security-namespace_free-v2-5-65591dbba7b3@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 29 Oct 2026 16:49:38 +0000
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list

> Now that ns_tree_add() doesn't allocate an id anymore it does the same
> thing as ns_tree_add_raw(). Switch the remaining ns_tree_add_raw() users
> over to ns_tree_add() and drop it. Rename __ns_tree_add_raw() to
> __ns_tree_add() while at it.
>=20
> No functional changes.
>=20
> Fixes: f675d2e95569 ("lsm: add LSM blob and hooks for namespaces")
> Cc: <stable@kernel.org> # mainline only
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261029-work-secur=
ity-namespace_free-v2-0-65591dbba7b3@kernel.org?part=3D5

