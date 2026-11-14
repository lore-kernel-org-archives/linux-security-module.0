Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794675229;
	b=C7STdXA23/hrkHLB+YM6y90A+/VkmZ6hbH+0RaZVc+3cxYviw9ZMjeUmMSXnIV+GfIhR
	 +oymLqG3EHAKhy1OLKYhtZQC4fe7dJmvPI6tb4S+fvYqPWZbLy4HELNKLHhVgg82eUU/6
	 WtBiQpw4GXcqOi2kMX9XhFUXDCNo4uP1TQy2v/2OLh4jk7FphEqAVlZNDKHBObUcSk9SJ
	 AW06W9hacbPsVj8HGXifN/sgqRC6XQRHergMvIMfK3icZMmrCQLHsg7hX1VJfoaUoWbO4
	 uFHGXp1ebH55oF2z4YelDagTZuByp9OSYgriRmsyhkqPSCuinBch7ZVVKut6EEcqD4g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794675229;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=Yc4OBxUipu8W97catUYnfLaU2/9RndlwZAZp558Riq8=;
	b=IilA/WooC8PXWUY/bWUt+H4DfyeTjiJDaUbQSEl+WWkCxc1dbpTSJHHH0QHvzOjLjh1V
	 XrjfuJx5oR46Qw8sV5oxGVfO4G+J7LoiXht2FtHZfcNNn4TLiDQBQ1+E6WHPEQoAjmEjS
	 pEf3AWDV9F8KH9yIeYiMt2ts1lRzKDpBhp84v7m8D1H0jnkjjxkTKWe9QaJbeFs0puVDB
	 HFeNo7MZp19fDwZUvTxMcRafkU0nc1CwOnco12IparYPis6Q+zMwByvbWqzmjpQccfUn1
	 2Chju+FGdQzXcO08MbRfsImw47SDWB3FG+bGSDgZyp1PuYH7P/ofsr0PwpzxwMJ0eLQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RMZ4r0iB;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B42FC606A327
	for <linux-security-module@vger.kernel.org>; Sat, 14 Nov 2026 16:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RMZ4r0iB
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49FDC1F000C4
	for <linux-security-module@vger.kernel.org>; Sat, 14 Nov 2026 16:53:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794675229;
	bh=Yc4OBxUipu8W97catUYnfLaU2/9RndlwZAZp558Riq8=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=RMZ4r0iByKag40Ka22UekyQV9UmlOB2bT4D2YcXjLaGbUB6Sqa4DNKvsl6UKeHrA1
	 cZ/UEBAj013wtUoUOVHhXguIu0NhqbHjiBjMdlfRPq/uhEn305v1eGrMm/TWF7re7S
	 xpLmbF0dshdI0abv0Ktqj0vFmVjvkgnY5J7oW+BAWRnFEWWRluUqjCp/JIpwpJfKL7
	 fV2bnsfF7bopWjTW7R/wvj/Q2z94ABxNUGmwKInEJFI6D6AK/wdwXJMeX894+TSXTp
	 6u24EWwNBR3M8jYP6IXEJQUut89j6zKI/+FVuK/z1mna/iAVh9GWLjBMQaqX/Sh04s
	 Ey1ZfPthbtZ9g==
Message-ID: <sashiko-outbox-214790@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v12 2/6] s390/cert_store: Return an owned reference from
 find_cs_keyring()
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20261114164139.429814-3-jarkko@kernel.org>
References: <20261114164139.429814-1-jarkko@kernel.org>
 <20261114164139.429814-3-jarkko@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 14 Nov 2026 16:53:48 +0000
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list

> Return an owned reference from find_cs_keyring() so that it will not get
> dropped.
>=20
> Cc: David Howells <dhowells@redhat.com>
> Cc: stable@vger.kernel.org # v6.6+
> Fixes: 8cf57d7217c3 ("s390: add support for user-defined certificates")
> Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261114164139.4298=
14-1-jarkko@kernel.org?part=3D2

