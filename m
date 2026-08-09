Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B64A37C0FE;
	Sun,  9 Aug 2026 16:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786291285; cv=none; b=IYfJfiSI9Sa3YTsd4gbDLs7erdfcmklJN9sEKEM5g4JlyLANsY9siHeHcawwMwaXWaJh3aXMAbb3yAIgF4LHd2gac6SlBVn80Ft1Ad7Xh+A1ZIf5Q++iNMSDSW6JgPZQFjFjJ6905i93Ol28BrNo9onj3Fx8kVGK2SgcutDoxSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786291285; c=relaxed/simple;
	bh=y9PuyInHs1ZmWJ+ndtQP1M3TkDI+wQCbGaG935XnimY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=miG5Gx8FYuNLEtCslmdm1tmPxqio0oKHb+KssNu8AMS0dKE4mAPX6kmglUNBb3jkTvkkXjsymbB6yt4B3m9KtvZWPS61tMmKdn7kzrszMk7D0d6OJVrkHcuMWTb6iCGJV7fheMnm4HTz1xse330BT7HeDhhC/uSN6v68M9mFgbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org; spf=pass smtp.mailfrom=maowtm.org; dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b=jPKggyNn; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=VLI13i5K; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=maowtm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b="jPKggyNn";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="VLI13i5K"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 510FF1400017;
	Sun,  9 Aug 2026 12:01:23 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Sun, 09 Aug 2026 12:01:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maowtm.org; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1786291283;
	 x=1786377683; bh=gI169Ew51hDQp77w2mLv8XPPjlIjh95sIZVZoGLyi24=; b=
	jPKggyNn+21qNHrTNoElcZ/zx3FPcXwUTlY1fVtbI7R20gT8HR9HRBpqqQ7H5UKz
	ttgWid/JWOVsNDKUUK+FKeWl1ddg/4UCxRbIDkGTjX1Ud3M5p0cN5/BCW4KrGe6c
	Vom893/VbfwQvitmbIFtarQKidiqRWq3F6ECUZP7luG48KdsRSjcm+9nK75nfzIW
	C4lMEElTbzfCpzUaXIpIEaV8fEw0/sLa8y/qBvccMLK1vp2TClf6C4JQA54gAD9j
	H1r25jdbtbZWNQ6BHFHd+6lqTsORv4gkPYvpgezoOPeLqGGf52VFL6tE3HXSB6N4
	OfZJA2Kx/OobDAz3O4X+wg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1786291283; x=
	1786377683; bh=gI169Ew51hDQp77w2mLv8XPPjlIjh95sIZVZoGLyi24=; b=V
	LI13i5K9d+pih78xa7QuVaolzN4KZBT4sNqp4KXfulN9cRghljPGHdx5WOevdv01
	tgTJz0J/FvlhKJALz/6xymqeoCiWbCnKJ9eiveWv4+QScE/Q70ro4EKzmJogUGcx
	0CMxGLc8qg/4mvIPdFA8VQFZCoEPQ5TC9Pl/pH40XVi7tABdMsAUixfYXk/9aIuS
	iyF2G+TWZqud/OtSDYZA8Clgv8H2zcpI2WwCzRf2r7tIn0S65Dfi6chvUiMKaWX8
	0kY/P6IkjkVOWOwkZxbkc0LyqYpm/hOSaw2NF27TN/nVOOE0fY2Znpld/3odr5zS
	0ik8+gcjIRzoxl+XwifiQ==
X-ME-Sender: <xms:U6R4ajhYS1dSok5v9IT3-gQsNz22euZpekGWazjyWhAA0qhhUFIlbQ>
    <xme:U6R4ao8588PWie64Vf6qIR8PQuGEj5ChL-5Z5Fqy4bMk2YwjuQ25lqUsYt33h2Pn4
    _94_t3pIUwEZBeMAjaOoJJz9TgpBZPIzzCJzWjsRadL5Dm2CtnsvMN7>
