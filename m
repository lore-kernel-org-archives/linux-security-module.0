Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.127.231.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793537482;
	b=ZuuUEPFtTME8i6+V1a0teN8m1YWpdUK5CgXMp8a09hAijnuaM2xgboesT+RasINlYL65
	 FzEs4NDoQ68GojAlRSBUYGyWGWytifmL5vQ/msGK4XFaBIWmT/bvK+MbcWwx8JKQ3PMPd
	 uNTgHQ1DgBqLKf8TRDroLfBKXbHvnKMrNaiZME8hyV62v5k3Xfu347D/kq5N8tOIJkV9Y
	 U72klhYfifKnG6VfIWySI0S/t0PfYaSp85l+Qi6NmL7vcRyCaXYIkwGa1szJ5+aGT0HkG
	 tbTYzowD/8LZ6tBWW0espY1ZjzDNnRabf0Rx2hf1mms7acthkedPrdAOwcj52VvubiQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793537482;
	h=DMARC-Filter:DKIM-Signature:From:Message-Id:Content-Type:
	 X-Lms-Return-Path:Date:Mime-Version:Received:To:Subject:
	 X-Original-From:Cc:In-Reply-To:References:X-Mailer:
	 Content-Transfer-Encoding;
	bh=bTf75aymh5jBl9eu/8t3zOznHSc9aBSs8jDGsG1P1tY=;
	b=lBxiXOwxYkJdXGkze39PzjIYRpsOIhyu/F41Jzgr4ijwKyzlTYfMSq9ll4CwMdzgzyON
	 ShANkLep06l2/22Zfb/dX5zYNMfblGkQYVF7YjaN+Z460RxYsmNl/rsLp8EYWr1Y0TAxC
	 ojKd1GpmzQ3bmWriymwP9a1DvwY4wc10fULEiJGO+IMIF4/5t6k6dTKyI9n0pEkbsMQ+A
	 bsS6t+UJ3a/kySq7l4GZrVPm+OhiInZXpsmYW13O5YVyYVwIVDkBnkerGGsWi6vyggQcv
	 YDC6kLZ9veyi7G6EdJSEgBWtfUtet0J/InryZMCNkOnT4LgFC/FIEyScyQ8S6//wTEw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=dw1.io;
	spf=pass smtp.mailfrom=dw1.io;
	dkim=pass header.d=dw1.io header.i=@dw1.io header.a=rsa-sha256 header.s=lark2403231520 header.b=sdU6Q6pT;
	arc=none smtp.remote-ip=209.127.231.45
Received: from va-2-45.ptr.blmpb.com (va-2-45.ptr.blmpb.com [209.127.231.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFA93606A324
	for <linux-security-module@vger.kernel.org>; Sun,  1 Nov 2026 12:51:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DFA93606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dw1.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dw1.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=dw1.io header.i=@dw1.io header.a=rsa-sha256 header.s=lark2403231520 header.b=sdU6Q6pT
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=lark2403231520; d=dw1.io; t=1793537477; h=from:subject:mime-version:
 from:date:message-id:subject:to:cc:reply-to:content-type:mime-version:
 in-reply-to:message-id;
 bh=bTf75aymh5jBl9eu/8t3zOznHSc9aBSs8jDGsG1P1tY=;
 b=sdU6Q6pTGdFUiNvz8IAK8o+7wxAQnpL+weLfM5dx470v01aoKYvx6t70phjo3GEa+LQdB+
 J0in4GLb+O7zD3Zpc/tes5MlBsbrEu7kGe0hlxTXlrLoF78+g2MOtzIxOstI0igjeAtgYN
 FyadbUTvfzrkLgatCN+wSN/0LbcQe0Ohg6ENFX43yJhiPPHMZM5BAO1tu+n1UdKA84p1xJ
 6Lo42L+PBnHbNWv0ekumgAh6Q3SMuNTNL2wBYJRXXtdhjBPQrqdYQrZjv9/2WTQOUCApCG
 CVhtcLF3EpvjNg5P0hbgvYS8726UYpzw69zPiMSLMx4zB48SOjjUqVUjK227zQ==
From: "Dwi Siswanto" <me@dw1.io>
Message-Id: <20261101125114.19009-1-me@dw1.io>
Content-Type: text/plain; charset=UTF-8
X-Lms-Return-Path: <lba+26ae735c4+e72af5+vger.kernel.org+me@dw1.io>
Date: Sun,  1 Nov 2026 19:47:50 +0700
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
Received: from dwis-macbook-pro.tail904ed7.ts.net ([168.107.87.239]) by smtp.larksuite.com with ESMTPS; Sun, 01 Nov 2026 12:51:16 +0000
To: =?utf-8?q?G=C3=BCnther_Noack?= <gnoack3000@gmail.com>
Subject: Re: [PATCH 1/3] landlock: Fix layer composition of LANDLOCK_ACCESS_FS_REFER
X-Original-From: Dwi Siswanto <me@dw1.io>
Cc: =?utf-8?q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>, 
	=?utf-8?q?G=C3=BCnther_Noack?= <gnoack@google.com>, 
	<linux-security-module@vger.kernel.org>, <stable@vger.kernel.org>, 
	"Paul Moore" <paul@paul-moore.com>, "James Morris" <jmorris@namei.org>, 
	"Serge E. Hallyn" <serge@hallyn.com>, 
	"Konstantin Meskhidze" <konstantin.meskhidze@huawei.com>, 
	<linux-kernel@vger.kernel.org>
In-Reply-To: <20261030102411.12985-2-gnoack3000@gmail.com>
References: <20261030102411.12985-1-gnoack3000@gmail.com> <20261030102411.12985-2-gnoack3000@gmail.com>
X-Mailer: git-send-email 2.50.1
Content-Transfer-Encoding: 7bit

I saw the docs still describe the old one. include/uapi/linux/landlock.h
says:

   * For historical reasons, the %LANDLOCK_ACCESS_FS_REFER right is always denied
   * by default, even when its bit is not set in @handled_access_fs.

and, for LANDLOCK_ACCESS_FS_REFER itself:

   *   This is the only access right which is denied by default by any ruleset,
   *   even if the right is not specified as handled at ruleset creation time.

So ruleset that handles no filesystem access right never denies
LANDLOCK_ACCESS_FS_REFER -- alone or layered.

Also, the comment above _LANDLOCK_ACCESS_FS_INITIALLY_DENIED in access.h
has the same problem:

   * All access rights that are denied by default whether they are handled or not
   * by a ruleset/layer.  This must be ORed with all domain->handled_masks[]
   * entries when we need to get the absolute handled access masks, see
   * landlock_upgrade_handled_access_masks().

After this patch, the mask only applies to layers that handle filesystem
access, and after patch 3, nothing ORs it in at read time. *Someone* who
follows the comment could bring the bug back.

> +	access_mask_t handled = domain->handled_masks[layer_level].fs;
> +
> +	/*
> +	 * Handles all initially denied by default access rights, but only for
> +	 * layers handling filesystem accesses.
> +	 */
> +	if (handled)
> +		handled |= _LANDLOCK_ACCESS_FS_INITIALLY_DENIED;
> +
> +	return handled;

nit: I believe landlock_upgrade_handled_access_masks() already has the
same "only if fs is non-zero" rule, so this could be

	return landlock_upgrade_handled_access_masks(
		domain->handled_masks[layer_level]).fs;

Which keep the rule in one place. It matters little if patch 3 goes in
on top, and 6.12 doesn't have the helper. What do you think?

Best!
Dwi
