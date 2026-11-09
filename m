Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794228480;
	b=rX7cwnnqbwFbySGABb6E9RuBHegsvd/JfRZDOVmQxIgJZnK9fVb62WB9IBfJALKFZxmm
	 UXuRNZvRBRfvtBOxc9mlWMPqkaQVHGJxebN/h+RXB+X9/gLk+ZQhQeQzjar23TC1410SC
	 huLa8mhosG4LeluK2tY8Td8uI1GAqVrIS1QRh+0LozvLNMVM8CnRYAirg/4npeNPXNhhQ
	 qntrkRZ3b31pky7DEgTS0o31JSzju3HF1SAidP35IWKtpAj9FliLgl+52E9YVHZ7AwA7c
	 Op+7c1k0kkIXd6Q3NU8qz834xJZ370AxvW1Vq3XWGsjS1HMwet4XEzJY5wEQr6jWiKw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794228480;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=DbwRqjrcUqCSFblEC+NHjniT3H02hJb7mL4+dW2A9GM=;
	b=aoMZxoQCJbW0/RkCll1vQXArQHrZbK7/qXL2cwIqQdCOkLqeUSCOgeRKhmJNEZiGqIhJ
	 AcH1B0r//m9FABzo2N0YWm4qRZSJByttcxGvlUOqmglT4Vj/aipWPGgPsL8j5d2vwdg4w
	 C+gOuwYzBJnjBjjeSXamRo8XRf5mflpjoMKIl9FzYoFR7iF7ob+mIDOS0ukjKlCDVZphU
	 F2FD5rDup6dwHgCuJMEdzdwFQ9lv+hRxX4Cy0XMSe91/OV7pZF8eP1ANWCA0D+GDScHi2
	 h+0JbdM7+YczTgEAtZRfDb8wqeriIB3sS0FXJ5jI9FydZgTas4sOslNpLdZW80TdP7w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PSEDHfEo;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E590D606A323
	for <linux-security-module@vger.kernel.org>; Mon,  9 Nov 2026 12:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PSEDHfEo
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 688141F00904
	for <linux-security-module@vger.kernel.org>; Mon,  9 Nov 2026 12:47:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794228479;
	bh=DbwRqjrcUqCSFblEC+NHjniT3H02hJb7mL4+dW2A9GM=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=PSEDHfEo8GF2Iq/Dqt+nglvyTl8dG1RWebDLZH3vOb8rDTuHdol6RdAPmfeaUq/Js
	 tqHXkRsEofLA0vA53VmH2vqjDpLgEVwVxPjgvzXPyrS+bND9aSCE8lkf5g2aa8fN4G
	 cxdf4i9UVJ098v7myT9AYzh7ALYRvZ5TB2EPfHoDFviDZFn21/8EZ6QD2cYaoBCfA8
	 WA8nBPtFjaTieyHYintbd/KcMOheOYXHx0Zoq9hKM2MBvSFw15KDu18SLUew5wAJ9L
	 jqtvUpmciE37aR4VtVqfHfCVNYjBWCqdi/7mjzOCh0siRFbNQwFKCIUJpOH2qby1n/
	 b3k7E5W2hZ5bg==
Message-ID: <sashiko-outbox-204980@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] ima: fix races when deleting measurement list
 entries
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20261109123335.432186-1-liuwb@xiaopeng.com>
References: <20261109123335.432186-1-liuwb@xiaopeng.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 09 Nov 2026 12:47:58 +0000
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list

> ima_queue_delete_partial() looks up the queue entry at which the
> measurement list has to be cut without holding ima_extend_list_mutex,
> and only takes the mutex afterwards for __list_cut_position().  The
> comment above the cut justifies this with "ima_fs.c enforces
> single-writer exclusion".
>=20
> That exclusion only covers cross-process opens.  ima_measure_lock()
> registers measure_writer at open() time and even lets the same task
> open the file again by incrementing measure_writer_extra_writes, while
> _ima_measurements_write() never checks the caller's identity.  A
> privileged task can therefore open several descriptors for the
> measurement list and use them concurrently from its own threads.  Each
> open() creates a separate struct file, so the f_pos_lock taken by
> fdget_pos() serializes neither these writers nor their readers.
>=20
> [ ... ]
>=20
> Suggested-by: Roberto Sassu <roberto.sassu@huawei.com>
> Fixes: fcb0318a2969 ("ima: Support staging and deleting N measurements re=
cords")
> Cc: stable@vger.kernel.org # v7.2+
> Signed-off-by: Weibin Liu <liuwb@xiaopeng.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261109123335.4321=
86-1-liuwb@xiaopeng.com?part=3D1

