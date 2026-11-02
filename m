Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793631071;
	b=RVD9jW2FP4J2HKzIJ3Sx6Lb4Kp42NRyHABECwlbj+43qrqn7WdhW5viF6qyzupfTtbH8
	 ujDDpwmZouQsDRGIJOqPhnNoxXLCas4ojx8kK8knk8ZXOKkSONym71crvpBI+r82wg85R
	 v+JZmKH58rcsNMJfp8DZGdaswqXPnX2EzCUpYpaaxqRT25G9PD8kCmuhyzxP7C41sLrKi
	 v204oqIN1bMO2qQuQ4QA45VUym515EwJbrX7auxv+UKx/yQdu4xKnh67ZCULXTX0ObFks
	 osnLvrJ+etEWi64zPbMDZLgt+gEY2DSBSF+ammo304BL+t49YHpEzJz+VzxKlk4r6Cg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793631071;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=Swuy955ElCUbws09OLNZf62LuuvsWEbc5ayAX8MWujU=;
	b=cXDaChUobf/3Fi4UK0ckbBJXuGVke0jwJhCrkKw40L3CmKoaVqVtEZKtgvQf8u5CvjiS
	 U+pattBECkLVx/rQtkJqHXnpz4vOyESe0c6vglH88h2cqREBzZsLkE1tlNBdW+aGFB+Cm
	 XeQwHQfbk5CHWh3ETADgPZcSoDMwUpYiHxwscVfZZPkZWc4lyORrRVnVMOMkht3WkDtRA
	 k1qqHrK+Kh6Y3ppM5fvPZ1otzUaSEG4Sf/7EHW0uaWCrp1RV7lQxEYic04IINznajFAwX
	 CPbx0u6sV74QU+fLwR5kd7FjLBT1BLxGCbEKqDSodUZJTkzWkFq1vzb9LKDH8BUSnTA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eFlYpD+n;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E806D606B1DE
	for <linux-security-module@vger.kernel.org>; Mon,  2 Nov 2026 14:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eFlYpD+n
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A77841F00A18
	for <linux-security-module@vger.kernel.org>; Mon,  2 Nov 2026 14:51:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793631070;
	bh=Swuy955ElCUbws09OLNZf62LuuvsWEbc5ayAX8MWujU=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=eFlYpD+n5bzrxdYlnzctOGr32ST77y+uR4POQgeW501xYQT3AgkyNj1rXJjmbWyyG
	 aVZ/YOVL4qks99VP2QnFg+ydP95h/7Cv5IwgKucTpc98juYroyY+9K5IOAqO1nqD72
	 CH46AOQDMOZxmoy00ixp/+Ka6BtlW+3ko0nqqcf5Jwl3eBqRmtq35zzOL/ZUtC4+Fc
	 la9pu49qHOmYKkY+/fExW2s+9+qIqLiKgo8EYXR7nlpivj5L7uu6MsU1SjqB+vFOEl
	 TaoZiRG/Ih5rEYdiAccEF0PZq/YxmL0g52+XY0aDB7J250GDvk0Dv9ULdnHzj4yb3r
	 IAlmrjnj8k/Ew==
Message-ID: <sashiko-outbox-193609@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/4] ipc: Move MQUEUE_MAGIC to a shared header
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20261102144708.920232-2-webprosto@gmail.com>
References: <20261102144708.920232-1-webprosto@gmail.com>
 <20261102144708.920232-2-webprosto@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 02 Nov 2026 14:51:10 +0000
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list

> Move MQUEUE_MAGIC from ipc/mqueue.c to include/linux/ipc_namespace.h so
> it can be shared by code outside of ipc/mqueue.c without duplicating
> the constant.
>=20
> Signed-off-by: Oxana Kharitonova <webprosto@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261102144708.9202=
32-1-webprosto@gmail.com?part=3D1