X-ME-Received: <xmr:U6R4aupDU1xPuTwBMZ81XuaYOL_pdBLjHjCnzBb2HcQzVuKsGzFUFnCrn41q_l29PfHZXFYyQEHrhuyNrQ>
X-ME-Proxy-Cause: dmFkZTFa3DN2qVho5/wT4S8BRzzMbXRjgH845UwluuNdkme+DqzdjYp1xuHCZlUTbNKDq/
    LkDtP9RSUiTNmUqDVBTV2gFUzKOS8TGXfAJ+zEUT/TXN6Qzcuj8snPZMYmqAph74NFFnBj
    /thO9szMfA97fnC5COM1dwJTmSYa4N6tK0adMsy3MLIyyacmNL3yv9Kzku+KwzK698INtn
    gN40RH1417QYneKZvTgMyVOfujmgon2wRlokPpzyIV/WJvBdAyd5BwITMr5H1I4dH6iYk0
    3misY9Z2fIaU2Krz60rIEkChQUf62hnTIsZBk6vHTXTvyHlIu6frsc0Yimi9oK3OdrUceE
    nvjm7OpqPM7BolEMTd8OFLOt48xr0WJXX9IjJKmYXlKuVQ1JHFkGeOtkfVRRzaZuabF7sO
    uWB6fSFzaly9SUZcgXZ4EL1QUxQotqveT+fHc2TS15QnjUffPHg/BOpgcFMgF7BN+zqgYG
    JHnNA8OT+4xt+AnqyHhq9ToFR/rP2kjudyUEmVMbeNYe7SdcwdsqSA1QFOgM2GKzVRPOPn
    xvS0DtAr0OdVDOFVAAyWFN49/1BOo8YL3hZ3jIESbUc5TVtxKpp+nB2ypOJ621wklXdVjC
    bHDexq65bTjGdtQi3dVyoxGV/Npc69zI3sDi9qKbswPWEn05Dvw1RNnWR83Q
X-ME-Proxy: <xmx:U6R4agVooZ1Imwz5CDGIEkemAmvcBlc8jcCL3KKtkBhpJuNK-Misng>
    <xmx:U6R4atAijaSXcRxTjdxLoLdRf6YeT092LSJyi6jmyyuKgd51YYYvaA>
    <xmx:U6R4ak0iDDmYfdqnG5IaTTduedagSZQBp40WRST2XcEXkz9Ke-LK9A>
    <xmx:U6R4av2XbfxYI4DdVRAObaE3Fl1PEQ3f3BiWfTOvQqaAMi19AdNwfg>
    <xmx:U6R4akCODKObNTcxPP-YlUSfe1MbEMrpK4NjR2icTDMvHf79-jsRL4QM>
Feedback-ID: i580e4893:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 9 Aug 2026 12:01:22 -0400 (EDT)
Message-ID: <24fa748c-c94d-41ee-83c7-65005ff1b447@maowtm.org>
Date: Sun, 9 Aug 2026 17:01:22 +0100
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 05/12] landlock: Wrap per-layer access masks in struct
 layer_config
To: =?UTF-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
Cc: kernel-team@cloudflare.com, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
References: <20260726161400.3010511-1-mic@digikod.net>
 <20260726161400.3010511-6-mic@digikod.net>
Content-Language: en-US
From: Tingmao Wang <m@maowtm.org>
In-Reply-To: <20260726161400.3010511-6-mic@digikod.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Reviewed-by: Tingmao Wang <m@maowtm.org>

On 7/26/26 17:13, Mickaël Salaün wrote:
> [...]
> @@ -61,6 +61,20 @@ union access_masks_all {
>  static_assert(sizeof(typeof_member(union access_masks_all, masks)) ==
>  	      sizeof(typeof_member(union access_masks_all, all)));
>  
> +/**
> + * struct layer_config - Per-layer access configuration
> + *
> + * Wraps the per-layer handled-access bitfields.  This is the element type of
> + * the &struct landlock_ruleset.layers FAM.
> + */
> +struct layer_config {

This will be nice to have for the supervise stuff.

> +	/**
> +	 * @handled: Bitmask of access rights handled (i.e. restricted) by this
> +	 * layer.
> +	 */
> +	struct access_masks handled;
> +};
> +
>  /**
>   * struct layer_mask - The access rights and rule flags for a layer.
>   *
