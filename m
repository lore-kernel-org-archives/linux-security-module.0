Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793692472;
	b=MERQf/16C2C04XHmlRDpnG/hEXF8GXDROm6C93/ewCixMP6hfJm8/UMk3zCWZgMg+xcs
	 bSabFOa+24jW+y2bCPnfdZNRCzcyuja/4i+MLkjpa6AjcM3bKatBTQm6Pqnm0Lw5yDPVm
	 uIm/4C/mrT8feQ1dGsL7RPXhf1tujQ7IxzxoegqPkcMfrzxMWLaB0lVHeje4eoS8Qmiy6
	 emZ767FJL3Jp0UlCNnRg97EiNSoKBqnIvF9twPCSjdANpRMdu9jpiJhDGoQZUXHgjpExO
	 5fGtm7bwOqxBrmrPJ6b6pjBz1uvXTWGbtc9VHkLv4sQshcy6W3xmj5RQdbWnkmRDiLA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793692472;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=AEe56zIITXj7fxZCOfJwuul5chWjtvojabkIbAG0vZ0=;
	b=EatuWVYbYfCzCl1Pt7p2cL483rqtDNvA5WOk9aJ0z+QeD27EDeopbH9PHFOkcg3koNB/
	 L1N0ACGUFu5/aYfxMxLo784kVB6/GaOlv9STa+l3pA3EjAlrDRICqeJL2Lg7U2MCxU5MX
	 nFfJ5d+dIHJB8BGcLbvO6M6+aQKOdhkF4HcwXq5WpcNXAtxzFjOGX2KXUP1I8MUbVch1X
	 n3V0bdUMSV2MXwt5fLLTicuWBc1VlmuQ/1VdoBoI3vzO7Qa2LopTsv3pHB29CSpH2mooJ
	 0pi/K2arv4L+mnCILdum13BKPe0hOi6DBBL5gX0dIKhl6zKsZOKCRCk10ujQnJsyZgg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=E6hK9TYH;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA6A8606A33A
	for <linux-security-module@vger.kernel.org>; Tue,  3 Nov 2026 07:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=E6hK9TYH
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA3A51F00919
	for <linux-security-module@vger.kernel.org>; Tue,  3 Nov 2026 07:54:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793692471;
	bh=AEe56zIITXj7fxZCOfJwuul5chWjtvojabkIbAG0vZ0=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=E6hK9TYHepaw7CsWNtkRGrf+b9Pmb1rjgZOgBoW5YQnKHwXoFdul7AMlOhpcXUtYC
	 ysWFW+nmIOTTANxRUWG7b5DkznpX7Q7mqfDCw2dVvLmOilRhjnQV86k5W7hgqeYQXc
	 G4c8Oajk0kE31JOcjCbXbg90L2gqaPiU59uGv62/Xt3h1jdpMoxHDsjl1E5Ince8YO
	 zemGy7GBg2wKXd7qKB18vUpTh87C7ZCQTKx64e9CwfdrKxIQOxEOw0epcELCt1ZdsL
	 BIg2pveJ7ODbGvwDcukMeYvJiRONMphW7YLmmJRnqhnehDy5GY2Yrc4iA2cVlnKYv3
	 PSYz0J5AXUk7Q==
Message-ID: <sashiko-outbox-194762@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH -next 1/9] lockdown: Add break in lockdown_write
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20261103082421.3033195-2-caixinchen1@huawei.com>
References: <20261103082421.3033195-1-caixinchen1@huawei.com>
 <20261103082421.3033195-2-caixinchen1@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 03 Nov 2026 07:54:31 +0000
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list

> After the label is matched successful, any other levels judgements
> are meaningless. Therefore, add break to return early
>=20
> Signed-off-by: Cai Xinchen <caixinchen1@huawei.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261103082421.3033=
195-1-caixinchen1@huawei.com?part=3D1

