Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EA584EE870
	for <linux-security-module@vger.kernel.org>; Tue, 13 Oct 2026 16:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791910593; cv=none; b=LfAiN82yBflVFATb3lzf8QsNiTlOUbo8vBRw5do0UQp/G7G2GIxqjlpTdkA3s1pA7BgzwJN68M+Tm0bJlPSrhmm9jlO0EIJcJ0rRI48KtFsIDHARK5thzqNd9vspf+h1qJxvDWwTxSEqvhbUVS3DjUfxm0+j6vFwh6Xfe2yCu8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791910593; c=relaxed/simple;
	bh=sIzcSDsL8jlsJOiZiTFD11JfN3y0qiAsVwgNY0Pv67Y=;
	h=Message-ID:From:Subject:Cc:In-Reply-To:References:Content-Type:
	 Date; b=RxehcaF0oeJ8/+zXPR68tJpUfg0j8UoCOGuBlBT1Cac+D1g3FCmm5R3UxdeC3QdSc4XqJz5+hkYCci6rw4seACD4hpS8HXZMQP/gg0ixnF4bT/tAi3hskbxlRN5b1uxX5WTCUHG6EyjrEyktCdn9F0HVnrmU4ZCYoyCyWTGEqWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UxJ9qRyg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UxJ9qRyg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABF6E1F000FF
	for <linux-security-module@vger.kernel.org>; Tue, 13 Oct 2026 16:56:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791910591;
	bh=sIzcSDsL8jlsJOiZiTFD11JfN3y0qiAsVwgNY0Pv67Y=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=UxJ9qRygFafWdL0hcRusI0OTPaMZAfSx23HTNG4bMOyV55HqT6HPfWlvcE3Cwbb0p
	 gPyhBlplDiJ2WYxxPZfTzDScFJxz3R5qWwrLH0LW3Vavxx2RFSYBsIKSoTNQQZnhP2
	 soaoKKS+Jkj92ERw/ndHcAwxb31cysewFsJCoGfvUyGWWbu4pGWJj9SZIbWyMYGYfN
	 UL3SeGIKVI8HR5+G+j2rMrSmZtZhod2OOYaZfm/svFyxUmKvD1CaqBUrPSwStaeP4j
	 wEo0hrHUqOKkgDkjtkTOF8HwPVPO6JoSd5UliZ7/fDwNlEPxxWOA4aWPj/G3GlB6hi
	 m2y2gYnOrH0uQ==
Message-ID: <sashiko-outbox-170176@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v1 06/11] selftests/bpf: exercise the path
 ancestor iterator
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20261013164800.2906577-7-utilityemal77@gmail.com>
References: <20261013164800.2906577-1-utilityemal77@gmail.com>
 <20261013164800.2906577-7-utilityemal77@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 13 Oct 2026 16:56:31 +0000
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>

> Walk the ancestry of a mkdir's parent directory from a sleepable LSM
> program and check that the iteration reaches the root: the temporary
> directory, its parent and / are visited, no position comes back
> flagged, and the flags read back after the loop show it ended at the
> root rather than on a failed allocation.
>=20
> Hold the first position across the rest of the walk and resolve its
> pathname only once the loop is done and the iterator destroyed: the
> acquired reference, not the walk's, is then all that keeps the
> position alive.
>=20
> Signed-off-by: Justin Suess <utilityemal77@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261013164800.2906=
577-1-utilityemal77@gmail.com?part=3D6

