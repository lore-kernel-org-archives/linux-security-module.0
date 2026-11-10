Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794295912;
	b=cdkInyR42T0EkWH8+pMYWC61t9pRo3WBsNuWCL8hwk6pJBGlu0P6a9e2RAvi8bc5kYio
	 keSoSZGLTVOJzonPDmf/FVzLTiGn7HwlfJfs9bksv9g0ZxCq3uxAdH0SFhbkIqMR4N1W+
	 vjEJpQcHpmhv7YN60ENVVsjYsx7zwEd2fD680Ko0mEZpf/sl3JIzZ98iqRhPPoImcjgBq
	 hEDh7w2b+Hv3l7mxg8cCHTyQ4+CLr/nfG4rUMZPrrTAHK2ro6pt93O+APAMVTqh6Y/rVM
	 9MOUHyudtZECF/3xY4OcAVZVR5hboY4oxFFPIrf+2lB/ks3JtJdas/22CZ0//YnSc0A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794295912;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=qUzT3MyGpLgUGdLFHYjJ3jYd1QrOsZqFHdnlEHP1MJw=;
	b=cwxfbaN0lbvJagmKCc9BPj2cLufqgfeRs5NuGyA/RUwXDGZ1cVcWXwb9+1JHzx0E5eOl
	 mRnC9IF07Pl74fu9egliwzpl9kYFubA1WyQ2cF7TOYGCqKobIqcvPCEYaQYhLKLN5f9d5
	 IwXbDjsKK7T/+ApqmL3gD0lCrJdRzj0s9rnKNabWzwl/RF/lNZUDWj4Zj5DfbsU2mz9cL
	 jx2L6He7QVv101lCdT5UNONSCDPHIcHXg2Kbt8nCEWJ7b0+pdvnOtCqtI4AuEsga0RYI7
	 /6cpN32e0RIYHsMD3cRhjysuN6ykTPVPnt97XQxv9d0n3VbNUBmD6+1vCjOcxOoOloQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZwdlB+eJ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD3AF606A333
	for <linux-security-module@vger.kernel.org>; Tue, 10 Nov 2026 07:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZwdlB+eJ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F1F91F008A6
	for <linux-security-module@vger.kernel.org>; Tue, 10 Nov 2026 07:31:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794295911;
	bh=qUzT3MyGpLgUGdLFHYjJ3jYd1QrOsZqFHdnlEHP1MJw=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=ZwdlB+eJEtQM1N9jE62Jezh4J8hj+6XUqIn14si8jaTVJjeDiCViPBdv6GryvqZub
	 WJHFvMpczXLm0U2UhVwXEFiM4pzwoXYZ/ufkA8QYbgaasuuZiMoQklbmKuRkN28v8j
	 6W/vo+Q8ganqbHGPDrHHOGgBhpXTxt7+/Z2y47WDHf23345VdIqfLXz4Xv+u582qPF
	 l25219jxOWJymfTdFldRuB6IbIOFfsqU5UwmrYLdMPj1GncZWTDX4ab/HxfB8UrSgS
	 vOOIbnDfMKOL+hTDdK2Ada5uNGhfG8LFu/T7Mny3SxrHq2vKp9lqGBxRNhurbWyfWH
	 XiUQue99fhW0A==
Message-ID: <sashiko-outbox-206497@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3] ima: fix races when deleting measurement list
 entries
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20261110071909.2056650-1-liuwb@xiaopeng.com>
References: <20261110071909.2056650-1-liuwb@xiaopeng.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 10 Nov 2026 07:31:50 +0000
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list

> Without this patch, ima_queue_delete_partial() looks up the queue entry
> at which the measurement list has to be cut without holding
> ima_extend_list_mutex, and only takes the mutex afterwards for
> __list_cut_position().  The comment above the cut justifies this with
> "ima_fs.c enforces single-writer exclusion".
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261110071909.2056=
650-1-liuwb@xiaopeng.com?part=3D1

