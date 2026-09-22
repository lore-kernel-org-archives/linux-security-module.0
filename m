Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6CDC53FD57
	for <linux-security-module@vger.kernel.org>; Tue, 22 Sep 2026 14:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790089059; cv=none; b=VXkVWO9L7pSZzoxsGenMAg3qGKjaXs/6sOYZmjogwIQWYalj9g7RyxD7CF4MYJetpNHs/f+i7vxmftGU7Zs+gN8dIILXWYDNW/riu48iu/cgFLn87x8L3InOjALcCuVUltPfw8VFt88gmdvwUhoicIKs/6mUKQyfAoRKXy2B268=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790089059; c=relaxed/simple;
	bh=YAZqFbfvYrwUGv5o46ezxZZqQh8k53c1ixB64zQVbAo=;
	h=From:Subject:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=DAuXohCVR8AQV9U1YWog30G0cw2h9TjImCHotqjMwbsPHeGjFaPvmxTYIrux8gdWLXINtZ7wA4tK+b4ai545sPrFPH1ILHDwsAehoq8efNHCyWF3cC62/THboD72dROxaLv5M6bVF4muGN0BRGLyoc9rd2Bz4HiY+SQFhIJSu+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A+gtnPmu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A+gtnPmu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A2AE1F000FF
	for <linux-security-module@vger.kernel.org>; Tue, 22 Sep 2026 14:57:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790089056;
	bh=YAZqFbfvYrwUGv5o46ezxZZqQh8k53c1ixB64zQVbAo=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=A+gtnPmu69FhA13yNrg/xWt3tD+50E6LMowI0dFBO3akxruHllGa9PyrwVETkFUmw
	 7j8aYN1Bosxcb3h/eyP1bmcXhMv3dfRRX/n2yER3tAgI7Mn3wbFgzysSX8SFSsVz3P
	 LIQ8ZAhe5mCqaxd6ifgW2E2T1NtG9eXCuFxMOz5YvwrU/H4wnytwJxGYP8lqNdROwl
	 Pix3/W7088HDWI9o/PYmWx6XX2Jq9aqyWYkdUSGaJ4kOq/1Z1kHpbxCks5DWZLjGVc
	 BQfbkNk6bIGA+k8/pnUs7Ilnfym5GV6d1gjhCUUN9Alh8MiwvlsMvb3WkxRkwwptcM
	 jkhjjWO36P2hw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] smackfs: fix IPv6 netlabel prefix mask for
 non-16-aligned lengths
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <A82C90B4956EE3A9+20260922144738.9594-1-daihongjian@kylinsec.com.cn>
References: <A82C90B4956EE3A9+20260922144738.9594-1-daihongjian@kylinsec.com.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 22 Sep 2026 14:57:36 +0000
Message-Id: <20260922145736.6A2AE1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>

> smk_write_net6addr() builds the partial-word mask as (1 << m) - 1,
> which keeps the low m bits instead of the high m bits (e.g. /33
> yields 0x0001 instead of 0x8000), and stores it without htons()
> while the address words are in network byte order. Any prefix with
> mask % 16 !=3D 0 is truncated to the wrong network and mislabeled.
>=20
> Take the high m bits and convert to network byte order, matching
> how newname words are stored with htons().
>=20
> Fixes: 21abb1ec414c ("Smack: IPv6 host labeling")

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/A82C90B4956EE3A9+20=
260922144738.9594-1-daihongjian@kylinsec.com.cn?part=3D1

