Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794751690;
	b=gU/fJ05YCDQWk5NqBExkjEI67v+Gpq7F3KMO/4VkV7rdFhUMlSywbUZYFXq46TmzwcxK
	 Ss3E+XjJt5IiihARJqiG7a3KiPbCrBRQNnM+rU5ZJH17+lfPhKJk5BFgboHE35JvI9u5u
	 XR/cMyEJ8BiQw3Q5yu0g10XZyxjYdXBY6M5OuEcO8Th9di5kyE6vSqYUcxgqIZJyUbbVJ
	 rNd9NpfXoiUjA8COX4kyaEY0xzLFo0VkYdJPRsfYNvQ+gDFUJyJQLF8diINE8OjpWD31p
	 uQdLdeSQN7TijkXy/V1EvhJFA3m8HfmGAmUGBDoIhaEoK/jH5a3mNwrHgmd0mAXQEow==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794751690;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=7LcCQ3LkcjlrUv20udQOuJv5IMOnmvGG5DxxMXPTTYo=;
	b=LMJZU+fc9iE+3Pon1c5ZrvqZ9lxNm0lBGk34xJku6YajDHC5feIXtgzYbLjchXGJz5cY
	 bmmTkyB+jkbLgRzqhipma+2o3sPI06qO/fSIVrdpXe+4UqG6pFSGKODSgkLkG2FYv3x57
	 9O9KxdCm2zIeRCjvxgYdsIv+TLG8M6LHafEIe3BMhx5Ry7SD7Uhz/nsusChlydF92qKZd
	 NO5FugZ9NQ40CDije1lPRmAHQtBkgiOKHnFzCf+6AwEl/hvv1l0GD4xvgKKtShgJZgETR
	 z6D1/3KdJAZflACCwU2ciL85MHo1IUhPkFVTx5ERITCtkjOVU1l1/0WqFcH68P7OxGg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aLwNwSJO;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAD5D606A31D
	for <linux-security-module@vger.kernel.org>; Sun, 15 Nov 2026 14:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aLwNwSJO
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51D671F000C4
	for <linux-security-module@vger.kernel.org>; Sun, 15 Nov 2026 14:08:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794751690;
	bh=7LcCQ3LkcjlrUv20udQOuJv5IMOnmvGG5DxxMXPTTYo=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=aLwNwSJOL6AzDW6JqVntYxyIMQgArbyvzGwxmEmOCj/oEylYnfEe0RLZF2OhHwWR2
	 ukVvPfdxBMBo9hRS6/cBNFe2Sdk7GjkJyNOBx3SZKN0JjDaKbw0AyqoLjclsOjJsc7
	 44KeU/Py8CffpVkvDAtiFIFKCECczk8OlHh2HsBlBa6DFZXgp9c8ihqtJ51Kmko988
	 jC9dDZk1THqsAIE2nJ1/tTQ4P4/MtkcSbS2JtsBiq1M6Nn3Gp0DRyX+6ONDxmbD96Z
	 opwDQGY3F4/VM1sD2KzJ2/a4SBpvX9NMAuuvzljsvFrjyfkbVLfXH7IwXVl9HKajeG
	 ospnnTqyQ6puQ==
Message-ID: <sashiko-outbox-215563@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 09/13] bpf: return NULL from bpf_real_data_inode() on
 errors
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20261115-work-ovl-d_real-v1-9-ca155efbcb2e@kernel.org>
References: <20261115-work-ovl-d_real-v1-0-ca155efbcb2e@kernel.org>
 <20261115-work-ovl-d_real-v1-9-ca155efbcb2e@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 15 Nov 2026 14:08:09 +0000
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list

> d_real() is about to be able to fail for D_REAL_DATA. So switch
> bpf_real_data_inode() from d_real_inode() to d_real_data_inode() and
> return NULL if the data can't be resolved.
>=20
> The kfunc is already KF_SLEEPABLE | KF_RET_NULL and its documentation
> says it may return NULL. So programs already have to deal with NULL and
> the verifier enforces that. Note that this is the caller that most
> easily ends up with a file whose data was never looked up.
> lsm.s/file_open runs before ovl_open() and lsm.s/file_receive sees
> O_PATH files passed via SCM_RIGHTS.
>=20
> Spell that out in the documentation.
>=20
> This is a no-op until d_real() can actually fail.
>=20
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261115-work-ovl-d=
_real-v1-0-ca155efbcb2e@kernel.org?part=3D9

