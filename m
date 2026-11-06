Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=27.86.113.3
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793980423;
	b=OilH2kJIL5dkuXjwdDSd9XlEz2B1Kv8Aj2bKDV+B6L2RSyVQR0/cN/ZKsvttaMW416Sa
	 JIvawg9VWPTsyPh/WzepV9B+v2yNUQnijfkJzncTFoOTkjo1+qo8h6gfChhQtnxoXJR1e
	 InjNe75wiS4yKxPtHKQWiZiiNv/mUgbAlWPhJ4IAIPfIXKEoV/ltSjJoSaU6wY0aCBk3H
	 q71Sfh8cR91IoUqLjt3CBksvr4cRcQ5qlkTWydlY2SA9cK2ulS4OxHjt06NZ2eiRlOR7q
	 sMOcw1M5DZGUSytliCjpDp1dbkHUMzFSjZJmo52Hdx1uytEDgwqfQwz3zvVXc7DQJNA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793980423;
	h=DMARC-Filter:Received:Message-ID:Subject:From:To:Cc:Date:In-Reply-To:
	 References:Content-Type:Content-Transfer-Encoding:User-Agent:
	 MIME-Version:X-Biglobe-Sender:DKIM-Signature;
	bh=2jHbuvgW8nH066FrG4kTNAIBlxTI2un3aWLAJ9ET1mE=;
	b=oLDtKiYFbQX5uxLdIySH7wTWh2sV7zd2DRk1sLbaxrD6guYEqxxI4gtQIsp8nqSRMIbi
	 IpLPO5SFSfYOQ6bOVWCXtl71Pm+eAPKVyZ4duuAb1xJvQZsnazAfkLnDp/iHa/Jw1BtDM
	 ZUO8TrKeUTlMEC9BymvAUZqWAqYoQFIoFY9MJS2Q40VaXjbJ7+aCOhIE4fHQb8Au5d0SV
	 gzg7YA/UQxI0DQaeM6Is0o5SutWTXPOFS+iQe2g0P3a3awQAX4wctqpgsbfcLGn7Exu3Q
	 lRbgEGBm78MssYErXn7JeWenViR5QMEsUnOzbiJNaA5rASWduUwqrEAzU1iHOl77pNg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=kjb.biglobe.ne.jp;
	spf=pass smtp.mailfrom=kjb.biglobe.ne.jp;
	dkim=pass header.d=kjb.biglobe.ne.jp header.i=@kjb.biglobe.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=VELl0OFT;
	arc=none smtp.remote-ip=27.86.113.3
Received: from mta-snd-e03.biglobe.ne.jp (mta-snd-e03.biglobe.ne.jp [27.86.113.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5BD7606A326
	for <linux-security-module@vger.kernel.org>; Fri,  6 Nov 2026 15:53:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D5BD7606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kjb.biglobe.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kjb.biglobe.ne.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kjb.biglobe.ne.jp header.i=@kjb.biglobe.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=VELl0OFT
Received: from mail.biglobe.ne.jp by mta-snd-e03.biglobe.ne.jp with ESMTP
          id <20261106155330629.QFFY.5266.mail.biglobe.ne.jp@biglobe.ne.jp>;
          Sat, 7 Nov 2026 00:53:30 +0900
Message-ID: <5b6397fc76e820118f20edebe9dc454e1a8ac620.camel@kjb.biglobe.ne.jp>
Subject: Re: [RFC idea] Kernel API Firewall (kaf): subsystem-level attack
 surface reduction for the post-AI-CVE era
From: Nakashima Seiichi <s-nakashima@kjb.biglobe.ne.jp>
To: Paul Moore <paul@paul-moore.com>
Cc: kernel-hardening@lists.openwall.com, keescook@kernel.org,
 mic@digikod.net,  linux-security-module@vger.kernel.org
Date: Sat, 07 Nov 2026 00:53:30 +0900
In-Reply-To: <CAHC9VhTB-obhgEM3g0VagzNaRUaF_tWTDu1FmX7SHeVU4pwfOA@mail.gmail.com>
References: 
	<ca90b945049ac3c27f3e1d9b8181137feb892436.camel@kjb.biglobe.ne.jp>
	 <CAHC9VhTB-obhgEM3g0VagzNaRUaF_tWTDu1FmX7SHeVU4pwfOA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3-0ubuntu1.1 
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-Biglobe-Sender: s-nakashima@kjb.biglobe.ne.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kjb.biglobe.ne.jp; s=default-1th84yt82rvi; t=1793980410;
 bh=2jHbuvgW8nH066FrG4kTNAIBlxTI2un3aWLAJ9ET1mE=;
 h=Subject:From:To:Cc:Date:In-Reply-To:References;
 b=VELl0OFTsYtYF/egyF3+HXVNOlsjYeVmOIzOisCfJ5fpMw0CYkjTVr2a4xuulCxllgWvOf5/
 ZYCVyh7W5Aqk2T9oe/qzso3LMB6lz9QwH1gZK01ITb1HnxxL54eyBb06zlJXF1N9VLsV5h8Z4F
 BXMc3MBGpmoCMyilJ9NggxMYPwdELchbOt0OPHQkdNRKRpfkfgaF1ky2wgGzNfQXeDh6nIQJKh
 rMO6/V/XPtWMAOZYVNZ8W7u3uX45DUdQdEDuduSMhnXb5toyADkKR6Vg7NbhvA7ZLiHTc6ckuI
 7Draf3ETu+MiCULQdolTQZzbQ7R9S/0TjQIEevTwjhJyWfVA==


>=20
> It should be possible to do most, if not all, of these things with an
> LSM.=C2=A0 Wearing my SELinux hat, I can say that SELinux currently
> provides access controls for most of these things today.=C2=A0 I would
> expect similar capabilities with the BPF LSM, although I can't speak
> to the coverage of any specific BPF LSM tools.=C2=A0 I believe AppArmor
> and
> Smack cover some of these things, but I can't say for certain.
>=20

Thank you very much. I have a poor understanding of existing features
like SELinux and AppArmor, and I don't know how to handle them well.=C2=A0

I believe that if there is a mechanism to discard problematic APIs when
called, we can temporarily address them until the fix is complete. I
just thought it might help reduce the workload.
