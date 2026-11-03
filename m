Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793692483;
	b=Rzj+qu5sMz52bG7M7Nbu+bI7yq6T7kK9lv6Ms9Edj3z4rVaH3/4eSh7Q/4qwjOpyWtr8
	 qQqZcv7prvD457QGp5xd4xZEuRPWVwiegx6PHe/LaOUGa8EDRcpqC3rf4Bm8bVStmHuly
	 r4nautK9HjEbtTldDPmrN/PsxrdFje6pgPt/f3O1sFrGeJktZdlTmbUyscO4oixB1tsPV
	 kYqTFIOGuARM75buw0zdhyHrryTm/euKD2TWn3iUAe/cJ0EBxxpKBisyB62zgR+LbLP+m
	 hOVkiGl1IjVRZQAgtgrsioenPxdhU4MCBk7Tbd/lSkoBfooGsET1Zsg0qYT5jd5gFbQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793692483;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=CILNshkuFy5oVbdbIZGZNaROSMs1IcJRWvqpLFmCrio=;
	b=DwW81PRmuf2ACovLS5UsyfPP+Kbr0C6e+U2XPjLsI33q0nAFwlZSj6r3R2TV2PhTSiL1
	 /JbwWZpvAu1nSoGnVXnZ6cD3R/sR1JMM3jVM5r7r6gyu0OKfPUXZFiCgf2Kw0D70fJUh9
	 iCrpR9tMVLG7oQ29tNsqqhDfUCzqld8QSpstpxmV1txKsOHcx44wnZyaDCGI5CIkOwW18
	 3N9hS9J8yQtN3vlcp+VRoL95S0G+w/rnKhfmX+d1KT3hEOHdnWvnTDip7b7wDeTWThjc8
	 mE+eGKpc+wA9XVuDqSGrt115do3YtqVXXPHF1H/OxJvh8aX/a96un/q64AJkxJZMiTQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XediSRNY;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3855606A32E
	for <linux-security-module@vger.kernel.org>; Tue,  3 Nov 2026 07:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XediSRNY
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 525551F00A15
	for <linux-security-module@vger.kernel.org>; Tue,  3 Nov 2026 07:54:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793692482;
	bh=CILNshkuFy5oVbdbIZGZNaROSMs1IcJRWvqpLFmCrio=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=XediSRNYnYtMkAEi8NxnJ+jvCfzUi0jQSojtXSEohRNeBkml0GbEa93X23OYaL3hC
	 semRtS7mqeO4ocbO2ejwH2TVIKZb+a3UwGuwzIjy9CltJO2uXeIqfDl88foqHLq6jP
	 yofRqgOILEqb/2vCXqv0G/BuXgpzbgyQHJ9PV6x0RhNe1NZFeKM+ZVFhx+PMBGN/VX
	 KnPcrF7TDBUB9+8g9aacoT+NCpUTXPaJSpzHhxi1BTVmXXCYV/SpkS+vPs1xv+7sSt
	 OmFPbBRjXIZQkWbNqClGLpF+55+8KrnNFLyTiWfanUbSaZxw41JSDYX7mzz+FTzIXf
	 PlNARtJpnYFnA==
Message-ID: <sashiko-outbox-194763@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH -next 2/9] lockdown: remove useless decrement operation
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20261103082421.3033195-3-caixinchen1@huawei.com>
References: <20261103082421.3033195-1-caixinchen1@huawei.com>
 <20261103082421.3033195-3-caixinchen1@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 03 Nov 2026 07:54:41 +0000
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list

> From: Kalevi Kolttonen <kalevi@kolttonen.fi>
>=20
> Signed-off-by: Kalevi Kolttonen <kalevi@kolttonen.fi>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261103082421.3033=
195-1-caixinchen1@huawei.com?part=3D2

