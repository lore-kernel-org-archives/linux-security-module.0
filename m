Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11D9936A341
	for <linux-security-module@vger.kernel.org>; Mon, 28 Sep 2026 07:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790580188; cv=none; b=tKzT3YcjiJtj9LtZPeoq4R937IfM1SrWvwbZT0OZR61BlX46lhxUvl8ZDIzwRBVuOYrtD6z5WWZfucfrtsAcDicK1n7CR0p/aH3mysB/q5yyp/boQjkAj2VUqgRjYz4TU4dW5/NDLIV0kzyqaQ+TEgtlVQwgnlh/2AVQRwIh6l4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790580188; c=relaxed/simple;
	bh=gBFNrmYeuFFWstJhiKVViFdxWIDk8/WeRZuPpTo1YTk=;
	h=From:Subject:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=s6YYu1cjeJxhXu4LsiERjdQ+0ByQF1AFVukrt/UPVRGeXlvHk9GxJpphBypf1JXxXQK5nXERSOS6g7WBruivD0I8X++KWXa5DhTekGlhasL2L/5iKE5f3XvBMdrfWOtKcFtcFl+6SnhxJzthxR3Hz2VVXPatuEE/QktjMziIsYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P6Oj/B4e; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P6Oj/B4e"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8686A1F000FF
	for <linux-security-module@vger.kernel.org>; Mon, 28 Sep 2026 07:23:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790580186;
	bh=gBFNrmYeuFFWstJhiKVViFdxWIDk8/WeRZuPpTo1YTk=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=P6Oj/B4eoTeyOCC98wWCUFmH19cFFNGRaFM+sB/NeegtPhOXNcmkD9QSgxtJBUFQA
	 MW137T0eHK0Ex0v9mHJEXbytWf12wxjU+BW4hroHaVQPb1XLpoCZpYOO/aaklrFjNI
	 KFIlGS+BCNKMr3oDEH1JwGnennuKA4zCvu7Bst0aH3F2zQx1ucUFEoKaDPwSAT94Fh
	 u4PivnLl1UV5NFO4uMdlkoWRxJx/a6qzTIhniG4ydHT43cGjb3Xi2LveKA69RjlLYi
	 w/oHeDYydT3GJGoAvm+igV+/bktlddY7GUPZ1vdma8kANcQZR+e2DEXhb8X6orodWa
	 enS0DQ1zbXoEg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] security: keys: Fix comment of
 search_process_keyrings_rcu()
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20260928072024.91664-1-thuth@redhat.com>
References: <20260928072024.91664-1-thuth@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 28 Sep 2026 07:23:06 +0000
Message-Id: <20260928072306.8686A1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>

> search_my_process_keyrings() has been renamed to search_cred_keyrings_rcu=
()
> in commit e59428f721ee ("keys: Move the RCU locks outwards from the keyri=
ng
> search functions"), but one spot has been missed in a comment.
>=20
> Signed-off-by: Thomas Huth <thuth@redhat.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260928072024.9166=
4-1-thuth@redhat.com?part=3D1

